import type {Metadata, Viewport} from 'next';
import './globals.css'; // Global styles
import { Providers } from '@/components/layout/providers';

export const metadata: Metadata = {
  title: 'Intern.az',
  description: 'Azərbaycan tələbələri üçün təcrübə platforması.',
  icons: {
    icon: [
      { url: '/favicon.ico', sizes: '32x32', type: 'image/x-icon' },
      { url: '/icon-192.png', sizes: '192x192', type: 'image/png' },
    ],
    apple: '/apple-touch-icon.png',
  },
  manifest: '/site.webmanifest',
  openGraph: {
    title: 'Intern.az',
    description: 'Azərbaycan tələbələri üçün təcrübə platforması.',
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Intern.az',
    description: 'Azərbaycan tələbələri üçün təcrübə platforması.',
  },
};

export const viewport: Viewport = {
  themeColor: '#00a651',
};

export default function RootLayout({children}: {children: React.ReactNode}) {
  return (
    <html lang="az">
      <body
        suppressHydrationWarning
        className="min-h-screen bg-[var(--page)] text-slate-100 antialiased flex flex-col"
      >
        <Providers>
          {children}
        </Providers>
      </body>
    </html>
  );
}
