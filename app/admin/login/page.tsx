'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { useAuth } from '@/lib/auth/auth-context';
import { loginSchema, LoginFormData } from '@/lib/validations/auth';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Alert, AlertDescription } from '@/components/ui/alert';
import {
  ArrowLeft,
  ArrowRight,
  Check,
  Eye,
  EyeOff,
  Loader2,
  Lock,
  Mail,
  ShieldAlert,
  ShieldCheck,
  Sparkles,
} from 'lucide-react';
import { SOLE_ADMIN_EMAIL } from '@/lib/auth/admin';

function BrandPanel() {
  return (
    <div className="relative hidden h-full overflow-hidden bg-gradient-to-br from-amber-500 via-amber-600 to-orange-700 text-white lg:flex lg:flex-col lg:justify-between lg:p-12 xl:p-16">
      <div
        aria-hidden="true"
        className="pointer-events-none absolute -top-24 -left-24 h-96 w-96 rounded-full bg-amber-300/40 blur-3xl"
      />
      <div
        aria-hidden="true"
        className="pointer-events-none absolute -bottom-32 -right-20 h-[28rem] w-[28rem] rounded-full bg-orange-300/30 blur-3xl"
      />

      <Link href="/" className="relative z-10 inline-flex items-center gap-3">
        <div className="flex h-11 w-11 items-center justify-center rounded-2xl bg-white text-amber-700 shadow-lg shadow-amber-900/20">
          <ShieldAlert className="h-6 w-6" aria-hidden="true" />
        </div>
        <div>
          <p className="text-lg font-bold tracking-tight">Intern.az Admin</p>
          <p className="text-[10px] uppercase tracking-[0.18em] text-amber-50/80">
            Administrator Portal
          </p>
        </div>
      </Link>

      <div className="relative z-10 max-w-md space-y-6">
        <div className="inline-flex items-center gap-2 rounded-full border border-white/20 bg-white/10 px-3.5 py-1.5 text-[11px] font-bold uppercase tracking-[0.18em] backdrop-blur-md">
          <Sparkles className="h-3.5 w-3.5" aria-hidden="true" />
          Məhdud giriş
        </div>
        <h2 className="text-4xl font-black leading-[1.05] tracking-tight xl:text-5xl">
          Yalnız{' '}
          <span className="bg-gradient-to-r from-white via-amber-100 to-orange-100 bg-clip-text text-transparent">
            səlahiyyətli
          </span>{' '}
          administratorlar.
        </h2>
        <p className="text-base leading-relaxed text-amber-50/90">
          Platform nəzarətçiləri, tapşırıq koordinatorları və sertifikat
          verifikatorları üçün məhdud giriş sahəsi.
        </p>
        <ul className="space-y-2.5 pt-2 text-sm text-amber-50/90">
          <li className="flex items-center gap-2.5">
            <span className="flex h-5 w-5 items-center justify-center rounded-full bg-white/15">
              <Check className="h-3 w-3" aria-hidden="true" />
            </span>
            Bütün admin əməliyyatlar jurnallanır
          </li>
          <li className="flex items-center gap-2.5">
            <span className="flex h-5 w-5 items-center justify-center rounded-full bg-white/15">
              <Check className="h-3 w-3" aria-hidden="true" />
            </span>
            2-ci faktorlu identifikasiya tələb olunur
          </li>
          <li className="flex items-center gap-2.5">
            <span className="flex h-5 w-5 items-center justify-center rounded-full bg-white/15">
              <Check className="h-3 w-3" aria-hidden="true" />
            </span>
            Uğursuz cəhdlər avtomatik bloklanır
          </li>
        </ul>
      </div>

      <div
        aria-hidden="true"
        className="absolute right-8 top-1/2 hidden -translate-y-1/2 rotate-3 rounded-2xl border border-white/20 bg-white/95 p-4 text-slate-900 shadow-2xl shadow-amber-900/30 backdrop-blur-md xl:block"
      >
        <div className="flex items-center gap-2">
          <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-amber-100 text-amber-700">
            <ShieldCheck className="h-4 w-4" aria-hidden="true" />
          </div>
          <div>
            <p className="text-[10px] font-bold text-slate-500">SON GİRİŞ</p>
            <p className="text-xs font-bold leading-tight">2 saat əvvəl</p>
            <p className="text-[9px] text-slate-400">Bakı, AZ · IP maskelanmış</p>
          </div>
        </div>
      </div>

      <p className="relative z-10 text-[10px] uppercase tracking-[0.18em] text-amber-50/70">
        © {new Date().getFullYear()} Intern.az — Administrator Console
      </p>
    </div>
  );
}

