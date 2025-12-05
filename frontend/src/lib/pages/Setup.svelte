<script lang="ts">
  import { onMount } from 'svelte';
  import { navigate } from 'svelte-routing';
  import { checkSetupStatus, performInitialSetup, type SignupMode } from '../stores/admin';

  let currentStep = 1;
  let loading = true;
  let submitting = false;
  let error = '';
  let success = '';

  // Step 1: Admin account
  let adminEmail = '';
  let adminUsername = '';
  let adminPassword = '';
  let confirmPassword = '';
  let showPassword = false;

  // Step 2: Signup mode
  let signupMode: SignupMode = 'closed';
  let allowedDomains = '';

  // Step 3: SMTP (optional)
  let configureSmtp = false;
  let smtpHost = '';
  let smtpPort = 587;
  let smtpUser = '';
  let smtpPassword = '';
  let smtpFromEmail = '';
  let smtpUseTls = true;

  // Password strength calculation
  $: passwordStrength = calculatePasswordStrength(adminPassword);
  $: passwordsMatch = confirmPassword.length === 0 || adminPassword === confirmPassword;
  $: emailValid = adminEmail.length === 0 || /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(adminEmail);
  $: usernameValid = adminUsername.length === 0 || /^[a-zA-Z0-9_]{3,20}$/.test(adminUsername);

  function calculatePasswordStrength(password: string): { score: number; label: string; color: string } {
    if (!password) return { score: 0, label: '', color: '' };
    
    let score = 0;
    
    // Length checks
    if (password.length >= 8) score += 1;
    if (password.length >= 12) score += 1;
    if (password.length >= 16) score += 1;
    
    // Complexity checks
    if (/[a-z]/.test(password)) score += 1;
    if (/[A-Z]/.test(password)) score += 1;
    if (/[0-9]/.test(password)) score += 1;
    if (/[^a-zA-Z0-9]/.test(password)) score += 1;
    
    // Normalize to 0-4 scale
    const normalizedScore = Math.min(4, Math.floor(score / 2));
    
    const labels = ['Très faible', 'Faible', 'Moyen', 'Bon', 'Excellent'];
    const colors = ['bg-error', 'bg-warning', 'bg-warning', 'bg-success', 'bg-success'];
    
    return {
      score: normalizedScore,
      label: labels[normalizedScore],
      color: colors[normalizedScore]
    };
  }

  onMount(async () => {
    try {
      const status = await checkSetupStatus();
      if (status.is_setup_complete) {
        navigate('/login');
        return;
      }
    } catch (e) {
      // If we can't check status, proceed with setup
    } finally {
      loading = false;
    }
  });

  function validateStep1(): boolean {
    if (!adminEmail || !adminUsername || !adminPassword) {
      error = 'Tous les champs sont requis';
      return false;
    }
    if (!emailValid) {
      error = 'Adresse email invalide';
      return false;
    }
    if (!usernameValid) {
      error = 'Le nom d\'utilisateur doit contenir 3-20 caractères alphanumériques';
      return false;
    }
    if (adminPassword.length < 8) {
      error = 'Le mot de passe doit contenir au moins 8 caractères';
      return false;
    }
    if (passwordStrength.score < 2) {
      error = 'Le mot de passe est trop faible. Ajoutez des majuscules, chiffres ou caractères spéciaux.';
      return false;
    }
    if (adminPassword !== confirmPassword) {
      error = 'Les mots de passe ne correspondent pas';
      return false;
    }
    return true;
  }

  function validateStep2(): boolean {
    if (signupMode === 'institutional' && !allowedDomains.trim()) {
      error = 'Veuillez spécifier au moins un domaine autorisé';
      return false;
    }
    return true;
  }

  function nextStep() {
    error = '';
    success = '';
    if (currentStep === 1 && !validateStep1()) return;
    if (currentStep === 2 && !validateStep2()) return;
    currentStep++;
  }

  function prevStep() {
    error = '';
    success = '';
    currentStep--;
  }

  async function handleSubmit() {
    error = '';
    success = '';
    
    if (!validateStep1() || !validateStep2()) {
      return;
    }

    submitting = true;
    try {
      const domains = allowedDomains.split(',').map(d => d.trim()).filter(d => d);
      
      await performInitialSetup({
        admin_email: adminEmail,
        admin_username: adminUsername,
        admin_password: adminPassword,
        signup_mode: signupMode,
        allowed_email_domains: domains,
        smtp_host: configureSmtp ? smtpHost : undefined,
        smtp_port: configureSmtp ? smtpPort : undefined,
        smtp_user: configureSmtp ? smtpUser : undefined,
        smtp_password: configureSmtp ? smtpPassword : undefined,
        smtp_from_email: configureSmtp ? smtpFromEmail : undefined,
        smtp_use_tls: configureSmtp ? smtpUseTls : undefined,
      });

      success = 'Configuration terminée avec succès !';
      
      // Small delay to show success message, then redirect
      setTimeout(() => {
        navigate('/login');
      }, 1500);
    } catch (e) {
      error = e instanceof Error ? e.message : 'La configuration a échoué';
    } finally {
      submitting = false;
    }
  }

  function getSignupModeDescription(mode: SignupMode): string {
    switch (mode) {
      case 'open': return 'Tout le monde peut créer un compte librement';
      case 'institutional': return 'Seuls les emails des domaines spécifiés peuvent s\'inscrire';
      case 'closed': return 'Seul un administrateur peut créer des comptes utilisateurs';
    }
  }

  function getSignupModeIcon(mode: SignupMode): string {
    switch (mode) {
      case 'open': return '🌐';
      case 'institutional': return '🏛️';
      case 'closed': return '🔒';
    }
  }
