CREATE TABLE IF NOT EXISTS public.platform_settings (
  key TEXT PRIMARY KEY CHECK (key IN ('platform_name', 'support_email', 'contact_phone', 'certificate_price')),
  value TEXT NOT NULL,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

INSERT INTO public.platform_settings (key, value)
VALUES
  ('platform_name', 'Intern.az'),
  ('support_email', 'babayev.omr.23@gmail.com'),
  ('contact_phone', '+994 70 644 92 22'),
  ('certificate_price', '15 AZN')
ON CONFLICT (key) DO NOTHING;

ALTER TABLE public.platform_settings ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Admins can read platform settings" ON public.platform_settings;
CREATE POLICY "Admins can read platform settings"
  ON public.platform_settings FOR SELECT TO authenticated
  USING (private.is_admin());

DROP POLICY IF EXISTS "Admins can update platform settings" ON public.platform_settings;
CREATE POLICY "Admins can update platform settings"
  ON public.platform_settings FOR UPDATE TO authenticated
  USING (private.is_admin())
  WITH CHECK (private.is_admin());

DROP POLICY IF EXISTS "Admins can insert platform settings" ON public.platform_settings;
CREATE POLICY "Admins can insert platform settings"
  ON public.platform_settings FOR INSERT TO authenticated
  WITH CHECK (private.is_admin());

REVOKE ALL ON public.platform_settings FROM anon;
GRANT SELECT, INSERT, UPDATE ON public.platform_settings TO authenticated;
