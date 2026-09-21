import { createClient } from '@/lib/supabase/client';
import { isSupabaseConfigured } from '@/lib/supabase/config';
import { AdminStats } from '@/types/database';

export async function getAdminStats(): Promise<AdminStats> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        const { count, error } = await supabase
          .from('profiles')
          .select('*', { count: 'exact', head: true })
          .eq('role', 'student');

        if (!error && count !== null) {
          return {
            totalStudents: count,
            activeInternships: 0,
            pendingApplications: 0,
            activeInterns: 0,
            pendingSubmissions: 0,
            completedInternships: 0,
            pendingCertificatePayments: 0,
            certificatesIssued: 0,
          };
        }
      } catch (err) {
        console.warn('Failed to fetch count from Supabase:', err);
      }
    }
  }

  // Fallback count in demo mode or if Supabase query fails
  let studentCount = 3;
  if (typeof window !== 'undefined') {
    try {
      const stored = localStorage.getItem('internship_az_demo_profiles');
      if (stored) {
        const parsed = JSON.parse(stored);
        if (Array.isArray(parsed)) {
          studentCount = parsed.filter((p: { role: string }) => p.role === 'student').length;
        }
      }
    } catch {
      // ignore
    }
  }

  return {
    totalStudents: studentCount,
    activeInternships: 0,
    pendingApplications: 0,
    activeInterns: 0,
    pendingSubmissions: 0,
    completedInternships: 0,
    pendingCertificatePayments: 0,
    certificatesIssued: 0,
  };
}
