'use client';

import React, { useState } from 'react';
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Settings, Shield, CheckCircle2 } from 'lucide-react';

export default function AdminSettingsPage() {
  const [saved, setSaved] = useState(false);
  const [settings, setSettings] = useState({
    platformName: 'Intern.az',
    supportEmail: 'info@intern.az',
    contactPhone: '+994 (12) 500-00-00',
    certificatePrice: '15 AZN',
  });

  const handleSave = (e: React.FormEvent) => {
    e.preventDefault();
    setSaved(true);
    setTimeout(() => setSaved(false), 2000);
  };

  return (
    <div className="space-y-6 max-w-3xl">
      <div className="pb-4 border-b border-slate-800">
        <h1 className="text-2xl font-bold text-white tracking-tight">
          İnzibatçı Parametrləri
        </h1>
        <p className="text-xs text-slate-400 mt-1">
          Platforma qlobal parametrləri və əlaqə tənzimləmələri
        </p>
      </div>

      {saved && (
        <div className="p-3 bg-emerald-950/60 border border-emerald-800 text-emerald-300 text-xs rounded-xl flex items-center gap-2">
          <CheckCircle2 className="w-4 h-4 text-emerald-400" />
          <span>Parametrlər yadda saxlanıldı.</span>
        </div>
      )}

      <Card className="bg-slate-900 border-slate-800 text-white">
        <CardHeader className="pb-3">
          <CardTitle className="text-base text-white flex items-center gap-2">
            <Settings className="w-4 h-4 text-amber-400" />
            Ümumi Platforma Məlumatları
          </CardTitle>
          <CardDescription className="text-xs text-slate-400">
            Saytda və rəsmi sənədlərdə əks olunan ilkin məlumatlar
          </CardDescription>
        </CardHeader>

        <CardContent>
          <form onSubmit={handleSave} className="space-y-4">
            <div>
              <Label className="text-xs text-slate-300">Platforma Adı</Label>
              <Input
                value={settings.platformName}
                onChange={(e) => setSettings({ ...settings, platformName: e.target.value })}
                className="mt-1 bg-slate-950 border-slate-700 text-white"
              />
            </div>

            <div>
              <Label className="text-xs text-slate-300">Dəstək E-poçtu</Label>
              <Input
                value={settings.supportEmail}
                onChange={(e) => setSettings({ ...settings, supportEmail: e.target.value })}
                className="mt-1 bg-slate-950 border-slate-700 text-white"
              />
            </div>

            <div>
              <Label className="text-xs text-slate-300">Əlaqə Telefonu</Label>
              <Input
                value={settings.contactPhone}
                onChange={(e) => setSettings({ ...settings, contactPhone: e.target.value })}
                className="mt-1 bg-slate-950 border-slate-700 text-white"
              />
            </div>

            <div>
              <Label className="text-xs text-slate-300">Rəsmi Sertifikat Rüsumu</Label>
              <Input
                value={settings.certificatePrice}
                onChange={(e) => setSettings({ ...settings, certificatePrice: e.target.value })}
                className="mt-1 bg-slate-950 border-slate-700 text-white"
              />
            </div>

            <Button type="submit" className="bg-amber-400 hover:bg-amber-500 text-slate-950 font-bold shadow-xs">
              Yadda saxla
            </Button>
          </form>
        </CardContent>
      </Card>
    </div>
  );
}
