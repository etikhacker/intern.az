import { createClient } from '@/lib/supabase/client';
import { isSupabaseConfigured } from '@/lib/supabase/config';
import { TaskSubmission, SubmissionStatus, Profile } from '@/types/database';
import { DEFAULT_SEED_SUBMISSIONS } from '@/lib/data/seeds';
import { getTaskById, getLocalTasks } from '@/lib/tasks/service';
import { getInternshipById } from '@/lib/internships/service';

const DEMO_SUBMISSIONS_KEY = 'internship_az_demo_submissions';

export function getLocalSubmissions(): TaskSubmission[] {
  if (typeof window === 'undefined') return DEFAULT_SEED_SUBMISSIONS;
  try {
    const stored = localStorage.getItem(DEMO_SUBMISSIONS_KEY);
    if (stored) {
      const parsed = JSON.parse(stored);
      if (Array.isArray(parsed) && parsed.length > 0) return parsed;
    }
    localStorage.setItem(DEMO_SUBMISSIONS_KEY, JSON.stringify(DEFAULT_SEED_SUBMISSIONS));
    return DEFAULT_SEED_SUBMISSIONS;
  } catch {
    return DEFAULT_SEED_SUBMISSIONS;
  }
}

export function saveLocalSubmissions(submissions: TaskSubmission[]) {
  if (typeof window === 'undefined') return;
  try {
    localStorage.setItem(DEMO_SUBMISSIONS_KEY, JSON.stringify(submissions));
  } catch {
    // ignore
  }
}

// Get student's submissions for an internship / enrollment
export async function getStudentSubmissionsForEnrollment(
  studentId: string,
  enrollmentId?: string
): Promise<TaskSubmission[]> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        let query = supabase
          .from('task_submissions')
          .select(`
            *,
            task:internship_tasks(*)
          `)
          .eq('student_id', studentId)
          .order('submitted_at', { ascending: false });

        if (enrollmentId) {
          query = query.eq('enrollment_id', enrollmentId);
        }

        const { data, error } = await query;
        if (!error && data) {
          return data as TaskSubmission[];
        }
      } catch (err) {
        console.warn('Failed to fetch student submissions from Supabase:', err);
      }
    }
  }

  // Demo fallback
  const list = getLocalSubmissions();
  const tasks = getLocalTasks();

  return list
    .filter((s) => s.student_id === studentId && (!enrollmentId || s.enrollment_id === enrollmentId))
    .map((s) => ({
      ...s,
      task: s.task || tasks.find((t) => t.id === s.task_id) || undefined,
    }))
    .sort((a, b) => new Date(b.submitted_at).getTime() - new Date(a.submitted_at).getTime());
}

// Get student's submission for a single task
export async function getStudentSubmissionForTask(
  studentId: string,
  taskId: string
): Promise<TaskSubmission | null> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        const { data, error } = await supabase
          .from('task_submissions')
          .select(`
            *,
            task:internship_tasks(*)
          `)
          .eq('student_id', studentId)
          .eq('task_id', taskId)
          .maybeSingle();

        if (!error && data) {
          return data as TaskSubmission;
        }
      } catch (err) {
        console.warn('Failed to fetch task submission from Supabase:', err);
      }
    }
  }

  // Demo fallback
  const list = getLocalSubmissions();
  const found = list.find((s) => s.student_id === studentId && s.task_id === taskId);
  if (!found) return null;

  if (!found.task) {
    const t = await getTaskById(taskId);
    if (t) found.task = t;
  }

  return found;
}

// Alias with (taskId, studentId) argument order
export async function getSubmissionForTask(
  taskId: string,
  studentId: string
): Promise<TaskSubmission | null> {
  return getStudentSubmissionForTask(studentId, taskId);
}

