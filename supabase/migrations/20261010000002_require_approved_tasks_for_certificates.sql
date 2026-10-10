-- Fail closed on missing or cross-owner submission files, and require every
-- published required task to be approved before a certificate payment or issue.

CREATE OR REPLACE FUNCTION public.protect_submission_review_fields()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, private, storage, pg_temp
AS $$
DECLARE
  v_profile_id uuid;
BEGIN
  IF (SELECT private.is_admin()) THEN
    RETURN NEW;
  END IF;

  SELECT p.id INTO v_profile_id
  FROM public.profiles p
  WHERE p.user_id = (SELECT auth.uid())
  LIMIT 1;

  IF v_profile_id IS NULL THEN
    RAISE EXCEPTION 'student profile required';
  END IF;

  IF TG_OP = 'INSERT' THEN
    IF NEW.student_id IS DISTINCT FROM v_profile_id THEN
      RAISE EXCEPTION 'submission student does not match authenticated profile';
    END IF;
    IF NEW.status <> 'pending'
       OR NEW.admin_feedback IS NOT NULL
       OR NEW.reviewed_by IS NOT NULL
       OR NEW.reviewed_at IS NOT NULL THEN
      RAISE EXCEPTION 'new submissions must be pending and unreviewed';
    END IF;
  ELSE
    IF OLD.student_id IS DISTINCT FROM v_profile_id THEN
      RAISE EXCEPTION 'submission owner required';
    END IF;
    IF OLD.status NOT IN ('pending', 'revision_requested', 'rejected') THEN
      RAISE EXCEPTION 'approved submissions cannot be edited';
    END IF;
    IF NEW.student_id IS DISTINCT FROM OLD.student_id
       OR NEW.task_id IS DISTINCT FROM OLD.task_id
       OR NEW.enrollment_id IS DISTINCT FROM OLD.enrollment_id THEN
      RAISE EXCEPTION 'submission ownership fields cannot be changed';
    END IF;
    IF NEW.status <> 'pending'
       OR NEW.admin_feedback IS NOT NULL
       OR NEW.reviewed_by IS NOT NULL
       OR NEW.reviewed_at IS NOT NULL THEN
      RAISE EXCEPTION 'students cannot change submission review fields';
    END IF;
    NEW.submitted_at := now();
  END IF;

  IF NEW.file_path IS NOT NULL THEN
    IF NEW.file_path NOT LIKE NEW.student_id::text || '/%' THEN
      RAISE EXCEPTION 'submission file path must belong to the student';
    END IF;
    IF NOT EXISTS (
      SELECT 1 FROM storage.objects o
      WHERE o.bucket_id = 'task-submissions'
        AND o.name = NEW.file_path
    ) THEN
      RAISE EXCEPTION 'uploaded submission file not found';
    END IF;
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS protect_submission_review_fields ON public.task_submissions;
CREATE TRIGGER protect_submission_review_fields
BEFORE INSERT OR UPDATE ON public.task_submissions
FOR EACH ROW EXECUTE FUNCTION public.protect_submission_review_fields();

CREATE OR REPLACE FUNCTION public.protect_certificate_payment_fields()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, private, storage, pg_temp
AS $$
DECLARE
  v_profile_id uuid;
  v_enrollment public.enrollments%ROWTYPE;
  v_price numeric;
  v_currency text;
  v_required integer;
  v_approved integer;
