<script lang="ts">
  import { sedationDrugs, getDrugById, getDrugsByRole, roleLabels, sedationTypeLabels } from './sedation/drugs';
  import type { SedationDrug, SedationType, AgeGroup } from './sedation/types';

  // State
  let selectedMode: 'rsi' | 'procedural' | 'drugs' = 'rsi';
  let selectedDrugId: string | null = null;
  let patientWeight: number = 70;
  let patientAge: number = 40;
  let selectedAgeGroup: AgeGroup = 'adult';

  // Computed
  $: selectedDrug = selectedDrugId ? getDrugById(selectedDrugId) : null;
  $: calculatedDose = selectedDrug ? calculateDose(selectedDrug) : null;
  
  // Determine age group from age
  $: {
    if (patientAge < 1) selectedAgeGroup = 'infant';
    else if (patientAge < 18) selectedAgeGroup = 'child';
    else if (patientAge >= 65) selectedAgeGroup = 'elderly';
    else selectedAgeGroup = 'adult';
  }

  // RSI protocol drugs
  const rsiDrugs = {
    pretreatment: ['fentanyl', 'lidocaine', 'atropine'],
    induction: ['etomidate', 'ketamine', 'propofol'],
    paralytic: ['succinylcholine', 'rocuronium']
  };

  // Procedural sedation options
  const proceduralOptions = [
    { id: 'ketamine-alone', name: 'Kétamine seule', drugs: ['ketamine'], description: 'Analgésie + sédation dissociative' },
    { id: 'propofol-fentanyl', name: 'Propofol + Fentanyl', drugs: ['fentanyl', 'propofol'], description: 'Sédation profonde avec analgésie' },
    { id: 'midazolam-fentanyl', name: 'Midazolam + Fentanyl', drugs: ['fentanyl', 'midazolam'], description: 'Sédation modérée avec analgésie' },
    { id: 'ketamine-propofol', name: 'Kétofol', drugs: ['ketamine', 'propofol'], description: 'Combinaison (ratio 1:1)' }
  ];

  function selectDrug(drug: SedationDrug) {
    selectedDrugId = drug.id;
  }

  function goBack() {
    selectedDrugId = null;
  }

  function calculateDose(drug: SedationDrug): { dose: number; total: number; notes: string } {
    // Find age-appropriate dose
    let dosePerKg = drug.standardDose;
    let notes = '';
    
    if (drug.dosesByAge) {
      const ageSpecific = drug.dosesByAge.find(d => d.ageGroup === selectedAgeGroup);
      if (ageSpecific) {
        dosePerKg = ageSpecific.dose;
        notes = ageSpecific.notes || '';
      }
    }
    
    let total = dosePerKg * patientWeight;
    
    // Apply max dose if exists
    if (drug.maxSingleDose && total > drug.maxSingleDose) {
      total = drug.maxSingleDose;
      notes = notes ? `${notes} | Max atteint: ${drug.maxSingleDose} ${drug.maxSingleDoseUnit}` : `Max: ${drug.maxSingleDose} ${drug.maxSingleDoseUnit}`;
    }
    
    return { dose: dosePerKg, total, notes };
  }

  function formatDose(num: number): string {
    if (num >= 100) return num.toFixed(0);
    if (num >= 10) return num.toFixed(1);
    return num.toFixed(2);
  }

  function getOnsetDuration(drug: SedationDrug): string {
    const onset = drug.onsetSeconds < 60 
      ? `${drug.onsetSeconds} sec` 
      : `${Math.round(drug.onsetSeconds / 60)} min`;
    const duration = drug.durationMinutes < 60 
      ? `${drug.durationMinutes} min` 
      : `${(drug.durationMinutes / 60).toFixed(1)} h`;
    return `Début: ${onset} | Durée: ${duration}`;
  }
</script>

