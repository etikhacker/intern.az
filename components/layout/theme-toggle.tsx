'use client';

import { useEffect, useSyncExternalStore } from 'react';
import { Moon, Sun } from 'lucide-react';

const STORAGE_KEY = 'intern-az-theme';
const THEME_EVENT = 'intern-az-theme-change';
type Theme = 'dark' | 'light';

function getTheme(): Theme {
  const saved = window.localStorage.getItem(STORAGE_KEY) as Theme | null;
  return saved ?? (window.matchMedia('(prefers-color-scheme: light)').matches ? 'light' : 'dark');
}

function subscribe(callback: () => void) {
  window.addEventListener(THEME_EVENT, callback);
  return () => window.removeEventListener(THEME_EVENT, callback);
}

export function ThemeToggle() {
  const theme = useSyncExternalStore(subscribe, getTheme, () => 'dark' as Theme);

  useEffect(() => {
    document.documentElement.classList.toggle('light', theme === 'light');
  }, [theme]);

  const toggleTheme = () => {
    const next: Theme = theme === 'dark' ? 'light' : 'dark';
    window.localStorage.setItem(STORAGE_KEY, next);
    document.documentElement.classList.toggle('light', next === 'light');
    window.dispatchEvent(new Event(THEME_EVENT));
  };

  return (
    <button
      type="button"
      onClick={toggleTheme}
      aria-label={theme === 'dark' ? 'Açıq temaya keç' : 'Qaranlıq temaya keç'}
      title={theme === 'dark' ? 'Açıq tema' : 'Qaranlıq tema'}
      className="theme-toggle inline-flex h-8 w-8 items-center justify-center rounded-lg border border-slate-200/80 bg-slate-100/70 text-slate-300 transition-transform duration-200 hover:-translate-y-0.5 hover:text-emerald-300"
    >
      {theme === 'dark' ? <Sun className="h-4 w-4" aria-hidden="true" /> : <Moon className="h-4 w-4" aria-hidden="true" />}
    </button>
  );
}
