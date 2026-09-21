-- ==========================================================
-- PHASE 3: INTERNSHIP TASKS, SUBMISSIONS, AND REVIEWS
-- Internship Management Platform (Azerbaijan)
-- ==========================================================

-- 1. Create internship_tasks table
CREATE TABLE IF NOT EXISTS public.internship_tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  internship_id UUID NOT NULL REFERENCES public.internships(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  instructions TEXT NOT NULL,
  week_number INTEGER NOT NULL DEFAULT 1 CHECK (week_number >= 1),
  task_number INTEGER NOT NULL DEFAULT 1 CHECK (task_number >= 1),
  difficulty TEXT NOT NULL DEFAULT 'intermediate' CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),
  submission_type TEXT NOT NULL DEFAULT 'github' CHECK (submission_type IN ('text', 'link', 'file', 'github', 'multiple')),
  deadline TIMESTAMPTZ NULL,
  is_required BOOLEAN NOT NULL DEFAULT true,
  status TEXT NOT NULL DEFAULT 'draft' CHECK (status IN ('draft', 'published', 'archived')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Indexes for internship_tasks
CREATE INDEX IF NOT EXISTS idx_tasks_internship_id ON public.internship_tasks(internship_id);
CREATE INDEX IF NOT EXISTS idx_tasks_week_task ON public.internship_tasks(internship_id, week_number, task_number);
CREATE INDEX IF NOT EXISTS idx_tasks_status ON public.internship_tasks(status);

-- Automatic updated_at trigger for internship_tasks
DROP TRIGGER IF EXISTS trigger_tasks_updated_at ON public.internship_tasks;
CREATE TRIGGER trigger_tasks_updated_at
  BEFORE UPDATE ON public.internship_tasks
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_updated_at();


-- 2. Create task_submissions table
CREATE TABLE IF NOT EXISTS public.task_submissions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID NOT NULL REFERENCES public.internship_tasks(id) ON DELETE CASCADE,
  student_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  enrollment_id UUID NOT NULL REFERENCES public.enrollments(id) ON DELETE CASCADE,
  text_answer TEXT NULL,
  submission_url TEXT NULL,
  github_url TEXT NULL,
  file_path TEXT NULL,
  comment TEXT NULL,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'revision_requested', 'approved', 'rejected')),
  admin_feedback TEXT NULL,
  reviewed_by UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  reviewed_at TIMESTAMPTZ NULL,
  submitted_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Unique index per task and student: each student has one active submission record per task that can be updated on revision
CREATE UNIQUE INDEX IF NOT EXISTS idx_unique_task_student_submission
  ON public.task_submissions(task_id, student_id);

-- Indexes for task_submissions
CREATE INDEX IF NOT EXISTS idx_submissions_task_id ON public.task_submissions(task_id);
CREATE INDEX IF NOT EXISTS idx_submissions_student_id ON public.task_submissions(student_id);
CREATE INDEX IF NOT EXISTS idx_submissions_enrollment_id ON public.task_submissions(enrollment_id);
CREATE INDEX IF NOT EXISTS idx_submissions_status ON public.task_submissions(status);

-- Automatic updated_at trigger for task_submissions
DROP TRIGGER IF EXISTS trigger_submissions_updated_at ON public.task_submissions;
CREATE TRIGGER trigger_submissions_updated_at
  BEFORE UPDATE ON public.task_submissions
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_updated_at();


-- 3. Enable Row Level Security (RLS)
ALTER TABLE public.internship_tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.task_submissions ENABLE ROW LEVEL SECURITY;


-- 4. RLS Policies for internship_tasks
-- Students can view published tasks belonging ONLY to internships where they have an active enrollment
DROP POLICY IF EXISTS "Students can view tasks of enrolled internships" ON public.internship_tasks;
CREATE POLICY "Students can view tasks of enrolled internships"
  ON public.internship_tasks
  FOR SELECT
  USING (
    status = 'published'
    AND internship_id IN (
      SELECT internship_id FROM public.enrollments
      WHERE student_id IN (
        SELECT id FROM public.profiles WHERE user_id = auth.uid()
      )
      AND status = 'active'
    )
  );

-- Admins can view all tasks
DROP POLICY IF EXISTS "Admins can view all tasks" ON public.internship_tasks;
CREATE POLICY "Admins can view all tasks"
  ON public.internship_tasks
  FOR SELECT
  USING (public.is_admin());

