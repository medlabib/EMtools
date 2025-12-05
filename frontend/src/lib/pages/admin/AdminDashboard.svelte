<script lang="ts">
  import { onMount } from 'svelte';
  import { navigate } from 'svelte-routing';
  import { authStore, isAdmin } from '../../stores/auth';
  import { 
    fetchDashboardStats,
    fetchActivityLogs,
    dashboardStats,
    activityLogs,
    type DashboardStats,
    type ActivityLog
  } from '../../stores/admin';

  let loading = true;
  let error = '';
  let refreshing = false;

  onMount(async () => {
    // Check if user is admin
    if (!$authStore.isAuthenticated || !isAdmin($authStore.user)) {
      navigate('/login');
      return;
    }

    await loadData();
  });

  async function loadData() {
    try {
      await Promise.all([
        fetchDashboardStats(),
        fetchActivityLogs({ limit: 10 })
      ]);
    } catch (e) {
      error = e instanceof Error ? e.message : 'Failed to load dashboard';
    } finally {
      loading = false;
    }
  }

  async function refresh() {
    refreshing = true;
    await loadData();
    refreshing = false;
  }

  function formatDate(dateStr: string): string {
    return new Date(dateStr).toLocaleString('fr-FR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  }

  function formatRelativeTime(dateStr: string): string {
    const now = new Date();
    const date = new Date(dateStr);
    const diffMs = now.getTime() - date.getTime();
    const diffMins = Math.floor(diffMs / 60000);
    const diffHours = Math.floor(diffMs / 3600000);
    const diffDays = Math.floor(diffMs / 86400000);

    if (diffMins < 1) return "À l'instant";
    if (diffMins < 60) return `Il y a ${diffMins} min`;
    if (diffHours < 24) return `Il y a ${diffHours}h`;
    if (diffDays < 7) return `Il y a ${diffDays}j`;
    return formatDate(dateStr);
  }

  function getActionBadgeClass(action: string): string {
    switch (action) {
      case 'login': return 'badge-success';
      case 'logout': return 'badge-neutral';
      case 'register': return 'badge-info';
      case 'initial_setup': return 'badge-primary';
      case 'update_settings': return 'badge-warning';
      case 'create_user': return 'badge-secondary';
      case 'delete_user': return 'badge-error';
      case 'update_user': return 'badge-accent';
      default: return 'badge-ghost';
    }
  }

  function getActionLabel(action: string): string {
    const labels: Record<string, string> = {
      'login': 'Connexion',
      'logout': 'Déconnexion',
      'register': 'Inscription',
      'initial_setup': 'Configuration',
      'update_settings': 'Paramètres',
      'create_user': 'Création',
      'delete_user': 'Suppression',
      'update_user': 'Modification'
    };
    return labels[action] || action;
  }

  function getSignupModeLabel(mode: string): string {
    switch (mode) {
      case 'open': return 'Ouvert';
      case 'institutional': return 'Institutionnel';
      case 'closed': return 'Fermé';
      default: return mode;
    }
  }

  function getSignupModeBadgeClass(mode: string): string {
    switch (mode) {
      case 'open': return 'badge-success';
      case 'institutional': return 'badge-warning';
      case 'closed': return 'badge-error';
      default: return 'badge-ghost';
    }
  }

  function getSignupModeDescription(mode: string): string {
    switch (mode) {
      case 'open': return 'Tout le monde peut s\'inscrire';
      case 'institutional': return 'Seuls les emails autorisés';
      case 'closed': return 'Inscription désactivée';
      default: return '';
    }
  }

  // Calculate percentages for visual display
  $: verifiedPercent = $dashboardStats?.total_users 
    ? Math.round(($dashboardStats.verified_users / $dashboardStats.total_users) * 100) 
    : 0;
  
  $: activePercent = $dashboardStats?.total_users 
    ? Math.round(($dashboardStats.active_users / $dashboardStats.total_users) * 100) 
    : 0;
</script>

<div class="min-h-screen bg-base-200">
  <!-- Header -->
  <div class="bg-base-100 shadow-sm border-b border-base-300">
    <div class="container mx-auto px-4 py-4">
      <div class="flex items-center justify-between flex-wrap gap-4">
        <div>
          <h1 class="text-2xl font-bold">🛠️ Administration</h1>
          <p class="text-base-content/60 text-sm">Tableau de bord</p>
        </div>
        <div class="flex gap-2 flex-wrap">
          <button class="btn btn-outline btn-sm" on:click={refresh} disabled={refreshing}>
            {#if refreshing}
              <span class="loading loading-spinner loading-xs"></span>
            {:else}
              <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
              </svg>
            {/if}
            Actualiser
          </button>
          <a href="/admin/users" class="btn btn-outline btn-sm">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
            </svg>
            Utilisateurs
          </a>
          <a href="/admin/settings" class="btn btn-outline btn-sm">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
            </svg>
            Paramètres
          </a>
          <a href="/admin/logs" class="btn btn-outline btn-sm">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
            </svg>
            Journaux
          </a>
        </div>
      </div>
    </div>
  </div>

  <div class="container mx-auto px-4 py-6">
    {#if loading}
      <div class="flex justify-center items-center h-64">
        <span class="loading loading-spinner loading-lg text-primary"></span>
      </div>
    {:else if error}
      <div class="alert alert-error">
        <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current shrink-0 h-6 w-6" fill="none" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" />
        </svg>
        <span>{error}</span>
      </div>
    {:else}
      <!-- Main Stats Cards -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
        <!-- Total Users -->
        <div class="card bg-base-100 shadow-sm hover:shadow-md transition-shadow">
          <div class="card-body p-4">
            <div class="flex items-center gap-4">
              <div class="p-3 rounded-xl bg-primary/10">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7 text-primary" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                </svg>
              </div>
              <div class="flex-1">
                <p class="text-3xl font-bold">{$dashboardStats?.total_users ?? 0}</p>
                <p class="text-sm text-base-content/60">Utilisateurs</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Active Users -->
        <div class="card bg-base-100 shadow-sm hover:shadow-md transition-shadow">
          <div class="card-body p-4">
            <div class="flex items-center gap-4">
              <div class="p-3 rounded-xl bg-success/10">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7 text-success" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
              </div>
              <div class="flex-1">
                <p class="text-3xl font-bold">{$dashboardStats?.active_users ?? 0}</p>
                <p class="text-sm text-base-content/60">Actifs ({activePercent}%)</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Verified Users -->
        <div class="card bg-base-100 shadow-sm hover:shadow-md transition-shadow">
          <div class="card-body p-4">
            <div class="flex items-center gap-4">
              <div class="p-3 rounded-xl bg-info/10">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7 text-info" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z" />
                </svg>
              </div>
              <div class="flex-1">
                <p class="text-3xl font-bold">{$dashboardStats?.verified_users ?? 0}</p>
                <p class="text-sm text-base-content/60">Vérifiés ({verifiedPercent}%)</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Admins -->
        <div class="card bg-base-100 shadow-sm hover:shadow-md transition-shadow">
          <div class="card-body p-4">
            <div class="flex items-center gap-4">
              <div class="p-3 rounded-xl bg-warning/10">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7 text-warning" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                </svg>
              </div>
              <div class="flex-1">
                <p class="text-3xl font-bold">{$dashboardStats?.admin_users ?? 0}</p>
                <p class="text-sm text-base-content/60">Administrateurs</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- System Status & Quick Actions -->
      <div class="grid grid-cols-1 lg:grid-cols-3 gap-4 mb-6">
        <!-- System Status -->
        <div class="lg:col-span-2 card bg-base-100 shadow-sm">
          <div class="card-body p-5">
            <h3 class="font-semibold text-lg mb-4">📊 État du système</h3>
            
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <!-- Signup Mode -->
              <div class="p-4 rounded-lg bg-base-200/50 border border-base-300">
                <div class="flex items-center justify-between mb-2">
                  <span class="text-sm font-medium text-base-content/70">Mode d'inscription</span>
                  <span class="badge {getSignupModeBadgeClass($dashboardStats?.signup_mode ?? 'closed')}">
                    {getSignupModeLabel($dashboardStats?.signup_mode ?? 'closed')}
                  </span>
                </div>
                <p class="text-xs text-base-content/50">{getSignupModeDescription($dashboardStats?.signup_mode ?? 'closed')}</p>
              </div>

              <!-- SMTP Status -->
              <div class="p-4 rounded-lg bg-base-200/50 border border-base-300">
                <div class="flex items-center justify-between mb-2">
                  <span class="text-sm font-medium text-base-content/70">Email (SMTP)</span>
                  {#if $dashboardStats?.smtp_configured}
                    <span class="badge badge-success gap-1">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                      </svg>
                      Actif
                    </span>
                  {:else}
                    <span class="badge badge-warning gap-1">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01" />
                      </svg>
                      Non configuré
                    </span>
                  {/if}
                </div>
                <p class="text-xs text-base-content/50">
                  {$dashboardStats?.smtp_configured ? 'Envoi d\'emails activé' : 'Configurez SMTP pour activer les emails'}
                </p>
              </div>

              <!-- Activity Stats -->
              <div class="p-4 rounded-lg bg-base-200/50 border border-base-300">
                <div class="flex items-center justify-between mb-2">
                  <span class="text-sm font-medium text-base-content/70">Activité 24h</span>
                  <span class="badge badge-info">{$dashboardStats?.recent_activities ?? 0} actions</span>
                </div>
                <p class="text-xs text-base-content/50">Connexions, inscriptions, modifications</p>
              </div>

              <!-- User Stats -->
              <div class="p-4 rounded-lg bg-base-200/50 border border-base-300">
                <div class="flex items-center justify-between mb-2">
                  <span class="text-sm font-medium text-base-content/70">Ratio actifs</span>
                  <span class="badge badge-success">{activePercent}%</span>
                </div>
                <div class="w-full bg-base-300 rounded-full h-2 mt-2">
                  <div class="bg-success h-2 rounded-full transition-all" style="width: {activePercent}%"></div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Quick Actions -->
        <div class="card bg-base-100 shadow-sm">
          <div class="card-body p-5">
            <h3 class="font-semibold text-lg mb-4">⚡ Actions rapides</h3>
            
            <div class="space-y-3">
              <a href="/admin/users" class="btn btn-outline btn-block justify-start gap-3">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z" />
                </svg>
                Gérer les utilisateurs
              </a>
              
              <a href="/admin/settings" class="btn btn-outline btn-block justify-start gap-3">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4" />
                </svg>
                Paramètres système
              </a>
              
              <a href="/admin/logs" class="btn btn-outline btn-block justify-start gap-3">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                </svg>
                Voir tous les journaux
              </a>

              <div class="divider my-2"></div>
              
              <a href="/" class="btn btn-ghost btn-block justify-start gap-3 text-base-content/70">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                </svg>
                Retour à l'application
              </a>
            </div>
          </div>
        </div>
      </div>

      <!-- Recent Activity Table -->
      <div class="card bg-base-100 shadow-sm">
        <div class="card-body p-5">
          <div class="flex items-center justify-between mb-4">
            <h3 class="font-semibold text-lg">📋 Activité récente</h3>
            <a href="/admin/logs" class="btn btn-ghost btn-sm">
              Voir tout →
            </a>
          </div>
          
          {#if $activityLogs.length > 0}
            <div class="overflow-x-auto">
              <table class="table table-sm">
                <thead>
                  <tr class="bg-base-200/50">
                    <th>Utilisateur</th>
                    <th>Action</th>
                    <th>Détails</th>
                    <th>IP</th>
                    <th>Date</th>
                  </tr>
                </thead>
                <tbody>
                  {#each $activityLogs as log}
                    <tr class="hover:bg-base-200/30">
                      <td>
                        <span class="text-sm font-medium">
                          {log.user_email || 'Système'}
                        </span>
                      </td>
                      <td>
                        <span class="badge {getActionBadgeClass(log.action)} badge-sm">
                          {getActionLabel(log.action)}
                        </span>
                      </td>
                      <td class="text-base-content/70 text-sm">{log.resource_type ?? '-'}</td>
                      <td class="text-base-content/60 font-mono text-xs">{log.ip_address ?? '-'}</td>
                      <td class="text-base-content/60 text-sm" title={formatDate(log.created_at)}>
                        {formatRelativeTime(log.created_at)}
                      </td>
                    </tr>
                  {/each}
                </tbody>
              </table>
            </div>
          {:else}
            <div class="text-center py-8 text-base-content/50">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12 mx-auto mb-3 opacity-50" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
              </svg>
              <p>Aucune activité récente</p>
            </div>
          {/if}
        </div>
      </div>
    {/if}
  </div>
</div>
