import { createClient } from '@/lib/supabase/client';
import { isSupabaseConfigured } from '@/lib/supabase/config';
import {
  CertificateSettings,
  CertificatePayment,
  Certificate,
  CertificateCandidate,
  Enrollment,
  Profile,
} from '@/types/database';
import { getInternshipById, getAllInternships } from '@/lib/internships/service';
import { getStudentEnrollments } from '@/lib/enrollments/service';
import { getAllTasksForInternship } from '@/lib/tasks/service';
import { getStudentSubmissionsForEnrollment } from '@/lib/submissions/service';
import { DEFAULT_SEED_CERTIFICATES, DEFAULT_SEED_CERTIFICATE_PAYMENTS } from '@/lib/data/seeds';

const DEMO_SETTINGS_KEY = 'internship_az_demo_certificate_settings';
const DEMO_PAYMENTS_KEY = 'internship_az_demo_certificate_payments';
const DEMO_CERTIFICATES_KEY = 'internship_az_demo_certificates';

// Default Demo Settings
export const DEFAULT_CERTIFICATE_SETTINGS: CertificateSettings[] = [
  {
    id: 'cert-setting-1',
    internship_id: 'internship-seed-1',
    price: 25,
    currency: 'AZN',
    card_number: '4169 7388 9012 3456',
    is_enabled: true,
    created_at: new Date(Date.now() - 30 * 86400000).toISOString(),
    updated_at: new Date(Date.now() - 30 * 86400000).toISOString(),
  },
  {
    id: 'cert-setting-2',
    internship_id: 'internship-seed-2',
    price: 30,
    currency: 'AZN',
    card_number: '4169 7388 9012 3456',
    is_enabled: true,
    created_at: new Date(Date.now() - 20 * 86400000).toISOString(),
    updated_at: new Date(Date.now() - 20 * 86400000).toISOString(),
  },
  {
    id: 'cert-setting-3',
    internship_id: 'internship-seed-3',
    price: 20,
    currency: 'AZN',
    card_number: '4169 7388 9012 3456',
    is_enabled: true,
    created_at: new Date(Date.now() - 15 * 86400000).toISOString(),
    updated_at: new Date(Date.now() - 15 * 86400000).toISOString(),
  },
];

// Local storage helpers
export function getLocalCertificateSettings(): CertificateSettings[] {
  if (typeof window === 'undefined') return DEFAULT_CERTIFICATE_SETTINGS;
  try {
    const stored = localStorage.getItem(DEMO_SETTINGS_KEY);
    if (stored) {
      const parsed = JSON.parse(stored);
      if (Array.isArray(parsed) && parsed.length > 0) return parsed;
    }
    localStorage.setItem(DEMO_SETTINGS_KEY, JSON.stringify(DEFAULT_CERTIFICATE_SETTINGS));
    return DEFAULT_CERTIFICATE_SETTINGS;
  } catch {
    return DEFAULT_CERTIFICATE_SETTINGS;
  }
}

export function saveLocalCertificateSettings(settings: CertificateSettings[]) {
  if (typeof window === 'undefined') return;
  try {
    localStorage.setItem(DEMO_SETTINGS_KEY, JSON.stringify(settings));
  } catch {
    // ignore
  }
}

export function getLocalCertificatePayments(): CertificatePayment[] {
  if (typeof window === 'undefined') return DEFAULT_SEED_CERTIFICATE_PAYMENTS;
  try {
    const stored = localStorage.getItem(DEMO_PAYMENTS_KEY);
    if (stored) {
      const parsed = JSON.parse(stored);
      if (Array.isArray(parsed) && parsed.length > 0) return parsed;
    }
    localStorage.setItem(DEMO_PAYMENTS_KEY, JSON.stringify(DEFAULT_SEED_CERTIFICATE_PAYMENTS));
    return DEFAULT_SEED_CERTIFICATE_PAYMENTS;
  } catch {
    return DEFAULT_SEED_CERTIFICATE_PAYMENTS;
  }
}

export function saveLocalCertificatePayments(payments: CertificatePayment[]) {
  if (typeof window === 'undefined') return;
  try {
    localStorage.setItem(DEMO_PAYMENTS_KEY, JSON.stringify(payments));
  } catch {
    // ignore
  }
}

