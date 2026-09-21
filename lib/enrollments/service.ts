import { createClient } from '@/lib/supabase/client';
import { isSupabaseConfigured } from '@/lib/supabase/config';
import { Enrollment, Profile } from '@/types/database';
import { getInternshipById } from '@/lib/internships/service';

const DEMO_ENROLLMENTS_KEY = 'internship_az_demo_enrollments';

export function getLocalEnrollments(): Enrollment[] {
  if (typeof window === 'undefined') return [];
  try {
    const stored = localStorage.getItem(DEMO_ENROLLMENTS_KEY);
    if (stored) {
      const parsed = JSON.parse(stored);
      if (Array.isArray(parsed)) return parsed;
    }
    return [];
  } catch {
    return [];
  }
}

export function saveLocalEnrollments(enrollments: Enrollment[]) {
  if (typeof window === 'undefined') return;
  try {
    localStorage.setItem(DEMO_ENROLLMENTS_KEY, JSON.stringify(enrollments));
  } catch {
    // ignore
  }
}

// Create enrollment upon accepting an application
export async function createEnrollment({
  internshipId,
  studentId,
  applicationId,
}: {
  internshipId: string;
  studentId: string;
  applicationId?: string;
}): Promise<{ success: boolean; error?: string; enrollment?: Enrollment }> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (!supabase) return { success: false, error: 'Verilənlər bazası əlçatan deyil.' };

    try {
      // Check if already enrolled
      const { data: existing } = await supabase
        .from('enrollments')
        .select('id')
        .eq('internship_id', internshipId)
        .eq('student_id', studentId)
        .maybeSingle();

      if (existing) {
        return { success: true }; // already enrolled
      }

      const { data: inserted, error } = await supabase
        .from('enrollments')
        .insert({
          internship_id: internshipId,
          student_id: studentId,
          application_id: applicationId || null,
          status: 'active',
        })
        .select()
        .single();

      if (error) {
        return { success: false, error: error.message };
      }

      return { success: true, enrollment: inserted as Enrollment };
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : 'Təcrübəçi qeydiyyatı aparılarkən xəta baş verdi.';
      return { success: false, error: message };
    }
  } else {
    // Demo Mode
    const enrollments = getLocalEnrollments();
    const existing = enrollments.find(
      (e) => e.internship_id === internshipId && e.student_id === studentId
    );

    if (existing) {
      return { success: true, enrollment: existing };
    }

    const internship = await getInternshipById(internshipId);

    const newEnrollment: Enrollment = {
      id: `enroll-${Date.now()}`,
      internship_id: internshipId,
      student_id: studentId,
      application_id: applicationId || null,
      status: 'active',
      enrolled_at: new Date().toISOString(),
      completed_at: null,
      created_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
      internship: internship || undefined,
    };

    saveLocalEnrollments([newEnrollment, ...enrollments]);
    return { success: true, enrollment: newEnrollment };
  }
}

// Get student enrollments
export async function getStudentEnrollments(studentId: string): Promise<Enrollment[]> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        const { data, error } = await supabase
          .from('enrollments')
          .select(`
            *,
            internship:internships(*)
          `)
          .eq('student_id', studentId)
          .order('created_at', { ascending: false });

        if (!error && data) {
          return data as Enrollment[];
        }
      } catch (err) {
        console.warn('Failed to fetch student enrollments from Supabase:', err);
      }
    }
  }

  // Demo fallback
  const enrollments = getLocalEnrollments();
  const studentEnrollments = enrollments.filter((e) => e.student_id === studentId);

  for (const en of studentEnrollments) {
    if (!en.internship) {
      const intern = await getInternshipById(en.internship_id);
      if (intern) en.internship = intern;
    }
  }

  return studentEnrollments;
}

// Get student's active enrollment (if any)
export async function getStudentActiveEnrollment(studentId: string): Promise<Enrollment | null> {
  const list = await getStudentEnrollments(studentId);
  const active = list.find((e) => e.status === 'active');
  return active || null;
}

// Count active enrollments for an internship
export async function getInternshipActiveEnrollmentsCount(internshipId: string): Promise<number> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        const { count, error } = await supabase
          .from('enrollments')
          .select('*', { count: 'exact', head: true })
          .eq('internship_id', internshipId)
          .eq('status', 'active');

        if (!error && count !== null) {
          return count;
        }
      } catch (err) {
        console.warn('Failed to count active enrollments from Supabase:', err);
      }
    }
  }

  // Demo fallback
  const enrollments = getLocalEnrollments();
  return enrollments.filter((e) => e.internship_id === internshipId && e.status === 'active').length;
}

// Get all enrollments count for admin stats
export async function getTotalActiveEnrollmentsCount(): Promise<number> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        const { count, error } = await supabase
          .from('enrollments')
          .select('*', { count: 'exact', head: true })
          .eq('status', 'active');

        if (!error && count !== null) {
          return count;
        }
      } catch (err) {
        console.warn('Failed to count total active enrollments:', err);
      }
    }
  }

  const enrollments = getLocalEnrollments();
  return enrollments.filter((e) => e.status === 'active').length;
}
