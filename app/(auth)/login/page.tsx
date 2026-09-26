'use client';

import React, { useEffect, useState, Suspense } from 'react';
import Link from 'next/link';
import { useRouter, useSearchParams } from 'next/navigation';
import { useAuth } from '@/lib/auth/auth-context';
import { loginSchema, LoginFormData } from '@/lib/validations/auth';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Alert, AlertDescription } from '@/components/ui/alert';
import {
  ArrowLeft,
  ArrowRight,
  Award,
  BookOpen,
  Briefcase,
  Check,
  Eye,
  EyeOff,
  GraduationCap,
  Loader2,
  Mail,
  Lock,
  ShieldCheck,
  Sparkles,
  Star,
  Users,
} from 'lucide-react';

const REMEMBER_KEY = 'intern-az-remember-email';

/* ---------------------------------------------------------------------------
 * Left brand panel — shown on desktop. Marketing copy, abstract art and
 * social proof stacked above decorative gradient orbs.
 * ------------------------------------------------------------------------ */
function BrandPanel() {
  return (
    <div className="relative hidden h-full overflow-hidden bg-gradient-to-br from-emerald-500 via-emerald-600 to-teal-700 text-white lg:flex lg:flex-col lg:justify-between lg:p-12 xl:p-16">
      {/* Decorative orbs */}
      <div
        aria-hidden="true"
        className="pointer-events-none absolute -top-24 -left-24 h-96 w-96 rounded-full bg-emerald-300/40 blur-3xl"
      />
      <div
        aria-hidden="true"
        className="pointer-events-none absolute -bottom-32 -right-20 h-[28rem] w-[28rem] rounded-full bg-cyan-300/30 blur-3xl"
      />
      <div
        aria-hidden="true"
        className="pointer-events-none absolute top-1/3 right-12 h-48 w-48 rounded-full bg-white/10 blur-2xl"
      />

      {/* Subtle grid */}
      <div
        aria-hidden="true"
        className="pointer-events-none absolute inset-0 opacity-[0.07]"
        style={{
          backgroundImage:
            'linear-gradient(rgba(255,255,255,0.6) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,0.6) 1px, transparent 1px)',
          backgroundSize: '40px 40px',
        }}
      />

      {/* Logo + nav hint */}
      <div className="relative z-10 flex items-center gap-3">
        <div className="flex h-11 w-11 items-center justify-center rounded-2xl bg-white text-emerald-700 shadow-lg shadow-emerald-900/20">
          <GraduationCap className="h-6 w-6" aria-hidden="true" />
        </div>
        <div>
          <p className="text-lg font-bold tracking-tight">Intern.az</p>
          <p className="text-[10px] uppercase tracking-[0.18em] text-emerald-50/80">
            Təcrübə Portalı
          </p>
        </div>
      </div>

      {/* Marketing copy */}
      <div className="relative z-10 max-w-md space-y-6">
        <div className="inline-flex items-center gap-2 rounded-full border border-white/20 bg-white/10 px-3.5 py-1.5 text-[11px] font-bold uppercase tracking-[0.18em] backdrop-blur-md">
          <Sparkles className="h-3.5 w-3.5" aria-hidden="true" />
          Tələbələr üçün
        </div>
        <h2 className="text-4xl font-black leading-[1.05] tracking-tight xl:text-5xl">
          Öyrəndiklərini{' '}
          <span className="bg-gradient-to-r from-amber-200 via-white to-cyan-200 bg-clip-text text-transparent">
            portfelə
          </span>{' '}
          çevir.
        </h2>
        <p className="text-base leading-relaxed text-emerald-50/90">
          Hesabına daxil ol, real layihələri tap, mentor rəyini al və
          karyeranda görünən nəticələr qazan.
        </p>

        {/* Feature bullets */}
        <ul className="space-y-2.5 pt-2 text-sm text-emerald-50/90">
          <li className="flex items-center gap-2.5">
            <span className="flex h-5 w-5 items-center justify-center rounded-full bg-white/15">
              <Check className="h-3 w-3" aria-hidden="true" />
            </span>
            Real şirkət layihələri üzərində iş
          </li>
          <li className="flex items-center gap-2.5">
            <span className="flex h-5 w-5 items-center justify-center rounded-full bg-white/15">
              <Check className="h-3 w-3" aria-hidden="true" />
            </span>
            Fərdi mentor dəstəyi və rəy
          </li>
          <li className="flex items-center gap-2.5">
            <span className="flex h-5 w-5 items-center justify-center rounded-full bg-white/15">
              <Check className="h-3 w-3" aria-hidden="true" />
            </span>
            Verifikasiya olunan sertifikat
          </li>
        </ul>
      </div>

      {/* Floating stats card */}
      <div className="relative z-10 grid grid-cols-3 gap-3">
        <div className="rounded-2xl border border-white/15 bg-white/10 p-4 backdrop-blur-md">
          <Users className="h-4 w-4 text-emerald-50" aria-hidden="true" />
          <p className="mt-3 text-2xl font-black tracking-tight">2.4K+</p>
          <p className="text-[10px] uppercase tracking-wider text-emerald-50/80">
            Tələbə
          </p>
        </div>
        <div className="rounded-2xl border border-white/15 bg-white/10 p-4 backdrop-blur-md">
          <Briefcase className="h-4 w-4 text-amber-200" aria-hidden="true" />
          <p className="mt-3 text-2xl font-black tracking-tight">180+</p>
          <p className="text-[10px] uppercase tracking-wider text-emerald-50/80">
            Şirkət
          </p>
        </div>
        <div className="rounded-2xl border border-white/15 bg-white/10 p-4 backdrop-blur-md">
          <Award className="h-4 w-4 text-cyan-200" aria-hidden="true" />
          <p className="mt-3 text-2xl font-black tracking-tight">96%</p>
          <p className="text-[10px] uppercase tracking-wider text-emerald-50/80">
            Məmnuniyyət
          </p>
        </div>
      </div>

      {/* Floating review card (top-right) */}
      <div
        aria-hidden="true"
        className="absolute right-8 top-1/2 hidden -translate-y-1/2 rotate-3 rounded-2xl border border-white/20 bg-white/95 p-4 text-slate-900 shadow-2xl shadow-emerald-900/30 backdrop-blur-md xl:block"
      >
        <div className="flex items-center gap-1 text-amber-500">
          {[...Array(5)].map((_, i) => (
            <Star key={i} className="h-3.5 w-3.5 fill-current" />
          ))}
        </div>
        <p className="mt-2 max-w-[13rem] text-xs font-medium leading-snug">
          &ldquo;İlk təcrübəmdə real layihə gördüm, sertifikatım indi CV-də parlayır.&rdquo;
        </p>
        <div className="mt-3 flex items-center gap-2">
          <div className="flex h-7 w-7 items-center justify-center rounded-full bg-emerald-500 text-[10px] font-bold text-white">
            LM
          </div>
          <div>
            <p className="text-[11px] font-bold">Leyla M.</p>
            <p className="text-[9px] text-slate-500">Frontend, 2025</p>
          </div>
        </div>
      </div>

      {/* Floating book card (bottom-left) */}
      <div
        aria-hidden="true"
        className="absolute bottom-44 left-8 hidden -rotate-6 rounded-2xl border border-white/20 bg-white/95 p-3 text-slate-900 shadow-2xl shadow-emerald-900/30 backdrop-blur-md xl:block"
      >
        <div className="flex items-center gap-2.5">
          <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-amber-100 text-amber-700">
            <BookOpen className="h-4 w-4" aria-hidden="true" />
          </div>
          <div>
            <p className="text-[10px] font-bold text-slate-500">YENİ</p>
            <p className="text-xs font-bold leading-tight">AI & Automation</p>
            <p className="text-[9px] text-slate-400">Track 03</p>
          </div>
        </div>
      </div>
    </div>
  );
}

