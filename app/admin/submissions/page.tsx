'use client';

import React from 'react';
import { Card, CardContent } from '@/components/ui/card';
import { CheckCircle } from 'lucide-react';

export default function AdminSubmissionsPage() {
  return (
    <div className="space-y-6">
      <div className="pb-4 border-b border-slate-800">
        <h1 className="text-2xl font-bold text-white tracking-tight">
          Tapşırıq Təqdimatları
        </h1>
        <p className="text-xs text-slate-400 mt-1">
          Tələbələrin göndərdiyi həllər və koordinator rəyləri
        </p>
      </div>

      <Card className="bg-slate-900 border-slate-800 text-white">
        <CardContent className="p-12 text-center">
          <div className="w-16 h-16 rounded-2xl bg-slate-800 text-amber-400 flex items-center justify-center mx-auto mb-4 border border-slate-700">
            <CheckCircle className="w-8 h-8" />
          </div>
          <h3 className="text-lg font-bold text-white mb-2">
            Yoxlama gözləyən təqdimat yoxdur
          </h3>
          <p className="text-xs text-slate-400 max-w-md mx-auto leading-relaxed">
            Tələbələr tapşırıq həllərini təqdim etdikdə qiymətləndirmə siyahısı burada formalaşacaqdır.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
