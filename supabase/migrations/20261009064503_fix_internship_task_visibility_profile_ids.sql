-- Students are enrolled with profiles.id, while auth.uid() returns auth.users.id.
-- Map the Auth user to its profile before checking active enrollment ownership.
DROP POLICY IF EXISTS "Students can view tasks of enrolled internships" ON public.internship_tasks;
DROP POLICY IF EXISTS tasks_public_select ON public.internship_tasks;
DROP POLICY IF EXISTS tasks_student_select ON public.internship_tasks;
DROP POLICY IF EXISTS "Admins can view all tasks" ON public.internship_tasks;
DROP POLICY IF EXISTS tasks_admin_select ON public.internship_tasks;

CREATE POLICY tasks_student_select
  ON public.internship_tasks
  FOR SELECT
  TO authenticated
  USING (
    status = 'published'
    AND EXISTS (
      SELECT 1
      FROM public.enrollments AS e
      JOIN public.profiles AS p ON p.id = e.student_id
      WHERE e.internship_id = internship_tasks.internship_id
        AND p.user_id = (SELECT auth.uid())
        AND e.status = 'active'
    )
  );

CREATE POLICY tasks_admin_select
  ON public.internship_tasks
  FOR SELECT
  TO authenticated
  USING ((SELECT private.is_admin()));
