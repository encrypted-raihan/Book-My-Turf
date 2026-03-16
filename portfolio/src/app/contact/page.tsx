import { Github, Linkedin, Mail } from 'lucide-react';

export default function ContactPage() {
  return (
    <section className="py-10">
      <h1 className="text-4xl font-bold">Contact</h1>
      <form className="glass mt-8 max-w-2xl space-y-4 rounded-2xl p-6">
        <input placeholder="Name" className="w-full rounded-md border border-cyan-500/30 bg-black/40 px-4 py-3 outline-none" />
        <input type="email" placeholder="Email" className="w-full rounded-md border border-cyan-500/30 bg-black/40 px-4 py-3 outline-none" />
        <textarea placeholder="Message" rows={5} className="w-full rounded-md border border-cyan-500/30 bg-black/40 px-4 py-3 outline-none" />
        <button type="submit" className="rounded-md border border-green-500/50 bg-green-500/10 px-5 py-2 text-green-300">Send Message</button>
      </form>
      <div className="mt-6 flex gap-4 text-cyan-300">
        <a href="#" aria-label="GitHub"><Github /></a>
        <a href="#" aria-label="LinkedIn"><Linkedin /></a>
        <a href="mailto:raihan@securedev.dev" aria-label="Email"><Mail /></a>
      </div>
    </section>
  );
}
