-- ==========================================================
-- SECURITY HARDENING: PRIVATE STORAGE AND ENROLLMENT RPC
-- Targets the active intern.az schema (student_id = auth.uid()).
-- ==========================================================

-- Existing live policies are recreated with explicit authenticated roles and
-- owner/admin checks so no authenticated user can read another user's files.
DROP POLICY IF EXISTS "task_files_insert" ON storage.objects;
CREATE POLICY "task_files_insert" ON storage.objects FOR INSERT TO authenticated
WITH CHECK (bucket_id = 'task-submissions' AND (storage.foldername(name))[1] = (SELECT auth.uid()::text));
DROP POLICY IF EXISTS "task_files_select" ON storage.objects;
CREATE POLICY "task_files_select" ON storage.objects FOR SELECT TO authenticated
USING (bucket_id = 'task-submissions' AND ((storage.foldername(name))[1] = (SELECT auth.uid()::text) OR (SELECT private.is_admin())));
DROP POLICY IF EXISTS "task_files_update" ON storage.objects;
CREATE POLICY "task_files_update" ON storage.objects FOR UPDATE TO authenticated
USING (bucket_id = 'task-submissions' AND ((storage.foldername(name))[1] = (SELECT auth.uid()::text) OR (SELECT private.is_admin())))
WITH CHECK (bucket_id = 'task-submissions' AND ((storage.foldername(name))[1] = (SELECT auth.uid()::text) OR (SELECT private.is_admin())));
DROP POLICY IF EXISTS "task_files_delete" ON storage.objects;
CREATE POLICY "task_files_delete" ON storage.objects FOR DELETE TO authenticated
USING (bucket_id = 'task-submissions' AND ((storage.foldername(name))[1] = (SELECT auth.uid()::text) OR (SELECT private.is_admin())));

DROP POLICY IF EXISTS "certificate_payment_files_insert" ON storage.objects;
CREATE POLICY "certificate_payment_files_insert" ON storage.objects FOR INSERT TO authenticated
WITH CHECK (bucket_id = 'certificate-payments' AND (storage.foldername(name))[1] = (SELECT auth.uid()::text));
DROP POLICY IF EXISTS "certificate_payment_files_select" ON storage.objects;
CREATE POLICY "certificate_payment_files_select" ON storage.objects FOR SELECT TO authenticated
USING (bucket_id = 'certificate-payments' AND ((storage.foldername(name))[1] = (SELECT auth.uid()::text) OR (SELECT private.is_admin())));
DROP POLICY IF EXISTS "certificate_payment_files_update" ON storage.objects;
CREATE POLICY "certificate_payment_files_update" ON storage.objects FOR UPDATE TO authenticated
USING (bucket_id = 'certificate-payments' AND ((storage.foldername(name))[1] = (SELECT auth.uid()::text) OR (SELECT private.is_admin())))
WITH CHECK (bucket_id = 'certificate-payments' AND ((storage.foldername(name))[1] = (SELECT auth.uid()::text) OR (SELECT private.is_admin())));
DROP POLICY IF EXISTS "certificate_payment_files_delete" ON storage.objects;
CREATE POLICY "certificate_payment_files_delete" ON storage.objects FOR DELETE TO authenticated
USING (bucket_id = 'certificate-payments' AND ((storage.foldername(name))[1] = (SELECT auth.uid()::text) OR (SELECT private.is_admin())));

DROP POLICY IF EXISTS "certificate_files_select" ON storage.objects;
CREATE POLICY "certificate_files_select" ON storage.objects FOR SELECT TO authenticated
USING (bucket_id = 'certificates' AND ((storage.foldername(name))[1] = (SELECT auth.uid()::text) OR (SELECT private.is_admin())));

-- Completion is only callable by the administrator and remains atomic.
CREATE OR REPLACE FUNCTION public.check_and_complete_enrollment(p_enrollment_id uuid)
RETURNS public.enrollments LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
declare v_enrollment public.enrollments%rowtype; v_required integer; v_approved integer;
begin
  if not private.is_admin() then raise exception 'admin access required'; end if;
  select * into v_enrollment from public.enrollments where id = p_enrollment_id for update;
  if not found then raise exception 'enrollment not found'; end if;
  select count(*) into v_required from public.internship_tasks
    where internship_id = v_enrollment.internship_id and is_required = true and status = 'published';
  select count(*) into v_approved from public.task_submissions ts
    join public.internship_tasks t on t.id = ts.task_id
    where ts.enrollment_id = p_enrollment_id and ts.student_id = v_enrollment.student_id
      and ts.status = 'approved' and t.internship_id = v_enrollment.internship_id
      and t.is_required = true and t.status = 'published';
  if v_required = 0 or v_approved = v_required then
    update public.enrollments set status = 'completed', completed_at = coalesce(completed_at, now()), updated_at = now()
      where id = p_enrollment_id returning * into v_enrollment;
  end if;
  return v_enrollment;
end;
$$;

-- These functions perform their own admin checks and use RLS as invokers.
ALTER FUNCTION public.issue_certificate_secure(uuid, uuid, uuid, text, text, text) SECURITY INVOKER;
ALTER FUNCTION public.revoke_certificate_secure(text, text) SECURITY INVOKER;

-- Cover foreign keys reported by Supabase performance advisors.
CREATE INDEX IF NOT EXISTS applications_reviewed_by_idx ON public.applications (reviewed_by);
CREATE INDEX IF NOT EXISTS certificate_payments_enrollment_id_idx ON public.certificate_payments (enrollment_id);
CREATE INDEX IF NOT EXISTS certificate_payments_reviewed_by_idx ON public.certificate_payments (reviewed_by);
CREATE INDEX IF NOT EXISTS enrollments_application_id_idx ON public.enrollments (application_id);
CREATE INDEX IF NOT EXISTS internships_created_by_idx ON public.internships (created_by);
CREATE INDEX IF NOT EXISTS task_submissions_reviewed_by_idx ON public.task_submissions (reviewed_by);
