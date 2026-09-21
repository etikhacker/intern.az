'use client';

import React from 'react';
import Link from 'next/link';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Award, CheckCircle2, ShieldCheck, ArrowRight } from 'lucide-react';

export default function StudentCertificatePage() {
  return (
    <div className="space-y-6">
      <div className="pb-4 border-b border-slate-200">
        <h1 className="text-2xl font-bold text-slate-900 tracking-tight">
          Sertifikat
        </h1>
        <p className="text-xs text-slate-500 mt-1">
          Rəsmi təcrübə sertifikatınız və təsdiq məlumatları
        </p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <Card className="md:col-span-2 border-slate-200 shadow-2xs">
          <CardHeader>
            <CardTitle className="text-base flex items-center gap-2">
              <Award className="w-5 h-5 text-emerald-600" />
              Sertifikat Statusu
            </CardTitle>
            <CardDescription className="text-xs">
              Sertifikat əldə etmək üçün tələblər
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4 text-xs">
            <div className="p-4 rounded-xl bg-slate-50 border border-slate-200 flex items-start gap-3">
              <div className="w-5 h-5 rounded-full border border-slate-300 text-slate-400 flex items-center justify-center font-bold shrink-0 mt-0.5">
                1
              </div>
              <div>
                <p className="font-semibold text-slate-800">Təcrübə proqramına qəbul</p>
                <p className="text-slate-500 mt-0.5">Açıq təcrübə vakansiyalarından birinə müraciət edin və qəbul olun.</p>
              </div>
            </div>

            <div className="p-4 rounded-xl bg-slate-50 border border-slate-200 flex items-start gap-3">
              <div className="w-5 h-5 rounded-full border border-slate-300 text-slate-400 flex items-center justify-center font-bold shrink-0 mt-0.5">
                2
              </div>
              <div>
                <p className="font-semibold text-slate-800">Həftəlik tapşırıqların icrası</p>
                <p className="text-slate-500 mt-0.5">Təyin olunmuş bütün tapşırıqları vaxtında və keyfiyyətlə tamamlayın.</p>
              </div>
            </div>

            <div className="p-4 rounded-xl bg-slate-50 border border-slate-200 flex items-start gap-3">
              <div className="w-5 h-5 rounded-full border border-slate-300 text-slate-400 flex items-center justify-center font-bold shrink-0 mt-0.5">
                3
              </div>
              <div>
                <p className="font-semibold text-slate-800">Yekun qiymətləndirmə və təsdiq</p>
                <p className="text-slate-500 mt-0.5">Koordinator tərəfindən yekun layihə təsdiq edildikdən sonra unikal seriyalı rəsmi sertifikat verilir.</p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card className="border-slate-200 shadow-2xs flex flex-col justify-between">
          <CardHeader>
            <CardTitle className="text-sm">Rəsmi Sertifikat Nümunəsi</CardTitle>
          </CardHeader>
          <CardContent className="text-center py-6">
            <div className="w-16 h-16 rounded-2xl bg-emerald-50 text-emerald-600 flex items-center justify-center mx-auto mb-3 border border-emerald-100">
              <ShieldCheck className="w-8 h-8" />
            </div>
            <p className="text-xs font-semibold text-slate-800 mb-1">
              Verifikasiya Kodlu Sertifikat
            </p>
            <p className="text-[11px] text-slate-500 leading-relaxed">
              LinkedIn profilinizə və CV-nizə birbaşa əlavə edə biləcəyiniz rəsmi keçid.
            </p>
          </CardContent>
          <div className="p-4 border-t border-slate-100">
            <Link href="/dashboard/internships">
              <Button size="sm" variant="outline" className="w-full text-xs">
                Təcrübə proqramlarına bax
              </Button>
            </Link>
          </div>
        </Card>
      </div>
    </div>
  );
}
