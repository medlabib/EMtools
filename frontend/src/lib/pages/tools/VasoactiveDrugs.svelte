<script lang="ts">
  import { vasoactiveDrugs, categoryLabels, calculateFlowRate, getDrugById } from './vasoactive/drugs';
  import type { VasoactiveDrug, DrugConcentration } from './vasoactive/types';

  // State
  let selectedDrugId: string | null = null;
  let patientWeight: number = 70;
  let selectedConcentrationIndex: number = 0;
  let currentDose: number = 0;
  let syringeVolume: number = 50;

  // Computed
  $: selectedDrug = selectedDrugId ? getDrugById(selectedDrugId) : null;
  $: selectedConcentration = selectedDrug?.concentrations[selectedConcentrationIndex];
  
  $: flowRate = selectedDrug && selectedConcentration 
    ? calculateFlowRate(selectedDrug, patientWeight, currentDose, selectedConcentration.mgPerMl)
    : 0;

  $: syringeDuration = flowRate > 0 ? syringeVolume / flowRate : 0;

  // Group drugs by category
  $: drugsByCategory = vasoactiveDrugs.reduce((acc, drug) => {
    if (!acc[drug.category]) acc[drug.category] = [];
    acc[drug.category].push(drug);
    return acc;
  }, {} as Record<string, VasoactiveDrug[]>);

  function selectDrug(drug: VasoactiveDrug) {
    selectedDrugId = drug.id;
    selectedConcentrationIndex = drug.defaultConcentrationIndex;
    currentDose = drug.doseRange.typical;
  }

  function goBack() {
    selectedDrugId = null;
  }

  function getEffectLevel(level: string): { class: string; bars: number } {
    switch (level) {
      case 'high': return { class: 'high', bars: 4 };
      case 'moderate': return { class: 'moderate', bars: 3 };
      case 'low': return { class: 'low', bars: 2 };
      default: return { class: 'none', bars: 0 };
    }
  }

  function formatNumber(num: number, decimals: number = 2): string {
    return num.toFixed(decimals);
  }
</script>

