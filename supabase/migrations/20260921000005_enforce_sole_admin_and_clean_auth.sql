-- ==========================================================
-- PHASE 5: SOLE ADMIN ENFORCEMENT & REAL AUTHENTICATION
-- Internship Management Platform (Intern.az)
-- Sole Administrator: babayev.omr.23@gmail.com
-- ==========================================================

-- 1. Helper function: is_admin() strictly checks for babayev.omr.23@gmail.com
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM public.profiles
    WHERE user_id = auth.uid()
      AND role = 'admin'
      AND LOWER(TRIM(email)) = 'babayev.omr.23@gmail.com'
  );
END;
$$;

-- 2. Trigger function: handle_new_user()
-- Automatically grants admin role ONLY to babayev.omr.23@gmail.com
-- All other accounts are strictly granted 'student' role.
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  v_role TEXT := 'student';
BEGIN
  IF LOWER(TRIM(NEW.email)) = 'babayev.omr.23@gmail.com' THEN
    v_role := 'admin';
  ELSE
    v_role := 'student';
  END IF;

  INSERT INTO public.profiles (
    user_id,
    full_name,
    email,
    university,
    role
  )
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', CASE WHEN v_role = 'admin' THEN 'Platform Administrator' ELSE 'Student User' END),
    NEW.email,
    NEW.raw_user_meta_data->>'university',
    v_role
  )
  ON CONFLICT (user_id) DO UPDATE
    SET email = EXCLUDED.email,
        role = v_role,
        updated_at = NOW();

  RETURN NEW;
END;
$$;

-- Recreate trigger on auth.users
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();

-- 3. Trigger function: protect_profile_role()
-- Enforces:
-- a) Only babayev.omr.23@gmail.com can possess or be assigned role = 'admin'
-- b) User cannot change their role, user_id, email, or created_at
CREATE OR REPLACE FUNCTION public.protect_profile_role()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  -- Immutable authorization & identity fields
  NEW.user_id := OLD.user_id;
  NEW.email := OLD.email;
  NEW.created_at := OLD.created_at;

  -- Ensure role cannot be changed by non-admins or set to admin for any other email
  IF OLD.role IS DISTINCT FROM NEW.role THEN
    IF NOT public.is_admin() THEN
      RAISE EXCEPTION 'Unauthorized: Only the platform administrator can alter user roles.';
    END IF;
  END IF;

  -- Strictly forbid any profile other than babayev.omr.23@gmail.com having role = 'admin'
  IF NEW.role = 'admin' AND LOWER(TRIM(NEW.email)) != 'babayev.omr.23@gmail.com' THEN
    NEW.role := 'student';
  END IF;

  -- Always guarantee babayev.omr.23@gmail.com retains role = 'admin'
  IF LOWER(TRIM(NEW.email)) = 'babayev.omr.23@gmail.com' THEN
    NEW.role := 'admin';
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trigger_protect_profile_role ON public.profiles;
CREATE TRIGGER trigger_protect_profile_role
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW
  EXECUTE FUNCTION public.protect_profile_role();

-- 4. Cleanup any existing profile roles in the database:
-- Set babayev.omr.23@gmail.com to admin, and all others to student
UPDATE public.profiles
SET role = 'admin'
WHERE LOWER(TRIM(email)) = 'babayev.omr.23@gmail.com';

UPDATE public.profiles
SET role = 'student'
WHERE LOWER(TRIM(email)) != 'babayev.omr.23@gmail.com';
