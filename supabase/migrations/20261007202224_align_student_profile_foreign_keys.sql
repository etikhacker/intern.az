-- Applications and enrollments store public.profiles.id in student_id.
-- The application services also query/insert by profiles.id; production had
-- drifted to auth.users.id, which rejects those profile IDs as foreign keys.
ALTER TABLE public.applications
  DROP CONSTRAINT IF EXISTS applications_student_id_fkey;

ALTER TABLE public.applications
  ADD CONSTRAINT applications_student_id_fkey
  FOREIGN KEY (student_id)
  REFERENCES public.profiles(id)
  ON DELETE CASCADE;

ALTER TABLE public.enrollments
  DROP CONSTRAINT IF EXISTS enrollments_student_id_fkey;

ALTER TABLE public.enrollments
  ADD CONSTRAINT enrollments_student_id_fkey
  FOREIGN KEY (student_id)
  REFERENCES public.profiles(id)
  ON DELETE CASCADE;

-- Student pages query enrollments by profile.id; keep admin visibility too.
DROP POLICY IF EXISTS "enrollments_student_select" ON public.enrollments;
DROP POLICY IF EXISTS "enrollments_admin_select" ON public.enrollments;
DROP POLICY IF EXISTS "Students can view own enrollments" ON public.enrollments;
DROP POLICY IF EXISTS "Admins can view all enrollments" ON public.enrollments;

CREATE POLICY "enrollments_student_select"
ON public.enrollments
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
