/**
 * Tests for API utility
 */
import { describe, it, expect, vi, beforeEach } from 'vitest';

// Mock the API module
const mockFetch = vi.fn();
global.fetch = mockFetch;

describe('API Utility', () => {
  beforeEach(() => {
    mockFetch.mockClear();
    localStorage.clear();
  });

  describe('GET requests', () => {
    it('should make GET request with correct headers', async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.resolve({ data: 'test' })
      });

      localStorage.setItem('access_token', 'test-token');

      // Import dynamically to avoid module caching issues
      const { api } = await import('../../src/lib/api');
      const result = await api.get('/test');

      expect(mockFetch).toHaveBeenCalledWith(
        expect.stringContaining('/test'),
        expect.objectContaining({
          method: 'GET'
        })
      );
    });

    it('should handle failed GET request', async () => {
      mockFetch.mockResolvedValueOnce({
        ok: false,
        status: 404,
        json: () => Promise.resolve({ detail: 'Not found' })
      });

      const { api } = await import('../../src/lib/api');
      
      await expect(api.get('/notfound')).rejects.toThrow();
    });
  });

  describe('POST requests', () => {
    it('should make POST request with JSON body', async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.resolve({ id: '123' })
      });

      const { api } = await import('../../src/lib/api');
      const result = await api.post('/create', { name: 'test' });

      expect(mockFetch).toHaveBeenCalledWith(
        expect.stringContaining('/create'),
        expect.objectContaining({
          method: 'POST',
          headers: expect.objectContaining({
            'Content-Type': 'application/json'
          }),
          body: JSON.stringify({ name: 'test' })
        })
      );
    });
  });
});
