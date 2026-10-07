import { NextResponse } from 'next/server';
import { createAdminClient } from '@/lib/supabase/server';

export const dynamic = 'force-dynamic';

export async function GET(request: Request) {
  const authHeader = request.headers.get('authorization');
  const cronSecret = process.env.CRON_SECRET;

  if (!cronSecret || authHeader !== `Bearer ${cronSecret}`) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  }

  const supabase = await createAdminClient();
  if (!supabase) {
    return NextResponse.json({ error: 'Admin Supabase client is not configured.' }, { status: 503 });
  }

  const { data, error } = await supabase.rpc('process_internship_deadlines');
  if (error) {
    console.error('Deadline processing failed:', error.message);
    return NextResponse.json({ error: 'Deadline processing failed.' }, { status: 500 });
  }

  return NextResponse.json({ ok: true, ...((data as Record<string, unknown>) || {}) });
}
