'use client';

import { useState } from 'react';

const responses: Record<string, string> = {
  help: 'Available: help, about, skills, projects, contact',
  about: 'Raihan is a cybersecurity student building secure systems and intelligent tools.',
  skills: 'Python, JavaScript, Bash, Network Security, Linux Security, Automation',
  projects: '1) Vulnerability Scanner 2) FloodSense 3) Cybersecurity Learning Lab',
  contact: 'Email: raihan@securedev.dev | LinkedIn/GitHub links in Contact page'
};

export function FakeTerminal() {
  const [input, setInput] = useState('');
  const [lines, setLines] = useState<string[]>(['Booting secure shell...', 'Type `help` to list commands.']);

  const submit = (e: React.FormEvent) => {
    e.preventDefault();
    const cmd = input.trim().toLowerCase();
    if (!cmd) return;
    setLines((prev) => [...prev, `root@raihan:~$ ${cmd}`, responses[cmd] ?? 'Command not found.']);
    setInput('');
  };

  return (
    <div className="glass mt-8 rounded-2xl p-4 shadow-glow">
      <div className="mb-3 flex gap-2">
        <span className="h-3 w-3 rounded-full bg-red-400" />
        <span className="h-3 w-3 rounded-full bg-yellow-400" />
        <span className="h-3 w-3 rounded-full bg-green-400" />
      </div>
      <div className="h-48 overflow-y-auto rounded bg-black/70 p-3 font-mono text-sm text-green-300">
        {lines.map((line, i) => <p key={i}>{line}</p>)}
      </div>
      <form onSubmit={submit} className="mt-3 flex items-center gap-2 font-mono text-sm">
        <span className="text-cyan-300">root@raihan:~$</span>
        <input value={input} onChange={(e) => setInput(e.target.value)} className="w-full bg-transparent outline-none" />
      </form>
    </div>
  );
}