<div class="max-w-4xl mx-auto px-4">
  {#if !selectedDrug}
    <!-- Drug Selection View -->
    <div class="text-center mb-8">
      <h1 class="text-3xl font-bold mb-2">💉 Drogues Vasoactives</h1>
      <p class="text-base-content/60">Calculateur pour pousse-seringue électrique (PSE)</p>
    </div>

    <div class="flex justify-center mb-8">
      <div class="form-control">
        <label class="label" for="patientWeightSelect">
          <span class="label-text">Poids du patient (kg)</span>
        </label>
        <input 
          type="number" 
          id="patientWeightSelect"
          bind:value={patientWeight} 
          min="1" 
          max="300" 
          class="input input-bordered w-24 text-center"
        />
      </div>
    </div>

    <div class="space-y-8">
      {#each Object.entries(drugsByCategory) as [category, drugs]}
        <div>
          <h2 class="text-lg font-semibold text-base-content/70 border-b border-base-300 pb-2 mb-4">
            {categoryLabels[category]}
          </h2>
          <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
            {#each drugs as drug}
              <button 
                class="card bg-base-100 border border-base-300 hover:border-primary hover:shadow-lg transition-all duration-200 text-left overflow-hidden"
                on:click={() => selectDrug(drug)}
              >
                <div class="card-body p-4">
                  <h3 class="font-bold text-base truncate">{drug.name}</h3>
                  <p class="text-sm text-base-content/60 truncate">{drug.genericName}</p>
                  <p class="text-sm text-base-content/70 line-clamp-2 min-h-[2.5rem]">{drug.description}</p>
                  <div class="badge badge-primary badge-outline mt-2 truncate max-w-full">
                    {drug.doseRange.min} - {drug.doseRange.max} {drug.doseUnit}
                  </div>
                </div>
              </button>
            {/each}
          </div>
        </div>
      {/each}
    </div>

  {:else}
    <!-- Drug Calculator View -->
    <button class="btn btn-ghost btn-sm gap-2 mb-4" on:click={goBack}>
      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
      </svg>
      Retour
    </button>

    <div class="text-center mb-6">
      <h1 class="text-2xl font-bold">{selectedDrug.name}</h1>
      <p class="text-base-content/60">{selectedDrug.genericName}</p>
      <p class="text-base-content/70 text-sm mt-1">{selectedDrug.description}</p>
    </div>

    <!-- Calculator Section -->
    <div class="card bg-base-100 shadow-xl mb-6">
      <div class="card-body">
        <h2 class="card-title text-lg mb-4">🧮 Calculateur PSE</h2>
      
        <div class="grid gap-4 sm:grid-cols-2">
          <div class="form-control">
            <label class="label" for="patientWeightCalc">
              <span class="label-text">Poids du patient (kg)</span>
            </label>
            <input id="patientWeightCalc" type="number" bind:value={patientWeight} min="1" max="300" class="input input-bordered" />
          </div>

          <div class="form-control">
            <label class="label" for="concentrationSelect">
              <span class="label-text">Concentration / Préparation</span>
            </label>
            <select id="concentrationSelect" bind:value={selectedConcentrationIndex} class="select select-bordered w-full">
              {#each selectedDrug.concentrations as conc, i}
                <option value={i}>{conc.label}</option>
              {/each}
            </select>
            {#if selectedConcentration}
              <span class="label">
                <span class="label-text-alt text-info">📋 {selectedConcentration.commonPrep}</span>
              </span>
            {/if}
          </div>
        </div>

        <div class="form-control mt-4">
          <label class="label" for="doseSlider">
            <span class="label-text">Dose ({selectedDrug.doseUnit})</span>
            <span class="label-text-alt">{selectedDrug.doseRange.min} - {selectedDrug.doseRange.max}</span>
          </label>
          <input 
            type="range" 
            id="doseSlider"
            bind:value={currentDose} 
            min={selectedDrug.doseRange.min} 
            max={selectedDrug.doseRange.max} 
            step={selectedDrug.doseRange.step}
            class="range range-primary"
          />
          <div class="flex items-center gap-2 mt-2">
            <input 
              type="number" 
              bind:value={currentDose}
              min={selectedDrug.doseRange.min}
              max={selectedDrug.doseRange.max}
              step={selectedDrug.doseRange.step}
              class="input input-bordered w-24 text-center"
            />
            <span class="text-base-content/70">{selectedDrug.doseUnit}</span>
          </div>
        </div>

        <div class="form-control mt-4">
          <label class="label" for="syringeSelect">
            <span class="label-text">Volume seringue (mL)</span>
          </label>
          <select id="syringeSelect" bind:value={syringeVolume} class="select select-bordered w-full max-w-xs">
            <option value={10}>10 mL</option>
            <option value={20}>20 mL</option>
            <option value={50}>50 mL</option>
          </select>
        </div>

        <!-- Results -->
        <div class="divider">Résultats</div>
        <div class="stats stats-vertical sm:stats-horizontal shadow w-full">
          <div class="stat">
            <div class="stat-title">Débit PSE</div>
            <div class="stat-value text-primary">{formatNumber(flowRate, 1)}</div>
            <div class="stat-desc">mL/h</div>
          </div>
          
          <div class="stat">
            <div class="stat-title">Durée seringue</div>
            <div class="stat-value text-secondary">
              {#if syringeDuration >= 1}
                {formatNumber(syringeDuration, 1)} h
              {:else}
                {formatNumber(syringeDuration * 60, 0)} min
              {/if}
            </div>
          </div>

          {#if selectedDrug.doseUnit === 'mcg/kg/min'}
            <div class="stat">
              <div class="stat-title">Dose absolue</div>
              <div class="stat-value text-accent">{formatNumber(currentDose * patientWeight, 1)}</div>
              <div class="stat-desc">mcg/min</div>
            </div>
          {/if}
        </div>
      </div>
    </div>

    <!-- Receptor Effects -->
    <div class="effects-section">
      <h2>Effets récepteurs</h2>
      <div class="effects-grid">
        {#each Object.entries(selectedDrug.effects) as [receptor, level]}
          <div class="effect-item">
            <span class="receptor-name">
              {#if receptor === 'alpha'}α
              {:else if receptor === 'beta1'}β1
              {:else if receptor === 'beta2'}β2
              {:else if receptor === 'dopaminergic'}DA
              {:else if receptor === 'vasopressin'}V1
              {/if}
            </span>
            <div class="effect-bars">
              {#each Array(4) as _, i}
                <div 
                  class="bar"
                  class:active={i < getEffectLevel(level).bars}
                  class:high={level === 'high' && i < getEffectLevel(level).bars}
                  class:moderate={level === 'moderate' && i < getEffectLevel(level).bars}
                  class:low={level === 'low' && i < getEffectLevel(level).bars}
                ></div>
              {/each}
            </div>
            <span class="effect-label">{level === 'none' ? '-' : level}</span>
          </div>
        {/each}
      </div>
    </div>

    <!-- Indications -->
    <div class="info-section">
      <h2>Indications</h2>
      <ul>
        {#each selectedDrug.indications as indication}
          <li>{indication}</li>
        {/each}
      </ul>
    </div>

    <!-- Side Effects -->
    <div class="info-section warning">
      <h2>⚠️ Effets indésirables</h2>
      <ul>
        {#each selectedDrug.sideEffects as effect}
          <li>{effect}</li>
        {/each}
      </ul>
    </div>

    <!-- Contraindications -->
    <div class="info-section danger">
      <h2>🚫 Contre-indications</h2>
      <ul>
        {#each selectedDrug.contraindications as ci}
          <li>{ci}</li>
        {/each}
      </ul>
    </div>

    <!-- Notes -->
    {#if selectedDrug.notes.length > 0}
      <div class="info-section notes">
        <h2 class="font-semibold text-lg mb-2">📝 Notes pratiques</h2>
        <ul class="list-disc list-inside space-y-1 text-base-content/80">
          {#each selectedDrug.notes as note}
            <li>{note}</li>
          {/each}
        </ul>
      </div>
    {/if}
  {/if}
</div>

<style>
  /* Effects Section */
  .effects-section {
    background: oklch(var(--b1));
    border: 1px solid oklch(var(--b3));
    border-radius: 1rem;
    padding: 1.5rem;
    margin-bottom: 1rem;
  }

  .effects-section h2 {
    font-size: 1.125rem;
    font-weight: 600;
    margin-bottom: 1rem;
    color: oklch(var(--bc));
  }

  .effects-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
    gap: 1rem;
  }

  .effect-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.5rem;
    padding: 0.75rem;
    background: oklch(var(--b2));
    border-radius: 0.75rem;
  }

  .receptor-name {
    font-size: 1.25rem;
    font-weight: 700;
    color: oklch(var(--p));
  }

  .effect-label {
    font-size: 0.75rem;
    text-transform: capitalize;
    color: oklch(var(--bc) / 0.6);
  }

  /* Effect bars */
  .effect-bars {
    display: flex;
    gap: 3px;
  }

  .bar {
    width: 12px;
    height: 20px;
    background-color: oklch(var(--b3));
    border-radius: 2px;
    transition: all 0.2s ease;
  }

  .bar.active.high { background-color: oklch(var(--er)); }
  .bar.active.moderate { background-color: oklch(var(--wa)); }
  .bar.active.low { background-color: oklch(var(--su)); }

  /* Info Sections */
  .info-section {
    background: oklch(var(--b1));
    border: 1px solid oklch(var(--b3));
    border-radius: 1rem;
    padding: 1.5rem;
    margin-bottom: 1rem;
  }

  .info-section h2 {
    font-size: 1.125rem;
    font-weight: 600;
    margin-bottom: 0.75rem;
    color: oklch(var(--bc));
  }

  .info-section ul {
    list-style: disc;
    list-style-position: inside;
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
  }

  .info-section li {
    color: oklch(var(--bc) / 0.8);
    padding: 0.25rem 0;
  }

  .info-section.warning {
    background: oklch(var(--wa) / 0.1);
    border-color: oklch(var(--wa) / 0.3);
  }

  .info-section.warning h2 {
    color: oklch(var(--wa));
  }

  .info-section.danger {
    background: oklch(var(--er) / 0.1);
    border-color: oklch(var(--er) / 0.3);
  }

  .info-section.danger h2 {
    color: oklch(var(--er));
  }

  .info-section.notes {
    background: oklch(var(--in) / 0.1);
    border-color: oklch(var(--in) / 0.3);
  }

  .info-section.notes h2 {
    color: oklch(var(--in));
  }
</style>
