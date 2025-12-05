import { writable } from 'svelte/store';
import { api } from '../api';

export interface User {
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

interface AuthState {
  user: User | null;
  isAuthenticated: boolean;
  isLoading: boolean;
}

const initialState: AuthState = {
  user: null,
  isAuthenticated: false,
  isLoading: true
};

export const authStore = writable<AuthState>(initialState);

export function setAuth(user: User) {
  authStore.set({
    user,
    isAuthenticated: true,
    isLoading: false
  });
}

export function clearAuth() {
  localStorage.removeItem('access_token');
  localStorage.removeItem('refresh_token');
  authStore.set({
    user: null,
    isAuthenticated: false,
    isLoading: false
  });
}

export async function checkAuth() {
  const token = localStorage.getItem('access_token');
  
  if (!token) {
    authStore.set({ ...initialState, isLoading: false });
    return;
  }
  
  try {
    const user = await api.get<User>('/users/me');
    setAuth(user);
  } catch {
    clearAuth();
  }
}

export async function login(email: string, password: string) {
  const formData = new FormData();
  formData.append('username', email);
  formData.append('password', password);
  
  const response = await api.postForm<{ access_token: string; refresh_token: string }>('/auth/login', formData);
  
  localStorage.setItem('access_token', response.access_token);
  localStorage.setItem('refresh_token', response.refresh_token);
  
  await checkAuth();
  return response;
}

export async function register(email: string, username: string, password: string, fullName?: string) {
  const response = await api.post<User>('/auth/register', {
    email,
    username,
    password,
    full_name: fullName
  });
  
  return response;
}

export function logout() {
  clearAuth();
}

export function isAdmin(user: User | null): boolean {
  return user?.role === 'admin' || user?.is_superuser === true;
}
