'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { useAuth } from '@/lib/auth/auth-context';
import { registerSchema, RegisterFormData } from '@/lib/validations/auth';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Card, CardHeader, CardTitle, CardDescription, CardContent, CardFooter } from '@/components/ui/card';
import { Alert, AlertDescription } from '@/components/ui/alert';
import { GraduationCap, ArrowRight, Loader2 } from 'lucide-react';

export default function RegisterPage() {
  const router = useRouter();
  const { signUp } = useAuth();

  const [formData, setFormData] = useState<RegisterFormData>({
    fullName: '',
    email: '',
    password: '',
    university: '',
  });

  const [errors, setErrors] = useState<Record<string, string>>({});
  const [serverError, setServerError] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [success, setSuccess] = useState(false);

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

    const result = registerSchema.safeParse(formData);
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
      const res = await signUp({
        fullName: result.data.fullName,
        email: result.data.email,
        password: result.data.password,
        university: result.data.university,
      });

      if (!res.success) {
        setServerError(res.error || 'Qeydiyyat zamanı xəta baş verdi. Zəhmət olmasa yenidən cəhd edin.');
        setIsSubmitting(false);
        return;
      }

      setSuccess(true);
      setTimeout(() => {
        router.push('/dashboard');
      }, 1000);
    } catch {
      setServerError('Xəta baş verdi. Zəhmət olmasa yenidən cəhd edin.');
      setIsSubmitting(false);
    }
  };

  return (
    <div className="flex-1 flex flex-col justify-center items-center py-12 px-4 sm:px-6 lg:px-8 bg-slate-50">
      <div className="w-full max-w-md space-y-6">
        {/* Brand Header */}
        <div className="text-center">
          <Link href="/" className="inline-flex items-center gap-2.5 mb-3">
            <div className="w-10 h-10 rounded-xl bg-emerald-600 flex items-center justify-center text-white shadow-xs">
              <GraduationCap className="w-5 h-5" />
            </div>
            <span className="text-2xl font-bold text-slate-900 tracking-tight">
              Intern<span className="text-emerald-600">.az</span>
            </span>
          </Link>
          <h1 className="text-2xl font-bold text-slate-900 tracking-tight">
            Tələbə Qeydiyyatı
          </h1>
          <p className="text-xs text-slate-500 mt-1">
            Praktiki təcrübə proqramlarına qatılmaq üçün profilinizi yaradın
          </p>
        </div>

        <Card className="border-slate-200 shadow-sm">
          <CardHeader className="pb-4">
            <CardTitle className="text-lg text-slate-900 font-bold">Qeydiyyat Formu</CardTitle>
            <CardDescription className="text-xs text-slate-500">
              Məlumatlarınızı daxil edərək tələbə kabinetinizi aktivləşdirin.
            </CardDescription>
          </CardHeader>

          <CardContent>
            {serverError && (
              <Alert variant="destructive" className="mb-4 text-xs">
                <AlertDescription>{serverError}</AlertDescription>
              </Alert>
            )}

            {success && (
              <Alert variant="success" className="mb-4 text-xs">
                <AlertDescription>
                  Qeydiyyat uğurla tamamlandı! Tələbə kabinetinə yönləndirilirsiniz...
                </AlertDescription>
              </Alert>
            )}

            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <Label htmlFor="fullName" className="text-xs font-semibold text-slate-700">
                  Ad və Soyad
                </Label>
                <Input
                  id="fullName"
                  name="fullName"
                  type="text"
                  placeholder="məs. Leyla Məmmədova"
                  value={formData.fullName}
                  onChange={handleChange}
                  disabled={isSubmitting || success}
                  className="mt-1"
                  required
                />
                {errors.fullName && (
                  <p className="text-xs text-red-600 mt-1">{errors.fullName}</p>
                )}
              </div>

              <div>
                <Label htmlFor="university" className="text-xs font-semibold text-slate-700">
                  Universitet
                </Label>
                <Input
                  id="university"
                  name="university"
                  type="text"
                  placeholder="məs. ADA Universiteti, BDU, ADNSU, BMU"
                  value={formData.university}
                  onChange={handleChange}
                  disabled={isSubmitting || success}
                  className="mt-1"
                  required
                />
                {errors.university && (
                  <p className="text-xs text-red-600 mt-1">{errors.university}</p>
                )}
              </div>

              <div>
                <Label htmlFor="email" className="text-xs font-semibold text-slate-700">
                  E-poçt ünvanı
                </Label>
                <Input
                  id="email"
                  name="email"
                  type="email"
                  placeholder="ad.soyad@universitet.edu.az"
                  value={formData.email}
                  onChange={handleChange}
                  disabled={isSubmitting || success}
                  className="mt-1"
                  required
                />
                {errors.email && (
                  <p className="text-xs text-red-600 mt-1">{errors.email}</p>
                )}
              </div>

              <div>
                <Label htmlFor="password" className="text-xs font-semibold text-slate-700">
                  Şifrə (minimum 6 simvol)
                </Label>
                <Input
                  id="password"
                  name="password"
                  type="password"
                  placeholder="••••••••"
                  value={formData.password}
                  onChange={handleChange}
                  disabled={isSubmitting || success}
                  className="mt-1"
                  required
                />
                {errors.password && (
                  <p className="text-xs text-red-600 mt-1">{errors.password}</p>
                )}
              </div>

              <Button
                type="submit"
                id="register-submit-btn"
                className="w-full mt-2 gap-2 shadow-xs"
                disabled={isSubmitting || success}
              >
                {isSubmitting ? (
                  <>
                    <Loader2 className="w-4 h-4 animate-spin" />
                    Hesab yaradılır...
                  </>
                ) : (
                  <>
                    Qeydiyyatdan keç
                    <ArrowRight className="w-4 h-4" />
                  </>
                )}
              </Button>
            </form>
          </CardContent>

          <CardFooter className="flex flex-col gap-2 pt-0 text-center text-xs text-slate-500 border-t border-slate-100 mt-4 p-4">
            <div>
              Artıq hesabınız var?{' '}
              <Link href="/login" className="text-emerald-600 font-semibold hover:underline">
                Daxil olun
              </Link>
            </div>
          </CardFooter>
        </Card>
      </div>
    </div>
  );
}
