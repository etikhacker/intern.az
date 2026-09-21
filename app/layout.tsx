import type {Metadata} from 'next';
import './globals.css'; // Global styles
import { Providers } from '@/components/layout/providers';

export const metadata: Metadata = {
  title: 'Internship Management Platform',
  description: 'Azerbaijan-focused internship platform foundation for students and administrators.',
  openGraph: {
    title: 'Internship Management Platform',
    description: 'Azerbaijan-focused internship platform foundation for students and administrators.',
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Internship Management Platform',
    description: 'Azerbaijan-focused internship platform foundation for students and administrators.',
  },
};

export default function RootLayout({children}: {children: React.ReactNode}) {
  return (
    <html lang="en">
      <body suppressHydrationWarning className="min-h-screen bg-slate-50 text-slate-900 antialiased flex flex-col">
        <Providers>
          {children}
        </Providers>
      </body>
    </html>
  );
}
