-- Prevent anonymous/signed-in users from invoking a SECURITY DEFINER routine
-- that can cancel enrollments. Scheduled/server-side jobs should use service_role.
REVOKE ALL ON FUNCTION public.process_internship_deadlines() FROM PUBLIC;
REVOKE EXECUTE ON FUNCTION public.process_internship_deadlines() FROM anon, authenticated;
GRANT EXECUTE ON FUNCTION public.process_internship_deadlines() TO service_role;

-- Avoid per-row auth.uid() evaluation in deadline notification policies.
DROP POLICY IF EXISTS "Students can view own deadline notifications" ON public.deadline_notifications;
CREATE POLICY "Students can view own deadline notifications"
ON public.deadline_notifications
FOR SELECT TO authenticated
USING (
  student_id IN (
    SELECT p.id FROM public.profiles p
    WHERE p.user_id = (SELECT auth.uid())
  )
  OR (SELECT private.is_admin())
);

DROP POLICY IF EXISTS "Students can mark own deadline notifications read" ON public.deadline_notifications;
CREATE POLICY "Students can mark own deadline notifications read"
ON public.deadline_notifications
FOR UPDATE TO authenticated
USING (
  student_id IN (
    SELECT p.id FROM public.profiles p
    WHERE p.user_id = (SELECT auth.uid())
  )
  OR (SELECT private.is_admin())
)
WITH CHECK (
  student_id IN (
    SELECT p.id FROM public.profiles p
    WHERE p.user_id = (SELECT auth.uid())
  )
  OR (SELECT private.is_admin())
);

CREATE INDEX IF NOT EXISTS deadline_notifications_enrollment_id_idx
ON public.deadline_notifications (enrollment_id);
CREATE INDEX IF NOT EXISTS deadline_notifications_task_id_idx
ON public.deadline_notifications (task_id);