function MobileBrand() {
  return (
    <div className="relative overflow-hidden bg-gradient-to-br from-amber-500 via-amber-600 to-orange-700 px-6 py-7 text-white lg:hidden">
      <div
        aria-hidden="true"
        className="pointer-events-none absolute -top-12 -right-12 h-40 w-40 rounded-full bg-amber-300/40 blur-3xl"
      />
      <Link href="/" className="relative z-10 inline-flex items-center gap-2.5">
        <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-white text-amber-700 shadow-lg shadow-amber-900/20">
          <ShieldAlert className="h-5 w-5" aria-hidden="true" />
        </div>
        <div>
          <p className="text-lg font-bold tracking-tight">Intern.az Admin</p>
          <p className="text-[9px] uppercase tracking-[0.18em] text-amber-50/80">
            Administrator Portal
          </p>
        </div>
      </Link>
      <h2 className="relative z-10 mt-5 text-2xl font-black leading-tight">
        Yalnız səlahiyyətli administratorlar.
      </h2>
    </div>
  );
}

export default function AdminLoginPage() {
  const router = useRouter();
  const { signIn } = useAuth();

  const [formData, setFormData] = useState<LoginFormData>({
    email: '',
    password: '',
  });

  const [errors, setErrors] = useState<Record<string, string>>({});
  const [serverError, setServerError] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [showPassword, setShowPassword] = useState(false);

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

    setIsSubmitting(true);

    try {
      const res = await signIn({
        email: result.data.email,
        password: result.data.password,
      });

      if (!res.success) {
        setServerError(res.error || 'Invalid administrator credentials.');
        setIsSubmitting(false);
        return;
      }

      if (res.role !== 'admin') {
        setServerError(
          'Giriş rədd edildi. Yalnız səlahiyyətli administrator hesabı bu səhifəyə daxil ola bilər.'
        );
        setIsSubmitting(false);
        setTimeout(() => {
          router.push('/dashboard');
        }, 1500);
        return;
      }

      router.push('/admin');
    } catch (err: unknown) {
      const msg =
        err instanceof Error
          ? err.message
          : 'An unexpected error occurred during admin authentication';
      setServerError(msg);
      setIsSubmitting(false);
    }
  };

  return (
    <div className="flex min-h-screen w-full flex-col bg-white lg:flex-row">
      <BrandPanel />
      <div className="flex w-full flex-col lg:max-w-xl lg:flex-[0_0_50%] xl:max-w-2xl">
        <MobileBrand />

        <div className="relative flex w-full flex-col bg-white">
          {/* Top bar */}
          <div className="flex items-center justify-between border-b border-slate-100 px-6 py-4 sm:px-10">
            <Link
              href="/"
              className="group inline-flex items-center gap-2 text-sm font-semibold text-slate-600 transition-colors hover:text-amber-600"
            >
              <span className="flex h-8 w-8 items-center justify-center rounded-lg border border-slate-200 bg-white text-slate-500 transition-all group-hover:-translate-x-0.5 group-hover:border-amber-300 group-hover:text-amber-600">
                <ArrowLeft className="h-4 w-4" aria-hidden="true" />
              </span>
              <span>Ana səhifə</span>
            </Link>
            <Link
              href="/login"
              className="inline-flex items-center gap-1.5 text-xs font-medium text-slate-500 transition-colors hover:text-slate-900"
            >
              <ArrowRight className="h-3.5 w-3.5" aria-hidden="true" />
              Tələbə girişi
            </Link>
          </div>

          {/* Form */}
          <div className="flex-1 px-6 py-8 sm:px-10 sm:py-10 lg:px-14 xl:px-20">
            <div className="mx-auto w-full max-w-md">
              <div className="space-y-2">
                <span className="inline-flex items-center gap-1.5 rounded-full bg-amber-50 px-2.5 py-1 text-[10px] font-bold uppercase tracking-[0.16em] text-amber-700">
                  <span className="h-1.5 w-1.5 rounded-full bg-amber-500" />
                  Administrator girişi
                </span>
                <h1 className="text-3xl font-black tracking-tight text-slate-900 sm:text-4xl">
                  Admin konsol.
                </h1>
                <p className="text-sm leading-relaxed text-slate-500">
                  Yalnız səlahiyyətli administrator hesabı ilə daxil ola
                  bilərsiniz. Bütün giriş cəhdləri qeydə alınır.
                </p>
              </div>

              {serverError && (
                <Alert
                  variant="destructive"
                  className="mt-6 text-xs"
                >
                  <AlertDescription>{serverError}</AlertDescription>
                </Alert>
              )}

              <form
                onSubmit={handleSubmit}
                className="mt-8 space-y-5"
                noValidate
              >
                <div className="space-y-1.5">
                  <Label
                    htmlFor="email"
                    className="text-xs font-semibold uppercase tracking-wider text-slate-700"
                  >
                    Administrator e-poçtu
                  </Label>
                  <div className="group relative">
                    <div className="pointer-events-none absolute inset-y-0 left-0 flex w-11 items-center justify-center text-slate-400 transition-colors group-focus-within:text-amber-600">
                      <Mail className="h-4 w-4" aria-hidden="true" />
                    </div>
                    <Input
                      id="email"
                      name="email"
                      type="email"
                      placeholder={SOLE_ADMIN_EMAIL}
                      value={formData.email}
                      onChange={handleChange}
                      disabled={isSubmitting}
                      className="h-12 rounded-xl border-slate-200 bg-slate-50 pl-11 pr-3 text-sm text-slate-900 placeholder:text-slate-400 focus:bg-white focus:border-amber-500 focus:ring-2 focus:ring-amber-500/20"
                      required
                    />
                  </div>
                  {errors.email && (
                    <p className="text-xs text-red-600">{errors.email}</p>
                  )}
                </div>

                <div className="space-y-1.5">
                  <Label
                    htmlFor="password"
                    className="text-xs font-semibold uppercase tracking-wider text-slate-700"
                  >
                    Administrator şifrəsi
                  </Label>
                  <div className="group relative">
                    <div className="pointer-events-none absolute inset-y-0 left-0 flex w-11 items-center justify-center text-slate-400 transition-colors group-focus-within:text-amber-600">
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
                      className="h-12 rounded-xl border-slate-200 bg-slate-50 pl-11 pr-11 text-sm text-slate-900 placeholder:text-slate-400 focus:bg-white focus:border-amber-500 focus:ring-2 focus:ring-amber-500/20"
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

                <Button
                  type="submit"
                  id="admin-login-submit-btn"
                  disabled={isSubmitting}
                  className="group h-12 w-full gap-2 rounded-xl bg-amber-500 text-sm font-bold text-slate-950 shadow-lg shadow-amber-500/25 hover:bg-amber-600 hover:shadow-amber-600/30"
                >
                  {isSubmitting ? (
                    <>
                      <Loader2
                        className="h-4 w-4 animate-spin"
                        aria-hidden="true"
                      />
                      Yoxlanılır...
                    </>
                  ) : (
                    <>
                      Admin konsola daxil ol
                      <ArrowRight
                        className="h-4 w-4 transition-transform group-hover:translate-x-0.5"
                        aria-hidden="true"
                      />
                    </>
                  )}
                </Button>
              </form>

              <div className="mt-8 flex items-start gap-2 rounded-xl border border-amber-200 bg-amber-50 p-3 text-[11px] text-amber-800">
                <ShieldCheck
                  className="mt-0.5 h-4 w-4 flex-shrink-0 text-amber-700"
                  aria-hidden="true"
                />
                <p className="leading-relaxed">
                  Bu sahifəyə giriş cəhdləri qeydə alınır. Səlahiyyətiniz
                  yoxdursa, hesabınız müvəqqəti olaraq bloklana bilər.
                </p>
              </div>

              <p className="mt-6 text-center text-xs text-slate-500">
                Tələbə hesabı ilə daxil olursan?{' '}
                <Link
                  href="/login"
                  className="font-bold text-emerald-600 hover:text-emerald-700 hover:underline"
                >
                  Tələbə girişi
                </Link>
              </p>
            </div>
          </div>

          <div className="border-t border-slate-100 bg-slate-50/50 px-6 py-4 text-center text-[11px] text-slate-400 sm:px-10">
            © {new Date().getFullYear()} Intern.az · Administrator Console
          </div>
        </div>
      </div>
    </div>
  );
}
