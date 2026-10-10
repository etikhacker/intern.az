BEGIN;

ALTER TABLE public.task_submissions
  ADD COLUMN IF NOT EXISTS file_name text;

-- Ensure PostgREST sees the new nullable column before the app submits it.
NOTIFY pgrst, 'reload schema';

COMMIT;
