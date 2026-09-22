-- ==========================================================
-- PHASE 4 SECURITY HARDENING & CERTIFICATE ISSUANCE RPC
-- Internship Management Platform (Azerbaijan)
-- ==========================================================

-- 1. Secure search_path on existing system and trigger functions
-- This resolves PostgreSQL mutable search_path / privilege escalation warnings
ALTER FUNCTION public.handle_updated_at() SET search_path = public, pg_temp;
ALTER FUNCTION public.is_admin() SET search_path = public, pg_temp;
ALTER FUNCTION public.protect_profile_role() SET search_path = public, pg_temp;
ALTER FUNCTION public.handle_new_user() SET search_path = public, pg_temp;


-- 2. Secure Function: Automatic Enrollment Completion when all required tasks are approved
CREATE OR REPLACE FUNCTION public.check_and_complete_enrollment(p_enrollment_id UUID)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  v_enrollment RECORD;
  v_total_required INTEGER;
  v_approved_required INTEGER;
  v_updated RECORD;
BEGIN
  -- Verify enrollment exists
  SELECT id, internship_id, student_id, status
  INTO v_enrollment
  FROM public.enrollments
  WHERE id = p_enrollment_id;

  IF NOT FOUND THEN
    RETURN jsonb_build_object('success', false, 'error', 'Enrollment not found');
  END IF;

  -- If already completed, nothing to do
  IF v_enrollment.status = 'completed' THEN
    RETURN jsonb_build_object('success', true, 'already_completed', true);
  END IF;

  -- Count total published required tasks for this internship
  SELECT COUNT(*)
  INTO v_total_required
  FROM public.internship_tasks
  WHERE internship_id = v_enrollment.internship_id
    AND is_required = true
    AND status = 'published';

  -- If there are no required tasks defined, do not auto-complete without admin action
  IF v_total_required = 0 THEN
    RETURN jsonb_build_object('success', true, 'completed', false, 'reason', 'No required tasks');
  END IF;

  -- Count student's approved submissions for those required tasks
  SELECT COUNT(DISTINCT ts.task_id)
  INTO v_approved_required
  FROM public.task_submissions ts
  JOIN public.internship_tasks it ON ts.task_id = it.id
  WHERE ts.enrollment_id = p_enrollment_id
    AND it.internship_id = v_enrollment.internship_id
    AND it.is_required = true
    AND it.status = 'published'
    AND ts.status = 'approved';

  -- If all required tasks are approved, mark enrollment as completed
  IF v_approved_required >= v_total_required THEN
    UPDATE public.enrollments
    SET status = 'completed',
        completed_at = COALESCE(completed_at, NOW()),
        updated_at = NOW()
    WHERE id = p_enrollment_id
    RETURNING * INTO v_updated;

    RETURN jsonb_build_object(
      'success', true,
      'completed', true,
      'enrollment_id', v_updated.id,
      'completed_at', v_updated.completed_at
    );
  END IF;

  RETURN jsonb_build_object(
    'success', true,
    'completed', false,
    'required_total', v_total_required,
    'approved_total', v_approved_required
  );
END;
$$;

REVOKE ALL ON FUNCTION public.check_and_complete_enrollment(UUID) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.check_and_complete_enrollment(UUID) TO authenticated;