export function getLocalCertificates(): Certificate[] {
  if (typeof window === 'undefined') return DEFAULT_SEED_CERTIFICATES;
  try {
    const stored = localStorage.getItem(DEMO_CERTIFICATES_KEY);
    if (stored) {
      const parsed = JSON.parse(stored);
      if (Array.isArray(parsed) && parsed.length > 0) return parsed;
    }
    localStorage.setItem(DEMO_CERTIFICATES_KEY, JSON.stringify(DEFAULT_SEED_CERTIFICATES));
    return DEFAULT_SEED_CERTIFICATES;
  } catch {
    return DEFAULT_SEED_CERTIFICATES;
  }
}

export function saveLocalCertificates(certs: Certificate[]) {
  if (typeof window === 'undefined') return;
  try {
    localStorage.setItem(DEMO_CERTIFICATES_KEY, JSON.stringify(certs));
  } catch {
    // ignore
  }
}

// Generate unique certificate ID (e.g. CERT-A1B2C3D4E5F6)
export function generateCertificateId(): string {
  const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  let random = '';
  for (let i = 0; i < 10; i++) {
    random += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return `CERT-${random.substring(0, 4)}-${random.substring(4, 8)}-${random.substring(8, 10)}`;
}

// ==========================================
// 1. Certificate Settings
// ==========================================

export async function getCertificateSettings(internshipId: string): Promise<CertificateSettings | null> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        const { data, error } = await supabase
          .from('certificate_settings')
          .select('*, internship:internships(*)')
          .eq('internship_id', internshipId)
          .maybeSingle();

        if (!error && data) {
          return data as CertificateSettings;
        }
      } catch (err) {
        console.warn('Failed to fetch certificate settings from Supabase:', err);
      }
    }
  }

  // Demo fallback
  const all = getLocalCertificateSettings();
  const found = all.find((s) => s.internship_id === internshipId);
  if (found) {
    if (!found.internship) {
      const intern = await getInternshipById(internshipId);
      if (intern) found.internship = intern;
    }
    return found;
  }
  return null;
}

export async function getAllCertificateSettings(): Promise<CertificateSettings[]> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        const { data, error } = await supabase
          .from('certificate_settings')
          .select('*, internship:internships(*)')
          .order('created_at', { ascending: false });

        if (!error && data) {
          return data as CertificateSettings[];
        }
      } catch (err) {
        console.warn('Failed to fetch all certificate settings from Supabase:', err);
      }
    }
  }

  // Demo fallback
  const list = getLocalCertificateSettings();
  for (const s of list) {
    if (!s.internship) {
      const intern = await getInternshipById(s.internship_id);
      if (intern) s.internship = intern;
    }
  }
  return list;
}

export async function saveCertificateSettings({
  internshipId,
  price,
  currency = 'AZN',
  cardNumber,
  isEnabled,
}: {
  internshipId: string;
  price: number;
  currency?: string;
  cardNumber: string;
  isEnabled: boolean;
}): Promise<{ success: boolean; error?: string; settings?: CertificateSettings }> {
  if (price < 0) {
    return { success: false, error: 'Qiymət mənfi ola bilməz.' };
  }
  if (isEnabled && !cardNumber.trim()) {
    return { success: false, error: 'Sertifikat aktiv olduqda kart nömrəsi qeyd edilməlidir.' };
  }

  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (!supabase) return { success: false, error: 'Verilənlər bazası əlçatan deyil.' };

    try {
      // Upsert by internship_id
      const payload = {
        internship_id: internshipId,
        price: Number(price),
        currency: currency.trim() || 'AZN',
        card_number: cardNumber.trim(),
        is_enabled: isEnabled,
        updated_at: new Date().toISOString(),
      };

      const { data, error } = await supabase
        .from('certificate_settings')
        .upsert(payload, { onConflict: 'internship_id' })
        .select('*, internship:internships(*)')
        .single();

      if (error) {
        return { success: false, error: error.message };
      }

      return { success: true, settings: data as CertificateSettings };
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : 'Sertifikat parametrləri yadda saxlanılarkən xəta baş verdi.';
      return { success: false, error: msg };
    }
  }

  // Demo fallback
  const all = getLocalCertificateSettings();
  const idx = all.findIndex((s) => s.internship_id === internshipId);
  const internship = await getInternshipById(internshipId);

  const updatedSetting: CertificateSettings = {
    id: idx >= 0 ? all[idx].id : `cert-setting-${Date.now()}`,
    internship_id: internshipId,
    price: Number(price),
    currency: currency.trim() || 'AZN',
    card_number: cardNumber.trim(),
    is_enabled: isEnabled,
    created_at: idx >= 0 ? all[idx].created_at : new Date().toISOString(),
    updated_at: new Date().toISOString(),
    internship: internship || undefined,
  };

  const nextList = [...all];
  if (idx >= 0) {
    nextList[idx] = updatedSetting;
  } else {
    nextList.unshift(updatedSetting);
  }

  saveLocalCertificateSettings(nextList);
  return { success: true, settings: updatedSetting };
}

