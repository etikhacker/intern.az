import { NextResponse } from 'next/server';
import { createClient as createServerClient } from '@/lib/supabase/server';

export const dynamic = 'force-dynamic';

export async function GET() {
  const supabase = await createServerClient();

  if (!supabase) {
    return NextResponse.json({ error: 'Supabase is not configured.' }, { status: 503 });
  }

  const { data, error } = await supabase
    .from('internships')
    .select('*')
    .eq('status', 'published')
    .order('created_at', { ascending: false });

  if (error) {
    console.error('Failed to fetch public internships:', error.message);
    return NextResponse.json({ error: 'Failed to load internships.' }, { status: 500 });
  }

  return NextResponse.json(data ?? [], {
    headers: {
      'Cache-Control': 'no-store',
    },
  });
}
