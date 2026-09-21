'use client';

import React from 'react';
import Link from 'next/link';
import { Navbar } from '@/components/layout/navbar';
import { Footer } from '@/components/layout/footer';
import { Button } from '@/components/ui/button';
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import {
  ArrowRight,
  CheckCircle2,
  Code2,
  Database,
  BarChart3,
  ShieldCheck,
  Award,
  Layers,
  Sparkles,
  Users,
  Compass,
} from 'lucide-react';

export default function HomePage() {
  return (
    <div className="flex-1 flex flex-col">
      <Navbar />

      <main className="flex-1">
        {/* Hero Section */}
        <section className="relative overflow-hidden bg-gradient-to-b from-emerald-50/50 via-white to-slate-50 py-20 lg:py-28 border-b border-slate-200/70">
          <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
            <div className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-emerald-100/80 border border-emerald-200/80 text-emerald-800 text-xs font-semibold mb-6">
              <Sparkles className="w-3.5 h-3.5 text-emerald-600" />
              <span>Azerbaijan Student Internship Foundation • Phase 1</span>
            </div>

            <h1 className="text-4xl sm:text-5xl lg:text-6xl font-extrabold text-slate-900 tracking-tight leading-[1.15]">
              Build Real Skills. Complete Real Projects.{' '}
              <span className="text-emerald-600">Get Certified.</span>
            </h1>

            <p className="mt-6 text-lg sm:text-xl text-slate-600 max-w-3xl mx-auto font-normal leading-relaxed">
              The premier internship platform tailored for students in Azerbaijan.
              Gain direct hands-on experience, tackle realistic workplace tasks,
              work under administrator mentorship, and earn verified career certificates.
            </p>

            {/* CTA Buttons */}
            <div className="mt-10 flex flex-col sm:flex-row items-center justify-center gap-4">
              <Link href="/register" className="w-full sm:w-auto">
                <Button size="lg" className="w-full sm:w-auto gap-2 text-base px-8 h-12 shadow-md">
                  Apply as a Student
                  <ArrowRight className="w-4 h-4" />
                </Button>
              </Link>
              <Link href="/login" className="w-full sm:w-auto">
                <Button variant="outline" size="lg" className="w-full sm:w-auto text-base px-8 h-12">
                  Student Portal Login
                </Button>
              </Link>
            </div>

            {/* Trust Metrics / Tags */}
            <div className="mt-12 pt-8 border-t border-slate-200/60 grid grid-cols-2 md:grid-cols-4 gap-4 max-w-4xl mx-auto text-left">
              <div className="p-3 bg-white/70 rounded-xl border border-slate-200/60 shadow-xs">
                <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider">Universities</p>
                <p className="text-sm font-bold text-slate-900 mt-1">ADA, BSU, ASOIU & more</p>
              </div>
              <div className="p-3 bg-white/70 rounded-xl border border-slate-200/60 shadow-xs">
                <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider">Security</p>
                <p className="text-sm font-bold text-slate-900 mt-1">Supabase RLS Enforced</p>
              </div>
              <div className="p-3 bg-white/70 rounded-xl border border-slate-200/60 shadow-xs">
                <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider">Cost</p>
                <p className="text-sm font-bold text-emerald-700 mt-1">100% Free Plan Tech</p>
              </div>
              <div className="p-3 bg-white/70 rounded-xl border border-slate-200/60 shadow-xs">
                <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider">Architecture</p>
                <p className="text-sm font-bold text-slate-900 mt-1">Phase 1 Foundation</p>
              </div>
            </div>
          </div>
        </section>

        {/* Short Platform Description & How It Works */}
        <section id="how-it-works" className="py-16 sm:py-24 bg-white border-b border-slate-200/70">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="text-center max-w-3xl mx-auto mb-16">
              <h2 className="text-xs font-bold uppercase tracking-wider text-emerald-600 mb-2">
                Structured Career Pathway
              </h2>
              <h3 className="text-3xl font-bold text-slate-900 tracking-tight sm:text-4xl">
                How The Internship Journey Works
              </h3>
              <p className="mt-3 text-slate-600 text-sm sm:text-base leading-relaxed">
                Designed to bridge university academic theory and the practical requirements
                of modern technology and business employers in Baku.
              </p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
              {/* Step 1 */}
              <Card className="relative border-slate-200 hover:border-emerald-300 transition-colors">
                <CardHeader>
                  <div className="w-10 h-10 rounded-lg bg-emerald-50 text-emerald-700 font-bold flex items-center justify-center mb-2">
                    01
                  </div>
                  <CardTitle className="text-base">Register & Profile</CardTitle>
                  <CardDescription>
                    Sign up with your university credentials and build your student profile.
                  </CardDescription>
                </CardHeader>
                <CardContent className="text-xs text-slate-500">
                  Secured automatically with student role assignment and Row Level Security.
                </CardContent>
              </Card>

              {/* Step 2 */}
              <Card className="relative border-slate-200 hover:border-emerald-300 transition-colors">
                <CardHeader>
                  <div className="w-10 h-10 rounded-lg bg-emerald-50 text-emerald-700 font-bold flex items-center justify-center mb-2">
                    02
                  </div>
                  <CardTitle className="text-base">Admin Review</CardTitle>
                  <CardDescription>
                    Administrators review university candidates and verify enrollment.
                  </CardDescription>
                </CardHeader>
                <CardContent className="text-xs text-slate-500">
                  Role-guarded administrative workflow with dedicated oversight console.
                </CardContent>
              </Card>

              {/* Step 3 */}
              <Card className="relative border-slate-200 hover:border-emerald-300 transition-colors">
                <CardHeader>
                  <div className="w-10 h-10 rounded-lg bg-emerald-50 text-emerald-700 font-bold flex items-center justify-center mb-2">
                    03
                  </div>
                  <CardTitle className="text-base">Tasks & Deliverables</CardTitle>
                  <CardDescription>
                    Complete real-world engineering and product assignments weekly.
                  </CardDescription>
                </CardHeader>
                <CardContent className="text-xs text-slate-500">
                  Structured curriculum designed to build demonstrable portfolio projects.
                </CardContent>
              </Card>

              {/* Step 4 */}
              <Card className="relative border-slate-200 hover:border-emerald-300 transition-colors">
                <CardHeader>
                  <div className="w-10 h-10 rounded-lg bg-emerald-50 text-emerald-700 font-bold flex items-center justify-center mb-2">
                    04
                  </div>
                  <CardTitle className="text-base">Certified Credential</CardTitle>
                  <CardDescription>
                    Obtain an official verifiable certificate upon final review.
                  </CardDescription>
                </CardHeader>
                <CardContent className="text-xs text-slate-500">
                  Verified credential with unique certificate serial and portfolio showcase.
                </CardContent>
              </Card>
            </div>
          </div>
        </section>

        {/* Internship Categories */}
        <section id="categories" className="py-16 sm:py-24 bg-slate-50/70 border-b border-slate-200/70">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="text-center max-w-3xl mx-auto mb-16">
              <h2 className="text-xs font-bold uppercase tracking-wider text-emerald-600 mb-2">
                Specialized Tracks
              </h2>
              <h3 className="text-3xl font-bold text-slate-900 tracking-tight sm:text-4xl">
                Featured Internship Categories
              </h3>
              <p className="mt-3 text-slate-600 text-sm sm:text-base leading-relaxed">
                Focus areas built around the fastest-growing hiring sectors in Azerbaijan’s digital economy.
              </p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              {/* Category 1 */}
              <div className="p-6 bg-white rounded-2xl border border-slate-200 hover:shadow-md transition-all">
                <div className="w-12 h-12 rounded-xl bg-blue-50 text-blue-600 flex items-center justify-center mb-4">
                  <Code2 className="w-6 h-6" />
                </div>
                <Badge variant="blue" className="mb-2">Frontend & Web Systems</Badge>
                <h4 className="text-lg font-bold text-slate-900 mb-2">
                  Full-Stack & React Engineering
                </h4>
                <p className="text-xs text-slate-500 leading-relaxed">
                  Next.js, TypeScript, PostgreSQL, and RESTful API integration for enterprise web applications.
                </p>
              </div>

              {/* Category 2 */}
              <div className="p-6 bg-white rounded-2xl border border-slate-200 hover:shadow-md transition-all">
                <div className="w-12 h-12 rounded-xl bg-emerald-50 text-emerald-600 flex items-center justify-center mb-4">
                  <Database className="w-6 h-6" />
                </div>
                <Badge variant="default" className="mb-2">Data & Backend</Badge>
                <h4 className="text-lg font-bold text-slate-900 mb-2">
                  Cloud Databases & Infrastructure
                </h4>
                <p className="text-xs text-slate-500 leading-relaxed">
                  PostgreSQL, Supabase, database design, query optimization, and server-side authentication security.
                </p>
              </div>

              {/* Category 3 */}
              <div className="p-6 bg-white rounded-2xl border border-slate-200 hover:shadow-md transition-all">
                <div className="w-12 h-12 rounded-xl bg-purple-50 text-purple-600 flex items-center justify-center mb-4">
                  <BarChart3 className="w-6 h-6" />
                </div>
                <Badge variant="secondary" className="mb-2">Product & Analytics</Badge>
                <h4 className="text-lg font-bold text-slate-900 mb-2">
                  Product Management & QA
                </h4>
                <p className="text-xs text-slate-500 leading-relaxed">
                  Requirements analysis, agile workflows, user journey mapping, and quality assurance testing.
                </p>
              </div>
            </div>
          </div>
        </section>

        {/* Student Benefits */}
        <section id="benefits" className="py-16 sm:py-24 bg-white border-b border-slate-200/70">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
              <div>
                <h2 className="text-xs font-bold uppercase tracking-wider text-emerald-600 mb-2">
                  Student Advantage
                </h2>
                <h3 className="text-3xl font-bold text-slate-900 tracking-tight sm:text-4xl">
                  Why Students Choose Intern.az
                </h3>
                <p className="mt-4 text-slate-600 text-sm sm:text-base leading-relaxed">
                  Traditional university coursework gives you foundation; our internship tracks give you proof of execution that recruiters can inspect.
                </p>

                <div className="mt-8 space-y-4">
                  <div className="flex items-start gap-3">
                    <div className="mt-1 p-1 rounded-md bg-emerald-100 text-emerald-700">
                      <CheckCircle2 className="w-4 h-4" />
                    </div>
                    <div>
                      <h4 className="text-sm font-semibold text-slate-900">
                        100% Free Foundation & Free-Tier Services
                      </h4>
                      <p className="text-xs text-slate-500 mt-0.5 leading-relaxed">
                        Built entirely on open-source and free cloud tools (Next.js, Supabase Free Tier, PostgreSQL). No hidden subscriptions.
                      </p>
                    </div>
                  </div>

                  <div className="flex items-start gap-3">
                    <div className="mt-1 p-1 rounded-md bg-emerald-100 text-emerald-700">
                      <CheckCircle2 className="w-4 h-4" />
                    </div>
                    <div>
                      <h4 className="text-sm font-semibold text-slate-900">
                        Protected Student Privacy
                      </h4>
                      <p className="text-xs text-slate-500 mt-0.5 leading-relaxed">
                        PostgreSQL Row Level Security ensures students can only view and edit their own profiles, while admins securely oversee the platform.
                      </p>
                    </div>
                  </div>

                  <div className="flex items-start gap-3">
                    <div className="mt-1 p-1 rounded-md bg-emerald-100 text-emerald-700">
                      <CheckCircle2 className="w-4 h-4" />
                    </div>
                    <div>
                      <h4 className="text-sm font-semibold text-slate-900">
                        Baku Tech Ecosystem Alignment
                      </h4>
                      <p className="text-xs text-slate-500 mt-0.5 leading-relaxed">
                        Customized for universities across Azerbaijan (ADA, BSU, ASOIU, BEU, Khazar) and local industry requirements.
                      </p>
                    </div>
                  </div>
                </div>

                <div className="mt-8">
                  <Link href="/register">
                    <Button size="lg" className="gap-2">
                      Get Started Today
                      <ArrowRight className="w-4 h-4" />
                    </Button>
                  </Link>
                </div>
              </div>

              <div className="bg-slate-50 rounded-2xl border border-slate-200 p-8 shadow-xs">
                <div className="space-y-6">
                  <div className="p-4 bg-white rounded-xl border border-slate-200 flex items-center justify-between">
                    <div className="flex items-center gap-3">
                      <div className="p-2.5 bg-emerald-50 text-emerald-600 rounded-lg">
                        <Users className="w-5 h-5" />
                      </div>
                      <div>
                        <p className="text-xs font-semibold text-slate-900">Student Profile</p>
                        <p className="text-[11px] text-slate-500">Autonomous role assignment</p>
                      </div>
                    </div>
                    <Badge variant="default">Verified</Badge>
                  </div>

                  <div className="p-4 bg-white rounded-xl border border-slate-200 flex items-center justify-between">
                    <div className="flex items-center gap-3">
                      <div className="p-2.5 bg-amber-50 text-amber-600 rounded-lg">
                        <ShieldCheck className="w-5 h-5" />
                      </div>
                      <div>
                        <p className="text-xs font-semibold text-slate-900">Admin Control</p>
                        <p className="text-[11px] text-slate-500">Server-side role verification</p>
                      </div>
                    </div>
                    <Badge variant="admin">Secured</Badge>
                  </div>

                  <div className="p-4 bg-white rounded-xl border border-slate-200 flex items-center justify-between">
                    <div className="flex items-center gap-3">
                      <div className="p-2.5 bg-blue-50 text-blue-600 rounded-lg">
                        <Award className="w-5 h-5" />
                      </div>
                      <div>
                        <p className="text-xs font-semibold text-slate-900">Verified Certificate</p>
                        <p className="text-[11px] text-slate-500">Unique serial validation (Phase 2+)</p>
                      </div>
                    </div>
                    <Badge variant="secondary">Ready</Badge>
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
              Ready to begin your internship journey?
            </h3>
            <p className="text-slate-400 text-sm sm:text-base mb-8 max-w-xl mx-auto leading-relaxed">
              Register now to set up your student profile and prepare for the upcoming internship cohorts in Azerbaijan.
            </p>
            <div className="flex flex-col sm:flex-row items-center justify-center gap-4">
              <Link href="/register" className="w-full sm:w-auto">
                <Button size="lg" className="w-full sm:w-auto bg-emerald-500 hover:bg-emerald-600 text-white font-semibold">
                  Register as Student
                </Button>
              </Link>
              <Link href="/login" className="w-full sm:w-auto">
                <Button variant="outline" size="lg" className="w-full sm:w-auto bg-transparent border-slate-700 text-slate-200 hover:bg-slate-800">
                  Student Sign In
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
