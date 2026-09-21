'use client';

import React, { useEffect, useState } from 'react';
import Link from 'next/link';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { useAuth } from '@/lib/auth/auth-context';
import { useLanguage } from '@/lib/i18n/language-context';
import { getStudentActiveEnrollment } from '@/lib/enrollments/service';
import { Enrollment } from '@/types/database';
import {
  Briefcase,
  ArrowRight,
  Clock,
  Calendar,
  Layers,
  CheckCircle2,
  ShieldCheck,
  Award,
  ListTodo,
} from 'lucide-react';

export default function StudentMyInternshipPage() {
  const { profile } = useAuth();
  const { language, t } = useLanguage();
  const isAz = language === 'az';

  const [enrollment, setEnrollment] = useState<Enrollment | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function load() {
      if (!profile?.id) return;
      setLoading(true);
      try {
        const active = await getStudentActiveEnrollment(profile.id);
        setEnrollment(active);
      } catch (err) {
        console.error('Failed to load active enrollment:', err);
      } finally {
        setLoading(false);
      }
    }
    load();
  }, [profile?.id]);

  const formatDate = (dateStr: string | null) => {
    if (!dateStr) return null;
    try {
      return new Date(dateStr).toLocaleDateString(isAz ? 'az-AZ' : 'en-US', {
        day: 'numeric',
        month: 'long',
        year: 'numeric',
      });
    } catch {
      return dateStr;
    }
  };

  return (
    <div className="space-y-6">
      <div className="pb-4 border-b border-slate-200">
        <h1 className="text-2xl font-bold text-slate-900 tracking-tight">
          {t('activeInternshipTitle')}
        </h1>
        <p className="text-xs text-slate-500 mt-1">
          {t('activeInternshipSubtitle')}
        </p>
      </div>

      {loading ? (
        <div className="py-12 flex justify-center">
          <div className="w-8 h-8 border-2 border-emerald-600 border-t-transparent rounded-full animate-spin"></div>
        </div>
      ) : enrollment && enrollment.internship ? (
        <div className="space-y-6">
          {/* Active Program Card */}
          <div className="bg-white rounded-2xl border border-slate-200 p-6 sm:p-7 shadow-2xs space-y-6">
            <div className="flex flex-wrap items-center justify-between gap-3 pb-4 border-b border-slate-100">
              <div className="flex items-center gap-2">
                <Badge variant="outline" className="bg-slate-50 text-slate-700 border-slate-200 text-2xs uppercase font-semibold">
                  {enrollment.internship.category}
                </Badge>
                <Badge className="bg-emerald-50 text-emerald-700 border-emerald-200 text-xs font-semibold gap-1">
                  <CheckCircle2 className="w-3.5 h-3.5 text-emerald-600" />
                  {isAz ? 'Aktiv Təcrübə' : 'Active Enrollment'}
                </Badge>
              </div>
              <span className="text-xs text-slate-400">
                {isAz ? 'Qəbul tarixi:' : 'Enrolled on:'} {formatDate(enrollment.enrolled_at)}
              </span>
            </div>

            <div>
              <h2 className="text-2xl font-extrabold text-slate-900 mb-2">
                {enrollment.internship.title}
              </h2>
              <p className="text-sm text-slate-600 leading-relaxed max-w-3xl">
                {enrollment.internship.short_description}
              </p>
            </div>

            {/* Program Specs */}
            <div className="grid grid-cols-2 sm:grid-cols-3 gap-3">
              <div className="bg-slate-50 rounded-xl p-3.5 border border-slate-100">
                <span className="text-2xs text-slate-400 block mb-1 uppercase font-semibold">{t('durationWeeks')}</span>
                <span className="text-sm font-bold text-slate-900 flex items-center gap-1.5">
                  <Clock className="w-4 h-4 text-slate-500" />
                  {enrollment.internship.duration_weeks} {t('durationWeeks')}
                </span>
              </div>
              <div className="bg-slate-50 rounded-xl p-3.5 border border-slate-100">
                <span className="text-2xs text-slate-400 block mb-1 uppercase font-semibold">{t('startDate')}</span>
                <span className="text-sm font-bold text-slate-900 flex items-center gap-1.5">
                  <Calendar className="w-4 h-4 text-slate-500" />
                  {formatDate(enrollment.internship.start_date) || (isAz ? 'Dərhal' : 'Immediate')}
                </span>
              </div>
              <div className="bg-slate-50 rounded-xl p-3.5 border border-slate-100">
                <span className="text-2xs text-slate-400 block mb-1 uppercase font-semibold">{t('requirements')}</span>
                <span className="text-sm font-bold text-slate-900 flex items-center gap-1.5">
                  <ShieldCheck className="w-4 h-4 text-slate-500" />
                  {enrollment.internship.requirements?.length || 0} {isAz ? 'tələb' : 'items'}
                </span>
              </div>
            </div>

            {/* Skills */}
            {enrollment.internship.skills && enrollment.internship.skills.length > 0 && (
              <div>
                <span className="text-xs font-bold text-slate-900 uppercase tracking-wider block mb-2">
                  {t('skills')}
                </span>
                <div className="flex flex-wrap gap-1.5">
                  {enrollment.internship.skills.map((skill) => (
                    <span
                      key={skill}
                      className="px-2.5 py-1 rounded-md bg-slate-100 text-slate-700 text-xs font-medium"
                    >
                      {skill}
                    </span>
                  ))}
                </div>
              </div>
            )}
          </div>

          {/* Assigned Tasks Section Placeholder */}
          <div className="bg-white rounded-2xl border border-slate-200 p-6 shadow-2xs">
            <h3 className="text-base font-bold text-slate-900 mb-4 flex items-center gap-2">
              <ListTodo className="w-5 h-5 text-emerald-600" />
              {isAz ? 'Proqram Tapşırıqları və Layihələr' : 'Program Assignments & Projects'}
            </h3>
            <div className="bg-slate-50 border border-slate-200 rounded-xl p-8 text-center">
              <div className="w-12 h-12 rounded-xl bg-white border border-slate-200 text-slate-400 flex items-center justify-center mx-auto mb-3">
                <ListTodo className="w-6 h-6" />
              </div>
              <p className="text-sm font-semibold text-slate-700 mb-1">
                {t('tasksPlaceholder')}
              </p>
              <p className="text-xs text-slate-400 max-w-sm mx-auto">
                {isAz
                  ? 'Həftəlik tapşırıqlar və layihə təlimatları mentor tərəfindən proqram cədvəlinə uyğun olaraq aktivləşdiriləcəkdir.'
                  : 'Weekly assignments and technical guidelines will be scheduled and released by your program mentor.'}
              </p>
            </div>
          </div>
        </div>
      ) : (
        /* Empty State */
        <Card className="border-slate-200 shadow-2xs">
          <CardContent className="p-12 text-center">
            <div className="w-16 h-16 rounded-2xl bg-slate-50 text-slate-400 flex items-center justify-center mx-auto mb-4 border border-slate-200">
              <Briefcase className="w-8 h-8" />
            </div>
            <h3 className="text-lg font-bold text-slate-900 mb-2">
              {t('noActiveInternship')}
            </h3>
            <p className="text-xs text-slate-500 max-w-md mx-auto leading-relaxed mb-6">
              {t('noActiveInternshipDesc')}
            </p>
            <Link href="/internships">
              <Button size="sm" className="gap-1.5 shadow-xs">
                {isAz ? 'Təcrübə proqramlarına bax' : 'Explore Internships'}
                <ArrowRight className="w-4 h-4" />
              </Button>
            </Link>
          </CardContent>
        </Card>
      )}
    </div>
  );
}
