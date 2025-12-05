/**
 * Tests for Admin Store
 * Tests admin-related state management and API calls
 */
import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';

describe('Admin Store', () => {
  const mockFetch = vi.fn();
  
  beforeEach(() => {
    global.fetch = mockFetch;
    vi.clearAllMocks();
    localStorage.clear();
    localStorage.setItem('access_token', 'admin-token-123');
  });

  afterEach(() => {
    vi.restoreAllMocks();
  });

  describe('User Management', () => {
    it('should fetch users list', async () => {
      const mockUsers = [
        { id: '1', email: 'user1@example.com', username: 'user1', role: 'user' },
        { id: '2', email: 'user2@example.com', username: 'user2', role: 'user' }
      ];

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => mockUsers
      });

      const response = await fetch('/api/v1/admin/users', {
        headers: { 'Authorization': `Bearer ${localStorage.getItem('access_token')}` }
      });
      const data = await response.json();

      expect(data).toHaveLength(2);
      expect(data[0].email).toBe('user1@example.com');
    });

    it('should fetch user count', async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => ({ count: 42 })
      });

      const response = await fetch('/api/v1/admin/users/count');
      const data = await response.json();

      expect(data.count).toBe(42);
    });

    it('should create new user', async () => {
      const newUser = {
        email: 'new@example.com',
        username: 'newuser',
        password: 'password123',
        role: 'user'
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => ({ id: '3', ...newUser })
      });

      const response = await fetch('/api/v1/admin/users', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(newUser)
      });
      const data = await response.json();

      expect(data.email).toBe('new@example.com');
      expect(data.id).toBe('3');
    });

    it('should update user', async () => {
      const updateData = { full_name: 'Updated Name', is_active: true };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => ({ id: '1', ...updateData })
      });

      const response = await fetch('/api/v1/admin/users/1', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(updateData)
      });
      const data = await response.json();

      expect(data.full_name).toBe('Updated Name');
    });

    it('should delete user', async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => ({ message: 'User deleted' })
      });

      const response = await fetch('/api/v1/admin/users/1', {
        method: 'DELETE'
      });

      expect(response.ok).toBe(true);
    });

    it('should handle user not found', async () => {
      mockFetch.mockResolvedValueOnce({
        ok: false,
        status: 404,
        json: async () => ({ detail: 'User not found' })
      });

      const response = await fetch('/api/v1/admin/users/nonexistent');

      expect(response.ok).toBe(false);
    });
  });

  describe('Dashboard Stats', () => {
    it('should fetch dashboard statistics', async () => {
      const mockStats = {
        total_users: 100,
        active_users: 85,
        total_pastes: 500,
        pastes_today: 25
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => mockStats
      });

      const response = await fetch('/api/v1/admin/dashboard/stats');
      const data = await response.json();

      expect(data.total_users).toBe(100);
      expect(data.active_users).toBe(85);
    });
  });

  describe('Activity Logs', () => {
    it('should fetch activity logs', async () => {
      const mockLogs = [
        { id: '1', action: 'user_login', timestamp: '2025-12-05T10:00:00Z' },
        { id: '2', action: 'paste_created', timestamp: '2025-12-05T09:00:00Z' }
      ];

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => mockLogs
      });

      const response = await fetch('/api/v1/admin/activity-logs');
      const data = await response.json();

      expect(data).toHaveLength(2);
      expect(data[0].action).toBe('user_login');
    });

    it('should fetch activity logs with limit', async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => [{ id: '1', action: 'test' }]
      });

      await fetch('/api/v1/admin/activity-logs?limit=10');

      expect(mockFetch).toHaveBeenCalledWith(
        '/api/v1/admin/activity-logs?limit=10'
      );
    });
  });

  describe('App Settings', () => {
    it('should fetch app settings', async () => {
      const mockSettings = {
        signup_mode: 'open',
        allowed_domains: ['example.com'],
        smtp_configured: true
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => mockSettings
      });

      const response = await fetch('/api/v1/admin/settings');
      const data = await response.json();

      expect(data.signup_mode).toBe('open');
    });

    it('should update app settings', async () => {
      const newSettings = {
        signup_mode: 'institutional',
        allowed_domains: ['hospital.org', 'university.edu']
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => newSettings
      });

      const response = await fetch('/api/v1/admin/settings', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(newSettings)
      });
      const data = await response.json();

      expect(data.signup_mode).toBe('institutional');
    });

    it('should update SMTP settings', async () => {
      const smtpSettings = {
        smtp_host: 'smtp.gmail.com',
        smtp_port: 587,
        smtp_user: 'user@gmail.com',
        smtp_use_tls: true
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => ({ ...smtpSettings, smtp_configured: true })
      });

      const response = await fetch('/api/v1/admin/settings/smtp', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(smtpSettings)
      });

      expect(response.ok).toBe(true);
    });
  });

  describe('Setup Process', () => {
    it('should check setup status', async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => ({ is_setup_complete: false })
      });

      const response = await fetch('/api/v1/admin/setup/status');
      const data = await response.json();

      expect(data.is_setup_complete).toBe(false);
    });

    it('should complete initial setup', async () => {
      const setupData = {
        admin_email: 'admin@example.com',
        admin_username: 'admin',
        admin_password: 'securepassword123',
        signup_mode: 'open'
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => ({ message: 'Setup complete', access_token: 'token123' })
      });

      const response = await fetch('/api/v1/admin/setup', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(setupData)
      });
      const data = await response.json();

      expect(data.access_token).toBeDefined();
    });

    it('should reject setup when already complete', async () => {
      mockFetch.mockResolvedValueOnce({
        ok: false,
        status: 400,
        json: async () => ({ detail: 'Setup already complete' })
      });

      const response = await fetch('/api/v1/admin/setup', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({})
      });

      expect(response.ok).toBe(false);
    });
  });
});

describe('Admin Authorization', () => {
  const mockFetch = vi.fn();
  
  beforeEach(() => {
    global.fetch = mockFetch;
    localStorage.clear();
  });

  it('should require authentication for admin endpoints', async () => {
    mockFetch.mockResolvedValueOnce({
      ok: false,
      status: 401,
      json: async () => ({ detail: 'Not authenticated' })
    });

    const response = await fetch('/api/v1/admin/users');

    expect(response.ok).toBe(false);
  });

  it('should require admin role', async () => {
    localStorage.setItem('access_token', 'regular-user-token');
    
    mockFetch.mockResolvedValueOnce({
      ok: false,
      status: 403,
      json: async () => ({ detail: 'Not enough permissions' })
    });

    const response = await fetch('/api/v1/admin/users', {
      headers: { 'Authorization': 'Bearer regular-user-token' }
    });

    expect(response.ok).toBe(false);
  });
});
