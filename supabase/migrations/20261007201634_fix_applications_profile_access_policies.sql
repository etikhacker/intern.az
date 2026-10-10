-- applications.student_id references profiles.id, not auth.users.id.
-- The client submits with INSERT ... SELECT, so the inserted row must also
-- pass the SELECT policy or Postgres rejects the entire returning operation.
DROP POLICY IF EXISTS "applications_student_select" ON public.applications;
DROP POLICY IF EXISTS "applications_admin_select" ON public.applications;
DROP POLICY IF EXISTS "Students can view own applications" ON public.applications;
DROP POLICY IF EXISTS "Admins can view all applications" ON public.applications;

CREATE POLICY "applications_student_select"
ON public.applications
FOR SELECT
TO authenticated
USING (
  student_id IN (
    SELECT p.id
    FROM public.profiles AS p
    WHERE p.user_id = (SELECT auth.uid())
  )
  OR (SELECT private.is_admin())
);

DROP POLICY IF EXISTS "applications_student_update" ON public.applications;
DROP POLICY IF EXISTS "applications_admin_update" ON public.applications;
DROP POLICY IF EXISTS "Students can withdraw own pending application" ON public.applications;
DROP POLICY IF EXISTS "Admins can update applications" ON public.applications;

-- Students may only withdraw their own pending, unreviewed application.
CREATE POLICY "applications_student_update"
ON public.applications
FOR UPDATE
TO authenticated
USING (
  student_id IN (
    SELECT p.id
    FROM public.profiles AS p
    WHERE p.user_id = (SELECT auth.uid())
  )
  AND status = 'pending'
  AND admin_note IS NULL
  AND reviewed_by IS NULL
  AND reviewed_at IS NULL
  AND NOT (SELECT private.is_admin())
)
WITH CHECK (
  student_id IN (
    SELECT p.id
    FROM public.profiles AS p
    WHERE p.user_id = (SELECT auth.uid())
  )
  AND status = 'withdrawn'
  AND admin_note IS NULL
  AND reviewed_by IS NULL
  AND reviewed_at IS NULL
  AND NOT (SELECT private.is_admin())
);

-- Preserve the administrator review flow expected by reviewApplication().
CREATE POLICY "applications_admin_update"
ON public.applications
FOR UPDATE
TO authenticated
USING ((SELECT private.is_admin()))
WITH CHECK ((SELECT private.is_admin()));
