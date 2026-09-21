import { createClient } from '@/lib/supabase/client';
import { isSupabaseConfigured } from '@/lib/supabase/config';
import { Application, ApplicationStatus, Profile } from '@/types/database';
import { ApplicationFormData } from '@/lib/validations/application';
import { getInternshipById } from '@/lib/internships/service';
import { createEnrollment, getInternshipActiveEnrollmentsCount } from '@/lib/enrollments/service';

const DEMO_APPLICATIONS_KEY = 'internship_az_demo_applications';

export function getLocalApplications(): Application[] {
  if (typeof window === 'undefined') return [];
  try {
    const stored = localStorage.getItem(DEMO_APPLICATIONS_KEY);
    if (stored) {
      const parsed = JSON.parse(stored);
      if (Array.isArray(parsed)) return parsed;
    }
    return [];
  } catch {
    return [];
  }
}

export function saveLocalApplications(applications: Application[]) {
  if (typeof window === 'undefined') return;
  try {
    localStorage.setItem(DEMO_APPLICATIONS_KEY, JSON.stringify(applications));
  } catch {
    // ignore
  }
}

// Submit Application
export async function submitApplication({
  internshipId,
  studentProfile,
  data,
}: {
  internshipId: string;
  studentProfile: Profile;
  data: ApplicationFormData;
}): Promise<{ success: boolean; error?: string; application?: Application }> {
  // 1. Fetch internship to verify eligibility, status, and deadline
  const internship = await getInternshipById(internshipId);
  if (!internship) {
    return { success: false, error: 'Təcrübə proqramı tapılmadı.' };
  }

  if (internship.status !== 'published') {
    return { success: false, error: 'Müraciətlər bağlıdır.' };
  }

  if (internship.application_deadline) {
    const deadline = new Date(internship.application_deadline).getTime();
    if (Date.now() > deadline) {
      return { success: false, error: 'Müraciət müddəti başa çatıb.' };
    }
  }

  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (!supabase) return { success: false, error: 'Verilənlər bazası ilə əlaqə qurulmadı.' };

    try {
      // Check if student already submitted an active application
      const { data: existingApp } = await supabase
        .from('applications')
        .select('id, status')
        .eq('internship_id', internshipId)
        .eq('student_id', studentProfile.id)
        .in('status', ['pending', 'accepted'])
        .maybeSingle();

      if (existingApp) {
        return { success: false, error: 'Bu proqrama artıq müraciət etmisiniz.' };
      }

      const { data: inserted, error: insertError } = await supabase
        .from('applications')
        .insert({
          internship_id: internshipId,
          student_id: studentProfile.id,
          motivation: data.motivation,
          experience: data.experience || null,
          portfolio_url: data.portfolio_url || null,
          github_url: data.github_url || null,
          linkedin_url: data.linkedin_url || null,
          status: 'pending',
        })
        .select()
        .single();

      if (insertError) {
        return { success: false, error: insertError.message };
      }

      return { success: true, application: inserted as Application };
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : 'Müraciət göndərilərkən xəta baş verdi.';
      return { success: false, error: message };
    }
  } else {
    // Demo Mode
    const applications = getLocalApplications();
    const alreadyApplied = applications.some(
      (app) =>
        app.internship_id === internshipId &&
        app.student_id === studentProfile.id &&
        (app.status === 'pending' || app.status === 'accepted')
    );

    if (alreadyApplied) {
      return { success: false, error: 'Bu proqrama artıq müraciət etmisiniz.' };
    }

    const newApp: Application = {
      id: `app-${Date.now()}`,
      internship_id: internshipId,
      student_id: studentProfile.id,
      motivation: data.motivation,
      experience: data.experience || null,
      portfolio_url: data.portfolio_url || null,
      github_url: data.github_url || null,
      linkedin_url: data.linkedin_url || null,
      status: 'pending',
      admin_note: null,
      reviewed_by: null,
      reviewed_at: null,
      created_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
      internship,
      student: studentProfile,
    };

    saveLocalApplications([newApp, ...applications]);
    return { success: true, application: newApp };
  }
}

