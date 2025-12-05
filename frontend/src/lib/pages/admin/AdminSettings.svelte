<script lang="ts">
  import { onMount } from 'svelte';
  import { navigate } from 'svelte-routing';
  import { authStore, isAdmin } from '../../stores/auth';
  import { 
    fetchSettings,
    updateSettings,
    updateSmtpSettings,
    testSmtpSettings,
    appSettings,
    type SignupMode
  } from '../../stores/admin';

  let loading = true;
  let saving = false;
  let error = '';
  let success = '';
  let smtpTestResult = '';

  // Form data
  let signupMode: SignupMode = 'closed';
  let allowedDomains = '';
  
  // SMTP form
  let smtpHost = '';
  let smtpPort = 587;
  let smtpUser = '';
  let smtpPassword = '';
  let smtpFromEmail = '';
  let smtpUseTls = true;

  onMount(async () => {
    if (!$authStore.isAuthenticated || !isAdmin($authStore.user)) {
      navigate('/login');
      return;
    }

    try {
      const settings = await fetchSettings();
      signupMode = settings.signup_mode;
      allowedDomains = settings.allowed_email_domains.join(', ');
      smtpHost = settings.smtp_host ?? '';
      smtpPort = settings.smtp_port ?? 587;
      smtpFromEmail = settings.smtp_from_email ?? '';
      smtpUseTls = settings.smtp_use_tls ?? true;
    } catch (e) {
      error = e instanceof Error ? e.message : 'Failed to load settings';
    } finally {
      loading = false;
    }
  });

  async function handleSaveGeneral() {
    saving = true;
    error = '';
    success = '';
    try {
      const domains = allowedDomains.split(',').map(d => d.trim()).filter(d => d);
      await updateSettings({
        signup_mode: signupMode,
        allowed_email_domains: domains
      });
      success = 'Paramètres enregistrés avec succès';
      setTimeout(() => success = '', 3000);
    } catch (e) {
      error = e instanceof Error ? e.message : 'Failed to save settings';
    } finally {
      saving = false;
    }
  }

  async function handleSaveSmtp() {
    if (!smtpHost || !smtpUser || !smtpPassword || !smtpFromEmail) {
      error = 'Tous les champs SMTP sont requis';
      return;
    }

    saving = true;
    error = '';
    success = '';
    try {
      await updateSmtpSettings({
        smtp_host: smtpHost,
        smtp_port: smtpPort,
        smtp_user: smtpUser,
        smtp_password: smtpPassword,
        smtp_from_email: smtpFromEmail,
        smtp_use_tls: smtpUseTls
      });
      success = 'Configuration SMTP enregistrée avec succès';
      smtpPassword = ''; // Clear password field after save
      setTimeout(() => success = '', 3000);
    } catch (e) {
      error = e instanceof Error ? e.message : 'Failed to save SMTP settings';
    } finally {
      saving = false;
    }
  }

  async function handleTestSmtp() {
    smtpTestResult = '';
    try {
      const result = await testSmtpSettings();
      smtpTestResult = result.message;
    } catch (e) {
      smtpTestResult = e instanceof Error ? e.message : 'Test failed';
    }
  }

  function getSignupModeDescription(mode: SignupMode): string {
    switch (mode) {
      case 'open': return 'Tout le monde peut créer un compte';
      case 'institutional': return 'Seuls les emails des domaines autorisés peuvent créer un compte';
      case 'closed': return 'Seul un administrateur peut créer des comptes';
    }
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
          <h1 class="text-2xl font-bold">Paramètres</h1>
          <p class="text-base-content/60 text-sm">Configuration de l'application</p>
        </div>
      </div>
    </div>
  </div>

  <div class="container mx-auto px-4 py-6 max-w-3xl">
    {#if loading}
      <div class="flex justify-center items-center h-64">
        <span class="loading loading-spinner loading-lg text-primary"></span>
      </div>
    {:else}
      {#if error}
        <div class="alert alert-error mb-4">
          <span>{error}</span>
          <button class="btn btn-ghost btn-sm" on:click={() => error = ''}>✕</button>
        </div>
      {/if}

      {#if success}
        <div class="alert alert-success mb-4">
          <span>{success}</span>
        </div>
      {/if}

      <!-- General Settings -->
      <div class="card bg-base-100 shadow-sm mb-6">
        <div class="card-body">
          <h2 class="card-title text-lg">Paramètres généraux</h2>
          
          <div class="form-control mb-4">
            <label class="label">
              <span class="label-text font-medium">Mode d'inscription</span>
            </label>
            <select class="select select-bordered w-full" bind:value={signupMode}>
              <option value="open">Ouvert</option>
              <option value="institutional">Institutionnel</option>
              <option value="closed">Fermé</option>
            </select>
            <label class="label">
              <span class="label-text-alt text-base-content/60">{getSignupModeDescription(signupMode)}</span>
            </label>
          </div>

          {#if signupMode === 'institutional'}
            <div class="form-control mb-4">
              <label class="label">
                <span class="label-text font-medium">Domaines autorisés</span>
              </label>
              <input 
                type="text" 
                class="input input-bordered w-full" 
                bind:value={allowedDomains}
                placeholder="example.com, hospital.org"
              />
              <label class="label">
                <span class="label-text-alt text-base-content/60">Séparez les domaines par des virgules</span>
              </label>
            </div>
          {/if}

          <div class="card-actions justify-end">
            <button class="btn btn-primary" on:click={handleSaveGeneral} disabled={saving}>
              {#if saving}<span class="loading loading-spinner loading-sm"></span>{/if}
              Enregistrer
            </button>
          </div>
        </div>
      </div>

      <!-- SMTP Settings -->
      <div class="card bg-base-100 shadow-sm mb-6">
        <div class="card-body">
          <div class="flex items-center justify-between mb-2">
            <h2 class="card-title text-lg">Configuration SMTP</h2>
            {#if $appSettings?.smtp_configured}
              <span class="badge badge-success gap-1">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                Configuré
              </span>
            {:else}
              <span class="badge badge-warning">Non configuré</span>
            {/if}
          </div>
          
          <p class="text-sm text-base-content/60 mb-4">
            Configurez SMTP pour envoyer des emails de vérification et de notification.
          </p>

          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div class="form-control">
              <label class="label"><span class="label-text">Serveur SMTP</span></label>
              <input type="text" class="input input-bordered" bind:value={smtpHost} placeholder="smtp.example.com" />
            </div>
            <div class="form-control">
              <label class="label"><span class="label-text">Port</span></label>
              <input type="number" class="input input-bordered" bind:value={smtpPort} placeholder="587" />
            </div>
            <div class="form-control">
              <label class="label"><span class="label-text">Nom d'utilisateur</span></label>
              <input type="text" class="input input-bordered" bind:value={smtpUser} placeholder="user@example.com" />
            </div>
            <div class="form-control">
              <label class="label"><span class="label-text">Mot de passe</span></label>
              <input type="password" class="input input-bordered" bind:value={smtpPassword} placeholder="••••••••" />
            </div>
            <div class="form-control md:col-span-2">
              <label class="label"><span class="label-text">Email d'envoi</span></label>
              <input type="email" class="input input-bordered" bind:value={smtpFromEmail} placeholder="noreply@example.com" />
            </div>
          </div>

          <div class="form-control mt-4">
            <label class="label cursor-pointer justify-start gap-3">
              <input type="checkbox" class="checkbox checkbox-primary" bind:checked={smtpUseTls} />
              <span class="label-text">Utiliser TLS</span>
            </label>
          </div>

          {#if smtpTestResult}
            <div class="alert alert-info mt-4 text-sm">
              <span>{smtpTestResult}</span>
            </div>
          {/if}

          <div class="card-actions justify-end mt-4">
            <button class="btn btn-outline" on:click={handleTestSmtp} disabled={saving || !$appSettings?.smtp_configured}>
              Tester
            </button>
            <button class="btn btn-primary" on:click={handleSaveSmtp} disabled={saving}>
              {#if saving}<span class="loading loading-spinner loading-sm"></span>{/if}
              Enregistrer SMTP
            </button>
          </div>
        </div>
      </div>

      <!-- System Info -->
      <div class="card bg-base-100 shadow-sm">
        <div class="card-body">
          <h2 class="card-title text-lg">Informations système</h2>
          
          <div class="overflow-x-auto">
            <table class="table table-sm">
              <tbody>
                <tr>
                  <td class="font-medium">Configuration initiale</td>
                  <td>
                    {#if $appSettings?.is_setup_complete}
                      <span class="badge badge-success badge-sm">Terminée</span>
                    {:else}
                      <span class="badge badge-warning badge-sm">En attente</span>
                    {/if}
                  </td>
                </tr>
                {#if $appSettings?.setup_at}
                  <tr>
                    <td class="font-medium">Date de configuration</td>
                    <td class="text-base-content/70">
                      {new Date($appSettings.setup_at).toLocaleString('fr-FR')}
                    </td>
                  </tr>
                {/if}
                <tr>
                  <td class="font-medium">Mode d'inscription actuel</td>
                  <td>
                    <span class="badge badge-outline badge-sm">{signupMode}</span>
                  </td>
                </tr>
                <tr>
                  <td class="font-medium">SMTP</td>
                  <td>
                    {#if $appSettings?.smtp_configured}
                      <span class="text-success">✓ {$appSettings.smtp_host}</span>
                    {:else}
                      <span class="text-warning">Non configuré</span>
                    {/if}
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    {/if}
  </div>
</div>
