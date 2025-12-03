<script lang="ts">
  import { _ } from 'svelte-i18n';
  import { navigate, Link } from 'svelte-routing';
  import { login, authStore } from '../stores/auth';
  import { onMount } from 'svelte';
  
  let email = '';
  let password = '';
  let error = '';
  let isLoading = false;
  
  onMount(() => {
    if ($authStore.isAuthenticated) {
      navigate('/dashboard');
    }
  });
  
  async function handleSubmit() {
    error = '';
    isLoading = true;
    
    try {
      await login(email, password);
      navigate('/dashboard');
    } catch (e) {
      error = e instanceof Error ? e.message : $_('auth.loginError');
    } finally {
      isLoading = false;
    }
  }
</script>

<div class="min-h-[80vh] flex items-center justify-center p-4 bg-gradient-to-br from-base-200 via-base-300 to-base-200 relative overflow-hidden">
  <!-- Background decorations -->
  <div class="absolute top-20 left-10 w-72 h-72 bg-primary/10 rounded-full blur-3xl"></div>
  <div class="absolute bottom-20 right-10 w-96 h-96 bg-secondary/10 rounded-full blur-3xl"></div>
  
  <div class="card w-full max-w-md bg-base-100/90 backdrop-blur-sm shadow-2xl border border-base-content/5 relative z-10">
    <div class="card-body">
      <!-- Header with icon -->
      <div class="text-center mb-6">
        <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-primary/10 mb-4">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-primary" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1" />
          </svg>
        </div>
        <h2 class="text-2xl font-bold">{$_('auth.login')}</h2>
        <p class="text-base-content/60 mt-1">Accédez à vos outils médicaux</p>
      </div>
      
      <form on:submit|preventDefault={handleSubmit} class="space-y-4">
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
          class="btn btn-primary w-full mt-6 shadow-lg shadow-primary/25 hover:shadow-xl hover:shadow-primary/30 hover:-translate-y-0.5 transition-all"
          class:loading={isLoading}
          disabled={isLoading}
        >
          {#if isLoading}
            <span class="loading loading-spinner"></span>
          {/if}
          {isLoading ? $_('common.loading') : $_('auth.login')}
        </button>
      </form>
      
      <div class="divider text-base-content/40">OU</div>
      
      <p class="text-center text-base-content/70">
        {$_('auth.noAccount')} 
        <Link to="/register" class="link link-primary font-medium">{$_('auth.register')}</Link>
      </p>
    </div>
  </div>
</div>
