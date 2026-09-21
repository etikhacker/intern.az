'use client';

import React from 'react';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Briefcase, Plus } from 'lucide-react';

export default function AdminInternshipsPage() {
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between pb-4 border-b border-slate-800">
        <div>
          <h1 className="text-2xl font-bold text-white tracking-tight">
            Təcrübə Proqramları
          </h1>
          <p className="text-xs text-slate-400 mt-1">
            Aktiv və planlaşdırılan təcrübə vakansiyalarının idarə edilməsi
          </p>
        </div>
        <Button size="sm" className="bg-amber-400 hover:bg-amber-500 text-slate-950 font-semibold gap-1.5 shadow-xs">
          <Plus className="w-4 h-4" />
          Yeni Proqram Yarat
        </Button>
      </div>

      <Card className="bg-slate-900 border-slate-800 text-white">
        <CardContent className="p-12 text-center">
          <div className="w-16 h-16 rounded-2xl bg-slate-800 text-amber-400 flex items-center justify-center mx-auto mb-4 border border-slate-700">
            <Briefcase className="w-8 h-8" />
          </div>
          <h3 className="text-lg font-bold text-white mb-2">
            Aktiv təcrübə proqramı tapılmadı
          </h3>
          <p className="text-xs text-slate-400 max-w-md mx-auto leading-relaxed mb-6">
            Yeni təcrübə proqramı və ya təcrübəçi qrupu yaratmaq üçün yuxarıdakı &quot;Yeni Proqram Yarat&quot; düyməsindən istifadə edin.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
