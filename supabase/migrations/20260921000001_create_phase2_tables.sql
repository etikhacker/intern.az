-- ==========================================================
-- PHASE 2: INTERNSHIPS, APPLICATIONS, AND ENROLLMENTS
-- Internship Management Platform (Azerbaijan)
-- ==========================================================

-- 1. Create internships table
CREATE TABLE IF NOT EXISTS public.internships (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  slug TEXT NOT NULL UNIQUE,
  short_description TEXT NOT NULL,
  description TEXT NOT NULL,
  category TEXT NOT NULL,
  duration_weeks INTEGER NOT NULL,
  difficulty TEXT NOT NULL CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),
  skills TEXT[] NOT NULL DEFAULT '{}',
  requirements TEXT[] NOT NULL DEFAULT '{}',
  responsibilities TEXT[] NOT NULL DEFAULT '{}',
  benefits TEXT[] NOT NULL DEFAULT '{}',
  max_students INTEGER NULL,
  status TEXT NOT NULL DEFAULT 'draft' CHECK (status IN ('draft', 'published', 'closed', 'archived')),
  application_deadline TIMESTAMPTZ NULL,
  start_date TIMESTAMPTZ NULL,
  created_by UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Indexes for internships
CREATE INDEX IF NOT EXISTS idx_internships_slug ON public.internships(slug);
CREATE INDEX IF NOT EXISTS idx_internships_status ON public.internships(status);
CREATE INDEX IF NOT EXISTS idx_internships_category ON public.internships(category);
CREATE INDEX IF NOT EXISTS idx_internships_deadline ON public.internships(application_deadline);

-- Automatic updated_at trigger for internships
DROP TRIGGER IF EXISTS trigger_internships_updated_at ON public.internships;
CREATE TRIGGER trigger_internships_updated_at
  BEFORE UPDATE ON public.internships
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_updated_at();


-- 2. Create applications table
CREATE TABLE IF NOT EXISTS public.applications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  internship_id UUID NOT NULL REFERENCES public.internships(id) ON DELETE CASCADE,
  student_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  motivation TEXT NOT NULL,
  experience TEXT,
  portfolio_url TEXT,
  github_url TEXT,
  linkedin_url TEXT,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'rejected', 'withdrawn')),
  admin_note TEXT,
  reviewed_by UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  reviewed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Unique index preventing a student from submitting multiple active applications to the same internship
CREATE UNIQUE INDEX IF NOT EXISTS idx_unique_active_student_application
  ON public.applications (internship_id, student_id)
  WHERE status IN ('pending', 'accepted');

-- General indexes for applications
CREATE INDEX IF NOT EXISTS idx_applications_internship_id ON public.applications(internship_id);
CREATE INDEX IF NOT EXISTS idx_applications_student_id ON public.applications(student_id);
CREATE INDEX IF NOT EXISTS idx_applications_status ON public.applications(status);

-- Automatic updated_at trigger for applications
DROP TRIGGER IF EXISTS trigger_applications_updated_at ON public.applications;
CREATE TRIGGER trigger_applications_updated_at
  BEFORE UPDATE ON public.applications
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_updated_at();


-- 3. Create enrollments table
CREATE TABLE IF NOT EXISTS public.enrollments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  internship_id UUID NOT NULL REFERENCES public.internships(id) ON DELETE CASCADE,
  student_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  application_id UUID REFERENCES public.applications(id) ON DELETE SET NULL,
  status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'completed', 'cancelled')),
  enrolled_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  completed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT unique_student_internship_enrollment UNIQUE (internship_id, student_id)
);

-- Indexes for enrollments
CREATE INDEX IF NOT EXISTS idx_enrollments_internship_id ON public.enrollments(internship_id);
CREATE INDEX IF NOT EXISTS idx_enrollments_student_id ON public.enrollments(student_id);
CREATE INDEX IF NOT EXISTS idx_enrollments_status ON public.enrollments(status);

-- Automatic updated_at trigger for enrollments
DROP TRIGGER IF EXISTS trigger_enrollments_updated_at ON public.enrollments;
CREATE TRIGGER trigger_enrollments_updated_at
  BEFORE UPDATE ON public.enrollments
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_updated_at();