/* ---------------------------------------------------------------------------
 * Mobile-only compact brand bar.
 * ------------------------------------------------------------------------ */
function MobileBrand() {
  return (
    <div className="relative overflow-hidden bg-gradient-to-br from-emerald-500 via-emerald-600 to-teal-700 px-6 py-7 text-white lg:hidden">
      <div
        aria-hidden="true"
        className="pointer-events-none absolute -top-12 -right-12 h-40 w-40 rounded-full bg-emerald-300/40 blur-3xl"
      />
      <Link href="/" className="relative z-10 inline-flex items-center gap-2.5">
        <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-white text-emerald-700 shadow-lg shadow-emerald-900/20">
          <GraduationCap className="h-5 w-5" aria-hidden="true" />
        </div>
        <div>
          <p className="text-lg font-bold tracking-tight">Intern.az</p>
          <p className="text-[9px] uppercase tracking-[0.18em] text-emerald-50/80">
            Təcrübə Portalı
          </p>
        </div>
      </Link>
      <h2 className="relative z-10 mt-5 text-2xl font-black leading-tight">
        Öyrəndiklərini portfelə çevir.
      </h2>
    </div>
  );
}

/* ---------------------------------------------------------------------------
 * Form panel — the actual login UI.
 * ------------------------------------------------------------------------ */
