'use client';

import React from 'react';
import Link from 'next/link';
import { Navbar } from '@/components/layout/navbar';
import { Footer } from '@/components/layout/footer';
import { Button } from '@/components/ui/button';
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { useLanguage } from '@/lib/i18n/language-context';
import {
  ArrowRight,
  CheckCircle2,
  Code2,
  Database,
  BarChart3,
  Award,
  Sparkles,
  Users,
  Briefcase,
  GraduationCap,
  Building2,
  Check,
} from 'lucide-react';

export default function HomePage() {
  const { language } = useLanguage();
  const isAz = language === 'az';

  return (
    <div className="flex-1 flex flex-col">
      <Navbar />

      <main className="flex-1">
        {/* Hero Section */}
        <section className="relative overflow-hidden bg-gradient-to-b from-[#0d1717] via-[#07090d] to-[#07090d] py-20 lg:py-28 border-b border-slate-200/70">
          <div className="hero-grid absolute inset-0 opacity-70" aria-hidden="true" />
          <div className="hero-orb hero-orb-left" aria-hidden="true" />
          <div className="hero-orb hero-orb-right" aria-hidden="true" />
          <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
            <div className="relative inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-emerald-400/10 border border-emerald-300/30 text-emerald-200 text-xs font-semibold mb-6 shadow-[0_0_28px_rgba(52,211,153,0.12)]">
              <Sparkles className="w-3.5 h-3.5 text-emerald-300" />
              <span>
                {isAz
                  ? 'Azərbaycan tələbələri üçün peşəkar təcrübə portalı'
                  : 'Professional internship platform for university students in Azerbaijan'}
              </span>
            </div>

            <h1 className="relative text-4xl sm:text-5xl lg:text-6xl font-extrabold text-white tracking-tight leading-[1.15] drop-shadow-[0_12px_28px_rgba(0,0,0,0.35)]">
              {isAz ? (
                <>
                  Bacarıqlarını inkişaf etdir. Real layihələr qur.{' '}
                  <span className="text-emerald-300 [text-shadow:0_0_30px_rgba(52,211,153,0.35)]">Sertifikat qazan.</span>
                </>
              ) : (
                <>
                  Build Real Skills. Deliver Industry Projects.{' '}
                  <span className="text-emerald-300 [text-shadow:0_0_30px_rgba(52,211,153,0.35)]">Get Certified.</span>
                </>
              )}
            </h1>

            <p className="relative mt-6 text-lg sm:text-xl text-slate-300 max-w-3xl mx-auto font-normal leading-relaxed">
              {isAz
                ? 'Universitet biliklərini real iş mühitində tətbiq et. Mentorların rəhbərliyi ilə həftəlik tapşırıqları tamamla və təsdiq olunmuş rəsmi karyera sertifikatı əldə et.'
                : 'Bridge the gap between academic theory and industry reality. Complete weekly workplace tasks with mentor guidance and earn verifiable certificates to boost your career.'}
            </p>

            {/* CTA Buttons */}
            <div className="mt-10 flex flex-col sm:flex-row items-center justify-center gap-4">
              <Link href="/register" className="w-full sm:w-auto">
                <Button size="lg" className="w-full sm:w-auto gap-2 text-base px-8 h-12 shadow-sm">
                  {isAz ? 'Tələbə kimi qeydiyyatdan keç' : 'Apply as a Student'}
                  <ArrowRight className="w-4 h-4" />
                </Button>
              </Link>
              <Link href="/internships" className="w-full sm:w-auto">
                <Button variant="outline" size="lg" className="w-full sm:w-auto text-base px-8 h-12">
                  {isAz ? 'Təcrübə proqramlarına bax' : 'Explore Internships'}
                </Button>
              </Link>
            </div>

            {/* Trust Metrics */}
            <div className="relative mt-14 pt-8 border-t border-slate-200/60 grid grid-cols-2 md:grid-cols-4 gap-4 max-w-4xl mx-auto text-left">
              <div className="p-4 bg-white/80 rounded-xl border border-slate-200/60 shadow-2xs">
                <div className="flex items-center gap-2 text-emerald-600 mb-1">
                  <GraduationCap className="w-4 h-4" />
                  <span className="text-xs font-bold uppercase tracking-wider text-slate-500">
                    {isAz ? 'Universitetlər' : 'Universities'}
                  </span>
                </div>
                <p className="text-sm font-bold text-slate-900">Bütün universitetlər</p>
              </div>

              <div className="p-4 bg-white/80 rounded-xl border border-slate-200/60 shadow-2xs">
                <div className="flex items-center gap-2 text-emerald-600 mb-1">
                  <Briefcase className="w-4 h-4" />
                  <span className="text-xs font-bold uppercase tracking-wider text-slate-500">
                    {isAz ? 'Format' : 'Format'}
                  </span>
                </div>
                <p className="text-sm font-bold text-slate-900">
                  {isAz ? 'Praktiki və Onlayn' : 'Hands-on & Remote'}
                </p>
              </div>

              <div className="p-4 bg-white/80 rounded-xl border border-slate-200/60 shadow-2xs">
                <div className="flex items-center gap-2 text-emerald-600 mb-1">
                  <Award className="w-4 h-4" />
                  <span className="text-xs font-bold uppercase tracking-wider text-slate-500">
                    {isAz ? 'Sertifikat' : 'Credential'}
                  </span>
                </div>
                <p className="text-sm font-bold text-slate-900">
                  {isAz ? 'Rəsmi və Təsdiqlənmiş' : 'Official & Verifiable'}
                </p>
              </div>

              <div className="p-4 bg-white/80 rounded-xl border border-slate-200/60 shadow-2xs">
                <div className="flex items-center gap-2 text-emerald-600 mb-1">
                  <Users className="w-4 h-4" />
                  <span className="text-xs font-bold uppercase tracking-wider text-slate-500">
                    {isAz ? 'Mentorluq' : 'Mentorship'}
                  </span>
                </div>
                <p className="text-sm font-bold text-slate-900">
                  {isAz ? 'Fərdi Əks-əlaqə' : '1-on-1 Feedback'}
                </p>
              </div>
            </div>
          </div>
        </section>

        {/* How It Works Section */}
        <section id="how-it-works" className="py-16 sm:py-24 bg-white border-b border-slate-200/70">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="text-center max-w-3xl mx-auto mb-16">
              <h2 className="text-xs font-bold uppercase tracking-wider text-emerald-600 mb-2">
                {isAz ? 'Addım-addım proses' : 'Step-by-step Process'}
              </h2>
              <h3 className="text-3xl font-bold text-slate-900 tracking-tight sm:text-4xl">
                {isAz ? 'Təcrübə proqramı necə işləyir?' : 'How The Internship Program Works'}
              </h3>
              <p className="mt-3 text-slate-600 text-sm sm:text-base leading-relaxed">
                {isAz
                  ? 'Tələbələrin karyera başlanğıcını sürətləndirən 4 əsas mərhələ.'
                  : 'A four-step pathway designed to transform academic learning into verified industry capability.'}
              </p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
              {/* Step 1 */}
              <Card className="border-slate-200 hover:border-emerald-300 hover:shadow-sm transition-all">
                <CardHeader>
                  <div className="w-10 h-10 rounded-lg bg-emerald-50 text-emerald-700 font-bold flex items-center justify-center mb-2">
                    01
                  </div>
                  <CardTitle className="text-base">
                    {isAz ? 'Qeydiyyat və Profil' : 'Registration & Profile'}
                  </CardTitle>
                  <CardDescription>
                    {isAz
                      ? 'Universitet məlumatlarını daxil edərək tələbə profilini yarat.'
                      : 'Sign up with your university details and create your student profile.'}
                  </CardDescription>
                </CardHeader>
                <CardContent className="text-xs text-slate-500">
                  {isAz
                    ? 'Bütün Azərbaycan universitetlərinin tələbələri üçün açıqdır.'
                    : 'Open to all university students across Azerbaijan.'}
                </CardContent>
              </Card>

              {/* Step 2 */}
              <Card className="border-slate-200 hover:border-emerald-300 hover:shadow-sm transition-all">
                <CardHeader>
                  <div className="w-10 h-10 rounded-lg bg-emerald-50 text-emerald-700 font-bold flex items-center justify-center mb-2">
                    02
                  </div>
                  <CardTitle className="text-base">
                    {isAz ? 'Seçim və Qəbul' : 'Cohort Selection'}
                  </CardTitle>
                  <CardDescription>
                    {isAz
                      ? 'İstiqamətini seç, müraciət et və təcrübə qrupuna qoşul.'
                      : 'Choose your desired track and join the active cohort.'}
                  </CardDescription>
                </CardHeader>
                <CardContent className="text-xs text-slate-500">
                  {isAz
                    ? 'Müraciətlər mütəxəssislər tərəfindən dəyərləndirilir.'
                    : 'Applications are carefully evaluated by industry coordinators.'}
                </CardContent>
              </Card>

              {/* Step 3 */}
              <Card className="border-slate-200 hover:border-emerald-300 hover:shadow-sm transition-all">
                <CardHeader>
                  <div className="w-10 h-10 rounded-lg bg-emerald-50 text-emerald-700 font-bold flex items-center justify-center mb-2">
                    03
                  </div>
                  <CardTitle className="text-base">
                    {isAz ? 'Praktiki Tapşırıqlar' : 'Weekly Tasks'}
                  </CardTitle>
                  <CardDescription>
                    {isAz
                      ? 'Həftəlik real iş tapşırıqlarını və layihələri yerinə yetir.'
                      : 'Deliver practical assignments modeled after modern company workflows.'}
                  </CardDescription>
                </CardHeader>
                <CardContent className="text-xs text-slate-500">
                  {isAz
                    ? 'Mentor rəyi ilə portfel layihələri formalaşdır.'
                    : 'Build strong portfolio projects with constructive feedback.'}
                </CardContent>
              </Card>

              {/* Step 4 */}
              <Card className="border-slate-200 hover:border-emerald-300 hover:shadow-sm transition-all">
                <CardHeader>
                  <div className="w-10 h-10 rounded-lg bg-emerald-50 text-emerald-700 font-bold flex items-center justify-center mb-2">
                    04
                  </div>
                  <CardTitle className="text-base">
                    {isAz ? 'Rəsmi Sertifikat' : 'Verified Certificate'}
                  </CardTitle>
                  <CardDescription>
                    {isAz
                      ? 'Yekun layihəni uğurla təqdim edib rəsmi sertifikat qazan.'
                      : 'Earn an official verifiable credential upon successful project completion.'}
                  </CardDescription>
                </CardHeader>
                <CardContent className="text-xs text-slate-500">
                  {isAz
                    ? 'LinkedIn və CV üçün unikal nömrəli təsdiq.'
                    : 'Equipped with a unique verification link for CVs and LinkedIn.'}
                </CardContent>
              </Card>
            </div>
          </div>
        </section>

        {/* Categories / Tracks */}
        <section className="py-16 sm:py-24 bg-slate-50/70 border-b border-slate-200/70">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="text-center max-w-3xl mx-auto mb-16">
              <h2 className="text-xs font-bold uppercase tracking-wider text-emerald-600 mb-2">
                {isAz ? 'İstiqamətlər' : 'Disciplines'}
              </h2>
              <h3 className="text-3xl font-bold text-slate-900 tracking-tight sm:text-4xl">
                {isAz ? 'Təcrübə İstiqamətləri' : 'Featured Internship Tracks'}
              </h3>
              <p className="mt-3 text-slate-600 text-sm sm:text-base leading-relaxed">
                {isAz
                  ? 'Azərbaycanda və qlobal bazarda ən çox tələbat olan sahələr.'
                  : 'High-demand industry sectors designed for student career growth.'}
              </p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              {/* Category 1 */}
              <div className="p-6 bg-white rounded-2xl border border-slate-200 hover:shadow-md transition-all">
                <div className="w-12 h-12 rounded-xl bg-blue-50 text-blue-600 flex items-center justify-center mb-4">
                  <Code2 className="w-6 h-6" />
                </div>
                <Badge variant="blue" className="mb-2">
                  {isAz ? 'Frontend və Veb İnkişafı' : 'Frontend & Web'}
                </Badge>
                <h4 className="text-lg font-bold text-slate-900 mb-2">
                  {isAz ? 'React və Müasir Veb Mühəndisliyi' : 'React & Web Engineering'}
                </h4>
                <p className="text-xs text-slate-500 leading-relaxed">
                  {isAz
                    ? 'Next.js, TypeScript, müasir interfeys arxitekturası və API inteqrasiyası ilə real tətbiqlər.'
                    : 'Next.js, TypeScript, modern UI architectures, and responsive interactive web applications.'}
                </p>
              </div>

              {/* Category 2 */}
              <div className="p-6 bg-white rounded-2xl border border-slate-200 hover:shadow-md transition-all">
                <div className="w-12 h-12 rounded-xl bg-emerald-50 text-emerald-600 flex items-center justify-center mb-4">
                  <Database className="w-6 h-6" />
                </div>
                <Badge variant="default" className="mb-2">
                  {isAz ? 'Backend və Məlumatlar' : 'Backend & Data'}
                </Badge>
                <h4 className="text-lg font-bold text-slate-900 mb-2">
                  {isAz ? 'Bulud Verilənlər Bazası və API' : 'Cloud Databases & APIs'}
                </h4>
                <p className="text-xs text-slate-500 leading-relaxed">
                  {isAz
                    ? 'PostgreSQL, verilənlər bazası dizaynı, sorğu optimallaşdırılması və server təhlükəsizliyi.'
                    : 'Relational databases, PostgreSQL schema design, query optimization, and secure API services.'}
                </p>
              </div>

              {/* Category 3 */}
              <div className="p-6 bg-white rounded-2xl border border-slate-200 hover:shadow-md transition-all">
                <div className="w-12 h-12 rounded-xl bg-purple-50 text-purple-600 flex items-center justify-center mb-4">
                  <BarChart3 className="w-6 h-6" />
                </div>
                <Badge variant="secondary" className="mb-2">
                  {isAz ? 'Məhsul və İdarəetmə' : 'Product & Quality'}
                </Badge>
                <h4 className="text-lg font-bold text-slate-900 mb-2">
                  {isAz ? 'Məhsul İdarəetməsi və QA' : 'Product Management & QA'}
                </h4>
                <p className="text-xs text-slate-500 leading-relaxed">
                  {isAz
                    ? 'Biznes tələbləri, çevik iş axınları (Agile/Scrum), istifadəçi təcrübəsi və keyfiyyətə nəzarət.'
                    : 'Product discovery, user journey mapping, agile workflows, and systematic quality assurance.'}
                </p>
              </div>
            </div>

            <div className="mt-10 text-center">
              <Link href="/internships">
                <Button variant="outline" className="gap-2">
                  {isAz ? 'Bütün təcrübə proqramlarına bax' : 'View All Internship Programs'}
                  <ArrowRight className="w-4 h-4" />
                </Button>
              </Link>
            </div>
          </div>
        </section>

        {/* Benefits Section */}
        <section className="py-16 sm:py-24 bg-white border-b border-slate-200/70">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
              <div>
                <h2 className="text-xs font-bold uppercase tracking-wider text-emerald-600 mb-2">
                  {isAz ? 'Tələbə Üstünlükləri' : 'Student Advantages'}
                </h2>
                <h3 className="text-3xl font-bold text-slate-900 tracking-tight sm:text-4xl">
                  {isAz ? 'Niyə Intern.az?' : 'Why Choose Intern.az?'}
                </h3>
                <p className="mt-4 text-slate-600 text-sm sm:text-base leading-relaxed">
                  {isAz
                    ? 'Universitet kursları nəzəri təməl yaradır; Intern.az isə işəgötürənlərə nümayiş etdirə biləcəyiniz praktiki nəticələr təqdim edir.'
                    : 'Academic courses provide theoretical knowledge; Intern.az gives you tangible project execution that recruiters can directly evaluate.'}
                </p>

                <div className="mt-8 space-y-4">
                  <div className="flex items-start gap-3">
                    <div className="mt-1 p-1 rounded-md bg-emerald-100 text-emerald-700">
                      <Check className="w-4 h-4" />
                    </div>
                    <div>
                      <h4 className="text-sm font-semibold text-slate-900">
                        {isAz ? 'Real İş Şəraitinə Uyğun Tapşırıqlar' : 'Workplace-Realistic Assignments'}
                      </h4>
                      <p className="text-xs text-slate-500 mt-0.5 leading-relaxed">
                        {isAz
                          ? 'Azərbaycanın qabaqcıl şirkətlərinin tələblərinə uyğunlaşdırılmış praktiki layihələr.'
                          : 'Projects curated to align with current hiring expectations in Azerbaijan.'}
                      </p>
                    </div>
                  </div>

                  <div className="flex items-start gap-3">
                    <div className="mt-1 p-1 rounded-md bg-emerald-100 text-emerald-700">
                      <Check className="w-4 h-4" />
                    </div>
                    <div>
                      <h4 className="text-sm font-semibold text-slate-900">
                        {isAz ? 'Tələbə Məxfiliyi və Təhlükəsizlik' : 'Secure Student Profile & Privacy'}
                      </h4>
                      <p className="text-xs text-slate-500 mt-0.5 leading-relaxed">
                        {isAz
                          ? 'Məlumatlarınız müasir təhlükəsizlik standartları ilə tam qorunur.'
                          : 'Student portfolios and identity are protected with modern security standards.'}
                      </p>
                    </div>
                  </div>

                  <div className="flex items-start gap-3">
                    <div className="mt-1 p-1 rounded-md bg-emerald-100 text-emerald-700">
                      <Check className="w-4 h-4" />
                    </div>
                    <div>
                      <h4 className="text-sm font-semibold text-slate-900">
                        {isAz ? 'Rəsmi Karyera Sertifikatı' : 'Official Career Credential'}
                      </h4>
                      <p className="text-xs text-slate-500 mt-0.5 leading-relaxed">
                        {isAz
                          ? 'Proqramı tamamladıqdan sonra CV və LinkedIn-də paylaşıla bilən təsdiq olunmuş sertifikat.'
                          : 'Sharable on LinkedIn and resumes with verifiable credentials.'}
                      </p>
                    </div>
                  </div>
                </div>

                <div className="mt-8">
                  <Link href="/register">
                    <Button size="lg" className="gap-2">
                      {isAz ? 'İndi Başla' : 'Get Started'}
                      <ArrowRight className="w-4 h-4" />
                    </Button>
                  </Link>
                </div>
              </div>

              {/* Showcase Box */}
              <div className="bg-slate-50 rounded-2xl border border-slate-200 p-8 shadow-2xs">
                <div className="space-y-4">
                  <div className="p-4 bg-white rounded-xl border border-slate-200 flex items-center justify-between">
                    <div className="flex items-center gap-3">
                      <div className="p-2.5 bg-emerald-50 text-emerald-600 rounded-lg">
                        <Users className="w-5 h-5" />
                      </div>
                      <div>
                        <p className="text-xs font-semibold text-slate-900">
                          {isAz ? 'Tələbə Profili' : 'Student Profile'}
                        </p>
                        <p className="text-[11px] text-slate-500">
                          {isAz ? 'Universitet və əlaqə məlumatları' : 'University & contact verification'}
                        </p>
                      </div>
                    </div>
                    <Badge variant="default">{isAz ? 'Aktiv' : 'Active'}</Badge>
                  </div>

                  <div className="p-4 bg-white rounded-xl border border-slate-200 flex items-center justify-between">
                    <div className="flex items-center gap-3">
                      <div className="p-2.5 bg-blue-50 text-blue-600 rounded-lg">
                        <Briefcase className="w-5 h-5" />
                      </div>
                      <div>
                        <p className="text-xs font-semibold text-slate-900">
                          {isAz ? 'Təcrübə Proqramı' : 'Internship Track'}
                        </p>
                        <p className="text-[11px] text-slate-500">
                          {isAz ? 'Praktiki tapşırıqlar və rəylər' : 'Hands-on project milestones'}
                        </p>
                      </div>
                    </div>
                    <Badge variant="blue">{isAz ? 'Praktiki' : 'Applied'}</Badge>
                  </div>

                  <div className="p-4 bg-white rounded-xl border border-slate-200 flex items-center justify-between">
                    <div className="flex items-center gap-3">
                      <div className="p-2.5 bg-purple-50 text-purple-600 rounded-lg">
                        <Award className="w-5 h-5" />
                      </div>
                      <div>
                        <p className="text-xs font-semibold text-slate-900">
                          {isAz ? 'Rəsmi Sertifikat' : 'Verified Certificate'}
                        </p>
                        <p className="text-[11px] text-slate-500">
                          {isAz ? 'Unikal nömrə ilə yoxlanıla bilən' : 'Unique verifiable serial number'}
                        </p>
                      </div>
                    </div>
                    <Badge variant="secondary">{isAz ? 'Rəsmi' : 'Official'}</Badge>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* Final CTA Banner */}
        <section className="py-16 bg-slate-900 text-white">
          <div className="max-w-4xl mx-auto px-4 text-center">
            <h3 className="text-2xl sm:text-3xl font-bold tracking-tight mb-4">
              {isAz
                ? 'Karyerana ilk addımı atmağa hazırsan?'
                : 'Ready to launch your practical career journey?'}
            </h3>
            <p className="text-slate-400 text-sm sm:text-base mb-8 max-w-xl mx-auto leading-relaxed">
              {isAz
                ? 'İndi qeydiyyatdan keçərək tələbə profilini yarat və təcrübə proqramlarına qatıl.'
                : 'Register today to create your verified student profile and access structured internships.'}
            </p>
            <div className="flex flex-col sm:flex-row items-center justify-center gap-4">
              <Link href="/register" className="w-full sm:w-auto">
                <Button size="lg" className="w-full sm:w-auto bg-emerald-500 hover:bg-emerald-600 text-white font-semibold">
                  {isAz ? 'Qeydiyyatdan Keç' : 'Register as Student'}
                </Button>
              </Link>
              <Link href="/login" className="w-full sm:w-auto">
                <Button variant="outline" size="lg" className="w-full sm:w-auto bg-transparent border-slate-700 text-slate-200 hover:bg-slate-800">
                  {isAz ? 'Tələbə Girişi' : 'Student Sign In'}
                </Button>
              </Link>
            </div>
          </div>
        </section>
      </main>

      <Footer />
    </div>
  );
}
