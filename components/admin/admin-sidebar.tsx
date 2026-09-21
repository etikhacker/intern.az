'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { useAuth } from '@/lib/auth/auth-context';
import { cn } from '@/lib/utils';
import {
  LayoutDashboard,
  Briefcase,
  FileCheck2,
  Users,
  ListTodo,
  CheckCircle,
  FileBadge,
  CreditCard,
  Award,
  Bell,
  Settings,
  LogOut,
  ChevronRight,
  ShieldAlert,
  Sparkles,
  Menu,
  X,
} from 'lucide-react';
import { Avatar } from '@/components/ui/avatar';
import { Badge } from '@/components/ui/badge';

interface AdminNavItem {
  name: string;
  href: string;
  icon: React.ElementType;
  isFunctional?: boolean;
}

const adminNavItems: AdminNavItem[] = [
  { name: 'Overview', href: '/admin', icon: LayoutDashboard, isFunctional: true },
  { name: 'Internships', href: '/admin/internships', icon: Briefcase },
  { name: 'Applications', href: '/admin/applications', icon: FileCheck2 },
  { name: 'Students', href: '/admin/students', icon: Users },
  { name: 'Tasks', href: '/admin/tasks', icon: ListTodo },
  { name: 'Submissions', href: '/admin/submissions', icon: CheckCircle },
  { name: 'Completed Internships', href: '/admin/completed', icon: FileBadge },
  { name: 'Certificate Orders', href: '/admin/orders', icon: CreditCard },
  { name: 'Certificates', href: '/admin/certificates', icon: Award },
  { name: 'Notifications', href: '/admin/notifications', icon: Bell },
  { name: 'Settings', href: '/admin/settings', icon: Settings },
];

