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
  Mail,
  Settings,
  LogOut,
  ChevronRight,
  ShieldCheck,
  Menu,
  X,
} from 'lucide-react';
import { Avatar } from '@/components/ui/avatar';
import { Badge } from '@/components/ui/badge';

interface AdminNavItem {
  name: string;
  href: string;
  icon: React.ElementType;
}

const adminNavItems: AdminNavItem[] = [
  { name: 'Ümumi baxış', href: '/admin', icon: LayoutDashboard },
  { name: 'Təcrübə proqramları', href: '/admin/internships', icon: Briefcase },
  { name: 'Müraciətlər', href: '/admin/applications', icon: FileCheck2 },
  { name: 'Tələbələr', href: '/admin/students', icon: Users },
  { name: 'Tapşırıqlar', href: '/admin/tasks', icon: ListTodo },
  { name: 'Təqdimatlar', href: '/admin/submissions', icon: CheckCircle },
  { name: 'Tamamlanmış təcrübələr', href: '/admin/completed', icon: FileBadge },
  { name: 'Sertifikat sifarişləri', href: '/admin/certificate-orders', icon: CreditCard },
  { name: 'Sertifikatlar', href: '/admin/certificates', icon: Award },
  { name: 'Sertifikat parametrləri', href: '/admin/certificate-settings', icon: Settings },
  { name: 'Bildirişlər', href: '/admin/notifications', icon: Bell },
  { name: 'Əlaqə mesajları', href: '/admin/contact-messages', icon: Mail },
];

export function AdminSidebar() {
  const pathname = usePathname();
  const { profile, signOut } = useAuth();
  const [mobileOpen, setMobileOpen] = useState(false);

  const sidebarContent = (
    <div className="flex flex-col h-full bg-slate-900 text-slate-300 border-r border-slate-800">
      {/* Brand Header */}
      <div className="p-5 border-b border-slate-800 flex items-center justify-between">
        <Link href="/admin" className="flex items-center gap-2.5">
          <div className="w-8 h-8 rounded-lg bg-amber-500 flex items-center justify-center text-slate-950 font-bold shadow-xs">
            <ShieldCheck className="w-4 h-4 text-slate-950" />
          </div>
          <div>
            <span className="font-bold text-white text-base leading-tight block">
              Intern<span className="text-amber-400">.az</span>
            </span>
            <span className="text-[10px] text-amber-400 font-medium tracking-wide uppercase">
              İnzibatçı Paneli
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
              {profile?.full_name || 'İnzibatçı'}
            </p>
            <p className="text-[10px] text-slate-400 truncate">
              {profile?.email || 'admin@intern.az'}
            </p>
            <div className="mt-1">
              <Badge variant="admin" className="text-[9px] py-0 px-1.5 bg-amber-400/20 text-amber-300 border-amber-400/40">
                Administrator
              </Badge>
            </div>
          </div>
        </div>
      </div>

      {/* Navigation List */}
      <div className="flex-1 px-3 py-2 space-y-1 overflow-y-auto">
        <div className="px-3 py-1 text-[10px] font-bold uppercase tracking-wider text-slate-400">
          İdarəetmə
        </div>
        {adminNavItems.map((item) => {
          const Icon = item.icon;
          const isActive = pathname === item.href;
          return (
            <Link
              key={item.name}
              href={item.href}
              onClick={() => setMobileOpen(false)}
              className={cn(
                'flex items-center justify-between px-3 py-2 rounded-lg text-xs font-medium transition-all group',
                isActive
                  ? 'bg-amber-400 text-slate-950 font-bold shadow-2xs'
                  : 'text-slate-300 hover:bg-slate-800 hover:text-white'
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
              {isActive && <ChevronRight className="w-3.5 h-3.5 text-slate-950" />}
            </Link>
          );
        })}
      </div>

      {/* Footer / Sign Out */}
      <div className="p-3 border-t border-slate-800 space-y-1">
        <button
          onClick={() => signOut()}
          className="w-full flex items-center gap-2.5 px-3 py-2 rounded-lg text-xs font-medium text-red-400 hover:bg-red-950/40 transition-colors"
        >
          <LogOut className="w-4 h-4" />
          <span>Çıxış</span>
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
            <ShieldCheck className="w-4 h-4" />
          </div>
          <span className="font-bold text-white text-sm">Intern.az İnzibatçı</span>
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
      <aside className="hidden md:block w-64 shrink-0 h-screen sticky top-0">
        {sidebarContent}
      </aside>

      {/* Mobile drawer */}
      {mobileOpen && (
        <div className="fixed inset-0 z-50 md:hidden flex">
          <div
            className="fixed inset-0 bg-slate-950/70 backdrop-blur-2xs"
            onClick={() => setMobileOpen(false)}
          />
          <div className="relative w-64 max-w-full h-full bg-slate-900 shadow-2xl z-10">
            {sidebarContent}
          </div>
        </div>
      )}
    </>
  );
}
