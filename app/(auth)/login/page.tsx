'use client';

import React, { useState, Suspense } from 'react';
import Link from 'next/link';
import { useRouter, useSearchParams } from 'next/navigation';
import { useAuth } from '@/lib/auth/auth-context';
import { loginSchema, LoginFormData } from '@/lib/validations/auth';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Card, CardHeader, CardTitle, CardDescription, CardContent, CardFooter } from '@/components/ui/card';
import { Alert, AlertDescription } from '@/components/ui/alert';
import { GraduationCap, ArrowRight, Loader2, ShieldCheck, UserCheck } from 'lucide-react';

function LoginForm() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const redirectPath = searchParams.get('redirect') || '/dashboard';
  const { signIn, isConfigured } = useAuth();

  const [formData, setFormData] = useState<LoginFormData>({
    email: '',
    password: '',
  });

  const [errors, setErrors] = useState<Record<string, string>>({});
  const [serverError, setServerError] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);

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
        setServerError(res.error || 'Invalid login credentials');
        setIsSubmitting(false);
        return;
      }

      if (res.role === 'admin') {
        router.push('/admin');
      } else {
        router.push(redirectPath.startsWith('/dashboard') ? redirectPath : '/dashboard');
      }
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : 'An unexpected error occurred during login';
      setServerError(msg);
      setIsSubmitting(false);
    }
  };

  const fillDemoStudent = () => {
    setFormData({
      email: 'leyla.m@ada.edu.az',
      password: 'password123',
    });
    setServerError(null);
  };

  return (
    <Card className="border-slate-200 shadow-md">
      <CardHeader className="pb-4">
        <CardTitle className="text-lg">Sign In</CardTitle>
        <CardDescription className="text-xs">
          Enter your email and password to access your student dashboard.
        </CardDescription>
      </CardHeader>

      <CardContent>
        {serverError && (
          <Alert variant="destructive" className="mb-4 text-xs">
            <AlertDescription>{serverError}</AlertDescription>
          </Alert>
        )}

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <Label htmlFor="email">Email Address</Label>
            <Input
              id="email"
              name="email"
              type="email"
              placeholder="student@ada.edu.az"
              value={formData.email}
              onChange={handleChange}
              disabled={isSubmitting}
              required
            />
            {errors.email && (
              <p className="text-xs text-red-600 mt-1">{errors.email}</p>
            )}
          </div>

          <div>
            <div className="flex items-center justify-between mb-1">
              <Label htmlFor="password">Password</Label>
            </div>
            <Input
              id="password"
              name="password"
              type="password"
              placeholder="••••••••"
              value={formData.password}
              onChange={handleChange}
              disabled={isSubmitting}
              required
            />
            {errors.password && (
              <p className="text-xs text-red-600 mt-1">{errors.password}</p>
            )}
          </div>

          <Button
            type="submit"
            id="login-submit-btn"
            className="w-full mt-2 gap-2"
            disabled={isSubmitting}
          >
            {isSubmitting ? (
              <>
                <Loader2 className="w-4 h-4 animate-spin" />
                Signing in...
              </>
            ) : (
              <>
                Sign In to Dashboard
                <ArrowRight className="w-4 h-4" />
              </>
            )}
          </Button>
        </form>

        {!isConfigured && (
          <div className="mt-4 pt-3 border-t border-slate-100 text-center">
            <button
              type="button"
              onClick={fillDemoStudent}
              className="text-[11px] text-emerald-700 bg-emerald-50 hover:bg-emerald-100 border border-emerald-200 px-2.5 py-1 rounded-md font-medium inline-flex items-center gap-1.5 transition-colors"
            >
              <UserCheck className="w-3.5 h-3.5" />
              Quick Fill Demo Student (Leyla Mammadova)
            </button>
          </div>
        )}
      </CardContent>

      <CardFooter className="flex flex-col gap-2 pt-0 text-center text-xs text-slate-500 border-t border-slate-100 mt-4 p-4">
        <div>
          Don&apos;t have an account yet?{' '}
          <Link href="/register" className="text-emerald-600 font-semibold hover:underline">
            Register as a Student
          </Link>
        </div>
        <div className="pt-1 flex items-center justify-center gap-1">
          <ShieldCheck className="w-3.5 h-3.5 text-amber-600" />
          <span>Platform Administrator?</span>{' '}
          <Link href="/admin/login" className="text-amber-800 font-semibold hover:underline">
            Admin Sign In
          </Link>
        </div>
      </CardFooter>
    </Card>
  );
}

export default function LoginPage() {
  return (
    <div className="flex-1 flex flex-col justify-center items-center py-12 px-4 sm:px-6 lg:px-8 bg-slate-50">
      <div className="w-full max-w-md space-y-6">
        {/* Brand Header */}
        <div className="text-center">
          <Link href="/" className="inline-flex items-center gap-2.5 mb-3">
            <div className="w-10 h-10 rounded-xl bg-emerald-600 flex items-center justify-center text-white shadow-sm">
              <GraduationCap className="w-5 h-5" />
            </div>
            <span className="text-2xl font-bold text-slate-900 tracking-tight">
              Intern<span className="text-emerald-600">.az</span>
            </span>
          </Link>
          <h1 className="text-2xl font-bold text-slate-900 tracking-tight">
            Student Portal Sign In
          </h1>
          <p className="text-xs text-slate-500 mt-1">
            Access your internship applications, assigned tasks, and verified profile
          </p>
        </div>

        <Suspense
          fallback={
            <Card className="border-slate-200 shadow-md p-12 text-center text-xs text-slate-500">
              <Loader2 className="w-6 h-6 animate-spin mx-auto text-emerald-600 mb-2" />
              Loading login portal...
            </Card>
          }
        >
          <LoginForm />
        </Suspense>
      </div>
    </div>
  );
}
