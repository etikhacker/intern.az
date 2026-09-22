import { createClient } from '@/lib/supabase/client';
import { isSupabaseConfigured } from '@/lib/supabase/config';
import { InternshipTask } from '@/types/database';

// Get all tasks for an internship
export async function getAllTasksForInternship(
  internshipId: string,
  includeDrafts = false
): Promise<InternshipTask[]> {
  if (!internshipId || !isSupabaseConfigured()) return [];

  const supabase = createClient();
  if (!supabase) return [];

  try {
    let query = supabase
      .from('internship_tasks')
      .select('*')
      .eq('internship_id', internshipId)
      .order('week_number', { ascending: true })
      .order('task_number', { ascending: true });

    if (!includeDrafts) {
      query = query.eq('status', 'published');
    }

    const { data, error } = await query;
    if (error || !data) return [];
    return data as InternshipTask[];
  } catch (err) {
    console.warn('Exception in getAllTasksForInternship:', err);
    return [];
  }
}

// Get a single task by ID
export async function getTaskById(taskId: string): Promise<InternshipTask | null> {
  if (!taskId || !isSupabaseConfigured()) return null;

  const supabase = createClient();
  if (!supabase) return null;

  try {
    const { data, error } = await supabase
      .from('internship_tasks')
      .select(`
        *,
        internship:internships(*)
      `)
      .eq('id', taskId)
      .maybeSingle();

    if (error || !data) return null;
    return data as InternshipTask;
  } catch (err) {
    console.warn('Exception in getTaskById:', err);
    return null;
  }
}

// Create a new task
export async function createTask(
  data: Omit<InternshipTask, 'id' | 'created_at' | 'updated_at'>
): Promise<{ success: boolean; error?: string; task?: InternshipTask }> {
  if (!isSupabaseConfigured()) {
    return { success: false, error: 'Verilənlər bazası konfiqurasiya edilməyib.' };
  }

  const supabase = createClient();
  if (!supabase) return { success: false, error: 'Verilənlər bazası əlçatan deyil.' };

  try {
    const { data: inserted, error } = await supabase
      .from('internship_tasks')
      .insert({
        internship_id: data.internship_id,
        title: data.title,
        description: data.description,
        instructions: data.instructions,
        week_number: data.week_number,
        task_number: data.task_number,
        difficulty: data.difficulty,
        submission_type: data.submission_type,
        deadline: data.deadline || null,
        is_required: data.is_required,
        status: data.status,
      })
      .select()
      .single();

    if (error) {
      return { success: false, error: error.message };
    }

    return { success: true, task: inserted as InternshipTask };
  } catch (err: unknown) {
    const msg = err instanceof Error ? err.message : 'Tapşırıq yaradılarkən xəta baş verdi.';
    return { success: false, error: msg };
  }
}

// Update a task
export async function updateTask(
  taskId: string,
  updates: Partial<InternshipTask>
): Promise<{ success: boolean; error?: string; task?: InternshipTask }> {
  if (!isSupabaseConfigured()) {
    return { success: false, error: 'Verilənlər bazası konfiqurasiya edilməyib.' };
  }

  const supabase = createClient();
  if (!supabase) return { success: false, error: 'Verilənlər bazası əlçatan deyil.' };

  try {
    const { data: updated, error } = await supabase
      .from('internship_tasks')
      .update({
        ...updates,
        updated_at: new Date().toISOString(),
      })
      .eq('id', taskId)
      .select()
      .single();

    if (error) {
      return { success: false, error: error.message };
    }

    return { success: true, task: updated as InternshipTask };
  } catch (err: unknown) {
    const msg = err instanceof Error ? err.message : 'Tapşırıq yenilənərkən xəta baş verdi.';
    return { success: false, error: msg };
  }
}

// Delete a task
export async function deleteTask(taskId: string): Promise<{ success: boolean; error?: string }> {
  if (!isSupabaseConfigured()) {
    return { success: false, error: 'Verilənlər bazası konfiqurasiya edilməyib.' };
  }

  const supabase = createClient();
  if (!supabase) return { success: false, error: 'Verilənlər bazası əlçatan deyil.' };

  try {
    const { error } = await supabase.from('internship_tasks').delete().eq('id', taskId);
    if (error) {
      return { success: false, error: error.message };
    }
    return { success: true };
  } catch (err: unknown) {
    const msg = err instanceof Error ? err.message : 'Tapşırıq silinərkən xəta baş verdi.';
    return { success: false, error: msg };
  }
}

// Reorder tasks in an internship
export async function reorderTasks(
  internshipId: string,
  orders: { id: string; week_number: number; task_number: number }[]
): Promise<{ success: boolean; error?: string }> {
  if (!isSupabaseConfigured()) {
    return { success: false, error: 'Verilənlər bazası konfiqurasiya edilməyib.' };
  }

  const supabase = createClient();
  if (!supabase) return { success: false, error: 'Verilənlər bazası əlçatan deyil.' };

  try {
    for (const item of orders) {
      await supabase
        .from('internship_tasks')
        .update({
          week_number: item.week_number,
          task_number: item.task_number,
          updated_at: new Date().toISOString(),
        })
        .eq('id', item.id);
    }
    return { success: true };
  } catch (err: unknown) {
    const msg = err instanceof Error ? err.message : 'Sıralama yenilənərkən xəta baş verdi.';
    return { success: false, error: msg };
  }
}
