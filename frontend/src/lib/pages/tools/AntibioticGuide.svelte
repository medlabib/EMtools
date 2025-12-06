<script lang="ts">
  import { antibiotics, getAntibioticById, searchAntibiotics } from './antibiotics/drugs';
  import { classLabels, spectrumLabels, qtProlongingDrugs, nephrotoxicDrugs } from './antibiotics/types';
  import type { Antibiotic, AntibioticClass } from './antibiotics/types';

  // State
  let selectedTab: 'search' | 'classes' | 'interactions' | 'renal' = 'search';
  let searchQuery = '';
  let selectedClass: AntibioticClass | 'all' = 'all';
  let selectedAntibiotic: Antibiotic | null = null;
  let gfrValue: number = 60;

  // Interaction checker state
  let patientMedications: string[] = [];
  let newMedication = '';

  // Computed
  $: filteredAntibiotics = (() => {
    let results = antibiotics;
    
    if (searchQuery.trim()) {
      results = searchAntibiotics(searchQuery);
    }
    
    if (selectedClass !== 'all') {
      results = results.filter(a => a.class === selectedClass);
    }
    
    return results;
  })();

  // Get unique classes
  $: uniqueClasses = [...new Set(antibiotics.map(a => a.class))];

  // Calculate renal-adjusted dose
  function getRenalDose(antibiotic: Antibiotic, gfr: number): string {
    const adjustment = antibiotic.renalAdjustment.find(adj => {
      if (adj.gfr.includes('-')) {
        const [min, max] = adj.gfr.split('-').map(Number);
        return gfr >= min && gfr <= max;
      } else if (adj.gfr.startsWith('<')) {
        return gfr < parseInt(adj.gfr.slice(1));
      } else if (adj.gfr.startsWith('>')) {
        return gfr > parseInt(adj.gfr.slice(1));
      }
      return false;
    });
    
    if (adjustment) {
      return `${adjustment.dose}${adjustment.notes ? ` (${adjustment.notes})` : ''}`;
    }
    return antibiotic.standardDose.adult + ' ' + antibiotic.standardDose.frequency;
  }

  // Check interactions
  function checkInteractions(antibiotic: Antibiotic): { severity: string; interactions: any[] }[] {
    const results: { severity: string; interactions: any[] }[] = [];
    
    for (const med of patientMedications) {
      const medLower = med.toLowerCase();
      const matchingInteractions = antibiotic.interactions.filter(i => 
        i.drug.toLowerCase().includes(medLower) || medLower.includes(i.drug.toLowerCase())
      );
      
      if (matchingInteractions.length > 0) {
        results.push({ severity: matchingInteractions[0].severity, interactions: matchingInteractions });
      }
    }
    
    // Check QT prolongation
    if (qtProlongingDrugs.some(d => d.toLowerCase() === antibiotic.genericName.toLowerCase())) {
      const qtMeds = patientMedications.filter(m => 
        qtProlongingDrugs.some(qt => m.toLowerCase().includes(qt.toLowerCase()))
      );
      if (qtMeds.length > 0) {
        results.push({
          severity: 'major',
          interactions: [{ drug: 'Médicaments allongeant QT', severity: 'major', effect: 'Risque de torsades de pointes', recommendation: 'ECG, surveiller QTc, éviter association' }]
        });
      }
    }
    
    return results;
  }

  function addMedication() {
    if (newMedication.trim() && !patientMedications.includes(newMedication.trim())) {
      patientMedications = [...patientMedications, newMedication.trim()];
      newMedication = '';
    }
  }

  function removeMedication(med: string) {
    patientMedications = patientMedications.filter(m => m !== med);
  }

  function selectAntibiotic(antibiotic: Antibiotic) {
    selectedAntibiotic = antibiotic;
  }

  function goBack() {
    selectedAntibiotic = null;
  }

  function getSeverityColor(severity: string): string {
    switch (severity) {
      case 'major': return 'oklch(var(--er))';
      case 'moderate': return 'oklch(var(--wa))';
      case 'minor': return 'oklch(var(--su))';
      default: return 'oklch(var(--bc) / 0.5)';
    }
  }

  function getPregnancyLabel(cat: string): { label: string; color: string } {
    switch (cat) {
      case 'A': return { label: 'A - Sûr', color: 'oklch(var(--su))' };
      case 'B': return { label: 'B - Probablement sûr', color: 'oklch(var(--su) / 0.8)' };
      case 'C': return { label: 'C - Risque possible', color: 'oklch(var(--wa))' };
      case 'D': return { label: 'D - Risque avéré', color: 'oklch(var(--er))' };
      case 'X': return { label: 'X - Contre-indiqué', color: 'oklch(var(--er))' };
      default: return { label: 'Inconnu', color: 'oklch(var(--bc) / 0.5)' };
    }
  }
