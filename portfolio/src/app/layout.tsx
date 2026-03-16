import type { Metadata } from 'next';
import './globals.css';
import { Navbar } from '@/components/Navbar';
import { CursorGlow, PageTransition, ScrollProgress } from '@/components/UiEffects';
import { Footer } from '@/components/Footer';

export const metadata: Metadata = {
  title: 'Raihan | Cybersecurity Developer Portfolio',
  description: 'Portfolio of Raihan, a cybersecurity-focused developer building secure systems.'
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>
        <ScrollProgress />
        <CursorGlow />
        <div className="grid-overlay fixed inset-0 -z-10 bg-grid" />
        <Navbar />
        <div className="mx-auto min-h-screen max-w-6xl px-6 pt-24">
          <PageTransition>{children}</PageTransition>
        </div>
        <Footer />
      </body>
    </html>
  );
}
