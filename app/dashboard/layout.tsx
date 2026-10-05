'use client';

import React, { useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { useAuth } from '@/lib/auth/auth-context';
import { StudentSidebar } from '@/components/dashboard/student-sidebar';
import { Loader2 } from 'lucide-react';

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const { user, isLoading } = useAuth();
  const router = useRouter();

  useEffect(() => {
    if (!isLoading && !user) {
      router.push('/login?redirect=/dashboard');
    }
  }, [user, isLoading, router]);

  if (isLoading) {
    return (
      <div className="flex-1 flex items-center justify-center p-12">
        <div className="flex flex-col items-center gap-3 text-slate-500">
          <Loader2 className="w-8 h-8 animate-spin text-emerald-600" />
          <p className="text-xs font-medium">Verifying student session...</p>
        </div>
      </div>
    );
  }

  if (!user) {
    return null;
  }

  return (
    /* Same single-viewport shell as the admin console, so the student sidebar
       (h-[100dvh]) and the content column can never leave a dead band. */
    <div className="flex flex-1 flex-col overflow-x-clip bg-slate-50 md:h-[100dvh] md:flex-row md:overflow-hidden">
      <StudentSidebar />
      <main className="min-w-0 flex-1 overflow-y-auto p-4 sm:p-6 lg:p-8">
        <div className="mx-auto max-w-6xl">
          {children}
        </div>
      </main>
    </div>
  );
}
