<script lang="ts">
  import { onMount } from 'svelte';
  import { navigate } from 'svelte-routing';
  import { authStore, isAdmin } from '../../stores/auth';
  import { fetchActivityLogs, type ActivityLog } from '../../stores/admin';

  let logs: ActivityLog[] = [];
  let loading = true;
  let error = '';

  // Filters
  let actionFilter = '';
  let searchQuery = '';
  let currentPage = 1;
  let totalLogs = 0;
  const logsPerPage = 20;
  
  // Details modal
  let selectedLog: ActivityLog | null = null;
  let showDetailsModal = false;

  $: totalPages = Math.ceil(totalLogs / logsPerPage);
  
  // Filter logs by search query (client-side)
  $: filteredLogs = logs.filter(log => {
    if (!searchQuery) return true;
    const query = searchQuery.toLowerCase();
    return (
      log.user_email?.toLowerCase().includes(query) ||
      log.action.toLowerCase().includes(query) ||
      log.ip_address?.toLowerCase().includes(query)
    );
  });

  onMount(async () => {
    if (!$authStore.isAuthenticated || !isAdmin($authStore.user)) {
      navigate('/login');
      return;
    }
    await loadLogs();
  });

  async function loadLogs() {
    loading = true;
    error = '';
    try {
      const skip = (currentPage - 1) * logsPerPage;
      const result = await fetchActivityLogs(logsPerPage, skip, actionFilter || undefined);
      logs = result.logs;
      totalLogs = result.total;
    } catch (e) {
      error = e instanceof Error ? e.message : 'Failed to load logs';
    } finally {
      loading = false;
    }
  }

  async function handleFilterChange() {
    currentPage = 1;
    await loadLogs();
  }

  async function goToPage(page: number) {
    if (page < 1 || page > totalPages) return;
    currentPage = page;
    await loadLogs();
  }
  
  function showDetails(log: ActivityLog) {
    selectedLog = log;
    showDetailsModal = true;
  }
  
  function closeDetailsModal() {
    showDetailsModal = false;
    selectedLog = null;
  }
  
  async function exportLogs() {
    // Export visible logs as CSV
    const headers = ['Date', 'Action', 'Utilisateur', 'IP', 'Détails'];
    const rows = filteredLogs.map(log => [
      formatDate(log.created_at),
      log.action,
      log.user_email || 'Anonyme',
      log.ip_address || '-',
      log.details ? JSON.stringify(log.details) : ''
    ]);
    
    const csvContent = [
      headers.join(','),
      ...rows.map(row => row.map(cell => `"${cell}"`).join(','))
    ].join('\n');
    
    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.href = url;
    link.download = `activity-logs-${new Date().toISOString().split('T')[0]}.csv`;
    link.click();
    URL.revokeObjectURL(url);
  }

  function formatDate(date: string): string {
    return new Date(date).toLocaleString('fr-FR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit'
    });
  }
  
  function formatRelativeDate(date: string): string {
    const now = new Date();
    const logDate = new Date(date);
    const diffMs = now.getTime() - logDate.getTime();
    const diffMins = Math.floor(diffMs / 60000);
    const diffHours = Math.floor(diffMs / 3600000);
    const diffDays = Math.floor(diffMs / 86400000);
    
    if (diffMins < 1) return 'À l\'instant';
    if (diffMins < 60) return `Il y a ${diffMins} min`;
    if (diffHours < 24) return `Il y a ${diffHours}h`;
    if (diffDays < 7) return `Il y a ${diffDays}j`;
    return formatDate(date);
  }

  function getActionBadge(action: string): { class: string; label: string; icon: string } {
    const actionMap: Record<string, { class: string; label: string; icon: string }> = {
      'login': { class: 'badge-info', label: 'Connexion', icon: '→' },
      'logout': { class: 'badge-secondary', label: 'Déconnexion', icon: '←' },
      'register': { class: 'badge-success', label: 'Inscription', icon: '+' },
      'initial_setup': { class: 'badge-primary', label: 'Config initiale', icon: '⚙' },
      'settings_update': { class: 'badge-warning', label: 'Paramètres', icon: '⚙' },
      'smtp_update': { class: 'badge-warning', label: 'SMTP', icon: '✉' },
      'user_created': { class: 'badge-success', label: 'Utilisateur créé', icon: '+' },
      'user_updated': { class: 'badge-info', label: 'Utilisateur MAJ', icon: '✎' },
      'user_deleted': { class: 'badge-error', label: 'Utilisateur supprimé', icon: '✕' },
      'password_reset': { class: 'badge-warning', label: 'MDP réinitialisé', icon: '🔑' },
    };
    return actionMap[action] || { class: 'badge-ghost', label: action, icon: '•' };
  }
  
  // Get action categories for grouping
  const actionCategories = [
    { label: 'Authentification', actions: ['login', 'logout', 'register', 'password_reset'] },
    { label: 'Administration', actions: ['initial_setup', 'settings_update', 'smtp_update'] },
    { label: 'Utilisateurs', actions: ['user_created', 'user_updated', 'user_deleted'] },
  ];
