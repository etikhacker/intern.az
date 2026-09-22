export function getSupabasePublicKey(): string | undefined {
  return (
    process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY ||
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
  );
}

export function isSupabaseConfigured(): boolean {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const anonKey = getSupabasePublicKey();
  return Boolean(
    url &&
    anonKey &&
    !url.includes('your-project') &&
    url.startsWith('https://') &&
    anonKey !== 'your-anon-key' &&
    anonKey !== 'your-publishable-key'
  );
}