export function AdminSidebar() {
  const pathname = usePathname();
  const { profile, signOut } = useAuth();
  const [mobileOpen, setMobileOpen] = useState(false);
  const [comingSoonModal, setComingSoonModal] = useState<string | null>(null);

  const handleNavClick = (e: React.MouseEvent, item: AdminNavItem) => {
    if (!item.isFunctional) {
      e.preventDefault();
      setComingSoonModal(item.name);
      setMobileOpen(false);
    } else {
      setMobileOpen(false);
    }
  };

  const sidebarContent = (
    <div className="flex flex-col h-full bg-slate-900 text-slate-300 border-r border-slate-800">
      {/* Brand Header */}
      <div className="p-5 border-b border-slate-800 flex items-center justify-between">
        <Link href="/admin" className="flex items-center gap-2.5">
          <div className="w-8 h-8 rounded-lg bg-amber-500 flex items-center justify-center text-slate-950 font-bold shadow-sm">
            <ShieldAlert className="w-4 h-4 text-slate-950" />
          </div>
          <div>
            <span className="font-bold text-white text-base leading-tight block">
              Intern<span className="text-amber-400">.az</span>
            </span>
            <span className="text-[10px] text-amber-400/90 font-mono tracking-wider uppercase">
              Admin Console
            </span>
          </div>
        </Link>
        <button
          onClick={() => setMobileOpen(false)}
          className="md:hidden p-1 text-slate-400 hover:text-white"
        >
          <X className="w-5 h-5" />
        </button>
      </div>

      {/* Admin Profile Capsule */}
      <div className="p-3.5 mx-3 my-3 rounded-xl bg-slate-800/80 border border-slate-700/60">
        <div className="flex items-center gap-3">
          <Avatar
            src={profile?.avatar_url}
            fallback={profile?.full_name || 'AD'}
            size="md"
            className="ring-amber-500/40"
          />
          <div className="min-w-0 flex-1">
            <p className="text-xs font-semibold text-white truncate">
              {profile?.full_name || 'Administrator'}
            </p>
            <p className="text-[10px] text-slate-400 truncate">
              {profile?.email || 'admin@intern.az'}
            </p>
            <div className="mt-1">
              <Badge variant="admin" className="text-[9px] py-0 px-1.5 bg-amber-400/20 text-amber-300 border-amber-400/40">
                Verified Admin
              </Badge>
            </div>
          </div>
        </div>
      </div>

      {/* Navigation List */}
      <div className="flex-1 px-3 py-2 space-y-1 overflow-y-auto">
        <div className="px-3 py-1 text-[10px] font-bold uppercase tracking-wider text-slate-400">
          Platform Management
        </div>
        {adminNavItems.map((item) => {
          const Icon = item.icon;
          const isActive = pathname === item.href;
          return (
            <Link
              key={item.name}
              href={item.href}
              onClick={(e) => handleNavClick(e, item)}
              className={cn(
                'flex items-center justify-between px-3 py-2 rounded-lg text-xs font-medium transition-all group',
                isActive
                  ? 'bg-amber-400 text-slate-950 font-bold shadow-xs'
                  : 'text-slate-400 hover:bg-slate-800 hover:text-white'
              )}
            >
              <div className="flex items-center gap-2.5">
                <Icon
                  className={cn(
                    'w-4 h-4 transition-colors',
                    isActive
                      ? 'text-slate-950'
                      : 'text-slate-400 group-hover:text-slate-200'
                  )}
                />
                <span>{item.name}</span>
              </div>
              {!item.isFunctional ? (
                <span className="text-[9px] text-slate-400 bg-slate-800 group-hover:bg-slate-700 px-1.5 py-0.5 rounded font-normal">
                  Phase 2+
                </span>
              ) : (
                isActive && <ChevronRight className="w-3.5 h-3.5 text-slate-950" />
              )}
            </Link>
          );
        })}
      </div>

      {/* Footer / Sign Out & Switch */}
      <div className="p-3 border-t border-slate-800 space-y-1">
        <Link
          href="/dashboard"
          className="w-full flex items-center justify-between px-3 py-2 rounded-lg text-xs font-medium text-slate-400 hover:bg-slate-800 hover:text-white transition-colors"
        >
          <span>View Student Dashboard</span>
          <ChevronRight className="w-3 h-3" />
        </Link>
        <button
          onClick={() => signOut()}
          className="w-full flex items-center gap-2.5 px-3 py-2 rounded-lg text-xs font-medium text-red-400 hover:bg-red-950/40 transition-colors"
        >
          <LogOut className="w-4 h-4" />
          <span>Sign Out</span>
        </button>
      </div>
    </div>
  );

  return (
    <>
      {/* Mobile top bar */}
      <div className="md:hidden flex items-center justify-between px-4 py-3 bg-slate-900 border-b border-slate-800 sticky top-0 z-20">
        <div className="flex items-center gap-2">
          <div className="w-7 h-7 rounded-lg bg-amber-400 flex items-center justify-center text-slate-950">
            <ShieldAlert className="w-4 h-4" />
          </div>
          <span className="font-bold text-white text-sm">Intern.az Admin</span>
        </div>
        <button
          onClick={() => setMobileOpen(true)}
          className="p-1.5 rounded-lg border border-slate-700 text-slate-300"
          aria-label="Open admin sidebar"
        >
          <Menu className="w-5 h-5" />
        </button>
      </div>

      {/* Desktop static sidebar */}
      <aside className="hidden md:block w-64 shrink-0 h-[calc(100vh-36px)] sticky top-[36px]">
        {sidebarContent}
      </aside>

      {/* Mobile drawer */}
      {mobileOpen && (
        <div className="fixed inset-0 z-50 md:hidden flex">
          <div
            className="fixed inset-0 bg-slate-950/70 backdrop-blur-xs"
            onClick={() => setMobileOpen(false)}
          />
          <div className="relative w-64 max-w-full h-full bg-slate-900 shadow-2xl z-10">
            {sidebarContent}
          </div>
        </div>
      )}

      {/* Coming Soon Modal */}
      {comingSoonModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-950/70 backdrop-blur-xs">
          <div className="bg-white rounded-xl max-w-md w-full p-6 shadow-xl border border-slate-200 text-center">
            <div className="w-12 h-12 rounded-full bg-amber-50 text-amber-600 flex items-center justify-center mx-auto mb-4">
              <Sparkles className="w-6 h-6" />
            </div>
            <h3 className="text-base font-bold text-slate-900 mb-1">
              {comingSoonModal}
            </h3>
            <p className="text-sm text-slate-500 mb-5 leading-relaxed">
              Coming in a future phase. Phase 1 provides the admin foundational statistics, student count synchronization, and authenticated access control.
            </p>
            <button
              onClick={() => setComingSoonModal(null)}
              className="w-full py-2 px-4 rounded-lg bg-slate-900 text-white text-xs font-semibold hover:bg-slate-800 transition-colors"
            >
              Understood
            </button>
          </div>
        </div>
      )}
    </>
  );
}
