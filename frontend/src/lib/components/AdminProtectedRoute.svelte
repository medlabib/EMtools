<script lang="ts">
  import { navigate } from 'svelte-routing';
  import { authStore, isAdmin } from '../stores/auth';
  import type { ComponentType, SvelteComponent } from 'svelte';
  import Lazy from './Lazy.svelte';

  export let component: ComponentType<SvelteComponent> | null = null;
  export let loader: (() => Promise<{ default: ComponentType<SvelteComponent> }>) | null = null;
  
  $: if ($authStore.isAuthenticated !== undefined && !$authStore.isAuthenticated) {
    navigate('/login', { replace: true });
  } else if ($authStore.isAuthenticated && !isAdmin($authStore.user)) {
    navigate('/dashboard', { replace: true });
  }
</script>

{#if $authStore.isAuthenticated && isAdmin($authStore.user)}
  {#if component}
    <svelte:component this={component} />
  {:else if loader}
    <Lazy {loader} />
  {/if}
{:else if $authStore.isAuthenticated === undefined}
  <div class="flex justify-center items-center h-64">
    <span class="loading loading-spinner loading-lg text-primary"></span>
  </div>
{/if}
