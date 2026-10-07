'use client';

import React, { useEffect } from 'react';
import { useRouter, usePathname } from 'next/navigation';
import { useAuth } from '@/lib/auth/auth-context';
import { isSoleAdminEmail } from '@/lib/auth/admin';
import { AdminSidebar } from '@/components/admin/admin-sidebar';
import { Loader2 } from 'lucide-react';

export default function AdminLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const { user, isLoading } = useAuth();
  const isAdmin = isSoleAdminEmail(user?.email);
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
      } else if (!isAdmin) {
        // Student -> redirect to /dashboard
        router.push('/dashboard');
      }
    }
  }, [user, isAdmin, isLoading, router, pathname]);

  if (pathname === '/admin/login') {
    return <>{children}</>;
  }

  if (isLoading) {
    return (
      <div className="admin-shell flex-1 min-h-screen bg-slate-900 flex items-center justify-center p-12">
        <div className="flex flex-col items-center gap-3 text-slate-400">
          <Loader2 className="w-8 h-8 animate-spin text-amber-400" />
          <p className="text-xs font-medium">Verifying administrator permissions...</p>
        </div>
      </div>
    );
  }

  // If user is not admin, do not render content while redirecting
  if (!user || !isAdmin) {
    return (
      <div className="admin-shell flex-1 min-h-screen bg-slate-900 flex items-center justify-center p-12">
        <div className="text-center text-slate-400 text-xs">
          Redirecting to authorized dashboard...
        </div>
      </div>
    );
  }

  return (
    /* The shell owns exactly one viewport (h-[100dvh]) with the main column as
     * the single scroll container. The previous `min-h-[calc(100vh-36px)]` plus
     * an `h-screen` sidebar made the sidebar 36px taller than its container, so
     * a dead band of page background showed under the console and the sidebar
     * pushed the page into a second, meaningless scroll.
     *
     * `flex-1` must stay off the shell: body is a column flex container and
     * `flex: 1 1 0%` (flex-basis) overrides `height`, which let the shell grow
     * to the content height — the document scrolled and the sidebar turned into
     * a half-height ("yarımqıq") bar. */
    <div className="admin-shell flex flex-col overflow-x-clip bg-slate-950 text-slate-100 md:h-[100dvh] md:flex-row md:overflow-hidden">
      <AdminSidebar />
      <main className="min-w-0 flex-1 overflow-y-auto p-4 sm:p-6 lg:p-8">
        <div className="mx-auto max-w-6xl">
          {children}
        </div>
      </main>
    </div>
  );
}
