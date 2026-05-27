import './globals.css';
import type { ReactNode } from 'react';

export const metadata = {
  title: 'Azure Local Training — AI Tutor',
  description: 'Interactive AI-led learning experience for Azure Local Operator Training'
};

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
