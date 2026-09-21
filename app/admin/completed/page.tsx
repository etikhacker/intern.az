'use client';

import React from 'react';
import { Card, CardContent } from '@/components/ui/card';
import { FileBadge } from 'lucide-react';

export default function AdminCompletedInternshipsPage() {
  return (
    <div className="space-y-6">
      <div className="pb-4 border-b border-slate-800">
        <h1 className="text-2xl font-bold text-white tracking-tight">
          Tamamlanmış Təcrübələr
        </h1>
        <p className="text-xs text-slate-400 mt-1">
          Bütün mərhələləri və layihə təqdimatlarını müvəffəqiyyətlə başa vuran təcrübəçilər
        </p>
      </div>

      <Card className="bg-slate-900 border-slate-800 text-white">
        <CardContent className="p-12 text-center">
          <div className="w-16 h-16 rounded-2xl bg-slate-800 text-amber-400 flex items-center justify-center mx-auto mb-4 border border-slate-700">
            <FileBadge className="w-8 h-8" />
          </div>
          <h3 className="text-lg font-bold text-white mb-2">
            Hələlik tamamlanmış təcrübə proqramı yoxdur
          </h3>
          <p className="text-xs text-slate-400 max-w-md mx-auto leading-relaxed">
            Təcrübə qrupları bitdikdə və qiymətləndirmə təsdiqləndikdə məzunların siyahısı burada arxivlənir.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
