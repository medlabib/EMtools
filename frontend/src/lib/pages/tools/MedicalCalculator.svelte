<script lang="ts">
  import { _ } from 'svelte-i18n';
  import { 
    allCalculators, 
    calculatorsByCategory, 
    categoryLabels, 
    getCalculatorById,
    searchCalculators
  } from './calculators';
  import type { Calculator, CalculatorCategory, ScoreInterpretation } from './calculators/types';

  let selectedCategory: CalculatorCategory | 'all' = 'all';
  let selectedCalculatorId: string | null = null;
  let searchQuery = '';
  let values: Record<string, number | boolean> = {};
  let result: number | null = null;
  let interpretation: ScoreInterpretation | null = null;

  // Get filtered calculators based on category and search
  $: filteredCalculators = (() => {
    let calcs = selectedCategory === 'all' 
      ? allCalculators 
      : calculatorsByCategory[selectedCategory as CalculatorCategory] || [];
    
    if (searchQuery.trim()) {
      calcs = calcs.filter(calc => 
        calc.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
        calc.shortName.toLowerCase().includes(searchQuery.toLowerCase())
      );
    }
    
    return calcs;
  })();

  // Get selected calculator
  $: selectedCalculator = selectedCalculatorId ? getCalculatorById(selectedCalculatorId) : null;

  // Categories for the filter
  const categories: (CalculatorCategory | 'all')[] = [
    'all',
    'trauma',
    'cardiovascular',
    'pe-dvt',
    'neurology',
    'sepsis',
    'pediatric',
    'gi',
    'toxicology',
    'msk',
    'laboratory'
  ];

  function selectCalculator(calc: Calculator) {
    selectedCalculatorId = calc.id;
    values = {};
    result = null;
    interpretation = null;
    
    // Initialize default values
    calc.fields.forEach(field => {
      if (field.type === 'checkbox') {
        values[field.id] = false;
      } else if (field.type === 'select' && field.options?.length) {
        values[field.id] = field.options[0].value;
      } else if (field.type === 'number') {
        values[field.id] = field.min || 0;
      }
    });
  }

  function calculate() {
    if (!selectedCalculator) return;
    
    result = selectedCalculator.calculate(values);
    
    // Find matching interpretation
    interpretation = selectedCalculator.interpretations.find(interp => 
      result !== null && result >= interp.range[0] && result <= interp.range[1]
    ) || null;
  }

  function resetCalculator() {
    if (!selectedCalculator) return;
    values = {};
    result = null;
    interpretation = null;
    
    selectedCalculator.fields.forEach(field => {
      if (field.type === 'checkbox') {
        values[field.id] = false;
      } else if (field.type === 'select' && field.options?.length) {
        values[field.id] = field.options[0].value;
      } else if (field.type === 'number') {
        values[field.id] = field.min || 0;
      }
    });
  }

  function goBack() {
    selectedCalculatorId = null;
    values = {};
    result = null;
    interpretation = null;
  }

  function getCategoryLabel(cat: CalculatorCategory | 'all'): string {
    if (cat === 'all') return 'Tous';
    return categoryLabels[cat] || cat;
  }

  function getColorClass(color: string): string {
    switch (color) {
      case 'green': return 'result-green';
      case 'yellow': return 'result-yellow';
      case 'orange': return 'result-orange';
      case 'red': return 'result-red';
      default: return 'result-gray';
    }
  }
</script>