</script>

<div class="min-h-screen bg-base-200">
  <!-- Header -->
  <div class="bg-base-100 shadow-sm border-b border-base-300">
    <div class="container mx-auto px-4 py-4">
      <div class="flex items-center gap-3">
  <a href="/admin" class="btn btn-ghost btn-ghost-contrast btn-sm btn-square">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
          </svg>
        </a>
        <div>
          <h1 class="text-2xl font-bold">Journaux d'activité</h1>
          <p class="text-base-content/60 text-sm">Historique des actions système</p>
        </div>
      </div>
    </div>
  </div>

  <div class="container mx-auto px-4 py-6">
    {#if error}
      <div class="alert alert-error mb-4">
        <span>{error}</span>
  <button class="btn btn-ghost btn-ghost-contrast btn-sm" on:click={() => error = ''}>✕</button>
      </div>
    {/if}

    <!-- Filters -->
    <div class="card bg-base-100 shadow-sm mb-4">
      <div class="card-body py-3">
        <div class="flex flex-wrap items-center gap-3">
          <!-- Search -->
          <div class="form-control flex-1 min-w-[200px]">
            <div class="relative">
              <input 
                type="text" 
                class="input input-bordered input-sm w-full pl-9" 
                placeholder="Rechercher (email, IP...)"
                bind:value={searchQuery}
              />
              <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 absolute left-3 top-1/2 -translate-y-1/2 text-base-content/40" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
              </svg>
            </div>
          </div>
          
          <!-- Action filter -->
          <div class="form-control">
            <select class="select select-bordered select-sm" bind:value={actionFilter} on:change={handleFilterChange}>
              <option value="">Toutes les actions</option>
              {#each actionCategories as category}
                <optgroup label={category.label}>
                  {#each category.actions as action}
                    {@const badge = getActionBadge(action)}
                    <option value={action}>{badge.label}</option>
                  {/each}
                </optgroup>
              {/each}
            </select>
          </div>
          
          <div class="flex items-center gap-2 ml-auto">
            <span class="text-sm text-base-content/60">
              {filteredLogs.length}/{totalLogs} entrée{totalLogs !== 1 ? 's' : ''}
            </span>
            
            <button 
              class="btn btn-ghost btn-ghost-contrast btn-sm tooltip tooltip-bottom" 
              data-tip="Exporter CSV"
              on:click={exportLogs}
              disabled={filteredLogs.length === 0}
            >
              <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
              </svg>
            </button>

            <button 
              class="btn btn-ghost btn-ghost-contrast btn-sm tooltip tooltip-bottom" 
              data-tip="Actualiser"
              on:click={loadLogs}
            >
              <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
              </svg>
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Logs List -->
    <div class="card bg-base-100 shadow-sm">
      {#if loading}
        <div class="card-body">
          <div class="flex justify-center items-center h-32">
            <span class="loading loading-spinner loading-lg text-primary"></span>
          </div>
        </div>
      {:else if filteredLogs.length === 0}
        <div class="card-body">
          <div class="text-center py-8 text-base-content/60">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12 mx-auto mb-3 opacity-40" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
            </svg>
            <p>Aucun journal trouvé</p>
            {#if searchQuery}
              <button class="btn btn-sm btn-ghost btn-ghost-contrast mt-2" on:click={() => searchQuery = ''}>Effacer la recherche</button>
            {/if}
          </div>
        </div>
      {:else}
        <div class="overflow-x-auto">
          <table class="table">
            <thead>
              <tr>
                <th>Date</th>
                <th>Action</th>
                <th>Utilisateur</th>
                <th>Détails</th>
                <th>IP</th>
              </tr>
            </thead>
            <tbody>
              {#each filteredLogs as log}
                {@const actionBadge = getActionBadge(log.action)}
                <tr class="hover cursor-pointer" on:click={() => showDetails(log)}>
                  <td class="whitespace-nowrap">
                    <div class="text-sm font-medium">{formatRelativeDate(log.created_at)}</div>
                    <div class="text-xs text-base-content/50">{formatDate(log.created_at)}</div>
                  </td>
                  <td>
                    <span class="badge {actionBadge.class} badge-sm gap-1">
                      <span class="text-xs">{actionBadge.icon}</span>
                      {actionBadge.label}
                    </span>
                  </td>
                  <td>
                    {#if log.user_email}
                      <div class="text-sm font-medium">{log.user_email}</div>
                    {:else}
                      <span class="text-base-content/40 text-sm">Anonyme</span>
                    {/if}
                  </td>
                  <td>
                    {#if log.details && Object.keys(log.details).length > 0}
                      <span class="badge badge-ghost badge-sm">
                        {Object.keys(log.details).length} champ{Object.keys(log.details).length > 1 ? 's' : ''}
                      </span>
                    {:else}
                      <span class="text-base-content/40 text-sm">—</span>
                    {/if}
                  </td>
                  <td class="text-sm text-base-content/60 font-mono">
                    {log.ip_address || '—'}
                  </td>
                </tr>
              {/each}
            </tbody>
          </table>
        </div>

        <!-- Pagination -->
        {#if totalPages > 1}
          <div class="card-body pt-0">
            <div class="flex justify-center">
              <div class="join">
                <button 
                  class="join-item btn btn-sm" 
                  disabled={currentPage === 1}
                  on:click={() => goToPage(1)}
                >
                  «
                </button>
                <button 
                  class="join-item btn btn-sm" 
                  disabled={currentPage === 1}
                  on:click={() => goToPage(currentPage - 1)}
                >
                  ‹
                </button>
                
                {#each Array(Math.min(5, totalPages)) as _, i}
                  {@const pageNum = Math.max(1, Math.min(currentPage - 2, totalPages - 4)) + i}
                  {#if pageNum <= totalPages}
                    <button 
                      class="join-item btn btn-sm"
                      class:btn-active={pageNum === currentPage}
                      on:click={() => goToPage(pageNum)}
                    >
                      {pageNum}
                    </button>
                  {/if}
                {/each}
                
                <button 
                  class="join-item btn btn-sm" 
                  disabled={currentPage === totalPages}
                  on:click={() => goToPage(currentPage + 1)}
                >
                  ›
                </button>
                <button 
                  class="join-item btn btn-sm" 
                  disabled={currentPage === totalPages}
                  on:click={() => goToPage(totalPages)}
                >
                  »
                </button>
              </div>
            </div>
          </div>
        {/if}
      {/if}
    </div>
  </div>
</div>

<!-- Details Modal -->
{#if showDetailsModal && selectedLog}
  {@const badge = getActionBadge(selectedLog.action)}
  <div class="modal modal-open">
    <div class="modal-box max-w-lg">
      <button class="btn btn-sm btn-circle btn-ghost btn-ghost-contrast absolute right-2 top-2" on:click={closeDetailsModal}>✕</button>
      
      <h3 class="font-bold text-lg flex items-center gap-2">
        <span class="badge {badge.class}">{badge.label}</span>
        Détails de l'événement
      </h3>
      
      <div class="py-4 space-y-4">
        <!-- Basic info -->
        <div class="grid grid-cols-2 gap-2 text-sm">
          <div class="text-base-content/60">Date</div>
          <div class="font-medium">{formatDate(selectedLog.created_at)}</div>
          
          <div class="text-base-content/60">Utilisateur</div>
          <div class="font-medium">{selectedLog.user_email || 'Anonyme'}</div>
          
          <div class="text-base-content/60">Adresse IP</div>
          <div class="font-mono">{selectedLog.ip_address || '—'}</div>
          
          <div class="text-base-content/60">Action</div>
          <div class="font-mono text-xs">{selectedLog.action}</div>
        </div>
        
        <!-- Details JSON -->
        {#if selectedLog.details && Object.keys(selectedLog.details).length > 0}
          <div class="divider text-xs">Données additionnelles</div>
          <div class="bg-base-200 rounded-lg p-3 max-h-60 overflow-auto">
            <table class="table table-xs">
              <tbody>
                {#each Object.entries(selectedLog.details) as [key, value]}
                  <tr>
                    <td class="font-medium text-base-content/70">{key}</td>
                    <td class="font-mono text-xs break-all">
                      {typeof value === 'object' ? JSON.stringify(value) : value}
                    </td>
                  </tr>
                {/each}
              </tbody>
            </table>
          </div>
        {/if}
      </div>
      
        <div class="modal-action">
        <button class="btn btn-ghost btn-ghost-contrast" on:click={closeDetailsModal}>Fermer</button>
      </div>
    </div>
    <!-- svelte-ignore a11y-click-events-have-key-events -->
    <!-- svelte-ignore a11y-no-noninteractive-element-interactions -->
    <form method="dialog" class="modal-backdrop" on:click={closeDetailsModal}>
      <button>close</button>
    </form>
  </div>
{/if}