// Submit or update a task solution
export async function submitTaskSolution({
  taskId,
  studentId,
  enrollmentId,
  textAnswer,
  submissionUrl,
  githubUrl,
  filePath,
  fileName,
  file,
  comment,
}: {
  taskId: string;
  studentId: string;
  enrollmentId: string;
  textAnswer?: string | null;
  submissionUrl?: string | null;
  githubUrl?: string | null;
  filePath?: string | null;
  fileName?: string | null;
  file?: File | null;
  comment?: string | null;
}): Promise<{ success: boolean; error?: string; submission?: TaskSubmission }> {
  let resolvedFilePath = filePath || null;
  let resolvedFileName = fileName || null;

  if (file) {
    const uploadRes = await uploadSubmissionFile(studentId, taskId, file);
    if (!uploadRes.success) {
      return { success: false, error: uploadRes.error || 'Fayl yüklənə bilmədi.' };
    }
    resolvedFilePath = uploadRes.filePath || null;
    resolvedFileName = uploadRes.fileName || null;
  }

  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (!supabase) return { success: false, error: 'Verilənlər bazası əlçatan deyil.' };

    try {
      // Check existing submission
      const { data: existing } = await supabase
        .from('task_submissions')
        .select('id')
        .eq('task_id', taskId)
        .eq('student_id', studentId)
        .maybeSingle();

      const payload = {
        task_id: taskId,
        student_id: studentId,
        enrollment_id: enrollmentId,
        text_answer: textAnswer || null,
        submission_url: submissionUrl || null,
        github_url: githubUrl || null,
        file_path: resolvedFilePath,
        comment: comment || null,
        status: 'pending' as SubmissionStatus,
        admin_feedback: null,
        reviewed_by: null,
        reviewed_at: null,
        submitted_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
      };

      let result;
      if (existing) {
        // Update existing submission (resubmission)
        result = await supabase
          .from('task_submissions')
          .update(payload)
          .eq('id', existing.id)
          .select()
          .single();
      } else {
        // Insert new submission
        result = await supabase
          .from('task_submissions')
          .insert(payload)
          .select()
          .single();
      }

      if (result.error) {
        return { success: false, error: result.error.message };
      }

      return { success: true, submission: result.data as TaskSubmission };
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : 'Tapşırıq təqdim edilərkən xəta baş verdi.';
      return { success: false, error: msg };
    }
  }

  // Demo mode
  const list = getLocalSubmissions();
  const existingIndex = list.findIndex(
    (s) => s.task_id === taskId && s.student_id === studentId
  );

  const task = await getTaskById(taskId);

  const newSub: TaskSubmission = {
    id: existingIndex >= 0 ? list[existingIndex].id : `sub-${Date.now()}`,
    task_id: taskId,
    student_id: studentId,
    enrollment_id: enrollmentId,
    text_answer: textAnswer || null,
    submission_url: submissionUrl || null,
    github_url: githubUrl || null,
    file_path: resolvedFilePath || (existingIndex >= 0 ? list[existingIndex].file_path : null),
    file_name: resolvedFileName || (existingIndex >= 0 ? list[existingIndex].file_name : null),
    comment: comment || null,
    status: 'pending',
    admin_feedback: null,
    reviewed_by: null,
    reviewed_at: null,
    submitted_at: new Date().toISOString(),
    updated_at: new Date().toISOString(),
    task: task || undefined,
  };

  const nextList = [...list];
  if (existingIndex >= 0) {
    nextList[existingIndex] = newSub;
  } else {
    nextList.unshift(newSub);
  }

  saveLocalSubmissions(nextList);
  return { success: true, submission: newSub };
}

