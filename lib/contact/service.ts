import { createClient } from '@/lib/supabase/client';
import { isSupabaseConfigured } from '@/lib/supabase/config';
import { ContactMessage } from '@/types/database';

export interface ContactMessageInput {
  name: string;
  email: string;
  subject: string;
  message: string;
}

export async function submitContactMessage(input: ContactMessageInput): Promise<{
  success: boolean;
  error?: string;
}> {
  if (!isSupabaseConfigured()) {
    return { success: false, error: 'Əlaqə xidməti hazırda konfiqurasiya edilməyib.' };
  }

  const supabase = createClient();
  if (!supabase) return { success: false, error: 'Əlaqə xidməti əlçatan deyil.' };

  const { error } = await supabase.from('contact_messages').insert({
    name: input.name.trim(),
    email: input.email.trim().toLowerCase(),
    subject: input.subject.trim(),
    message: input.message.trim(),
  });

  return error
    ? { success: false, error: 'Mesaj göndərilmədi. Zəhmət olmasa yenidən cəhd edin.' }
    : { success: true };
}

export async function getContactMessages(): Promise<ContactMessage[]> {
  const supabase = createClient();
  if (!supabase) return [];

  const { data, error } = await supabase
    .from('contact_messages')
    .select('id, name, email, subject, message, status, created_at, read_at')
    .order('created_at', { ascending: false });

  if (error) throw error;
  return (data || []) as ContactMessage[];
}

export async function updateContactMessageStatus(
  id: string,
  status: ContactMessage['status']
): Promise<{ success: boolean; error?: string }> {
  const supabase = createClient();
  if (!supabase) return { success: false, error: 'Əlaqə xidməti əlçatan deyil.' };

  const { error } = await supabase
    .from('contact_messages')
    .update({ status, read_at: status === 'new' ? null : new Date().toISOString() })
    .eq('id', id);

  return error
    ? { success: false, error: 'Mesajın statusu dəyişdirilmədi.' }
    : { success: true };
}

export async function deleteContactMessage(id: string): Promise<{
  success: boolean;
  error?: string;
}> {
  const supabase = createClient();
  if (!supabase) return { success: false, error: 'Əlaqə xidməti əlçatan deyil.' };

  const { error } = await supabase.from('contact_messages').delete().eq('id', id);
  return error
    ? { success: false, error: 'Mesaj silinmədi.' }
    : { success: true };
}
