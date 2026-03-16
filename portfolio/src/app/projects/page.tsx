import { Github, Globe } from 'lucide-react';
import { projects } from '@/components/data';

export default function ProjectsPage() {
  return (
    <section className="py-10">
      <h1 className="text-4xl font-bold">Projects</h1>
      <div className="mt-8 space-y-6">
        {projects.map((project) => (
          <article key={project.title} className="glass rounded-2xl p-6 shadow-glow">
            <h2 className="text-2xl font-semibold">{project.title}</h2>
            <p className="mt-3 text-slate-300">{project.description}</p>
            <div className="mt-4 flex flex-wrap gap-2">{project.tech.map((t) => <span key={t} className="rounded border border-cyan-500/40 px-2 py-1 text-xs text-cyan-200">{t}</span>)}</div>
            <div className="mt-5 flex gap-3">
              <button className="inline-flex items-center gap-2 rounded-md border border-cyan-400/40 px-4 py-2"><Github size={16} /> GitHub</button>
              <button className="inline-flex items-center gap-2 rounded-md border border-green-400/40 px-4 py-2"><Globe size={16} /> Demo</button>
            </div>
          </article>
        ))}
      </div>
    </section>
  );
}
