'use client';

import { useEffect } from 'react';
import { Moon } from 'lucide-react';

const STORAGE_KEY = 'intern-az-theme';

export function ThemeToggle() {
  // Light theme was removed — the codebase uses literal text-white /
  // text-slate-300 contrast classes on hero and CTA surfaces, which would
  // become invisible on a light background. We force dark and keep the
  // icon as a decorative element so layout doesn't shift.
  useEffect(() => {
    document.documentElement.classList.add('dark');
    document.documentElement.classList.remove('light');
    try {
      window.localStorage.setItem(STORAGE_KEY, 'dark');
    } catch {
      /* localStorage may be unavailable — non-fatal */
    }
  }, []);

  return (
    <button
      type="button"
      aria-label="Qaranlıq tema"
      title="Qaranlıq tema"
      onClick={(e) => e.preventDefault()}
      className="theme-toggle inline-flex h-8 w-8 items-center justify-center rounded-lg border border-slate-200/80 bg-slate-100/70 text-slate-300 transition-transform duration-200 hover:-translate-y-0.5 hover:text-emerald-300"
    >
      <Moon className="h-4 w-4" aria-hidden="true" />
    </button>
  );
}
