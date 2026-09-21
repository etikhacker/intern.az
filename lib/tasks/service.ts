import { createClient } from '@/lib/supabase/client';
import { isSupabaseConfigured } from '@/lib/supabase/config';
import { InternshipTask } from '@/types/database';
import { DEFAULT_SEED_TASKS } from '@/lib/data/seeds';

const DEMO_TASKS_KEY = 'internship_az_demo_tasks';

export function getLocalTasks(): InternshipTask[] {
  if (typeof window === 'undefined') return DEFAULT_SEED_TASKS;
  try {
    const stored = localStorage.getItem(DEMO_TASKS_KEY);
    if (stored) {
      const parsed = JSON.parse(stored);
      if (Array.isArray(parsed) && parsed.length > 0) return parsed;
    }
    // Initialize with seed tasks
    localStorage.setItem(DEMO_TASKS_KEY, JSON.stringify(DEFAULT_SEED_TASKS));
    return DEFAULT_SEED_TASKS;
  } catch {
    return DEFAULT_SEED_TASKS;
  }
}

export function saveLocalTasks(tasks: InternshipTask[]) {
  if (typeof window === 'undefined') return;
  try {
    localStorage.setItem(DEMO_TASKS_KEY, JSON.stringify(tasks));
  } catch {
    // ignore
  }
}

// Get all tasks for an internship
export async function getAllTasksForInternship(
  internshipId: string,
  includeDrafts = false
): Promise<InternshipTask[]> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
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
        if (!error && data) {
          return data as InternshipTask[];
        }
      } catch (err) {
        console.warn('Failed to fetch tasks from Supabase:', err);
      }
    }
  }

  // Demo fallback
  const tasks = getLocalTasks();
  return tasks
    .filter((t) => {
      if (t.internship_id !== internshipId) return false;
      if (!includeDrafts && t.status !== 'published') return false;
      return true;
    })
    .sort((a, b) => {
      if (a.week_number !== b.week_number) return a.week_number - b.week_number;
      return a.task_number - b.task_number;
    });
}

// Get a single task by ID
export async function getTaskById(taskId: string): Promise<InternshipTask | null> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        const { data, error } = await supabase
          .from('internship_tasks')
          .select(`
            *,
            internship:internships(*)
          `)
          .eq('id', taskId)
          .maybeSingle();

        if (!error && data) {
          return data as InternshipTask;
        }
      } catch (err) {
        console.warn('Failed to fetch task from Supabase:', err);
      }
    }
  }

  // Demo fallback
  const tasks = getLocalTasks();
  const task = tasks.find((t) => t.id === taskId);
  return task || null;
}

// Create a new task
export async function createTask(
  data: Omit<InternshipTask, 'id' | 'created_at' | 'updated_at'>
): Promise<{ success: boolean; error?: string; task?: InternshipTask }> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
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

  // Demo mode
  const tasks = getLocalTasks();
  const newTask: InternshipTask = {
    ...data,
    id: `task-${Date.now()}-${Math.random().toString(36).substring(2, 7)}`,
    created_at: new Date().toISOString(),
    updated_at: new Date().toISOString(),
  };

  saveLocalTasks([...tasks, newTask]);
  return { success: true, task: newTask };
}

// Update a task
export async function updateTask(
  taskId: string,
  updates: Partial<InternshipTask>
): Promise<{ success: boolean; error?: string; task?: InternshipTask }> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
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

  // Demo mode
  const tasks = getLocalTasks();
  const index = tasks.findIndex((t) => t.id === taskId);
  if (index === -1) {
    return { success: false, error: 'Tapşırıq tapılmadı.' };
  }

  const updatedTask: InternshipTask = {
    ...tasks[index],
    ...updates,
    updated_at: new Date().toISOString(),
  };

  const nextTasks = [...tasks];
  nextTasks[index] = updatedTask;
  saveLocalTasks(nextTasks);

  return { success: true, task: updatedTask };
}

// Delete a task
export async function deleteTask(taskId: string): Promise<{ success: boolean; error?: string }> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
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

  // Demo mode
  const tasks = getLocalTasks();
  const filtered = tasks.filter((t) => t.id !== taskId);
  saveLocalTasks(filtered);
  return { success: true };
}

// Reorder tasks in an internship
export async function reorderTasks(
  internshipId: string,
  orders: { id: string; week_number: number; task_number: number }[]
): Promise<{ success: boolean; error?: string }> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
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
  }

  // Demo mode
  const tasks = getLocalTasks();
  const orderMap = new Map(orders.map((o) => [o.id, o]));
  const updatedTasks = tasks.map((t) => {
    if (orderMap.has(t.id)) {
      const o = orderMap.get(t.id)!;
      return {
        ...t,
        week_number: o.week_number,
        task_number: o.task_number,
        updated_at: new Date().toISOString(),
      };
    }
    return t;
  });

  saveLocalTasks(updatedTasks);
  return { success: true };
}