// Student: Get their applications
export async function getStudentApplications(studentId: string): Promise<Application[]> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        const { data, error } = await supabase
          .from('applications')
          .select(`
            *,
            internship:internships(*)
          `)
          .eq('student_id', studentId)
          .order('created_at', { ascending: false });

        if (!error && data) {
          return data as Application[];
        }
      } catch (err) {
        console.warn('Failed to fetch student applications from Supabase:', err);
      }
    }
  }

  // Demo fallback
  const all = getLocalApplications();
  const studentApps = all.filter((a) => a.student_id === studentId);

  // Attach fresh internship object if needed
  for (const app of studentApps) {
    if (!app.internship) {
      const intern = await getInternshipById(app.internship_id);
      if (intern) app.internship = intern;
    }
  }

  return studentApps.sort((a, b) => new Date(b.created_at).getTime() - new Date(a.created_at).getTime());
}

// Admin: Get all applications with search and filters
export async function getAllApplications(filters?: {
  internshipId?: string;
  status?: ApplicationStatus | 'all';
  search?: string;
}): Promise<Application[]> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        let query = supabase.from('applications').select(`
          *,
          internship:internships(*),
          student:profiles(*)
        `).order('created_at', { ascending: false });

        if (filters?.internshipId && filters.internshipId !== 'all') {
          query = query.eq('internship_id', filters.internshipId);
        }

        if (filters?.status && filters.status !== 'all') {
          query = query.eq('status', filters.status);
        }

        const { data, error } = await query;
        if (!error && data) {
          let list = data as Application[];
          if (filters?.search) {
            const s = filters.search.toLowerCase();
            list = list.filter(
              (item) =>
                item.student?.full_name?.toLowerCase().includes(s) ||
                item.student?.email?.toLowerCase().includes(s) ||
                item.student?.university?.toLowerCase().includes(s)
            );
          }
          return list;
        }
      } catch (err) {
        console.warn('Failed to fetch all applications from Supabase:', err);
      }
    }
  }

  // Demo fallback
  let all = getLocalApplications();

  // Attach joined records
  const storedProfiles = typeof window !== 'undefined' ? localStorage.getItem('internship_az_demo_profiles') : null;
  const profiles: Profile[] = storedProfiles ? JSON.parse(storedProfiles) : [];

  for (const app of all) {
    if (!app.internship) {
      const intern = await getInternshipById(app.internship_id);
      if (intern) app.internship = intern;
    }
    if (!app.student) {
      const prof = profiles.find((p) => p.id === app.student_id);
      if (prof) app.student = prof;
    }
  }

  if (filters?.internshipId && filters.internshipId !== 'all') {
    all = all.filter((a) => a.internship_id === filters.internshipId);
  }

  if (filters?.status && filters.status !== 'all') {
    all = all.filter((a) => a.status === filters.status);
  }

  if (filters?.search) {
    const s = filters.search.toLowerCase();
    all = all.filter(
      (item) =>
        item.student?.full_name?.toLowerCase().includes(s) ||
        item.student?.email?.toLowerCase().includes(s) ||
        item.student?.university?.toLowerCase().includes(s)
    );
  }

  return all.sort((a, b) => new Date(b.created_at).getTime() - new Date(a.created_at).getTime());
}

// Get single application by ID
export async function getApplicationById(id: string): Promise<Application | null> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        const { data, error } = await supabase
          .from('applications')
          .select(`
            *,
            internship:internships(*),
            student:profiles(*)
          `)
          .eq('id', id)
          .single();

        if (!error && data) {
          return data as Application;
        }
      } catch (err) {
        console.warn('Failed to fetch application by id from Supabase:', err);
      }
    }
  }

  // Demo fallback
  const all = getLocalApplications();
  const app = all.find((a) => a.id === id);
  if (!app) return null;

  if (!app.internship) {
    const intern = await getInternshipById(app.internship_id);
    if (intern) app.internship = intern;
  }

  if (!app.student && typeof window !== 'undefined') {
    const stored = localStorage.getItem('internship_az_demo_profiles');
    if (stored) {
      const profiles: Profile[] = JSON.parse(stored);
      const prof = profiles.find((p) => p.id === app.student_id);
      if (prof) app.student = prof;
    }
  }

  return app;
}

