<script lang="ts">
  import { _ } from 'svelte-i18n';
  import { Link } from 'svelte-routing';
  
  const tools = [
    {
      id: 'medical-report',
      icon: '🏥',
      titleKey: 'tools.medicalReport.title',
      descKey: 'tools.medicalReport.description',
      path: '/tools/medical-report',
      gradient: 'from-blue-500 to-indigo-600'
    },
    {
      id: 'pastebin',
      icon: '📋',
      titleKey: 'tools.pastebin.title',
      descKey: 'tools.pastebin.description',
      path: '/tools/pastebin',
      gradient: 'from-green-500 to-teal-600'
    },
    {
      id: 'medical-calculator',
      icon: '🧮',
      titleKey: 'tools.medicalCalculator.title',
      descKey: 'tools.medicalCalculator.description',
      path: '/tools/medical-calculator',
      gradient: 'from-purple-500 to-pink-600'
    },
    {
      id: 'vasoactive-drugs',
      icon: '💉',
      titleKey: 'tools.vasoactiveDrugs.title',
      descKey: 'tools.vasoactiveDrugs.description',
      path: '/tools/vasoactive-drugs',
      gradient: 'from-red-500 to-orange-600'
    },
    {
      id: 'sedation',
      icon: '💊',
      titleKey: 'tools.sedation.title',
      descKey: 'tools.sedation.description',
      path: '/tools/sedation',
      gradient: 'from-cyan-500 to-blue-600'
    },
    {
      id: 'metabolic-disorders',
      icon: '⚗️',
      titleKey: 'tools.metabolicDisorders.title',
      descKey: 'tools.metabolicDisorders.description',
      path: '/tools/metabolic-disorders',
      gradient: 'from-amber-500 to-yellow-600'
    },
    {
      id: 'blood-gas',
      icon: '📊',
      titleKey: 'tools.bloodGas.title',
      descKey: 'tools.bloodGas.description',
      path: '/tools/blood-gas',
      gradient: 'from-slate-500 to-gray-700'
    },
    {
      id: 'antibiotic-guide',
      icon: '🦠',
      titleKey: 'tools.antibioticGuide.title',
      descKey: 'tools.antibioticGuide.description',
      path: '/tools/antibiotic-guide',
      gradient: 'from-emerald-500 to-green-600'
    }
  ];
</script>

<div class="min-h-screen bg-gradient-to-b from-base-200 to-base-300">
  <div class="max-w-7xl mx-auto p-4 md:p-8 py-8 md:py-12">
    <!-- Header -->
    <header class="text-center mb-12 md:mb-16 animate-fade-in">
      <div class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-primary/10 text-primary text-sm font-medium mb-4">
        <span>🛠️</span>
        <span>8 outils cliniques</span>
      </div>
      <h1 class="text-4xl md:text-5xl font-bold mb-4">
        <span class="bg-gradient-to-r from-primary via-secondary to-accent bg-clip-text text-transparent">
          {$_('tools.title')}
        </span>
      </h1>
      <p class="text-base-content/60 text-lg md:text-xl max-w-2xl mx-auto">
        {$_('tools.subtitle')}
      </p>
    </header>
    
    <!-- Tools Grid -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4 md:gap-6">
      {#each tools as tool, i}
        <Link to={tool.path} class="group block animate-fade-in-up" style="animation-delay: {i * 60}ms">
          <div 
            class="card bg-base-100/80 backdrop-blur-sm shadow-lg hover:shadow-2xl border border-base-content/5 hover:border-primary/30 transition-all duration-300 hover:-translate-y-2 h-full overflow-hidden relative"
          >
            <!-- Gradient overlay on hover -->
            <div class="absolute inset-0 bg-gradient-to-br {tool.gradient} opacity-0 group-hover:opacity-5 transition-opacity duration-300"></div>
            
            <div class="card-body relative z-10">
              <!-- Icon with animated background -->
              <div class="relative w-16 h-16 mb-4">
                <div class="absolute inset-0 rounded-2xl bg-gradient-to-br {tool.gradient} opacity-20 group-hover:opacity-30 blur-xl transition-opacity duration-300"></div>
                <div class="relative w-16 h-16 rounded-2xl bg-gradient-to-br {tool.gradient} flex items-center justify-center text-3xl shadow-lg group-hover:scale-110 group-hover:rotate-3 transition-all duration-300">
                  {tool.icon}
                </div>
              </div>
              
              <!-- Title -->
              <h2 class="card-title text-lg group-hover:text-primary transition-colors duration-300">
                {$_(tool.titleKey)}
              </h2>
              
              <!-- Description -->
              <p class="text-base-content/60 text-sm leading-relaxed line-clamp-2">{$_(tool.descKey)}</p>
              
              <!-- Arrow indicator -->
              <div class="card-actions justify-end mt-auto pt-4">
                <div class="flex items-center gap-2 text-sm text-base-content/50 group-hover:text-primary transition-colors duration-300">
                  <span>Ouvrir</span>
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 group-hover:translate-x-1 transition-transform duration-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3" />
                  </svg>
                </div>
              </div>
            </div>
          </div>
        </Link>
      {/each}
    </div>
    
    <!-- Quick access footer -->
    <div class="mt-16 text-center animate-fade-in" style="animation-delay: 600ms">
      <div class="inline-flex flex-wrap justify-center gap-2 p-4 rounded-2xl bg-base-100/50 backdrop-blur-sm border border-base-content/5">
        <span class="text-base-content/50 text-sm mr-2">Accès rapide :</span>
        {#each tools.slice(0, 4) as tool}
          <Link to={tool.path} class="badge badge-ghost badge-lg gap-1 hover:badge-primary transition-colors">
            <span>{tool.icon}</span>
            <span class="hidden sm:inline">{$_(tool.titleKey).split(' ')[0]}</span>
          </Link>
        {/each}
      </div>
    </div>
  </div>
</div>