-- 3. Secure Function: Issue Certificate (Atomic & Server-Authoritative)
-- Validates:
-- 1) Admin caller
-- 2) Enrollment exists and status = 'completed'
-- 3) Enrollment matches requested student_id and internship_id
-- 4) Approved certificate payment exists for same student/internship/enrollment
-- 5) Single source of truth for Certificate ID (e.g. AZ-INT-YYYY-XXXX)
-- 6) Prevents duplicate certificate generation
CREATE OR REPLACE FUNCTION public.issue_certificate_secure(
  p_enrollment_id UUID,
  p_student_id UUID,
  p_internship_id UUID,
  p_student_name TEXT,
  p_internship_title TEXT,
  p_certificate_file_path TEXT
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  v_enrollment RECORD;
  v_payment RECORD;
  v_existing_cert RECORD;
  v_cert_id TEXT;
  v_created_cert RECORD;
  v_year TEXT;
  v_rand_part TEXT;
BEGIN
  -- 1. Authorization: Only platform admins can issue certificates
  IF NOT public.is_admin() THEN
    RAISE EXCEPTION 'Unauthorized: Only platform administrators can issue certificates.';
  END IF;

  -- 2. Input Validation
  IF p_student_name IS NULL OR TRIM(p_student_name) = '' THEN
    RAISE EXCEPTION 'Student name is required.';
  END IF;

  IF p_internship_title IS NULL OR TRIM(p_internship_title) = '' THEN
    RAISE EXCEPTION 'Internship title is required.';
  END IF;

  IF p_certificate_file_path IS NULL OR TRIM(p_certificate_file_path) = '' THEN
    RAISE EXCEPTION 'Certificate file path is required.';
  END IF;

  -- 3. Enrollment Validation: Must exist and have status = 'completed'
  SELECT id, student_id, internship_id, status
  INTO v_enrollment
  FROM public.enrollments
  WHERE id = p_enrollment_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Enrollment not found.';
  END IF;

  IF v_enrollment.status != 'completed' THEN
    RAISE EXCEPTION 'Enrollment is not completed. Current status: %', v_enrollment.status;
  END IF;

  -- 4. Verify enrollment matches student and internship
  IF v_enrollment.student_id != p_student_id THEN
    RAISE EXCEPTION 'Student ID mismatch with enrollment.';
  END IF;

  IF v_enrollment.internship_id != p_internship_id THEN
    RAISE EXCEPTION 'Internship ID mismatch with enrollment.';
  END IF;

  -- 5. Payment Validation: Must have an approved payment record
  SELECT id, status, amount, currency
  INTO v_payment
  FROM public.certificate_payments
  WHERE enrollment_id = p_enrollment_id
    AND student_id = p_student_id
    AND internship_id = p_internship_id
    AND status = 'approved'
  ORDER BY created_at DESC
  LIMIT 1;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Sertifikat yalnız təsdiqlənmiş ödənişdən sonra verilə bilər (Approved payment required).';
  END IF;

  -- 6. Check if certificate already exists for this enrollment (prevent duplicates)
  SELECT id, certificate_id, status
  INTO v_existing_cert
  FROM public.certificates
  WHERE enrollment_id = p_enrollment_id;

  IF FOUND THEN
    -- Update existing certificate with new PDF / updated titles while preserving certificate_id
    UPDATE public.certificates
    SET student_name = TRIM(p_student_name),
        internship_title = TRIM(p_internship_title),
        certificate_file_path = TRIM(p_certificate_file_path),
        status = 'issued',
        issued_at = NOW(),
        updated_at = NOW()
    WHERE id = v_existing_cert.id
    RETURNING * INTO v_created_cert;

    RETURN to_jsonb(v_created_cert);
  END IF;

  -- 7. Generate a unique, standard Certificate ID: AZ-INT-YYYY-XXXX
  v_year := TO_CHAR(NOW(), 'YYYY');
  LOOP
    v_rand_part := UPPER(SUBSTRING(MD5(gen_random_uuid()::text) FROM 1 FOR 4) || '-' || SUBSTRING(MD5(gen_random_uuid()::text) FROM 5 FOR 4));
    v_cert_id := 'AZ-INT-' || v_year || '-' || v_rand_part;

    EXIT WHEN NOT EXISTS (
      SELECT 1 FROM public.certificates WHERE certificate_id = v_cert_id
    );
  END LOOP;

  -- 8. Insert new certificate
  INSERT INTO public.certificates (
    certificate_id,
    student_id,
    internship_id,
    enrollment_id,
    student_name,
    internship_title,
    certificate_file_path,
    status,
    issued_at,
    created_at,
    updated_at
  )
  VALUES (
    v_cert_id,
    p_student_id,
    p_internship_id,
    p_enrollment_id,
    TRIM(p_student_name),
    TRIM(p_internship_title),
    TRIM(p_certificate_file_path),
    'issued',
    NOW(),
    NOW(),
    NOW()
  )
  RETURNING * INTO v_created_cert;

  RETURN to_jsonb(v_created_cert);
END;
$$;

REVOKE ALL ON FUNCTION public.issue_certificate_secure(UUID, UUID, UUID, TEXT, TEXT, TEXT) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.issue_certificate_secure(UUID, UUID, UUID, TEXT, TEXT, TEXT) TO authenticated;


-- 4. Secure Function: Revoke Certificate (Admin only)
CREATE OR REPLACE FUNCTION public.revoke_certificate_secure(
  p_certificate_id TEXT,
  p_admin_note TEXT DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  v_cert RECORD;
  v_updated RECORD;
BEGIN
  IF NOT public.is_admin() THEN
    RAISE EXCEPTION 'Unauthorized: Only administrators can revoke certificates.';
  END IF;

  SELECT * INTO v_cert
  FROM public.certificates
  WHERE certificate_id = p_certificate_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Certificate not found.';
  END IF;

  UPDATE public.certificates
  SET status = 'revoked',
      updated_at = NOW()
  WHERE id = v_cert.id
  RETURNING * INTO v_updated;

  RETURN to_jsonb(v_updated);
END;
$$;

REVOKE ALL ON FUNCTION public.revoke_certificate_secure(TEXT, TEXT) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.revoke_certificate_secure(TEXT, TEXT) TO authenticated;
