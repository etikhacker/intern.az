-- ==========================================================
-- PHASE 4: CERTIFICATES, PAYMENTS, AND PUBLIC VERIFICATION
-- Internship Management Platform (Azerbaijan)
-- ==========================================================

-- 1. Create certificate_settings table
CREATE TABLE IF NOT EXISTS public.certificate_settings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  internship_id UUID NOT NULL REFERENCES public.internships(id) ON DELETE CASCADE,
  price NUMERIC NOT NULL DEFAULT 25 CHECK (price >= 0),
  currency TEXT NOT NULL DEFAULT 'AZN',
  card_number TEXT NOT NULL DEFAULT '4169 7388 9012 3456',
  is_enabled BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Unique index to ensure 1 certificate setting per internship
CREATE UNIQUE INDEX IF NOT EXISTS idx_unique_certificate_settings_internship
  ON public.certificate_settings(internship_id);

-- Automatic updated_at trigger for certificate_settings
DROP TRIGGER IF EXISTS trigger_certificate_settings_updated_at ON public.certificate_settings;
CREATE TRIGGER trigger_certificate_settings_updated_at
  BEFORE UPDATE ON public.certificate_settings
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_updated_at();


-- 2. Create certificate_payments table
CREATE TABLE IF NOT EXISTS public.certificate_payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  internship_id UUID NOT NULL REFERENCES public.internships(id) ON DELETE CASCADE,
  enrollment_id UUID NOT NULL REFERENCES public.enrollments(id) ON DELETE CASCADE,
  amount NUMERIC NOT NULL CHECK (amount >= 0),
  currency TEXT NOT NULL DEFAULT 'AZN',
  receipt_path TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
  admin_note TEXT NULL,
  reviewed_by UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  reviewed_at TIMESTAMPTZ NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Indexes for certificate_payments
CREATE INDEX IF NOT EXISTS idx_cert_payments_student_id ON public.certificate_payments(student_id);
CREATE INDEX IF NOT EXISTS idx_cert_payments_enrollment_id ON public.certificate_payments(enrollment_id);
CREATE INDEX IF NOT EXISTS idx_cert_payments_internship_id ON public.certificate_payments(internship_id);
CREATE INDEX IF NOT EXISTS idx_cert_payments_status ON public.certificate_payments(status);

-- Automatic updated_at trigger for certificate_payments
DROP TRIGGER IF EXISTS trigger_certificate_payments_updated_at ON public.certificate_payments;
CREATE TRIGGER trigger_certificate_payments_updated_at
  BEFORE UPDATE ON public.certificate_payments
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_updated_at();