BEGIN
  IF (SELECT private.is_admin()) THEN
    RETURN NEW;
  END IF;

  SELECT p.id INTO v_profile_id
  FROM public.profiles p
  WHERE p.user_id = (SELECT auth.uid())
  LIMIT 1;
  IF v_profile_id IS NULL THEN
    RAISE EXCEPTION 'student profile required';
  END IF;

  IF TG_OP = 'INSERT' THEN
    IF NEW.student_id IS DISTINCT FROM v_profile_id THEN
      RAISE EXCEPTION 'payment student does not match authenticated profile';
    END IF;

    SELECT * INTO v_enrollment
    FROM public.enrollments e
    WHERE e.id = NEW.enrollment_id
      AND e.student_id = NEW.student_id
      AND e.internship_id = NEW.internship_id
      AND e.status = 'completed';
    IF NOT FOUND THEN
      RAISE EXCEPTION 'completed enrollment required';
    END IF;

    SELECT count(*) INTO v_required
    FROM public.internship_tasks t
    WHERE t.internship_id = NEW.internship_id
      AND t.is_required = true
      AND t.status = 'published';
    SELECT count(*) INTO v_approved
    FROM public.task_submissions ts
    JOIN public.internship_tasks t ON t.id = ts.task_id
    WHERE ts.enrollment_id = NEW.enrollment_id
      AND ts.student_id = NEW.student_id
      AND ts.status = 'approved'
      AND t.internship_id = NEW.internship_id
      AND t.is_required = true
      AND t.status = 'published';
    IF v_required > 0 AND v_approved <> v_required THEN
      RAISE EXCEPTION 'all required tasks must be approved before certificate payment';
    END IF;

    SELECT cs.price, cs.currency INTO v_price, v_currency
    FROM public.certificate_settings cs
    WHERE cs.internship_id = NEW.internship_id
      AND cs.is_enabled = true
    LIMIT 1;
    IF NOT FOUND THEN
      RAISE EXCEPTION 'certificate payment is disabled for this internship';
    END IF;
    IF NEW.amount IS DISTINCT FROM v_price
       OR upper(trim(NEW.currency)) IS DISTINCT FROM upper(trim(v_currency)) THEN
      RAISE EXCEPTION 'certificate payment amount/currency does not match current settings';
    END IF;
    IF NEW.status <> 'pending'
       OR NEW.admin_note IS NOT NULL
       OR NEW.reviewed_by IS NOT NULL
       OR NEW.reviewed_at IS NOT NULL THEN
      RAISE EXCEPTION 'new certificate payments must be pending and unreviewed';
    END IF;
  ELSE
    IF OLD.student_id IS DISTINCT FROM v_profile_id THEN
      RAISE EXCEPTION 'payment owner required';
    END IF;
    IF OLD.status <> 'pending' THEN
      RAISE EXCEPTION 'only pending payments may be updated by the student';
    END IF;
    IF NEW.student_id IS DISTINCT FROM OLD.student_id
       OR NEW.internship_id IS DISTINCT FROM OLD.internship_id
       OR NEW.enrollment_id IS DISTINCT FROM OLD.enrollment_id
       OR NEW.amount IS DISTINCT FROM OLD.amount
       OR NEW.currency IS DISTINCT FROM OLD.currency
       OR NEW.status IS DISTINCT FROM OLD.status
       OR NEW.admin_note IS DISTINCT FROM OLD.admin_note
       OR NEW.reviewed_by IS DISTINCT FROM OLD.reviewed_by
       OR NEW.reviewed_at IS DISTINCT FROM OLD.reviewed_at
       OR NEW.created_at IS DISTINCT FROM OLD.created_at THEN
      RAISE EXCEPTION 'payment financial/review fields cannot be changed by the student';
    END IF;
  END IF;

  IF NEW.receipt_path IS NULL
     OR NEW.receipt_path NOT LIKE NEW.student_id::text || '/%' THEN
    RAISE EXCEPTION 'receipt path must belong to the student';
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM storage.objects o
    WHERE o.bucket_id = 'certificate-payments'
      AND o.name = NEW.receipt_path
  ) THEN
    RAISE EXCEPTION 'uploaded receipt file not found';
  END IF;
  RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION public.issue_certificate_secure(
  p_enrollment_id uuid,
  p_student_id uuid,
  p_internship_id uuid,
  p_student_name text,
  p_internship_title text,
  p_certificate_file_path text
)
RETURNS public.certificates
LANGUAGE plpgsql
SET search_path TO public
AS $$
DECLARE
  v_enrollment public.enrollments%ROWTYPE;
  v_payment public.certificate_payments%ROWTYPE;
  v_existing public.certificates%ROWTYPE;
  v_cert public.certificates%ROWTYPE;
  v_certificate_id text;
  v_required integer;
  v_approved integer;
