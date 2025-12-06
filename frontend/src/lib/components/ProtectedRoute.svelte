<script lang="ts">
  import { navigate } from 'svelte-routing';
  import { authStore } from '../stores/auth';
  import Lazy from './Lazy.svelte';
  import type { ComponentType, SvelteComponent } from 'svelte';

  export let component: ComponentType<SvelteComponent> | null = null;
  export let loader: (() => Promise<{ default: ComponentType<SvelteComponent> }>) | null = null;

  // Only redirect when auth check is complete (not loading) and user is not authenticated
  $: if (!$authStore.isLoading && !$authStore.isAuthenticated && typeof window !== 'undefined') {
    navigate('/login', { replace: true });
  }
</script>

{#if $authStore.isLoading}
  <div class="loading-auth">
    <div class="spinner"></div>
    <p>Checking authentication...</p>
  </div>
{:else if $authStore.isAuthenticated}
  {#if component}
    <svelte:component this={component} />
  {:else if loader}
    <Lazy {loader} />
  {/if}
{:else}
  <div class="loading-auth">
    <p>Redirecting to login...</p>
  </div>
{/if}

<style>
  .loading-auth {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    min-height: 50vh;
    color: #888;
    gap: 1rem;
  }
  
  .spinner {
    width: 40px;
    height: 40px;
    border: 3px solid rgba(100, 108, 255, 0.2);
    border-top-color: #646cff;
    border-radius: 50%;
    animation: spin 1s linear infinite;
  }
  
  @keyframes spin {
    to { transform: rotate(360deg); }
  }
</style>