// ==========================================
// 2. Student Certificate Eligibility & Details
// ==========================================

export async function getStudentCertificateEligibility(studentId: string): Promise<{
  eligible: boolean;
  completedEnrollments: Enrollment[];
  eligibleEnrollment: Enrollment | null;
  settings: CertificateSettings | null;
  currentPayment: CertificatePayment | null;
  currentCertificate: Certificate | null;
  tasksCompletedCount?: number;
  totalRequiredTasksCount?: number;
}> {
  const enrollments = await getStudentEnrollments(studentId);

  // Check enrollments that have status === 'completed'
  let completed = enrollments.filter((e) => e.status === 'completed');

  // Also check if any active enrollment has completed all required tasks, mark or treat as completed
  for (const en of enrollments) {
    if (en.status === 'active') {
      const tasks = await getAllTasksForInternship(en.internship_id, false);
      const reqTasks = tasks.filter((t) => t.is_required && t.status === 'published');
      if (reqTasks.length > 0) {
        const subs = await getStudentSubmissionsForEnrollment(studentId, en.id);
        const approvedCount = reqTasks.filter((t) =>
          subs.some((s) => s.task_id === t.id && s.status === 'approved')
        ).length;

        if (approvedCount === reqTasks.length) {
          // All required tasks are approved!
          const completedEnrollment: Enrollment = {
            ...en,
            status: 'completed',
            completed_at: en.completed_at || new Date().toISOString(),
          };
          if (!completed.some((c) => c.id === en.id)) {
            completed.push(completedEnrollment);
          }
        }
      }
    }
  }

  if (completed.length === 0) {
    return {
      eligible: false,
      completedEnrollments: [],
      eligibleEnrollment: null,
      settings: null,
      currentPayment: null,
      currentCertificate: null,
    };
  }

  // Use the most recent completed enrollment
  const primaryEnrollment = completed[0];
  const settings = await getCertificateSettings(primaryEnrollment.internship_id);

  // Check payments for this enrollment
  const payments = await getStudentCertificatePayments(studentId, primaryEnrollment.id);
  const currentPayment = payments.length > 0 ? payments[0] : null;

  // Check issued/existing certificate for this enrollment
  const certificate = await getCertificateForEnrollment(primaryEnrollment.id, studentId);

  return {
    eligible: true,
    completedEnrollments: completed,
    eligibleEnrollment: primaryEnrollment,
    settings,
    currentPayment,
    currentCertificate: certificate,
  };
}

// Get student's certificate payments
export async function getStudentCertificatePayments(
  studentId: string,
  enrollmentId?: string
): Promise<CertificatePayment[]> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        let query = supabase
          .from('certificate_payments')
          .select(`
            *,
            internship:internships(*),
            enrollment:enrollments(*)
          `)
          .eq('student_id', studentId)
          .order('created_at', { ascending: false });

        if (enrollmentId) {
          query = query.eq('enrollment_id', enrollmentId);
        }

        const { data, error } = await query;
        if (!error && data) {
          return data as CertificatePayment[];
        }
      } catch (err) {
        console.warn('Failed to fetch certificate payments from Supabase:', err);
      }
    }
  }

  // Demo fallback
  const list = getLocalCertificatePayments();
  return list
    .filter((p) => p.student_id === studentId && (!enrollmentId || p.enrollment_id === enrollmentId))
    .sort((a, b) => new Date(b.created_at).getTime() - new Date(a.created_at).getTime());
}

// Upload receipt to private bucket `certificate-payments`
export async function uploadReceiptFile(
  studentId: string,
  enrollmentId: string,
  file: File
): Promise<{ success: boolean; error?: string; filePath?: string; fileName?: string }> {
  // Validate allowed extensions
  const allowedExtensions = ['jpg', 'jpeg', 'png', 'webp', 'pdf'];
  const ext = file.name.split('.').pop()?.toLowerCase() || 'jpg';
  if (!allowedExtensions.includes(ext)) {
    return {
      success: false,
      error: 'Yalnız JPG, JPEG, PNG, WEBP və PDF fayl formatları qəbul edilir.',
    };
  }

  // 10MB limit
  if (file.size > 10 * 1024 * 1024) {
    return {
      success: false,
      error: 'Faylın həcmi 10MB-dan çox ola bilməz.',
    };
  }

  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        const uniqueId = typeof crypto !== 'undefined' && crypto.randomUUID ? crypto.randomUUID() : `${Date.now()}`;
        const path = `${studentId}/${uniqueId}.${ext}`;

        const { error } = await supabase.storage
          .from('certificate-payments')
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
        const msg = err instanceof Error ? err.message : 'Qəbz yüklənərkən xəta baş verdi.';
        return { success: false, error: msg };
      }
    }
  }

  // Demo mode: read as Data URL or simulated path
  return new Promise((resolve) => {
    try {
      const reader = new FileReader();
      reader.onload = () => {
        const simulatedPath = `${studentId}/${Date.now()}.${ext}`;
        if (typeof window !== 'undefined' && file.size < 2 * 1024 * 1024) {
          try {
            sessionStorage.setItem(`receipt_${simulatedPath}`, reader.result as string);
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
        filePath: `${studentId}/${Date.now()}.${ext}`,
        fileName: file.name,
      });
    }
  });
}

