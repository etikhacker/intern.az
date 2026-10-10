-- Remove the legacy global uniqueness rule that blocks a student from reapplying
-- after a rejection or withdrawal, then restore the intended active-only rule.
ALTER TABLE public.applications
  DROP CONSTRAINT IF EXISTS applications_internship_id_student_id_key;

DROP INDEX IF EXISTS public.idx_unique_active_student_application;

CREATE UNIQUE INDEX idx_unique_active_student_application
  ON public.applications (internship_id, student_id)
  WHERE status IN ('pending', 'accepted');
