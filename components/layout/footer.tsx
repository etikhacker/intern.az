import React from 'react';
import Link from 'next/link';
import { GraduationCap, Shield } from 'lucide-react';

export function Footer() {
  return (
    <footer className="w-full bg-slate-900 text-slate-400 text-sm border-t border-slate-800">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          <div className="md:col-span-2 space-y-4">
            <div className="flex items-center gap-2">
              <div className="w-8 h-8 rounded-lg bg-emerald-600 flex items-center justify-center text-white">
                <GraduationCap className="w-5 h-5" />
              </div>
              <span className="text-lg font-bold text-white">
                Intern<span className="text-emerald-400">.az</span>
              </span>
            </div>
            <p className="text-slate-400 text-xs leading-relaxed max-w-sm">
              Empowering university students in Azerbaijan with structured practical internships, hands-on industry tasks, and verifiable career credentials.
            </p>
            <div className="text-xs text-slate-500 flex items-center gap-1.5">
              <span>Baku, Azerbaijan</span>
              <span>•</span>
              <span>Phase 1 Architecture</span>
            </div>
          </div>

          <div>
            <h4 className="font-semibold text-white text-xs uppercase tracking-wider mb-3">
              Platform
            </h4>
            <ul className="space-y-2 text-xs">
              <li>
                <Link href="/register" className="hover:text-emerald-400 transition-colors">
                  Student Registration
                </Link>
              </li>
              <li>
                <Link href="/login" className="hover:text-emerald-400 transition-colors">
                  Student Login
                </Link>
              </li>
              <li>
                <Link href="/dashboard" className="hover:text-emerald-400 transition-colors">
                  Internship Dashboard
                </Link>
              </li>
              <li>
                <Link href="/dashboard/profile" className="hover:text-emerald-400 transition-colors">
                  Student Profile
                </Link>
              </li>
            </ul>
          </div>

          <div>
            <h4 className="font-semibold text-white text-xs uppercase tracking-wider mb-3">
              Administration
            </h4>
            <ul className="space-y-2 text-xs">
              <li>
                <Link href="/admin/login" className="hover:text-amber-400 transition-colors flex items-center gap-1">
                  <Shield className="w-3.5 h-3.5" />
                  Admin Login
                </Link>
              </li>
              <li>
                <Link href="/admin" className="hover:text-amber-400 transition-colors">
                  Admin Dashboard
                </Link>
              </li>
              <li className="text-slate-500 pt-2 text-[11px]">
                Built on Next.js 15, PostgreSQL & Supabase Auth Free Tier
              </li>
            </ul>
          </div>
        </div>

        <div className="mt-8 pt-8 border-t border-slate-800 text-xs text-slate-500 flex flex-col sm:flex-row items-center justify-between gap-4">
          <p>© {new Date().getFullYear()} Intern.az Platform. All rights reserved.</p>
          <p className="text-slate-500 text-[11px]">
            Azerbaijan Tech & University Student Internship Foundation
          </p>
        </div>
      </div>
    </footer>
  );
}