// Admin Review: Accept or Reject
export async function reviewApplication({
  applicationId,
  action,
  adminNote,
  adminProfile,
}: {
  applicationId: string;
  action: 'accept' | 'reject';
  adminNote?: string;
  adminProfile: Profile;
}): Promise<{ success: boolean; error?: string }> {
  // 1. Fetch current application
  const app = await getApplicationById(applicationId);
  if (!app) {
    return { success: false, error: 'Müraciət tapılmadı.' };
  }

  // 2. Fetch internship
  const internship = await getInternshipById(app.internship_id);
  if (!internship) {
    return { success: false, error: 'Müvafiq təcrübə proqramı tapılmadı.' };
  }

  // 3. If action is 'accept', verify maximum student capacity
  if (action === 'accept') {
    if (internship.max_students !== null && internship.max_students > 0) {
      const currentActiveCount = await getInternshipActiveEnrollmentsCount(internship.id);
      if (currentActiveCount >= internship.max_students) {
        return {
          success: false,
          error: 'Bu təcrübə proqramında boş yer qalmayıb.',
        };
      }
    }
  }

  const isConfigured = isSupabaseConfigured();
  const newStatus: ApplicationStatus = action === 'accept' ? 'accepted' : 'rejected';
  const now = new Date().toISOString();

  if (isConfigured) {
    const supabase = createClient();
    if (!supabase) return { success: false, error: 'Verilənlər bazası əlçatan deyil.' };

    try {
      // Update application
      const { error: updateError } = await supabase
        .from('applications')
        .update({
          status: newStatus,
          admin_note: adminNote?.trim() || null,
          reviewed_by: adminProfile.user_id,
          reviewed_at: now,
          updated_at: now,
        })
        .eq('id', applicationId);

      if (updateError) {
        return { success: false, error: updateError.message };
      }

      // If accepted, create enrollment
      if (action === 'accept') {
        const enrollResult = await createEnrollment({
          internshipId: app.internship_id,
          studentId: app.student_id,
          applicationId: app.id,
        });

        if (!enrollResult.success) {
          // Revert or report
          return { success: false, error: enrollResult.error };
        }
      }

      return { success: true };
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : 'Qərar tətbiq edilərkən xəta baş verdi.';
      return { success: false, error: message };
    }
  } else {
    // Demo Mode
    const all = getLocalApplications();
    const index = all.findIndex((a) => a.id === applicationId);
    if (index === -1) {
      return { success: false, error: 'Müraciət tapılmadı.' };
    }

    all[index] = {
      ...all[index],
      status: newStatus,
      admin_note: adminNote?.trim() || null,
      reviewed_by: adminProfile.user_id,
      reviewed_at: now,
      updated_at: now,
    };
    saveLocalApplications(all);

    // If accepted, create demo enrollment
    if (action === 'accept') {
      const enrollResult = await createEnrollment({
        internshipId: app.internship_id,
        studentId: app.student_id,
        applicationId: app.id,
      });

      if (!enrollResult.success) {
        return { success: false, error: enrollResult.error };
      }
    }

    return { success: true };
  }
}

// Student: Withdraw pending application
export async function withdrawApplication(
  applicationId: string,
  studentId: string
): Promise<{ success: boolean; error?: string }> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (!supabase) return { success: false, error: 'Verilənlər bazası əlçatan deyil.' };

    try {
      const { error } = await supabase
        .from('applications')
        .update({
          status: 'withdrawn',
          updated_at: new Date().toISOString(),
        })
        .eq('id', applicationId)
        .eq('student_id', studentId)
        .eq('status', 'pending');

      if (error) {
        return { success: false, error: error.message };
      }
      return { success: true };
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : 'Xəta baş verdi.';
      return { success: false, error: message };
    }
  } else {
    const all = getLocalApplications();
    const target = all.find((a) => a.id === applicationId && a.student_id === studentId);
    if (!target) {
      return { success: false, error: 'Müraciət tapılmadı.' };
    }
    if (target.status !== 'pending') {
      return { success: false, error: 'Yalnız gözləmədə olan müraciətlər geri çəkilə bilər.' };
    }

    target.status = 'withdrawn';
    target.updated_at = new Date().toISOString();
    saveLocalApplications(all);
    return { success: true };
  }
}
