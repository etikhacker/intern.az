'use client';

import React, { useState } from 'react';
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';
import { useLanguage } from '@/lib/i18n/language-context';
import { Bell, Globe, Shield, CheckCircle2 } from 'lucide-react';

export default function StudentSettingsPage() {
  const { language, setLanguage } = useLanguage();
  const [saved, setSaved] = useState(false);

  const handleSave = () => {
    setSaved(true);
    setTimeout(() => setSaved(false), 2000);
  };

  return (
    <div className="space-y-6 max-w-3xl">
      <div className="pb-4 border-b border-slate-200">
        <h1 className="text-2xl font-bold text-slate-900 tracking-tight">
          Parametrlər
        </h1>
        <p className="text-xs text-slate-500 mt-1">
          Hesab və bildiriş tənzimləmələri
        </p>
      </div>

      {saved && (
        <div className="p-3 bg-emerald-50 border border-emerald-200 text-emerald-800 text-xs rounded-xl flex items-center gap-2">
          <CheckCircle2 className="w-4 h-4 text-emerald-600" />
          <span>Parametrlər yadda saxlanıldı.</span>
        </div>
      )}

      {/* Language Settings */}
      <Card className="border-slate-200 shadow-2xs">
        <CardHeader className="pb-3">
          <CardTitle className="text-base flex items-center gap-2">
            <Globe className="w-4 h-4 text-emerald-600" />
            İnterfeys Dili
          </CardTitle>
          <CardDescription className="text-xs">
            Platformada istifadə etmək istədiyiniz dili seçin
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-3">
          <div className="flex gap-3">
            <button
              onClick={() => setLanguage('az')}
              className={`px-4 py-2 rounded-xl text-xs font-semibold border transition-all ${
                language === 'az'
                  ? 'bg-emerald-50 border-emerald-500 text-emerald-900 shadow-2xs'
                  : 'bg-white border-slate-200 text-slate-600 hover:bg-slate-50'
              }`}
            >
              Azərbaycan dili (AZ)
            </button>
            <button
              onClick={() => setLanguage('en')}
              className={`px-4 py-2 rounded-xl text-xs font-semibold border transition-all ${
                language === 'en'
                  ? 'bg-emerald-50 border-emerald-500 text-emerald-900 shadow-2xs'
                  : 'bg-white border-slate-200 text-slate-600 hover:bg-slate-50'
              }`}
            >
              English (EN)
            </button>
          </div>
        </CardContent>
      </Card>

      {/* Notification Preferences */}
      <Card className="border-slate-200 shadow-2xs">
        <CardHeader className="pb-3">
          <CardTitle className="text-base flex items-center gap-2">
            <Bell className="w-4 h-4 text-emerald-600" />
            Bildiriş Tənzimləmələri
          </CardTitle>
          <CardDescription className="text-xs">
            E-poçt bildirişlərinin idarə edilməsi
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-3 text-xs">
          <label className="flex items-center gap-3 p-3 bg-slate-50 rounded-xl border border-slate-200 cursor-pointer">
            <input type="checkbox" defaultChecked className="rounded text-emerald-600 focus:ring-emerald-500" />
            <div>
              <p className="font-semibold text-slate-800">Yeni təcrübə elanları</p>
              <p className="text-slate-500 text-[11px]">Yeni təcrübə proqramı açıldıqda dərhal e-poçt göndərilsin</p>
            </div>
          </label>

          <label className="flex items-center gap-3 p-3 bg-slate-50 rounded-xl border border-slate-200 cursor-pointer">
            <input type="checkbox" defaultChecked className="rounded text-emerald-600 focus:ring-emerald-500" />
            <div>
              <p className="font-semibold text-slate-800">Müraciət statusu dəyişiklikləri</p>
              <p className="text-slate-500 text-[11px]">Müraciətiniz qəbul olunduqda və ya rəy verildikdə bildiriş göndərilsin</p>
            </div>
          </label>

          <Button size="sm" onClick={handleSave} className="mt-2 shadow-xs">
            Yadda saxla
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}
