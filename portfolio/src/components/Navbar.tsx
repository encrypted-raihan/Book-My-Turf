'use client';

import { Menu, X } from 'lucide-react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { useState } from 'react';
import { motion } from 'framer-motion';
import { navLinks } from './data';

export function Navbar() {
  const pathname = usePathname();
  const [open, setOpen] = useState(false);

  return (
    <header className="fixed top-0 z-50 w-full border-b border-cyan-400/20 bg-black/40 backdrop-blur-xl">
      <nav className="mx-auto flex max-w-6xl items-center justify-between px-6 py-4">
        <Link href="/" className="text-lg font-semibold tracking-wide text-cyan-300">Raihan</Link>
        <div className="hidden gap-8 md:flex">
          {navLinks.map((item) => (
            <Link key={item.href} href={item.href} className="group relative text-sm text-slate-200">
              {item.label}
              <span className={`absolute -bottom-1 left-0 h-0.5 bg-cyan-400 transition-all ${pathname === item.href ? 'w-full' : 'w-0 group-hover:w-full'}`} />
            </Link>
          ))}
        </div>
        <button className="md:hidden" onClick={() => setOpen(!open)}>{open ? <X /> : <Menu />}</button>
      </nav>
      {open && (
        <motion.div initial={{ opacity: 0, y: -8 }} animate={{ opacity: 1, y: 0 }} className="glass m-3 rounded-xl p-4 md:hidden">
          {navLinks.map((item) => (
            <Link key={item.href} href={item.href} className="block py-2" onClick={() => setOpen(false)}>
              {item.label}
            </Link>
          ))}
        </motion.div>
      )}
    </header>
  );
}
