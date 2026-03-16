'use client';

import { motion } from 'framer-motion';

const interests = ['Cybersecurity', 'System Security', 'Linux', 'Networking', 'Automation', 'Startup Building'];

export default function AboutPage() {
  return (
    <section className="py-10">
      <h1 className="text-4xl font-bold">About Raihan</h1>
      <p className="mt-6 max-w-3xl text-slate-300">Raihan is a student passionate about cybersecurity, system security, and building security tools. He enjoys exploring Linux systems, networking, and understanding vulnerabilities in modern applications. His goal is building technology that helps startups secure digital infrastructure.</p>
      <h2 className="mt-14 text-2xl font-semibold">Interests</h2>
      <div className="mt-6 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {interests.map((item, idx) => (
          <motion.div key={item} whileHover={{ y: -4 }} initial={{ opacity: 0, y: 12 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: idx * 0.05 }} className="glass rounded-xl p-4 text-cyan-100 shadow-glow">
            {item}
          </motion.div>
        ))}
      </div>
      <h2 className="mt-14 text-2xl font-semibold">Skills</h2>
      <div className="mt-6 grid gap-4 md:grid-cols-3">
        <div className="glass rounded-xl p-5"><h3 className="font-medium text-cyan-300">Programming</h3><p className="mt-2 text-sm">Python · JavaScript · Bash</p></div>
        <div className="glass rounded-xl p-5"><h3 className="font-medium text-cyan-300">Cybersecurity</h3><p className="mt-2 text-sm">Network Security · Vulnerability Analysis · Linux Security</p></div>
        <div className="glass rounded-xl p-5"><h3 className="font-medium text-cyan-300">Technologies</h3><p className="mt-2 text-sm">Linux · Git · CLI Tools · Networking</p></div>
      </div>
    </section>
  );
}