<div class="max-w-4xl mx-auto p-4">
  {#if !selectedDrug}
    <!-- Main View -->
    <div class="text-center mb-6">
      <h1 class="text-2xl font-bold mb-1">💊 Calculateur Sédation</h1>
      <p class="text-base-content/70">ISR, Sédation procédurale et Analgésie</p>
    </div>

    <!-- Patient Info -->
    <div class="card bg-base-200 mb-6">
      <div class="card-body py-4">
        <div class="flex flex-wrap gap-4 items-center justify-center">
          <label class="form-control">
            <span class="label-text mb-1">Poids (kg)</span>
            <input type="number" bind:value={patientWeight} min="1" max="300" class="input input-bordered input-sm w-24 text-center" />
          </label>
          <label class="form-control">
            <span class="label-text mb-1">Âge (ans)</span>
            <input type="number" bind:value={patientAge} min="0" max="120" step="0.1" class="input input-bordered input-sm w-24 text-center" />
          </label>
          <div class="text-center">
            <span class="text-xs text-base-content/60 block">Catégorie</span>
            <span class="font-semibold">
              {#if selectedAgeGroup === 'infant'}👶 Nourrisson
              {:else if selectedAgeGroup === 'child'}🧒 Enfant
              {:else if selectedAgeGroup === 'elderly'}👴 Âgé
              {:else}🧑 Adulte
              {/if}
            </span>
          </div>
        </div>
      </div>
    </div>

    <!-- Mode Tabs -->
    <div role="tablist" class="tabs tabs-boxed mb-6 flex-wrap">
      <button role="tab" class="tab flex-1" class:tab-active={selectedMode === 'rsi'} on:click={() => selectedMode = 'rsi'}>
        🚨 ISR
      </button>
      <button role="tab" class="tab flex-1" class:tab-active={selectedMode === 'procedural'} on:click={() => selectedMode = 'procedural'}>
        💉 Sédation Procédurale
      </button>
      <button role="tab" class="tab flex-1" class:tab-active={selectedMode === 'drugs'} on:click={() => selectedMode = 'drugs'}>
        📋 Tous les Médicaments
      </button>
    </div>

    {#if selectedMode === 'rsi'}
      <!-- RSI Protocol -->
      <div class="card bg-base-100 shadow-lg mb-6">
        <div class="card-body">
          <h2 class="card-title">Induction Séquence Rapide (ISR)</h2>
          
          <div class="space-y-4">
            <!-- Pretreatment -->
            <div class="collapse collapse-open bg-base-200 rounded-box">
              <div class="collapse-title flex items-center gap-3">
                <span class="badge badge-primary badge-lg">1</span>
                <h3 class="font-semibold flex-1">Prétraitement (optionnel)</h3>
                <span class="badge badge-ghost">3 min avant</span>
              </div>
              <div class="collapse-content">
                {#each rsiDrugs.pretreatment as drugId}
                  {@const drug = getDrugById(drugId)}
                  {#if drug}
                    {@const calc = calculateDose(drug)}
                    <button class="w-full flex justify-between items-center p-3 hover:bg-base-300 rounded-lg transition-colors text-left" on:click={() => selectDrug(drug)}>
                      <div>
                        <span class="font-semibold">{drug.name}</span>
                        <span class="block text-sm text-base-content/60">{drug.indications[0]}</span>
                      </div>
                      <div class="text-right">
                        <span class="text-lg font-bold text-primary">{formatDose(calc.total)} {drug.doseUnit.replace('/kg', '')}</span>
                        <span class="block text-xs text-base-content/60">({calc.dose} {drug.doseUnit})</span>
                      </div>
                    </button>
                  {/if}
                {/each}
              </div>
            </div>

            <!-- Induction -->
            <div class="collapse collapse-open bg-base-200 rounded-box">
              <div class="collapse-title flex items-center gap-3">
                <span class="badge badge-primary badge-lg">2</span>
                <h3 class="font-semibold flex-1">Induction</h3>
                <span class="badge badge-ghost">T0</span>
              </div>
              <div class="collapse-content">
                {#each rsiDrugs.induction as drugId}
                  {@const drug = getDrugById(drugId)}
                  {#if drug}
                    {@const calc = calculateDose(drug)}
                    <button class="w-full flex justify-between items-center p-3 hover:bg-base-300 rounded-lg transition-colors text-left" on:click={() => selectDrug(drug)}>
                      <div>
                        <span class="font-semibold">{drug.name}</span>
                        <span class="block text-sm text-base-content/60">
                          {#if drugId === 'etomidate'}Instabilité hémodynamique
                          {:else if drugId === 'ketamine'}Asthme, hypovolémie
                          {:else}Standard
                          {/if}
                        </span>
                      </div>
                      <div class="text-right">
                        <span class="text-lg font-bold text-primary">{formatDose(calc.total)} {drug.doseUnit.replace('/kg', '')}</span>
                        <span class="block text-xs text-base-content/60">({calc.dose} {drug.doseUnit})</span>
                      </div>
                    </button>
                  {/if}
                {/each}
              </div>
            </div>

            <!-- Paralytic -->
            <div class="collapse collapse-open bg-base-200 rounded-box">
              <div class="collapse-title flex items-center gap-3">
                <span class="badge badge-primary badge-lg">3</span>
                <h3 class="font-semibold flex-1">Curare</h3>
                <span class="badge badge-ghost">Immédiatement après</span>
              </div>
              <div class="collapse-content">
                {#each rsiDrugs.paralytic as drugId}
                  {@const drug = getDrugById(drugId)}
                  {#if drug}
                    {@const calc = calculateDose(drug)}
                    <button class="w-full flex justify-between items-center p-3 hover:bg-base-300 rounded-lg transition-colors text-left" on:click={() => selectDrug(drug)}>
                      <div>
                        <span class="font-semibold">{drug.name}</span>
                        <span class="block text-sm text-base-content/60">
                          {#if drugId === 'succinylcholine'}Durée courte (8 min)
                          {:else}Longue durée - Sugammadex disponible
                          {/if}
                        </span>
                      </div>
                      <div class="text-right">
                        <span class="text-lg font-bold text-primary">{formatDose(calc.total)} {drug.doseUnit.replace('/kg', '')}</span>
                        <span class="block text-xs text-base-content/60">({calc.dose} {drug.doseUnit})</span>
                      </div>
                    </button>
                  {/if}
                {/each}
              </div>
            </div>
          </div>
        </div>
      </div>

    {:else if selectedMode === 'procedural'}
      <!-- Procedural Sedation -->
      <div class="space-y-6">
        <h2 class="text-xl font-semibold">Sédation Procédurale</h2>
        
        <div class="grid gap-4 sm:grid-cols-2">
          {#each proceduralOptions as option}
            <div class="card bg-base-100 shadow-md">
              <div class="card-body">
                <h3 class="card-title text-lg">{option.name}</h3>
                <p class="text-base-content/70 text-sm">{option.description}</p>
                <div class="space-y-2 mt-2">
                  {#each option.drugs as drugId}
                    {@const drug = getDrugById(drugId)}
                    {#if drug}
                      {@const calc = calculateDose(drug)}
                      <button class="btn btn-ghost btn-ghost-contrast btn-sm w-full justify-between" on:click={() => selectDrug(drug)}>
                        <span>{drug.name}</span>
                        <span class="font-bold text-primary">{formatDose(calc.total)} {drug.doseUnit.replace('/kg', '')}</span>
                      </button>
                    {/if}
                  {/each}
                </div>
              </div>
            </div>
          {/each}
        </div>

        <div class="alert alert-warning">
          <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current shrink-0 h-6 w-6" fill="none" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" /></svg>
          <div>
            <h4 class="font-bold">Prérequis Sédation Procédurale</h4>
            <ul class="list-disc list-inside text-sm mt-1 space-y-1">
              <li>Jeûne: solides 6h, liquides clairs 2h</li>
              <li>Monitoring: SpO2, FC, PA, capnographie si disponible</li>
              <li>Matériel de réanimation à proximité</li>
              <li>Personnel formé à la gestion des voies aériennes</li>
              <li>Antidotes disponibles (Flumazénil, Naloxone)</li>
            </ul>
          </div>
        </div>
      </div>

    {:else}
      <!-- All Drugs -->
      <div class="space-y-6">
        {#each Object.entries(roleLabels) as [role, label]}
          {@const drugs = getDrugsByRole(role)}
          {#if drugs.length > 0}
            <div>
              <h2 class="text-lg font-semibold mb-3 pb-2 border-b border-base-300">{label}</h2>
              <div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
                {#each drugs as drug}
                  {@const calc = calculateDose(drug)}
                  <button class="card bg-base-100 shadow-md hover:shadow-lg hover:-translate-y-1 transition-all text-left" on:click={() => selectDrug(drug)}>
                    <div class="card-body p-4">
                      <h3 class="font-semibold">{drug.name}</h3>
                      <p class="text-xs text-base-content/60">{drug.drugClass}</p>
                      <div class="mt-2">
                        <span class="text-xl font-bold text-primary">{formatDose(calc.total)} {drug.doseUnit.replace('/kg', '')}</span>
                        <span class="text-xs text-base-content/60 ml-1">({calc.dose} {drug.doseUnit})</span>
                      </div>
                      <span class="badge badge-ghost badge-sm mt-2">{getOnsetDuration(drug)}</span>
                    </div>
                  </button>
                {/each}
              </div>
            </div>
          {/if}
        {/each}
      </div>
    {/if}

  {:else}
    <!-- Drug Detail View -->
  <button class="btn btn-ghost btn-ghost-contrast btn-sm mb-4" on:click={goBack}>← Retour</button>

    <div class="card bg-base-100 shadow-lg">
      <div class="card-body">
        <div class="mb-6">
          <h1 class="text-2xl font-bold">{selectedDrug.name}</h1>
          <p class="text-base-content/60 italic">{selectedDrug.genericName} • {selectedDrug.drugClass}</p>
        </div>

        <!-- Dose Calculator -->
        <div class="bg-base-200 p-4 rounded-box mb-6">
          <h2 class="font-semibold mb-4">Calcul de Dose</h2>
          <div class="flex flex-wrap gap-4 mb-4">
            <label class="form-control">
              <span class="label-text">Poids</span>
              <div class="join">
                <input type="number" bind:value={patientWeight} min="1" max="300" class="input input-bordered input-sm join-item w-20" />
                <span class="join-item btn btn-sm no-animation">kg</span>
              </div>
            </label>
            <label class="form-control">
              <span class="label-text">Âge</span>
              <div class="join">
                <input type="number" bind:value={patientAge} min="0" max="120" class="input input-bordered input-sm join-item w-20" />
                <span class="join-item btn btn-sm no-animation">ans</span>
              </div>
            </label>
          </div>

          {#if calculatedDose}
          <div class="bg-base-100 p-4 rounded-box text-center mb-4">
            <div class="flex items-baseline justify-center gap-2">
              <span class="text-sm text-base-content/60">Dose calculée</span>
              <span class="text-4xl font-bold text-primary">{formatDose(calculatedDose.total)}</span>
              <span class="text-lg text-base-content/60">{selectedDrug.doseUnit.replace('/kg', '')}</span>
            </div>
            <div class="text-sm text-base-content/60 mt-1">
              ({calculatedDose.dose} {selectedDrug.doseUnit})
            </div>
            {#if calculatedDose.notes}
              <div class="badge badge-warning mt-2">📝 {calculatedDose.notes}</div>
            {/if}
          </div>
          {/if}

          <div class="stats stats-horizontal shadow w-full">
            <div class="stat">
              <div class="stat-title">Début d'action</div>
              <div class="stat-value text-lg">
                {selectedDrug.onsetSeconds < 60 
                  ? `${selectedDrug.onsetSeconds} sec` 
                  : `${Math.round(selectedDrug.onsetSeconds / 60)} min`}
              </div>
            </div>
            <div class="stat">
              <div class="stat-title">Durée d'action</div>
              <div class="stat-value text-lg">
                {selectedDrug.durationMinutes < 60 
                  ? `${selectedDrug.durationMinutes} min` 
                  : `${(selectedDrug.durationMinutes / 60).toFixed(1)} h`}
              </div>
            </div>
          </div>
        </div>

        <!-- Age-specific dosing -->
        {#if selectedDrug.dosesByAge}
          <div class="card bg-base-200 mb-4">
            <div class="card-body">
              <h2 class="font-semibold">Doses selon l'âge</h2>
              <div class="space-y-2 mt-2">
                {#each selectedDrug.dosesByAge as ageDose}
                  <div class="flex flex-wrap items-center gap-4 p-3 rounded-lg bg-base-100" class:ring-2={ageDose.ageGroup === selectedAgeGroup} class:ring-primary={ageDose.ageGroup === selectedAgeGroup}>
                    <span class="font-medium min-w-[100px]">{ageDose.ageRange}</span>
                    <span class="font-bold text-primary">{ageDose.dose} {selectedDrug.doseUnit}</span>
                    {#if ageDose.notes}
                      <span class="text-sm text-base-content/60 flex-1">{ageDose.notes}</span>
                    {/if}
                  </div>
                {/each}
              </div>
            </div>
          </div>
        {/if}

        <!-- Mechanism & Indications -->
        <div class="card bg-base-200 mb-4">
          <div class="card-body">
            <h2 class="font-semibold">Mécanisme d'action</h2>
            <p class="text-base-content/80">{selectedDrug.mechanism}</p>
          </div>
        </div>

        <div class="card bg-base-200 mb-4">
          <div class="card-body">
            <h2 class="font-semibold">Indications</h2>
            <ul class="list-disc list-inside space-y-1 text-base-content/80 mt-2">
              {#each selectedDrug.indications as indication}
                <li>{indication}</li>
              {/each}
            </ul>
          </div>
        </div>

        <!-- Advantages -->
        <div class="alert alert-success mb-4">
          <div>
            <h2 class="font-semibold">✅ Avantages</h2>
            <ul class="list-disc list-inside space-y-1 mt-2">
              {#each selectedDrug.advantages as adv}
                <li>{adv}</li>
              {/each}
            </ul>
          </div>
        </div>

        <!-- Side Effects -->
        <div class="alert alert-warning mb-4">
          <div>
            <h2 class="font-semibold">⚠️ Effets indésirables</h2>
            <ul class="list-disc list-inside space-y-1 mt-2">
              {#each selectedDrug.sideEffects as effect}
                <li>{effect}</li>
              {/each}
            </ul>
          </div>
        </div>

        <!-- Contraindications -->
        <div class="alert alert-error mb-4">
          <div>
            <h2 class="font-semibold">🚫 Contre-indications</h2>
            <ul class="list-disc list-inside space-y-1 mt-2">
              {#each selectedDrug.contraindications as ci}
                <li>{ci}</li>
              {/each}
            </ul>
          </div>
        </div>

        <!-- Precautions -->
        {#if selectedDrug.precautions.length > 0}
          <div class="alert mb-4 bg-yellow-50 border-yellow-300 dark:bg-yellow-900/20 dark:border-yellow-700">
            <div>
              <h2 class="font-semibold">⚡ Précautions</h2>
              <ul class="list-disc list-inside space-y-1 mt-2">
                {#each selectedDrug.precautions as precaution}
                  <li>{precaution}</li>
                {/each}
              </ul>
            </div>
          </div>
        {/if}

        <!-- Notes -->
        {#if selectedDrug.notes.length > 0}
          <div class="alert alert-info mb-4">
            <div>
              <h2 class="font-semibold">📝 Notes pratiques</h2>
              <ul class="list-disc list-inside space-y-1 mt-2">
                {#each selectedDrug.notes as note}
                  <li>{note}</li>
                {/each}
              </ul>
            </div>
          </div>
        {/if}

        <!-- Preparation -->
        <div class="card bg-base-200">
          <div class="card-body">
            <h2 class="font-semibold">Préparation</h2>
            <p><strong>Concentrations:</strong> {selectedDrug.concentrations.join(', ')}</p>
            {#if selectedDrug.dilution}
              <p><strong>Dilution:</strong> {selectedDrug.dilution}</p>
            {/if}
            <p><strong>Voies:</strong> {selectedDrug.route.join(', ')}</p>
          </div>
        </div>
      </div>
    </div>
  {/if}
</div>

<style>
  /* No custom styles needed - using Tailwind/DaisyUI */
</style>