function LoginForm() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const redirectPath = searchParams.get('redirect') || '/dashboard';
  const { signIn } = useAuth();

  const [formData, setFormData] = useState<LoginFormData>({
    email: '',
    password: '',
  });

  const [errors, setErrors] = useState<Record<string, string>>({});
  const [serverError, setServerError] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [remember, setRemember] = useState(true);

  // Restore remembered email on mount (client-only via typeof guard).
  // setState-in-effect here is intentional — the entire purpose is to
  // hydrate local state from external (localStorage) on mount.
  useEffect(() => {
    try {
      const saved = window.localStorage.getItem(REMEMBER_KEY);
      if (saved) {
        // eslint-disable-next-line react-hooks/set-state-in-effect
        setFormData((prev) => ({ ...prev, email: saved }));
      }
    } catch {
      /* localStorage may be unavailable — non-fatal */
    }
  }, []);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
    if (errors[name]) {
      setErrors((prev) => {
        const next = { ...prev };
        delete next[name];
        return next;
      });
    }
    setServerError(null);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setServerError(null);
    setErrors({});

    const result = loginSchema.safeParse(formData);
    if (!result.success) {
      const fieldErrors: Record<string, string> = {};
      result.error.issues.forEach((issue) => {
        const field = issue.path[0] as string;
        fieldErrors[field] = issue.message;
      });
      setErrors(fieldErrors);
      return;
    }

    // Persist (or clear) remembered email based on user preference.
    try {
      if (remember) {
        window.localStorage.setItem(REMEMBER_KEY, result.data.email);
      } else {
        window.localStorage.removeItem(REMEMBER_KEY);
      }
    } catch {
      /* localStorage may be unavailable — non-fatal */
    }

    setIsSubmitting(true);

    try {
      const res = await signIn({
        email: result.data.email,
        password: result.data.password,
      });

      if (!res.success) {
        setServerError(res.error || 'İstifadəçi adı və ya şifrə yanlışdır');
        setIsSubmitting(false);
        return;
      }

      if (res.role === 'admin') {
        router.push('/admin');
      } else {
        router.push(
          redirectPath.startsWith('/dashboard') ? redirectPath : '/dashboard'
        );
      }
    } catch {
      setServerError('Xəta baş verdi. Zəhmət olmasa yenidən cəhd edin.');
      setIsSubmitting(false);
    }
  };

  return (
    <div className="relative flex w-full flex-col">
      {/* Top bar: back-to-landing link + admin link */}
      <div className="flex items-center justify-between border-b border-slate-100 px-6 py-4 sm:px-10">
        <Link
          href="/"
          className="group inline-flex items-center gap-2 text-sm font-semibold text-slate-600 transition-colors hover:text-emerald-600"
        >
          <span className="flex h-8 w-8 items-center justify-center rounded-lg border border-slate-200 bg-white text-slate-500 transition-all group-hover:-translate-x-0.5 group-hover:border-emerald-300 group-hover:text-emerald-600">
            <ArrowLeft className="h-4 w-4" aria-hidden="true" />
          </span>
          <span>Ana səhifə</span>
        </Link>
        <Link
          href="/admin/login"
          className="inline-flex items-center gap-1.5 text-xs font-medium text-slate-500 transition-colors hover:text-slate-900"
        >
          <ShieldCheck className="h-3.5 w-3.5" aria-hidden="true" />
          Administrator girişi
        </Link>
      </div>

      {/* Form area */}
      <div className="flex-1 px-6 py-8 sm:px-10 sm:py-10 lg:px-14 xl:px-20">
        <div className="mx-auto w-full max-w-md">
          {/* Heading */}
          <div className="space-y-2">
            <span className="inline-flex items-center gap-1.5 rounded-full bg-emerald-50 px-2.5 py-1 text-[10px] font-bold uppercase tracking-[0.16em] text-emerald-700">
              <span className="h-1.5 w-1.5 rounded-full bg-emerald-500" />
              Tələbə kabineti
            </span>
            <h1 className="text-3xl font-black tracking-tight text-slate-900 sm:text-4xl">
              Xoş gəldin geri.
            </h1>
            <p className="text-sm leading-relaxed text-slate-500">
              Hesabına daxil ol, təcrübə müraciətlərinə və tapşırıqlarına bax.
            </p>
          </div>

          {/* Server error */}
          {serverError && (
            <Alert
              variant="destructive"
              className="mt-6 text-xs"
            >
              <AlertDescription>{serverError}</AlertDescription>
            </Alert>
          )}

          {/* Form */}
          <form onSubmit={handleSubmit} className="mt-8 space-y-5" noValidate>
            {/* Email */}
            <div className="space-y-1.5">
              <Label
                htmlFor="email"
                className="text-xs font-semibold uppercase tracking-wider text-slate-700"
              >
                E-poçt ünvanı
              </Label>
              <div className="group relative">
                <div className="pointer-events-none absolute inset-y-0 left-0 flex w-11 items-center justify-center text-slate-400 transition-colors group-focus-within:text-emerald-600">
                  <Mail className="h-4 w-4" aria-hidden="true" />
                </div>
                <Input
                  id="email"
                  name="email"
                  type="email"
                  placeholder="telebe@universitet.edu.az"
                  value={formData.email}
                  onChange={handleChange}
                  disabled={isSubmitting}
                  className="h-12 rounded-xl border-slate-200 bg-slate-50 pl-11 pr-3 text-sm text-slate-900 placeholder:text-slate-400 focus:bg-white focus:border-emerald-500 focus:ring-2 focus:ring-emerald-500/20"
                  required
                />
              </div>
              {errors.email && (
                <p className="text-xs text-red-600">{errors.email}</p>
              )}
            </div>

            {/* Password */}
            <div className="space-y-1.5">
              <div className="flex items-center justify-between">
                <Label
                  htmlFor="password"
                  className="text-xs font-semibold uppercase tracking-wider text-slate-700"
                >
                  Şifrə
                </Label>
                <Link
                  href="/contact"
                  className="text-xs font-semibold text-emerald-600 hover:text-emerald-700 hover:underline"
                >
                  Şifrəni unutdum?
                </Link>
              </div>
              <div className="group relative">
                <div className="pointer-events-none absolute inset-y-0 left-0 flex w-11 items-center justify-center text-slate-400 transition-colors group-focus-within:text-emerald-600">
                  <Lock className="h-4 w-4" aria-hidden="true" />
                </div>
                <Input
                  id="password"
                  name="password"
                  type={showPassword ? 'text' : 'password'}
                  placeholder="••••••••"
                  value={formData.password}
                  onChange={handleChange}
                  disabled={isSubmitting}
                  className="h-12 rounded-xl border-slate-200 bg-slate-50 pl-11 pr-11 text-sm text-slate-900 placeholder:text-slate-400 focus:bg-white focus:border-emerald-500 focus:ring-2 focus:ring-emerald-500/20"
                  required
                />
                <button
                  type="button"
                  onClick={() => setShowPassword((visible) => !visible)}
                  className="absolute inset-y-0 right-0 flex w-11 items-center justify-center text-slate-400 transition-colors hover:text-slate-700"
                  aria-label={
                    showPassword ? 'Şifrəni gizlət' : 'Şifrəni göstər'
                  }
                >
                  {showPassword ? (
                    <EyeOff className="h-4 w-4" aria-hidden="true" />
                  ) : (
                    <Eye className="h-4 w-4" aria-hidden="true" />
                  )}
                </button>
              </div>
              {errors.password && (
                <p className="text-xs text-red-600">{errors.password}</p>
              )}
            </div>

            {/* Remember me */}
            <label className="flex cursor-pointer select-none items-center gap-2.5 text-sm text-slate-700">
              <span className="relative inline-flex">
                <input
                  type="checkbox"
                  checked={remember}
                  onChange={(e) => setRemember(e.target.checked)}
                  className="peer h-4 w-4 cursor-pointer appearance-none rounded border border-slate-300 bg-white transition-all checked:border-emerald-600 checked:bg-emerald-600 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-emerald-500/30"
                />
                <Check
                  className="pointer-events-none absolute left-0 top-0 h-4 w-4 text-white opacity-0 transition-opacity peer-checked:opacity-100"
                  strokeWidth={3}
                  aria-hidden="true"
                />
              </span>
              <span className="text-xs font-medium">Məni xatırla</span>
            </label>

            {/* Submit */}
            <Button
              type="submit"
              id="login-submit-btn"
              disabled={isSubmitting}
              className="group h-12 w-full gap-2 rounded-xl bg-emerald-600 text-sm font-bold text-white shadow-lg shadow-emerald-600/20 hover:bg-emerald-700 hover:shadow-emerald-700/30"
            >
              {isSubmitting ? (
                <>
                  <Loader2 className="h-4 w-4 animate-spin" aria-hidden="true" />
                  Daxil olunur...
                </>
              ) : (
                <>
                  Daxil ol
                  <ArrowRight
                    className="h-4 w-4 transition-transform group-hover:translate-x-0.5"
                    aria-hidden="true"
                  />
                </>
              )}
            </Button>
          </form>

          {/* Divider */}
          <div className="my-7 flex items-center gap-3">
            <div className="h-px flex-1 bg-slate-200" />
            <span className="text-[10px] font-bold uppercase tracking-[0.18em] text-slate-400">
              və ya
            </span>
            <div className="h-px flex-1 bg-slate-200" />
          </div>

          {/* Social placeholders — visual only, not wired to OAuth yet */}
          <div className="grid grid-cols-2 gap-3">
            <button
              type="button"
              disabled
              className="flex h-11 items-center justify-center gap-2 rounded-xl border border-slate-200 bg-white text-xs font-semibold text-slate-700 transition-colors hover:bg-slate-50 disabled:cursor-not-allowed disabled:opacity-60"
              aria-label="Google ilə daxil ol"
            >
              <svg
                className="h-4 w-4"
                viewBox="0 0 24 24"
                aria-hidden="true"
              >
                <path
                  fill="#EA4335"
                  d="M12 10.2v3.9h5.5c-.2 1.4-1.7 4.2-5.5 4.2-3.3 0-6-2.7-6-6.1s2.7-6.1 6-6.1c1.9 0 3.2.8 3.9 1.5l2.6-2.5C16.9 3.6 14.6 2.7 12 2.7 6.9 2.7 2.8 6.8 2.8 12s4.1 9.3 9.2 9.3c5.3 0 8.8-3.7 8.8-9 0-.6-.1-1-.1-1.5H12z"
                />
              </svg>
              Google
            </button>
            <button
              type="button"
              disabled
              className="flex h-11 items-center justify-center gap-2 rounded-xl border border-slate-200 bg-white text-xs font-semibold text-slate-700 transition-colors hover:bg-slate-50 disabled:cursor-not-allowed disabled:opacity-60"
              aria-label="Apple ilə daxil ol"
            >
              <svg
                className="h-4 w-4"
                viewBox="0 0 24 24"
                fill="currentColor"
                aria-hidden="true"
              >
                <path d="M16.365 1.43c.07 1.32-.45 2.6-1.27 3.5-.81.91-2.16 1.62-3.27 1.55-.08-1.28.5-2.6 1.3-3.49.83-.94 2.27-1.62 3.24-1.56zM20.5 17.39c-.49 1.13-.72 1.63-1.35 2.63-.88 1.4-2.13 3.13-3.67 3.15-1.38.02-1.73-.9-3.6-.9-1.87 0-2.27.92-3.64.92-1.54-.02-2.72-1.59-3.6-2.99-2.46-3.92-2.72-8.52-1.2-10.97 1.08-1.74 2.78-2.76 4.39-2.76 1.63 0 2.66.9 4.01.9 1.31 0 2.1-.9 3.98-.9 1.42 0 2.93.78 4.01 2.12-3.52 1.93-2.95 6.96.67 8.8z" />
              </svg>
              Apple
            </button>
          </div>

          {/* Footer link */}
          <p className="mt-8 text-center text-xs text-slate-500">
            Hesabın yoxdur?{' '}
            <Link
              href="/register"
              className="font-bold text-emerald-600 hover:text-emerald-700 hover:underline"
            >
              Pulsuz qeydiyyatdan keç
            </Link>
          </p>
        </div>
      </div>

      {/* Bottom bar — copyright */}
      <div className="border-t border-slate-100 bg-slate-50/50 px-6 py-4 text-center text-[11px] text-slate-400 sm:px-10">
        © {new Date().getFullYear()} Intern.az · Tələbələr üçün təcrübə portalı
      </div>
    </div>
  );
}

/* ---------------------------------------------------------------------------
 * Page wrapper.
 * ------------------------------------------------------------------------ */
export default function LoginPage() {
  return (
    <div className="flex min-h-screen w-full flex-col bg-white lg:flex-row">
      <Suspense
        fallback={
          <div className="flex min-h-[60vh] w-full items-center justify-center text-sm text-slate-500">
            <Loader2
              className="mr-2 h-5 w-5 animate-spin text-emerald-600"
              aria-hidden="true"
            />
            Giriş səhifəsi yüklənir...
          </div>
        }
      >
        <BrandPanel />
        <div className="flex w-full flex-col lg:max-w-xl lg:flex-[0_0_50%] xl:max-w-2xl">
          <MobileBrand />
          <LoginForm />
        </div>
      </Suspense>
    </div>
  );
}
