<script lang="ts">
  import { _ } from 'svelte-i18n';
  import { Link, navigate } from 'svelte-routing';
  import { authStore, logout } from '../stores/auth';
  import LanguageSwitcher from './LanguageSwitcher.svelte';
  import ThemeToggle from './ThemeToggle.svelte';
  
  let mobileMenuOpen = false;
  
  function handleLogout() {
    logout();
    navigate('/');
    mobileMenuOpen = false;
  }
  
  function closeMenu() {
    mobileMenuOpen = false;
  }
</script>

<div class="flex flex-col min-h-screen bg-base-200">
  <!-- Navbar -->
  <header class="navbar bg-base-100/80 backdrop-blur-xl border-b border-base-content/5 sticky top-0 z-50 px-4 md:px-6 shadow-sm">
    <!-- Logo -->
    <div class="flex-1">
      <Link to="/" class="flex items-center gap-3 group">
        <div class="relative">
          <div class="absolute -inset-2 bg-gradient-to-r from-primary/20 to-secondary/20 rounded-full blur-lg opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
          <img src="/logo.png" alt="EMTOOLS Logo" class="relative h-10 md:h-11 w-auto group-hover:scale-105 group-hover:rotate-[-3deg] transition-all duration-300" />
        </div>
        <span class="text-xl md:text-2xl font-bold bg-gradient-to-r from-primary via-secondary to-accent bg-clip-text text-transparent group-hover:from-secondary group-hover:to-primary transition-all duration-500">
          {$_('app.name')}
        </span>
      </Link>
    </div>
    
    <!-- Desktop nav -->
    <nav class="hidden md:flex items-center gap-3" aria-label="Main navigation">
      {#if $authStore.isAuthenticated}
        <Link to="/dashboard" class="btn btn-ghost btn-sm gap-2 hover:bg-primary/10 hover:text-primary transition-colors">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z" />
          </svg>
          {$_('nav.tools')}
        </Link>
        <div class="flex items-center gap-2 px-3 py-1.5 rounded-full bg-base-200/80 text-sm">
          <div class="w-6 h-6 rounded-full bg-gradient-to-br from-primary to-secondary flex items-center justify-center text-xs text-white font-bold">
            {($authStore.user?.full_name || $authStore.user?.email || 'U')[0].toUpperCase()}
          </div>
          <span class="text-base-content/80 max-w-[120px] truncate">{$authStore.user?.full_name || $authStore.user?.email}</span>
        </div>
        <button 
          class="btn btn-ghost btn-sm text-base-content/60 hover:text-error hover:bg-error/10" 
          on:click={handleLogout}
          aria-label="Log out of your account"
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
          </svg>
        </button>
      {:else}
        <Link to="/login" class="btn btn-ghost btn-sm gap-2 hover:bg-primary/10 hover:text-primary">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1" />
          </svg>
          {$_('nav.login')}
        </Link>
        <Link to="/register" class="btn btn-primary btn-sm gap-2 shadow-md shadow-primary/25 hover:shadow-lg hover:shadow-primary/30 hover:-translate-y-0.5 transition-all">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z" />
          </svg>
          {$_('nav.register')}
        </Link>
      {/if}
      <div class="w-px h-6 bg-base-content/10 mx-1"></div>
      <ThemeToggle />
      <LanguageSwitcher />
    </nav>
    
    <!-- Mobile menu button -->
    <div class="md:hidden">
      <button 
        class="btn btn-ghost btn-circle"
        on:click={() => mobileMenuOpen = !mobileMenuOpen}
        aria-label={mobileMenuOpen ? 'Close menu' : 'Open menu'}
      >
        <div class="relative w-6 h-6">
          <span class="absolute top-1 left-0 w-6 h-0.5 bg-current rounded transition-all duration-300 {mobileMenuOpen ? 'rotate-45 top-[11px]' : ''}"></span>
          <span class="absolute top-[11px] left-0 w-6 h-0.5 bg-current rounded transition-all duration-300 {mobileMenuOpen ? 'opacity-0' : ''}"></span>
          <span class="absolute bottom-1 left-0 w-6 h-0.5 bg-current rounded transition-all duration-300 {mobileMenuOpen ? '-rotate-45 bottom-[11px]' : ''}"></span>
        </div>
      </button>
    </div>
  </header>
  
  <!-- Mobile dropdown menu -->
  {#if mobileMenuOpen}
    <div class="md:hidden bg-base-100/95 backdrop-blur-xl border-b border-base-content/5 animate-fade-in-down shadow-xl">
      <nav class="flex flex-col p-4 gap-2">
        <Link to="/" class="btn btn-ghost justify-start gap-3 h-12" on:click={closeMenu}>
          <span class="text-lg">🏠</span>
          <span>{$_('nav.home') || 'Home'}</span>
        </Link>
        
        {#if $authStore.isAuthenticated}
          <Link to="/dashboard" class="btn btn-ghost justify-start gap-3 h-12" on:click={closeMenu}>
            <span class="text-lg">🛠️</span>
            <span>{$_('nav.tools')}</span>
          </Link>
          <div class="divider my-2"></div>
          <div class="flex items-center gap-3 px-4 py-3 rounded-xl bg-base-200/50">
            <div class="w-10 h-10 rounded-full bg-gradient-to-br from-primary to-secondary flex items-center justify-center text-white font-bold">
              {($authStore.user?.full_name || $authStore.user?.email || 'U')[0].toUpperCase()}
            </div>
            <div class="flex-1 min-w-0">
              <div class="font-medium truncate">{$authStore.user?.full_name || 'User'}</div>
              <div class="text-sm text-base-content/50 truncate">{$authStore.user?.email}</div>
            </div>
          </div>
          <button 
            class="btn btn-outline btn-error mt-2 gap-2" 
            on:click={handleLogout}
          >
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
            </svg>
            {$_('nav.logout')}
          </button>
        {:else}
          <Link to="/login" class="btn btn-ghost justify-start gap-3 h-12" on:click={closeMenu}>
            <span class="text-lg">🔐</span>
            <span>{$_('nav.login')}</span>
          </Link>
          <Link to="/register" class="btn btn-primary gap-2 h-12 shadow-md" on:click={closeMenu}>
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z" />
            </svg>
            {$_('nav.register')}
          </Link>
        {/if}
        
        <div class="divider my-2"></div>
        <div class="flex items-center justify-between px-2">
          <ThemeToggle />
          <LanguageSwitcher />
        </div>
      </nav>
    </div>
  {/if}
  
  <!-- Main content -->
  <main class="flex-1">
    <slot />
  </main>
  
  <!-- Footer -->
  <footer class="bg-base-100/80 backdrop-blur-sm border-t border-base-content/5">
    <div class="max-w-7xl mx-auto px-4 py-6">
      <div class="flex flex-col md:flex-row items-center justify-between gap-4">
        <div class="flex items-center gap-2 text-base-content/60">
          <span class="font-semibold bg-gradient-to-r from-primary to-secondary bg-clip-text text-transparent">EMTOOLS</span>
          <span>•</span>
          <span>&copy; 2025</span>
        </div>
        <div class="flex items-center gap-4 text-sm text-base-content/50">
          <span>Développé avec ❤️ pour les urgentistes</span>
        </div>
      </div>
    </div>
  </footer>
</div>
