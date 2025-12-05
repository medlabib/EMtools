<script lang="ts">
  import { 
    IV_FLUIDS, 
    calculateTBW, 
    calculateDysnatremiaCorrection, 
    getRecommendedFluids,
    getDefaultSodiumValues,
    getSafetyLimitText,
    DYSNATREMIA_REFERENCES
  } from './metabolic/dysnatremia';
  import {
    HYPERKALEMIA_ECG_FINDINGS,
    HYPOKALEMIA_ECG_FINDINGS,
    getHyperkalemiaTreatments,
    getHypokalemiaTreatments,
    estimatePotassiumDeficit,
    DYSKALEMIA_REFERENCES
  } from './metabolic/dyskalemia';
  import {
    HYPERCALCEMIA_SYMPTOMS,
    HYPOCALCEMIA_SYMPTOMS,
    calculateCorrectedCalcium,
    getHypercalcemiaTreatments,
    getHypocalcemiaTreatments,
    DYSCALCEMIA_REFERENCES
  } from './metabolic/dyscalcemia';
  import type { 
    SodiumDirection, 
    PotassiumDirection, 
    CalciumDirection,
    CorrectionMode, 
    AgeGroup, 
    Sex,
    IVFluid,
    DysnatremiaResult,
    DyskalemiaResult,
    DyscalcemiaResult
  } from './metabolic/types';

  // Active disorder tab
  type DisorderTab = 'sodium' | 'potassium' | 'calcium';
  let activeTab: DisorderTab = 'sodium';

  // Common patient parameters
  let weight = 70;
  let sex: Sex = 'male';
  let ageGroup: AgeGroup = 'adult';

  // === SODIUM ===
  let sodiumDirection: SodiumDirection = 'hyper';
  let sodiumMode: CorrectionMode = 'chronic';
  let baselineNa = 160;
  let targetNa1 = 150;
  let targetNa2 = 142;
  let urineOutput1 = 1000;
  let insensibleLoss1 = 800;
  let urineOutput2 = 1500;
  let insensibleLoss2 = 800;
  let fluidA1: IVFluid = IV_FLUIDS[0];
  let fluidB1: IVFluid = IV_FLUIDS[4];
  let fluidA2: IVFluid = IV_FLUIDS[0];
  let fluidB2: IVFluid = IV_FLUIDS[4];

  // === POTASSIUM ===
  let potassiumDirection: PotassiumDirection = 'hyper';
  let potassiumLevel = 6.5;
  let hasECGChanges = false;
  let selectedECGFindings: string[] = [];
  let hasMuscleWeakness = false;
  let isOnDigoxin = false;
  let renalFunctionK: 'normal' | 'impaired' | 'dialysis' = 'normal';
  let magnesiumLevel: number | undefined;

  // === CALCIUM ===
  let calciumDirection: CalciumDirection = 'hypo';
  let totalCalcium = 7.5;
  let albumin = 4.0;
  let hasCalciumSymptoms = false;
  let selectedCalciumSymptoms: string[] = [];
  let renalFunctionCa: 'normal' | 'impaired' | 'dialysis' = 'normal';

  // Reactive calculations
  $: tbw = calculateTBW(weight, sex, ageGroup);
  
  $: sodiumResult1 = calculateDysnatremiaCorrection({
    weight,
    sex,
    ageGroup,
    baselineNa,
    targetNa: targetNa1,
    direction: sodiumDirection,
    mode: sodiumMode,
    urineOutput: urineOutput1,
    insensibleLoss: insensibleLoss1,
    fluidA: fluidA1,
    fluidB: fluidB1
  });

  $: sodiumResult2 = calculateDysnatremiaCorrection({
    weight,
    sex,
    ageGroup,
    baselineNa: targetNa1,
    targetNa: targetNa2,
    direction: sodiumDirection,
    mode: sodiumMode,
    urineOutput: urineOutput2,
    insensibleLoss: insensibleLoss2,
    fluidA: fluidA2,
    fluidB: fluidB2
  });

  $: potassiumResult = potassiumDirection === 'hyper' 
    ? getHyperkalemiaTreatments({
        weight, sex, ageGroup,
        potassium: potassiumLevel,
        direction: potassiumDirection,
        hasECGChanges,
        ecgFindings: selectedECGFindings,
        renalFunction: renalFunctionK,
        hasMuscleWeakness,
        isOnDigoxin,
        magnesium: magnesiumLevel
      })
    : getHypokalemiaTreatments({
        weight, sex, ageGroup,
        potassium: potassiumLevel,
        direction: potassiumDirection,
        hasECGChanges,
        ecgFindings: selectedECGFindings,
        renalFunction: renalFunctionK,
        hasMuscleWeakness,
        isOnDigoxin,
        magnesium: magnesiumLevel
      });

  $: correctedCalcium = calculateCorrectedCalcium(totalCalcium, albumin);

  $: calciumResult = calciumDirection === 'hyper'
    ? getHypercalcemiaTreatments({
        weight, sex, ageGroup,
        totalCalcium,
        albumin,
        direction: calciumDirection,
        hasSymptoms: hasCalciumSymptoms,
        symptoms: selectedCalciumSymptoms,
        renalFunction: renalFunctionCa
      })
    : getHypocalcemiaTreatments({
        weight, sex, ageGroup,
        totalCalcium,
        albumin,
        direction: calciumDirection,
        hasSymptoms: hasCalciumSymptoms,
        symptoms: selectedCalciumSymptoms,
        renalFunction: renalFunctionCa
      });

  $: kDeficit = potassiumDirection === 'hypo' 
    ? estimatePotassiumDeficit(potassiumLevel)
    : null;

  // Functions
  function setSodiumProtocol(dir: SodiumDirection) {
    sodiumDirection = dir;
    const defaults = getDefaultSodiumValues(dir);
    baselineNa = defaults.baseline;
    targetNa1 = defaults.target;
    targetNa2 = dir === 'hyper' ? 142 : 130;
    
    const recommended = getRecommendedFluids(dir);
    fluidA1 = recommended.primary;
    fluidB1 = recommended.secondary;
    fluidA2 = recommended.primary;
    fluidB2 = recommended.secondary;
  }

  function toggleECGFinding(id: string) {
    if (selectedECGFindings.includes(id)) {
      selectedECGFindings = selectedECGFindings.filter(f => f !== id);
    } else {
      selectedECGFindings = [...selectedECGFindings, id];
    }
    hasECGChanges = selectedECGFindings.length > 0;
  }

  function toggleCalciumSymptom(id: string) {
    if (selectedCalciumSymptoms.includes(id)) {
      selectedCalciumSymptoms = selectedCalciumSymptoms.filter(s => s !== id);
    } else {
      selectedCalciumSymptoms = [...selectedCalciumSymptoms, id];
    }
    hasCalciumSymptoms = selectedCalciumSymptoms.length > 0;
  }

  function getSeverityColor(severity: string): string {
    switch (severity) {
      case 'critical': return 'bg-red-600';
      case 'severe': return 'bg-orange-500';
      case 'moderate': return 'bg-yellow-500';
      case 'mild': return 'bg-amber-400';
      case 'normal': return 'bg-green-500';
      default: return 'bg-green-500';
    }
  }

  function getSeverityLabel(severity: string): string {
    switch (severity) {
      case 'critical': return 'Critique';
      case 'severe': return 'Sévère';
      case 'moderate': return 'Modérée';
      case 'mild': return 'Légère';
      case 'normal': return 'Normal';
      default: return 'Normal';
    }
  }
