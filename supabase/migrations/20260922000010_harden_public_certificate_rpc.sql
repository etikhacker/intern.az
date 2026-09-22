-- Public certificate verification only returns fields intentionally exposed by
-- the public certificates SELECT policy. Run it as the caller so it cannot
-- bypass RLS or become a privilege-escalation boundary.
ALTER FUNCTION public.get_public_certificate(text) SECURITY INVOKER;
REVOKE EXECUTE ON FUNCTION public.get_public_certificate(text) FROM authenticated;
GRANT EXECUTE ON FUNCTION public.get_public_certificate(text) TO anon;

COMMENT ON FUNCTION public.get_public_certificate(text) IS
  'Publicly verifies issued certificates and returns only non-sensitive verification fields.';

NOTIFY pgrst, 'reload schema';