// Submit payment receipt
export async function submitCertificatePayment({
  studentId,
  internshipId,
  enrollmentId,
  amount,
  currency = 'AZN',
  receiptFile,
  receiptPath,
  receiptName,
}: {
  studentId: string;
  internshipId: string;
  enrollmentId: string;
  amount: number;
  currency?: string;
  receiptFile?: File | null;
  receiptPath?: string;
  receiptName?: string;
}): Promise<{ success: boolean; error?: string; payment?: CertificatePayment }> {
  let finalReceiptPath = receiptPath || '';
  let finalReceiptName = receiptName || '';

  if (receiptFile) {
    const uploadRes = await uploadReceiptFile(studentId, enrollmentId, receiptFile);
    if (!uploadRes.success) {
      return { success: false, error: uploadRes.error || 'Qəbz faylı yüklənə bilmədi.' };
    }
    finalReceiptPath = uploadRes.filePath || '';
    finalReceiptName = uploadRes.fileName || '';
  }

  if (!finalReceiptPath) {
    return { success: false, error: 'Zəhmət olmasa ödəniş qəbzini yükləyin.' };
  }

  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (!supabase) return { success: false, error: 'Verilənlər bazası əlçatan deyil.' };

    try {
      // Check existing pending payment to prevent duplicate pending payments for the same enrollment
      const { data: existingPending } = await supabase
        .from('certificate_payments')
        .select('id')
        .eq('student_id', studentId)
        .eq('enrollment_id', enrollmentId)
        .eq('status', 'pending')
        .maybeSingle();

      if (existingPending) {
        // Update existing pending payment
        const { data: updated, error: updateError } = await supabase
          .from('certificate_payments')
          .update({
            amount,
            currency,
            receipt_path: finalReceiptPath,
            updated_at: new Date().toISOString(),
          })
          .eq('id', existingPending.id)
          .select('*, internship:internships(*), enrollment:enrollments(*)')
          .single();

        if (updateError) {
          return { success: false, error: updateError.message };
        }
        return { success: true, payment: updated as CertificatePayment };
      }

      const payload = {
        student_id: studentId,
        internship_id: internshipId,
        enrollment_id: enrollmentId,
        amount,
        currency,
        receipt_path: finalReceiptPath,
        status: 'pending',
        admin_note: null,
        reviewed_by: null,
        reviewed_at: null,
      };

      const { data, error } = await supabase
        .from('certificate_payments')
        .insert(payload)
        .select('*, internship:internships(*), enrollment:enrollments(*)')
        .single();

      if (error) {
        return { success: false, error: error.message };
      }

      return { success: true, payment: data as CertificatePayment };
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : 'Ödəniş qəbzi göndərilərkən xəta baş verdi.';
      return { success: false, error: msg };
    }
  }

  // Demo fallback
  const payments = getLocalCertificatePayments();
  const existingPendingIndex = payments.findIndex(
    (p) => p.student_id === studentId && p.enrollment_id === enrollmentId && p.status === 'pending'
  );

  const internship = await getInternshipById(internshipId);

  const newPayment: CertificatePayment = {
    id: existingPendingIndex >= 0 ? payments[existingPendingIndex].id : `pay-${Date.now()}`,
    student_id: studentId,
    internship_id: internshipId,
    enrollment_id: enrollmentId,
    amount,
    currency,
    receipt_path: finalReceiptPath,
    receipt_name: finalReceiptName,
    status: 'pending',
    admin_note: null,
    reviewed_by: null,
    reviewed_at: null,
    created_at: existingPendingIndex >= 0 ? payments[existingPendingIndex].created_at : new Date().toISOString(),
    updated_at: new Date().toISOString(),
    internship: internship || undefined,
  };

  const nextList = [...payments];
  if (existingPendingIndex >= 0) {
    nextList[existingPendingIndex] = newPayment;
  } else {
    nextList.unshift(newPayment);
  }

  saveLocalCertificatePayments(nextList);
  return { success: true, payment: newPayment };
}

