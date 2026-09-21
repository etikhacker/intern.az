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
  Sparkles,
  Calendar,
  CheckCircle2,
  Clock,
  ExternalLink,
} from 'lucide-react';

export default function StudentDashboardPage() {
  const { profile, user } = useAuth();

  const formattedJoinDate = profile?.created_at
    ? new Date(profile.created_at).toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
      })
    : 'Recent';

  return (
    <div className="space-y-6">
      {/* Top Banner / Welcome */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 pb-4 border-b border-slate-200/80">
        <div>
          <h1 className="text-2xl sm:text-3xl font-bold tracking-tight text-slate-900">
            Student Dashboard
          </h1>
          <p className="text-xs sm:text-sm text-slate-500 mt-1">
            Welcome back, {profile?.full_name || 'Student'}. Here is your internship progress and profile status.
          </p>
        </div>

        <div className="flex items-center gap-2">
          <Link href="/dashboard/profile">
            <Button variant="outline" size="sm" className="gap-1.5 text-xs">
              <User className="w-3.5 h-3.5 text-emerald-600" />
              Edit Profile
            </Button>
          </Link>
        </div>
      </div>

      {/* Main Student Profile & Internship Status Card */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Left 2 Cols: Detailed Student Profile Card */}
        <Card className="lg:col-span-2 border-slate-200/90 shadow-sm">
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
                    {profile?.full_name || 'Student User'}
                  </CardTitle>
                  <p className="text-xs text-slate-500 flex items-center gap-1.5 mt-0.5">
                    <GraduationCap className="w-3.5 h-3.5 text-emerald-600" />
                    <span>{profile?.university || 'University not specified'}</span>
                  </p>
                </div>
              </div>
              <Badge variant="default" className="text-xs capitalize py-1 px-3">
                {profile?.role || 'student'}
              </Badge>
            </div>
          </CardHeader>

          <CardContent className="pt-6">
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 text-xs">
              <div className="p-3.5 rounded-xl bg-slate-50 border border-slate-100">
                <p className="text-[11px] font-semibold text-slate-400 uppercase tracking-wider mb-1 flex items-center gap-1">
                  <Mail className="w-3 h-3 text-slate-400" />
                  Account Email
                </p>
                <p className="text-xs font-semibold text-slate-800 break-all">
                  {profile?.email || user?.email || 'N/A'}
                </p>
              </div>

              <div className="p-3.5 rounded-xl bg-slate-50 border border-slate-100">
                <p className="text-[11px] font-semibold text-slate-400 uppercase tracking-wider mb-1 flex items-center gap-1">
                  <GraduationCap className="w-3 h-3 text-slate-400" />
                  University Institution
                </p>
                <p className="text-xs font-semibold text-slate-800">
                  {profile?.university || 'Not specified'}
                </p>
              </div>

              <div className="p-3.5 rounded-xl bg-slate-50 border border-slate-100">
                <p className="text-[11px] font-semibold text-slate-400 uppercase tracking-wider mb-1 flex items-center gap-1">
                  <Shield className="w-3 h-3 text-slate-400" />
                  System Role
                </p>
                <p className="text-xs font-semibold text-slate-800 capitalize">
                  {profile?.role || 'student'}
                </p>
              </div>

              <div className="p-3.5 rounded-xl bg-slate-50 border border-slate-100">
                <p className="text-[11px] font-semibold text-slate-400 uppercase tracking-wider mb-1 flex items-center gap-1">
                  <Calendar className="w-3 h-3 text-slate-400" />
                  Member Since
                </p>
                <p className="text-xs font-semibold text-slate-800">
                  {formattedJoinDate}
                </p>
              </div>
            </div>
          </CardContent>

          <CardFooter className="bg-slate-50/60 border-t border-slate-100 flex items-center justify-between text-xs text-slate-500 py-3">
            <span>Secured via PostgreSQL Row Level Security (RLS)</span>
            <Link href="/dashboard/profile" className="text-emerald-700 font-semibold hover:underline flex items-center gap-1">
              Update Profile Details
              <ArrowRight className="w-3 h-3" />
            </Link>
          </CardFooter>
        </Card>

        {/* Right Col: Internship Status Card */}
        <Card className="border-slate-200/90 shadow-sm flex flex-col justify-between">
          <div>
            <CardHeader className="pb-3 border-b border-slate-100">
              <CardTitle className="text-base flex items-center gap-2">
                <Briefcase className="w-4 h-4 text-emerald-600" />
                Current Internship Status
              </CardTitle>
              <CardDescription className="text-xs">
                Your cohort enrollment and progress
              </CardDescription>
            </CardHeader>

            <CardContent className="pt-6 text-center">
              <div className="w-16 h-16 rounded-2xl bg-amber-50 text-amber-600 flex items-center justify-center mx-auto mb-3 border border-amber-200/70">
                <Clock className="w-8 h-8" />
              </div>
              <div className="inline-block px-3 py-1 rounded-full bg-slate-100 text-slate-800 text-xs font-bold mb-2">
                Not enrolled
              </div>
              <p className="text-xs text-slate-500 leading-relaxed max-w-xs mx-auto">
                You are not currently enrolled in an active internship track.
                Internship applications will open in upcoming phases.
              </p>
            </CardContent>
          </div>

          <CardFooter className="p-4 bg-slate-50/60 border-t border-slate-100">
            <div className="w-full text-center">
              <span className="text-[11px] text-slate-400">
                Phase 1: Registration & Profile Foundation
              </span>
            </div>
          </CardFooter>
        </Card>
      </div>

      {/* Roadmap / Phase 1 Status Banner */}
      <Card className="bg-gradient-to-r from-emerald-500 to-teal-700 text-white border-none shadow-md">
        <CardContent className="p-6 sm:p-8">
          <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-6">
            <div className="space-y-2 max-w-2xl">
              <div className="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full bg-white/20 text-white text-xs font-semibold">
                <Sparkles className="w-3.5 h-3.5" />
                <span>Phase 1 Architecture Complete</span>
              </div>
              <h3 className="text-xl sm:text-2xl font-bold tracking-tight">
                Profile Verified & Ready for Future Cohorts
              </h3>
              <p className="text-xs sm:text-sm text-emerald-100 leading-relaxed">
                Your student profile is active in the database. When Phase 2 launches,
                you will be able to browse open internships across Azerbaijan, submit applications,
                and receive weekly mentored task assignments.
              </p>
            </div>

            <div className="shrink-0">
              <Link href="/dashboard/profile">
                <Button variant="outline" className="bg-white text-emerald-800 hover:bg-emerald-50 border-none font-bold">
                  Review Your Profile
                </Button>
              </Link>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
