'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import { Navbar } from '@/components/layout/navbar';
import { Footer } from '@/components/layout/footer';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { useLanguage } from '@/lib/i18n/language-context';
import { Briefcase, Search, Filter, BellRing, ArrowRight } from 'lucide-react';

export default function InternshipsPage() {
  const { language } = useLanguage();
  const isAz = language === 'az';
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('all');

  const categories = isAz
    ? [
        { id: 'all', label: 'Bütün istiqamətlər' },
        { id: 'dev', label: 'Proqramlaşdırma və Veb' },
        { id: 'data', label: 'Məlumat Analitikası' },
        { id: 'product', label: 'Məhsul İdarəetməsi' },
        { id: 'marketing', label: 'Rəqəmsal Marketinq' },
      ]
    : [
        { id: 'all', label: 'All Tracks' },
        { id: 'dev', label: 'Software & Web' },
        { id: 'data', label: 'Data Analytics' },
        { id: 'product', label: 'Product Management' },
        { id: 'marketing', label: 'Digital Marketing' },
      ];

  return (
    <div className="flex-1 flex flex-col min-h-screen bg-slate-50">
      <Navbar />

      <main className="flex-1 py-12">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
          {/* Header */}
          <div className="mb-8">
            <h1 className="text-3xl font-extrabold text-slate-900 tracking-tight">
              {isAz ? 'Təcrübə Proqramları' : 'Internship Programs'}
            </h1>
            <p className="text-sm text-slate-600 mt-2">
              {isAz
                ? 'Azərbaycanın aparıcı texnologiya şirkətləri və təşkilatları ilə birgə təşkil olunan təcrübə vakansiyaları.'
                : 'Internship opportunities organized in collaboration with top organizations in Azerbaijan.'}
            </p>
          </div>

          {/* Search and Filters */}
          <div className="bg-white p-4 rounded-xl border border-slate-200 shadow-2xs mb-8 flex flex-col md:flex-row gap-4 items-center justify-between">
            <div className="relative flex-1 w-full">
              <Search className="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
              <Input
                placeholder={isAz ? 'Vəzifə və ya bacarıq axtarın...' : 'Search role, track or skill...'}
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                className="pl-9 h-10"
              />
            </div>
            <div className="flex items-center gap-2 overflow-x-auto w-full md:w-auto pb-1 md:pb-0">
              <Filter className="w-4 h-4 text-slate-400 shrink-0 hidden sm:block" />
              {categories.map((cat) => (
                <button
                  key={cat.id}
                  onClick={() => setSelectedCategory(cat.id)}
                  className={`px-3 py-1.5 rounded-lg text-xs font-medium whitespace-nowrap transition-colors ${
                    selectedCategory === cat.id
                      ? 'bg-emerald-600 text-white shadow-2xs'
                      : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
                  }`}
                >
                  {cat.label}
                </button>
              ))}
            </div>
          </div>

          {/* Production-Style Empty State */}
          <div className="bg-white rounded-2xl border border-slate-200 p-12 text-center max-w-2xl mx-auto shadow-2xs">
            <div className="w-16 h-16 rounded-2xl bg-emerald-50 text-emerald-600 flex items-center justify-center mx-auto mb-5 border border-emerald-100">
              <Briefcase className="w-8 h-8" />
            </div>

            <h3 className="text-xl font-bold text-slate-900 mb-2">
              {isAz ? 'Hazırda aktiv təcrübə proqramı yoxdur.' : 'No active internship programs are available at the moment.'}
            </h3>

            <p className="text-sm text-slate-500 leading-relaxed max-w-md mx-auto mb-8">
              {isAz
                ? 'Yeni təcrübə qrupları və tərəfdaş şirkətlərin vakansiyaları yaxın günlərdə elan olunacaq. İlk müraciət edənlərdən olmaq üçün tələbə profilinizi yaradın.'
                : 'Upcoming internship cohorts will be announced shortly. Register your student profile today to receive immediate notifications when applications open.'}
            </p>

            <div className="flex flex-col sm:flex-row items-center justify-center gap-3">
              <Link href="/register" className="w-full sm:w-auto">
                <Button className="w-full sm:w-auto gap-2 shadow-xs">
                  {isAz ? 'Tələbə kimi qeydiyyatdan keç' : 'Register as a Student'}
                  <ArrowRight className="w-4 h-4" />
                </Button>
              </Link>
              <Link href="/how-it-works" className="w-full sm:w-auto">
                <Button variant="outline" className="w-full sm:w-auto">
                  {isAz ? 'Necə işləyir?' : 'How It Works'}
                </Button>
              </Link>
            </div>

            <div className="mt-8 pt-6 border-t border-slate-100 flex items-center justify-center gap-2 text-xs text-slate-500">
              <BellRing className="w-4 h-4 text-emerald-600" />
              <span>
                {isAz
                  ? 'Qeydiyyatdan keçmiş tələbələrə yeni təcrübələr haqqında e-poçt bildirişi göndərilir.'
                  : 'Registered students automatically receive email alerts when new positions open.'}
              </span>
            </div>
          </div>
        </div>
      </main>

      <Footer />
    </div>
  );
}
