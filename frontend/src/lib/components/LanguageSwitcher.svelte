<script lang="ts">
  import { locale } from 'svelte-i18n';
  
  const languages = [
    { code: 'en', label: '🇬🇧', name: 'English' },
    { code: 'fr', label: '🇫🇷', name: 'Français' }
  ];
  
  function changeLanguage(code: string) {
    locale.set(code);
    localStorage.setItem('locale', code);
  }
</script>

<div class="dropdown dropdown-end">
  <div tabindex="0" role="button" class="btn btn-ghost btn-ghost-contrast btn-sm gap-1">
    <span class="text-lg">{languages.find(l => l.code === $locale)?.label || '🌐'}</span>
    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
    </svg>
  </div>
  <!-- svelte-ignore a11y-no-noninteractive-tabindex -->
  <ul tabindex="0" class="dropdown-content z-[1] menu p-2 shadow-lg bg-base-200 rounded-box w-40">
    {#each languages as lang}
      <li>
        <button 
          class="flex items-center gap-2" 
          class:active={$locale === lang.code}
          on:click={() => changeLanguage(lang.code)}
        >
          <span class="text-lg">{lang.label}</span>
          <span>{lang.name}</span>
        </button>
      </li>
    {/each}
  </ul>
</div>
