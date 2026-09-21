import type {Metadata} from 'next';
import './globals.css'; // Global styles
import { Providers } from '@/components/layout/providers';

export const metadata: Metadata = {
  title: 'Internship Management Platform',
  description: 'Azerbaijan-focused internship platform for students and administrators, featuring verified internship catalogs, structured student applications, and enrollment management.',
  openGraph: {
    title: 'Internship Management Platform',
    description: 'Azerbaijan-focused internship platform for students and administrators, featuring verified internship catalogs, structured student applications, and enrollment management.',
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Internship Management Platform',
    description: 'Azerbaijan-focused internship platform for students and administrators, featuring verified internship catalogs, structured student applications, and enrollment management.',
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
