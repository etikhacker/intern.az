'use client';

import React from 'react';
import Link from 'next/link';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { FileText, ArrowRight } from 'lucide-react';

export default function StudentApplicationsPage() {
  return (
    <div className="space-y-6">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-4 border-b border-slate-200">
        <div>
          <h1 className="text-2xl font-bold text-slate-900 tracking-tight">
            Müraciətlərim
          </h1>
          <p className="text-xs text-slate-500 mt-1">
            Göndərdiyiniz təcrübə müraciətlərinin cari statusu
          </p>
        </div>
        <Link href="/dashboard/internships">
          <Button size="sm" className="gap-1.5 shadow-xs">
            Yeni Müraciət
            <ArrowRight className="w-4 h-4" />
          </Button>
        </Link>
      </div>

      <Card className="border-slate-200 shadow-2xs">
        <CardContent className="p-12 text-center">
          <div className="w-16 h-16 rounded-2xl bg-slate-50 text-slate-400 flex items-center justify-center mx-auto mb-4 border border-slate-200">
            <FileText className="w-8 h-8" />
          </div>
          <h3 className="text-lg font-bold text-slate-900 mb-2">
            Hazırda aktiv müraciətiniz yoxdur.
          </h3>
          <p className="text-xs text-slate-500 max-w-md mx-auto leading-relaxed mb-6">
            Açıq təcrübə proqramlarını nəzərdən keçirin və karyera hədəflərinizə uyğun qrupa müraciət edin.
          </p>
          <Link href="/dashboard/internships">
            <Button variant="outline" size="sm">
              Təcrübə proqramlarına bax
            </Button>
          </Link>
        </CardContent>
      </Card>
    </div>
  );
}
