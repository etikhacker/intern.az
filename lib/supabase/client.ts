import { createBrowserClient } from '@supabase/ssr';
import { getSupabasePublicKey, getSupabaseUrl, isSupabaseConfigured } from './config';

let browserClient: ReturnType<typeof createBrowserClient> | null = null;

export function createClient() {
  if (!isSupabaseConfigured()) {
    // Return null or dummy client if not configured yet
    return null;
  }

  if (!browserClient) {
    browserClient = createBrowserClient(
      getSupabaseUrl()!,
      getSupabasePublicKey()!
    );
  }

  return browserClient;
}
