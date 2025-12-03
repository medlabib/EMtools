<script lang="ts">
  import { _ } from 'svelte-i18n';
  import { Link } from 'svelte-routing';
</script>

<div class="min-h-[60vh] flex flex-col items-center justify-center text-center p-4">
  <div class="text-9xl font-bold bg-gradient-to-r from-primary to-error bg-clip-text text-transparent mb-4">
    404
  </div>
  <p class="text-2xl text-base-content/60 mb-8">Page non trouvée</p>
  <Link to="/" class="btn btn-primary btn-lg gap-2">
    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
    </svg>
    {$_('nav.home') || 'Accueil'}
  </Link>
</div>
