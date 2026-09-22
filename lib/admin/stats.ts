import { createClient } from '@/lib/supabase/client';
import { isSupabaseConfigured } from '@/lib/supabase/config';
import { AdminStats } from '@/types/database';

export async function getAdminStats(): Promise<AdminStats> {
  const defaultStats: AdminStats = {
    totalStudents: 0,
    activeInternships: 0,
    pendingApplications: 0,
    activeInterns: 0,
    pendingSubmissions: 0,
    completedInternships: 0,
    pendingCertificatePayments: 0,
    certificatesIssued: 0,
  };

  if (!isSupabaseConfigured()) return defaultStats;

  const supabase = createClient();
  if (!supabase) return defaultStats;

  try {
    const [
      { count: studentCount },
      { count: internshipCount },
      { count: appCount },
      { count: internCount },
      { count: pendingSubCount },
      { count: completedEnrollmentsCount },
      { count: pendingCertPayCount },
      { count: certsIssuedCount },
    ] = await Promise.all([
      supabase.from('profiles').select('*', { count: 'exact', head: true }).eq('role', 'student'),
      supabase.from('internships').select('*', { count: 'exact', head: true }).eq('status', 'published'),
      supabase.from('applications').select('*', { count: 'exact', head: true }).eq('status', 'pending'),
      supabase.from('enrollments').select('*', { count: 'exact', head: true }).eq('status', 'active'),
      supabase.from('task_submissions').select('*', { count: 'exact', head: true }).eq('status', 'pending'),
      supabase.from('enrollments').select('*', { count: 'exact', head: true }).eq('status', 'completed'),
      supabase.from('certificate_payments').select('*', { count: 'exact', head: true }).eq('status', 'pending'),
      supabase.from('certificates').select('*', { count: 'exact', head: true }).eq('status', 'issued'),
    ]);

    return {
      totalStudents: studentCount ?? 0,
      activeInternships: internshipCount ?? 0,
      pendingApplications: appCount ?? 0,
      activeInterns: internCount ?? 0,
      pendingSubmissions: pendingSubCount ?? 0,
      completedInternships: completedEnrollmentsCount ?? 0,
      pendingCertificatePayments: pendingCertPayCount ?? 0,
      certificatesIssued: certsIssuedCount ?? 0,
    };
  } catch (err) {
    console.warn('Failed to fetch admin stats from Supabase:', err);
    return defaultStats;
  }
}
