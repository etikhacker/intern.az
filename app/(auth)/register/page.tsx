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
import { GraduationCap, ArrowRight, Loader2, CheckCircle2, ShieldAlert } from 'lucide-react';

export default function RegisterPage() {
  const router = useRouter();
  const { signUp, isConfigured } = useAuth();

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

    // Validate with Zod
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
        setServerError(res.error || 'Failed to create account. Please try again.');
        setIsSubmitting(false);
        return;
      }

      setSuccess(true);
      setTimeout(() => {
        router.push('/dashboard');
      }, 1200);
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : 'An unexpected error occurred';
      setServerError(msg);
      setIsSubmitting(false);
    }
  };

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
            Create Student Account
          </h1>
          <p className="text-xs text-slate-500 mt-1">
            Join the Azerbaijan internship platform to access assignments & verified certificates
          </p>
        </div>

        {/* Security Notice on Role assignment */}
        <div className="bg-emerald-50/60 border border-emerald-200/80 rounded-xl p-3 text-xs text-emerald-900 flex items-start gap-2.5">
          <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0 mt-0.5" />
          <div>
            <span className="font-semibold">Automatic Student Role Assignment:</span> All public registrations are assigned the <code className="bg-white/80 px-1 py-0.5 rounded font-mono text-[11px] text-emerald-950 font-bold">student</code> role by policy. Admin roles cannot be requested via public signup.
          </div>
        </div>

        <Card className="border-slate-200 shadow-md">
          <CardHeader className="pb-4">
            <CardTitle className="text-lg">Registration Form</CardTitle>
            <CardDescription className="text-xs">
              Enter your details to register as a student.
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
                  Registration successful! Redirecting to your student dashboard...
                </AlertDescription>
              </Alert>
            )}

            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <Label htmlFor="fullName">Full Name</Label>
                <Input
                  id="fullName"
                  name="fullName"
                  type="text"
                  placeholder="e.g. Leyla Mammadova"
                  value={formData.fullName}
                  onChange={handleChange}
                  disabled={isSubmitting || success}
                  required
                />
                {errors.fullName && (
                  <p className="text-xs text-red-600 mt-1">{errors.fullName}</p>
                )}
              </div>

              <div>
                <Label htmlFor="university">University</Label>
                <Input
                  id="university"
                  name="university"
                  type="text"
                  placeholder="e.g. ADA University, BSU, ASOIU, BEU"
                  value={formData.university}
                  onChange={handleChange}
                  disabled={isSubmitting || success}
                  required
                />
                {errors.university && (
                  <p className="text-xs text-red-600 mt-1">{errors.university}</p>
                )}
              </div>

              <div>
                <Label htmlFor="email">Email Address</Label>
                <Input
                  id="email"
                  name="email"
                  type="email"
                  placeholder="student@university.edu.az"
                  value={formData.email}
                  onChange={handleChange}
                  disabled={isSubmitting || success}
                  required
                />
                {errors.email && (
                  <p className="text-xs text-red-600 mt-1">{errors.email}</p>
                )}
              </div>

              <div>
                <Label htmlFor="password">Password</Label>
                <Input
                  id="password"
                  name="password"
                  type="password"
                  placeholder="At least 6 characters"
                  value={formData.password}
                  onChange={handleChange}
                  disabled={isSubmitting || success}
                  required
                />
                {errors.password && (
                  <p className="text-xs text-red-600 mt-1">{errors.password}</p>
                )}
              </div>

              <Button
                type="submit"
                id="register-submit-btn"
                className="w-full mt-2 gap-2"
                disabled={isSubmitting || success}
              >
                {isSubmitting ? (
                  <>
                    <Loader2 className="w-4 h-4 animate-spin" />
                    Creating Student Account...
                  </>
                ) : (
                  <>
                    Create Student Profile
                    <ArrowRight className="w-4 h-4" />
                  </>
                )}
              </Button>
            </form>
          </CardContent>

          <CardFooter className="flex flex-col gap-2 pt-0 text-center text-xs text-slate-500 border-t border-slate-100 mt-4 p-4">
            <div>
              Already have an account?{' '}
              <Link href="/login" className="text-emerald-600 font-semibold hover:underline">
                Sign in here
              </Link>
            </div>
            <div>
              Administrator?{' '}
              <Link href="/admin/login" className="text-slate-700 hover:text-slate-900 underline">
                Admin portal login
              </Link>
            </div>
          </CardFooter>
        </Card>
      </div>
    </div>
  );
}
