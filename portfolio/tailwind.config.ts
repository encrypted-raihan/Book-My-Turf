import type { Config } from 'tailwindcss';

const config: Config = {
  content: ['./src/**/*.{js,ts,jsx,tsx,mdx}'],
  theme: {
    extend: {
      colors: {
        bg: '#06080f',
        neonBlue: '#22d3ee',
        cyberGreen: '#22c55e'
      },
      boxShadow: {
        glow: '0 0 24px rgba(34, 211, 238, 0.25)',
        greenGlow: '0 0 24px rgba(34, 197, 94, 0.3)'
      },
      backgroundImage: {
        grid: 'linear-gradient(rgba(34,211,238,0.08) 1px, transparent 1px), linear-gradient(90deg, rgba(34,211,238,0.08) 1px, transparent 1px)'
      }
    }
  },
  plugins: []
};

export default config;
