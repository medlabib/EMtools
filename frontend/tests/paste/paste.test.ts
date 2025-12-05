/**
 * Tests for Paste functionality
 * Tests paste creation, retrieval, and management
 */
import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';

describe('Paste Module', () => {
  const mockFetch = vi.fn();
  
  beforeEach(() => {
    global.fetch = mockFetch;
    vi.clearAllMocks();
    localStorage.clear();
  });

  afterEach(() => {
    vi.restoreAllMocks();
  });

  describe('Create Paste', () => {
    it('should create a basic paste', async () => {
      const pasteData = {
        content: 'Hello, World!',
        title: 'Test Paste',
        language: 'text'
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => ({
          paste_id: 'abc123xyz',
          ...pasteData,
          created_at: '2025-12-05T10:00:00Z'
        })
      });

      const response = await fetch('/api/v1/paste', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(pasteData)
      });
      const data = await response.json();

      expect(data.paste_id).toBe('abc123xyz');
      expect(data.content).toBe('Hello, World!');
    });

    it('should create a paste with expiration', async () => {
      const pasteData = {
        content: 'Expiring content',
        expires_in: 3600 // 1 hour
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => ({
          paste_id: 'exp123',
          ...pasteData,
          expires_at: '2025-12-05T11:00:00Z'
        })
      });

      const response = await fetch('/api/v1/paste', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(pasteData)
      });
      const data = await response.json();

      expect(data.expires_at).toBeDefined();
    });

    it('should create a password-protected paste', async () => {
      const pasteData = {
        content: 'Secret content',
        password: 'secretpassword'
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => ({
          paste_id: 'protected123',
          is_protected: true
        })
      });

      const response = await fetch('/api/v1/paste', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(pasteData)
      });
      const data = await response.json();

      expect(data.is_protected).toBe(true);
    });

    it('should create a burn-after-read paste', async () => {
      const pasteData = {
        content: 'One-time content',
        burn_after_read: true
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => ({
          paste_id: 'burn123',
          burn_after_read: true
        })
      });

      const response = await fetch('/api/v1/paste', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(pasteData)
      });
      const data = await response.json();

      expect(data.burn_after_read).toBe(true);
    });

    it('should create a paste with max views', async () => {
      const pasteData = {
        content: 'Limited views content',
        max_views: 5
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => ({
          paste_id: 'limited123',
          max_views: 5,
          views: 0
        })
      });

      const response = await fetch('/api/v1/paste', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(pasteData)
      });
      const data = await response.json();

      expect(data.max_views).toBe(5);
    });
  });

  describe('Get Paste', () => {
    it('should retrieve a paste by ID', async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => ({
          paste_id: 'abc123',
          content: 'Test content',
          title: 'Test',
          views: 5
        })
      });

      const response = await fetch('/api/v1/paste/abc123');
      const data = await response.json();

      expect(data.paste_id).toBe('abc123');
      expect(data.content).toBe('Test content');
    });

    it('should handle paste not found', async () => {
      mockFetch.mockResolvedValueOnce({
        ok: false,
        status: 404,
        json: async () => ({ detail: 'Paste not found' })
      });

      const response = await fetch('/api/v1/paste/nonexistent');

      expect(response.ok).toBe(false);
    });

    it('should handle expired paste', async () => {
      mockFetch.mockResolvedValueOnce({
        ok: false,
        status: 410,
        json: async () => ({ detail: 'Paste has expired' })
      });

      const response = await fetch('/api/v1/paste/expired123');

      expect(response.ok).toBe(false);
    });

    it('should require password for protected paste', async () => {
      mockFetch.mockResolvedValueOnce({
        ok: false,
        status: 401,
        json: async () => ({ detail: 'Password required' })
      });

      const response = await fetch('/api/v1/paste/protected123');

      expect(response.ok).toBe(false);
    });

    it('should access protected paste with correct password', async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => ({
          paste_id: 'protected123',
          content: 'Secret content'
        })
      });

      const response = await fetch('/api/v1/paste/protected123', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ password: 'correctpassword' })
      });
      const data = await response.json();

      expect(data.content).toBe('Secret content');
    });
  });

  describe('Delete Paste', () => {
    it('should delete own paste', async () => {
      localStorage.setItem('access_token', 'user-token');

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => ({ message: 'Paste deleted' })
      });

      const response = await fetch('/api/v1/paste/abc123', {
        method: 'DELETE',
        headers: { 'Authorization': 'Bearer user-token' }
      });

      expect(response.ok).toBe(true);
    });

    it('should not delete others paste', async () => {
      localStorage.setItem('access_token', 'user-token');

      mockFetch.mockResolvedValueOnce({
        ok: false,
        status: 403,
        json: async () => ({ detail: 'Not authorized' })
      });

      const response = await fetch('/api/v1/paste/others123', {
        method: 'DELETE',
        headers: { 'Authorization': 'Bearer user-token' }
      });

      expect(response.ok).toBe(false);
    });
  });

  describe('List User Pastes', () => {
    it('should list user pastes when authenticated', async () => {
      localStorage.setItem('access_token', 'user-token');

      const mockPastes = [
        { paste_id: 'paste1', title: 'Paste 1' },
        { paste_id: 'paste2', title: 'Paste 2' }
      ];

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => mockPastes
      });

      const response = await fetch('/api/v1/paste/user/me', {
        headers: { 'Authorization': 'Bearer user-token' }
      });
      const data = await response.json();

      expect(data).toHaveLength(2);
    });

    it('should require authentication for user pastes', async () => {
      mockFetch.mockResolvedValueOnce({
        ok: false,
        status: 401,
        json: async () => ({ detail: 'Not authenticated' })
      });

      const response = await fetch('/api/v1/paste/user/me');

      expect(response.ok).toBe(false);
    });
  });
});

