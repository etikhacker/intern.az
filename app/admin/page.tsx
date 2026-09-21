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
  GraduationCap,
} from 'lucide-react';

export default function AdminOverviewPage() {
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
      const fetchedStats = await getAdminStats();
      setStats(fetchedStats);

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
      title: 'Qeydiyyatdan Keçmiş Tələbələr',
      value: stats.totalStudents,
      description: 'Verilənlər bazasında aktiv tələbə profilləri',
      icon: Users,
      color: 'emerald',
    },
    {
      title: 'Aktiv Təcrübə Proqramları',
      value: stats.activeInternships,
      description: 'Açıq elan olunmuş qruplar',
      icon: Briefcase,
      color: 'slate',
    },
    {
      title: 'Gözləyən Müraciətlər',
      value: stats.pendingApplications,
      description: 'Baxılmamış namizəd anketləri',
      icon: FileCheck2,
      color: 'slate',
    },
    {
      title: 'Cari Təcrübəçilər',
      value: stats.activeInterns,
      description: 'Aktiv proqramda olan tələbələr',
      icon: UserCheck,
      color: 'slate',
    },
    {
      title: 'Yoxlanmalı Tapşırıqlar',
      value: stats.pendingSubmissions,
      description: 'Yoxlama gözləyən həllər',
      icon: UploadCloud,
      color: 'slate',
    },
    {
      title: 'Tamamlanmış Təcrübələr',
      value: stats.completedInternships,
      description: 'Mərhələləri bitirmiş məzunlar',
      icon: FileBadge,
      color: 'slate',
    },
    {
      title: 'Sertifikat Müraciətləri',
      value: stats.pendingCertificatePayments,
      description: 'Ödəniş və təsdiq gözləyən',
      icon: CreditCard,
      color: 'slate',
    },
    {
      title: 'Verilmiş Sertifikatlar',
      value: stats.certificatesIssued,
      description: 'Rəsmi kodla təsdiq olunmuş',
      icon: Award,
      color: 'slate',
    },
  ];

  return (
    <div className="space-y-8">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 pb-4 border-b border-slate-800">
        <div>
          <h1 className="text-2xl sm:text-3xl font-bold tracking-tight text-white">
            İnzibatçı Paneli
          </h1>
          <p className="text-xs sm:text-sm text-slate-400 mt-1">
            Platforma idarəetməsi, tələbə qeydiyyatları və təcrübə proqramları göstəriciləri.
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
            Yenilə
          </Button>
        </div>
      </div>

      {/* 8 Statistics Cards Grid */}
      <div>
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-xs font-bold uppercase tracking-wider text-slate-400">
            Sistem Göstəriciləri
          </h2>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
          {statCards.map((card) => {
            const Icon = card.icon;
            return (
              <Card
                key={card.title}
                className="bg-slate-900/90 text-white border border-slate-800 shadow-2xs"
              >
                <CardHeader className="p-4 pb-2 flex flex-row items-center justify-between space-y-0">
                  <span className="text-xs font-medium text-slate-300">
                    {card.title}
                  </span>
                  <div className="p-2 rounded-lg bg-slate-800 text-amber-400">
                    <Icon className="w-4 h-4" />
                  </div>
                </CardHeader>
                <CardContent className="p-4 pt-1">
                  <div className="text-2xl sm:text-3xl font-bold tracking-tight text-white">
                    {card.value}
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

      {/* Registered Students Table */}
      <Card className="bg-slate-900 border-slate-800 text-white">
        <CardHeader className="border-b border-slate-800 pb-4">
          <div className="flex items-center justify-between">
            <div>
              <CardTitle className="text-base text-white flex items-center gap-2">
                <Users className="w-4 h-4 text-amber-400" />
                Qeydiyyatdan Keçmiş Tələbələr
              </CardTitle>
              <CardDescription className="text-xs text-slate-400 mt-0.5">
                Universitetlər üzrə qeydiyyatdan keçmiş tələbələrin siyahısı
              </CardDescription>
            </div>
            <Badge variant="default" className="bg-amber-400/20 text-amber-300 border-amber-400/30">
              {students.length} Tələbə
            </Badge>
          </div>
        </CardHeader>

        <CardContent className="p-0 overflow-x-auto">
          {students.length === 0 ? (
            <div className="p-8 text-center text-slate-500 text-xs">
              Hələlik qeydiyyatdan keçmiş tələbə tapılmadı.
            </div>
          ) : (
            <table className="w-full text-left text-xs text-slate-300">
              <thead className="bg-slate-950 text-slate-400 text-[11px] uppercase tracking-wider border-b border-slate-800">
                <tr>
                  <th className="px-6 py-3 font-semibold">Tələbə</th>
                  <th className="px-6 py-3 font-semibold">Universitet</th>
                  <th className="px-6 py-3 font-semibold">E-poçt</th>
                  <th className="px-6 py-3 font-semibold">Rol</th>
                  <th className="px-6 py-3 font-semibold">Tarix</th>
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
                        <GraduationCap className="w-3.5 h-3.5 text-amber-400 shrink-0" />
                        <span>{student.university || 'Qeyd olunmayıb'}</span>
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
                      {student.created_at ? new Date(student.created_at).toLocaleDateString('az-AZ') : '—'}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