// Get all submissions for Admin panel
export async function getAllSubmissions(filter?: {
  status?: string;
  internshipId?: string;
}): Promise<TaskSubmission[]> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        let query = supabase
          .from('task_submissions')
          .select(`
            *,
            task:internship_tasks(*),
            student:profiles!task_submissions_student_id_fkey(*),
            enrollment:enrollments(*)
          `)
          .order('submitted_at', { ascending: false });

        if (filter?.status && filter.status !== 'all') {
          query = query.eq('status', filter.status);
        }

        const { data, error } = await query;
        if (!error && data) {
          // If internship filter requested
          let filtered = data as TaskSubmission[];
          if (filter?.internshipId && filter.internshipId !== 'all') {
            filtered = filtered.filter((s) => s.task?.internship_id === filter.internshipId);
          }
          return filtered;
        }
      } catch (err) {
        console.warn('Failed to fetch admin submissions from Supabase:', err);
      }
    }
  }

  // Demo fallback
  let list = getLocalSubmissions();
  const tasks = getLocalTasks();

  // Attach student profiles if available
  let profiles: Profile[] = [];
  if (typeof window !== 'undefined') {
    try {
      const stored = localStorage.getItem('internship_az_demo_profiles');
      if (stored) profiles = JSON.parse(stored);
    } catch {
      // ignore
    }
  }

  const enriched = list.map((s) => {
    const task = tasks.find((t) => t.id === s.task_id);
    const student = profiles.find((p) => p.id === s.student_id) || {
      id: s.student_id,
      user_id: s.student_id,
      full_name: 'Ömər Babayev',
      email: 'babayev.omr.23@gmail.com',
      role: 'student' as const,
      avatar_url: null,
      phone: '+994 50 123 45 67',
      university: 'ADA Universiteti',
      created_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
    };

    return {
      ...s,
      task: s.task || task,
      student: s.student || student,
    };
  });

  let result = enriched;
  if (filter?.status && filter.status !== 'all') {
    result = result.filter((s) => s.status === filter.status);
  }
  if (filter?.internshipId && filter.internshipId !== 'all') {
    result = result.filter((s) => s.task?.internship_id === filter.internshipId);
  }

  return result.sort((a, b) => new Date(b.submitted_at).getTime() - new Date(a.submitted_at).getTime());
}

// Get single submission by ID for review
export async function getSubmissionById(submissionId: string): Promise<TaskSubmission | null> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        const { data, error } = await supabase
          .from('task_submissions')
          .select(`
            *,
            task:internship_tasks(*),
            student:profiles!task_submissions_student_id_fkey(*),
            enrollment:enrollments(*)
          `)
          .eq('id', submissionId)
          .maybeSingle();

        if (!error && data) {
          return data as TaskSubmission;
        }
      } catch (err) {
        console.warn('Failed to fetch submission by id from Supabase:', err);
      }
    }
  }

  // Demo fallback
  const list = await getAllSubmissions();
  const found = list.find((s) => s.id === submissionId);
  return found || null;
}

// Review a submission (Approve / Request Revision / Reject)
export async function reviewSubmission({
  submissionId,
  action,
  adminFeedback,
  reviewerId,
}: {
  submissionId: string;
  action: 'approve' | 'revision_requested' | 'reject';
  adminFeedback?: string | null;
  reviewerId?: string;
}): Promise<{ success: boolean; error?: string; submission?: TaskSubmission }> {
  // Validate requirement: Feedback is mandatory for revision_requested and reject!
  if ((action === 'revision_requested' || action === 'reject') && (!adminFeedback || adminFeedback.trim().length < 5)) {
    return {
      success: false,
      error: 'Düzəliş tələb edildikdə və ya rədd edildikdə rəy/səbəb qeyd edilməsi məcburidir (ən azı 5 simvol).',
    };
  }

  const targetStatus: SubmissionStatus =
    action === 'approve'
      ? 'approved'
      : action === 'revision_requested'
      ? 'revision_requested'
      : 'rejected';

  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (!supabase) return { success: false, error: 'Verilənlər bazası əlçatan deyil.' };

    try {
      const { data: updated, error } = await supabase
        .from('task_submissions')
        .update({
          status: targetStatus,
          admin_feedback: adminFeedback?.trim() || null,
          reviewed_by: reviewerId || null,
          reviewed_at: new Date().toISOString(),
          updated_at: new Date().toISOString(),
        })
        .eq('id', submissionId)
        .select(`
          *,
          task:internship_tasks(*),
          student:profiles!task_submissions_student_id_fkey(*)
        `)
        .single();

      if (error) {
        return { success: false, error: error.message };
      }

      // If approved, verify if this completes all required tasks for the enrollment
      if (targetStatus === 'approved' && updated.enrollment_id) {
        try {
          const { checkAndUpdateEnrollmentCompletion } = await import('@/lib/enrollments/service');
          await checkAndUpdateEnrollmentCompletion(updated.enrollment_id);
        } catch (compErr) {
          console.warn('Failed to check enrollment completion trigger:', compErr);
        }
      }

      return { success: true, submission: updated as TaskSubmission };
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : 'Təqdimat yoxlanılarkən xəta baş verdi.';
      return { success: false, error: msg };
    }
  }

  // Demo mode
  const list = getLocalSubmissions();
  const index = list.findIndex((s) => s.id === submissionId);
  if (index === -1) {
    return { success: false, error: 'Təqdimat tapılmadı.' };
  }

  const updated: TaskSubmission = {
    ...list[index],
    status: targetStatus,
    admin_feedback: adminFeedback?.trim() || null,
    reviewed_by: reviewerId || 'admin-demo-1',
    reviewed_at: new Date().toISOString(),
    updated_at: new Date().toISOString(),
  };

  const nextList = [...list];
  nextList[index] = updated;
  saveLocalSubmissions(nextList);

  // If approved in demo mode, verify completion
  if (targetStatus === 'approved' && updated.enrollment_id) {
    try {
      const { checkAndUpdateEnrollmentCompletion } = await import('@/lib/enrollments/service');
      await checkAndUpdateEnrollmentCompletion(updated.enrollment_id);
    } catch (compErr) {
      console.warn('Failed to trigger demo enrollment completion check:', compErr);
    }
  }

  return { success: true, submission: updated };
}

