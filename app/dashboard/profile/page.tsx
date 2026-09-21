'use client';

import React, { useState } from 'react';
import { useAuth } from '@/lib/auth/auth-context';
import { profileUpdateSchema, ProfileUpdateFormData } from '@/lib/validations/profile';
import { Card, CardHeader, CardTitle, CardDescription, CardContent, CardFooter } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Alert, AlertDescription } from '@/components/ui/alert';
import { Avatar } from '@/components/ui/avatar';
import { Badge } from '@/components/ui/badge';
import { Profile } from '@/types/database';
import {
  User,
  Phone,
  GraduationCap,
  Image as ImageIcon,
  Lock,
  CheckCircle2,
  Loader2,
  ShieldCheck,
  Calendar,
  Key,
} from 'lucide-react';

interface ProfileFormProps {
  profile: Profile | null;
  user: { id: string; email: string } | null;
  updateProfile: (input: {
    full_name?: string;
    phone?: string | null;
    university?: string | null;
    avatar_url?: string | null;
  }) => Promise<{ success: boolean; error?: string; profile?: Profile }>;
}

function ProfileForm({ profile, user, updateProfile }: ProfileFormProps) {
  const [formData, setFormData] = useState<ProfileUpdateFormData>({
    fullName: profile?.full_name || '',
    phone: profile?.phone || '',
    university: profile?.university || '',
    avatarUrl: profile?.avatar_url || '',
  });

  const [errors, setErrors] = useState<Record<string, string>>({});
  const [serverError, setServerError] = useState<string | null>(null);
  const [successMessage, setSuccessMessage] = useState<string | null>(null);
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
    setSuccessMessage(null);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setServerError(null);
    setSuccessMessage(null);
    setErrors({});

    const result = profileUpdateSchema.safeParse(formData);
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
      const res = await updateProfile({
        full_name: result.data.fullName,
        phone: result.data.phone || null,
        university: result.data.university || null,
        avatar_url: result.data.avatarUrl || null,
      });

      if (!res.success) {
        setServerError(res.error || 'Failed to update profile.');
      } else {
        setSuccessMessage('Your profile details have been saved successfully.');
      }
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : 'An error occurred during update';
      setServerError(msg);
    } finally {
      setIsSubmitting(false);
    }
  };

  const formattedDate = profile?.created_at
    ? new Date(profile.created_at).toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
      })
    : 'N/A';

  return (
    <div className="space-y-6">
      {successMessage && (
        <Alert variant="success" className="text-xs">
          <CheckCircle2 className="w-4 h-4" />
          <AlertDescription>{successMessage}</AlertDescription>
        </Alert>
      )}

      {serverError && (
        <Alert variant="destructive" className="text-xs">
          <AlertDescription>{serverError}</AlertDescription>
        </Alert>
      )}

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {/* Left Column: Avatar Preview & Account Info */}
        <Card className="border-slate-200 shadow-sm h-fit">
          <CardHeader className="text-center pb-2">
            <div className="flex justify-center mb-3">
              <Avatar
                src={formData.avatarUrl || profile?.avatar_url}
                fallback={formData.fullName || profile?.full_name || 'ST'}
                size="xl"
                className="ring-4 ring-emerald-50 border-2 border-emerald-200"
              />
            </div>
            <CardTitle className="text-base text-slate-900 truncate">
              {formData.fullName || profile?.full_name || 'Student Name'}
            </CardTitle>
            <CardDescription className="text-xs truncate">
              {profile?.email || user?.email}
            </CardDescription>
            <div className="pt-2 flex justify-center">
              <Badge variant="default" className="text-xs capitalize">
                {profile?.role || 'student'}
              </Badge>
            </div>
          </CardHeader>

          <CardContent className="pt-4 border-t border-slate-100 space-y-3 text-xs">
            <div className="flex items-center justify-between text-slate-600">
              <span className="text-slate-400">Security:</span>
              <span className="font-semibold text-emerald-700">Row Level Security</span>
            </div>
            <div className="flex items-center justify-between text-slate-600">
              <span className="text-slate-400">Database:</span>
              <span className="font-semibold text-slate-800">PostgreSQL</span>
            </div>
            <div className="flex items-center justify-between text-slate-600">
              <span className="text-slate-400">Tier:</span>
              <span className="font-semibold text-slate-800">100% Free Plan</span>
            </div>
          </CardContent>
        </Card>

        {/* Right 2 Columns: Editable & Protected Fields */}
        <div className="md:col-span-2 space-y-6">
          {/* Editable Fields Form */}
          <Card className="border-slate-200 shadow-sm">
            <CardHeader className="pb-4 border-b border-slate-100">
              <CardTitle className="text-lg text-slate-900 flex items-center gap-2">
                <User className="w-4 h-4 text-emerald-600" />
                Editable Information
              </CardTitle>
              <CardDescription className="text-xs">
                You can update your name, phone number, university, and avatar image.
              </CardDescription>
            </CardHeader>

            <form onSubmit={handleSubmit}>
              <CardContent className="pt-6 space-y-4">
                {/* Full Name */}
                <div>
                  <Label htmlFor="fullName">Full Name</Label>
                  <div className="relative">
                    <Input
                      id="fullName"
                      name="fullName"
                      type="text"
                      placeholder="e.g. Leyla Mammadova"
                      value={formData.fullName}
                      onChange={handleChange}
                      disabled={isSubmitting}
                      required
                    />
                  </div>
                  {errors.fullName && (
                    <p className="text-xs text-red-600 mt-1">{errors.fullName}</p>
                  )}
                </div>

                {/* University */}
                <div>
                  <Label htmlFor="university">University Institution</Label>
                  <div className="relative">
                    <Input
                      id="university"
                      name="university"
                      type="text"
                      placeholder="e.g. ADA University, Baku State University (BSU), ASOIU"
                      value={formData.university || ''}
                      onChange={handleChange}
                      disabled={isSubmitting}
                    />
                  </div>
                  {errors.university && (
                    <p className="text-xs text-red-600 mt-1">{errors.university}</p>
                  )}
                </div>

                {/* Phone */}
                <div>
                  <Label htmlFor="phone">Phone Number (Optional)</Label>
                  <div className="relative">
                    <Input
                      id="phone"
                      name="phone"
                      type="tel"
                      placeholder="+994 50 123 45 67"
                      value={formData.phone || ''}
                      onChange={handleChange}
                      disabled={isSubmitting}
                    />
                  </div>
                  {errors.phone && (
                    <p className="text-xs text-red-600 mt-1">{errors.phone}</p>
                  )}
                </div>

                {/* Avatar URL */}
                <div>
                  <Label htmlFor="avatarUrl">Avatar Image URL (Optional)</Label>
                  <div className="relative">
                    <Input
                      id="avatarUrl"
                      name="avatarUrl"
                      type="url"
                      placeholder="https://picsum.photos/seed/student/200/200"
                      value={formData.avatarUrl || ''}
                      onChange={handleChange}
                      disabled={isSubmitting}
                    />
                  </div>
                  <p className="text-[11px] text-slate-400 mt-1">
                    Provide a public image URL or use a placeholder like https://picsum.photos/seed/student/200/200
                  </p>
                  {errors.avatarUrl && (
                    <p className="text-xs text-red-600 mt-1">{errors.avatarUrl}</p>
                  )}
                </div>
              </CardContent>

              <CardFooter className="bg-slate-50/60 border-t border-slate-100 flex items-center justify-between py-4">
                <span className="text-xs text-slate-500">
                  Validated with Zod schema
                </span>
                <Button
                  type="submit"
                  id="save-profile-btn"
                  disabled={isSubmitting}
                  className="gap-2"
                >
                  {isSubmitting ? (
                    <>
                      <Loader2 className="w-4 h-4 animate-spin" />
                      Saving changes...
                    </>
                  ) : (
                    <>
                      <CheckCircle2 className="w-4 h-4" />
                      Save Profile Changes
                    </>
                  )}
                </Button>
              </CardFooter>
            </form>
          </Card>

          {/* Protected / Read-Only Fields Card */}
          <Card className="border-slate-200/80 bg-slate-50/50 shadow-xs">
            <CardHeader className="pb-3 border-b border-slate-200/60">
              <div className="flex items-center gap-2">
                <ShieldCheck className="w-4 h-4 text-slate-600" />
                <CardTitle className="text-sm text-slate-800">
                  Security-Protected Fields (Read-Only)
                </CardTitle>
              </div>
              <CardDescription className="text-xs text-slate-500">
                To prevent privilege escalation and unauthorized modifications, these values are guarded on both database and server tiers.
              </CardDescription>
            </CardHeader>

            <CardContent className="pt-4 space-y-3 text-xs">
              {/* Email */}
              <div className="flex flex-col sm:flex-row sm:items-center justify-between p-2.5 rounded-lg bg-white border border-slate-200/70 gap-1">
                <div>
                  <span className="font-semibold text-slate-700 block">Account Email:</span>
                  <span className="text-slate-500 font-mono text-[11px]">
                    {profile?.email || user?.email || 'N/A'}
                  </span>
                </div>
                <div className="flex items-center gap-1 text-[11px] text-slate-400">
                  <Lock className="w-3 h-3 text-slate-400" />
                  <span>Immutable in Phase 1</span>
                </div>
              </div>

              {/* Role */}
              <div className="flex flex-col sm:flex-row sm:items-center justify-between p-2.5 rounded-lg bg-white border border-slate-200/70 gap-1">
                <div>
                  <span className="font-semibold text-slate-700 block">Account Role:</span>
                  <span className="text-slate-500 capitalize font-medium">
                    {profile?.role || 'student'}
                  </span>
                </div>
                <div className="flex items-center gap-1 text-[11px] text-amber-600">
                  <Lock className="w-3 h-3 text-amber-600" />
                  <span>Protected (Cannot be changed by student)</span>
                </div>
              </div>

              {/* User ID */}
              <div className="flex flex-col sm:flex-row sm:items-center justify-between p-2.5 rounded-lg bg-white border border-slate-200/70 gap-1">
                <div>
                  <span className="font-semibold text-slate-700 block">Supabase Auth User ID:</span>
                  <span className="text-slate-500 font-mono text-[11px] break-all">
                    {profile?.user_id || user?.id || 'N/A'}
                  </span>
                </div>
                <div className="flex items-center gap-1 text-[11px] text-slate-400">
                  <Key className="w-3 h-3 text-slate-400" />
                  <span>Primary Key Reference</span>
                </div>
              </div>

              {/* Account Created At */}
              <div className="flex flex-col sm:flex-row sm:items-center justify-between p-2.5 rounded-lg bg-white border border-slate-200/70 gap-1">
                <div>
                  <span className="font-semibold text-slate-700 block">Account Creation Timestamp:</span>
                  <span className="text-slate-500 font-mono text-[11px]">
                    {formattedDate}
                  </span>
                </div>
                <div className="flex items-center gap-1 text-[11px] text-slate-400">
                  <Calendar className="w-3 h-3 text-slate-400" />
                  <span>Immutable Timestamp</span>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  );
}

export default function ProfilePage() {
  const { profile, user, updateProfile } = useAuth();

  return (
    <div className="space-y-6 max-w-4xl">
      <div>
        <h1 className="text-2xl sm:text-3xl font-bold tracking-tight text-slate-900">
          Student Profile Settings
        </h1>
        <p className="text-xs sm:text-sm text-slate-500 mt-1">
          Manage your personal university and contact information. Immutable and role security parameters are strictly protected.
        </p>
      </div>

      <ProfileForm
        key={profile ? `${profile.user_id}-${profile.updated_at}` : 'empty'}
        profile={profile}
        user={user}
        updateProfile={updateProfile}
      />
    </div>
  );
}
