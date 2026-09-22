import { createServerClient, type CookieOptions } from '@supabase/ssr';
import { cookies } from 'next/headers';
import { isSupabaseConfigured } from './config';

export async function createClient() {
  if (!isSupabaseConfigured()) {
    return null;
  }

  const cookieStore = await cookies();

  return createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    getSupabasePublicKey()!,
    {
      cookies: {
        getAll() {
          return cookieStore.getAll();
        },
        setAll(cookiesToSet) {
          try {
            cookiesToSet.forEach(({ name, value, options }) => {
              cookieStore.set(name, value, options as CookieOptions);
            });
          } catch {
            // The `setAll` method was called from a Server Component.
            // This can be ignored if you have middleware refreshing user sessions.
          }
        },
      },
    }
  );
}

export async function createAdminClient() {
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!isSupabaseConfigured() || !serviceKey || serviceKey === 'your-service-role-key') {
    return null;
  }

  const { createClient: createSupabaseJsClient } = await import('@supabase/supabase-js');
  return createSupabaseJsClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    serviceKey,
    {
      auth: {
        autoRefreshToken: false,
        persistSession: false,
      },
    }
  );
}
