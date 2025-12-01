/**
 * Tests for auth store
 */
import { describe, it, expect, vi, beforeEach } from 'vitest';
import { get } from 'svelte/store';
import { authStore, setAuth, clearAuth } from '../../src/lib/stores/auth';

describe('Auth Store', () => {
  beforeEach(() => {
    // Reset store to initial state
    authStore.set({
      user: null,
      isAuthenticated: false,
      isLoading: true
    });
    vi.clearAllMocks();
  });

  describe('Initial State', () => {
    it('should have initial state with isLoading true', () => {
      const state = get(authStore);
      expect(state.user).toBeNull();
      expect(state.isAuthenticated).toBe(false);
      expect(state.isLoading).toBe(true);
    });
  });

  describe('setAuth', () => {
    it('should set user and mark as authenticated', () => {
      const mockUser = {
        id: '123',
        email: 'test@example.com',
        full_name: 'Test User',
        is_active: true,
        is_superuser: false,
        role: 'user' as const,
        created_at: '2024-01-01T00:00:00Z'
      };

      setAuth(mockUser);
      const state = get(authStore);

      expect(state.user).toEqual(mockUser);
      expect(state.isAuthenticated).toBe(true);
      expect(state.isLoading).toBe(false);
    });

    it('should handle admin user', () => {
      const mockAdmin = {
        id: '456',
        email: 'admin@example.com',
        full_name: 'Admin User',
        is_active: true,
        is_superuser: true,
        role: 'admin' as const,
        created_at: '2024-01-01T00:00:00Z'
      };

      setAuth(mockAdmin);
      const state = get(authStore);

      expect(state.user?.is_superuser).toBe(true);
      expect(state.user?.role).toBe('admin');
    });
  });

  describe('clearAuth', () => {
    it('should clear user and mark as not authenticated', () => {
      // First set a user
      setAuth({
        id: '123',
        email: 'test@example.com',
        full_name: 'Test User',
        is_active: true,
        is_superuser: false,
        role: 'user',
        created_at: '2024-01-01T00:00:00Z'
      });

      // Then clear
      clearAuth();
      const state = get(authStore);

      expect(state.user).toBeNull();
      expect(state.isAuthenticated).toBe(false);
      expect(state.isLoading).toBe(false);
    });

    it('should remove tokens from localStorage', () => {
      const removeItemSpy = vi.spyOn(localStorage, 'removeItem');
      
      clearAuth();

      expect(removeItemSpy).toHaveBeenCalledWith('access_token');
      expect(removeItemSpy).toHaveBeenCalledWith('refresh_token');
    });
  });
});