// Get Signed URL for Payment Receipt from private bucket `certificate-payments`
export async function getPaymentReceiptSignedUrl(receiptPath: string): Promise<string> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        const { data, error } = await supabase.storage
          .from('certificate-payments')
          .createSignedUrl(receiptPath, 3600); // 1 hour link

        if (!error && data?.signedUrl) {
          return data.signedUrl;
        }
      } catch (err) {
        console.warn('Failed to get signed URL for receipt:', err);
      }
    }
  }

  // Demo fallback
  if (typeof window !== 'undefined') {
    const cached = sessionStorage.getItem(`receipt_${receiptPath}`);
    if (cached) return cached;
  }

  return '#';
}

// ==========================================
// 3. Admin Certificate Orders & Review
// ==========================================

export async function getAdminCertificatePayments(filter?: {
  status?: string;
  search?: string;
}): Promise<CertificatePayment[]> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        let query = supabase
          .from('certificate_payments')
          .select(`
            *,
            student:profiles!certificate_payments_student_id_fkey(*),
            internship:internships(*),
            enrollment:enrollments(*)
          `)
          .order('created_at', { ascending: false });

        if (filter?.status && filter.status !== 'all') {
          query = query.eq('status', filter.status);
        }

        const { data, error } = await query;
        if (!error && data) {
          let list = data as CertificatePayment[];
          if (filter?.search && filter.search.trim()) {
            const q = filter.search.toLowerCase().trim();
            list = list.filter(
              (p) =>
                p.student?.full_name?.toLowerCase().includes(q) ||
                p.student?.email?.toLowerCase().includes(q) ||
                p.internship?.title?.toLowerCase().includes(q)
            );
          }
          return list;
        }
      } catch (err) {
        console.warn('Failed to fetch admin certificate payments from Supabase:', err);
      }
    }
  }

  // Demo fallback
  let list = getLocalCertificatePayments();
  const internships = await getAllInternships('all');

  // Load student profiles from localStorage if available
  let profiles: Profile[] = [];
  if (typeof window !== 'undefined') {
    try {
      const stored = localStorage.getItem('internship_az_demo_profiles');
      if (stored) profiles = JSON.parse(stored);
    } catch {
      // ignore
    }
  }

  let enriched = list.map((p) => ({
    ...p,
    internship: p.internship || internships.find((i) => i.id === p.internship_id),
    student: p.student || profiles.find((pr) => pr.id === p.student_id || pr.user_id === p.student_id) || {
      id: p.student_id,
      user_id: p.student_id,
      full_name: 'Ömər Babayev',
      email: 'student@intern.az',
      role: 'student',
      avatar_url: null,
      phone: '+994 50 123 45 67',
      university: 'Azərbaycan Dövlət Neft və Sənaye Universiteti',
      created_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
    },
  }));

  if (filter?.status && filter.status !== 'all') {
    enriched = enriched.filter((p) => p.status === filter.status);
  }

  if (filter?.search && filter.search.trim()) {
    const q = filter.search.toLowerCase().trim();
    enriched = enriched.filter(
      (p) =>
        p.student?.full_name?.toLowerCase().includes(q) ||
        p.student?.email?.toLowerCase().includes(q) ||
        p.internship?.title?.toLowerCase().includes(q)
    );
  }

  return enriched;
}

export async function reviewCertificatePayment({
  paymentId,
  status,
  adminId,
  adminNote,
}: {
  paymentId: string;
  status: 'approved' | 'rejected';
  adminId: string;
  adminNote?: string;
}): Promise<{ success: boolean; error?: string; payment?: CertificatePayment }> {
  if (status === 'rejected' && (!adminNote || !adminNote.trim())) {
    return { success: false, error: 'Ödənişi rədd edərkən səbəb / qeyd mütləq yazılmalıdır.' };
  }

  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (!supabase) return { success: false, error: 'Verilənlər bazası əlçatan deyil.' };

    try {
      const payload = {
        status,
        admin_note: adminNote?.trim() || null,
        reviewed_by: adminId,
        reviewed_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
      };

      const { data, error } = await supabase
        .from('certificate_payments')
        .update(payload)
        .eq('id', paymentId)
        .select('*, student:profiles!certificate_payments_student_id_fkey(*), internship:internships(*)')
        .single();

      if (error) {
        return { success: false, error: error.message };
      }

      return { success: true, payment: data as CertificatePayment };
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : 'Ödəniş icmalı yadda saxlanılarkən xəta baş verdi.';
      return { success: false, error: msg };
    }
  }

  // Demo fallback
  const list = getLocalCertificatePayments();
  const idx = list.findIndex((p) => p.id === paymentId);
  if (idx < 0) {
    return { success: false, error: 'Ödəniş tapılmadı.' };
  }

  const updated: CertificatePayment = {
    ...list[idx],
    status,
    admin_note: adminNote?.trim() || null,
    reviewed_by: adminId,
    reviewed_at: new Date().toISOString(),
    updated_at: new Date().toISOString(),
  };

  list[idx] = updated;
  saveLocalCertificatePayments(list);
  return { success: true, payment: updated };
}

