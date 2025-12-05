import { writable } from 'svelte/store';
import { api } from '../api';

// Types
export type SignupMode = 'open' | 'institutional' | 'closed';

export interface SetupStatus {
  is_setup_complete: boolean;
  has_admin: boolean;
  message: string;
}

export interface AppSettings {
  signup_mode: SignupMode;
  allowed_email_domains: string[];
  smtp_configured: boolean;
  smtp_host: string | null;
  smtp_port: number | null;
  smtp_from_email: string | null;
  smtp_use_tls: boolean | null;
  is_setup_complete: boolean;
  setup_at: string | null;
}

export interface ActivityLog {
  id: string;
  user_id: string | null;
  user_email: string | null;
  action: string;
  resource_type: string | null;
  resource_id: string | null;
  details: Record<string, unknown> | null;
  ip_address: string | null;
  user_agent: string | null;
  created_at: string;
}

export interface DashboardStats {
  total_users: number;
  active_users: number;
  admin_users: number;
  verified_users: number;
  recent_activities: number;
  signup_mode: SignupMode;
  smtp_configured: boolean;
}

export interface AdminUser {
  id: string;
  email: string;
  username: string;
  full_name: string | null;
  is_active: boolean;
  is_verified: boolean;
  is_superuser: boolean;
  role: 'admin' | 'user';
  created_at: string;
}

// Stores
export const setupStatus = writable<SetupStatus | null>(null);
export const appSettings = writable<AppSettings | null>(null);
export const dashboardStats = writable<DashboardStats | null>(null);
export const activityLogs = writable<ActivityLog[]>([]);
export const adminUsers = writable<AdminUser[]>([]);

// API Functions
export async function checkSetupStatus(): Promise<SetupStatus> {
  const status = await api.get<SetupStatus>('/admin/setup/status');
  setupStatus.set(status);
  return status;
}

export interface SetupRequest {
  admin_email: string;
  admin_username: string;
  admin_password: string;
  signup_mode?: SignupMode;
  allowed_email_domains?: string[];
  smtp_settings?: {
    smtp_host: string;
    smtp_port: number;
    smtp_user: string;
    smtp_password: string;
    smtp_from_email: string;
    smtp_use_tls: boolean;
  };
}

export interface SetupRequestInput {
  admin_email: string;
  admin_username: string;
  admin_password: string;
  signup_mode?: SignupMode;
  allowed_email_domains?: string[];
  smtp_host?: string;
  smtp_port?: number;
  smtp_user?: string;
  smtp_password?: string;
  smtp_from_email?: string;
  smtp_use_tls?: boolean;
}

export async function performInitialSetup(input: SetupRequestInput): Promise<SetupStatus> {
  // Format SMTP settings as nested object if provided
  const data: SetupRequest = {
    admin_email: input.admin_email,
    admin_username: input.admin_username,
    admin_password: input.admin_password,
    signup_mode: input.signup_mode,
    allowed_email_domains: input.allowed_email_domains,
  };
  
  if (input.smtp_host && input.smtp_user && input.smtp_password && input.smtp_from_email) {
    data.smtp_settings = {
      smtp_host: input.smtp_host,
      smtp_port: input.smtp_port ?? 587,
      smtp_user: input.smtp_user,
      smtp_password: input.smtp_password,
      smtp_from_email: input.smtp_from_email,
      smtp_use_tls: input.smtp_use_tls ?? true,
    };
  }
  
  const status = await api.post<SetupStatus>('/admin/setup', data);
  setupStatus.set(status);
  return status;
}

// Alias for compatibility
export const performSetup = performInitialSetup;

export async function fetchSettings(): Promise<AppSettings> {
  const settings = await api.get<AppSettings>('/admin/settings');
  appSettings.set(settings);
  return settings;
}

export async function updateSettings(data: Partial<AppSettings>): Promise<AppSettings> {
  const settings = await api.patch<AppSettings>('/admin/settings', data);
  appSettings.set(settings);
  return settings;
}

export async function updateSmtpSettings(data: {
  smtp_host: string;
  smtp_port: number;
  smtp_user: string;
  smtp_password: string;
  smtp_from_email: string;
  smtp_use_tls: boolean;
}): Promise<AppSettings> {
  const settings = await api.put<AppSettings>('/admin/settings/smtp', data);
  appSettings.set(settings);
  return settings;
}

