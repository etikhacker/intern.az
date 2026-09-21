'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import { useAuth } from '@/lib/auth/auth-context';
import { Button } from '@/components/ui/button';
import { GraduationCap, Menu, X, ArrowRight, ShieldCheck, User } from 'lucide-react';

export function Navbar() {
  const { user, profile, role, signOut } = useAuth();
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

  return (
    <nav className="sticky top-0 z-30 w-full bg-white/95 backdrop-blur-md border-b border-slate-200/80">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16">
          {/* Brand Logo */}
          <Link href="/" className="flex items-center gap-2.5 group">
            <div className="w-10 h-10 rounded-xl bg-emerald-600 flex items-center justify-center text-white shadow-sm group-hover:bg-emerald-700 transition-colors">
              <GraduationCap className="w-5 h-5" />
            </div>
            <div>
              <span className="text-xl font-bold tracking-tight text-slate-900 block leading-tight">
                Intern<span className="text-emerald-600">.az</span>
              </span>
              <span className="text-[10px] tracking-wide text-slate-500 uppercase font-medium">
                Azerbaijan Internship Portal
              </span>
            </div>
          </Link>

          {/* Desktop Navigation Links */}
          <div className="hidden md:flex items-center gap-8 text-sm font-medium text-slate-600">
            <Link href="/#how-it-works" className="hover:text-emerald-600 transition-colors">
              How It Works
            </Link>
            <Link href="/#categories" className="hover:text-emerald-600 transition-colors">
              Internship Tracks
            </Link>
            <Link href="/#benefits" className="hover:text-emerald-600 transition-colors">
              Student Benefits
            </Link>
          </div>

          {/* Auth Actions */}
          <div className="hidden md:flex items-center gap-3">
            {user ? (
              <div className="flex items-center gap-3">
                {role === 'admin' ? (
                  <Link href="/admin">
                    <Button variant="outline" size="sm" className="gap-2 border-amber-300 text-amber-900 bg-amber-50 hover:bg-amber-100">
                      <ShieldCheck className="w-4 h-4 text-amber-600" />
                      Admin Panel
                    </Button>
                  </Link>
                ) : (
                  <Link href="/dashboard">
                    <Button variant="outline" size="sm" className="gap-2">
                      <User className="w-4 h-4 text-emerald-600" />
                      Dashboard
                    </Button>
                  </Link>
                )}
                <Button variant="ghost" size="sm" onClick={() => signOut()}>
                  Log Out
                </Button>
              </div>
            ) : (
              <div className="flex items-center gap-3">
                <Link href="/login">
                  <Button variant="ghost" size="sm">
                    Log In
                  </Button>
                </Link>
                <Link href="/register">
                  <Button variant="default" size="sm" className="gap-1.5">
                    Register
                    <ArrowRight className="w-4 h-4" />
                  </Button>
                </Link>
              </div>
            )}
          </div>

          {/* Mobile hamburger */}
          <div className="flex md:hidden">
            <button
              onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
              className="p-2 rounded-lg text-slate-600 hover:text-slate-900 hover:bg-slate-100"
              aria-label="Toggle navigation"
            >
              {mobileMenuOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
            </button>
          </div>
        </div>
      </div>

      {/* Mobile menu dropdown */}
      {mobileMenuOpen && (
        <div className="md:hidden border-b border-slate-200 bg-white px-4 pt-2 pb-6 space-y-3">
          <Link
            href="/#how-it-works"
            onClick={() => setMobileMenuOpen(false)}
            className="block px-3 py-2 rounded-md text-base font-medium text-slate-700 hover:bg-slate-50"
          >
            How It Works
          </Link>
          <Link
            href="/#categories"
            onClick={() => setMobileMenuOpen(false)}
            className="block px-3 py-2 rounded-md text-base font-medium text-slate-700 hover:bg-slate-50"
          >
            Internship Tracks
          </Link>
          <Link
            href="/#benefits"
            onClick={() => setMobileMenuOpen(false)}
            className="block px-3 py-2 rounded-md text-base font-medium text-slate-700 hover:bg-slate-50"
          >
            Student Benefits
          </Link>

          <div className="pt-4 border-t border-slate-100 flex flex-col gap-2">
            {user ? (
              <>
                <div className="px-3 py-1 text-xs text-slate-500">
                  Signed in as {profile?.full_name || user.email}
                </div>
                {role === 'admin' ? (
                  <Link href="/admin" onClick={() => setMobileMenuOpen(false)}>
                    <Button variant="outline" className="w-full justify-start gap-2 text-amber-900 bg-amber-50">
                      <ShieldCheck className="w-4 h-4" />
                      Admin Panel
                    </Button>
                  </Link>
                ) : (
                  <Link href="/dashboard" onClick={() => setMobileMenuOpen(false)}>
                    <Button variant="outline" className="w-full justify-start gap-2">
                      <User className="w-4 h-4" />
                      Student Dashboard
                    </Button>
                  </Link>
                )}
                <Button variant="ghost" onClick={() => { signOut(); setMobileMenuOpen(false); }}>
                  Log Out
                </Button>
              </>
            ) : (
              <>
                <Link href="/login" onClick={() => setMobileMenuOpen(false)}>
                  <Button variant="outline" className="w-full">
                    Log In
                  </Button>
                </Link>
                <Link href="/register" onClick={() => setMobileMenuOpen(false)}>
                  <Button variant="default" className="w-full">
                    Register
                  </Button>
                </Link>
                <Link href="/admin/login" onClick={() => setMobileMenuOpen(false)} className="text-center text-xs text-slate-400 hover:underline pt-2">
                  Admin Portal Login
                </Link>
              </>
            )}
          </div>
        </div>
      )}
    </nav>
  );
}
