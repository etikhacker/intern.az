'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { useAuth } from '@/lib/auth/auth-context';
import { loginSchema, LoginFormData } from '@/lib/validations/auth';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Card, CardHeader, CardTitle, CardDescription, CardContent, CardFooter } from '@/components/ui/card';
import { Alert, AlertDescription } from '@/components/ui/alert';
import { ShieldAlert, ArrowRight, Loader2, KeyRound, ArrowLeft, Eye, EyeOff } from 'lucide-react';
import { SOLE_ADMIN_EMAIL } from '@/lib/auth/admin';

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
      const msg = err instanceof Error ? err.message : 'An unexpected error occurred during admin authentication';
      setServerError(msg);
      setIsSubmitting(false);
    }
  };

  return (
    <div className="flex-1 flex flex-col justify-center items-center py-12 px-4 sm:px-6 lg:px-8 bg-slate-900 text-slate-100">
      <div className="w-full max-w-md space-y-6">
        {/* Brand Header */}
        <div className="text-center">
          <Link href="/" className="inline-flex items-center gap-2.5 mb-3">
            <div className="w-10 h-10 rounded-xl bg-amber-500 flex items-center justify-center text-slate-950 font-bold shadow-sm">
              <ShieldAlert className="w-5 h-5 text-slate-950" />
            </div>
            <span className="text-2xl font-bold text-white tracking-tight">
              Intern<span className="text-amber-400">.az</span>
            </span>
          </Link>
          <h1 className="text-2xl font-bold text-white tracking-tight">
            Administrator Portal
          </h1>
          <p className="text-xs text-slate-400 mt-1">
            Restricted access for platform supervisors, task coordinators, and credential verifiers
          </p>
        </div>

        <Card className="border-slate-800 bg-slate-950/80 text-white shadow-xl">
          <CardHeader className="pb-4 border-b border-slate-800">
            <div className="flex items-center gap-2">
              <KeyRound className="w-4 h-4 text-amber-400" />
              <CardTitle className="text-base text-white">Administrator Authentication</CardTitle>
            </div>
            <CardDescription className="text-xs text-slate-400">
              Only verified administrative accounts configured in the Supabase database can sign in.
            </CardDescription>
          </CardHeader>

          <CardContent className="pt-6">
            {serverError && (
              <Alert variant="destructive" className="mb-4 text-xs bg-red-950/50 border-red-800 text-red-200">
                <AlertDescription>{serverError}</AlertDescription>
              </Alert>
            )}

            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <Label htmlFor="email" className="text-slate-300">Admin Email</Label>
                <Input
                  id="email"
                  name="email"
                  type="email"
                  placeholder={SOLE_ADMIN_EMAIL}
                  value={formData.email}
                  onChange={handleChange}
                  disabled={isSubmitting}
                  className="bg-slate-900 border-slate-700 text-white placeholder:text-slate-500 focus:ring-amber-500"
                  required
                />
                {errors.email && (
                  <p className="text-xs text-red-400 mt-1">{errors.email}</p>
                )}
              </div>

              <div>
                <Label htmlFor="password" className="text-slate-300">Admin Password</Label>
                <div className="relative">
                  <Input
                    id="password"
                    name="password"
                    type={showPassword ? 'text' : 'password'}
                    placeholder="••••••••"
                    value={formData.password}
                    onChange={handleChange}
                    disabled={isSubmitting}
                    className="pr-10 bg-slate-900 border-slate-700 text-white placeholder:text-slate-500 focus:ring-amber-500"
                    required
                  />
                  <button
                    type="button"
                    onClick={() => setShowPassword((visible) => !visible)}
                    className="absolute inset-y-0 right-0 flex w-10 items-center justify-center text-slate-400 hover:text-slate-200"
                    aria-label={showPassword ? 'Şifrəni gizlət' : 'Şifrəni göstər'}
                  >
                    {showPassword ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
                  </button>
                </div>
                {errors.password && (
                  <p className="text-xs text-red-400 mt-1">{errors.password}</p>
                )}
              </div>

              <Button
                type="submit"
                id="admin-login-submit-btn"
                className="w-full mt-2 gap-2 bg-amber-500 hover:bg-amber-600 text-slate-950 font-bold"
                disabled={isSubmitting}
              >
                {isSubmitting ? (
                  <>
                    <Loader2 className="w-4 h-4 animate-spin text-slate-950" />
                    Verifying Credentials...
                  </>
                ) : (
                  <>
                    Access Admin Console
                    <ArrowRight className="w-4 h-4" />
                  </>
                )}
              </Button>
            </form>

          </CardContent>

          <CardFooter className="flex flex-col gap-2 pt-0 text-center text-xs text-slate-400 border-t border-slate-800 mt-4 p-4">
            <Link
              href="/login"
              className="inline-flex items-center gap-1.5 text-slate-400 hover:text-white transition-colors"
            >
              <ArrowLeft className="w-3.5 h-3.5" />
              Return to Student Sign In
            </Link>
          </CardFooter>
        </Card>
      </div>
    </div>
  );
}