// ==========================================
// 4. Admin Certificates & Issuance (Canva PDF)
// ==========================================

export async function getCertificateForEnrollment(
  enrollmentId: string,
  studentId?: string
): Promise<Certificate | null> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        let query = supabase
          .from('certificates')
          .select('*, student:profiles!certificates_student_id_fkey(*), internship:internships(*)')
          .eq('enrollment_id', enrollmentId);

        if (studentId) {
          query = query.eq('student_id', studentId);
        }

        const { data, error } = await query.maybeSingle();
        if (!error && data) {
          return data as Certificate;
        }
      } catch (err) {
        console.warn('Failed to fetch certificate for enrollment:', err);
      }
    }
  }

  // Demo fallback
  const list = getLocalCertificates();
  return list.find((c) => c.enrollment_id === enrollmentId && (!studentId || c.student_id === studentId)) || null;
}

// Get candidates awaiting certificate issuance:
// (Completed internship + approved certificate payment + no issued certificate)
export async function getCertificateCandidates(): Promise<CertificateCandidate[]> {
  const payments = await getAdminCertificatePayments({ status: 'approved' });
  const certs = await getAdminCertificates();

  const candidates: CertificateCandidate[] = [];

  for (const p of payments) {
    const existingCert = certs.find((c) => c.enrollment_id === p.enrollment_id && c.status === 'issued');
    if (!existingCert && p.internship && p.student && p.enrollment) {
      candidates.push({
        enrollment: p.enrollment,
        student: p.student,
        internship: p.internship,
        payment: p,
        certificate: certs.find((c) => c.enrollment_id === p.enrollment_id) || null,
      });
    }
  }

  return candidates;
}

export async function getAdminCertificates(filter?: {
  status?: string;
  search?: string;
}): Promise<Certificate[]> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        let query = supabase
          .from('certificates')
          .select(`
            *,
            student:profiles!certificates_student_id_fkey(*),
            internship:internships(*),
            enrollment:enrollments(*)
          `)
          .order('created_at', { ascending: false });

        if (filter?.status && filter.status !== 'all') {
          query = query.eq('status', filter.status);
        }

        const { data, error } = await query;
        if (!error && data) {
          let list = data as Certificate[];
          if (filter?.search && filter.search.trim()) {
            const q = filter.search.toLowerCase().trim();
            list = list.filter(
              (c) =>
                c.student_name?.toLowerCase().includes(q) ||
                c.internship_title?.toLowerCase().includes(q) ||
                c.certificate_id?.toLowerCase().includes(q)
            );
          }
          return list;
        }
      } catch (err) {
        console.warn('Failed to fetch admin certificates from Supabase:', err);
      }
    }
  }

  // Demo fallback
  let list = getLocalCertificates();
  const internships = await getAllInternships('all');

  let enriched = list.map((c) => ({
    ...c,
    internship: c.internship || internships.find((i) => i.id === c.internship_id),
  }));

  if (filter?.status && filter.status !== 'all') {
    enriched = enriched.filter((c) => c.status === filter.status);
  }

  if (filter?.search && filter.search.trim()) {
    const q = filter.search.toLowerCase().trim();
    enriched = enriched.filter(
      (c) =>
        c.student_name?.toLowerCase().includes(q) ||
        c.internship_title?.toLowerCase().includes(q) ||
        c.certificate_id?.toLowerCase().includes(q)
    );
  }

  return enriched;
}