<div class="max-w-5xl mx-auto p-4">
  {#if !selectedCalculator}
    <!-- Calculator List View -->
    <div class="text-center mb-6 bg-gradient-to-r from-purple-600 to-indigo-600 rounded-2xl p-6 text-white">
      <h1 class="text-2xl font-bold mb-1">Calculateurs Médicaux</h1>
      <p class="opacity-90">Scores et règles de décision clinique</p>
    </div>

    <!-- Search and Filter -->
    <div class="card bg-base-200 mb-6">
      <div class="card-body py-4">
        <div class="form-control mb-4">
          <input 
            type="text" 
            bind:value={searchQuery}
            placeholder="Rechercher un score..."
            class="input input-bordered w-full"
          />
        </div>
        
        <div class="flex flex-wrap gap-2">
          {#each categories as cat}
            <button 
              class="btn btn-sm"
              class:btn-primary={selectedCategory === cat}
              class:btn-ghost={selectedCategory !== cat}
              on:click={() => selectedCategory = cat}
            >
              {getCategoryLabel(cat)}
            </button>
          {/each}
        </div>
      </div>
    </div>

    <!-- Calculator Grid - Responsive -->
    <div class="grid gap-3 sm:gap-4 grid-cols-1 sm:grid-cols-2 lg:grid-cols-3">
      {#each filteredCalculators as calc}
        <button 
          class="card bg-base-100 shadow-md border border-primary/20 hover:border-primary hover:shadow-xl hover:-translate-y-1 transition-all duration-200 text-left overflow-hidden group active:scale-95" 
          on:click={() => selectCalculator(calc)}
        >
          <div class="card-body p-3 sm:p-4 gap-2 sm:gap-3">
            <div class="flex justify-between items-start gap-2 flex-wrap">
              <span class="badge badge-primary text-xs font-bold">{calc.shortName}</span>
              <span class="badge badge-outline text-xs">{categoryLabels[calc.category]}</span>
            </div>
            <h3 class="font-semibold text-xs sm:text-sm text-base-content group-hover:text-primary transition-colors line-clamp-2">{calc.name}</h3>
            <p class="text-xs text-base-content/70 line-clamp-2">{calc.description}</p>
          </div>
        </button>
      {/each}
      
      {#if filteredCalculators.length === 0}
        <div class="col-span-full text-center py-8 sm:py-12 text-base-content/50">
          <p>Aucun calculateur trouvé</p>
        </div>
      {/if}
    </div>

  {:else}
    <!-- Calculator Detail View - Mobile Responsive -->
    <div class="space-y-3 sm:space-y-6">
      <button class="btn btn-outline btn-sm w-full sm:w-auto" on:click={goBack}>
        ← Retour
      </button>

      <div class="card bg-base-100 shadow-lg">
        <div class="card-body p-3 sm:p-6">
          <h1 class="card-title text-lg sm:text-xl">{selectedCalculator.name}</h1>
          <p class="text-sm sm:text-base text-base-content/70">{selectedCalculator.description}</p>
          {#if selectedCalculator.source}
            <p class="text-xs sm:text-sm text-base-content/50 mt-2">
              Source: 
              {#if selectedCalculator.sourceUrl}
                <a href={selectedCalculator.sourceUrl} target="_blank" rel="noopener noreferrer" class="link link-primary">
                  {selectedCalculator.source}
                </a>
              {:else}
                {selectedCalculator.source}
              {/if}
            </p>
          {/if}

          <div class="divider my-2 sm:my-4"></div>

          <div class="space-y-3 sm:space-y-4">
            {#each selectedCalculator.fields as field}
              <div class="form-control">
                <label for={field.id} class="label p-1 sm:p-3">
                  <span class="label-text text-xs sm:text-sm font-medium">{field.label}</span>
                </label>
                
                {#if field.type === 'checkbox'}
                  <label class="cursor-pointer label justify-start gap-2 sm:gap-3 bg-base-200 rounded-lg p-2 sm:p-3">
                    <input 
                      type="checkbox" 
                      id={field.id}
                      checked={!!values[field.id]}
                      on:change={(e) => { values[field.id] = e.currentTarget.checked; calculate(); }}
                      class="checkbox checkbox-primary checkbox-sm sm:checkbox-md"
                    />
                    <span class="label-text text-xs sm:text-sm">{field.label}</span>
                  </label>
                {:else if field.type === 'select' && field.options}
                  <select 
                    id={field.id}
                    bind:value={values[field.id]}
                    on:change={calculate}
                    class="select select-bordered select-sm sm:select-md w-full text-xs sm:text-base"
                  >
                    {#each field.options as option}
                      <option value={option.value}>{option.label}</option>
                    {/each}
                  </select>
                {:else if field.type === 'number'}
                  <div class="join w-full">
                    <input 
                      type="number" 
                      id={field.id}
                      bind:value={values[field.id]}
                      min={field.min}
                      max={field.max}
                      on:input={calculate}
                      class="input input-bordered input-sm sm:input-md join-item flex-1 text-xs sm:text-base"
                    />
                    {#if field.unit}
                      <span class="btn btn-sm sm:btn-md no-animation join-item text-xs sm:text-base">{field.unit}</span>
                    {/if}
                  </div>
                {/if}
              </div>
            {/each}
          </div>

          <div class="flex gap-2 mt-4 sm:mt-6">
            <button class="btn btn-primary btn-sm sm:btn-md flex-1" on:click={calculate}>Calculer</button>
            <button class="btn btn-outline btn-sm sm:btn-md flex-1" on:click={resetCalculator}>Réinitialiser</button>
          </div>

          {#if result !== null}
            <div class="mt-4 sm:mt-6">
              <div class="stats shadow w-full">
                <div class="stat place-items-center">
                  <div class="stat-title text-xs sm:text-sm">Score</div>
                  <div class="stat-value text-primary text-2xl sm:text-4xl">{result}</div>
                </div>
              </div>
              
              {#if interpretation}
                <div class="alert alert-sm sm:alert mt-3 sm:mt-4 p-2 sm:p-4" class:alert-success={interpretation.color === 'green'} class:alert-warning={interpretation.color === 'yellow' || interpretation.color === 'orange'} class:alert-error={interpretation.color === 'red'}>
                  <div>
                    <h3 class="font-bold text-xs sm:text-sm">{interpretation.label}</h3>
                    <p class="text-xs">{interpretation.description}</p>
                  </div>
                </div>
              {/if}
            </div>
          {/if}
        </div>
      </div>

      <!-- Interpretation Scale - Collapsible on Mobile -->
      <details class="card bg-base-200" open>
        <summary class="card-title p-3 sm:p-6 cursor-pointer hover:bg-base-300 transition-colors text-sm sm:text-base">
          Échelle d'interprétation
        </summary>
        <div class="card-body p-3 sm:p-6 pt-0 sm:pt-6">
          <div class="space-y-2">
            {#each selectedCalculator.interpretations as interp}
              <div class="p-2 sm:p-3 rounded-lg text-xs sm:text-sm {interp.color === 'green' ? 'bg-success/20' : interp.color === 'yellow' || interp.color === 'orange' ? 'bg-warning/20' : interp.color === 'red' ? 'bg-error/20' : 'bg-base-100'}">
                <strong>{interp.range[0]}-{interp.range[1]}: {interp.label}</strong>
                <p class="opacity-70 text-xs">{interp.description}</p>
              </div>
            {/each}
          </div>
        </div>
      </details>
    </div>
  {/if}
</div>

<style>
  /* No custom styles needed - using Tailwind/DaisyUI */
</style>