-- Admins can insert tasks
DROP POLICY IF EXISTS "Admins can insert tasks" ON public.internship_tasks;
CREATE POLICY "Admins can insert tasks"
  ON public.internship_tasks
  FOR INSERT
  WITH CHECK (public.is_admin());

-- Admins can update tasks
DROP POLICY IF EXISTS "Admins can update tasks" ON public.internship_tasks;
CREATE POLICY "Admins can update tasks"
  ON public.internship_tasks
  FOR UPDATE
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- Admins can delete tasks
DROP POLICY IF EXISTS "Admins can delete tasks" ON public.internship_tasks;
CREATE POLICY "Admins can delete tasks"
  ON public.internship_tasks
  FOR DELETE
  USING (public.is_admin());


-- 5. RLS Policies for task_submissions
-- Students can view ONLY their own submissions
DROP POLICY IF EXISTS "Students can view own submissions" ON public.task_submissions;
CREATE POLICY "Students can view own submissions"
  ON public.task_submissions
  FOR SELECT
  USING (
    student_id IN (
      SELECT id FROM public.profiles WHERE user_id = auth.uid()
    )
  );

-- Admins can view all submissions
DROP POLICY IF EXISTS "Admins can view all submissions" ON public.task_submissions;
CREATE POLICY "Admins can view all submissions"
  ON public.task_submissions
  FOR SELECT
  USING (public.is_admin());

-- Students can insert their own submissions for an active enrollment
DROP POLICY IF EXISTS "Students can submit task solutions" ON public.task_submissions;
CREATE POLICY "Students can submit task solutions"
  ON public.task_submissions
  FOR INSERT
  WITH CHECK (
    student_id IN (
      SELECT id FROM public.profiles WHERE user_id = auth.uid()
    )
    AND enrollment_id IN (
      SELECT id FROM public.enrollments
      WHERE student_id IN (SELECT id FROM public.profiles WHERE user_id = auth.uid())
      AND status = 'active'
    )
    AND status = 'pending'
  );

-- Students can update their own submissions (e.g., when resubmitting after revision requested)
DROP POLICY IF EXISTS "Students can update own submissions" ON public.task_submissions;
CREATE POLICY "Students can update own submissions"
  ON public.task_submissions
  FOR UPDATE
  USING (
    student_id IN (
      SELECT id FROM public.profiles WHERE user_id = auth.uid()
    )
  )
  WITH CHECK (
    student_id IN (
      SELECT id FROM public.profiles WHERE user_id = auth.uid()
    )
    AND status = 'pending'
  );

-- Admins can update any submission (review, approve, request revision, reject, add feedback)
DROP POLICY IF EXISTS "Admins can review submissions" ON public.task_submissions;
CREATE POLICY "Admins can review submissions"
  ON public.task_submissions
  FOR UPDATE
  USING (public.is_admin())
  WITH CHECK (public.is_admin());


-- 6. Supabase Storage: Bucket and Policies for task-submissions
INSERT INTO storage.buckets (id, name, public)
VALUES ('task-submissions', 'task-submissions', false)
ON CONFLICT (id) DO NOTHING;

-- Storage Policy: Students can upload files into their own user folder
DROP POLICY IF EXISTS "Students can upload submission files" ON storage.objects;
CREATE POLICY "Students can upload submission files"
  ON storage.objects
  FOR INSERT
  WITH CHECK (
    bucket_id = 'task-submissions'
    AND auth.role() = 'authenticated'
  );

-- Storage Policy: Students can read their own files
DROP POLICY IF EXISTS "Students can read own submission files" ON storage.objects;
CREATE POLICY "Students can read own submission files"
  ON storage.objects
  FOR SELECT
  USING (
    bucket_id = 'task-submissions'
    AND (
      public.is_admin()
      OR (auth.uid() IS NOT NULL)
    )
  );

-- Storage Policy: Admins have full access to all submission files
DROP POLICY IF EXISTS "Admins have full access to submission files" ON storage.objects;
CREATE POLICY "Admins have full access to submission files"
  ON storage.objects
  FOR ALL
  USING (
    bucket_id = 'task-submissions'
    AND public.is_admin()
  );