// Upload Certificate PDF (Canva manual creation) to private bucket `certificates`
export async function uploadCertificatePdf(
  studentId: string,
  enrollmentId: string,
  file: File
): Promise<{ success: boolean; error?: string; filePath?: string }> {
  const ext = file.name.split('.').pop()?.toLowerCase() || '';
  if (ext !== 'pdf') {
    return { success: false, error: 'Sertifikat faylı yalnız PDF formatında olmalıdır.' };
  }

  if (file.size > 20 * 1024 * 1024) {
    return { success: false, error: 'PDF faylının həcmi 20MB-dan çox ola bilməz.' };
  }

  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        const uniqueId = typeof crypto !== 'undefined' && crypto.randomUUID ? crypto.randomUUID() : `${Date.now()}`;
        const path = `${studentId}/${uniqueId}.pdf`;

        const { error } = await supabase.storage
          .from('certificates')
          .upload(path, file, {
            cacheControl: '3600',
            upsert: true,
          });

        if (error) {
          return { success: false, error: error.message };
        }

        return { success: true, filePath: path };
      } catch (err: unknown) {
        const msg = err instanceof Error ? err.message : 'Sertifikat PDF yüklənərkən xəta baş verdi.';
        return { success: false, error: msg };
      }
    }
  }

  // Demo mode: save data URL to session
  return new Promise((resolve) => {
    try {
      const reader = new FileReader();
      reader.onload = () => {
        const simulatedPath = `${studentId}/${Date.now()}.pdf`;
        if (typeof window !== 'undefined' && file.size < 4 * 1024 * 1024) {
          try {
            sessionStorage.setItem(`cert_${simulatedPath}`, reader.result as string);
          } catch {
            // ignore
          }
        }
        resolve({
          success: true,
          filePath: simulatedPath,
        });
      };
      reader.onerror = () => {
        resolve({ success: false, error: 'PDF oxuna bilmədi.' });
      };
      reader.readAsDataURL(file);
    } catch {
      resolve({
        success: true,
        filePath: `${studentId}/${Date.now()}.pdf`,
      });
    }
  });
}

// Issue Certificate
export async function issueCertificate({
  studentId,
  internshipId,
  enrollmentId,
  studentName,
  internshipTitle,
  certificateFile,
  certificateFilePath,
}: {
  studentId: string;
  internshipId: string;
  enrollmentId: string;
  studentName: string;
  internshipTitle: string;
  certificateFile?: File | null;
  certificateFilePath?: string;
}): Promise<{ success: boolean; error?: string; certificate?: Certificate }> {
  let finalPath = certificateFilePath || '';

  if (certificateFile) {
    const uploadRes = await uploadCertificatePdf(studentId, enrollmentId, certificateFile);
    if (!uploadRes.success) {
      return { success: false, error: uploadRes.error || 'Sertifikat PDF faylı yüklənə bilmədi.' };
    }
    finalPath = uploadRes.filePath || '';
  }

  if (!finalPath) {
    return { success: false, error: 'Zəhmət olmasa tərtib edilmiş sertifikat PDF faylını yükləyin.' };
  }

  const certificateId = generateCertificateId();
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (!supabase) return { success: false, error: 'Verilənlər bazası əlçatan deyil.' };

    try {
      // Check if existing certificate for enrollment
      const { data: existing } = await supabase
        .from('certificates')
        .select('id')
        .eq('enrollment_id', enrollmentId)
        .maybeSingle();

      if (existing) {
        const { data: updated, error: updateErr } = await supabase
          .from('certificates')
          .update({
            student_name: studentName.trim(),
            internship_title: internshipTitle.trim(),
            certificate_file_path: finalPath,
            status: 'issued',
            issued_at: new Date().toISOString(),
            updated_at: new Date().toISOString(),
          })
          .eq('id', existing.id)
          .select('*, student:profiles!certificates_student_id_fkey(*), internship:internships(*)')
          .single();

        if (updateErr) {
          return { success: false, error: updateErr.message };
        }
        return { success: true, certificate: updated as Certificate };
      }

      const payload = {
        certificate_id: certificateId,
        student_id: studentId,
        internship_id: internshipId,
        enrollment_id: enrollmentId,
        student_name: studentName.trim(),
        internship_title: internshipTitle.trim(),
        issued_at: new Date().toISOString(),
        certificate_file_path: finalPath,
        status: 'issued',
      };

      const { data, error } = await supabase
        .from('certificates')
        .insert(payload)
        .select('*, student:profiles!certificates_student_id_fkey(*), internship:internships(*)')
        .single();

      if (error) {
        return { success: false, error: error.message };
      }

      return { success: true, certificate: data as Certificate };
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : 'Sertifikat tərtib edilərkən xəta baş verdi.';
      return { success: false, error: msg };
    }
  }

  // Demo fallback
  const list = getLocalCertificates();
  const existingIdx = list.findIndex((c) => c.enrollment_id === enrollmentId);
  const internship = await getInternshipById(internshipId);

  const newCert: Certificate = {
    id: existingIdx >= 0 ? list[existingIdx].id : `cert-${Date.now()}`,
    certificate_id: existingIdx >= 0 ? list[existingIdx].certificate_id : certificateId,
    student_id: studentId,
    internship_id: internshipId,
    enrollment_id: enrollmentId,
    student_name: studentName.trim(),
    internship_title: internshipTitle.trim(),
    issued_at: new Date().toISOString(),
    certificate_file_path: finalPath,
    status: 'issued',
    created_at: existingIdx >= 0 ? list[existingIdx].created_at : new Date().toISOString(),
    updated_at: new Date().toISOString(),
    internship: internship || undefined,
  };

  const nextList = [...list];
  if (existingIdx >= 0) {
    nextList[existingIdx] = newCert;
  } else {
    nextList.unshift(newCert);
  }

  saveLocalCertificates(nextList);
  return { success: true, certificate: newCert };
}

