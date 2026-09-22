import { createBrowserClient } from '@supabase/ssr';
import { isSupabaseConfigured, getSupabasePublicKey } from './config';

let browserClient: ReturnType<typeof createBrowserClient> | null = null;

export function createClient() {
  if (!isSupabaseConfigured()) {
    // Return null or dummy client if not configured yet
    return null;
  }

  if (!browserClient) {
    browserClient = createBrowserClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      getSupabasePublicKey()!
    );
  }

  return browserClient;
}
