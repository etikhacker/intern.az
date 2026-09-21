'use client';

import React from 'react';
import Link from 'next/link';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Briefcase, ArrowRight } from 'lucide-react';

export default function StudentMyInternshipPage() {
  return (
    <div className="space-y-6">
      <div className="pb-4 border-b border-slate-200">
        <h1 className="text-2xl font-bold text-slate-900 tracking-tight">
          Mənim Təcrübəm
        </h1>
        <p className="text-xs text-slate-500 mt-1">
          Qoşulduğunuz aktiv təcrübə proqramı, mentor məlumatları və tərəqqiniz
        </p>
      </div>

      <Card className="border-slate-200 shadow-2xs">
        <CardContent className="p-12 text-center">
          <div className="w-16 h-16 rounded-2xl bg-slate-50 text-slate-400 flex items-center justify-center mx-auto mb-4 border border-slate-200">
            <Briefcase className="w-8 h-8" />
          </div>
          <h3 className="text-lg font-bold text-slate-900 mb-2">
            Aktiv təcrübə proqramına qeydiyyatınız yoxdur.
          </h3>
          <p className="text-xs text-slate-500 max-w-md mx-auto leading-relaxed mb-6">
            Təcrübə proqramına qəbul edildikdən sonra proqram planı, həftəlik modullar və mentor əlaqələri burada görünəcəkdir.
          </p>
          <Link href="/dashboard/internships">
            <Button size="sm" className="gap-1.5 shadow-xs">
              Təcrübə proqramlarına bax
              <ArrowRight className="w-4 h-4" />
            </Button>
          </Link>
        </CardContent>
      </Card>
    </div>
  );
}