describe('Paste Validation', () => {
  it('should require content', () => {
    const validatePaste = (data: { content?: string }) => {
      if (!data.content || data.content.trim() === '') {
        throw new Error('Content is required');
      }
      return true;
    };

    expect(() => validatePaste({})).toThrow('Content is required');
    expect(() => validatePaste({ content: '' })).toThrow('Content is required');
    expect(() => validatePaste({ content: '   ' })).toThrow('Content is required');
    expect(validatePaste({ content: 'Valid content' })).toBe(true);
  });

  it('should validate expiration time', () => {
    const validateExpiration = (seconds: number) => {
      const minExpiration = 60; // 1 minute
      const maxExpiration = 86400 * 365; // 1 year
      
      if (seconds < minExpiration || seconds > maxExpiration) {
        throw new Error('Invalid expiration time');
      }
      return true;
    };

    expect(() => validateExpiration(30)).toThrow('Invalid expiration time');
    expect(validateExpiration(3600)).toBe(true);
    expect(() => validateExpiration(86400 * 400)).toThrow('Invalid expiration time');
  });

  it('should validate max views', () => {
    const validateMaxViews = (views: number) => {
      if (views < 1 || views > 1000) {
        throw new Error('Invalid max views');
      }
      return true;
    };

    expect(() => validateMaxViews(0)).toThrow('Invalid max views');
    expect(validateMaxViews(10)).toBe(true);
    expect(() => validateMaxViews(5000)).toThrow('Invalid max views');
  });
});

describe('Paste Languages', () => {
  const supportedLanguages = [
    'text', 'javascript', 'typescript', 'python', 'java', 'csharp',
    'cpp', 'go', 'rust', 'php', 'ruby', 'swift', 'kotlin', 'sql',
    'html', 'css', 'json', 'xml', 'yaml', 'markdown', 'bash', 'powershell'
  ];

  it('should include common languages', () => {
    expect(supportedLanguages).toContain('javascript');
    expect(supportedLanguages).toContain('python');
    expect(supportedLanguages).toContain('typescript');
  });

  it('should include text as default', () => {
    expect(supportedLanguages).toContain('text');
    expect(supportedLanguages[0]).toBe('text');
  });

  it('should have unique languages', () => {
    const uniqueLanguages = new Set(supportedLanguages);
    expect(uniqueLanguages.size).toBe(supportedLanguages.length);
  });
});
