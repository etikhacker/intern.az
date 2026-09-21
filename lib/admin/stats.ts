import { createClient } from '@/lib/supabase/client';
import { isSupabaseConfigured } from '@/lib/supabase/config';
import { AdminStats } from '@/types/database';
import { getPublishedInternships } from '@/lib/internships/service';
import { getLocalApplications } from '@/lib/applications/service';
import { getTotalActiveEnrollmentsCount, getLocalEnrollments } from '@/lib/enrollments/service';
import { getLocalSubmissions } from '@/lib/submissions/service';

export async function getAdminStats(): Promise<AdminStats> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        const [
          { count: studentCount },
          { count: internshipCount },
          { count: appCount },
          { count: internCount },
          { count: pendingSubCount },
        ] = await Promise.all([
          supabase.from('profiles').select('*', { count: 'exact', head: true }).eq('role', 'student'),
          supabase.from('internships').select('*', { count: 'exact', head: true }).eq('status', 'published'),
          supabase.from('applications').select('*', { count: 'exact', head: true }).eq('status', 'pending'),
          supabase.from('enrollments').select('*', { count: 'exact', head: true }).eq('status', 'active'),
          supabase.from('task_submissions').select('*', { count: 'exact', head: true }).eq('status', 'pending'),
        ]);

        return {
          totalStudents: studentCount ?? 0,
          activeInternships: internshipCount ?? 0,
          pendingApplications: appCount ?? 0,
          activeInterns: internCount ?? 0,
          pendingSubmissions: pendingSubCount ?? 0,
          completedInternships: 0,
          pendingCertificatePayments: 0,
          certificatesIssued: 0,
        };
      } catch (err) {
        console.warn('Failed to fetch admin stats from Supabase:', err);
      }
    }
  }

  // Fallback count in demo mode
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

  const published = await getPublishedInternships();
  const applications = getLocalApplications();
  const pendingApps = applications.filter((a) => a.status === 'pending').length;
  const enrollments = getLocalEnrollments();
  const activeInterns = enrollments.filter((e) => e.status === 'active').length;
  const submissions = getLocalSubmissions();
  const pendingSubs = submissions.filter((s) => s.status === 'pending').length;

  return {
    totalStudents: studentCount,
    activeInternships: published.length,
    pendingApplications: pendingApps,
    activeInterns: activeInterns,
    pendingSubmissions: pendingSubs,
    completedInternships: 0,
    pendingCertificatePayments: 0,
    certificatesIssued: 0,
  };
}
