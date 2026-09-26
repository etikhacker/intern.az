'use client';

import { useEffect, useState } from 'react';
import { Moon, Sun } from 'lucide-react';

const STORAGE_KEY = 'intern-az-theme';

type Theme = 'light' | 'dark';

function readSavedTheme(): Theme | null {
  if (typeof window === 'undefined') return null;
  try {
    const v = window.localStorage.getItem(STORAGE_KEY);
    if (v === 'light' || v === 'dark') return v;
  } catch {
    /* localStorage may be unavailable — non-fatal */
  }
  return null;
}

function applyTheme(theme: Theme) {
  const root = document.documentElement;
  if (theme === 'dark') {
    root.classList.add('dark');
    root.classList.remove('light');
  } else {
    root.classList.add('light');
    root.classList.remove('dark');
  }
}

export function ThemeToggle() {
  const [theme, setTheme] = useState<Theme>('light');
  const [mounted, setMounted] = useState(false);

  // Read saved preference on mount so client and server agree visually.
  // This is the standard React pattern for "read something client-only after
  // hydration" — the cascading render is the entire point here.
  useEffect(() => {
    const saved = readSavedTheme();
    const next: Theme = saved ?? 'light';
    // eslint-disable-next-line react-hooks/set-state-in-effect
    setTheme(next);
    applyTheme(next);
    setMounted(true);
  }, []);

  const toggle = () => {
    const next: Theme = theme === 'light' ? 'dark' : 'light';
    setTheme(next);
    applyTheme(next);
    try {
      window.localStorage.setItem(STORAGE_KEY, next);
    } catch {
      /* localStorage may be unavailable — non-fatal */
    }
  };

  const isLight = theme === 'light';
  const label = isLight ? 'Qaranlıq tema' : 'Açıq tema';
  const title = isLight ? 'Qaranlıq temaya keç' : 'Açıq temaya keç';

  return (
    <button
      type="button"
      aria-label={label}
      title={title}
      onClick={toggle}
      className="theme-toggle inline-flex h-9 w-9 items-center justify-center rounded-lg border border-slate-200 bg-white text-slate-600 transition-all duration-200 hover:-translate-y-0.5 hover:text-emerald-600 hover:border-emerald-300 hover:shadow-sm"
    >
      {/* Render both icons; CSS visibility swaps on light vs dark. Avoids
       * layout shift when the user toggles and keeps server/client markup
       * identical before hydration. */}
      <Sun
        aria-hidden="true"
        className={`h-4 w-4 ${mounted && isLight ? 'block' : 'hidden'}`}
      />
      <Moon
        aria-hidden="true"
        className={`h-4 w-4 ${mounted && !isLight ? 'block' : 'hidden'}`}
      />
      {!mounted && <Sun aria-hidden="true" className="h-4 w-4 opacity-0" />}
    </button>
  );
}
