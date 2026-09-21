'use client';

import React, { createContext, useContext, useEffect, useState, useCallback } from 'react';
import { useRouter } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';
import { isSupabaseConfigured } from '@/lib/supabase/config';
import { Profile, ProfileUpdateInput, UserRole } from '@/types/database';
import type { AuthChangeEvent, Session } from '@supabase/supabase-js';

interface AuthContextType {
  user: { id: string; email: string } | null;
  profile: Profile | null;
  role: UserRole | null;
  isLoading: boolean;
  isConfigured: boolean;
  error: string | null;
  signUp: (params: { fullName: string; email: string; password: string; university: string }) => Promise<{ success: boolean; error?: string }>;
  signIn: (params: { email: string; password: string }) => Promise<{ success: boolean; error?: string; role?: UserRole }>;
  signOut: () => Promise<void>;
  updateProfile: (input: ProfileUpdateInput) => Promise<{ success: boolean; error?: string; profile?: Profile }>;
  refreshProfile: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

// Local storage key for demo mode when live Supabase credentials aren't entered yet
const DEMO_STORAGE_KEY = 'internship_az_demo_session';
const DEMO_PROFILES_KEY = 'internship_az_demo_profiles';

// Initial demo seed data
const DEFAULT_DEMO_PROFILES: Profile[] = [
  {
    id: 'demo-student-1',
    user_id: 'user-student-1',
    full_name: 'Leyla Mammadova',
    email: 'leyla.m@ada.edu.az',
    role: 'student',
    university: 'ADA University',
    phone: '+994 50 123 45 67',
    avatar_url: null,
    created_at: new Date(Date.now() - 7 * 86400000).toISOString(),
    updated_at: new Date().toISOString(),
  },
  {
    id: 'demo-student-2',
    user_id: 'user-student-2',
    full_name: 'Murad Aliyev',
    email: 'murad.a@bsu.edu.az',
    role: 'student',
    university: 'Baku State University',
    phone: '+994 55 987 65 43',
    avatar_url: null,
    created_at: new Date(Date.now() - 3 * 86400000).toISOString(),
    updated_at: new Date().toISOString(),
  },
  {
    id: 'demo-student-3',
    user_id: 'user-student-3',
    full_name: 'Aysel Huseynova',
    email: 'aysel.h@asoiu.edu.az',
    role: 'student',
    university: 'Azerbaijan State Oil and Industry University',
    phone: '+994 70 345 67 89',
    avatar_url: null,
    created_at: new Date(Date.now() - 1 * 86400000).toISOString(),
    updated_at: new Date().toISOString(),
  },
  {
    id: 'demo-admin-1',
    user_id: 'user-admin-1',
    full_name: 'Admin Supervisor',
    email: 'admin@intern.az',
    role: 'admin',
    university: 'Ministry of Digital Development and Transport',
    phone: '+994 12 598 00 00',
    avatar_url: null,
    created_at: new Date(Date.now() - 30 * 86400000).toISOString(),
    updated_at: new Date().toISOString(),
  },
];

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<{ id: string; email: string } | null>(null);
  const [profile, setProfile] = useState<Profile | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const router = useRouter();
  const isConfigured = isSupabaseConfigured();

  // Helper to get demo profiles from localStorage
  const getDemoProfiles = useCallback((): Profile[] => {
    if (typeof window === 'undefined') return DEFAULT_DEMO_PROFILES;
    try {
      const stored = localStorage.getItem(DEMO_PROFILES_KEY);
      if (stored) return JSON.parse(stored);
      localStorage.setItem(DEMO_PROFILES_KEY, JSON.stringify(DEFAULT_DEMO_PROFILES));
      return DEFAULT_DEMO_PROFILES;
    } catch {
      return DEFAULT_DEMO_PROFILES;
    }
  }, []);

  // Helper to save demo profiles
  const saveDemoProfiles = useCallback((profiles: Profile[]) => {
    if (typeof window === 'undefined') return;
    try {
      localStorage.setItem(DEMO_PROFILES_KEY, JSON.stringify(profiles));
    } catch {
      // ignore
    }
  }, []);

  // Fetch real profile from Supabase
  const fetchSupabaseProfile = useCallback(async (userId: string) => {
    const supabase = createClient();
    if (!supabase) return null;

    try {
      const { data, error } = await supabase
        .from('profiles')
        .select('*')
        .eq('user_id', userId)
        .single();

      if (error) {
        console.warn('Profile fetch warning:', error.message);
        return null;
      }
      return data as Profile;
    } catch (err) {
      console.warn('Profile fetch exception:', err);
      return null;
    }
  }, []);

