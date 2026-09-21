'use client';

import React from 'react';
import Link from 'next/link';
import { useAuth } from '@/lib/auth/auth-context';
import { Card, CardHeader, CardTitle, CardDescription, CardContent, CardFooter } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Avatar } from '@/components/ui/avatar';
import {
  User,
  GraduationCap,
  Mail,
  Shield,
  Briefcase,
  ArrowRight,
  Calendar,
  Clock,
  CheckCircle2,
  FileText,
} from 'lucide-react';

export default function StudentDashboardPage() {
  const { profile, user } = useAuth();

  const formattedJoinDate = profile?.created_at
    ? new Date(profile.created_at).toLocaleDateString('az-AZ', {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
      })
    : 'Yenicə';

  return (
    <div className="space-y-6">
      {/* Top Banner / Welcome */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 pb-4 border-b border-slate-200/80">
        <div>
          <h1 className="text-2xl sm:text-3xl font-bold tracking-tight text-slate-900">
            Tələbə İdarəetmə Paneli
          </h1>
          <p className="text-xs sm:text-sm text-slate-500 mt-1">
            Xoş gəldiniz, {profile?.full_name || 'Tələbə'}. Təcrübə müraciətləriniz və profil statusunuz.
          </p>
        </div>

        <div className="flex items-center gap-2">
          <Link href="/dashboard/profile">
            <Button variant="outline" size="sm" className="gap-1.5 text-xs">
              <User className="w-3.5 h-3.5 text-emerald-600" />
              Profili redaktə et
            </Button>
          </Link>
        </div>
      </div>

      {/* Main Student Profile & Internship Status Card */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Left 2 Cols: Detailed Student Profile Card */}
        <Card className="lg:col-span-2 border-slate-200/90 shadow-2xs">
          <CardHeader className="pb-4 border-b border-slate-100">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-3">
                <Avatar
                  src={profile?.avatar_url}
                  fallback={profile?.full_name || 'ST'}
                  size="lg"
                  className="border-2 border-emerald-100 ring-2 ring-emerald-50"
                />
                <div>
                  <CardTitle className="text-xl text-slate-900">
                    {profile?.full_name || 'Tələbə İstifadəçi'}
                  </CardTitle>
                  <p className="text-xs text-slate-500 flex items-center gap-1.5 mt-0.5">
                    <GraduationCap className="w-3.5 h-3.5 text-emerald-600" />
                    <span>{profile?.university || 'Universitet qeyd olunmayıb'}</span>
                  </p>
                </div>
              </div>
              <Badge variant="default" className="text-xs capitalize py-1 px-3">
                Tələbə
              </Badge>
            </div>
          </CardHeader>

          <CardContent className="pt-6">
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 text-xs">
              <div className="p-3.5 rounded-xl bg-slate-50 border border-slate-100">
                <p className="text-[11px] font-semibold text-slate-400 uppercase tracking-wider mb-1 flex items-center gap-1">
                  <Mail className="w-3 h-3 text-slate-400" />
                  E-poçt ünvanı
                </p>
                <p className="text-xs font-semibold text-slate-800 break-all">
                  {profile?.email || user?.email || '—'}
                </p>
              </div>

              <div className="p-3.5 rounded-xl bg-slate-50 border border-slate-100">
                <p className="text-[11px] font-semibold text-slate-400 uppercase tracking-wider mb-1 flex items-center gap-1">
                  <GraduationCap className="w-3 h-3 text-slate-400" />
                  Təhsil Müəssisəsi
                </p>
                <p className="text-xs font-semibold text-slate-800">
                  {profile?.university || 'Qeyd olunmayıb'}
                </p>
              </div>

              <div className="p-3.5 rounded-xl bg-slate-50 border border-slate-100">
                <p className="text-[11px] font-semibold text-slate-400 uppercase tracking-wider mb-1 flex items-center gap-1">
                  <Shield className="w-3 h-3 text-slate-400" />
                  Status
                </p>
                <p className="text-xs font-semibold text-emerald-700 font-bold">
                  Aktiv Tələbə Hesabı
                </p>
              </div>

              <div className="p-3.5 rounded-xl bg-slate-50 border border-slate-100">
                <p className="text-[11px] font-semibold text-slate-400 uppercase tracking-wider mb-1 flex items-center gap-1">
                  <Calendar className="w-3 h-3 text-slate-400" />
                  Qeydiyyat tarixi
                </p>
                <p className="text-xs font-semibold text-slate-800">
                  {formattedJoinDate}
                </p>
              </div>
            </div>
          </CardContent>

          <CardFooter className="bg-slate-50/60 border-t border-slate-100 flex items-center justify-between text-xs text-slate-500 py-3">
            <span>Profil məlumatlarınız rəsmi sertifikatda əks olunur.</span>
            <Link href="/dashboard/profile" className="text-emerald-700 font-semibold hover:underline flex items-center gap-1">
              Profili yenilə
              <ArrowRight className="w-3 h-3" />
            </Link>
          </CardFooter>
        </Card>

        {/* Right Col: Internship Status Card */}
        <Card className="border-slate-200/90 shadow-2xs flex flex-col justify-between">
          <div>
            <CardHeader className="pb-3 border-b border-slate-100">
              <CardTitle className="text-base flex items-center gap-2">
                <Briefcase className="w-4 h-4 text-emerald-600" />
                Aktiv Təcrübə Statusu
              </CardTitle>
              <CardDescription className="text-xs">
                Cari təcrübə proqramınızın vəziyyəti
              </CardDescription>
            </CardHeader>

            <CardContent className="pt-6 text-center">
              <div className="w-16 h-16 rounded-2xl bg-slate-50 text-slate-400 flex items-center justify-center mx-auto mb-3 border border-slate-200">
                <Clock className="w-8 h-8" />
              </div>
              <div className="inline-block px-3 py-1 rounded-full bg-slate-100 text-slate-700 text-xs font-semibold mb-2">
                Aktiv proqram yoxdur
              </div>
              <p className="text-xs text-slate-500 leading-relaxed max-w-xs mx-auto">
                Hazırda hər hansı təcrübə proqramına qoşulmamısınız. Təcrübələr bölməsindən açıq vakansiyalara müraciət edə bilərsiniz.
              </p>
            </CardContent>
          </div>

          <CardFooter className="p-4 bg-slate-50/60 border-t border-slate-100">
            <Link href="/dashboard/internships" className="w-full">
              <Button variant="outline" size="sm" className="w-full text-xs">
                Təcrübə proqramlarına bax
              </Button>
            </Link>
          </CardFooter>
        </Card>
      </div>

      {/* Student Action Card */}
      <Card className="bg-white border-slate-200 shadow-2xs">
        <CardContent className="p-6">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
            <div className="space-y-1">
              <h3 className="text-base font-bold text-slate-900">
                Müraciət etməyə hazırsınız?
              </h3>
              <p className="text-xs text-slate-500">
                Profil məlumatlarınız tamamlandıqdan sonra açıq təcrübə qruplarına müraciət göndərə bilərsiniz.
              </p>
            </div>
            <div className="flex gap-2">
              <Link href="/dashboard/applications">
                <Button variant="outline" size="sm" className="gap-1.5">
                  <FileText className="w-4 h-4" />
                  Müraciətlərim
                </Button>
              </Link>
              <Link href="/dashboard/internships">
                <Button size="sm" className="gap-1.5 shadow-xs">
                  Təcrübələri kəşf et
                  <ArrowRight className="w-4 h-4" />
                </Button>
              </Link>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
