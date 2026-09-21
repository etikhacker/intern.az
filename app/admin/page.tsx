'use client';

import React, { useEffect, useState, useCallback } from 'react';
import { useAuth } from '@/lib/auth/auth-context';
import { createClient } from '@/lib/supabase/client';
import { isSupabaseConfigured } from '@/lib/supabase/config';
import { getAdminStats } from '@/lib/admin/stats';
import { AdminStats, Profile } from '@/types/database';
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Avatar } from '@/components/ui/avatar';
import {
  Users,
  Briefcase,
  FileCheck2,
  UserCheck,
  UploadCloud,
  FileBadge,
  CreditCard,
  Award,
  RefreshCw,
  ShieldAlert,
  Database,
  Calendar,
  GraduationCap,
  Sparkles,
  Info,
} from 'lucide-react';

export default function AdminOverviewPage() {
  const { profile } = useAuth();
  const [stats, setStats] = useState<AdminStats>({
    totalStudents: 0,
    activeInternships: 0,
    pendingApplications: 0,
    activeInterns: 0,
    pendingSubmissions: 0,
    completedInternships: 0,
    pendingCertificatePayments: 0,
    certificatesIssued: 0,
  });
  const [students, setStudents] = useState<Profile[]>([]);
  const [loading, setLoading] = useState(true);
  const isConfigured = isSupabaseConfigured();

  const loadData = useCallback(async () => {
    setLoading(true);
    try {
      // 1. Fetch Stats
      const fetchedStats = await getAdminStats();
      setStats(fetchedStats);

      // 2. Fetch Students List
      if (isConfigured) {
        const supabase = createClient();
        if (supabase) {
          const { data, error } = await supabase
            .from('profiles')
            .select('*')
            .eq('role', 'student')
            .order('created_at', { ascending: false });

          if (!error && data) {
            setStudents(data as Profile[]);
          }
        }
      } else {
        // Demo fallback students
        if (typeof window !== 'undefined') {
          const stored = localStorage.getItem('internship_az_demo_profiles');
          if (stored) {
            const parsed = JSON.parse(stored);
            if (Array.isArray(parsed)) {
              setStudents(parsed.filter((p: Profile) => p.role === 'student'));
            }
          }
        }
      }
    } catch (err) {
      console.warn('Failed to load admin data:', err);
    } finally {
      setLoading(false);
    }
  }, [isConfigured]);

  useEffect(() => {
    let isMounted = true;

    async function initialFetch() {
      try {
        const fetchedStats = await getAdminStats();
        if (!isMounted) return;
        setStats(fetchedStats);

        if (isConfigured) {
          const supabase = createClient();
          if (supabase) {
            const { data, error } = await supabase
              .from('profiles')
              .select('*')
              .eq('role', 'student')
              .order('created_at', { ascending: false });

            if (!isMounted) return;
            if (!error && data) {
              setStudents(data as Profile[]);
            }
          }
        } else if (typeof window !== 'undefined') {
          const stored = localStorage.getItem('internship_az_demo_profiles');
          if (stored) {
            const parsed = JSON.parse(stored);
            if (!isMounted) return;
            if (Array.isArray(parsed)) {
              setStudents(parsed.filter((p: Profile) => p.role === 'student'));
            }
          }
        }
      } catch (err) {
        console.warn('Initial admin data fetch error:', err);
      } finally {
        if (isMounted) setLoading(false);
      }
    }

    initialFetch();

    return () => {
      isMounted = false;
    };
  }, [isConfigured]);

  const statCards = [
    {
      title: 'Total Students',
      value: stats.totalStudents,
      description: 'Retrieved live from PostgreSQL profiles table',
      icon: Users,
      color: 'emerald',
      isLive: true,
    },
    {
      title: 'Active Internships',
      value: stats.activeInternships,
      description: 'Coming in Phase 2 (Cohort tracks)',
      icon: Briefcase,
      color: 'slate',
      isLive: false,
    },
    {
      title: 'Pending Applications',
      value: stats.pendingApplications,
      description: 'Coming in Phase 2 (Student reviews)',
      icon: FileCheck2,
      color: 'slate',
      isLive: false,
    },
    {
      title: 'Active Interns',
      value: stats.activeInterns,
      description: 'Coming in Phase 3 (Enrolled students)',
      icon: UserCheck,
      color: 'slate',
      isLive: false,
    },
    {
      title: 'Pending Submissions',
      value: stats.pendingSubmissions,
      description: 'Coming in Phase 3 (Task reviews)',
      icon: UploadCloud,
      color: 'slate',
      isLive: false,
    },
    {
      title: 'Completed Internships',
      value: stats.completedInternships,
      description: 'Coming in Phase 4 (Final project completions)',
      icon: FileBadge,
      color: 'slate',
      isLive: false,
    },
    {
      title: 'Pending Certificate Payments',
      value: stats.pendingCertificatePayments,
      description: 'Coming in Phase 4 (Manual bank transfer receipts)',
      icon: CreditCard,
      color: 'slate',
      isLive: false,
    },
    {
      title: 'Certificates Issued',
      value: stats.certificatesIssued,
      description: 'Coming in Phase 4 (Approved credentials)',
      icon: Award,
      color: 'slate',
      isLive: false,
    },
  ];

  return (
    <div className="space-y-8">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 pb-4 border-b border-slate-800">
        <div>
          <div className="flex items-center gap-2 mb-1">
            <h1 className="text-2xl sm:text-3xl font-bold tracking-tight text-white">
              Administrator Overview
            </h1>
            <Badge variant="admin" className="text-xs bg-amber-400/20 text-amber-300 border-amber-400/40">
              Phase 1
            </Badge>
          </div>
          <p className="text-xs sm:text-sm text-slate-400">
            Platform governance and synchronized student metrics for Azerbaijan internship cohorts.
          </p>
        </div>

        <div className="flex items-center gap-2">
          <Button
            variant="outline"
            size="sm"
            onClick={loadData}
            disabled={loading}
            className="gap-1.5 text-xs bg-slate-900 border-slate-700 text-slate-300 hover:bg-slate-800 hover:text-white"
          >
            <RefreshCw className={`w-3.5 h-3.5 ${loading ? 'animate-spin' : ''}`} />
            Refresh Data
          </Button>
        </div>
      </div>

      {/* 8 Statistics Cards Grid */}
      <div>
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-xs font-bold uppercase tracking-wider text-slate-400">
            Platform Metrics
          </h2>
          <span className="text-[11px] text-slate-500">
            Phase 1: Total Students active • Other metrics reserved for future phases
          </span>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
          {statCards.map((card) => {
            const Icon = card.icon;
            return (
              <Card
                key={card.title}
                className={`bg-slate-900/90 text-white border transition-all ${
                  card.isLive
                    ? 'border-emerald-500/60 shadow-lg shadow-emerald-950/30'
                    : 'border-slate-800/80 opacity-80'
                }`}
              >
                <CardHeader className="p-4 pb-2 flex flex-row items-center justify-between space-y-0">
                  <span className="text-xs font-medium text-slate-300">
                    {card.title}
                  </span>
                  <div
                    className={`p-2 rounded-lg ${
                      card.isLive
                        ? 'bg-emerald-500/20 text-emerald-400'
                        : 'bg-slate-800 text-slate-500'
                    }`}
                  >
                    <Icon className="w-4 h-4" />
                  </div>
                </CardHeader>
                <CardContent className="p-4 pt-1">
                  <div className="flex items-baseline gap-2">
                    <span className="text-2xl sm:text-3xl font-bold tracking-tight text-white">
                      {card.value}
                    </span>
                    {card.isLive ? (
                      <span className="text-[10px] font-bold text-emerald-400 uppercase tracking-wide">
                        Database Synchronized
                      </span>
                    ) : (
                      <span className="text-[10px] text-slate-500 uppercase tracking-wide">
                        Phase 2+
                      </span>
                    )}
                  </div>
                  <p className="text-[11px] text-slate-400 mt-1 leading-snug">
                    {card.description}
                  </p>
                </CardContent>
              </Card>
            );
          })}
        </div>
      </div>

      {/* Registered Students Table (Phase 1 Inspection) */}
      <Card className="bg-slate-900 border-slate-800 text-white">
        <CardHeader className="border-b border-slate-800 pb-4">
          <div className="flex items-center justify-between">
            <div>
              <CardTitle className="text-base text-white flex items-center gap-2">
                <Users className="w-4 h-4 text-emerald-400" />
                Registered Students Directory
              </CardTitle>
              <CardDescription className="text-xs text-slate-400 mt-0.5">
                Students registered across universities in Azerbaijan currently in database
              </CardDescription>
            </div>
            <Badge variant="default" className="bg-emerald-950/60 text-emerald-300 border border-emerald-800">
              {students.length} Total Registered
            </Badge>
          </div>
        </CardHeader>

        <CardContent className="p-0 overflow-x-auto">
          {students.length === 0 ? (
            <div className="p-8 text-center text-slate-500 text-xs">
              No registered students found yet. Register a student via /register to see them populate here!
            </div>
          ) : (
            <table className="w-full text-left text-xs text-slate-300">
              <thead className="bg-slate-950 text-slate-400 text-[11px] uppercase tracking-wider border-b border-slate-800">
                <tr>
                  <th className="px-6 py-3 font-semibold">Student Name</th>
                  <th className="px-6 py-3 font-semibold">University</th>
                  <th className="px-6 py-3 font-semibold">Email</th>
                  <th className="px-6 py-3 font-semibold">Role</th>
                  <th className="px-6 py-3 font-semibold">Registered</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-800/60">
                {students.map((student) => (
                  <tr key={student.id} className="hover:bg-slate-800/40 transition-colors">
                    <td className="px-6 py-3.5 flex items-center gap-3">
                      <Avatar
                        src={student.avatar_url}
                        fallback={student.full_name}
                        size="sm"
                        className="ring-slate-700"
                      />
                      <span className="font-semibold text-white">
                        {student.full_name}
                      </span>
                    </td>
                    <td className="px-6 py-3.5">
                      <div className="flex items-center gap-1.5 text-slate-300">
                        <GraduationCap className="w-3.5 h-3.5 text-emerald-400 shrink-0" />
                        <span>{student.university || 'Not Specified'}</span>
                      </div>
                    </td>
                    <td className="px-6 py-3.5 font-mono text-slate-400 text-[11px]">
                      {student.email}
                    </td>
                    <td className="px-6 py-3.5">
                      <Badge variant="default" className="text-[10px] py-0 px-2 bg-emerald-950 text-emerald-300 border-emerald-800">
                        {student.role}
                      </Badge>
                    </td>
                    <td className="px-6 py-3.5 text-slate-400 text-[11px]">
                      {student.created_at ? new Date(student.created_at).toLocaleDateString('en-US') : 'N/A'}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </CardContent>
      </Card>

      {/* Security & Admin Management Guide Card */}
      <Card className="bg-slate-900/60 border-slate-800 text-slate-300">
        <CardHeader className="pb-3">
          <div className="flex items-center gap-2">
            <ShieldAlert className="w-5 h-5 text-amber-400" />
            <CardTitle className="text-sm text-white">
              First Admin Account Creation & Security Protocol
            </CardTitle>
          </div>
          <CardDescription className="text-xs text-slate-400">
            Per architectural guidelines, administrative access is strictly managed server-side and never granted through public web signup forms.
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-3 text-xs">
          <p className="text-slate-400 leading-relaxed">
            To create or promote an administrator in your live Supabase database:
          </p>
          <div className="bg-slate-950 p-3 rounded-lg font-mono text-amber-300 text-[11px] overflow-x-auto border border-slate-800">
            <pre>{`-- Run in Supabase Dashboard SQL Editor to grant admin role:
UPDATE public.profiles
SET role = 'admin'
WHERE email = 'your-admin-email@domain.com';`}</pre>
          </div>
          <p className="text-[11px] text-slate-500">
            The Supabase Row Level Security policies automatically recognize this change and grant access to the admin console upon next session refresh.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
