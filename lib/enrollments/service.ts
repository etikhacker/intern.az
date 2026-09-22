import { createClient } from '@/lib/supabase/client';
import { isSupabaseConfigured } from '@/lib/supabase/config';
import { Enrollment } from '@/types/database';

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
  if (!isSupabaseConfigured()) {
    return { success: false, error: 'Verilənlər bazası konfiqurasiya edilməyib.' };
  }

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
}

// Get student enrollments
export async function getStudentEnrollments(studentId: string): Promise<Enrollment[]> {
  if (!studentId || !isSupabaseConfigured()) return [];

  const supabase = createClient();
  if (!supabase) return [];

  try {
    const { data, error } = await supabase
      .from('enrollments')
      .select(`
        *,
        internship:internships(*)
      `)
      .eq('student_id', studentId)
      .order('created_at', { ascending: false });

    if (error || !data) return [];
    return data as Enrollment[];
  } catch (err) {
    console.warn('Exception in getStudentEnrollments:', err);
    return [];
  }
}

// Get student's active enrollment (if any)
export async function getStudentActiveEnrollment(studentId: string): Promise<Enrollment | null> {
  const list = await getStudentEnrollments(studentId);
  const active = list.find((e) => e.status === 'active');
  return active || null;
}

// Count active enrollments for an internship
export async function getInternshipActiveEnrollmentsCount(internshipId: string): Promise<number> {
  if (!internshipId || !isSupabaseConfigured()) return 0;

  const supabase = createClient();
  if (!supabase) return 0;

  try {
    const { count, error } = await supabase
      .from('enrollments')
      .select('*', { count: 'exact', head: true })
      .eq('internship_id', internshipId)
      .eq('status', 'active');

    if (!error && count !== null) {
      return count;
    }
    return 0;
  } catch (err) {
    console.warn('Exception in getInternshipActiveEnrollmentsCount:', err);
    return 0;
  }
}

// Get all enrollments count for admin stats
export async function getTotalActiveEnrollmentsCount(): Promise<number> {
  if (!isSupabaseConfigured()) return 0;

  const supabase = createClient();
  if (!supabase) return 0;

  try {
    const { count, error } = await supabase
      .from('enrollments')
      .select('*', { count: 'exact', head: true })
      .eq('status', 'active');

    if (!error && count !== null) {
      return count;
    }
    return 0;
  } catch (err) {
    console.warn('Exception in getTotalActiveEnrollmentsCount:', err);
    return 0;
  }
}

// Mark an enrollment explicitly as completed (Admin or system action)
export async function completeEnrollment({
  enrollmentId,
}: {
  enrollmentId: string;
}): Promise<{ success: boolean; error?: string; enrollment?: Enrollment }> {
  if (!isSupabaseConfigured()) {
    return { success: false, error: 'Verilənlər bazası konfiqurasiya edilməyib.' };
  }

  const supabase = createClient();
  if (!supabase) return { success: false, error: 'Verilənlər bazası əlçatan deyil.' };

  try {
    const { data, error } = await supabase
      .from('enrollments')
      .update({
        status: 'completed',
        completed_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
      })
      .eq('id', enrollmentId)
      .select('*, internship:internships(*)')
      .single();

    if (error) {
      return { success: false, error: error.message };
    }

    return { success: true, enrollment: data as Enrollment };
  } catch (err: unknown) {
    const msg = err instanceof Error ? err.message : 'Təcrübə proqramı tamamlanarkən xəta baş verdi.';
    return { success: false, error: msg };
  }
}

// Check and complete enrollment when all required tasks are approved
export async function checkAndUpdateEnrollmentCompletion(
  enrollmentId: string
): Promise<{ completed: boolean; error?: string }> {
  if (!isSupabaseConfigured()) {
    return { completed: false, error: 'Verilənlər bazası konfiqurasiya edilməyib.' };
  }

  const supabase = createClient();
  if (!supabase) return { completed: false, error: 'Verilənlər bazası əlçatan deyil.' };

  try {
    // Try calling the secure database RPC first
    const { data, error } = await supabase.rpc('check_and_complete_enrollment', {
      p_enrollment_id: enrollmentId,
    });

    if (!error && data) {
      const parsed = typeof data === 'string' ? JSON.parse(data) : data;
      return { completed: !!parsed.completed || !!parsed.already_completed };
    }
    return { completed: false };
  } catch (err: unknown) {
    const msg = err instanceof Error ? err.message : 'Xəta baş verdi.';
    return { completed: false, error: msg };
  }
}
