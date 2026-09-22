import { createClient } from '@/lib/supabase/client';
import { isSupabaseConfigured } from '@/lib/supabase/config';
import { Internship, InternshipStatus } from '@/types/database';
import { InternshipFormData } from '@/lib/validations/internship';

// Fetch published internships for public directory (status = 'published' only)
export async function getPublishedInternships(): Promise<Internship[]> {
  if (!isSupabaseConfigured()) {
    console.warn('Supabase is not configured.');
    return [];
  }

  const supabase = createClient();
  if (!supabase) return [];

  try {
    const { data, error } = await supabase
      .from('internships')
      .select('*')
      .eq('status', 'published')
      .order('created_at', { ascending: false });

    if (error) {
      console.warn('Failed to fetch published internships:', error.message);
      return [];
    }

    return (data as Internship[]) || [];
  } catch (err) {
    console.warn('Exception in getPublishedInternships:', err);
    return [];
  }
}

// Fetch all internships for admin panel (supports optional status filter)
export async function getAllInternships(statusFilter?: InternshipStatus | 'all'): Promise<Internship[]> {
  if (!isSupabaseConfigured()) {
    console.warn('Supabase is not configured.');
    return [];
  }

  const supabase = createClient();
  if (!supabase) return [];

  try {
    let query = supabase.from('internships').select('*').order('created_at', { ascending: false });
    if (statusFilter && statusFilter !== 'all') {
      query = query.eq('status', statusFilter);
    }
    const { data, error } = await query;
    if (error) {
      console.warn('Failed to fetch all internships:', error.message);
      return [];
    }
    return (data as Internship[]) || [];
  } catch (err) {
    console.warn('Exception in getAllInternships:', err);
    return [];
  }
}

// Fetch single internship by slug
export async function getInternshipBySlug(slug: string): Promise<Internship | null> {
  if (!slug || !isSupabaseConfigured()) return null;

  const supabase = createClient();
  if (!supabase) return null;

  try {
    const { data, error } = await supabase
      .from('internships')
      .select('*')
      .eq('slug', slug)
      .maybeSingle();

    if (error || !data) return null;
    return data as Internship;
  } catch (err) {
    console.warn('Exception in getInternshipBySlug:', err);
    return null;
  }
}

// Fetch single internship by ID
export async function getInternshipById(id: string): Promise<Internship | null> {
  if (!id || !isSupabaseConfigured()) return null;

  const supabase = createClient();
  if (!supabase) return null;

  try {
    const { data, error } = await supabase
      .from('internships')
      .select('*')
      .eq('id', id)
      .maybeSingle();

    if (error || !data) return null;
    return data as Internship;
  } catch (err) {
    console.warn('Exception in getInternshipById:', err);
    return null;
  }
}

// Create new internship
export async function createInternship(
  data: InternshipFormData,
  userId?: string
): Promise<{ success: boolean; error?: string; internship?: Internship }> {
  if (!isSupabaseConfigured()) {
    return { success: false, error: 'Verilənlər bazası konfiqurasiya edilməyib.' };
  }

  const supabase = createClient();
  if (!supabase) return { success: false, error: 'Verilənlər bazası ilə əlaqə qurulmadı.' };

  try {
    // Check if slug is unique
    const { data: existing } = await supabase
      .from('internships')
      .select('id')
      .eq('slug', data.slug)
      .maybeSingle();

    if (existing) {
      return { success: false, error: 'Bu slug ilə başqa bir təcrübə proqramı artıq mövcuddur.' };
    }

    const { data: inserted, error } = await supabase
      .from('internships')
      .insert({
        title: data.title,
        slug: data.slug,
        short_description: data.short_description,
        description: data.description,
        category: data.category,
        duration_weeks: data.duration_weeks,
        difficulty: data.difficulty,
        skills: data.skills,
        requirements: data.requirements,
        responsibilities: data.responsibilities,
        benefits: data.benefits,
        max_students: data.max_students || null,
        status: data.status,
        application_deadline: data.application_deadline || null,
        start_date: data.start_date || null,
        created_by: userId || null,
      })
      .select()
      .single();

    if (error) {
      return { success: false, error: error.message };
    }

    return { success: true, internship: inserted as Internship };
  } catch (err: unknown) {
    const message = err instanceof Error ? err.message : 'Təcrübə proqramı yaradılarkən xəta baş verdi.';
    return { success: false, error: message };
  }
}

// Update existing internship
export async function updateInternship(
  id: string,
  data: Partial<InternshipFormData>
): Promise<{ success: boolean; error?: string; internship?: Internship }> {
  if (!isSupabaseConfigured()) {
    return { success: false, error: 'Verilənlər bazası konfiqurasiya edilməyib.' };
  }

  const supabase = createClient();
  if (!supabase) return { success: false, error: 'Verilənlər bazası ilə əlaqə qurulmadı.' };

  try {
    // If updating slug, check uniqueness
    if (data.slug) {
      const { data: existing } = await supabase
        .from('internships')
        .select('id')
        .eq('slug', data.slug)
        .neq('id', id)
        .maybeSingle();

      if (existing) {
        return { success: false, error: 'Bu slug ilə başqa bir təcrübə proqramı artıq mövcuddur.' };
      }
    }

    const payload: Record<string, unknown> = {
      updated_at: new Date().toISOString(),
    };
    if (data.title !== undefined) payload.title = data.title;
    if (data.slug !== undefined) payload.slug = data.slug;
    if (data.short_description !== undefined) payload.short_description = data.short_description;
    if (data.description !== undefined) payload.description = data.description;
    if (data.category !== undefined) payload.category = data.category;
    if (data.duration_weeks !== undefined) payload.duration_weeks = data.duration_weeks;
    if (data.difficulty !== undefined) payload.difficulty = data.difficulty;
    if (data.skills !== undefined) payload.skills = data.skills;
    if (data.requirements !== undefined) payload.requirements = data.requirements;
    if (data.responsibilities !== undefined) payload.responsibilities = data.responsibilities;
    if (data.benefits !== undefined) payload.benefits = data.benefits;
    if (data.max_students !== undefined) payload.max_students = data.max_students || null;
    if (data.status !== undefined) payload.status = data.status;
    if (data.application_deadline !== undefined) payload.application_deadline = data.application_deadline || null;
    if (data.start_date !== undefined) payload.start_date = data.start_date || null;

    const { data: updated, error } = await supabase
      .from('internships')
      .update(payload)
      .eq('id', id)
      .select()
      .single();

    if (error) {
      return { success: false, error: error.message };
    }

    return { success: true, internship: updated as Internship };
  } catch (err: unknown) {
    const message = err instanceof Error ? err.message : 'Təcrübə proqramı yenilənərkən xəta baş verdi.';
    return { success: false, error: message };
  }
}

// Delete an internship
export async function deleteInternship(id: string): Promise<{ success: boolean; error?: string }> {
  if (!isSupabaseConfigured()) {
    return { success: false, error: 'Verilənlər bazası konfiqurasiya edilməyib.' };
  }

  const supabase = createClient();
  if (!supabase) return { success: false, error: 'Verilənlər bazası ilə əlaqə qurulmadı.' };

  try {
    const { error } = await supabase.from('internships').delete().eq('id', id);
    if (error) {
      return { success: false, error: error.message };
    }
    return { success: true };
  } catch (err: unknown) {
    const message = err instanceof Error ? err.message : 'Təcrübə proqramı silinərkən xəta baş verdi.';
    return { success: false, error: message };
  }
}
