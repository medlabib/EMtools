<script lang="ts">
  import { _ } from 'svelte-i18n';
  import { 
    type PatientData, 
    type CalculationResults,
    defaultPatientData,
    calculateAll,
    DEFINITIONS
  } from './bloodgas/bloodgas';
  
  type DefinitionKey = keyof typeof DEFINITIONS;
  
  // State
  let patient: PatientData = { ...defaultPatientData };
  let results: CalculationResults | null = null;
  let activeInfo: DefinitionKey | null = null;
  
  // Reactive calculation
  $: results = calculateAll(patient);
  
  // Handle input changes
  function handleChange(event: Event) {
    const target = event.target as HTMLInputElement;
    const { name, value } = target;
    patient = {
      ...patient,
      [name]: parseFloat(value) || 0
    };
  }
  
  function setGender(gender: 'male' | 'female') {
    patient = { ...patient, gender };
  }
  
  function openInfo(key: DefinitionKey) {
    activeInfo = key;
  }
  
  function closeInfo() {
    activeInfo = null;
  }
</script>

<div class="max-w-6xl mx-auto p-4">
  <!-- INFO MODAL -->
  {#if activeInfo && DEFINITIONS[activeInfo]}
    <dialog class="modal modal-open">
      <div class="modal-box max-w-md">
        <button class="btn btn-sm btn-circle btn-ghost absolute right-2 top-2" on:click={closeInfo}>✕</button>
        <h3 class="font-bold text-lg flex items-center gap-2">
          <span>ℹ️</span>
          {DEFINITIONS[activeInfo].title}
        </h3>
        <div class="py-4 text-base-content/80">
          {DEFINITIONS[activeInfo].content}
        </div>
        <div class="modal-action">
          <button class="btn btn-primary" on:click={closeInfo}>Compris</button>
        </div>
      </div>
      <form method="dialog" class="modal-backdrop">
        <button on:click={closeInfo}>close</button>
      </form>
    </dialog>
  {/if}

  <!-- HEADER -->
  <header class="flex items-center justify-between bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-2xl p-4 mb-6">
    <div class="flex items-center gap-3">
      <div class="text-3xl">📊</div>
      <div>
        <h1 class="text-xl font-bold">{$_('tools.bloodGas.title')}</h1>
        <p class="text-sm opacity-90">{$_('tools.bloodGas.description')}</p>
      </div>
    </div>
    <div class="badge badge-lg bg-white/20 border-0 text-white">
      <span class="font-bold">ICU</span>
      <span class="ml-1 opacity-80">GRADE</span>
    </div>
  </header>

  <main class="grid gap-6 lg:grid-cols-2">
    <!-- LEFT COLUMN: INPUTS -->
    <div class="space-y-4">
      
      <!-- PATIENT -->
      <div class="card bg-base-100 shadow-md">
        <div class="card-body p-4">
          <div class="flex items-center justify-between mb-3">
            <h2 class="card-title text-base flex items-center gap-2">
              <span class="text-blue-500">🧮</span>
              Patient & Constantes
            </h2>
            <button class="btn btn-circle btn-ghost btn-sm" on:click={() => openInfo('patient')}>❓</button>
          </div>
          <div class="grid gap-3 sm:grid-cols-2">
            <div class="form-control">
              <span class="label py-1"><span class="label-text">Sexe</span></span>
              <div class="join w-full">
                <button 
                  class="join-item btn btn-sm flex-1"
                  class:btn-primary={patient.gender === 'male'} 
                  on:click={() => setGender('male')}
                >Homme</button>
                <button 
                  class="join-item btn btn-sm flex-1"
                  class:btn-primary={patient.gender === 'female'} 
                  on:click={() => setGender('female')}
                >Femme</button>
              </div>
            </div>
            <div class="form-control">
              <label for="height" class="label py-1"><span class="label-text">Taille (cm)</span></label>
              <input type="number" id="height" name="height" bind:value={patient.height} on:change={handleChange} class="input input-bordered input-sm" />
            </div>
          </div>
          <div class="grid gap-3 grid-cols-3 mt-2">
            <div class="form-control">
              <label for="age" class="label py-1"><span class="label-text">Age</span></label>
              <input type="number" id="age" name="age" bind:value={patient.age} on:change={handleChange} class="input input-bordered input-sm" />
            </div>
            <div class="form-control">
              <label for="temp" class="label py-1"><span class="label-text">Temp (°C)</span></label>
              <input type="number" id="temp" name="temp" bind:value={patient.temp} step="0.1" on:change={handleChange} class="input input-bordered input-sm" />
            </div>
            <div class="form-control">
              <label for="hb" class="label py-1"><span class="label-text text-error">Hb (g/dL)</span></label>
              <input type="number" id="hb" name="hb" bind:value={patient.hb} step="0.1" on:change={handleChange} class="input input-bordered input-sm border-error" />
            </div>
          </div>
        </div>
      </div>

      <!-- GDS -->
      <div class="card bg-base-100 shadow-md">
        <div class="card-body p-4">
          <div class="flex items-center justify-between mb-3">
            <h2 class="card-title text-base flex items-center gap-2">
              <span class="text-red-500">❤️</span>
              Gazométrie (GDS)
            </h2>
            <button class="btn btn-circle btn-ghost btn-sm" on:click={() => openInfo('gds')}>❓</button>
          </div>
          <div class="grid gap-3 grid-cols-3">
            <div class="form-control">
              <label for="ph" class="label py-1"><span class="label-text font-semibold">pH</span></label>
              <input type="number" id="ph" name="ph" bind:value={patient.ph} step="0.01" min="6.8" max="7.8" on:change={handleChange} class="input input-bordered input-sm border-primary" />
            </div>
            <div class="form-control">
              <label for="paco2" class="label py-1"><span class="label-text">PaCO2</span></label>
              <input type="number" id="paco2" name="paco2" bind:value={patient.paco2} on:change={handleChange} class="input input-bordered input-sm" />
            </div>
            <div class="form-control">
              <label for="pao2" class="label py-1"><span class="label-text">PaO2</span></label>
              <input type="number" id="pao2" name="pao2" bind:value={patient.pao2} on:change={handleChange} class="input input-bordered input-sm" />
            </div>
          </div>
          <div class="grid gap-3 grid-cols-3 mt-2">
            <div class="form-control">
              <label for="hco3" class="label py-1"><span class="label-text">HCO3</span></label>
              <input type="number" id="hco3" name="hco3" bind:value={patient.hco3} on:change={handleChange} class="input input-bordered input-sm" />
            </div>
            <div class="form-control">
              <label for="sao2" class="label py-1"><span class="label-text">SaO2 (%)</span></label>
              <input type="number" id="sao2" name="sao2" bind:value={patient.sao2} max="100" on:change={handleChange} class="input input-bordered input-sm" />
            </div>
            <div class="form-control">
              <label for="lactate" class="label py-1"><span class="label-text" class:text-warning={patient.lactate >= 2}>Lactate</span></label>
              <input type="number" id="lactate" name="lactate" bind:value={patient.lactate} step="0.1" on:change={handleChange} class="input input-bordered input-sm" class:border-warning={patient.lactate >= 2} />
            </div>
          </div>
        </div>
      </div>

      <!-- IONOGRAM -->
      <div class="card bg-base-100 shadow-md">
        <div class="card-body p-4">
          <div class="flex items-center justify-between mb-3">
            <h2 class="card-title text-base flex items-center gap-2">
              <span class="text-yellow-500">⚡</span>
              Ionogramme
            </h2>
            <button class="btn btn-circle btn-ghost btn-sm" on:click={() => openInfo('iono')}>❓</button>
          </div>
          <div class="grid gap-3 grid-cols-3">
            <div class="form-control">
              <label for="na" class="label py-1"><span class="label-text">Na+</span></label>
              <input type="number" id="na" name="na" bind:value={patient.na} on:change={handleChange} class="input input-bordered input-sm" />
            </div>
            <div class="form-control">
              <label for="cl" class="label py-1"><span class="label-text">Cl-</span></label>
              <input type="number" id="cl" name="cl" bind:value={patient.cl} on:change={handleChange} class="input input-bordered input-sm" />
            </div>
            <div class="form-control">
              <label for="alb" class="label py-1"><span class="label-text" class:text-warning={patient.alb < 3.5}>Albumine</span></label>
              <input type="number" id="alb" name="alb" bind:value={patient.alb} step="0.1" on:change={handleChange} class="input input-bordered input-sm" class:border-warning={patient.alb < 3.5} />
            </div>
          </div>
        </div>
      </div>

      <!-- VENTILATOR -->
      <div class="card bg-base-100 shadow-md">
        <div class="card-body p-4">
          <div class="flex items-center justify-between mb-3">
            <h2 class="card-title text-base flex items-center gap-2">
              <span class="text-teal-500">🌬️</span>
              Respirateur
            </h2>
            <button class="btn btn-circle btn-ghost btn-sm" on:click={() => openInfo('respi')}>❓</button>
          </div>
          <div class="grid gap-3 grid-cols-3">
            <div class="form-control">
              <label for="fio2" class="label py-1"><span class="label-text">FiO2</span></label>
              <input type="number" id="fio2" name="fio2" bind:value={patient.fio2} step="0.05" min="0.21" max="1.0" on:change={handleChange} class="input input-bordered input-sm" />
            </div>
            <div class="form-control">
              <label for="vt" class="label py-1"><span class="label-text">Vt (ml)</span></label>
              <input type="number" id="vt" name="vt" bind:value={patient.vt} step="10" on:change={handleChange} class="input input-bordered input-sm" />
            </div>
            <div class="form-control">
              <label for="rr" class="label py-1"><span class="label-text">Fréquence</span></label>
              <input type="number" id="rr" name="rr" bind:value={patient.rr} on:change={handleChange} class="input input-bordered input-sm" />
            </div>
          </div>
          <div class="grid gap-3 grid-cols-3 mt-2">
            <div class="form-control">
              <label for="peep" class="label py-1"><span class="label-text">PEEP</span></label>
              <input type="number" id="peep" name="peep" bind:value={patient.peep} on:change={handleChange} class="input input-bordered input-sm" />
            </div>
            <div class="form-control">
              <label for="pplat" class="label py-1"><span class="label-text" class:text-warning={patient.pplat > 30}>P.Plat</span></label>
              <input type="number" id="pplat" name="pplat" bind:value={patient.pplat} on:change={handleChange} class="input input-bordered input-sm" class:border-warning={patient.pplat > 30} />
            </div>
            <div class="form-control">
              <label for="ppeak" class="label py-1"><span class="label-text font-semibold">P.Crête</span></label>
              <input type="number" id="ppeak" name="ppeak" bind:value={patient.ppeak} on:change={handleChange} class="input input-bordered input-sm border-primary" />
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- RIGHT COLUMN: RESULTS -->
    <div class="space-y-4">
      {#if results}
        <!-- DIAGNOSTIC BANNER -->
        <div class="card bg-gradient-to-br from-slate-800 to-slate-900 text-white shadow-lg">
          <div class="card-body p-4">
            <div class="flex justify-between items-start flex-wrap gap-2">
              <div>
                <span class="text-xs uppercase tracking-wide opacity-70">État Clinique</span>
                <div class="text-lg font-bold">
                  {results.status} <span class="text-cyan-400">{results.primary}</span>
                </div>
              </div>
              {#if results.lactate_status !== "Normal"}
                <div class="badge badge-error">{results.lactate_status}</div>
              {/if}
            </div>
            
            <div class="flex flex-wrap gap-2 my-3">
              {#if results.winter_msg}
                <span class="badge badge-outline">{results.winter_msg}</span>
              {/if}
              {#if results.resistive_gradient > 5}
                <span class="badge badge-warning">Résistances Élevées</span>
              {/if}
              {#if results.cao2 < 12}
                <span class="badge badge-error">Transport O2 Critique</span>
              {/if}
            </div>

            <div class="stats stats-vertical sm:stats-horizontal bg-base-100/10 text-white w-full">
              <div class="stat p-2">
                <div class="stat-title text-xs opacity-70">Rapport P/F</div>
                <div class="stat-value text-lg" class:text-error={results.pf_ratio < 200} class:text-success={results.pf_ratio >= 300}>
                  {Math.round(results.pf_ratio)}
                </div>
                <div class="stat-desc text-xs opacity-60">{results.ards_grade}</div>
              </div>
              <div class="stat p-2">
                <div class="stat-title text-xs opacity-70">Contenu O2</div>
                <div class="stat-value text-lg" class:text-error={results.cao2 < 12} class:text-success={results.cao2 >= 16}>
                  {results.cao2.toFixed(1)} <span class="text-xs">ml/dL</span>
                </div>
                <div class="stat-desc text-xs opacity-60">{results.cao2 < 16 ? "Bas (<16)" : "Normal"}</div>
              </div>
              <div class="stat p-2">
                <div class="stat-title text-xs opacity-70">Driving P.</div>
                <div class="stat-value text-lg" class:text-warning={results.driving_pressure > 15}>
                  {results.driving_pressure} <span class="text-xs">cmH2O</span>
                </div>
                <div class="stat-desc text-xs opacity-60">{results.driving_pressure > 15 ? ">15 Danger" : "Protecteur"}</div>
              </div>
              <div class="stat p-2">
                <div class="stat-title text-xs opacity-70">P.Crête-Plat</div>
                <div class="stat-value text-lg" class:text-warning={results.resistive_gradient > 5}>
                  {results.resistive_gradient} <span class="text-xs">cmH2O</span>
                </div>
                <div class="stat-desc text-xs opacity-60">Résistance</div>
              </div>
            </div>
          </div>
        </div>

        <div class="grid gap-4 sm:grid-cols-2">
          <!-- O2 TRANSPORT -->
          <div class="card">
            <div class="card-header red">
              <span class="card-icon">🔥</span>
              <h2>Transport O2 & Hématose</h2>
              <button class="info-btn" on:click={() => openInfo('transport')}>❓</button>
            </div>
            <div class="card-body">
              <div class="result-row highlight-box red">
                <div>
                  <strong>CaO2 (Contenu Artériel)</strong>
                  <small>Reflet de l'apport tissulaire</small>
                </div>
                <div class="result-value">{results.cao2.toFixed(1)} <small>ml/dL</small></div>
              </div>
              {#if results.cao2 < 12}
                <div class="alert danger">
                  ⚠️ Risque Hypoxie Tissulaire malgré SaO2 correcte (Anémie ?)
                </div>
              {/if}
              <div class="result-row">
                <span>Gradient A-a O2</span>
                <span class="result-value" class:danger={results.aa_gradient > results.expected_aa + 10}>
                  {Math.round(results.aa_gradient)} <small>/ {Math.round(results.expected_aa)} exp</small>
                </span>
              </div>
            </div>
          </div>

          <!-- MECHANICS -->
          <div class="card">
            <div class="card-header orange">
              <span class="card-icon">⚙️</span>
              <h2>Mécanique Ventilatoire</h2>
              <button class="info-btn" on:click={() => openInfo('meca')}>❓</button>
            </div>
            <div class="card-body">
              <div class="mini-stats">
                <div class="mini-stat">
                  <span class="mini-label">Compliance</span>
                  <span class="mini-value">{Math.round(results.compliance)} <small>ml/cmH2O</small></span>
                </div>
                <div class="mini-stat" class:warning={results.resistive_gradient > 5}>
                  <span class="mini-label">Résistances (Grad)</span>
                  <span class="mini-value">{results.resistive_gradient} <small>cmH2O</small></span>
                </div>
              </div>
              <div class="progress-section">
                <div class="progress-header">
                  <span>Vt / PBW ({results.pbw.toFixed(0)}kg)</span>
                  <span class:danger={results.vt_per_kg > 8} class:success={results.vt_per_kg <= 6}>
                    {results.vt_per_kg.toFixed(1)} ml/kg
                  </span>
                </div>
                <div class="progress-bar">
                  <div 
                    class="progress-fill"
                    class:danger={results.vt_per_kg > 8}
                    class:warning={results.vt_per_kg > 6 && results.vt_per_kg <= 8}
                    class:success={results.vt_per_kg <= 6}
                    style="width: {Math.min(results.vt_per_kg * 10, 100)}%"
                  ></div>
                </div>
              </div>
            </div>
          </div>

          <!-- METABOLIC -->
          <div class="card">
            <div class="card-header purple">
              <span class="card-icon">🧪</span>
              <h2>Troubles Métaboliques</h2>
              <button class="info-btn" on:click={() => openInfo('metabo')}>❓</button>
            </div>
            <div class="card-body">
              <div class="result-row">
                <span>Trou Anionique Corr.</span>
                <span class="result-value" class:danger={results.ag_corrected > 16}>
                  {results.ag_corrected.toFixed(1)}
                </span>
              </div>
              {#if results.ag_corrected > 14}
                <div class="alert info">
                  {results.delta_ratio < 0.8 
                    ? "Acidose Mixte (AG + Hyperchlorémique)" 
                    : "Acidose à Trou Anionique Élevé pure"}
                </div>
              {/if}
            </div>
          </div>

          <!-- ACTIONS -->
          <div class="card actions-card">
            <div class="card-header blue">
              <span class="card-icon">🎯</span>
              <h2>Actions Prioritaires</h2>
            </div>
            <div class="card-body">
              <ul class="actions-list">
                {#if results.resistive_gradient > 5}
                  <li><strong>Obstruction ?</strong> Vérifier sonde, aspiration, bronchodilatateurs.</li>
                {/if}
                {#if results.driving_pressure > 15}
                  <li><strong>Protection :</strong> Baisser Vt ou optimiser PEEP.</li>
                {/if}
                {#if results.cao2 < 12}
                  <li><strong>Transport O2 bas :</strong> Transfusion CGR ? Optimiser débit cardiaque.</li>
                {/if}
                {#if results.pf_ratio < 150}
                  <li><strong>Hypoxémie Sévère :</strong> Discuter DV.</li>
                {/if}
                {#if results.resistive_gradient <= 5 && results.driving_pressure <= 15 && results.cao2 >= 12 && results.pf_ratio >= 150}
                  <li>✅ Pas d'action urgente identifiée. Continuer la surveillance.</li>
                {/if}
              </ul>
            </div>
          </div>
        </div>
      {/if}
    </div>
  </main>
</div>

<style>
  /* CARDS */
  .card {
    background: white;
    border-radius: 12px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    border: 1px solid #e2e8f0;
    overflow: hidden;
  }

  .card-header {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.75rem 1rem;
    border-bottom: 1px solid #e2e8f0;
  }

  .card-header.blue { background: linear-gradient(to right, #eff6ff, white); }
  .card-header.red { background: linear-gradient(to right, #fef2f2, white); }
  .card-header.orange { background: linear-gradient(to right, #fff7ed, white); }
  .card-header.purple { background: linear-gradient(to right, #faf5ff, white); }

  .card-icon {
    font-size: 1rem;
  }

  .card-header h2 {
    flex: 1;
    font-size: 0.75rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    color: #475569;
    margin: 0;
  }

  .info-btn {
    background: none;
    border: none;
    cursor: pointer;
    opacity: 0.5;
    transition: opacity 0.2s;
  }

  .info-btn:hover {
    opacity: 1;
  }

  .card-body {
    padding: 1rem;
  }

  @keyframes pulse {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.5; }
  }

  /* RESULT ROWS */
  .result-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.5rem 0;
    border-bottom: 1px solid #f1f5f9;
    font-size: 0.875rem;
    color: #64748b;
  }

  .result-row:last-child {
    border-bottom: none;
  }

  .result-row.highlight-box {
    background: #fef2f2;
    padding: 0.75rem;
    border-radius: 8px;
    border: 1px solid #fecaca;
    margin-bottom: 0.5rem;
  }

  .result-row.highlight-box div:first-child strong {
    display: block;
    color: #7f1d1d;
    font-size: 0.7rem;
    text-transform: uppercase;
  }

  .result-row.highlight-box div:first-child small {
    color: rgba(127, 29, 29, 0.7);
    font-size: 0.65rem;
  }

  .result-value {
    font-family: monospace;
    font-weight: 700;
    color: #475569;
  }

  .result-value small {
    font-size: 0.7rem;
    color: #94a3b8;
    font-weight: 400;
  }

  .result-value.danger { color: #ef4444; }

  /* ALERTS */
  .alert {
    padding: 0.5rem 0.75rem;
    border-radius: 6px;
    font-size: 0.75rem;
    font-weight: 500;
    margin: 0.5rem 0;
  }

  .alert.danger {
    background: #fef2f2;
    color: #b91c1c;
    border: 1px solid #fecaca;
  }

  .alert.info {
    background: #f5f3ff;
    color: #5b21b6;
    border: 1px solid #ddd6fe;
  }

  /* MINI STATS */
  .mini-stats {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 0.5rem;
    margin-bottom: 1rem;
  }

  .mini-stat {
    text-align: center;
    padding: 0.75rem;
    background: #f8fafc;
    border-radius: 8px;
    border: 1px solid #e2e8f0;
  }

  .mini-stat.warning {
    background: #fef3c7;
    border-color: #fde68a;
  }

  .mini-label {
    display: block;
    font-size: 0.6rem;
    color: #94a3b8;
    text-transform: uppercase;
    font-weight: 700;
  }

  .mini-value {
    display: block;
    font-size: 1.125rem;
    font-weight: 700;
    color: #475569;
  }

  .mini-value small {
    font-size: 0.6rem;
    font-weight: 400;
    color: #94a3b8;
  }

  /* PROGRESS */
  .progress-section {
    margin-top: 0.5rem;
  }

  .progress-header {
    display: flex;
    justify-content: space-between;
    font-size: 0.75rem;
    margin-bottom: 0.25rem;
    color: #64748b;
  }

  .progress-header .success { color: #16a34a; font-weight: 600; }
  .progress-header .danger { color: #dc2626; font-weight: 600; }

  .progress-bar {
    width: 100%;
    height: 8px;
    background: #e2e8f0;
    border-radius: 4px;
    overflow: hidden;
  }

  .progress-fill {
    height: 100%;
    border-radius: 4px;
    transition: width 0.5s ease-out;
  }

  .progress-fill.success { background: #22c55e; }
  .progress-fill.warning { background: #fb923c; }
  .progress-fill.danger { background: #ef4444; }

  /* ACTIONS CARD */
  .actions-card {
    grid-column: span 2;
    background: #eff6ff;
    border-color: #bfdbfe;
  }

  @media (max-width: 768px) {
    .actions-card {
      grid-column: span 1;
    }
  }

  .actions-list {
    list-style: disc;
    padding-left: 1.25rem;
    margin: 0;
    font-size: 0.8rem;
    color: rgba(30, 58, 138, 0.9);
  }

  .actions-list li {
    margin-bottom: 0.5rem;
  }

  .actions-list li:last-child {
    margin-bottom: 0;
  }

  .actions-list strong {
    color: #1e3a8a;
  }

  /* DARK MODE */
  @media (prefers-color-scheme: dark) {
    .card {
      background: #1e293b;
      border-color: #334155;
    }

    .card-header h2 {
      color: #e2e8f0;
    }

    .card-header.blue { background: linear-gradient(to right, rgba(59, 130, 246, 0.1), transparent); }
    .card-header.red { background: linear-gradient(to right, rgba(239, 68, 68, 0.1), transparent); }
    .card-header.orange { background: linear-gradient(to right, rgba(249, 115, 22, 0.1), transparent); }
    .card-header.purple { background: linear-gradient(to right, rgba(168, 85, 247, 0.1), transparent); }

    .result-row {
      border-color: #334155;
      color: #94a3b8;
    }

    .result-value {
      color: #e2e8f0;
    }

    .mini-stat {
      background: #334155;
      border-color: #475569;
    }

    .mini-value,
    .mini-label {
      color: #e2e8f0;
    }

    .progress-bar {
      background: #334155;
    }

    .actions-card {
      background: rgba(59, 130, 246, 0.1);
      border-color: rgba(59, 130, 246, 0.3);
    }

    .actions-list {
      color: #93c5fd;
    }

    .actions-list strong {
      color: #60a5fa;
    }

    .alert.info {
      background: rgba(139, 92, 246, 0.1);
      border-color: rgba(139, 92, 246, 0.3);
      color: #c4b5fd;
    }

    .result-row.highlight-box {
      background: rgba(239, 68, 68, 0.1);
      border-color: rgba(239, 68, 68, 0.3);
    }

    .result-row.highlight-box div:first-child strong {
      color: #fca5a5;
    }

    .result-row.highlight-box div:first-child small {
      color: rgba(252, 165, 165, 0.7);
    }
  }
</style>
