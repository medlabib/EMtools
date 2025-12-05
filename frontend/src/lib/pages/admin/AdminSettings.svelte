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
  let savingSmtp = false;
  let testingSmtp = false;
  let error = '';
  let success = '';
  let smtpTestResult = '';
  let smtpTestSuccess = false;

  // Form data
  let signupMode: SignupMode = 'closed';
  let allowedDomains = '';
  let newDomain = '';
  let domainList: string[] = [];
  
  // SMTP form
  let smtpHost = '';
  let smtpPort = 587;
  let smtpUser = '';
  let smtpPassword = '';
  let smtpFromEmail = '';
  let smtpUseTls = true;
  
  // Active tab for settings sections
  let activeSection: 'general' | 'smtp' | 'security' = 'general';
  
  // SMTP Presets
  const smtpPresets = [
    { name: 'Gmail', host: 'smtp.gmail.com', port: 587, tls: true },
    { name: 'Outlook', host: 'smtp-mail.outlook.com', port: 587, tls: true },
    { name: 'Yahoo', host: 'smtp.mail.yahoo.com', port: 587, tls: true },
    { name: 'SendGrid', host: 'smtp.sendgrid.net', port: 587, tls: true },
    { name: 'Mailgun', host: 'smtp.mailgun.org', port: 587, tls: true },
    { name: 'Custom', host: '', port: 587, tls: true }
  ];

  onMount(async () => {
    if (!$authStore.isAuthenticated || !isAdmin($authStore.user)) {
      navigate('/login');
      return;
    }

    try {
      const settings = await fetchSettings();
      signupMode = settings.signup_mode;
      domainList = settings.allowed_email_domains || [];
      allowedDomains = domainList.join(', ');
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
  
  function addDomain() {
    const domain = newDomain.trim().toLowerCase();
    if (domain && !domainList.includes(domain)) {
      // Basic domain validation
      if (/^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,}$/.test(domain)) {
        domainList = [...domainList, domain];
        allowedDomains = domainList.join(', ');
        newDomain = '';
      } else {
        error = 'Format de domaine invalide';
        setTimeout(() => error = '', 3000);
      }
    }
  }
  
  function removeDomain(domain: string) {
    domainList = domainList.filter(d => d !== domain);
    allowedDomains = domainList.join(', ');
  }
  
  function applySmtpPreset(preset: typeof smtpPresets[0]) {
    if (preset.host) {
      smtpHost = preset.host;
      smtpPort = preset.port;
      smtpUseTls = preset.tls;
    }
  }

  async function handleSaveGeneral() {
    saving = true;
    error = '';
    success = '';
    try {
      await updateSettings({
        signup_mode: signupMode,
        allowed_email_domains: domainList
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

    savingSmtp = true;
    error = '';
    success = '';
    smtpTestResult = '';
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
      savingSmtp = false;
    }
  }

  async function handleTestSmtp() {
    smtpTestResult = '';
    testingSmtp = true;
    try {
      const result = await testSmtpSettings();
      smtpTestResult = result.message || 'Test réussi! Email envoyé.';
      smtpTestSuccess = true;
    } catch (e) {
      smtpTestResult = e instanceof Error ? e.message : 'Test failed';
      smtpTestSuccess = false;
    } finally {
      testingSmtp = false;
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

  <div class="container mx-auto px-4 py-6 max-w-4xl">
    {#if loading}
      <div class="flex justify-center items-center h-64">
        <span class="loading loading-spinner loading-lg text-primary"></span>
      </div>
    {:else}
      {#if error}
        <div class="alert alert-error mb-4">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
          </svg>
          <span>{error}</span>
          <button class="btn btn-ghost btn-sm" on:click={() => error = ''}>✕</button>
        </div>
      {/if}

      {#if success}
        <div class="alert alert-success mb-4">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
          </svg>
          <span>{success}</span>
        </div>
      {/if}
      
      <!-- Tabs -->
      <div class="tabs tabs-boxed bg-base-100 p-1 mb-6">
        <button 
          class="tab flex-1 gap-2" 
          class:tab-active={activeSection === 'general'}
          on:click={() => activeSection = 'general'}
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
          </svg>
          Général
        </button>
        <button 
          class="tab flex-1 gap-2" 
          class:tab-active={activeSection === 'smtp'}
          on:click={() => activeSection = 'smtp'}
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
          </svg>
          Email SMTP
          {#if !$appSettings?.smtp_configured}
            <span class="badge badge-warning badge-xs">!</span>
          {/if}
        </button>
        <button 
          class="tab flex-1 gap-2" 
          class:tab-active={activeSection === 'security'}
          on:click={() => activeSection = 'security'}
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
          </svg>
          Système
        </button>
      </div>

      <!-- General Settings -->
      {#if activeSection === 'general'}
      <div class="card bg-base-100 shadow-sm mb-6">
        <div class="card-body">
          <h2 class="card-title text-lg flex items-center gap-2">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-primary" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z" />
            </svg>
            Mode d'inscription
          </h2>
          
          <div class="grid gap-4 mt-4">
            <!-- Signup mode cards -->
            <label class="card card-compact bg-base-200 cursor-pointer hover:bg-base-300 transition-colors" class:ring-2={signupMode === 'open'} class:ring-primary={signupMode === 'open'}>
              <div class="card-body flex-row items-center gap-4">
                <input type="radio" name="signupMode" class="radio radio-primary" bind:group={signupMode} value="open" />
                <div class="flex-1">
                  <h3 class="font-semibold">Ouvert</h3>
                  <p class="text-sm text-base-content/60">Tout le monde peut créer un compte</p>
                </div>
                <span class="badge badge-success">Public</span>
              </div>
            </label>
            
            <label class="card card-compact bg-base-200 cursor-pointer hover:bg-base-300 transition-colors" class:ring-2={signupMode === 'institutional'} class:ring-primary={signupMode === 'institutional'}>
              <div class="card-body flex-row items-center gap-4">
                <input type="radio" name="signupMode" class="radio radio-primary" bind:group={signupMode} value="institutional" />
                <div class="flex-1">
                  <h3 class="font-semibold">Institutionnel</h3>
                  <p class="text-sm text-base-content/60">Seuls les emails des domaines autorisés</p>
                </div>
                <span class="badge badge-warning">Restreint</span>
              </div>
            </label>
            
            <label class="card card-compact bg-base-200 cursor-pointer hover:bg-base-300 transition-colors" class:ring-2={signupMode === 'closed'} class:ring-primary={signupMode === 'closed'}>
              <div class="card-body flex-row items-center gap-4">
                <input type="radio" name="signupMode" class="radio radio-primary" bind:group={signupMode} value="closed" />
                <div class="flex-1">
                  <h3 class="font-semibold">Fermé</h3>
                  <p class="text-sm text-base-content/60">Seul un administrateur peut créer des comptes</p>
                </div>
                <span class="badge badge-error">Privé</span>
              </div>
            </label>
          </div>

          {#if signupMode === 'institutional'}
            <div class="divider"></div>
            <h3 class="font-semibold flex items-center gap-2">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9a9 9 0 01-9-9m9 9c1.657 0 3-4.03 3-9s-1.343-9-3-9m0 18c-1.657 0-3-4.03-3-9s1.343-9 3-9m-9 9a9 9 0 019-9" />
              </svg>
              Domaines autorisés
            </h3>
            
            <div class="form-control mt-2">
              <div class="join w-full">
                <input 
                  type="text" 
                  class="input input-bordered join-item flex-1" 
                  bind:value={newDomain}
                  placeholder="example.com"
                  on:keydown={(e) => e.key === 'Enter' && addDomain()}
                />
                <button class="btn btn-primary join-item" on:click={addDomain}>
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                  </svg>
                  Ajouter
                </button>
              </div>
            </div>
            
            {#if domainList.length > 0}
              <div class="flex flex-wrap gap-2 mt-3">
                {#each domainList as domain}
                  <span class="badge badge-lg gap-2">
                    @{domain}
                    <button class="btn btn-ghost btn-xs btn-circle" on:click={() => removeDomain(domain)}>✕</button>
                  </span>
                {/each}
              </div>
            {:else}
              <p class="text-sm text-base-content/50 mt-2">Aucun domaine configuré. Ajoutez des domaines pour permettre l'inscription.</p>
            {/if}
          {/if}

          <div class="card-actions justify-end mt-4">
            <button class="btn btn-primary" on:click={handleSaveGeneral} disabled={saving}>
              {#if saving}<span class="loading loading-spinner loading-sm"></span>{/if}
              Enregistrer
            </button>
          </div>
        </div>
      </div>
      {/if}

      <!-- SMTP Settings -->
      {#if activeSection === 'smtp'}
      <div class="card bg-base-100 shadow-sm mb-6">
        <div class="card-body">
          <div class="flex items-center justify-between mb-2">
            <h2 class="card-title text-lg flex items-center gap-2">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-primary" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
              </svg>
              Configuration SMTP
            </h2>
            {#if $appSettings?.smtp_configured}
              <span class="badge badge-success gap-1">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                Configuré
              </span>
            {:else}
              <span class="badge badge-warning gap-1">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                </svg>
                Non configuré
              </span>
            {/if}
          </div>
          
          <p class="text-sm text-base-content/60 mb-4">
            Configurez SMTP pour envoyer des emails de vérification et de réinitialisation de mot de passe.
          </p>
          
          <!-- SMTP Presets -->
          <div class="mb-4">
            <label class="label"><span class="label-text font-medium">Préréglages rapides</span></label>
            <div class="flex flex-wrap gap-2">
              {#each smtpPresets as preset}
                <button 
                  class="btn btn-sm btn-outline"
                  class:btn-primary={smtpHost === preset.host}
                  on:click={() => applySmtpPreset(preset)}
                >
                  {preset.name}
                </button>
              {/each}
            </div>
          </div>
          
          <div class="divider my-2"></div>

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
              <label class="label"><span class="label-text">Email d'envoi (From)</span></label>
              <input type="email" class="input input-bordered" bind:value={smtpFromEmail} placeholder="noreply@example.com" />
              <label class="label">
                <span class="label-text-alt text-base-content/50">Cet email apparaîtra comme expéditeur</span>
              </label>
            </div>
          </div>

          <div class="form-control mt-2">
            <label class="label cursor-pointer justify-start gap-3">
              <input type="checkbox" class="checkbox checkbox-primary" bind:checked={smtpUseTls} />
              <div>
                <span class="label-text font-medium">Utiliser TLS/STARTTLS</span>
                <p class="text-xs text-base-content/50">Recommandé pour la sécurité</p>
              </div>
            </label>
          </div>

          {#if smtpTestResult}
            <div class="alert mt-4 text-sm" class:alert-success={smtpTestSuccess} class:alert-error={!smtpTestSuccess}>
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                {#if smtpTestSuccess}
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                {:else}
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                {/if}
              </svg>
              <span>{smtpTestResult}</span>
            </div>
          {/if}

          <div class="card-actions justify-end mt-4">
            <button 
              class="btn btn-outline gap-2" 
              on:click={handleTestSmtp} 
              disabled={testingSmtp || !$appSettings?.smtp_configured}
            >
              {#if testingSmtp}
                <span class="loading loading-spinner loading-sm"></span>
              {:else}
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
              {/if}
              Tester la connexion
            </button>
            <button class="btn btn-primary gap-2" on:click={handleSaveSmtp} disabled={savingSmtp}>
              {#if savingSmtp}<span class="loading loading-spinner loading-sm"></span>{/if}
              <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
              </svg>
              Enregistrer SMTP
            </button>
          </div>
        </div>
      </div>
      
      <!-- SMTP Help -->
      <div class="card bg-base-100 shadow-sm">
        <div class="card-body">
          <h3 class="font-semibold flex items-center gap-2">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            Configuration par fournisseur
          </h3>
          <div class="text-sm text-base-content/70 space-y-2 mt-2">
            <p><strong>Gmail:</strong> Activez "App passwords" dans votre compte Google si 2FA est activé.</p>
            <p><strong>Outlook/Office 365:</strong> Utilisez votre email complet comme nom d'utilisateur.</p>
            <p><strong>SendGrid:</strong> Utilisez "apikey" comme nom d'utilisateur et votre API key comme mot de passe.</p>
          </div>
        </div>
      </div>
      {/if}

      <!-- System Info -->
      {#if activeSection === 'security'}
      <div class="card bg-base-100 shadow-sm mb-6">
        <div class="card-body">
          <h2 class="card-title text-lg flex items-center gap-2">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-primary" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
            </svg>
            État du système
          </h2>
          
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
            <!-- Setup Status -->
            <div class="stat bg-base-200 rounded-lg">
              <div class="stat-figure text-primary">
                {#if $appSettings?.is_setup_complete}
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-success" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                {:else}
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-warning" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                {/if}
              </div>
              <div class="stat-title">Configuration initiale</div>
              <div class="stat-value text-lg">
                {#if $appSettings?.is_setup_complete}
                  <span class="text-success">Terminée</span>
                {:else}
                  <span class="text-warning">En attente</span>
                {/if}
              </div>
              {#if $appSettings?.setup_at}
                <div class="stat-desc">{new Date($appSettings.setup_at).toLocaleDateString('fr-FR')}</div>
              {/if}
            </div>
            
            <!-- SMTP Status -->
            <div class="stat bg-base-200 rounded-lg">
              <div class="stat-figure">
                {#if $appSettings?.smtp_configured}
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-success" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                  </svg>
                {:else}
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-warning" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                  </svg>
                {/if}
              </div>
              <div class="stat-title">Email SMTP</div>
              <div class="stat-value text-lg">
                {#if $appSettings?.smtp_configured}
                  <span class="text-success">Actif</span>
                {:else}
                  <span class="text-warning">Non configuré</span>
                {/if}
              </div>
              {#if $appSettings?.smtp_host}
                <div class="stat-desc">{$appSettings.smtp_host}</div>
              {/if}
            </div>
          </div>
        </div>
      </div>
      
      <!-- Security Checklist -->
      <div class="card bg-base-100 shadow-sm mb-6">
        <div class="card-body">
          <h2 class="card-title text-lg flex items-center gap-2">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-primary" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4" />
            </svg>
            Checklist de sécurité
          </h2>
          
          <div class="space-y-3 mt-4">
            <div class="flex items-center gap-3 p-3 bg-base-200 rounded-lg">
              {#if $appSettings?.smtp_configured}
                <span class="text-success">✓</span>
              {:else}
                <span class="text-warning">○</span>
              {/if}
              <div class="flex-1">
                <p class="font-medium">Configuration SMTP</p>
                <p class="text-sm text-base-content/60">Permet l'envoi d'emails de vérification</p>
              </div>
              {#if !$appSettings?.smtp_configured}
                <button class="btn btn-sm btn-primary" on:click={() => activeSection = 'smtp'}>Configurer</button>
              {/if}
            </div>
            
            <div class="flex items-center gap-3 p-3 bg-base-200 rounded-lg">
              {#if signupMode !== 'open'}
                <span class="text-success">✓</span>
              {:else}
                <span class="text-info">○</span>
              {/if}
              <div class="flex-1">
                <p class="font-medium">Inscriptions restreintes</p>
                <p class="text-sm text-base-content/60">
                  Mode actuel: <span class="badge badge-sm">{signupMode}</span>
                </p>
              </div>
            </div>
            
            <div class="flex items-center gap-3 p-3 bg-base-200 rounded-lg">
              {#if $appSettings?.is_setup_complete}
                <span class="text-success">✓</span>
              {:else}
                <span class="text-warning">○</span>
              {/if}
              <div class="flex-1">
                <p class="font-medium">Configuration initiale terminée</p>
                <p class="text-sm text-base-content/60">Premier administrateur créé</p>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Quick Links -->
      <div class="card bg-base-100 shadow-sm">
        <div class="card-body">
          <h2 class="card-title text-lg">Actions rapides</h2>
          
          <div class="grid grid-cols-1 md:grid-cols-2 gap-3 mt-2">
            <a href="/admin/users" class="btn btn-outline justify-start gap-2">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
              </svg>
              Gérer les utilisateurs
            </a>
            <a href="/admin/logs" class="btn btn-outline justify-start gap-2">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
              </svg>
              Voir les logs d'activité
            </a>
            <a href="/admin" class="btn btn-outline justify-start gap-2">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
              </svg>
              Tableau de bord
            </a>
          </div>
        </div>
      </div>
      {/if}
    {/if}
  </div>
</div>
