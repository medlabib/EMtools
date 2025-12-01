/**
 * Test setup file for Vitest
 */
import '@testing-library/svelte';
import { vi, afterEach } from 'vitest';

// Mock svelte-routing
vi.mock('svelte-routing', () => ({
  Link: vi.fn(),
  Router: vi.fn(),
  Route: vi.fn(),
  navigate: vi.fn()
}));

// Mock svelte-i18n
vi.mock('svelte-i18n', () => ({
  _: {
    subscribe: (fn: (value: (key: string) => string) => void) => {
      fn((key: string) => key);
      return () => {};
    }
  },
  isLoading: {
    subscribe: (fn: (value: boolean) => void) => {
      fn(false);
      return () => {};
    }
  },
  init: vi.fn(),
  register: vi.fn(),
  locale: {
    subscribe: (fn: (value: string) => void) => {
      fn('fr');
      return () => {};
    },
    set: vi.fn()
  }
}));

// Mock localStorage
const localStorageMock = {
  getItem: vi.fn(),
  setItem: vi.fn(),
  removeItem: vi.fn(),
  clear: vi.fn()
};
Object.defineProperty(window, 'localStorage', { value: localStorageMock });

// Mock fetch
global.fetch = vi.fn();

// Clean up after each test
afterEach(() => {
  vi.clearAllMocks();
});
