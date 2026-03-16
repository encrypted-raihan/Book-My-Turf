import { blogs } from '@/components/data';

export default function BlogPage() {
  return (
    <section className="py-10">
      <h1 className="text-4xl font-bold">Blog</h1>
      <div className="mt-8 grid gap-5 md:grid-cols-2 lg:grid-cols-3">
        {blogs.map((title) => (
          <article key={title} className="glass rounded-xl p-5">
            <h2 className="text-lg font-semibold">{title}</h2>
            <p className="mt-3 text-sm text-slate-300">Insights and practical techniques for secure development and cyber defense.</p>
            <button className="mt-4 text-sm text-cyan-300">Read more →</button>
          </article>
        ))}
      </div>
    </section>
  );
}