  const refreshProfile = useCallback(async () => {
    if (!user) return;

    if (isConfigured) {
      const fresh = await fetchSupabaseProfile(user.id);
      if (fresh) {
        setProfile(fresh);
      }
    } else {
      const profiles = getDemoProfiles();
      const current = profiles.find((p) => p.user_id === user.id);
      if (current) {
        setProfile(current);
      }
    }
  }, [user, isConfigured, fetchSupabaseProfile, getDemoProfiles]);

  // Initial Auth Check
  useEffect(() => {
    let isMounted = true;

    async function initAuth() {
      setIsLoading(true);

      if (isConfigured) {
        const supabase = createClient();
        if (!supabase) {
          setIsLoading(false);
          return;
        }

        try {
          const {
            data: { session },
          } = await supabase.auth.getSession();

          if (session?.user && isMounted) {
            setUser({ id: session.user.id, email: session.user.email || '' });
            const prof = await fetchSupabaseProfile(session.user.id);
            if (prof && isMounted) {
              setProfile(prof);
            }
          }

          const {
            data: { subscription },
          } = supabase.auth.onAuthStateChange(async (_event: AuthChangeEvent, session: Session | null) => {
            if (!isMounted) return;
            if (session?.user) {
              setUser({ id: session.user.id, email: session.user.email || '' });
              const prof = await fetchSupabaseProfile(session.user.id);
              if (isMounted) setProfile(prof);
            } else {
              setUser(null);
              setProfile(null);
            }
          });

          return () => {
            subscription.unsubscribe();
          };
        } catch (err) {
          console.error('Supabase init error:', err);
        } finally {
          if (isMounted) setIsLoading(false);
        }
      } else {
        // Demo mode initialization
        if (typeof window !== 'undefined') {
          const storedSession = localStorage.getItem(DEMO_STORAGE_KEY);
          if (storedSession) {
            try {
              const parsed = JSON.parse(storedSession);
              setUser({ id: parsed.user_id, email: parsed.email });
              const profiles = getDemoProfiles();
              const existing = profiles.find((p) => p.user_id === parsed.user_id);
              if (existing) {
                setProfile(existing);
              } else {
                setProfile(parsed);
              }
            } catch {
              localStorage.removeItem(DEMO_STORAGE_KEY);
            }
          }
        }
        if (isMounted) setIsLoading(false);
      }
    }

    initAuth();

    return () => {
      isMounted = false;
    };
  }, [isConfigured, fetchSupabaseProfile, getDemoProfiles]);

  // Sign Up: Always creates student role
  const signUp = async ({
    fullName,
    email,
    password,
    university,
  }: {
    fullName: string;
    email: string;
    password: string;
    university: string;
  }): Promise<{ success: boolean; error?: string }> => {
    setError(null);

    if (isConfigured) {
      const supabase = createClient();
      if (!supabase) return { success: false, error: 'Supabase client unavailable' };

      try {
        const { data, error: signUpError } = await supabase.auth.signUp({
          email,
          password,
          options: {
            data: {
              full_name: fullName,
              university,
            },
          },
        });

        if (signUpError) {
          return { success: false, error: signUpError.message };
        }

        if (data.user) {
          // If profile trigger didn't catch or is delayed, attempt insert or select
          let prof = await fetchSupabaseProfile(data.user.id);
          if (!prof) {
            // Fallback insert if trigger hasn't fired
            const { data: newProfile } = await supabase
              .from('profiles')
              .insert({
                user_id: data.user.id,
                full_name: fullName,
                email,
                university,
                role: 'student', // ALWAYS student
              })
              .select()
              .single();
            if (newProfile) prof = newProfile as Profile;
          }

          setUser({ id: data.user.id, email: data.user.email || email });
          setProfile(prof);
          return { success: true };
        }

        return { success: true };
      } catch (err: unknown) {
        const message = err instanceof Error ? err.message : 'An unexpected error occurred during registration';
        return { success: false, error: message };
      }
    } else {
      // Demo mode registration
      const profiles = getDemoProfiles();
      const existing = profiles.find((p) => p.email.toLowerCase() === email.toLowerCase());
      if (existing) {
        return { success: false, error: 'An account with this email already exists.' };
      }

      const newUserId = `user-${Date.now()}`;
      const newProfile: Profile = {
        id: `profile-${Date.now()}`,
        user_id: newUserId,
        full_name: fullName,
        email,
        role: 'student', // Strictly 'student'
        university,
        phone: null,
        avatar_url: null,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
      };

      const updatedProfiles = [...profiles, newProfile];
      saveDemoProfiles(updatedProfiles);

      setUser({ id: newUserId, email });
      setProfile(newProfile);
      localStorage.setItem(DEMO_STORAGE_KEY, JSON.stringify(newProfile));

      return { success: true };
    }
  };

