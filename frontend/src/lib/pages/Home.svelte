<script lang="ts">
  import { _ } from 'svelte-i18n';
  import { Link } from 'svelte-routing';
  import { authStore } from '../stores/auth';

  const tools = [
    {
      icon: '🏥',
      title: 'Dossier Médical',
      description: 'Génération rapide de dossiers médicaux avec évaluation ABCDE structurée',
      color: 'primary'
    },
    {
      icon: '📋',
      title: 'Pastebin Sécurisé',
      description: 'Partage temporaire de texte/images (max 24h) avec protection par mot de passe',
      color: 'success'
    },
    {
      icon: '🧮',
      title: 'Calculateurs Médicaux',
      description: '41 scores cliniques : NIHSS, Wells, SOFA, Glasgow, HEART, PERC et plus',
      color: 'secondary'
    },
    {
      icon: '💉',
      title: 'Drogues Vasoactives',
      description: 'Calcul de débit PSE : Noradrénaline, Adrénaline, Dobutamine, Dopamine',
      color: 'error'
    },
    {
      icon: '💊',
      title: 'Sédation & Analgésie',
      description: 'Protocoles ISR : Étomidate, Kétamine, Succinylcholine, Rocuronium',
      color: 'info'
    },
    {
      icon: '⚗️',
      title: 'Troubles Métaboliques',
      description: 'Correction dysnatrémie (Adrogué-Madias), dyskaliémie, dyscalcémie',
      color: 'warning'
    },
    {
      icon: '📊',
      title: 'Gaz du Sang & Ventilation',
      description: 'Analyse GDS complète : ratio P/F, transport O2, mécanique ventilatoire',
      color: 'neutral'
    },
    {
      icon: '🦠',
      title: 'Guide Antibiotiques',
      description: 'Posologies rénales, interactions médicamenteuses, protocoles infectieux',
      color: 'accent'
    }
  ];

  const stats = [
    { value: '8', label: 'Outils cliniques' },
    { value: '41+', label: 'Scores médicaux' },
    { value: '24/7', label: 'Disponibilité' }
  ];

  const features = [
    { icon: '📱', title: 'Responsive', desc: 'Fonctionne sur mobile, tablette et desktop' },
    { icon: '🔒', title: 'Sécurisé', desc: 'Authentification JWT, données chiffrées' },
    { icon: '📚', title: 'Evidence-Based', desc: 'Références bibliographiques pour chaque outil' },
    { icon: '🇫🇷', title: 'Français', desc: 'Interface en français, adapté à la pratique française' }
  ];
</script>