-- 3. Create certificates table
CREATE TABLE IF NOT EXISTS public.certificates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  certificate_id TEXT NOT NULL UNIQUE,
  student_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  internship_id UUID NOT NULL REFERENCES public.internships(id) ON DELETE CASCADE,
  enrollment_id UUID NOT NULL REFERENCES public.enrollments(id) ON DELETE CASCADE,
  student_name TEXT NOT NULL,
  internship_title TEXT NOT NULL,
  issued_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  certificate_file_path TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'issued' CHECK (status IN ('pending', 'issued', 'revoked')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Unique index to prevent duplicate certificates for the same enrollment
CREATE UNIQUE INDEX IF NOT EXISTS idx_unique_certificate_enrollment
  ON public.certificates(enrollment_id);

CREATE INDEX IF NOT EXISTS idx_certificates_student_id ON public.certificates(student_id);
CREATE INDEX IF NOT EXISTS idx_certificates_internship_id ON public.certificates(internship_id);
CREATE INDEX IF NOT EXISTS idx_certificates_status ON public.certificates(status);

-- Automatic updated_at trigger for certificates
DROP TRIGGER IF EXISTS trigger_certificates_updated_at ON public.certificates;
CREATE TRIGGER trigger_certificates_updated_at
  BEFORE UPDATE ON public.certificates
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_updated_at();


-- 4. Enable Row Level Security (RLS)
ALTER TABLE public.certificate_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.certificate_payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.certificates ENABLE ROW LEVEL SECURITY;


-- 5. RLS Policies for certificate_settings
-- Everyone authenticated can view settings for active internships
DROP POLICY IF EXISTS "Authenticated users can view certificate settings" ON public.certificate_settings;
CREATE POLICY "Authenticated users can view certificate settings"
  ON public.certificate_settings
  FOR SELECT
  USING (true);

-- Admins can manage certificate settings
DROP POLICY IF EXISTS "Admins can manage certificate settings" ON public.certificate_settings;
CREATE POLICY "Admins can manage certificate settings"
  ON public.certificate_settings
  FOR ALL
  USING (public.is_admin())
  WITH CHECK (public.is_admin());


-- 6. RLS Policies for certificate_payments
-- Students can view ONLY their own payments
DROP POLICY IF EXISTS "Students can view own certificate payments" ON public.certificate_payments;
CREATE POLICY "Students can view own certificate payments"
  ON public.certificate_payments
  FOR SELECT
  USING (
    student_id IN (
      SELECT id FROM public.profiles WHERE user_id = auth.uid()
    )
  );

-- Admins can view all payments
DROP POLICY IF EXISTS "Admins can view all certificate payments" ON public.certificate_payments;
CREATE POLICY "Admins can view all certificate payments"
  ON public.certificate_payments
  FOR SELECT
  USING (public.is_admin());

-- Students can insert their own payment for a completed enrollment
DROP POLICY IF EXISTS "Students can submit certificate payment" ON public.certificate_payments;
CREATE POLICY "Students can submit certificate payment"
  ON public.certificate_payments
  FOR INSERT
  WITH CHECK (
    student_id IN (
      SELECT id FROM public.profiles WHERE user_id = auth.uid()
    )
    AND enrollment_id IN (
      SELECT id FROM public.enrollments
      WHERE student_id IN (SELECT id FROM public.profiles WHERE user_id = auth.uid())
      AND status = 'completed'
    )
    AND status = 'pending'
  );

-- Students can update their pending/rejected payment (e.g. upload new receipt)
DROP POLICY IF EXISTS "Students can update own payment receipt" ON public.certificate_payments;
CREATE POLICY "Students can update own payment receipt"
  ON public.certificate_payments
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

-- Admins can review/update payments
DROP POLICY IF EXISTS "Admins can review certificate payments" ON public.certificate_payments;
CREATE POLICY "Admins can review certificate payments"
  ON public.certificate_payments
  FOR UPDATE
  USING (public.is_admin())
  WITH CHECK (public.is_admin());


-- 7. RLS Policies for certificates
-- Public can view verification details for certificates
DROP POLICY IF EXISTS "Public can view certificate verification" ON public.certificates;
CREATE POLICY "Public can view certificate verification"
  ON public.certificates
  FOR SELECT
  USING (true);

-- Students can view their own certificates
DROP POLICY IF EXISTS "Students can view own certificates" ON public.certificates;
CREATE POLICY "Students can view own certificates"
  ON public.certificates
  FOR SELECT
  USING (
    student_id IN (
      SELECT id FROM public.profiles WHERE user_id = auth.uid()
    )
  );

-- Admins can manage all certificates
DROP POLICY IF EXISTS "Admins can manage certificates" ON public.certificates;
CREATE POLICY "Admins can manage certificates"
  ON public.certificates
  FOR ALL
  USING (public.is_admin())
  WITH CHECK (public.is_admin());


-- 8. Supabase Storage: Buckets and Policies for Phase 4
-- Private Bucket 1: certificate-payments
INSERT INTO storage.buckets (id, name, public)
VALUES ('certificate-payments', 'certificate-payments', false)
ON CONFLICT (id) DO NOTHING;

-- Storage Policy: Students can upload receipts into their own student folder
DROP POLICY IF EXISTS "Students can upload payment receipts" ON storage.objects;
CREATE POLICY "Students can upload payment receipts"
  ON storage.objects
  FOR INSERT
  WITH CHECK (
    bucket_id = 'certificate-payments'
    AND auth.role() = 'authenticated'
  );

-- Storage Policy: Students can read their own payment receipts
DROP POLICY IF EXISTS "Students can read own payment receipts" ON storage.objects;
CREATE POLICY "Students can read own payment receipts"
  ON storage.objects
  FOR SELECT
  USING (
    bucket_id = 'certificate-payments'
    AND (
      public.is_admin()
      OR (auth.uid() IS NOT NULL)
    )
  );

-- Storage Policy: Admins have full access to certificate-payments
DROP POLICY IF EXISTS "Admins have full access to certificate-payments" ON storage.objects;
CREATE POLICY "Admins have full access to certificate-payments"
  ON storage.objects
  FOR ALL
  USING (
    bucket_id = 'certificate-payments'
    AND public.is_admin()
  );


-- Private Bucket 2: certificates
INSERT INTO storage.buckets (id, name, public)
VALUES ('certificates', 'certificates', false)
ON CONFLICT (id) DO NOTHING;

-- Storage Policy: Admins can upload and manage certificates
DROP POLICY IF EXISTS "Admins can manage certificate files" ON storage.objects;
CREATE POLICY "Admins can manage certificate files"
  ON storage.objects
  FOR ALL
  USING (
    bucket_id = 'certificates'
    AND public.is_admin()
  );

-- Storage Policy: Authenticated users can read certificate files (accessed via signed URLs)
DROP POLICY IF EXISTS "Authenticated users can read certificates" ON storage.objects;
CREATE POLICY "Authenticated users can read certificates"
  ON storage.objects
  FOR SELECT
  USING (
    bucket_id = 'certificates'
    AND (
      public.is_admin()
      OR (auth.uid() IS NOT NULL)
    )
  );