// Upload file to Supabase Storage or demo fallback
export async function uploadSubmissionFile(
  studentId: string,
  taskId: string,
  file: File
): Promise<{ success: boolean; filePath?: string; fileName?: string; error?: string }> {
  // Max size 15MB
  if (file.size > 15 * 1024 * 1024) {
    return { success: false, error: 'Faylın həcmi 15MB-dan çox ola bilməz.' };
  }

  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        const cleanName = file.name.replace(/[^a-zA-Z0-9.-]/g, '_');
        const path = `${studentId}/${taskId}/${Date.now()}_${cleanName}`;

        const { error } = await supabase.storage
          .from('task-submissions')
          .upload(path, file, {
            cacheControl: '3600',
            upsert: true,
          });

        if (error) {
          return { success: false, error: error.message };
        }

        return {
          success: true,
          filePath: path,
          fileName: file.name,
        };
      } catch (err: unknown) {
        const msg = err instanceof Error ? err.message : 'Fayl yüklənərkən xəta baş verdi.';
        return { success: false, error: msg };
      }
    }
  }

  // Demo mode: read as object URL or base64
  return new Promise((resolve) => {
    try {
      const reader = new FileReader();
      reader.onload = () => {
        const simulatedPath = `${studentId}/${taskId}/${Date.now()}_${file.name}`;
        // Store in sessionStorage or state cache if small
        if (typeof window !== 'undefined' && file.size < 2 * 1024 * 1024) {
          try {
            sessionStorage.setItem(`file_${simulatedPath}`, reader.result as string);
          } catch {
            // ignore
          }
        }
        resolve({
          success: true,
          filePath: simulatedPath,
          fileName: file.name,
        });
      };
      reader.onerror = () => {
        resolve({ success: false, error: 'Fayl oxuna bilmədi.' });
      };
      reader.readAsDataURL(file);
    } catch {
      resolve({
        success: true,
        filePath: `${studentId}/${taskId}/${Date.now()}_${file.name}`,
        fileName: file.name,
      });
    }
  });
}

// Get file download/view URL
export async function getSubmissionFileUrl(filePath: string): Promise<string> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        const { data, error } = await supabase.storage
          .from('task-submissions')
          .createSignedUrl(filePath, 3600); // 1 hour link

        if (!error && data?.signedUrl) {
          return data.signedUrl;
        }
      } catch (err) {
        console.warn('Failed to get signed URL:', err);
      }
    }
  }

  // Demo fallback
  if (typeof window !== 'undefined') {
    const cached = sessionStorage.getItem(`file_${filePath}`);
    if (cached) return cached;
  }

  return '#';
}