BEGIN
  IF NOT private.is_admin() THEN
    RAISE EXCEPTION 'admin access required';
  END IF;
  IF trim(coalesce(p_student_name, '')) = '' OR trim(coalesce(p_internship_title, '')) = '' THEN
    RAISE EXCEPTION 'student name and internship title are required';
  END IF;
  IF p_certificate_file_path IS NULL
     OR p_certificate_file_path NOT LIKE p_student_id::text || '/%' THEN
    RAISE EXCEPTION 'certificate file path must belong to the student';
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM storage.objects o
    WHERE o.bucket_id = 'certificates'
      AND o.name = p_certificate_file_path
  ) THEN
    RAISE EXCEPTION 'uploaded certificate PDF not found';
  END IF;

  SELECT * INTO v_enrollment
  FROM public.enrollments
  WHERE id = p_enrollment_id
  FOR UPDATE;
  IF NOT FOUND THEN RAISE EXCEPTION 'enrollment not found'; END IF;
  IF v_enrollment.student_id <> p_student_id OR v_enrollment.internship_id <> p_internship_id THEN
    RAISE EXCEPTION 'enrollment ownership mismatch';
  END IF;
  IF v_enrollment.status <> 'completed' THEN
    RAISE EXCEPTION 'enrollment is not completed';
  END IF;

  SELECT count(*) INTO v_required
  FROM public.internship_tasks t
  WHERE t.internship_id = p_internship_id
    AND t.is_required = true
    AND t.status = 'published';
  SELECT count(*) INTO v_approved
  FROM public.task_submissions ts
  JOIN public.internship_tasks t ON t.id = ts.task_id
  WHERE ts.enrollment_id = p_enrollment_id
    AND ts.student_id = p_student_id
    AND ts.status = 'approved'
    AND t.internship_id = p_internship_id
    AND t.is_required = true
    AND t.status = 'published';
  IF v_required > 0 AND v_approved <> v_required THEN
    RAISE EXCEPTION 'all required tasks must be approved before certificate issuance';
  END IF;

  SELECT * INTO v_payment
  FROM public.certificate_payments
  WHERE enrollment_id = p_enrollment_id AND status = 'approved'
  ORDER BY reviewed_at DESC NULLS LAST, created_at DESC
  LIMIT 1;
  IF NOT FOUND THEN RAISE EXCEPTION 'approved certificate payment required'; END IF;

  SELECT * INTO v_existing
  FROM public.certificates
  WHERE enrollment_id = p_enrollment_id
  FOR UPDATE;
  IF FOUND THEN
    UPDATE public.certificates
    SET student_name = trim(p_student_name),
        internship_title = trim(p_internship_title),
        certificate_file_path = p_certificate_file_path,
        status = 'issued',
        issued_at = coalesce(issued_at, now()),
        updated_at = now()
    WHERE id = v_existing.id
    RETURNING * INTO v_cert;
    RETURN v_cert;
  END IF;

  v_certificate_id := 'AZ-INT-' || to_char(current_date, 'YYYY') || '-' ||
    upper(substr(replace(gen_random_uuid()::text, '-', ''), 1, 4));
  INSERT INTO public.certificates (
    certificate_id, student_id, internship_id, enrollment_id,
    student_name, internship_title, issued_at, certificate_file_path, status
  )
  VALUES (
    v_certificate_id, p_student_id, p_internship_id, p_enrollment_id,
    trim(p_student_name), trim(p_internship_title), now(), p_certificate_file_path, 'issued'
  )
  RETURNING * INTO v_cert;
  RETURN v_cert;
END;
$$;
ALTER FUNCTION public.issue_certificate_secure(uuid, uuid, uuid, text, text, text) SECURITY INVOKER;
