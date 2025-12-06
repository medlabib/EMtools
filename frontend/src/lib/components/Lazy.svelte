<script lang="ts">
  import { onMount } from 'svelte';
  import type { ComponentType, SvelteComponent } from 'svelte';

  export let loader: () => Promise<{ default: ComponentType<SvelteComponent> }>;
  export let props: Record<string, any> = {};

  let component: ComponentType<SvelteComponent> | undefined;

  onMount(async () => {
    const module = await loader();
    component = module.default;
  });
</script>

{#if component}
  <svelte:component this={component} {...props} />
{:else}
  <div class="flex justify-center items-center h-64">
    <span class="loading loading-spinner loading-lg text-primary"></span>
  </div>
{/if}
