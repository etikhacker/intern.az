'use client';

import React, { useEffect, useState } from 'react';
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { useLanguage } from '@/lib/i18n/language-context';
import { useAuth } from '@/lib/auth/auth-context';
import { createClient } from '@/lib/supabase/client';
import {
  DEFAULT_NOTIFICATION_PREFERENCES,
  mergeNotificationPreferences,
  normalizeNotificationPreferences,
} from '@/lib/notification-preferences';
import type { NotificationPreferences } from '@/lib/notification-preferences';
import { Bell, Globe, CheckCircle2, AlertCircle } from 'lucide-react';

type Feedback = { type: 'success' | 'error'; message: string } | null;

export default function StudentSettingsPage() {
  const { language, setLanguage } = useLanguage();
  const { user, isLoading: authLoading } = useAuth();
  const [preferences, setPreferences] = useState<NotificationPreferences>({
    ...DEFAULT_NOTIFICATION_PREFERENCES,
  });
  const [preferencesLoading, setPreferencesLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [feedback, setFeedback] = useState<Feedback>(null);

  useEffect(() => {
    if (authLoading) return;

    let isCurrent = true;
    const loadPreferences = async () => {
      if (!user) {
        if (isCurrent) {
          setPreferencesLoading(false);
          setFeedback({ type: 'error', message: 'Bildiriş parametrlərini görmək üçün hesabınıza daxil olun.' });
        }
        return;
      }

      const supabase = createClient();
      if (!supabase) {
        if (isCurrent) {
          setPreferencesLoading(false);
          setFeedback({ type: 'error', message: 'Verilənlər bazası ilə əlaqə qurulmadı.' });
        }
        return;
      }

      try {
        const { data, error } = await supabase.auth.getUser();
        if (error) throw error;
        if (!data.user) throw new Error('İstifadəçi sessiyası tapılmadı.');

        if (isCurrent) {
          setPreferences(
            normalizeNotificationPreferences(data.user.user_metadata?.notification_preferences)
          );
          setFeedback(null);
        }
      } catch (error) {
        if (isCurrent) {
          setFeedback({
            type: 'error',
            message: error instanceof Error ? error.message : 'Bildiriş parametrləri yüklənmədi.',
          });
        }
      } finally {
        if (isCurrent) setPreferencesLoading(false);
      }
    };

    void loadPreferences();
    return () => {
      isCurrent = false;
    };
  }, [authLoading, user]);

  const handleSave = async () => {
    const supabase = createClient();
    if (!supabase || !user) {
      setFeedback({ type: 'error', message: 'Parametrləri saxlamaq üçün hesabınıza daxil olun.' });
      return;
    }

    setSaving(true);
    setFeedback(null);

    try {
      const { data, error: userError } = await supabase.auth.getUser();
      if (userError) throw userError;
      if (!data.user) throw new Error('İstifadəçi sessiyası tapılmadı.');

      const { error } = await supabase.auth.updateUser({
        data: mergeNotificationPreferences(data.user.user_metadata, preferences),
      });
      if (error) throw error;

      setFeedback({ type: 'success', message: 'Bildiriş parametrləri yadda saxlanıldı.' });
    } catch (error) {
      setFeedback({
        type: 'error',
        message: error instanceof Error ? error.message : 'Parametrlər saxlanarkən xəta baş verdi.',
      });
    } finally {
      setSaving(false);
    }
  };

  const updatePreference = (key: keyof NotificationPreferences, checked: boolean) => {
    setPreferences((current) => ({ ...current, [key]: checked }));
    setFeedback(null);
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

      {feedback && (
        <div
          role={feedback.type === 'error' ? 'alert' : 'status'}
          className={`p-3 border text-xs rounded-xl flex items-center gap-2 ${
            feedback.type === 'success'
              ? 'bg-emerald-50 border-emerald-200 text-emerald-800'
              : 'bg-red-50 border-red-200 text-red-800'
          }`}
        >
          {feedback.type === 'success' ? (
            <CheckCircle2 className="w-4 h-4 shrink-0 text-emerald-600" />
          ) : (
            <AlertCircle className="w-4 h-4 shrink-0 text-red-600" />
          )}
          <span>{feedback.message}</span>
        </div>
      )}

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
              type="button"
              onClick={() => setLanguage('az')}
              aria-pressed={language === 'az'}
              className={`px-4 py-2 rounded-xl text-xs font-semibold border transition-all ${
                language === 'az'
                  ? 'bg-emerald-50 border-emerald-500 text-emerald-900 shadow-2xs'
                  : 'bg-white border-slate-200 text-slate-600 hover:bg-slate-50'
              }`}
            >
              Azərbaycan dili (AZ)
            </button>
            <button
              type="button"
              onClick={() => setLanguage('en')}
              aria-pressed={language === 'en'}
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

      <Card className="border-slate-200 shadow-2xs">
        <CardHeader className="pb-3">
          <CardTitle className="text-base flex items-center gap-2">
            <Bell className="w-4 h-4 text-emerald-600" />
            Bildiriş Tənzimləmələri
          </CardTitle>
          <CardDescription className="text-xs">
            E-poçt bildirişləri üçün seçimlərinizi idarə edin
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-3 text-xs">
          <label
            htmlFor="new-internship-announcements"
            className={`flex items-center gap-3 p-3 bg-slate-50 rounded-xl border border-slate-200 ${preferencesLoading ? 'opacity-60' : 'cursor-pointer'}`}
          >
            <input
              id="new-internship-announcements"
              type="checkbox"
              checked={preferences.new_internship_announcements}
              onChange={(event) => updatePreference('new_internship_announcements', event.target.checked)}
              disabled={preferencesLoading || saving}
              className="rounded text-emerald-600 focus:ring-emerald-500"
            />
            <div>
              <p className="font-semibold text-slate-800">Yeni təcrübə elanları</p>
              <p className="text-slate-500 text-[11px]">Yeni təcrübə proqramı açıldıqda e-poçt bildirişi almaq</p>
            </div>
          </label>

          <label
            htmlFor="application-status-updates"
            className={`flex items-center gap-3 p-3 bg-slate-50 rounded-xl border border-slate-200 ${preferencesLoading ? 'opacity-60' : 'cursor-pointer'}`}
          >
            <input
              id="application-status-updates"
              type="checkbox"
              checked={preferences.application_status_updates}
              onChange={(event) => updatePreference('application_status_updates', event.target.checked)}
              disabled={preferencesLoading || saving}
              className="rounded text-emerald-600 focus:ring-emerald-500"
            />
            <div>
              <p className="font-semibold text-slate-800">Müraciət statusu dəyişiklikləri</p>
              <p className="text-slate-500 text-[11px]">Müraciətinizin statusu dəyişdikdə e-poçt bildirişi almaq</p>
            </div>
          </label>

          <Button
            size="sm"
            onClick={handleSave}
            disabled={preferencesLoading || saving || authLoading || !user}
            className="mt-2 shadow-xs"
          >
            {saving ? 'Saxlanılır...' : 'Yadda saxla'}
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}
