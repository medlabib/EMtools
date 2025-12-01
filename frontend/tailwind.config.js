/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{svelte,js,ts,jsx,tsx,html}"
  ],
  theme: {
    extend: {
      colors: {
        // Medical/Emergency theme colors
        primary: '#3b82f6',
        secondary: '#8b5cf6',
        accent: '#06b6d4',
        success: '#22c55e',
        warning: '#f59e0b',
        error: '#ef4444',
        info: '#0ea5e9',
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Roboto', 'sans-serif'],
      },
      animation: {
        'fade-in': 'fadeIn 0.3s ease-out',
        'slide-up': 'slideUp 0.3s ease-out',
        'pulse-slow': 'pulse 3s cubic-bezier(0.4, 0, 0.6, 1) infinite',
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
        slideUp: {
          '0%': { opacity: '0', transform: 'translateY(10px)' },
          '100%': { opacity: '1', transform: 'translateY(0)' },
        },
      },
    },
  },
  plugins: [
    require('daisyui'),
  ],
  daisyui: {
    themes: [
      {
        emtools: {
          "primary": "#3b82f6",
          "primary-content": "#ffffff",
          "secondary": "#8b5cf6",
          "secondary-content": "#ffffff",
          "accent": "#06b6d4",
          "accent-content": "#ffffff",
          "neutral": "#1e293b",
          "neutral-content": "#f1f5f9",
          "base-100": "#0f172a",
          "base-200": "#1e293b",
          "base-300": "#334155",
          "base-content": "#f1f5f9",
          "info": "#0ea5e9",
          "info-content": "#ffffff",
          "success": "#22c55e",
          "success-content": "#ffffff",
          "warning": "#f59e0b",
          "warning-content": "#000000",
          "error": "#ef4444",
          "error-content": "#ffffff",
        },
        emtoolsLight: {
          "primary": "#3b82f6",
          "primary-content": "#ffffff",
          "secondary": "#8b5cf6",
          "secondary-content": "#ffffff",
          "accent": "#06b6d4",
          "accent-content": "#ffffff",
          "neutral": "#64748b",
          "neutral-content": "#f1f5f9",
          "base-100": "#ffffff",
          "base-200": "#f1f5f9",
          "base-300": "#e2e8f0",
          "base-content": "#1e293b",
          "info": "#0ea5e9",
          "info-content": "#ffffff",
          "success": "#22c55e",
          "success-content": "#ffffff",
          "warning": "#f59e0b",
          "warning-content": "#000000",
          "error": "#ef4444",
          "error-content": "#ffffff",
        },
      },
    ],
    darkTheme: "emtools",
    base: true,
    styled: true,
    utils: true,
    prefix: "",
    logs: false,
  },
}
