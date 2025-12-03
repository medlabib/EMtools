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

<div class="min-h-[60vh] flex items-center justify-center p-4">
  <div class="card w-full max-w-md bg-base-100 shadow-xl">
    <div class="card-body">
      <h2 class="card-title text-2xl font-bold justify-center mb-6">{$_('auth.login')}</h2>
      
      <form on:submit|preventDefault={handleSubmit} class="space-y-4">
        <div class="form-control w-full">
          <label class="label" for="email">
            <span class="label-text">{$_('auth.email')}</span>
          </label>
          <input
            type="email"
            id="email"
            bind:value={email}
            required
            disabled={isLoading}
            class="input input-bordered w-full"
            placeholder="email@example.com"
          />
        </div>
        
        <div class="form-control w-full">
          <label class="label" for="password">
            <span class="label-text">{$_('auth.password')}</span>
          </label>
          <input
            type="password"
            id="password"
            bind:value={password}
            required
            disabled={isLoading}
            class="input input-bordered w-full"
            placeholder="********"
          />
        </div>
        
        {#if error}
          <div class="alert alert-error">
            <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current shrink-0 h-6 w-6" fill="none" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <span>{error}</span>
          </div>
        {/if}
        
        <button 
          type="submit" 
          class="btn btn-primary w-full mt-4"
          class:loading={isLoading}
          disabled={isLoading}
        >
          {#if isLoading}
            <span class="loading loading-spinner"></span>
          {/if}
          {isLoading ? $_('common.loading') : $_('auth.login')}
        </button>
      </form>
      
      <div class="divider">OU</div>
      
      <p class="text-center text-base-content/70">
        {$_('auth.noAccount')} 
        <Link to="/register" class="link link-primary">{$_('auth.register')}</Link>
      </p>
    </div>
  </div>
</div>