export async function testSmtpSettings(): Promise<{ status: string; message: string }> {
  return api.post('/admin/settings/smtp/test', {});
}

export async function fetchDashboardStats(): Promise<DashboardStats> {
  const stats = await api.get<DashboardStats>('/admin/dashboard/stats/v2');
  dashboardStats.set(stats);
  return stats;
}

export async function fetchActivityLogs(
  limit?: number,
  skip?: number,
  action?: string,
  user_id?: string,
  resource_type?: string
): Promise<{ logs: ActivityLog[]; total: number }> {
  const queryParams = new URLSearchParams();
  if (skip !== undefined) queryParams.set('skip', skip.toString());
  if (limit !== undefined) queryParams.set('limit', limit.toString());
  if (user_id) queryParams.set('user_id', user_id);
  if (action) queryParams.set('action', action);
  if (resource_type) queryParams.set('resource_type', resource_type);
  
  const url = `/admin/logs${queryParams.toString() ? '?' + queryParams.toString() : ''}`;
  const logs = await api.get<ActivityLog[]>(url);
  activityLogs.set(logs);
  
  // Get total count
  const total = await fetchActivityLogsCount({ user_id, action, resource_type });
  
  return { logs, total };
}

export async function fetchActivityLogsCount(params?: {
  user_id?: string;
  action?: string;
  resource_type?: string;
}): Promise<number> {
  const queryParams = new URLSearchParams();
  if (params?.user_id) queryParams.set('user_id', params.user_id);
  if (params?.action) queryParams.set('action', params.action);
  if (params?.resource_type) queryParams.set('resource_type', params.resource_type);
  
  const url = `/admin/logs/count${queryParams.toString() ? '?' + queryParams.toString() : ''}`;
  const result = await api.get<{ count: number }>(url);
  return result.count;
}

export async function fetchUsers(params?: {
  skip?: number;
  limit?: number;
  role?: 'admin' | 'user';
  is_active?: boolean;
}): Promise<AdminUser[]> {
  const queryParams = new URLSearchParams();
  if (params?.skip !== undefined) queryParams.set('skip', params.skip.toString());
  if (params?.limit !== undefined) queryParams.set('limit', params.limit.toString());
  if (params?.role) queryParams.set('role', params.role);
  if (params?.is_active !== undefined) queryParams.set('is_active', params.is_active.toString());
  
  const url = `/admin/users${queryParams.toString() ? '?' + queryParams.toString() : ''}`;
  const users = await api.get<AdminUser[]>(url);
  adminUsers.set(users);
  return users;
}

export async function fetchUsersCount(params?: {
  role?: 'admin' | 'user';
  is_active?: boolean;
}): Promise<number> {
  const queryParams = new URLSearchParams();
  if (params?.role) queryParams.set('role', params.role);
  if (params?.is_active !== undefined) queryParams.set('is_active', params.is_active.toString());
  
  const url = `/admin/users/count${queryParams.toString() ? '?' + queryParams.toString() : ''}`;
  const result = await api.get<{ count: number }>(url);
  return result.count;
}

export async function fetchUser(userId: string): Promise<AdminUser> {
  return api.get<AdminUser>(`/admin/users/${userId}`);
}

export async function createUser(data: {
  email: string;
  username: string;
  password: string;
  role?: 'admin' | 'user';
  is_verified?: boolean;
  is_active?: boolean;
}): Promise<AdminUser> {
  const user = await api.post<AdminUser>('/admin/users', data);
  // Refresh users list
  await fetchUsers();
  return user;
}

export async function updateUser(userId: string, data: {
  email?: string;
  username?: string;
  password?: string;
  role?: 'admin' | 'user';
  is_verified?: boolean;
  is_active?: boolean;
}): Promise<AdminUser> {
  const user = await api.patch<AdminUser>(`/admin/users/${userId}`, data);
  // Refresh users list
  await fetchUsers();
  return user;
}

export async function deleteUser(userId: string): Promise<void> {
  await api.delete(`/admin/users/${userId}`);
  // Refresh users list
  await fetchUsers();
}
