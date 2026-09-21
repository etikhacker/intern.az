'use client';

import React, { useEffect } from 'react';
import { useRouter, usePathname } from 'next/navigation';
import { useAuth } from '@/lib/auth/auth-context';
import { AdminSidebar } from '@/components/admin/admin-sidebar';
import { Loader2 } from 'lucide-react';

export default function AdminLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const { user, profile, role, isLoading } = useAuth();
  const router = useRouter();
  const pathname = usePathname();

  useEffect(() => {
    // If on /admin/login, don't guard
    if (pathname === '/admin/login') {
      return;
    }

    if (!isLoading) {
      if (!user) {
        // Unauthenticated -> redirect to /admin/login
        router.push('/admin/login');
      } else if (role !== 'admin') {
        // Student -> redirect to /dashboard
        router.push('/dashboard');
      }
    }
  }, [user, role, isLoading, router, pathname]);

  if (pathname === '/admin/login') {
    return <>{children}</>;
  }

  if (isLoading) {
    return (
      <div className="flex-1 min-h-screen bg-slate-900 flex items-center justify-center p-12">
        <div className="flex flex-col items-center gap-3 text-slate-400">
          <Loader2 className="w-8 h-8 animate-spin text-amber-400" />
          <p className="text-xs font-medium">Verifying administrator permissions...</p>
        </div>
      </div>
    );
  }

  // If user is not admin, do not render content while redirecting
  if (!user || role !== 'admin') {
    return (
      <div className="flex-1 min-h-screen bg-slate-900 flex items-center justify-center p-12">
        <div className="text-center text-slate-400 text-xs">
          Redirecting to authorized dashboard...
        </div>
      </div>
    );
  }

  return (
    <div className="flex-1 flex flex-col md:flex-row bg-slate-950 text-slate-100 min-h-[calc(100vh-36px)]">
      <AdminSidebar />
      <main className="flex-1 min-w-0 p-4 sm:p-6 lg:p-8 overflow-y-auto">
        <div className="max-w-6xl mx-auto">
          {children}
        </div>
      </main>
    </div>
  );
}
