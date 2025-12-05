import { writable } from 'svelte/store';

export type Theme = 'light' | 'dark';

// DaisyUI theme names
const THEME_MAP = {
  light: 'emtoolsLight',
  dark: 'emtools'
};

// Check if we're in browser
const isBrowser = typeof window !== 'undefined';

// Get initial theme from localStorage or system preference
function getInitialTheme(): Theme {
  if (!isBrowser) return 'dark';
  
  const stored = localStorage.getItem('theme') as Theme | null;
  if (stored && (stored === 'light' || stored === 'dark')) {
    return stored;
  }
  
  // Check system preference
  if (window.matchMedia('(prefers-color-scheme: light)').matches) {
    return 'light';
  }
  
  return 'dark';
}

function createThemeStore() {
  const initialTheme = isBrowser ? getInitialTheme() : 'dark';
  const { subscribe, set, update } = writable<Theme>(initialTheme);
  
  return {
    subscribe,
    toggle: () => {
      update(current => {
        const newTheme = current === 'light' ? 'dark' : 'light';
        if (isBrowser) {
          localStorage.setItem('theme', newTheme);
          document.documentElement.setAttribute('data-theme', THEME_MAP[newTheme]);
        }
        return newTheme;
      });
    },
    set: (theme: Theme) => {
      if (isBrowser) {
        localStorage.setItem('theme', theme);
        document.documentElement.setAttribute('data-theme', THEME_MAP[theme]);
      }
      set(theme);
    },
    initialize: () => {
      if (isBrowser) {
        const theme = getInitialTheme();
        document.documentElement.setAttribute('data-theme', THEME_MAP[theme]);
        set(theme);
        
        // Listen for system theme changes
        window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
          if (!localStorage.getItem('theme')) {
            const newTheme = e.matches ? 'dark' : 'light';
            document.documentElement.setAttribute('data-theme', THEME_MAP[newTheme]);
            set(newTheme);
          }
        });
      }
    }
  };
}

export const theme = createThemeStore();