  // Sign In
  const signIn = async ({
    email,
    password,
  }: {
    email: string;
    password: string;
  }): Promise<{ success: boolean; error?: string; role?: UserRole }> => {
    setError(null);

    if (isConfigured) {
      const supabase = createClient();
      if (!supabase) return { success: false, error: 'Supabase client unavailable' };

      try {
        const { data, error: signInError } = await supabase.auth.signInWithPassword({
          email,
          password,
        });

        if (signInError) {
          if (signInError.message.includes('Invalid login credentials')) {
            return { success: false, error: 'Incorrect email or password. Please try again.' };
          }
          return { success: false, error: signInError.message };
        }

        if (data.user) {
          const prof = await fetchSupabaseProfile(data.user.id);
          setUser({ id: data.user.id, email: data.user.email || email });
          setProfile(prof);
          return { success: true, role: prof?.role || 'student' };
        }

        return { success: false, error: 'Failed to retrieve user session.' };
      } catch (err: unknown) {
        const message = err instanceof Error ? err.message : 'Login failed due to unexpected error.';
        return { success: false, error: message };
      }
    } else {
      // Demo Mode login
      const profiles = getDemoProfiles();
      const target = profiles.find((p) => p.email.toLowerCase() === email.toLowerCase());

      if (!target) {
        return {
          success: false,
          error: 'No account found with this email. (In demo mode, use leyla.m@ada.edu.az or admin@intern.az, or create a new student account).',
        };
      }

      setUser({ id: target.user_id, email: target.email });
      setProfile(target);
      localStorage.setItem(DEMO_STORAGE_KEY, JSON.stringify(target));

      return { success: true, role: target.role };
    }
  };

  // Sign Out
  const signOut = async () => {
    if (isConfigured) {
      const supabase = createClient();
      if (supabase) {
        await supabase.auth.signOut();
      }
    } else {
      if (typeof window !== 'undefined') {
        localStorage.removeItem(DEMO_STORAGE_KEY);
      }
    }

    setUser(null);
    setProfile(null);
    router.push('/login');
  };

  // Update Profile: students can ONLY update full_name, phone, university, avatar_url
  const updateProfile = async (
    input: ProfileUpdateInput
  ): Promise<{ success: boolean; error?: string; profile?: Profile }> => {
    if (!user || !profile) {
      return { success: false, error: 'You must be logged in to update your profile.' };
    }

    if (isConfigured) {
      const supabase = createClient();
      if (!supabase) return { success: false, error: 'Database connection unavailable.' };

      try {
        const { data, error: updateError } = await supabase
          .from('profiles')
          .update({
            full_name: input.full_name?.trim() || profile.full_name,
            phone: input.phone !== undefined ? input.phone : profile.phone,
            university: input.university !== undefined ? input.university : profile.university,
            avatar_url: input.avatar_url !== undefined ? input.avatar_url : profile.avatar_url,
            updated_at: new Date().toISOString(),
          })
          .eq('user_id', user.id)
          .select()
          .single();

        if (updateError) {
          return { success: false, error: updateError.message };
        }

        const updated = data as Profile;
        setProfile(updated);
        return { success: true, profile: updated };
      } catch (err: unknown) {
        const message = err instanceof Error ? err.message : 'Failed to update profile.';
        return { success: false, error: message };
      }
    } else {
      // Demo mode update
      const profiles = getDemoProfiles();
      const index = profiles.findIndex((p) => p.user_id === user.id);

      if (index === -1) {
        return { success: false, error: 'Profile not found.' };
      }

      const updated: Profile = {
        ...profiles[index],
        full_name: input.full_name?.trim() || profiles[index].full_name,
        phone: input.phone !== undefined ? input.phone : profiles[index].phone,
        university: input.university !== undefined ? input.university : profiles[index].university,
        avatar_url: input.avatar_url !== undefined ? input.avatar_url : profiles[index].avatar_url,
        updated_at: new Date().toISOString(),
        // user_id, role, email, created_at strictly untouched
        role: profiles[index].role,
        email: profiles[index].email,
        user_id: profiles[index].user_id,
        created_at: profiles[index].created_at,
      };

      profiles[index] = updated;
      saveDemoProfiles(profiles);
      setProfile(updated);
      localStorage.setItem(DEMO_STORAGE_KEY, JSON.stringify(updated));

      return { success: true, profile: updated };
    }
  };

  return (
    <AuthContext.Provider
      value={{
        user,
        profile,
        role: profile?.role || null,
        isLoading,
        isConfigured,
        error,
        signUp,
        signIn,
        signOut,
        updateProfile,
        refreshProfile,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}