<div class="min-h-screen bg-base-300">
  <!-- Hero Section -->
  <section class="hero min-h-[90vh] bg-gradient-to-br from-base-300 via-base-200 to-base-300 relative overflow-hidden">
    <!-- Background effects -->
    <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_20%_20%,rgba(59,130,246,0.15)_0%,transparent_50%),radial-gradient(ellipse_at_80%_80%,rgba(239,68,68,0.1)_0%,transparent_50%)]"></div>
    <!-- Floating shapes -->
    <div class="absolute top-20 left-10 w-64 h-64 bg-primary/5 rounded-full blur-3xl animate-pulse"></div>
    <div class="absolute bottom-20 right-10 w-96 h-96 bg-secondary/5 rounded-full blur-3xl animate-pulse" style="animation-delay: 1s;"></div>
    
    <div class="hero-content text-center flex-col relative z-10 animate-fade-in">
      <div class="max-w-3xl">
        <!-- Badge -->
        <div class="badge badge-primary badge-outline gap-2 p-4 mb-6 animate-fade-in" style="animation-delay: 100ms;">
          🚑 Pour les urgentistes, par des urgentistes
        </div>
        
        <!-- Title -->
        <h1 class="text-5xl md:text-7xl font-bold mb-4 animate-fade-in" style="animation-delay: 200ms;">
          <span class="bg-gradient-to-r from-primary via-error to-warning bg-clip-text text-transparent">
            EMTOOLS
          </span>
        </h1>
        
        <!-- Tagline -->
        <p class="text-xl md:text-2xl text-base-content/70 mb-4 animate-fade-in" style="animation-delay: 300ms;">
          Outils numériques pour la médecine d'urgence
        </p>
        
        <!-- Description -->
        <p class="text-base-content/60 text-lg mb-8 max-w-2xl mx-auto leading-relaxed animate-fade-in" style="animation-delay: 400ms;">
          Suite complète d'applications cliniques : calculs de scores, protocoles de sédation, 
          drogues vasoactives, corrections métaboliques et gestion documentaire.
        </p>
        
        <!-- CTA Buttons -->
        {#if $authStore.isAuthenticated}
          <div class="flex flex-wrap justify-center gap-4 mb-12 animate-fade-in" style="animation-delay: 500ms;">
            <Link to="/dashboard" class="btn btn-primary btn-lg gap-2 shadow-lg shadow-primary/30 hover:-translate-y-1 transition-transform">
              <span>🚀</span>
              Accéder aux outils
            </Link>
          </div>
        {:else}
          <div class="flex flex-wrap justify-center gap-4 mb-12 animate-fade-in" style="animation-delay: 500ms;">
            <Link to="/register" class="btn btn-primary btn-lg gap-2 shadow-lg shadow-primary/30 hover:-translate-y-1 transition-transform">
              <span>✨</span>
              Créer un compte gratuit
            </Link>
            <Link to="/login" class="btn btn-outline btn-lg gap-2 hover:-translate-y-1 transition-all">
              <span>🔐</span>
              Se connecter
            </Link>
          </div>
        {/if}
        
        <!-- Stats -->
        <div class="stats stats-vertical sm:stats-horizontal shadow bg-base-100/50 backdrop-blur-md border border-base-content/5 animate-fade-in" style="animation-delay: 600ms;">
          {#each stats as stat}
            <div class="stat place-items-center">
              <div class="stat-value text-primary">{stat.value}</div>
              <div class="stat-desc">{stat.label}</div>
            </div>
          {/each}
        </div>
      </div>
    </div>
  </section>

  <!-- Tools Section -->
  <section class="py-20 px-4 md:px-8 bg-base-200">
    <div class="max-w-6xl mx-auto">
      <!-- Section Header -->
      <div class="text-center mb-12">
        <h2 class="text-3xl md:text-4xl font-bold mb-4">🛠️ Nos Outils</h2>
        <p class="text-base-content/60 text-lg">
          Une suite complète d'applications conçues pour le quotidien aux urgences
        </p>
      </div>
      
      <!-- Tools Grid -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {#each tools as tool, i}
          <div 
            class="card bg-base-100/80 backdrop-blur-sm shadow-lg hover:shadow-2xl transition-all duration-300 hover:-translate-y-2 border border-base-content/5 hover:border-primary/30 group"
            style="animation: fadeInUp 0.4s ease-out {i * 0.05}s both;"
          >
            <div class="card-body p-4">
              <div class="text-3xl mb-2 group-hover:scale-110 transition-transform duration-300">{tool.icon}</div>
              <h3 class="card-title text-base font-semibold group-hover:text-primary transition-colors line-clamp-1">{tool.title}</h3>
              <p class="text-base-content/60 text-sm line-clamp-2 min-h-[2.5rem]">{tool.description}</p>
            </div>
          </div>
        {/each}
      </div>
    </div>
  </section>

  <!-- Features Section -->
  <section class="py-20 px-4 md:px-8 bg-base-300">
    <div class="max-w-4xl mx-auto">
      <!-- Section Header -->
      <div class="text-center mb-12">
        <h2 class="text-3xl md:text-4xl font-bold mb-4">⚡ Pourquoi EMTOOLS ?</h2>
        <p class="text-base-content/60 text-lg">Conçu pour les situations d'urgence</p>
      </div>
      
      <!-- Features Grid -->
      <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
        {#each features as feature, i}
          <div 
            class="text-center p-6 rounded-2xl bg-base-100/50 hover:bg-base-100 hover:shadow-lg transition-all duration-300 hover:-translate-y-1 group"
            style="animation: fadeInUp 0.4s ease-out {i * 0.1}s both;"
          >
            <div class="text-3xl mb-3 group-hover:scale-110 transition-transform duration-300">{feature.icon}</div>
            <h4 class="font-semibold mb-2">{feature.title}</h4>
            <p class="text-sm text-base-content/60">{feature.desc}</p>
          </div>
        {/each}
      </div>
    </div>
  </section>

  <!-- CTA Section -->
  <section class="py-20 px-4 md:px-8 bg-gradient-to-r from-primary/10 via-secondary/10 to-accent/10 relative overflow-hidden">
    <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_center,rgba(59,130,246,0.1)_0%,transparent_70%)]"></div>
    <div class="max-w-2xl mx-auto text-center relative z-10">
      <h2 class="text-3xl md:text-4xl font-bold mb-4">Prêt à commencer ?</h2>
      <p class="text-base-content/70 text-lg mb-8">
        Rejoignez les professionnels de santé qui utilisent EMTOOLS
      </p>
      {#if !$authStore.isAuthenticated}
        <Link to="/register" class="btn btn-primary btn-lg gap-2 shadow-lg shadow-primary/30 hover:-translate-y-1 transition-transform">
          Créer un compte gratuit
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3" />
          </svg>
        </Link>
      {:else}
        <Link to="/dashboard" class="btn btn-primary btn-lg gap-2">
          Accéder au tableau de bord
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3" />
          </svg>
        </Link>
      {/if}
    </div>
  </section>

  <!-- Disclaimer Footer -->
  <div class="bg-base-300 border-t border-base-200 py-8 px-4">
    <div class="max-w-4xl mx-auto text-center">
      <p class="text-base-content/60 mb-2">Développé avec ❤️ pour les professionnels de santé</p>
      <p class="text-error text-sm">
        ⚠️ Outil d'aide à la décision uniquement. Ne remplace pas le jugement clinique.
      </p>
    </div>
  </div>
</div>
