'use client';

import React from 'react';
import { Card, CardContent } from '@/components/ui/card';
import { FileCheck2 } from 'lucide-react';

export default function AdminApplicationsPage() {
  return (
    <div className="space-y-6">
      <div className="pb-4 border-b border-slate-800">
        <h1 className="text-2xl font-bold text-white tracking-tight">
          Tələbə Müraciətləri
        </h1>
        <p className="text-xs text-slate-400 mt-1">
          Təcrübə proqramlarına daxil olmuş namizəd anketləri və təsdiq prosesi
        </p>
      </div>

      <Card className="bg-slate-900 border-slate-800 text-white">
        <CardContent className="p-12 text-center">
          <div className="w-16 h-16 rounded-2xl bg-slate-800 text-amber-400 flex items-center justify-center mx-auto mb-4 border border-slate-700">
            <FileCheck2 className="w-8 h-8" />
          </div>
          <h3 className="text-lg font-bold text-white mb-2">
            Baxılmamış müraciət yoxdur
          </h3>
          <p className="text-xs text-slate-400 max-w-md mx-auto leading-relaxed">
            Tələbələr açıq təcrübə proqramlarına müraciət etdikdə anketlər burada yoxlanılmaq üçün siyahıya alınacaqdır.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
