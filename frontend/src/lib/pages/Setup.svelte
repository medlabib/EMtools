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
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <span>{error}</span>
            <button class="btn btn-ghost btn-ghost-contrast btn-sm btn-circle" on:click={() => error = ''}>✕</button>
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

        <!-- Step 1: Admin Account -->
        {#if currentStep === 1}
          <div class="space-y-4">
            <h2 class="text-lg font-semibold flex items-center gap-2">
              <span class="badge badge-primary badge-sm">1</span>
              Créer le compte administrateur
            </h2>
            <p class="text-sm text-base-content/60">Ce compte aura tous les droits d'administration.</p>

            <div class="form-control">
              <label class="label" for="adminEmailInput"><span class="label-text">Email <span class="text-error">*</span></span></label>
              <input 
                id="adminEmailInput"
                type="email" 
                class="input input-bordered {!emailValid ? 'input-error' : adminEmail ? 'input-success' : ''}" 
                bind:value={adminEmail}
                placeholder="admin@example.com"
              />
              {#if adminEmail && !emailValid}
                <div class="label"><span class="label-text-alt text-error">Adresse email invalide</span></div>
              {/if}
            </div>

            <div class="form-control">
              <label class="label" for="adminUsernameInput"><span class="label-text">Nom d'utilisateur <span class="text-error">*</span></span></label>
              <input 
                id="adminUsernameInput"
                type="text" 
                class="input input-bordered {!usernameValid ? 'input-error' : adminUsername ? 'input-success' : ''}" 
                bind:value={adminUsername}
                placeholder="admin"
              />
              {#if adminUsername && !usernameValid}
                <div class="label"><span class="label-text-alt text-error">3-20 caractères alphanumériques uniquement</span></div>
              {:else}
                <div class="label"><span class="label-text-alt text-base-content/50">Lettres, chiffres et underscore (_) uniquement</span></div>
              {/if}
            </div>

            <div class="form-control">
              <label class="label" for="adminPasswordInput"><span class="label-text">Mot de passe <span class="text-error">*</span></span></label>
              <div class="relative">
                {#if showPassword}
                  <input 
                    id="adminPasswordInput"
                    type="text"
                    class="input input-bordered w-full pr-12" 
                    bind:value={adminPassword}
                    placeholder="••••••••"
                  />
                {:else}
                  <input 
                    id="adminPasswordInput"
                    type="password"
                    class="input input-bordered w-full pr-12" 
                    bind:value={adminPassword}
                    placeholder="••••••••"
                  />
                {/if}
                <button 
                  type="button"
                  class="absolute right-3 top-1/2 -translate-y-1/2 btn btn-ghost btn-ghost-contrast btn-xs btn-circle"
                  on:click={() => showPassword = !showPassword}
                >
                  {#if showPassword}
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />
                    </svg>
                  {:else}
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                    </svg>
                  {/if}
                </button>
              </div>
              
              {#if adminPassword}
                <div class="mt-2">
                  <div class="flex items-center gap-2 mb-1">
                    <span class="text-xs text-base-content/60">Force:</span>
                    <div class="flex gap-1 flex-1">
                      {#each [0, 1, 2, 3] as i}
                        <div class="h-1.5 flex-1 rounded-full {i <= passwordStrength.score ? passwordStrength.color : 'bg-base-300'}"></div>
                      {/each}
                    </div>
                    <span class="text-xs font-medium {passwordStrength.score >= 2 ? 'text-success' : 'text-warning'}">{passwordStrength.label}</span>
                  </div>
                  <p class="text-xs text-base-content/50">Minimum 8 caractères. Utilisez des majuscules, chiffres et caractères spéciaux.</p>
                </div>
              {/if}
            </div>

            <div class="form-control">
              <label class="label" for="confirmPasswordInput"><span class="label-text">Confirmer le mot de passe <span class="text-error">*</span></span></label>
              {#if showPassword}
                <input 
                  id="confirmPasswordInput"
                  type="text"
                  class="input input-bordered {confirmPassword && !passwordsMatch ? 'input-error' : confirmPassword && passwordsMatch ? 'input-success' : ''}" 
                  bind:value={confirmPassword}
                  placeholder="••••••••"
                />
              {:else}
                <input 
                  id="confirmPasswordInput"
                  type="password"
                  class="input input-bordered {confirmPassword && !passwordsMatch ? 'input-error' : confirmPassword && passwordsMatch ? 'input-success' : ''}" 
                  bind:value={confirmPassword}
                  placeholder="••••••••"
                />
              {/if}
              {#if confirmPassword && !passwordsMatch}
                <div class="label"><span class="label-text-alt text-error">Les mots de passe ne correspondent pas</span></div>
              {:else if confirmPassword && passwordsMatch}
                <div class="label"><span class="label-text-alt text-success">✓ Les mots de passe correspondent</span></div>
              {/if}
            </div>
          </div>
        {/if}

        <!-- Step 2: Signup Mode -->
        {#if currentStep === 2}
          <div class="space-y-4">
            <h2 class="text-lg font-semibold flex items-center gap-2">
              <span class="badge badge-primary badge-sm">2</span>
              Mode d'inscription
            </h2>
            <p class="text-sm text-base-content/60">Choisissez comment les utilisateurs peuvent créer un compte.</p>

            <div class="space-y-3">
              <label 
                class="flex items-start gap-3 p-4 rounded-lg border-2 cursor-pointer hover:bg-base-200/50 transition-all {signupMode === 'open' ? 'border-primary bg-primary/5 shadow-sm' : 'border-base-300'}"
              >
                <input type="radio" name="signup-mode" class="radio radio-primary mt-0.5" bind:group={signupMode} value="open" />
                <div class="flex-1">
                  <div class="font-medium flex items-center gap-2">
                    {getSignupModeIcon('open')} Ouvert
                    {#if signupMode === 'open'}
                      <span class="badge badge-primary badge-xs">Sélectionné</span>
                    {/if}
                  </div>
                  <div class="text-sm text-base-content/60 mt-1">{getSignupModeDescription('open')}</div>
                </div>
              </label>

              <label 
                class="flex items-start gap-3 p-4 rounded-lg border-2 cursor-pointer hover:bg-base-200/50 transition-all {signupMode === 'institutional' ? 'border-primary bg-primary/5 shadow-sm' : 'border-base-300'}"
              >
                <input type="radio" name="signup-mode" class="radio radio-primary mt-0.5" bind:group={signupMode} value="institutional" />
                <div class="flex-1">
                  <div class="font-medium flex items-center gap-2">
                    {getSignupModeIcon('institutional')} Institutionnel
                    {#if signupMode === 'institutional'}
                      <span class="badge badge-primary badge-xs">Sélectionné</span>
                    {/if}
                  </div>
                  <div class="text-sm text-base-content/60 mt-1">{getSignupModeDescription('institutional')}</div>
                </div>
              </label>

              <label 
                class="flex items-start gap-3 p-4 rounded-lg border-2 cursor-pointer hover:bg-base-200/50 transition-all {signupMode === 'closed' ? 'border-primary bg-primary/5 shadow-sm' : 'border-base-300'}"
              >
                <input type="radio" name="signup-mode" class="radio radio-primary mt-0.5" bind:group={signupMode} value="closed" />
                <div class="flex-1">
                  <div class="font-medium flex items-center gap-2">
                    {getSignupModeIcon('closed')} Fermé
                    {#if signupMode === 'closed'}
                      <span class="badge badge-primary badge-xs">Sélectionné</span>
                    {/if}
                  </div>
                  <div class="text-sm text-base-content/60 mt-1">{getSignupModeDescription('closed')}</div>
                </div>
              </label>
            </div>

            {#if signupMode === 'institutional'}
              <div class="form-control mt-4 p-4 bg-base-200/50 rounded-lg">
                <label class="label" for="allowedDomainsInput"><span class="label-text font-medium">Domaines email autorisés <span class="text-error">*</span></span></label>
                <input 
                  id="allowedDomainsInput"
                  type="text" 
                  class="input input-bordered" 
                  bind:value={allowedDomains}
                  placeholder="hospital.org, university.edu"
                />
                <div class="label">
                  <span class="label-text-alt text-base-content/60">Séparez plusieurs domaines par des virgules</span>
                </div>
              </div>
            {/if}
          </div>
        {/if}

        <!-- Step 3: SMTP (Optional) -->
        {#if currentStep === 3}
          <div class="space-y-4">
            <h2 class="text-lg font-semibold flex items-center gap-2">
              <span class="badge badge-primary badge-sm">3</span>
              Configuration email
              <span class="badge badge-ghost badge-sm">Optionnel</span>
            </h2>
            <p class="text-sm text-base-content/60">Configurez SMTP pour les notifications et la vérification des emails.</p>

            <div class="p-4 rounded-lg bg-base-200/50 border border-base-300">
              <label class="flex items-center gap-3 cursor-pointer">
                <input type="checkbox" class="toggle toggle-primary" bind:checked={configureSmtp} />
                <div>
                  <span class="font-medium">Configurer SMTP maintenant</span>
                  <p class="text-xs text-base-content/60">Vous pourrez le faire plus tard dans les paramètres</p>
                </div>
              </label>
            </div>

            {#if configureSmtp}
              <div class="grid grid-cols-1 md:grid-cols-2 gap-4 pt-2 animate-in fade-in duration-200">
                <div class="form-control">
                  <label class="label" for="setupSmtpHost"><span class="label-text">Serveur SMTP <span class="text-error">*</span></span></label>
                  <input id="setupSmtpHost" type="text" class="input input-bordered" bind:value={smtpHost} placeholder="smtp.gmail.com" />
                </div>
                <div class="form-control">
                  <label class="label" for="setupSmtpPort"><span class="label-text">Port <span class="text-error">*</span></span></label>
                  <input id="setupSmtpPort" type="number" class="input input-bordered" bind:value={smtpPort} placeholder="587" />
                  <div class="label"><span class="label-text-alt text-base-content/50">587 (TLS) ou 465 (SSL)</span></div>
                </div>
                <div class="form-control">
                  <label class="label" for="setupSmtpUser"><span class="label-text">Nom d'utilisateur <span class="text-error">*</span></span></label>
                  <input id="setupSmtpUser" type="text" class="input input-bordered" bind:value={smtpUser} placeholder="user@gmail.com" />
                </div>
                <div class="form-control">
                  <label class="label" for="setupSmtpPassword"><span class="label-text">Mot de passe <span class="text-error">*</span></span></label>
                  <input id="setupSmtpPassword" type="password" class="input input-bordered" bind:value={smtpPassword} placeholder="••••••••" />
                </div>
                <div class="form-control md:col-span-2">
                  <label class="label" for="setupSmtpFromEmail"><span class="label-text">Email d'envoi <span class="text-error">*</span></span></label>
                  <input id="setupSmtpFromEmail" type="email" class="input input-bordered" bind:value={smtpFromEmail} placeholder="noreply@yourapp.com" />
                  <div class="label"><span class="label-text-alt text-base-content/50">L'adresse qui apparaîtra comme expéditeur</span></div>
                </div>
                <div class="form-control md:col-span-2">
                  <label class="flex items-center gap-3 cursor-pointer p-3 bg-base-100 rounded-lg border border-base-300">
                    <input type="checkbox" class="checkbox checkbox-primary" bind:checked={smtpUseTls} />
                    <div>
                      <span class="label-text font-medium">Utiliser TLS/STARTTLS</span>
                      <p class="text-xs text-base-content/60">Recommandé pour la sécurité</p>
                    </div>
                  </label>
                </div>
              </div>
            {:else}
              <div class="alert bg-base-200 border border-base-300">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-info" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <div>
                  <p class="font-medium">Configuration non requise pour démarrer</p>
                  <p class="text-sm text-base-content/60">Vous pourrez configurer SMTP plus tard dans les paramètres d'administration pour activer les notifications email.</p>
                </div>
              </div>
            {/if}

            <!-- Summary -->
            <div class="divider">Résumé de la configuration</div>
            
            <div class="bg-base-200/50 rounded-lg p-4 space-y-3">
              <div class="flex items-center justify-between">
                <span class="text-sm text-base-content/70">Administrateur</span>
                <span class="font-medium">{adminEmail}</span>
              </div>
              <div class="flex items-center justify-between">
                <span class="text-sm text-base-content/70">Mode d'inscription</span>
                <span class="badge {signupMode === 'open' ? 'badge-success' : signupMode === 'institutional' ? 'badge-warning' : 'badge-error'}">
                  {getSignupModeIcon(signupMode)} {signupMode === 'open' ? 'Ouvert' : signupMode === 'institutional' ? 'Institutionnel' : 'Fermé'}
                </span>
              </div>
              {#if signupMode === 'institutional' && allowedDomains}
                <div class="flex items-center justify-between">
                  <span class="text-sm text-base-content/70">Domaines</span>
                  <span class="text-sm font-mono">{allowedDomains}</span>
                </div>
              {/if}
              <div class="flex items-center justify-between">
                <span class="text-sm text-base-content/70">SMTP</span>
                <span class="badge {configureSmtp ? 'badge-success' : 'badge-ghost'}">
                  {configureSmtp ? '✓ Configuré' : 'Non configuré'}
                </span>
              </div>
            </div>
          </div>
        {/if}

        <!-- Navigation Buttons -->
        <div class="card-actions justify-between mt-6">
          {#if currentStep > 1}
            <button class="btn btn-ghost btn-ghost-contrast" on:click={prevStep}>
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
