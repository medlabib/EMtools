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
  let currentPage = 1;
  let totalLogs = 0;
  const logsPerPage = 20;

  $: totalPages = Math.ceil(totalLogs / logsPerPage);

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

  function getActionBadge(action: string): { class: string; label: string } {
    const actionMap: Record<string, { class: string; label: string }> = {
      'login': { class: 'badge-info', label: 'Connexion' },
      'logout': { class: 'badge-secondary', label: 'Déconnexion' },
      'register': { class: 'badge-success', label: 'Inscription' },
      'initial_setup': { class: 'badge-primary', label: 'Config initiale' },
      'settings_update': { class: 'badge-warning', label: 'Paramètres' },
      'smtp_update': { class: 'badge-warning', label: 'SMTP' },
      'user_created': { class: 'badge-success', label: 'Utilisateur créé' },
      'user_updated': { class: 'badge-info', label: 'Utilisateur MAJ' },
      'user_deleted': { class: 'badge-error', label: 'Utilisateur supprimé' },
      'password_reset': { class: 'badge-warning', label: 'MDP réinitialisé' },
    };
    return actionMap[action] || { class: 'badge-ghost', label: action };
  }

  function getUniqueActions(): string[] {
    const actions = new Set(logs.map(l => l.action));
    return Array.from(actions).sort();
  }
</script>

<div class="min-h-screen bg-base-200">
  <!-- Header -->
  <div class="bg-base-100 shadow-sm border-b border-base-300">
    <div class="container mx-auto px-4 py-4">
      <div class="flex items-center gap-3">
        <a href="/admin" class="btn btn-ghost btn-sm btn-square">
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
        <button class="btn btn-ghost btn-sm" on:click={() => error = ''}>✕</button>
      </div>
    {/if}

    <!-- Filters -->
    <div class="card bg-base-100 shadow-sm mb-4">
      <div class="card-body py-3">
        <div class="flex flex-wrap items-center gap-3">
          <div class="form-control">
            <select class="select select-bordered select-sm" bind:value={actionFilter} on:change={handleFilterChange}>
              <option value="">Toutes les actions</option>
              <option value="login">Connexion</option>
              <option value="logout">Déconnexion</option>
              <option value="register">Inscription</option>
              <option value="initial_setup">Config initiale</option>
              <option value="settings_update">Paramètres</option>
              <option value="smtp_update">SMTP</option>
              <option value="user_created">Utilisateur créé</option>
              <option value="user_updated">Utilisateur MAJ</option>
              <option value="user_deleted">Utilisateur supprimé</option>
            </select>
          </div>
          
          <div class="ml-auto text-sm text-base-content/60">
            {totalLogs} entrée{totalLogs !== 1 ? 's' : ''}
          </div>

          <button class="btn btn-ghost btn-sm" on:click={loadLogs} title="Actualiser">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
            </svg>
          </button>
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
      {:else if logs.length === 0}
        <div class="card-body">
          <div class="text-center py-8 text-base-content/60">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12 mx-auto mb-3 opacity-40" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
            </svg>
            <p>Aucun journal trouvé</p>
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
              {#each logs as log}
                {@const actionBadge = getActionBadge(log.action)}
                <tr class="hover">
                  <td class="whitespace-nowrap text-sm">
                    {formatDate(log.created_at)}
                  </td>
                  <td>
                    <span class="badge {actionBadge.class} badge-sm">{actionBadge.label}</span>
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
                      <button 
                        class="btn btn-ghost btn-xs"
                        on:click={() => alert(JSON.stringify(log.details, null, 2))}
                      >
                        Voir détails
                      </button>
                    {:else}
                      <span class="text-base-content/40 text-sm">—</span>
                    {/if}
                  </td>
                  <td class="text-sm text-base-content/60">
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
