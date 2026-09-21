import { createClient } from '@/lib/supabase/client';
import { isSupabaseConfigured } from '@/lib/supabase/config';
import { Internship, InternshipStatus } from '@/types/database';
import { InternshipFormData } from '@/lib/validations/internship';
import { DEFAULT_SEED_INTERNSHIPS } from '@/lib/data/seeds';

const DEMO_INTERNSHIPS_KEY = 'internship_az_demo_internships';

function getLocalInternships(): Internship[] {
  if (typeof window === 'undefined') return DEFAULT_SEED_INTERNSHIPS;
  try {
    const stored = localStorage.getItem(DEMO_INTERNSHIPS_KEY);
    if (stored) {
      const parsed = JSON.parse(stored);
      if (Array.isArray(parsed) && parsed.length > 0) return parsed;
    }
    localStorage.setItem(DEMO_INTERNSHIPS_KEY, JSON.stringify(DEFAULT_SEED_INTERNSHIPS));
    return DEFAULT_SEED_INTERNSHIPS;
  } catch {
    return DEFAULT_SEED_INTERNSHIPS;
  }
}

function saveLocalInternships(internships: Internship[]) {
  if (typeof window === 'undefined') return;
  try {
    localStorage.setItem(DEMO_INTERNSHIPS_KEY, JSON.stringify(internships));
  } catch {
    // ignore
  }
}

// Fetch published internships for public directory
export async function getPublishedInternships(): Promise<Internship[]> {
  if (isSupabaseConfigured()) {
    const supabase = createClient();
    if (supabase) {
      try {
        const { data, error } = await supabase
          .from('internships')
          .select('*')
          .eq('status', 'published')
          .order('created_at', { ascending: false });

        if (!error && data) {
          return data as Internship[];
        }
      } catch (err) {
        console.warn('Failed to fetch published internships from Supabase:', err);
      }
    }
  }

  // Demo mode fallback
  const local = getLocalInternships();
  return local.filter((item) => item.status === 'published');
}

// Fetch all internships for admin panel
export async function getAllInternships(statusFilter?: InternshipStatus | 'all'): Promise<Internship[]> {
  if (isSupabaseConfigured()) {
    const supabase = createClient();
    if (supabase) {
      try {
        let query = supabase.from('internships').select('*').order('created_at', { ascending: false });
        if (statusFilter && statusFilter !== 'all') {
          query = query.eq('status', statusFilter);
        }
        const { data, error } = await query;
        if (!error && data) {
          return data as Internship[];
        }
      } catch (err) {
        console.warn('Failed to fetch all internships from Supabase:', err);
      }
    }
  }

  // Demo mode fallback
  const local = getLocalInternships();
  if (statusFilter && statusFilter !== 'all') {
    return local.filter((item) => item.status === statusFilter);
  }
  return local;
}

// Fetch single internship by slug
export async function getInternshipBySlug(slug: string): Promise<Internship | null> {
  if (isSupabaseConfigured()) {
    const supabase = createClient();
    if (supabase) {
      try {
        const { data, error } = await supabase
          .from('internships')
          .select('*')
          .eq('slug', slug)
          .single();

        if (!error && data) {
          return data as Internship;
        }
      } catch (err) {
        console.warn('Failed to fetch internship by slug from Supabase:', err);
      }
    }
  }

  // Demo mode fallback
  const local = getLocalInternships();
  const found = local.find((item) => item.slug === slug);
  return found || null;
}

// Fetch single internship by ID
export async function getInternshipById(id: string): Promise<Internship | null> {
  if (isSupabaseConfigured()) {
    const supabase = createClient();
    if (supabase) {
      try {
        const { data, error } = await supabase
          .from('internships')
          .select('*')
          .eq('id', id)
          .single();

        if (!error && data) {
          return data as Internship;
        }
      } catch (err) {
        console.warn('Failed to fetch internship by id from Supabase:', err);
      }
    }
  }

  // Demo mode fallback
  const local = getLocalInternships();
  const found = local.find((item) => item.id === id);
  return found || null;
}

// Create new internship
export async function createInternship(
  data: InternshipFormData,
  userId?: string
): Promise<{ success: boolean; error?: string; internship?: Internship }> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
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
  } else {
    // Demo mode
    const local = getLocalInternships();
    const existing = local.find((item) => item.slug === data.slug);
    if (existing) {
      return { success: false, error: 'Bu slug ilə başqa bir təcrübə proqramı artıq mövcuddur.' };
    }

    const newInternship: Internship = {
      id: `internship-${Date.now()}`,
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
      created_by: userId || 'user-admin-1',
      created_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
    };

    const updated = [newInternship, ...local];
    saveLocalInternships(updated);
    return { success: true, internship: newInternship };
  }
}

// Update existing internship
export async function updateInternship(
  id: string,
  data: Partial<InternshipFormData>
): Promise<{ success: boolean; error?: string; internship?: Internship }> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
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
  } else {
    // Demo mode
    const local = getLocalInternships();
    const index = local.findIndex((item) => item.id === id);
    if (index === -1) {
      return { success: false, error: 'Təcrübə proqramı tapılmadı.' };
    }

    if (data.slug && data.slug !== local[index].slug) {
      const exists = local.some((item) => item.slug === data.slug && item.id !== id);
      if (exists) {
        return { success: false, error: 'Bu slug ilə başqa bir təcrübə proqramı artıq mövcuddur.' };
      }
    }

    const updatedItem: Internship = {
      ...local[index],
      ...data,
      updated_at: new Date().toISOString(),
    };

    local[index] = updatedItem;
    saveLocalInternships(local);
    return { success: true, internship: updatedItem };
  }
}
