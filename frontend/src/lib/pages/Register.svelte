<script lang="ts">
  import { _ } from 'svelte-i18n';
  import { navigate, Link } from 'svelte-routing';
  import { register, authStore } from '../stores/auth';
  import { onMount } from 'svelte';
  
  let email = '';
  let username = '';
  let password = '';
  let confirmPassword = '';
  let fullName = '';
  let error = '';
  let isLoading = false;
  
  onMount(() => {
    if ($authStore.isAuthenticated) {
      navigate('/dashboard');
    }
  });
  
  async function handleSubmit() {
    error = '';
    
    if (!username || username.length < 3) {
      error = 'Le nom d\'utilisateur doit contenir au moins 3 caractères';
      return;
    }
    
    if (password !== confirmPassword) {
      error = 'Passwords do not match';
      return;
    }
    
    isLoading = true;
    
    try {
      await register(email, username, password, fullName || undefined);
      navigate('/login');
    } catch (e) {
      error = e instanceof Error ? e.message : $_('auth.registerError');
    } finally {
      isLoading = false;
    }
  }
</script>

<div class="min-h-[90vh] flex items-center justify-center p-4 bg-gradient-to-br from-base-200 via-base-300 to-base-200 relative overflow-hidden">
  <!-- Background decorations -->
  <div class="absolute top-10 right-20 w-72 h-72 bg-secondary/10 rounded-full blur-3xl"></div>
  <div class="absolute bottom-10 left-20 w-96 h-96 bg-primary/10 rounded-full blur-3xl"></div>
  
  <div class="card w-full max-w-md bg-base-100/90 backdrop-blur-sm shadow-2xl border border-base-content/5 relative z-10">
    <div class="card-body">
      <!-- Header with icon -->
      <div class="text-center mb-6">
        <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-secondary/10 mb-4">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-secondary" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z" />
          </svg>
        </div>
        <h2 class="text-2xl font-bold">{$_('auth.register')}</h2>
        <p class="text-base-content/60 mt-1">Créez votre compte EMTOOLS</p>
      </div>
      
      <form on:submit|preventDefault={handleSubmit} class="space-y-4">
        <div class="form-control w-full">
          <label class="label" for="fullName">
            <span class="label-text font-medium">{$_('auth.fullName')}</span>
            <span class="label-text-alt text-base-content/50">Optionnel</span>
          </label>
          <div class="relative">
            <span class="absolute left-3 top-1/2 -translate-y-1/2 text-base-content/40">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
              </svg>
            </span>
            <input
              type="text"
              id="fullName"
              bind:value={fullName}
              disabled={isLoading}
              class="input input-bordered w-full pl-10"
              placeholder="Dr. Jean Dupont"
            />
          </div>
        </div>
        
        <div class="form-control w-full">
          <label class="label" for="username">
            <span class="label-text font-medium">Nom d'utilisateur</span>
          </label>
          <div class="relative">
            <span class="absolute left-3 top-1/2 -translate-y-1/2 text-base-content/40">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0zm6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </span>
            <input
              type="text"
              id="username"
              bind:value={username}
              required
              minlength="3"
              disabled={isLoading}
              class="input input-bordered w-full pl-10"
              placeholder="jeandupont"
            />
          </div>
          <div class="label">
            <span class="label-text-alt text-base-content/50">Minimum 3 caractères, sans espaces</span>
          </div>
        </div>
        
        <div class="form-control w-full">
          <label class="label" for="email">
            <span class="label-text font-medium">{$_('auth.email')}</span>
          </label>
          <div class="relative">
            <span class="absolute left-3 top-1/2 -translate-y-1/2 text-base-content/40">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207" />
              </svg>
            </span>
            <input
              type="email"
              id="email"
              bind:value={email}
              required
              disabled={isLoading}
              class="input input-bordered w-full pl-10"
              placeholder="email@example.com"
            />
          </div>
        </div>
        
        <div class="form-control w-full">
          <label class="label" for="password">
            <span class="label-text font-medium">{$_('auth.password')}</span>
          </label>
          <div class="relative">
            <span class="absolute left-3 top-1/2 -translate-y-1/2 text-base-content/40">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
              </svg>
            </span>
            <input
              type="password"
              id="password"
              bind:value={password}
              required
              minlength="6"
              disabled={isLoading}
              class="input input-bordered w-full pl-10"
              placeholder="••••••••"
            />
          </div>
          <div class="label">
            <span class="label-text-alt text-base-content/50">Minimum 6 caractères</span>
          </div>
        </div>
        
        <div class="form-control w-full">
          <label class="label" for="confirmPassword">
            <span class="label-text font-medium">{$_('auth.confirmPassword')}</span>
          </label>
          <div class="relative">
            <span class="absolute left-3 top-1/2 -translate-y-1/2 text-base-content/40">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
              </svg>
            </span>
            <input
              type="password"
              id="confirmPassword"
              bind:value={confirmPassword}
              required
              disabled={isLoading}
              class="input input-bordered w-full pl-10"
              placeholder="••••••••"
            />
          </div>
        </div>
        
        {#if error}
          <div class="alert alert-error shadow-lg">
            <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current shrink-0 h-6 w-6" fill="none" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <span>{error}</span>
          </div>
        {/if}
        
        <button 
          type="submit" 
          class="btn btn-secondary w-full mt-6 shadow-lg shadow-secondary/25 hover:shadow-xl hover:shadow-secondary/30 hover:-translate-y-0.5 transition-all"
          class:loading={isLoading}
          disabled={isLoading}
        >
          {#if isLoading}
            <span class="loading loading-spinner"></span>
          {/if}
          {isLoading ? $_('common.loading') : $_('auth.register')}
        </button>
      </form>
      
      <div class="divider text-base-content/40">OU</div>
      
      <p class="text-center text-base-content/70">
        {$_('auth.hasAccount')} 
        <Link to="/login" class="link link-primary font-medium">{$_('auth.login')}</Link>
      </p>
    </div>
  </div>
</div>
