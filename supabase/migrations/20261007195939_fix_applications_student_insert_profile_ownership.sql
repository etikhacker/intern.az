-- Restore student ownership using the profile row linked to the authenticated user.
-- Students may only submit pending applications without admin review fields.
DROP POLICY IF EXISTS "applications_student_insert" ON public.applications;
DROP POLICY IF EXISTS "Students can submit application" ON public.applications;

CREATE POLICY "applications_student_insert"
ON public.applications
FOR INSERT
TO authenticated
WITH CHECK (
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
);
