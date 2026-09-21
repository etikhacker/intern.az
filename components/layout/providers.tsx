'use client';

import React from 'react';
import { AuthProvider } from '@/lib/auth/auth-context';
import { ConfigBanner } from '@/components/ui/config-banner';

export function Providers({ children }: { children: React.ReactNode }) {
  return (
    <AuthProvider>
      <ConfigBanner />
      {children}
    </AuthProvider>
  );
}