// Revoke Certificate
export async function revokeCertificate(
  idOrCertId: string
): Promise<{ success: boolean; error?: string }> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (!supabase) return { success: false, error: 'Verilənlər bazası əlçatan deyil.' };

    try {
      const { error } = await supabase
        .from('certificates')
        .update({
          status: 'revoked',
          updated_at: new Date().toISOString(),
        })
        .or(`id.eq.${idOrCertId},certificate_id.eq.${idOrCertId}`);

      if (error) {
        return { success: false, error: error.message };
      }

      return { success: true };
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : 'Sertifikat ləğv edilərkən xəta baş verdi.';
      return { success: false, error: msg };
    }
  }

  // Demo fallback
  const list = getLocalCertificates();
  const idx = list.findIndex((c) => c.id === idOrCertId || c.certificate_id === idOrCertId);
  if (idx < 0) {
    return { success: false, error: 'Sertifikat tapılmadı.' };
  }

  list[idx] = {
    ...list[idx],
    status: 'revoked',
    updated_at: new Date().toISOString(),
  };

  saveLocalCertificates(list);
  return { success: true };
}

// Get Signed URL for Certificate PDF from private bucket `certificates`
export async function getCertificateSignedUrl(certificateFilePath: string): Promise<string> {
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        const { data, error } = await supabase.storage
          .from('certificates')
          .createSignedUrl(certificateFilePath, 3600); // 1 hour link

        if (!error && data?.signedUrl) {
          return data.signedUrl;
        }
      } catch (err) {
        console.warn('Failed to get signed URL for certificate:', err);
      }
    }
  }

  // Demo fallback
  if (typeof window !== 'undefined') {
    const cached = sessionStorage.getItem(`cert_${certificateFilePath}`);
    if (cached) return cached;
  }

  return '#';
}

// ==========================================
// 5. Public Certificate Verification
// ==========================================
// Public verification: accessible without login.
// ONLY returns if status === 'issued'.
// Safely exposes ONLY: certificate_id, student_name, internship_title, issued_at, status.
// NEVER exposes: email, phone, university, payment info, or raw storage path.
export async function getPublicCertificate(certificateId: string): Promise<{
  certificate_id: string;
  student_name: string;
  internship_title: string;
  issued_at: string;
  status: 'issued';
} | null> {
  if (!certificateId || !certificateId.trim()) return null;

  const cleanId = certificateId.trim();
  const isConfigured = isSupabaseConfigured();

  if (isConfigured) {
    const supabase = createClient();
    if (supabase) {
      try {
        const { data, error } = await supabase
          .from('certificates')
          .select('certificate_id, student_name, internship_title, issued_at, status')
          .eq('certificate_id', cleanId)
          .eq('status', 'issued')
          .maybeSingle();

        if (!error && data && data.status === 'issued') {
          return {
            certificate_id: data.certificate_id,
            student_name: data.student_name,
            internship_title: data.internship_title,
            issued_at: data.issued_at,
            status: 'issued',
          };
        }
      } catch (err) {
        console.warn('Failed to fetch public certificate from Supabase:', err);
      }
    }
  }

  // Demo fallback
  const list = getLocalCertificates();
  const found = list.find((c) => c.certificate_id.toLowerCase() === cleanId.toLowerCase());
  if (found && found.status === 'issued') {
    return {
      certificate_id: found.certificate_id,
      student_name: found.student_name,
      internship_title: found.internship_title,
      issued_at: found.issued_at,
      status: 'issued',
    };
  }

  return null;
}
