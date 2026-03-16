'use client';

import Link from 'next/link';
import { motion } from 'framer-motion';
import { NetworkHero } from '@/components/NetworkHero';
import { FakeTerminal } from '@/components/Terminal';
import { projects } from '@/components/data';
import { useRef } from 'react';

export default function HomePage() {
  const projectsRef = useRef<HTMLElement>(null);

  return (
    <>
      <section className="grid min-h-[85vh] items-center gap-12 md:grid-cols-2">
        <motion.div initial={{ opacity: 0, x: -25 }} animate={{ opacity: 1, x: 0 }}>
          <p className="text-cyan-300">Raihan</p>
          <h1 className="mt-4 text-4xl font-bold leading-tight md:text-6xl">Cybersecurity Enthusiast | Developer | Future Startup Founder</h1>
          <p className="mt-5 text-lg text-slate-300">Building secure systems and intelligent tools.</p>
          <div className="mt-8 flex gap-4">
            <Link href="/projects" className="rounded-lg border border-cyan-300/50 bg-cyan-400/10 px-5 py-3 text-cyan-200 transition hover:shadow-glow">View Projects</Link>
            <Link href="/contact" className="rounded-lg border border-green-300/50 bg-green-400/10 px-5 py-3 text-green-200 transition hover:shadow-greenGlow">Contact Me</Link>
          </div>
          <FakeTerminal />
        </motion.div>
        <motion.div initial={{ opacity: 0, x: 25 }} animate={{ opacity: 1, x: 0 }}>
          <NetworkHero onScannerClick={() => projectsRef.current?.scrollIntoView({ behavior: 'smooth' })} />
        </motion.div>
      </section>
      <section ref={projectsRef} className="py-20">
        <h2 className="mb-8 text-3xl font-semibold">Featured Security Projects</h2>
        <div className="grid gap-6 md:grid-cols-3">
          {projects.map((project) => (
            <article key={project.title} className="glass rounded-2xl p-5 transition hover:-translate-y-1 hover:shadow-glow">
              <h3 className="mb-3 text-xl font-medium">{project.title}</h3>
              <p className="text-sm text-slate-300">{project.description}</p>
            </article>
          ))}
        </div>
      </section>
    </>
  );
}
