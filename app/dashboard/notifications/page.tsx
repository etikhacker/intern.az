'use client';

import React from 'react';
import { Card, CardContent } from '@/components/ui/card';
import { Bell } from 'lucide-react';

export default function StudentNotificationsPage() {
  return (
    <div className="space-y-6">
      <div className="pb-4 border-b border-slate-200">
        <h1 className="text-2xl font-bold text-slate-900 tracking-tight">
          Bildirişlər
        </h1>
        <p className="text-xs text-slate-500 mt-1">
          Müraciət nəticələri, tapşırıq rəyləri və sistem elanları
        </p>
      </div>

      <Card className="border-slate-200 shadow-2xs">
        <CardContent className="p-12 text-center">
          <div className="w-16 h-16 rounded-2xl bg-slate-50 text-slate-400 flex items-center justify-center mx-auto mb-4 border border-slate-200">
            <Bell className="w-8 h-8" />
          </div>
          <h3 className="text-lg font-bold text-slate-900 mb-2">
            Yeni bildiriş yoxdur.
          </h3>
          <p className="text-xs text-slate-500 max-w-md mx-auto leading-relaxed">
            Təcrübə proqramları və tapşırıq yeniləmələri haqqında bütün bildirişlər burada göstəriləcəkdir.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
