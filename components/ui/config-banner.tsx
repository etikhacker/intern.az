'use client';

import React, { useState } from 'react';
import { isSupabaseConfigured } from '@/lib/supabase/config';
import { Database, CheckCircle2, ChevronRight, Copy, Check, X, ShieldAlert } from 'lucide-react';
import { Button } from './button';

export function ConfigBanner() {
  const isConfigured = isSupabaseConfigured();
  const [isOpen, setIsOpen] = useState(false);
  const [copied, setCopied] = useState(false);

  const envSnippet = `NEXT_PUBLIC_SUPABASE_URL="https://your-project.supabase.co"
NEXT_PUBLIC_SUPABASE_ANON_KEY="your-anon-public-key"`;

  const handleCopy = () => {
    navigator.clipboard.writeText(envSnippet);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  return (
    <>
      <aside
        aria-label="Database Status"
        className="w-full bg-slate-900 text-white text-xs border-b border-slate-800 px-4 py-2 flex flex-wrap items-center justify-between gap-2 z-40"
      >
        <div className="flex items-center gap-2">
          <span className="flex h-2 w-2 rounded-full relative">
            <span
              className={`animate-ping absolute inline-flex h-full w-full rounded-full opacity-75 ${
                isConfigured ? 'bg-emerald-400' : 'bg-amber-400'
              }`}
            />
            <span
              className={`relative inline-flex rounded-full h-2 w-2 ${
                isConfigured ? 'bg-emerald-500' : 'bg-amber-500'
              }`}
            />
          </span>
          <span className="font-semibold text-slate-200">
            {isConfigured ? 'Supabase Connected:' : 'Supabase Environment:'}
          </span>
          <span className="text-slate-400 hidden sm:inline">
            {isConfigured
              ? 'PostgreSQL database & Row Level Security active'
              : 'Running in Interactive Preview mode. Add credentials in .env.local to link live Supabase.'}
          </span>
        </div>

        <div className="flex items-center gap-2">
          <button
            onClick={() => setIsOpen(true)}
            className="inline-flex items-center gap-1 text-emerald-400 hover:text-emerald-300 font-medium transition-colors"
          >
            Setup Guide & SQL Migration
            <ChevronRight className="w-3.5 h-3.5" />
          </button>
        </div>
      </aside>

      {/* Instructions Modal */}
      {isOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-950/60 backdrop-blur-sm">
          <div className="bg-white rounded-2xl max-w-2xl w-full max-h-[85vh] overflow-y-auto p-6 shadow-2xl border border-slate-200">
            <div className="flex items-start justify-between pb-4 border-b border-slate-100">
              <div className="flex items-center gap-2">
                <div className="p-2 rounded-lg bg-emerald-50 text-emerald-600">
                  <Database className="w-5 h-5" />
                </div>
                <div>
                  <h3 className="font-bold text-slate-900 text-lg">
                    Supabase Free-Tier Integration Guide
                  </h3>
                  <p className="text-xs text-slate-500">
                    Phase 1: Profiles table, Row Level Security, and Admin access
                  </p>
                </div>
              </div>
              <button
                onClick={() => setIsOpen(false)}
                className="p-1 rounded-lg text-slate-400 hover:text-slate-600 hover:bg-slate-100"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <div className="mt-4 space-y-4 text-sm text-slate-600">
              <div className="bg-emerald-50/70 border border-emerald-200 rounded-xl p-3.5 flex items-start gap-3">
                <CheckCircle2 className="w-5 h-5 text-emerald-600 shrink-0 mt-0.5" />
                <div className="text-xs text-emerald-950">
                  <p className="font-semibold text-emerald-900">100% Free Plan Compatible</p>
                  <p className="mt-0.5 text-emerald-800">
                    Supabase Free includes 500MB PostgreSQL, 50,000 monthly active auth users, and 1GB storage. No credit card required.
                  </p>
                </div>
              </div>

              <div>
                <h4 className="font-semibold text-slate-900 mb-1">
                  1. Add Environment Variables
                </h4>
                <p className="text-xs text-slate-500 mb-2">
                  Create or update your <code className="bg-slate-100 px-1 py-0.5 rounded text-slate-800">.env.local</code> with your Supabase Project API keys:
                </p>
                <div className="relative bg-slate-900 text-slate-100 p-3 rounded-xl font-mono text-xs overflow-x-auto">
                  <pre>{envSnippet}</pre>
                  <button
                    onClick={handleCopy}
                    className="absolute top-2 right-2 p-1.5 rounded-md bg-slate-800 hover:bg-slate-700 text-slate-300 transition-colors"
                    title="Copy environment variables"
                  >
                    {copied ? <Check className="w-3.5 h-3.5 text-emerald-400" /> : <Copy className="w-3.5 h-3.5" />}
                  </button>
                </div>
              </div>

              <div>
                <h4 className="font-semibold text-slate-900 mb-1">
                  2. Apply SQL Migration
                </h4>
                <p className="text-xs text-slate-500 mb-1">
                  Go to your Supabase Dashboard → <strong>SQL Editor</strong> → New Query, and paste the contents of:
                </p>
                <div className="bg-slate-50 border border-slate-200 p-2.5 rounded-lg text-xs font-mono text-slate-700">
                  supabase/migrations/20260921000000_create_profiles.sql
                </div>
              </div>

              <div>
                <h4 className="font-semibold text-slate-900 mb-1 flex items-center gap-1.5">
                  <ShieldAlert className="w-4 h-4 text-amber-600" />
                  3. Creating Your First Admin Account
                </h4>
                <p className="text-xs text-slate-500 mb-2">
                  Public registration strictly assigns the <code className="bg-slate-100 px-1 py-0.5 rounded">student</code> role. To promote your account to administrator, run:
                </p>
                <div className="bg-slate-900 text-slate-100 p-3 rounded-xl font-mono text-xs overflow-x-auto">
                  <pre>{`UPDATE public.profiles
SET role = 'admin'
WHERE email = 'your-email@domain.com';`}</pre>
                </div>
              </div>

              <div className="pt-2 border-t border-slate-100 flex justify-end">
                <Button variant="default" size="sm" onClick={() => setIsOpen(false)}>
                  Close Guide
                </Button>
              </div>
            </div>
          </div>
        </div>
      )}
    </>
  );
}