-- 4. Enable Row Level Security (RLS)
ALTER TABLE public.internships ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.applications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.enrollments ENABLE ROW LEVEL SECURITY;


-- 5. RLS Policies for internships
-- Public can read ONLY published internships
DROP POLICY IF EXISTS "Public can view published internships" ON public.internships;
CREATE POLICY "Public can view published internships"
  ON public.internships
  FOR SELECT
  USING (status = 'published');

-- Admins can view all internships (draft, published, closed, archived)
DROP POLICY IF EXISTS "Admins can view all internships" ON public.internships;
CREATE POLICY "Admins can view all internships"
  ON public.internships
  FOR SELECT
  USING (public.is_admin());

-- Admins can insert internships
DROP POLICY IF EXISTS "Admins can insert internships" ON public.internships;
CREATE POLICY "Admins can insert internships"
  ON public.internships
  FOR INSERT
  WITH CHECK (public.is_admin());

-- Admins can update internships
DROP POLICY IF EXISTS "Admins can update internships" ON public.internships;
CREATE POLICY "Admins can update internships"
  ON public.internships
  FOR UPDATE
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- Admins can delete internships
DROP POLICY IF EXISTS "Admins can delete internships" ON public.internships;
CREATE POLICY "Admins can delete internships"
  ON public.internships
  FOR DELETE
  USING (public.is_admin());


-- 6. RLS Policies for applications
-- Students can view their own applications
DROP POLICY IF EXISTS "Students can view own applications" ON public.applications;
CREATE POLICY "Students can view own applications"
  ON public.applications
  FOR SELECT
  USING (
    student_id IN (
      SELECT id FROM public.profiles WHERE user_id = auth.uid()
    )
  );

-- Admins can view all applications
DROP POLICY IF EXISTS "Admins can view all applications" ON public.applications;
CREATE POLICY "Admins can view all applications"
  ON public.applications
  FOR SELECT
  USING (public.is_admin());

-- Students can insert their own application
DROP POLICY IF EXISTS "Students can submit application" ON public.applications;
CREATE POLICY "Students can submit application"
  ON public.applications
  FOR INSERT
  WITH CHECK (
    student_id IN (
      SELECT id FROM public.profiles WHERE user_id = auth.uid()
    )
    AND status = 'pending'
  );

-- Students can withdraw their own pending application
DROP POLICY IF EXISTS "Students can withdraw own pending application" ON public.applications;
CREATE POLICY "Students can withdraw own pending application"
  ON public.applications
  FOR UPDATE
  USING (
    student_id IN (
      SELECT id FROM public.profiles WHERE user_id = auth.uid()
    )
    AND status = 'pending'
  )
  WITH CHECK (
    status = 'withdrawn'
  );

-- Admins can update any application (accept/reject/add notes)
DROP POLICY IF EXISTS "Admins can update applications" ON public.applications;
CREATE POLICY "Admins can update applications"
  ON public.applications
  FOR UPDATE
  USING (public.is_admin())
  WITH CHECK (public.is_admin());


-- 7. RLS Policies for enrollments
-- Students can view their own enrollments
DROP POLICY IF EXISTS "Students can view own enrollments" ON public.enrollments;
CREATE POLICY "Students can view own enrollments"
  ON public.enrollments
  FOR SELECT
  USING (
    student_id IN (
      SELECT id FROM public.profiles WHERE user_id = auth.uid()
    )
  );

-- Admins can view all enrollments
DROP POLICY IF EXISTS "Admins can view all enrollments" ON public.enrollments;
CREATE POLICY "Admins can view all enrollments"
  ON public.enrollments
  FOR SELECT
  USING (public.is_admin());

-- Only admins can insert enrollments
DROP POLICY IF EXISTS "Admins can create enrollments" ON public.enrollments;
CREATE POLICY "Admins can create enrollments"
  ON public.enrollments
  FOR INSERT
  WITH CHECK (public.is_admin());

-- Only admins can update enrollments
DROP POLICY IF EXISTS "Admins can update enrollments" ON public.enrollments;
CREATE POLICY "Admins can update enrollments"
  ON public.enrollments
  FOR UPDATE
  USING (public.is_admin())
  WITH CHECK (public.is_admin());