</script>

<div class="max-w-5xl mx-auto p-4">
  <!-- Header -->
  <div class="text-center mb-6 bg-gradient-to-r from-emerald-600 to-teal-600 rounded-2xl p-6 text-white">
    <h1 class="text-2xl font-bold mb-1">🧪 Troubles Métaboliques</h1>
    <p class="opacity-90">Protocoles de correction électrolytique basés sur les preuves</p>
  </div>

  <!-- Tab Navigation -->
  <div role="tablist" class="tabs tabs-boxed mb-6 p-1">
    <button 
      role="tab"
      class="tab gap-2 flex-1" 
      class:tab-active={activeTab === 'sodium'}
      on:click={() => activeTab = 'sodium'}
    >
      <span>🧂</span>
      <span class="hidden sm:inline">Dysnatrémie</span>
    </button>
    <button 
      role="tab"
      class="tab gap-2 flex-1" 
      class:tab-active={activeTab === 'potassium'}
      on:click={() => activeTab = 'potassium'}
    >
      <span>⚡</span>
      <span class="hidden sm:inline">Dyskaliémie</span>
    </button>
    <button 
      role="tab"
      class="tab gap-2 flex-1" 
      class:tab-active={activeTab === 'calcium'}
      on:click={() => activeTab = 'calcium'}
    >
      <span>🦴</span>
      <span class="hidden sm:inline">Dyscalcémie</span>
    </button>
  </div>

  <!-- Patient Parameters (Common) -->
  <div class="card bg-base-200 mb-6">
    <div class="card-body py-4">
      <h3 class="card-title text-base">👤 Paramètres Patient</h3>
      <div class="grid grid-cols-2 sm:grid-cols-4 gap-4">
        <div class="form-control">
          <label class="label py-1" for="patientSex">
            <span class="label-text">Sexe</span>
          </label>
          <select id="patientSex" bind:value={sex} class="select select-bordered select-sm">
            <option value="male">Homme</option>
            <option value="female">Femme</option>
          </select>
        </div>
        <div class="form-control">
          <label class="label py-1" for="patientAge">
            <span class="label-text">Âge</span>
          </label>
          <select id="patientAge" bind:value={ageGroup} class="select select-bordered select-sm">
            <option value="adult">Adulte</option>
            <option value="elderly">Âgé (>65)</option>
            <option value="child">Enfant</option>
          </select>
        </div>
        <div class="form-control">
          <label class="label py-1" for="patientWeight">
            <span class="label-text">Poids (kg)</span>
          </label>
          <input id="patientWeight" type="number" bind:value={weight} min="1" max="300" class="input input-bordered input-sm" />
        </div>
        <div class="form-control">
          <div class="label py-1">
            <span class="label-text">Eau Totale (L)</span>
          </div>
          <div class="input input-bordered input-sm flex items-center bg-base-100 font-bold text-primary">
            {tbw.toFixed(1)}
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- SODIUM TAB -->
  {#if activeTab === 'sodium'}
    <div class="disorder-content">
      <!-- Protocol Toggle -->
      <div class="toggle-row">
        <div class="toggle-group">
          <button 
            class="toggle-btn" 
            class:active={sodiumDirection === 'hyper'}
            on:click={() => setSodiumProtocol('hyper')}
          >
            ↓ Hypernatrémie
          </button>
          <button 
            class="toggle-btn" 
            class:active={sodiumDirection === 'hypo'}
            on:click={() => setSodiumProtocol('hypo')}
          >
            ↑ Hyponatrémie
          </button>
        </div>
        <div class="toggle-group">
          <button 
            class="toggle-btn" 
            class:active={sodiumMode === 'chronic'}
            on:click={() => sodiumMode = 'chronic'}
          >
            Chronique
          </button>
          <button 
            class="toggle-btn" 
            class:active={sodiumMode === 'acute'}
            on:click={() => sodiumMode = 'acute'}
          >
            Aiguë
          </button>
        </div>
      </div>

      <!-- Safety Banner -->
      <div class="safety-banner" class:warning={sodiumResult1.isUnsafe}>
        <span class="safety-icon">{sodiumResult1.isUnsafe ? '⚠️' : '✅'}</span>
        <span>Limite de sécurité: {getSafetyLimitText(sodiumDirection, sodiumMode)}</span>
      </div>

      <!-- Baseline Na+ -->
      <div class="card">
        <label class="na-input">
          <span class="label-text">Na+ de base (mEq/L)</span>
          <input 
            type="number" 
            bind:value={baselineNa} 
            class="big-input"
            class:hyper={sodiumDirection === 'hyper'}
            class:hypo={sodiumDirection === 'hypo'}
          />
        </label>
      </div>

      <!-- Two-Day Protocol -->
      <div class="two-day-grid">
        <!-- Day 1 -->
        <div class="card day-card">
          <div class="day-header">
            <h3><span class="day-badge">1</span> Premières 24h</h3>
            <span class="time-badge">0h - 24h</span>
          </div>

          <div class="day-content">
            <label>
              <span class="label-text">Cible Na+ à 24h</span>
              <div class="target-row">
                <input type="number" bind:value={targetNa1} class="target-input" />
                <div class="delta-display">
                  <span class="arrow">{sodiumResult1.deltaNA >= 0 ? '↑' : '↓'}</span>
                  <span class="delta-value">{Math.abs(sodiumResult1.deltaNA).toFixed(1)}</span>
                  <span class="rate">({sodiumResult1.ratePerHour >= 0 ? '+' : ''}{sodiumResult1.ratePerHour.toFixed(2)}/h)</span>
                </div>
              </div>
            </label>

            {#if sodiumResult1.isUnsafe}
              <div class="safety-warning">
                {sodiumResult1.safetyWarning}
              </div>
            {/if}

            <div class="losses-section">
              <span class="section-label">💧 Pertes estimées (24h)</span>
              <div class="losses-grid">
                <label>
                  <span class="label-text small">Urine (mL)</span>
                  <input type="number" bind:value={urineOutput1} />
                </label>
                <label>
                  <span class="label-text small">Insensibles (mL)</span>
                  <input type="number" bind:value={insensibleLoss1} />
                </label>
              </div>
            </div>

            <div class="fluid-section">
              <span class="section-label">💉 Solutés</span>
              <div class="fluid-grid">
                <label>
                  <span class="label-text small">Soluté A</span>
                  <select bind:value={fluidA1}>
                    {#each IV_FLUIDS as fluid}
                      <option value={fluid}>{fluid.nameFr}</option>
                    {/each}
                  </select>
                </label>
                <label>
                  <span class="label-text small">Soluté B</span>
                  <select bind:value={fluidB1}>
                    {#each IV_FLUIDS as fluid}
                      <option value={fluid}>{fluid.nameFr}</option>
                    {/each}
                  </select>
                </label>
              </div>
            </div>

            <div class="pump-result">
              <h4>⚙️ Réglages Pompe</h4>
              <div class="rates-display">
                <div class="rate-box primary">
                  <span class="rate-value">{sodiumResult1.fluidARate}</span>
                  <span class="rate-label">mL/h Soluté A</span>
                </div>
                <span class="plus">+</span>
                <div class="rate-box secondary">
                  <span class="rate-value">{sodiumResult1.fluidBRate}</span>
                  <span class="rate-label">mL/h Soluté B</span>
                </div>
              </div>
              <div class="totals-row">
                <span>Total: <strong>{sodiumResult1.totalRate}</strong> mL/h</span>
                <span>Volume: <strong>{sodiumResult1.totalVolume24h.toFixed(1)}</strong> L/24h</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Day 2 -->
        <div class="card day-card day2">
          <div class="day-header">
            <h3><span class="day-badge secondary">2</span> 24h suivantes</h3>
            <span class="time-badge">24h - 48h</span>
          </div>

          <div class="day-content">
            <div class="inherited-na">
              <span>Départ: </span>
              <strong>{targetNa1}</strong> mEq/L
            </div>

            <label>
              <span class="label-text">Cible Na+ à 48h</span>
              <div class="target-row">
                <input type="number" bind:value={targetNa2} class="target-input" />
                <div class="delta-display">
                  <span class="arrow">{sodiumResult2.deltaNA >= 0 ? '↑' : '↓'}</span>
                  <span class="delta-value">{Math.abs(sodiumResult2.deltaNA).toFixed(1)}</span>
                  <span class="rate">({sodiumResult2.ratePerHour >= 0 ? '+' : ''}{sodiumResult2.ratePerHour.toFixed(2)}/h)</span>
                </div>
              </div>
            </label>

            {#if sodiumResult2.isUnsafe}
              <div class="safety-warning">
                {sodiumResult2.safetyWarning}
              </div>
            {/if}

            <div class="losses-section">
              <span class="section-label">💧 Pertes estimées (Jour 2)</span>
              <div class="losses-grid">
                <label>
                  <span class="label-text small">Urine (mL)</span>
                  <input type="number" bind:value={urineOutput2} />
                </label>
                <label>
                  <span class="label-text small">Insensibles (mL)</span>
                  <input type="number" bind:value={insensibleLoss2} />
                </label>
              </div>
            </div>

            <div class="fluid-section">
              <span class="section-label">💉 Solutés</span>
              <div class="fluid-grid">
                <label>
                  <span class="label-text small">Soluté A</span>
                  <select bind:value={fluidA2}>
                    {#each IV_FLUIDS as fluid}
                      <option value={fluid}>{fluid.nameFr}</option>
                    {/each}
                  </select>
                </label>
                <label>
                  <span class="label-text small">Soluté B</span>
                  <select bind:value={fluidB2}>
                    {#each IV_FLUIDS as fluid}
                      <option value={fluid}>{fluid.nameFr}</option>
                    {/each}
                  </select>
                </label>
              </div>
            </div>

            <div class="pump-result day2-result">
              <h4>⚙️ Réglages Jour 2</h4>
              <div class="rates-display">
                <div class="rate-box">
                  <span class="rate-value">{sodiumResult2.fluidARate}</span>
                  <span class="rate-label">mL/h A</span>
                </div>
                <span class="plus">+</span>
                <div class="rate-box">
                  <span class="rate-value">{sodiumResult2.fluidBRate}</span>
                  <span class="rate-label">mL/h B</span>
                </div>
              </div>
              <div class="totals-row">
                <span>Total: <strong>{sodiumResult2.totalRate}</strong> mL/h</span>
                <span>Volume: <strong>{sodiumResult2.totalVolume24h.toFixed(1)}</strong> L</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- References -->
      <div class="references">
        <h4>📚 Références</h4>
        <ul>
          {#each DYSNATREMIA_REFERENCES.slice(0, 3) as ref}
            <li>{ref.title} - {ref.source}</li>
          {/each}
        </ul>
      </div>
    </div>
  {/if}

  <!-- POTASSIUM TAB -->
  {#if activeTab === 'potassium'}
    <div class="disorder-content">
      <!-- Protocol Toggle -->
      <div class="toggle-row single">
        <div class="toggle-group">
          <button 
            class="toggle-btn" 
            class:active={potassiumDirection === 'hyper'}
            on:click={() => { potassiumDirection = 'hyper'; potassiumLevel = 6.5; }}
          >
            ↑ Hyperkaliémie
          </button>
          <button 
            class="toggle-btn" 
            class:active={potassiumDirection === 'hypo'}
            on:click={() => { potassiumDirection = 'hypo'; potassiumLevel = 2.8; }}
          >
            ↓ Hypokaliémie
          </button>
        </div>
      </div>

      <!-- Potassium Level -->
      <div class="card">
        <div class="k-input-section">
          <label>
            <span class="label-text">Kaliémie (mEq/L)</span>
            <input 
              type="number" 
              bind:value={potassiumLevel} 
              step="0.1"
              class="big-input k-input"
              class:hyper={potassiumDirection === 'hyper'}
              class:hypo={potassiumDirection === 'hypo'}
            />
          </label>
          <div class="severity-badge {getSeverityColor(potassiumResult.severity)}">
            {getSeverityLabel(potassiumResult.severity)}
          </div>
        </div>

        {#if potassiumDirection === 'hypo' && kDeficit}
          <div class="deficit-info">
            <span>📊 Déficit estimé: ~{kDeficit.deficit} mEq</span>
            <span class="note">{kDeficit.note}</span>
          </div>
        {/if}
      </div>

      <!-- ECG Findings -->
      <div class="card">
        <h3>📊 Anomalies ECG</h3>
        <div class="ecg-grid">
          {#each (potassiumDirection === 'hyper' ? HYPERKALEMIA_ECG_FINDINGS : HYPOKALEMIA_ECG_FINDINGS) as finding}
            <button 
              class="ecg-btn"
              class:selected={selectedECGFindings.includes(finding.id)}
              on:click={() => toggleECGFinding(finding.id)}
            >
              {finding.nameFr}
            </button>
          {/each}
        </div>
      </div>

      <!-- Risk Factors -->
      <div class="card">
        <h3>⚠️ Facteurs de Risque</h3>
        <div class="risk-grid">
          <label class="checkbox-label">
            <input type="checkbox" bind:checked={hasMuscleWeakness} />
            Faiblesse musculaire
          </label>
          <label class="checkbox-label">
            <input type="checkbox" bind:checked={isOnDigoxin} />
            Sous Digoxine
          </label>
          <label>
            <span class="label-text">Fonction rénale</span>
            <select bind:value={renalFunctionK}>
              <option value="normal">Normale</option>
              <option value="impaired">Altérée</option>
              <option value="dialysis">Dialyse</option>
            </select>
          </label>
          <label>
            <span class="label-text">Magnésémie (optionnel)</span>
            <input type="number" bind:value={magnesiumLevel} step="0.1" placeholder="mEq/L" />
          </label>
        </div>
      </div>

      <!-- Warnings -->
      {#if potassiumResult.warnings.length > 0}
        <div class="warnings-box">
          {#each potassiumResult.warnings as warning}
            <p>{warning}</p>
          {/each}
        </div>
      {/if}

      <!-- Treatments -->
      <div class="card treatments-card">
        <h3>💊 Protocole de Traitement</h3>
        <div class="monitoring-badge">
          Surveillance: {potassiumResult.monitoringInterval}
        </div>

        <div class="treatments-list">
          {#each potassiumResult.treatments as treatment}
            <div class="treatment-item" class:immediate={treatment.urgency === 'immediate'} class:urgent={treatment.urgency === 'urgent'}>
              <div class="treatment-header">
                <span class="treatment-name">{treatment.nameFr}</span>
                <span class="treatment-route">{treatment.route}</span>
              </div>
              <div class="treatment-dose">{treatment.dose}</div>
              <div class="treatment-timing">
                <span>⏱️ Début: {treatment.onset}</span>
                <span>⏳ Durée: {treatment.duration}</span>
              </div>
              <p class="treatment-notes">{treatment.notesFr}</p>
              {#if treatment.contraindications.length > 0}
                <div class="contraindications">
                  ❌ CI: {treatment.contraindications.join(', ')}
                </div>
              {/if}
            </div>
          {/each}
        </div>
      </div>

      <!-- References -->
      <div class="references">
        <h4>📚 Références</h4>
        <ul>
          {#each DYSKALEMIA_REFERENCES.slice(0, 3) as ref}
            <li>{ref.title} - {ref.source}</li>
          {/each}
        </ul>
      </div>
    </div>
  {/if}

  <!-- CALCIUM TAB -->
  {#if activeTab === 'calcium'}
    <div class="disorder-content">
      <!-- Protocol Toggle -->
      <div class="toggle-row single">
        <div class="toggle-group">
          <button 
            class="toggle-btn" 
            class:active={calciumDirection === 'hyper'}
            on:click={() => { calciumDirection = 'hyper'; totalCalcium = 13; }}
          >
            ↑ Hypercalcémie
          </button>
          <button 
            class="toggle-btn" 
            class:active={calciumDirection === 'hypo'}
            on:click={() => { calciumDirection = 'hypo'; totalCalcium = 7.5; }}
          >
            ↓ Hypocalcémie
          </button>
        </div>
      </div>

      <!-- Calcium Level -->
      <div class="card">
        <div class="calcium-inputs">
          <label>
            <span class="label-text">Calcium Total (mg/dL)</span>
            <input 
              type="number" 
              bind:value={totalCalcium} 
              step="0.1"
              class="big-input"
            />
          </label>
          <label>
            <span class="label-text">Albumine (g/dL)</span>
            <input 
              type="number" 
              bind:value={albumin} 
              step="0.1"
            />
          </label>
          <div class="corrected-ca">
            <span class="label-text">Ca Corrigé</span>
            <span class="corrected-value" class:hyper={correctedCalcium > 10.5} class:hypo={correctedCalcium < 8.5}>
              {correctedCalcium.toFixed(1)} mg/dL
            </span>
          </div>
          <div class="severity-badge {getSeverityColor(calciumResult.severity)}">
            {getSeverityLabel(calciumResult.severity)}
          </div>
        </div>

        <div class="formula-note">
          Ca corrigé = Ca total + 0.8 × (4.0 - Albumine)
        </div>
      </div>

      <!-- Symptoms -->
      <div class="card">
        <h3>🩺 Symptômes</h3>
        <div class="symptoms-grid">
          {#each (calciumDirection === 'hyper' ? HYPERCALCEMIA_SYMPTOMS : HYPOCALCEMIA_SYMPTOMS) as symptom}
            <button 
              class="symptom-btn"
              class:selected={selectedCalciumSymptoms.includes(symptom.id)}
              class:severe={symptom.severity === 'severe' || symptom.severity === 'critical'}
              on:click={() => toggleCalciumSymptom(symptom.id)}
            >
              {symptom.nameFr}
            </button>
          {/each}
        </div>
      </div>

      <!-- Renal Function -->
      <div class="card">
        <label>
          <span class="label-text">Fonction rénale</span>
          <select bind:value={renalFunctionCa}>
            <option value="normal">Normale</option>
            <option value="impaired">Altérée</option>
            <option value="dialysis">Dialyse</option>
          </select>
        </label>
      </div>

      <!-- Warnings -->
      {#if calciumResult.warnings.length > 0}
        <div class="warnings-box">
          {#each calciumResult.warnings as warning}
            <p>{warning}</p>
          {/each}
        </div>
      {/if}

      <!-- Treatments -->
      <div class="card treatments-card">
        <h3>💊 Protocole de Traitement</h3>

        <div class="treatments-list">
          {#each calciumResult.treatments as treatment}
            <div class="treatment-item" class:immediate={treatment.urgency === 'immediate'} class:urgent={treatment.urgency === 'urgent'}>
              <div class="treatment-header">
                <span class="treatment-name">{treatment.nameFr}</span>
                <span class="treatment-route">{treatment.route}</span>
              </div>
              <div class="treatment-dose">{treatment.dose}</div>
              <p class="treatment-indication">📋 {treatment.indication}</p>
              <p class="treatment-notes">{treatment.notesFr}</p>
              {#if treatment.contraindications.length > 0}
                <div class="contraindications">
                  ❌ CI: {treatment.contraindications.join(', ')}
                </div>
              {/if}
            </div>
          {/each}
        </div>
      </div>

      <!-- References -->
      <div class="references">
        <h4>📚 Références</h4>
        <ul>
          {#each DYSCALCEMIA_REFERENCES.slice(0, 3) as ref}
            <li>{ref.title} - {ref.source}</li>
          {/each}
        </ul>
      </div>
    </div>
  {/if}

  <!-- Footer -->
  <div class="footer">
    <p>⚠️ <strong>Avertissement:</strong> Outil d'aide au calcul uniquement. Ne remplace pas le jugement clinique.</p>
  </div>
</div>

<style>
  .metabolic-calculator {
    max-width: 1200px;
    margin: 0 auto;
    padding: 1rem;
    background: oklch(var(--b2));
    min-height: 100vh;
  }

  .tab-nav {
    display: flex;
    gap: 0.5rem;
    margin-bottom: 1rem;
    background: oklch(var(--b1));
    padding: 0.5rem;
    border-radius: 12px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
  }

  .tab-btn {
    flex: 1;
    padding: 0.75rem;
    border: none;
    border-radius: 8px;
    background: transparent;
    cursor: pointer;
    font-size: 0.9rem;
    font-weight: 600;
    color: oklch(var(--bc) / 0.6);
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
    transition: all 0.2s;
  }

  .tab-btn.active {
    background: oklch(var(--p));
    color: oklch(var(--pc));
  }

  .tab-btn:hover:not(.active) {
    background: oklch(var(--b2));
  }

  .tab-icon {
    font-size: 1.2rem;
  }

  .card {
    background: oklch(var(--b1));
    border-radius: 12px;
    padding: 1.25rem;
    margin-bottom: 1rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
  }

  .patient-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 1rem;
    align-items: end;
  }

  @media (max-width: 768px) {
    .patient-grid {
      grid-template-columns: repeat(2, 1fr);
    }
  }

  label {
    display: flex;
    flex-direction: column;
  }

  .label-text {
    font-size: 0.7rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    color: oklch(var(--bc) / 0.6);
    margin-bottom: 0.35rem;
  }

  .label-text.small {
    font-size: 0.65rem;
  }

  input, select {
    padding: 0.5rem;
    border: 1px solid oklch(var(--bc) / 0.2);
    border-radius: 6px;
    font-size: 0.875rem;
    background: oklch(var(--b1));
    color: oklch(var(--bc));
  }

  input:focus, select:focus {
    outline: none;
    border-color: oklch(var(--p));
    box-shadow: 0 0 0 3px oklch(var(--p) / 0.1);
  }

  .tbw-display {
    display: flex;
    flex-direction: column;
  }

  .tbw-value {
    font-size: 1.25rem;
    font-weight: 700;
    color: oklch(var(--p));
  }

  .toggle-row {
    display: flex;
    justify-content: space-between;
    gap: 1rem;
    margin-bottom: 1rem;
    flex-wrap: wrap;
  }

  .toggle-row.single {
    justify-content: center;
  }

  .toggle-group {
    display: flex;
    background: oklch(var(--b1));
    padding: 0.25rem;
    border-radius: 9999px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
  }

  .toggle-btn {
    padding: 0.5rem 1rem;
    border: none;
    border-radius: 9999px;
    font-size: 0.8rem;
    font-weight: 600;
    cursor: pointer;
    background: transparent;
    color: oklch(var(--bc) / 0.5);
    transition: all 0.2s;
  }

  .toggle-btn.active {
    background: oklch(var(--p));
    color: oklch(var(--pc));
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  }

  .safety-banner {
    padding: 0.75rem;
    background: oklch(var(--su) / 0.1);
    border: 1px solid oklch(var(--su) / 0.3);
    border-radius: 8px;
    text-align: center;
    font-size: 0.85rem;
    font-weight: 600;
    color: oklch(var(--su));
    margin-bottom: 1rem;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
  }

  .safety-banner.warning {
    background: oklch(var(--er) / 0.1);
    border-color: oklch(var(--er) / 0.3);
    color: oklch(var(--er));
    animation: pulse-warning 2s infinite;
  }

  @keyframes pulse-warning {
    0%, 100% { background: #fef2f2; }
    50% { background: #fee2e2; }
  }

  .big-input {
    font-size: 1.5rem !important;
    font-weight: 700;
    padding: 0.75rem !important;
    text-align: center;
    border-width: 2px !important;
  }

  .big-input.hyper {
    border-color: #3b82f6;
    color: #1d4ed8;
  }

  .big-input.hypo {
    border-color: #f59e0b;
    color: #b45309;
  }

  .two-day-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 1rem;
  }

  @media (max-width: 1024px) {
    .two-day-grid {
      grid-template-columns: 1fr;
    }
  }

  .day-card {
    border-left: 4px solid #3b82f6;
  }

  .day-card.day2 {
    border-left-color: #64748b;
    opacity: 0.9;
  }

  .day-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
    padding-bottom: 0.75rem;
    border-bottom: 1px solid oklch(var(--bc) / 0.1);
  }

  .day-header h3 {
    margin: 0;
    font-size: 1rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    color: oklch(var(--bc));
  }

  .day-badge {
    width: 24px;
    height: 24px;
    background: oklch(var(--p));
    color: oklch(var(--pc));
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.75rem;
  }

  .day-badge.secondary {
    background: oklch(var(--bc) / 0.4);
  }

  .time-badge {
    font-size: 0.65rem;
    font-weight: 700;
    text-transform: uppercase;
    padding: 0.25rem 0.5rem;
    background: oklch(var(--b2));
    border-radius: 4px;
    color: oklch(var(--bc) / 0.6);
  }

  .target-row {
    display: flex;
    align-items: center;
    gap: 1rem;
  }

  .target-input {
    width: 100px;
    font-size: 1.25rem !important;
    font-weight: 700;
    padding: 0.5rem !important;
  }

  .delta-display {
    font-size: 0.8rem;
    color: oklch(var(--bc) / 0.6);
  }

  .delta-value {
    font-weight: 700;
    color: oklch(var(--bc));
  }

  .arrow {
    margin-right: 0.25rem;
  }

  .rate {
    font-family: monospace;
    font-size: 0.7rem;
    color: oklch(var(--bc) / 0.5);
  }

  .safety-warning {
    background: oklch(var(--er) / 0.1);
    border: 1px solid oklch(var(--er) / 0.3);
    border-radius: 6px;
    padding: 0.5rem;
    font-size: 0.8rem;
    font-weight: 600;
    color: oklch(var(--er));
    margin-top: 0.5rem;
  }

  .section-label {
    display: block;
    font-size: 0.7rem;
    font-weight: 700;
    text-transform: uppercase;
    color: oklch(var(--bc) / 0.6);
    margin-bottom: 0.5rem;
  }

  .losses-section, .fluid-section {
    margin-top: 1rem;
  }

  .losses-grid, .fluid-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 0.5rem;
  }

  .pump-result {
    background: oklch(var(--n));
    color: oklch(var(--nc));
    padding: 1rem;
    border-radius: 8px;
    margin-top: 1rem;
  }

  .pump-result h4 {
    margin: 0 0 0.75rem 0;
    font-size: 0.7rem;
    text-transform: uppercase;
    letter-spacing: 0.1em;
    color: oklch(var(--nc) / 0.6);
  }

  .day2-result {
    background: oklch(var(--n) / 0.8);
  }

  .rates-display {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 0.75rem;
  }

  .rate-box {
    text-align: center;
    background: oklch(var(--nc) / 0.05);
    padding: 0.5rem;
    border-radius: 6px;
    flex: 1;
  }

  .rate-box.primary .rate-value {
    color: oklch(var(--in));
  }

  .rate-box.secondary .rate-value {
    color: oklch(var(--su));
  }

  .rate-value {
    font-size: 1.5rem;
    font-weight: 700;
    font-family: monospace;
    display: block;
  }

  .rate-label {
    font-size: 0.65rem;
    color: oklch(var(--nc) / 0.6);
  }

  .plus {
    font-size: 1.25rem;
    font-weight: 700;
    color: oklch(var(--bc) / 0.5);
    padding: 0 0.5rem;
  }

  .totals-row {
    display: flex;
    justify-content: space-between;
    border-top: 1px solid oklch(var(--nc) / 0.3);
    padding-top: 0.5rem;
    font-size: 0.8rem;
    font-family: monospace;
    color: oklch(var(--nc) / 0.8);
  }

  .inherited-na {
    background: oklch(var(--b2));
    padding: 0.5rem;
    border-radius: 6px;
    font-size: 0.85rem;
    margin-bottom: 1rem;
    color: oklch(var(--bc) / 0.7);
  }

  .inherited-na strong {
    color: oklch(var(--bc));
    margin-left: 0.25rem;
  }

  /* Potassium Tab Styles */
  .k-input-section {
    display: flex;
    align-items: end;
    gap: 1rem;
    flex-wrap: wrap;
  }

  .k-input.hyper {
    border-color: oklch(var(--er));
    color: oklch(var(--er));
  }

  .k-input.hypo {
    border-color: oklch(var(--su));
    color: oklch(var(--su));
  }

  .severity-badge {
    padding: 0.5rem 1rem;
    border-radius: 9999px;
    color: white;
    font-size: 0.8rem;
    font-weight: 700;
    text-transform: uppercase;
  }

  .deficit-info {
    margin-top: 1rem;
    padding: 0.75rem;
    background: oklch(var(--wa) / 0.2);
    border-radius: 6px;
    font-size: 0.85rem;
    color: oklch(var(--bc));
  }

  .deficit-info .note {
    display: block;
    font-size: 0.75rem;
    color: oklch(var(--wa));
    margin-top: 0.25rem;
  }

  .ecg-grid, .symptoms-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
  }

  .ecg-btn, .symptom-btn {
    padding: 0.5rem 0.75rem;
    border: 1px solid oklch(var(--bc) / 0.2);
    border-radius: 9999px;
    background: oklch(var(--b2));
    font-size: 0.75rem;
    cursor: pointer;
    transition: all 0.2s;
    color: oklch(var(--bc) / 0.7);
  }

  .ecg-btn:hover, .symptom-btn:hover {
    background: oklch(var(--b3));
  }

  .ecg-btn.selected, .symptom-btn.selected {
    background: oklch(var(--er));
    color: oklch(var(--erc));
    border-color: oklch(var(--er));
  }

  .symptom-btn.severe {
    border-color: oklch(var(--er) / 0.5);
  }

  .symptom-btn.severe.selected {
    background: oklch(var(--er) / 0.8);
  }

  .risk-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 1rem;
    align-items: end;
  }

  .checkbox-label {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    cursor: pointer;
    font-size: 0.875rem;
    color: oklch(var(--bc));
  }

  .checkbox-label input {
    width: 1rem;
    height: 1rem;
  }

  .warnings-box {
    background: oklch(var(--wa) / 0.15);
    border: 1px solid oklch(var(--wa) / 0.4);
    border-radius: 8px;
    padding: 1rem;
    margin-bottom: 1rem;
  }

  .warnings-box p {
    margin: 0 0 0.5rem 0;
    font-size: 0.85rem;
    color: oklch(var(--wa));
  }

  .warnings-box p:last-child {
    margin-bottom: 0;
  }

  .treatments-card h3 {
    margin: 0 0 1rem 0;
    font-size: 1rem;
    color: oklch(var(--bc));
  }

  .monitoring-badge {
    display: inline-block;
    background: oklch(var(--in) / 0.2);
    color: oklch(var(--in));
    padding: 0.35rem 0.75rem;
    border-radius: 9999px;
    font-size: 0.75rem;
    font-weight: 600;
    margin-bottom: 1rem;
  }

  .treatments-list {
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }

  .treatment-item {
    border: 1px solid oklch(var(--bc) / 0.15);
    border-radius: 8px;
    padding: 1rem;
    transition: all 0.2s;
    background: oklch(var(--b1));
  }

  .treatment-item.immediate {
    border-left: 4px solid oklch(var(--er));
    background: oklch(var(--er) / 0.05);
  }

  .treatment-item.urgent {
    border-left: 4px solid oklch(var(--wa));
    background: oklch(var(--wa) / 0.05);
  }

  .treatment-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.5rem;
  }

  .treatment-name {
    font-weight: 700;
    color: oklch(var(--bc));
  }

  .treatment-route {
    font-size: 0.7rem;
    font-weight: 600;
    padding: 0.2rem 0.5rem;
    background: oklch(var(--bc) / 0.1);
    border-radius: 4px;
    color: oklch(var(--bc) / 0.7);
  }

  .treatment-dose {
    font-family: monospace;
    font-size: 0.9rem;
    color: oklch(var(--bc));
    background: oklch(var(--b2));
    padding: 0.5rem;
    border-radius: 4px;
    margin-bottom: 0.5rem;
  }

  .treatment-timing {
    display: flex;
    gap: 1rem;
    font-size: 0.75rem;
    color: oklch(var(--bc) / 0.6);
    margin-bottom: 0.5rem;
  }

  .treatment-indication {
    font-size: 0.8rem;
    color: oklch(var(--in));
    margin: 0.5rem 0;
    font-style: italic;
  }

  .treatment-notes {
    font-size: 0.8rem;
    color: oklch(var(--bc) / 0.7);
    margin: 0 0 0.5rem 0;
    line-height: 1.4;
  }

  .contraindications {
    font-size: 0.75rem;
    color: oklch(var(--er));
    background: oklch(var(--er) / 0.1);
    padding: 0.35rem 0.5rem;
    border-radius: 4px;
  }

  /* Calcium Tab Styles */
  .calcium-inputs {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr auto;
    gap: 1rem;
    align-items: end;
  }

  @media (max-width: 768px) {
    .calcium-inputs {
      grid-template-columns: 1fr 1fr;
    }
  }

  .corrected-ca {
    display: flex;
    flex-direction: column;
  }

  .corrected-value {
    font-size: 1.5rem;
    font-weight: 700;
    color: oklch(var(--bc));
  }

  .corrected-value.hyper {
    color: oklch(var(--er));
  }

  .corrected-value.hypo {
    color: oklch(var(--in));
  }

  .formula-note {
    margin-top: 0.75rem;
    font-size: 0.75rem;
    color: oklch(var(--bc) / 0.5);
    font-family: monospace;
    text-align: center;
  }

  .references {
    background: oklch(var(--b2));
    padding: 1rem;
    border-radius: 8px;
    margin-top: 1rem;
  }

  .references h4 {
    margin: 0 0 0.5rem 0;
    font-size: 0.85rem;
    color: oklch(var(--bc) / 0.7);
  }

  .references ul {
    margin: 0;
    padding-left: 1.25rem;
    font-size: 0.75rem;
    color: oklch(var(--bc) / 0.6);
    line-height: 1.6;
  }

  .footer {
    text-align: center;
    padding: 1.5rem;
    font-size: 0.8rem;
    color: oklch(var(--bc) / 0.6);
    border-top: 1px solid oklch(var(--bc) / 0.1);
    margin-top: 2rem;
  }

  .footer p {
    margin: 0;
  }

  /* ===== Mobile Responsiveness ===== */
  
  /* Tablet breakpoint (768px) */
  @media (max-width: 768px) {
    .metabolic-calculator {
      padding: 0.75rem;
    }

    .tab-nav {
      flex-wrap: wrap;
      gap: 0.35rem;
    }

    .tab-btn {
      flex: 1 1 calc(50% - 0.35rem);
      min-width: 0;
      padding: 0.6rem 0.5rem;
      font-size: 0.75rem;
    }

    .tab-icon {
      font-size: 1rem;
    }

    .tab-label {
      display: none;
    }

    .card {
      padding: 1rem;
    }

    .toggle-row {
      flex-direction: column;
      gap: 0.75rem;
      align-items: stretch;
    }

    .toggle-group {
      justify-content: center;
      flex-wrap: wrap;
    }

    .toggle-btn {
      padding: 0.5rem 0.75rem;
      font-size: 0.7rem;
    }

    .rates-display {
      flex-direction: column;
      gap: 0.5rem;
    }

    .rate-box {
      width: 100%;
    }

    .plus {
      display: none;
    }

    .totals-row {
      flex-direction: column;
      gap: 0.25rem;
      text-align: center;
    }

    .treatment-header {
      flex-direction: column;
      align-items: flex-start;
      gap: 0.5rem;
    }

    .treatment-timing {
      flex-direction: column;
      gap: 0.25rem;
    }

    .k-input-section {
      flex-direction: column;
      align-items: stretch;
    }

    .k-input-section label {
      width: 100%;
    }

    .risk-grid {
      grid-template-columns: 1fr;
    }

    .losses-grid, .fluid-grid {
      grid-template-columns: 1fr;
    }

    .target-row {
      flex-direction: column;
      align-items: stretch;
      gap: 0.5rem;
    }

    .target-input {
      width: 100%;
    }

    .day-header {
      flex-direction: column;
      align-items: flex-start;
      gap: 0.5rem;
    }

    .references ul {
      padding-left: 1rem;
    }
  }

  /* Mobile breakpoint (480px) */
  @media (max-width: 480px) {
    .metabolic-calculator {
      padding: 0.5rem;
    }

    .tab-nav {
      padding: 0.35rem;
      border-radius: 8px;
    }

    .tab-btn {
      flex: 1 1 calc(50% - 0.25rem);
      padding: 0.5rem 0.25rem;
      font-size: 0.7rem;
      gap: 0.25rem;
    }

    .card {
      padding: 0.75rem;
      border-radius: 8px;
    }

    .patient-grid {
      grid-template-columns: 1fr;
    }

    .calcium-inputs {
      grid-template-columns: 1fr;
    }

    .big-input {
      font-size: 1.25rem !important;
    }

    .rate-value {
      font-size: 1.25rem;
    }

    .corrected-value {
      font-size: 1.25rem;
    }

    .safety-banner {
      font-size: 0.75rem;
      padding: 0.5rem;
    }

    .ecg-grid, .symptoms-grid {
      gap: 0.35rem;
    }

    .ecg-btn, .symptom-btn {
      padding: 0.4rem 0.6rem;
      font-size: 0.7rem;
    }

    .treatment-item {
      padding: 0.75rem;
    }

    .treatment-dose {
      font-size: 0.8rem;
      padding: 0.4rem;
    }

    .footer {
      padding: 1rem;
      font-size: 0.7rem;
    }

    .pump-result {
      padding: 0.75rem;
    }

    .pump-result h4 {
      font-size: 0.65rem;
    }

    .inherited-na {
      font-size: 0.75rem;
    }

    .warnings-box p {
      font-size: 0.75rem;
    }

    .monitoring-badge {
      font-size: 0.65rem;
    }
  }
</style>
