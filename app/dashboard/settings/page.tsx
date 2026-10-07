'use client';

import React, { useState } from 'react';
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { useLanguage } from '@/lib/i18n/language-context';
import { Bell, Globe, CheckCircle2 } from 'lucide-react';

export default function StudentSettingsPage() {
  const { language, setLanguage, t } = useLanguage();
  const [saved, setSaved] = useState(false);

  const handleSave = () => {
    setSaved(true);
    setTimeout(() => setSaved(false), 2000);
  };

  const languageOptions = [
    { code: 'az' as const, label: t('languageAzLabel') },
    { code: 'en' as const, label: t('languageEnLabel') },
  ];

  return (
    <div className="space-y-6 max-w-3xl">
      {/* Page header. The divider spans the full content column (w-full) and
          sits flush under the copy block — previously it inherited the flex
          item's content width, so the rule rendered as a half-line. */}
      <header className="w-full border-b border-slate-300 pb-4">
        <h1 className="text-2xl font-bold text-slate-900 tracking-tight">
          {t('settingsTitle')}
        </h1>
        <p className="text-xs text-slate-500 mt-1">{t('settingsSubtitle')}</p>
      </header>

      {saved && (
        <div className="p-3 bg-emerald-50 border border-emerald-200 text-emerald-800 text-xs rounded-xl flex items-center gap-2">
          <CheckCircle2 className="w-4 h-4 text-emerald-600" />
          <span>{t('settingsSaved')}</span>
        </div>
      )}

      {/* Language Settings */}
      <Card className="border-slate-200 shadow-2xs">
        <CardHeader className="pb-3">
          <CardTitle className="text-base flex items-center gap-2">
            <Globe className="w-4 h-4 text-emerald-600" />
            {t('interfaceLanguage')}
          </CardTitle>
          <CardDescription className="text-xs">
            {t('interfaceLanguageDesc')}
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-3">
          <div className="flex flex-wrap gap-3">
            {languageOptions.map((option) => {
              const isActive = language === option.code;
              return (
                <button
                  key={option.code}
                  type="button"
                  onClick={() => setLanguage(option.code)}
                  aria-pressed={isActive}
                  className={`px-4 py-2 rounded-xl text-xs font-semibold border transition-all ${
                    isActive
                      ? 'bg-emerald-50 border-emerald-500 text-emerald-900 shadow-2xs'
                      : 'bg-white border-slate-200 text-slate-600 hover:bg-slate-50'
                  }`}
                >
                  {option.label}
                </button>
              );
            })}
          </div>
        </CardContent>
      </Card>

      {/* Notification Preferences */}
      <Card className="border-slate-200 shadow-2xs">
        <CardHeader className="pb-3">
          <CardTitle className="text-base flex items-center gap-2">
            <Bell className="w-4 h-4 text-emerald-600" />
            {t('notificationSettings')}
          </CardTitle>
          <CardDescription className="text-xs">
            {t('notificationSettingsDesc')}
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-3 text-xs">
          <label className="flex items-center gap-3 p-3 bg-slate-50 rounded-xl border border-slate-200 cursor-pointer">
            <input
              type="checkbox"
              defaultChecked
              className="rounded text-emerald-600 focus:ring-emerald-500"
            />
            <div>
              <p className="font-semibold text-slate-800">{t('notifNewInternships')}</p>
              <p className="text-slate-500 text-[11px]">{t('notifNewInternshipsDesc')}</p>
            </div>
          </label>

          <label className="flex items-center gap-3 p-3 bg-slate-50 rounded-xl border border-slate-200 cursor-pointer">
            <input
              type="checkbox"
              defaultChecked
              className="rounded text-emerald-600 focus:ring-emerald-500"
            />
            <div>
              <p className="font-semibold text-slate-800">{t('notifApplicationStatus')}</p>
              <p className="text-slate-500 text-[11px]">
                {t('notifApplicationStatusDesc')}
              </p>
            </div>
          </label>

          <Button size="sm" onClick={handleSave} className="mt-2 shadow-xs">
            {t('saveBtn')}
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}