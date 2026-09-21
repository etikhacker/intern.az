'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Briefcase, Search, Filter, BellRing } from 'lucide-react';

export default function StudentInternshipsPage() {
  const [searchTerm, setSearchTerm] = useState('');

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-slate-900 tracking-tight">
          Təcrübə Proqramları
        </h1>
        <p className="text-xs text-slate-500 mt-1">
          Açıq təcrübə vakansiyalarını kəşf edin və müraciət edin.
        </p>
      </div>

      <div className="bg-white p-4 rounded-xl border border-slate-200 shadow-2xs flex flex-col sm:flex-row gap-3">
        <div className="relative flex-1">
          <Search className="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
          <Input
            placeholder="İstiqamət və ya vakansiya axtarın..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="pl-9 h-10"
          />
        </div>
      </div>

      <Card className="border-slate-200 shadow-2xs">
        <CardContent className="p-12 text-center">
          <div className="w-16 h-16 rounded-2xl bg-slate-50 text-slate-400 flex items-center justify-center mx-auto mb-4 border border-slate-200">
            <Briefcase className="w-8 h-8" />
          </div>
          <h3 className="text-lg font-bold text-slate-900 mb-2">
            Hazırda aktiv təcrübə proqramı yoxdur.
          </h3>
          <p className="text-xs text-slate-500 max-w-md mx-auto leading-relaxed mb-6">
            Yeni təcrübə qrupları yaxın günlərdə elan olunacaq. Vakansiyalar açıldıqda sizə dərhal bildiriş göndəriləcəkdir.
          </p>
          <div className="inline-flex items-center gap-2 text-xs text-emerald-700 bg-emerald-50 px-3 py-1.5 rounded-lg border border-emerald-200">
            <BellRing className="w-4 h-4 text-emerald-600" />
            <span>Bildirişlər e-poçt ünvanınıza avtomatik yönləndirilir</span>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