</script>

<div class="min-h-screen bg-base-200 flex items-center justify-center p-4">
  <div class="card w-full max-w-xl bg-base-100 shadow-xl">
    {#if loading}
      <div class="card-body items-center py-16">
        <span class="loading loading-spinner loading-lg text-primary"></span>
        <p class="text-base-content/60 mt-4">Vérification...</p>
      </div>
    {:else}
      <div class="card-body">
        <!-- Header -->
        <div class="text-center mb-6">
          <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-primary/10 mb-4">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-primary" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
            </svg>
          </div>
          <h1 class="text-2xl font-bold">Configuration initiale</h1>
          <p class="text-base-content/60 mt-1">Bienvenue ! Configurons votre application.</p>
        </div>

        <!-- Progress Steps -->
        <ul class="steps steps-horizontal w-full mb-6">
          <li class="step" class:step-primary={currentStep >= 1}>Admin</li>
          <li class="step" class:step-primary={currentStep >= 2}>Inscriptions</li>
          <li class="step" class:step-primary={currentStep >= 3}>Email</li>
        </ul>

        {#if error}
          <div class="alert alert-error mb-4">
            <span>{error}</span>
            <button class="btn btn-ghost btn-sm" on:click={() => error = ''}>✕</button>
          </div>
        {/if}

        <!-- Step 1: Admin Account -->
        {#if currentStep === 1}
          <div class="space-y-4">
            <h2 class="text-lg font-semibold">Créer le compte administrateur</h2>
            <p class="text-sm text-base-content/60">Ce compte aura tous les droits d'administration.</p>

            <div class="form-control">
              <label class="label"><span class="label-text">Email</span></label>
              <input 
                type="email" 
                class="input input-bordered" 
                bind:value={adminEmail}
                placeholder="admin@example.com"
              />
            </div>

            <div class="form-control">
              <label class="label"><span class="label-text">Nom d'utilisateur</span></label>
              <input 
                type="text" 
                class="input input-bordered" 
                bind:value={adminUsername}
                placeholder="admin"
              />
            </div>

            <div class="form-control">
              <label class="label"><span class="label-text">Mot de passe</span></label>
              <input 
                type="password" 
                class="input input-bordered" 
                bind:value={adminPassword}
                placeholder="••••••••"
              />
            </div>

            <div class="form-control">
              <label class="label"><span class="label-text">Confirmer le mot de passe</span></label>
              <input 
                type="password" 
                class="input input-bordered" 
                bind:value={confirmPassword}
                placeholder="••••••••"
              />
            </div>
          </div>
        {/if}

        <!-- Step 2: Signup Mode -->
        {#if currentStep === 2}
          <div class="space-y-4">
            <h2 class="text-lg font-semibold">Mode d'inscription</h2>
            <p class="text-sm text-base-content/60">Choisissez comment les utilisateurs peuvent créer un compte.</p>

            <div class="space-y-3">
              <label 
                class="flex items-start gap-3 p-3 rounded-lg border cursor-pointer hover:bg-base-200 transition-colors {signupMode === 'open' ? 'border-primary bg-primary/5' : 'border-base-300'}"
              >
                <input type="radio" name="signup-mode" class="radio radio-primary mt-0.5" bind:group={signupMode} value="open" />
                <div>
                  <div class="font-medium">Ouvert</div>
                  <div class="text-sm text-base-content/60">{getSignupModeDescription('open')}</div>
                </div>
              </label>

              <label 
                class="flex items-start gap-3 p-3 rounded-lg border cursor-pointer hover:bg-base-200 transition-colors {signupMode === 'institutional' ? 'border-primary bg-primary/5' : 'border-base-300'}"
              >
                <input type="radio" name="signup-mode" class="radio radio-primary mt-0.5" bind:group={signupMode} value="institutional" />
                <div>
                  <div class="font-medium">Institutionnel</div>
                  <div class="text-sm text-base-content/60">{getSignupModeDescription('institutional')}</div>
                </div>
              </label>

              <label 
                class="flex items-start gap-3 p-3 rounded-lg border cursor-pointer hover:bg-base-200 transition-colors {signupMode === 'closed' ? 'border-primary bg-primary/5' : 'border-base-300'}"
              >
                <input type="radio" name="signup-mode" class="radio radio-primary mt-0.5" bind:group={signupMode} value="closed" />
                <div>
                  <div class="font-medium">Fermé</div>
                  <div class="text-sm text-base-content/60">{getSignupModeDescription('closed')}</div>
                </div>
              </label>
            </div>

            {#if signupMode === 'institutional'}
              <div class="form-control mt-4">
                <label class="label"><span class="label-text">Domaines email autorisés</span></label>
                <input 
                  type="text" 
                  class="input input-bordered" 
                  bind:value={allowedDomains}
                  placeholder="hospital.org, university.edu"
                />
                <label class="label">
                  <span class="label-text-alt text-base-content/60">Séparez plusieurs domaines par des virgules</span>
                </label>
              </div>
            {/if}
          </div>
        {/if}

        <!-- Step 3: SMTP (Optional) -->
        {#if currentStep === 3}
          <div class="space-y-4">
            <h2 class="text-lg font-semibold">Configuration email (optionnel)</h2>
            <p class="text-sm text-base-content/60">Configurez SMTP pour les notifications et la vérification des emails.</p>

            <div class="form-control">
              <label class="label cursor-pointer justify-start gap-3">
                <input type="checkbox" class="toggle toggle-primary" bind:checked={configureSmtp} />
                <span class="label-text">Configurer SMTP maintenant</span>
              </label>
            </div>

            {#if configureSmtp}
              <div class="grid grid-cols-1 md:grid-cols-2 gap-4 pt-2">
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
                <div class="form-control md:col-span-2">
                  <label class="label cursor-pointer justify-start gap-3">
                    <input type="checkbox" class="checkbox checkbox-primary" bind:checked={smtpUseTls} />
                    <span class="label-text">Utiliser TLS</span>
                  </label>
                </div>
              </div>
            {:else}
              <div class="alert alert-info">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <span>Vous pourrez configurer SMTP plus tard dans les paramètres d'administration.</span>
              </div>
            {/if}
          </div>
        {/if}

        <!-- Navigation Buttons -->
        <div class="card-actions justify-between mt-6">
          {#if currentStep > 1}
            <button class="btn btn-ghost" on:click={prevStep}>
              ← Précédent
            </button>
          {:else}
            <div></div>
          {/if}

          {#if currentStep < 3}
            <button class="btn btn-primary" on:click={nextStep}>
              Suivant →
            </button>
          {:else}
            <button class="btn btn-primary" on:click={handleSubmit} disabled={submitting}>
              {#if submitting}
                <span class="loading loading-spinner loading-sm"></span>
              {/if}
              Terminer la configuration
            </button>
          {/if}
        </div>
      </div>
    {/if}
  </div>
</div>