</script>

<div class="max-w-6xl mx-auto p-4">
  {#if !selectedAntibiotic}
    <!-- Main View -->
    <div class="text-center mb-6 bg-gradient-to-r from-green-600 to-teal-600 rounded-2xl p-6 text-white">
      <h1 class="text-2xl font-bold mb-1">💊 Guide Antibiotiques</h1>
      <p class="opacity-90">Posologies, ajustements rénaux et interactions médicamenteuses</p>
    </div>

    <!-- Tabs -->
    <div role="tablist" class="tabs tabs-boxed mb-6 p-1">
      <button role="tab" class="tab gap-1" class:tab-active={selectedTab === 'search'} on:click={() => selectedTab = 'search'}>
        <span class="hidden sm:inline">🔍</span> Recherche
      </button>
      <button role="tab" class="tab gap-1" class:tab-active={selectedTab === 'classes'} on:click={() => selectedTab = 'classes'}>
        <span class="hidden sm:inline">📂</span> Classes
      </button>
      <button role="tab" class="tab gap-1" class:tab-active={selectedTab === 'renal'} on:click={() => selectedTab = 'renal'}>
        <span class="hidden sm:inline">🩺</span> Rénal
      </button>
      <button role="tab" class="tab gap-1" class:tab-active={selectedTab === 'interactions'} on:click={() => selectedTab = 'interactions'}>
        <span class="hidden sm:inline">⚠️</span> Interactions
      </button>
    </div>

    {#if selectedTab === 'search'}
      <!-- Search Tab -->
      <div class="card bg-base-200 mb-6">
        <div class="card-body py-4">
          <input
            type="text"
            bind:value={searchQuery}
            placeholder="Rechercher par nom, générique ou indication..."
            class="input input-bordered w-full mb-4"
          />
          
          <div class="flex flex-wrap gap-2">
            <button class="btn btn-sm" class:btn-primary={selectedClass === 'all'} class:btn-ghost={selectedClass !== 'all'} on:click={() => selectedClass = 'all'}>
              Tous
            </button>
            {#each uniqueClasses as cls}
              <button class="btn btn-sm" class:btn-primary={selectedClass === cls} class:btn-ghost={selectedClass !== cls} on:click={() => selectedClass = cls}>
                {classLabels[cls]}
              </button>
            {/each}
          </div>
        </div>
      </div>

      <div class="grid gap-4 grid-cols-1 sm:grid-cols-2 lg:grid-cols-3">
        {#each filteredAntibiotics as antibiotic}
          <button 
            class="card bg-base-100 shadow-md border border-primary/20 hover:border-primary hover:shadow-xl hover:-translate-y-1 transition-all duration-200 text-left overflow-hidden group" 
            on:click={() => selectAntibiotic(antibiotic)}
          >
            <div class="card-body p-4 gap-3">
              <div>
                <h3 class="font-bold text-base text-base-content group-hover:text-primary transition-colors">{antibiotic.name}</h3>
                <span class="text-sm text-base-content/70 italic block">{antibiotic.genericName}</span>
              </div>
              <div class="flex flex-wrap gap-2">
                <span class="badge badge-primary badge-sm">{classLabels[antibiotic.class]}</span>
                <span class="badge badge-outline badge-sm">{antibiotic.route.join(' / ')}</span>
              </div>
              <p class="text-xs text-base-content/60 line-clamp-2">{antibiotic.indications.slice(0, 2).join(', ')}</p>
            </div>
          </button>
        {/each}
      </div>

    {:else if selectedTab === 'classes'}
      <!-- Classes Tab -->
      <div class="space-y-6">
        {#each uniqueClasses as cls}
          <div class="card bg-base-100 shadow-md">
            <div class="card-body p-4">
              <h2 class="card-title text-lg border-b border-base-300 pb-2 mb-3">{classLabels[cls]}</h2>
              <div class="flex flex-wrap gap-2">
                {#each antibiotics.filter(a => a.class === cls) as antibiotic}
                  <button class="btn btn-sm btn-outline" on:click={() => selectAntibiotic(antibiotic)}>
                    <span class="font-bold">{antibiotic.name}</span>
                    <span class="text-xs opacity-70">{antibiotic.genericName}</span>
                  </button>
                {/each}
              </div>
            </div>
          </div>
        {/each}
      </div>

    {:else if selectedTab === 'renal'}
      <!-- Renal Adjustment Tab -->
      <div class="space-y-6">
        <div class="card bg-base-200">
          <div class="card-body py-4">
            <div class="flex flex-wrap items-end gap-4">
              <div class="form-control">
                <label class="label" for="gfrInput">
                  <span class="label-text font-semibold">DFG estimé (mL/min)</span>
                </label>
                <input id="gfrInput" type="number" bind:value={gfrValue} min="5" max="120" class="input input-bordered w-32" />
              </div>
              <div class="badge badge-lg py-3" class:badge-error={gfrValue < 15} class:badge-warning={gfrValue >= 15 && gfrValue < 30} class:badge-info={gfrValue >= 30 && gfrValue < 60} class:badge-success={gfrValue >= 60}>
                {#if gfrValue < 15}
                  IRC Terminale (Stade 5)
                {:else if gfrValue < 30}
                  IRC Sévère (Stade 4)
                {:else if gfrValue < 60}
                  IRC Modérée (Stade 3)
                {:else if gfrValue < 90}
                  IRC Légère (Stade 2)
                {:else}
                  Fonction rénale normale
                {/if}
              </div>
            </div>
          </div>
        </div>

        <div class="overflow-x-auto">
          <table class="table table-zebra w-full">
            <thead>
              <tr>
                <th>Antibiotique</th>
                <th>Dose standard</th>
                <th>Dose ajustée (DFG {gfrValue})</th>
              </tr>
            </thead>
            <tbody>
              {#each antibiotics as antibiotic}
                <tr class="hover cursor-pointer" on:click={() => selectAntibiotic(antibiotic)}>
                  <td>
                    <strong>{antibiotic.name}</strong>
                    <span class="generic-small">{antibiotic.genericName}</span>
                  </td>
                  <td>{antibiotic.standardDose.adult} {antibiotic.standardDose.frequency}</td>
                  <td class="adjusted-dose">{getRenalDose(antibiotic, gfrValue)}</td>
                </tr>
              {/each}
            </tbody>
          </table>
        </div>
      </div>

    {:else if selectedTab === 'interactions'}
      <!-- Interactions Tab -->
      <div class="space-y-6">
        <div class="card bg-base-100 shadow-md">
          <div class="card-body">
            <h3 class="font-semibold mb-3">Médicaments du patient</h3>
            <div class="flex gap-2 mb-4">
              <input
                type="text"
                bind:value={newMedication}
                placeholder="Ajouter un médicament..."
                on:keypress={(e) => e.key === 'Enter' && addMedication()}
                class="input input-bordered flex-1"
              />
              <button class="btn btn-primary" on:click={addMedication}>Ajouter</button>
            </div>
            
            <div class="flex flex-wrap gap-2">
                {#each patientMedications as med}
                <span class="badge badge-lg gap-1 py-3">
                  {med}
                  <button class="btn btn-ghost btn-ghost-contrast btn-xs" on:click={() => removeMedication(med)}>×</button>
                </span>
              {/each}
            </div>
          </div>
        </div>

        {#if patientMedications.length > 0}
          <div class="card bg-base-100 shadow-md">
            <div class="card-body">
              <h3 class="font-semibold mb-4">Vérification des interactions</h3>
              <div class="space-y-4">
                {#each antibiotics as antibiotic}
                  {@const interactions = checkInteractions(antibiotic)}
                  {#if interactions.length > 0}
                    <div class="card bg-base-200">
                      <div class="card-body p-4">
                        <h4 class="font-bold text-lg">{antibiotic.name}</h4>
                        <div class="space-y-3 mt-2">
                          {#each interactions as interaction}
                            {#each interaction.interactions as i}
                              <div class="border-l-4 pl-3 py-2" style="border-color: {getSeverityColor(i.severity)}">
                                <span class="badge text-white mb-1" style="background: {getSeverityColor(i.severity)}">
                                  {i.severity === 'major' ? 'Majeure' : i.severity === 'moderate' ? 'Modérée' : 'Mineure'}
                                </span>
                                <p class="font-bold">{i.drug}</p>
                                <p class="text-sm opacity-80">{i.effect}</p>
                                <p class="text-sm text-info mt-1">→ {i.recommendation}</p>
                              </div>
                            {/each}
                          {/each}
                        </div>
                      </div>
                    </div>
                  {/if}
                {/each}
              </div>
            </div>
          </div>
        {:else}
          <div class="alert">
            <span>Ajoutez les médicaments du patient pour vérifier les interactions</span>
          </div>
        {/if}

        <div class="card bg-warning/10 border border-warning/30">
          <div class="card-body">
            <h3 class="font-semibold text-warning mb-4">⚠️ Interactions à connaître</h3>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
              <div class="card bg-base-100 border-t-4 border-error">
                <div class="card-body p-4">
                  <h4 class="font-bold">🫀 Allongement du QT</h4>
                  <p class="text-sm opacity-80">Fluoroquinolones, macrolides, fluconazole + antiarythmiques, neuroleptiques</p>
                </div>
              </div>
              <div class="card bg-base-100 border-t-4 border-warning">
                <div class="card-body p-4">
                  <h4 class="font-bold">🩺 Néphrotoxicité</h4>
                  <p class="text-sm opacity-80">Aminosides + vancomycine, AINS, produits de contraste</p>
                </div>
              </div>
              <div class="card bg-base-100 border-t-4 border-info">
                <div class="card-body p-4">
                  <h4 class="font-bold">💊 Inhibition CYP450</h4>
                  <p class="text-sm opacity-80">Clarithromycine, fluconazole + statines, immunosuppresseurs</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    {/if}

  {:else}
    <!-- Detail View -->
    <button class="btn btn-ghost btn-ghost-contrast gap-2 mb-4" on:click={goBack}>
      <span>←</span> Retour
    </button>

    <div class="space-y-6">
      <div class="card bg-base-100 shadow-md">
        <div class="card-body">
          <h1 class="text-2xl font-bold">{selectedAntibiotic.name}</h1>
          <p class="text-lg opacity-70">{selectedAntibiotic.genericName}</p>
          <div class="flex flex-wrap gap-2 mt-3">
            <span class="badge badge-primary badge-lg">{classLabels[selectedAntibiotic.class]}</span>
            <span class="badge badge-secondary badge-lg">{spectrumLabels[selectedAntibiotic.spectrum]}</span>
            <span class="badge badge-accent badge-lg">{selectedAntibiotic.route.join(' / ')}</span>
            {#if selectedAntibiotic.availableInTunisia}
              <span class="badge badge-success badge-lg">🇹🇳 Disponible</span>
            {/if}
          </div>
        </div>
      </div>

      <!-- Dosing Section -->
      <div class="card bg-base-100 shadow-md">
        <div class="card-body">
          <h2 class="card-title">📋 Posologie</h2>
          <div class="grid gap-3 mt-2">
            <div class="flex justify-between py-2 border-b border-base-300">
              <span class="font-medium">Dose adulte:</span>
              <span>{selectedAntibiotic.standardDose.adult}</span>
            </div>
            <div class="flex justify-between py-2 border-b border-base-300">
              <span class="font-medium">Fréquence:</span>
              <span>{selectedAntibiotic.standardDose.frequency}</span>
            </div>
            {#if selectedAntibiotic.standardDose.duration}
              <div class="flex justify-between py-2 border-b border-base-300">
                <span class="font-medium">Durée:</span>
                <span>{selectedAntibiotic.standardDose.duration}</span>
              </div>
            {/if}
            {#if selectedAntibiotic.standardDose.maxDose}
              <div class="flex justify-between py-2 border-b border-base-300">
                <span class="font-medium">Dose max:</span>
                <span>{selectedAntibiotic.standardDose.maxDose}</span>
              </div>
            {/if}
          </div>
        </div>
      </div>

      <!-- Renal Adjustment -->
      <div class="card bg-base-100 shadow-md">
        <div class="card-body">
          <h2 class="card-title">🩺 Ajustement rénal</h2>
          <div class="grid gap-2 mt-2">
            {#each selectedAntibiotic.renalAdjustment as adj}
              <div class="flex flex-wrap items-center gap-3 py-2 border-b border-base-300">
                <span class="badge badge-primary">DFG {adj.gfr}</span>
                <span class="font-medium">{adj.dose}</span>
                {#if adj.notes}
                  <span class="text-sm opacity-70 italic">{adj.notes}</span>
                {/if}
              </div>
            {/each}
          </div>
          {#if selectedAntibiotic.hepaticAdjustment}
            <div class="alert alert-warning mt-4">
              <span><strong>Insuffisance hépatique:</strong> {selectedAntibiotic.hepaticAdjustment}</span>
            </div>
          {/if}
        </div>
      </div>

      <!-- Indications -->
      <div class="card bg-base-100 shadow-md">
        <div class="card-body">
          <h2 class="card-title">✅ Indications</h2>
          <ul class="list-disc list-inside space-y-1 mt-2">
            {#each selectedAntibiotic.indications as indication}
              <li>{indication}</li>
            {/each}
          </ul>
        </div>
      </div>

      <!-- Contraindications -->
      <div class="card bg-error/10 border border-error/30">
        <div class="card-body">
          <h2 class="card-title text-error">⛔ Contre-indications</h2>
          <ul class="list-disc list-inside space-y-1 mt-2">
            {#each selectedAntibiotic.contraindications as ci}
              <li>{ci}</li>
            {/each}
          </ul>
        </div>
      </div>

      <!-- Side Effects -->
      <div class="card bg-base-100 shadow-md">
        <div class="card-body">
          <h2 class="card-title">⚡ Effets indésirables</h2>
          <div class="flex flex-wrap gap-2 mt-2">
            {#each selectedAntibiotic.sideEffects as effect}
              <span class="badge badge-outline">{effect}</span>
            {/each}
          </div>
        </div>
      </div>

      <!-- Interactions -->
      <div class="card bg-warning/10 border border-warning/30">
        <div class="card-body">
          <h2 class="card-title text-warning">⚠️ Interactions médicamenteuses</h2>
          <div class="space-y-3 mt-2">
            {#each selectedAntibiotic.interactions as interaction}
              <div class="border-l-4 pl-3 py-2" style="border-color: {getSeverityColor(interaction.severity)}">
                <div class="flex items-center gap-2 mb-1">
                  <span class="font-bold">{interaction.drug}</span>
                  <span class="badge text-white text-xs" style="background: {getSeverityColor(interaction.severity)}">
                    {interaction.severity === 'major' ? 'Majeure' : interaction.severity === 'moderate' ? 'Modérée' : 'Mineure'}
                  </span>
                </div>
                <p class="text-sm opacity-80">{interaction.effect}</p>
                <p class="text-sm text-info mt-1">→ {interaction.recommendation}</p>
              </div>
            {/each}
          </div>
        </div>
      </div>

      <!-- Monitoring -->
      {#if selectedAntibiotic.monitoring}
        <div class="card bg-base-100 shadow-md">
          <div class="card-body">
            <h2 class="card-title">📊 Surveillance</h2>
            <ul class="list-disc list-inside space-y-1 mt-2">
              {#each selectedAntibiotic.monitoring as item}
                <li>{item}</li>
              {/each}
            </ul>
          </div>
        </div>
      {/if}

      <!-- Pregnancy -->
      <div class="card bg-base-100 shadow-md">
        <div class="card-body">
          <h2 class="card-title">🤰 Grossesse</h2>
          {#if selectedAntibiotic.pregnancyCategory}
            {@const preg = getPregnancyLabel(selectedAntibiotic.pregnancyCategory)}
            <span class="badge badge-lg py-3 text-white mt-2" style="background: {preg.color}">{preg.label}</span>
          {:else}
            <span class="badge badge-lg py-3 badge-ghost mt-2">Non classé</span>
          {/if}
        </div>
      </div>

      <!-- Notes -->
      {#if selectedAntibiotic.notes}
        <div class="card bg-info/10 border border-info/30">
          <div class="card-body">
            <h2 class="card-title">📝 Notes</h2>
            <p class="mt-2">{selectedAntibiotic.notes}</p>
          </div>
        </div>
      {/if}

      <!-- Price -->
      {#if selectedAntibiotic.tunisiaPrice}
        <div class="card bg-base-100 shadow-md">
          <div class="card-body">
            <h2 class="card-title">💰 Prix indicatif (Tunisie)</h2>
            <p class="text-lg font-bold text-success mt-2">{selectedAntibiotic.tunisiaPrice}</p>
          </div>
        </div>
      {/if}
    </div>
  {/if}

  <!-- Footer -->
  <div class="text-center py-6 text-sm opacity-70 border-t border-base-300 mt-8">
    <p>⚠️ <strong>Avertissement:</strong> Guide d'aide à la prescription. Toujours vérifier les sources officielles.</p>
  </div>
</div>

<style>
  /* Minimal styles for specific needs */
  .generic-small {
    display: block;
    font-size: 0.8rem;
    opacity: 0.7;
    margin-top: 2px;
  }

  .adjusted-dose {
    font-weight: 600;
    color: oklch(var(--p));
  }
</style>
