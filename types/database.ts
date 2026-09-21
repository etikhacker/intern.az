export type UserRole = 'student' | 'admin';

export interface Profile {
  id: string;
  user_id: string;
  full_name: string;
  email: string;
  role: UserRole;
  avatar_url: string | null;
  phone: string | null;
  university: string | null;
  created_at: string;
  updated_at: string;
}

export interface ProfileUpdateInput {
  full_name?: string;
  phone?: string | null;
  university?: string | null;
  avatar_url?: string | null;
}

export interface AdminStats {
  totalStudents: number;
  activeInternships: number;
  pendingApplications: number;
  activeInterns: number;
  pendingSubmissions: number;
  completedInternships: number;
  pendingCertificatePayments: number;
  certificatesIssued: number;
}
