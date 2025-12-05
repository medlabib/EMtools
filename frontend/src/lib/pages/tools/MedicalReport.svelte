<script lang="ts">
  import { _, locale } from 'svelte-i18n';
  
  // Form state
  let form = {
    // Identity
    patientName: '',
    gender: 'male',
    age: '',
    motif: '',
    
    // Context
    isTrauma: false,
    mecanisme: '',

    // A - Airway
    airwayStatus: 'clear',
    airwayDevice: '',
    airwaySize: '',
    airwayAction: '',

    // B - Breathing
    respiratoryRate: '',
    workOfBreathing: [] as string[],
    ampliation: 'symmetric',
    traumaRibs: '',
    traumaEmphysema: false,
    auscultation: 'clear',
    auscultationType: '',
    spo2: '',
    oxygenDevice: '',
    oxygenFlow: '',
    bAction: '',

    // C - Circulation
    extremities: 'warm',
    chocSigns: [] as string[],
    heartFailureSigns: [] as string[],
    bpRight: '',
    bpLeft: '',
    pulse: '',
    
    // ECG
    ecgRhythm: 'sinus',
    ecgRate: '',
    ecgP: 'normal',
    ecgPR: 'normal',
    ecgQRS: 'narrow',
    ecgQRSDetails: '',
    ecgScarbossa: false,
    ecgST: 'normal',
    ecgSTTerritory: '',
    ecgT: 'normal',

    // D - Disability
    gcsE: 4,
    gcsV: 5,
    gcsM: 6,
    pupils: 'perrl',
    pupilsDetails: '',
    neuroDeficit: 'none',
    aphasia: false,
    gad: '',
    meningealSigns: false,
    purpura: false,

    // E - Exposure / History
    terrainType: 'none',
    terrainDetails: '',
    tabac: false,
    pa: '',
    alcool: false,
    hdm: '',
  };

  let report = '';
  let copied = false;

  // Computed values
  $: gcsTotal = Number(form.gcsE) + Number(form.gcsV) + Number(form.gcsM);

  // Work of breathing options (keys for translation)
  const wobKeys = ['wobSuprasternal', 'wobSubcostal', 'wobIntercostal', 'wobParadoxical', 'wobGasping'];
  const chocKeys = ['shockMottling', 'shockCRT', 'shockWeakPulse', 'shockAsymmetric'];
  const heartFailureKeys = ['jvd', 'hjr', 'peripheralEdema'];

  function getRRInterpretation(rate: string): string {
    const r = parseInt(rate);
    if (!r) return '';
    const t = $_('medicalReport.report');
    if (r < 12) return `${$_('medicalReport.report.bradypneic')} ${r} ${$_('medicalReport.report.rpm')}`;
    if (r > 20) return `${$_('medicalReport.report.tachypneic')} ${r} ${$_('medicalReport.report.rpm')}`;
    return `${$_('medicalReport.report.eupneic')} ${r} ${$_('medicalReport.report.rpm')}`;
  }

  function getECGText(): string {
    let text = form.ecgRhythm === 'irregular' 
      ? $_('medicalReport.report.rhythmIrregular')
      : $_('medicalReport.report.rhythmRegular');
    
    text += ` ${$_(`medicalReport.circulation.ecg.rhythm${form.ecgRhythm.charAt(0).toUpperCase() + form.ecgRhythm.slice(1)}`)}`;
    
    if (form.ecgRhythm === 'af' || form.ecgRhythm === 'flutter') {
      text += ` ${form.ecgRate || '?'} ${$_('medicalReport.report.bpm')}`;
    }
    
    text += `, ${$_('medicalReport.report.pWave')} ${$_(`medicalReport.circulation.ecg.p${form.ecgP.charAt(0).toUpperCase() + form.ecgP.slice(1)}`)}`;
    text += `, ${$_('medicalReport.report.prInterval')} ${$_(`medicalReport.circulation.ecg.pr${form.ecgPR.charAt(0).toUpperCase() + form.ecgPR.slice(1)}`)}`;
    text += `, ${$_('medicalReport.report.qrsComplex')} ${$_(`medicalReport.circulation.ecg.qrs${form.ecgQRS.charAt(0).toUpperCase() + form.ecgQRS.slice(1)}`)}`;
    
    if (form.ecgQRS === 'wide' && form.ecgQRSDetails) {
      text += ` ${form.ecgQRSDetails}`;
    }
    if (form.ecgScarbossa) text += ` ${$_('medicalReport.report.sgarbossaPresent')}`;

    text += `, ${$_('medicalReport.report.stSegment')} ${$_(`medicalReport.circulation.ecg.st${form.ecgST.charAt(0).toUpperCase() + form.ecgST.slice(1)}`)}`;
    if (form.ecgST !== 'normal' && form.ecgSTTerritory) text += ` ${form.ecgSTTerritory}`;
    
    text += `, ${$_('medicalReport.report.tWave')} ${$_(`medicalReport.circulation.ecg.t${form.ecgT.charAt(0).toUpperCase() + form.ecgT.slice(1)}`)}`;
    return text;
  }

  function getSeverityDescription(): string {
    const isRespDistress = (parseInt(form.spo2) < 90) || 
                          (parseInt(form.respiratoryRate) > 30) || 
                          (parseInt(form.respiratoryRate) < 10) || 
                          form.workOfBreathing.length > 0;
    const isHemoDistress = (parseInt(form.bpRight?.split('/')[0]) < 90) || form.chocSigns.length > 0;
    const isNeuroDistress = gcsTotal < 13 || form.neuroDeficit !== 'none';
    const isStemi = form.ecgST === 'elevation';

    let text = "";

    if (isStemi) {
      text = $_('medicalReport.report.presentingSTEMI');
      const distresses = [];
      if (isRespDistress) distresses.push($_('medicalReport.report.respiratory'));
      if (isHemoDistress) distresses.push($_('medicalReport.report.hemodynamic'));
      if (isNeuroDistress) distresses.push($_('medicalReport.report.neurological'));
      
      if (distresses.length > 0) text += ` ${$_('medicalReport.report.withDistress')} ${distresses.join(' & ')}`;
      else text += ` ${$_('medicalReport.report.withoutVitalDistress')}`;
      text += ".";
    } else if (!isRespDistress && !isHemoDistress && !isNeuroDistress) {
      text = $_('medicalReport.report.noVitalDistress');
    } else {
      text = `${$_('medicalReport.report.presents')} `;
      const distressParts = [];

      if (isRespDistress) {
        const auscText = form.auscultation === 'clear' 
          ? $_('medicalReport.report.lungClear') 
          : form.auscultationType;
        distressParts.push(`${$_('medicalReport.report.respiratoryDistress')} ${auscText}`);
      }
      if (isHemoDistress) {
        distressParts.push(`${$_('medicalReport.report.hemodynamicDistress')} ${getECGText()}`);
      }
      if (isNeuroDistress) {
        const hypoText = form.gad && parseFloat(form.gad) < 0.7 
          ? $_('medicalReport.report.withHypoglycemia')
          : $_('medicalReport.report.withoutHypoglycemia');
        distressParts.push(`${$_('medicalReport.report.neurologicalDistress')} ${hypoText} ${$_('medicalReport.report.hypoglycemia')}`);
      }
      
      text += distressParts.join(' + ');
      text += ".";
    }

    return text;
  }

  function toggleArrayItem(arr: string[], item: string): string[] {
    if (arr.includes(item)) {
      return arr.filter(i => i !== item);
    } else {
      return [...arr, item];
    }
  }

  function generateReport() {
    const isFemale = form.gender === 'female';
    const genderSuffix = isFemale ? 'e' : '';
    const nameStr = form.patientName ? ` ${form.patientName}` : '';
    const patientIntro = `${$_('medicalReport.report.intro')} ${isFemale ? $_('medicalReport.report.femalePatient') : $_('medicalReport.report.malePatient')}${nameStr}`;
    
    // For French: "âgé(e) de X ans", for English: "aged X years old"
    const agedBase = $_('medicalReport.report.agedOf');
    const agedWithSuffix = $locale === 'fr' ? `${agedBase}${genderSuffix}` : agedBase;
    const ofAge = $_('medicalReport.report.ofAge');
    const ageValue = form.age || '...';
    const ageStr = ofAge ? `${agedWithSuffix} ${ofAge} ${ageValue} ${$_('medicalReport.report.years')}` : `${agedWithSuffix} ${ageValue} ${$_('medicalReport.report.years')}`;
    
    let r = `${patientIntro} ${ageStr} ${$_('medicalReport.report.presentsFor')} ${form.motif || '...'}.\n\n`;

    // Context - show mechanism only, without "Contexte: Traumatique" line
    if (form.isTrauma && form.mecanisme) {
      r += `${$_('medicalReport.report.mechanismOfInjury')}: ${form.mecanisme}\n`;
    }
    
    r += `\n${$_('medicalReport.report.severityAssessment')}:\n`;

    // A
    r += `A: ${$_('medicalReport.airway.title').replace('💨 ', '')}: ${$_(`medicalReport.airway.status${form.airwayStatus.charAt(0).toUpperCase() + form.airwayStatus.slice(1)}`)}`;
    if (form.airwayDevice) r += `, ${$_('medicalReport.report.airwaySecured')} ${$_(`medicalReport.airway.device${form.airwayDevice.charAt(0).toUpperCase() + form.airwayDevice.slice(1)}`)} N° ${form.airwaySize}`;
    r += '\n';
    if (form.airwayAction) r += `${$_('medicalReport.report.actionLabel')}: ${form.airwayAction}\n`;

    // B
    r += `B:\n`;
    r += `  ${$_('medicalReport.report.frequency')}: ${getRRInterpretation(form.respiratoryRate)}\n`;
    const wobText = form.workOfBreathing.length === 0 
      ? $_('medicalReport.report.noDistressSigns')
      : form.workOfBreathing.map(k => $_(`medicalReport.breathing.${k}`)).join(', ');
    r += `  ${$_('medicalReport.report.workLabel')}: ${wobText}\n`;
    r += `  ${$_('medicalReport.report.volumeLabel')}: ${$_('medicalReport.report.chestExpansion')} ${$_(`medicalReport.breathing.expansion${form.ampliation.charAt(0).toUpperCase() + form.ampliation.slice(1)}`)}`;
    if (form.isTrauma) {
      r += `, ${form.traumaRibs ? `${$_('medicalReport.report.ribCrepitusPresent')} (${form.traumaRibs})` : $_('medicalReport.report.noRibCrepitus')}`;
      r += `, ${form.traumaEmphysema ? $_('medicalReport.report.subcutEmphysemaPresent') : $_('medicalReport.report.subcutEmphysemaAbsent')}`;
    }
    r += '\n';
    r += `  ${$_('medicalReport.report.auscultationLabel')}: ${form.auscultation === 'clear' ? $_('medicalReport.report.lungClear') : `${$_('medicalReport.report.ralesPresent')} (${form.auscultationType})`}\n`;
    r += `  ${$_('medicalReport.report.o2')} = ${form.spo2 || '...'} %\n`;
    
    let bConduites = [];
    if (form.oxygenDevice) bConduites.push(`${$_('medicalReport.report.oxygenTherapy')} ${$_(`medicalReport.breathing.oxygen${form.oxygenDevice.charAt(0).toUpperCase() + form.oxygenDevice.slice(1)}`)} ${$_('medicalReport.report.at')} ${form.oxygenFlow} ${$_('medicalReport.report.lPerMin')}`);
    if (form.bAction) bConduites.push(form.bAction);
    if (bConduites.length > 0) r += `${$_('medicalReport.report.actionLabel')}: ${bConduites.join(', ')}\n`;

    // C
    r += `C:\n`;
    const chocText = form.chocSigns.length === 0 
      ? $_('medicalReport.report.noPeripheralShockSigns')
      : form.chocSigns.map(k => $_(`medicalReport.circulation.${k}`)).join(', ');
    r += `${$_('medicalReport.report.extremitiesLabel')} ${$_(`medicalReport.circulation.extremities${form.extremities.charAt(0).toUpperCase() + form.extremities.slice(1)}`)}. ${chocText}.\n`;
    const hfText = form.heartFailureSigns.length === 0 
      ? $_('medicalReport.report.noRightHeartSigns')
      : form.heartFailureSigns.map(k => $_(`medicalReport.circulation.${k}`)).join(', ');
    r += `${hfText}.\n`;
    r += `${$_('medicalReport.report.bpLabel')} ${form.bpRight || '.../...'} ${$_('medicalReport.report.andLeft')} ${form.bpLeft || '.../...'}\n`;
    r += `${$_('medicalReport.report.pulseLabel')}: ${form.pulse || '...'} ${$_('medicalReport.report.bpm')}\n`;
    r += `${$_('medicalReport.report.ecgLabel')}: ${getECGText()}.\n`;

    // D
    r += `${$_('medicalReport.report.gcsLabel')} = ${gcsTotal} (E${form.gcsE} V${form.gcsV} M${form.gcsM})\n`;
    r += `${$_('medicalReport.report.pupilsLabel')} = ${form.pupils === 'perrl' ? $_('medicalReport.disability.pupilsPERRL') : form.pupilsDetails}\n`;
    r += `${$_(`medicalReport.disability.deficit${form.neuroDeficit.charAt(0).toUpperCase() + form.neuroDeficit.slice(1)}`)}${form.aphasia ? $_('medicalReport.report.withAphasia') : ''}.\n`;
    if (form.gad) r += `${$_('medicalReport.report.glucoseLabel')} = ${form.gad}\n`;
    if (form.meningealSigns) r += `${$_('medicalReport.report.meningealPresent')}\n`;
    if (form.purpura) r += `${$_('medicalReport.report.purpuraPresent')}\n`;

    // Severity summary
    const severityDesc = getSeverityDescription();
    r += `\n${$_('medicalReport.report.severityTotal')}: ${patientIntro} ${severityDesc}\n\n`;

    // E
    r += `${$_('medicalReport.report.exposureLabel')}\n`;
    r += `  ${$_('medicalReport.report.backgroundLabel')}: ${form.terrainType === 'none' ? $_('medicalReport.exposure.backgroundNone') : form.terrainDetails}\n`;
    r += `  ${$_('medicalReport.report.habitsLabel')}: ${form.tabac ? `${$_('medicalReport.report.smoker')} (${form.pa} ${$_('medicalReport.exposure.tobaccoPY')})` : $_('medicalReport.report.nonSmoker')}, ${form.alcool ? $_('medicalReport.report.drinker') : $_('medicalReport.report.nonDrinker')}\n`;
    r += `  ${$_('medicalReport.report.historyLabel')}: ${form.hdm}\n`;

    // Summary
    r += `\n${$_('medicalReport.report.summaryTitle')}\n`;
    
    let terrainSummary = form.terrainType === 'none' ? '' : form.terrainDetails;
    let terrainFullText = "";
    
    const isRas = form.terrainType === 'none' && !form.tabac && !form.alcool;
    
    if (isRas) {
      terrainFullText = $_('medicalReport.report.noSignificantHistory');
    } else {
      if (form.tabac) terrainSummary += `, ${$_('medicalReport.report.smoker').toLowerCase()}`;
      if (form.alcool) terrainSummary += `, ${$_('medicalReport.report.drinker').toLowerCase()}`;
      terrainFullText = `${$_('medicalReport.report.withHistoryOf')} ${terrainSummary}`;
    }

    const summaryAgeStr = form.age ? `${form.age} ${$_('medicalReport.report.years')}` : `.. ${$_('medicalReport.report.years')}`;
    r += `${patientIntro} ${summaryAgeStr} ${$_('medicalReport.report.presentsFor')} ${form.motif || '...'}, ${terrainFullText}, ${severityDesc}`;

    report = r;
  }

  // Reactive report generation - regenerate when form OR locale changes
  $: if (form && $locale) {
    generateReport();
  }

  async function copyToClipboard() {
    try {
      await navigator.clipboard.writeText(report);
      copied = true;
      setTimeout(() => {
        copied = false;
      }, 2000);
    } catch (err) {
      console.error('Failed to copy:', err);
      const textarea = document.createElement('textarea');
      textarea.value = report;
      document.body.appendChild(textarea);
      textarea.select();
      document.execCommand('copy');
      document.body.removeChild(textarea);
      copied = true;
      setTimeout(() => {
        copied = false;
      }, 2000);
    }
  }

  function resetForm() {
    form = {
      patientName: '',
      gender: 'male',
      age: '',
      motif: '',
      isTrauma: false,
      mecanisme: '',
      airwayStatus: 'clear',
      airwayDevice: '',
      airwaySize: '',
      airwayAction: '',
      respiratoryRate: '',
      workOfBreathing: [],
      ampliation: 'symmetric',
      traumaRibs: '',
      traumaEmphysema: false,
      auscultation: 'clear',
      auscultationType: '',
      spo2: '',
      oxygenDevice: '',
      oxygenFlow: '',
      bAction: '',
      extremities: 'warm',
      chocSigns: [],
      heartFailureSigns: [],
      bpRight: '',
      bpLeft: '',
      pulse: '',
      ecgRhythm: 'sinus',
      ecgRate: '',
      ecgP: 'normal',
      ecgPR: 'normal',
      ecgQRS: 'narrow',
      ecgQRSDetails: '',
      ecgScarbossa: false,
      ecgST: 'normal',
      ecgSTTerritory: '',
      ecgT: 'normal',
      gcsE: 4,
      gcsV: 5,
      gcsM: 6,
      pupils: 'perrl',
      pupilsDetails: '',
      neuroDeficit: 'none',
      aphasia: false,
      gad: '',
      meningealSigns: false,
      purpura: false,
      terrainType: 'none',
      terrainDetails: '',
      tabac: false,
      pa: '',
      alcool: false,
      hdm: '',
    };
  }
</script>

<div class="min-h-screen bg-base-200 p-4">
  <div class="max-w-7xl mx-auto grid grid-cols-1 lg:grid-cols-2 gap-6">
    <!-- LEFT COLUMN: FORM -->
    <div class="flex flex-col gap-4">
      <!-- HEADER -->
      <div class="card bg-base-100 shadow-md border-t-4 border-primary">
        <div class="card-body">
          <h1 class="card-title text-2xl">{$_('medicalReport.pageTitle')}</h1>
          <p class="text-base-content/70">{$_('medicalReport.pageSubtitle')}</p>
          
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
            <div class="form-control md:col-span-2">
              <label class="label" for="patientName">
                <span class="label-text font-medium">{$_('medicalReport.identity.patientName')}</span>
              </label>
              <input id="patientName" type="text" bind:value={form.patientName} placeholder={$_('medicalReport.identity.patientNamePlaceholder')} class="input input-bordered" />
            </div>
            
            <div class="form-control">
              <label class="label" for="gender">
                <span class="label-text font-medium">{$_('medicalReport.identity.gender')}</span>
              </label>
              <select id="gender" bind:value={form.gender} class="select select-bordered">
                <option value="male">{$_('medicalReport.identity.genderMale')}</option>
                <option value="female">{$_('medicalReport.identity.genderFemale')}</option>
              </select>
            </div>
            
            <div class="form-control">
              <label class="label" for="age">
                <span class="label-text font-medium">{$_('medicalReport.identity.age')}</span>
              </label>
              <input id="age" type="number" bind:value={form.age} placeholder={$_('medicalReport.identity.agePlaceholder')} class="input input-bordered" />
            </div>
            
            <div class="form-control md:col-span-2">
              <label class="label" for="motif">
                <span class="label-text font-medium">{$_('medicalReport.identity.reason')}</span>
              </label>
              <input id="motif" type="text" bind:value={form.motif} placeholder={$_('medicalReport.identity.reasonPlaceholder')} class="input input-bordered" />
            </div>
          </div>
          
          <div class="mt-4">
            <button
              type="button"
              class="w-full flex items-center justify-between p-4 rounded-xl border-2 transition-all duration-200 {form.isTrauma 
                ? 'bg-error/15 border-error text-error shadow-md' 
                : 'bg-base-200 border-base-300 hover:border-error/50 hover:bg-error/5'}"
              on:click={() => form.isTrauma = !form.isTrauma}
            >
              <div class="flex items-center gap-3">
                <span class="text-2xl">{form.isTrauma ? '🚨' : '🏥'}</span>
                <div class="text-left">
                  <span class="font-semibold block">{$_('medicalReport.context.traumaQuestion')}</span>
                  <span class="text-sm opacity-70">{form.isTrauma ? 'Contexte traumatique activé' : 'Cliquez pour activer'}</span>
                </div>
              </div>
              <div class="flex items-center gap-2">
                <div class="w-12 h-7 rounded-full transition-colors duration-200 {form.isTrauma ? 'bg-error' : 'bg-base-300'} relative">
                  <div class="absolute top-1 w-5 h-5 rounded-full bg-white shadow transition-all duration-200 {form.isTrauma ? 'left-6' : 'left-1'}"></div>
                </div>
              </div>
            </button>
          </div>
          
          {#if form.isTrauma}
            <div class="form-control mt-2">
              <label class="label" for="mecanisme">
                <span class="label-text font-medium">{$_('medicalReport.context.mechanism')}</span>
              </label>
              <textarea id="mecanisme" bind:value={form.mecanisme} rows="2" placeholder={$_('medicalReport.context.mechanismPlaceholder')} class="textarea textarea-bordered"></textarea>
            </div>
          {/if}
        </div>
      </div>

      <!-- A - AIRWAY -->
      <div class="card bg-base-100 shadow-md border-l-4 border-info">
        <div class="card-body">
          <h2 class="card-title text-lg">{$_('medicalReport.airway.title')}</h2>
          
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div class="form-control">
              <label class="label" for="airwayStatus">
                <span class="label-text font-medium">{$_('medicalReport.airway.status')}</span>
              </label>
              <select id="airwayStatus" bind:value={form.airwayStatus} class="select select-bordered">
                <option value="clear">{$_('medicalReport.airway.statusClear')}</option>
                <option value="atRisk">{$_('medicalReport.airway.statusAtRisk')}</option>
                <option value="obstructed">{$_('medicalReport.airway.statusObstructed')}</option>
                <option value="secured">{$_('medicalReport.airway.statusSecured')}</option>
              </select>
            </div>
            
            <div class="form-control">
              <label class="label" for="airwayDevice">
                <span class="label-text font-medium">{$_('medicalReport.airway.device')}</span>
              </label>
              <select id="airwayDevice" bind:value={form.airwayDevice} class="select select-bordered">
                <option value="">{$_('medicalReport.airway.deviceNone')}</option>
                <option value="guedel">{$_('medicalReport.airway.deviceGuedel')}</option>
                <option value="ett">{$_('medicalReport.airway.deviceETT')}</option>
              </select>
            </div>
            
            {#if form.airwayDevice}
              <div class="form-control">
                <label class="label" for="airwaySize">
                  <span class="label-text font-medium">{$_('medicalReport.airway.size')}</span>
                </label>
                <input id="airwaySize" type="text" bind:value={form.airwaySize} placeholder={$_('medicalReport.airway.sizePlaceholder')} class="input input-bordered" />
              </div>
            {/if}
            
            <div class="form-control md:col-span-2">
              <label class="label" for="airwayAction">
                <span class="label-text font-medium">{$_('medicalReport.airway.action')}</span>
              </label>
              <input id="airwayAction" type="text" bind:value={form.airwayAction} placeholder={$_('medicalReport.airway.actionPlaceholder')} class="input input-bordered" />
            </div>
          </div>
        </div>
      </div>

      <!-- B - BREATHING -->
      <div class="card bg-base-100 shadow-md border-l-4 border-success">
        <div class="card-body">
          <h2 class="card-title text-lg">{$_('medicalReport.breathing.title')}</h2>
          
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div class="form-control">
              <label class="label" for="respiratoryRate">
                <span class="label-text font-medium">{$_('medicalReport.breathing.respiratoryRate')}</span>
              </label>
              <input id="respiratoryRate" type="number" bind:value={form.respiratoryRate} class="input input-bordered" />
              <span class="text-xs opacity-70 mt-1">{getRRInterpretation(form.respiratoryRate)}</span>
            </div>
            
            <div class="form-control">
              <label class="label" for="spo2">
                <span class="label-text font-medium">{$_('medicalReport.breathing.spo2')}</span>
              </label>
              <input id="spo2" type="number" bind:value={form.spo2} class="input input-bordered" />
            </div>
          </div>
          
          <div class="form-control">
            <!-- svelte-ignore a11y-label-has-associated-control -->
            <label class="label">
              <span class="label-text font-medium">{$_('medicalReport.breathing.workOfBreathing')}</span>
            </label>
            <div class="flex flex-wrap gap-2">
              {#each wobKeys as key}
                <button 
                  type="button"
                  class="btn btn-sm" 
                  class:btn-primary={form.workOfBreathing.includes(key)}
                  class:btn-outline={!form.workOfBreathing.includes(key)}
                  on:click={() => form.workOfBreathing = toggleArrayItem(form.workOfBreathing, key)}
                >
                  {$_(`medicalReport.breathing.${key}`)}
                </button>
              {/each}
            </div>
          </div>
          
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div class="form-control">
              <label class="label" for="ampliation">
                <span class="label-text font-medium">{$_('medicalReport.breathing.expansion')}</span>
              </label>
              <select id="ampliation" bind:value={form.ampliation} class="select select-bordered">
                <option value="symmetric">{$_('medicalReport.breathing.expansionSymmetric')}</option>
                <option value="asymmetric">{$_('medicalReport.breathing.expansionAsymmetric')}</option>
              </select>
            </div>
            
            {#if form.isTrauma}
              <div class="form-control justify-end">
                <button
                  type="button"
                  class="flex items-center gap-3 px-4 py-2 rounded-lg border-2 transition-all duration-200 {form.traumaEmphysema 
                    ? 'border-warning bg-warning/10 text-warning-content' 
                    : 'border-base-300 bg-base-200 hover:border-base-content/30'}"
                  on:click={() => form.traumaEmphysema = !form.traumaEmphysema}
                >
                  <span class="text-lg">{form.traumaEmphysema ? '💨' : '🫁'}</span>
                  <span class="text-sm font-medium">{$_('medicalReport.breathing.traumaEmphysema')}</span>
                  <div class="w-10 h-5 rounded-full transition-colors duration-200 {form.traumaEmphysema ? 'bg-warning' : 'bg-base-300'} relative ml-auto">
                    <div class="absolute top-0.5 w-4 h-4 rounded-full bg-white shadow transition-all duration-200 {form.traumaEmphysema ? 'left-5' : 'left-0.5'}"></div>
                  </div>
                </button>
              </div>
            {/if}
          </div>
          
          {#if form.isTrauma}
            <div class="form-control">
              <label class="label" for="traumaRibs">
                <span class="label-text font-medium">{$_('medicalReport.breathing.ribCrepitus')}</span>
              </label>
              <input id="traumaRibs" type="text" bind:value={form.traumaRibs} placeholder={$_('medicalReport.breathing.ribCrepitusPlaceholder')} class="input input-bordered" />
            </div>
          {/if}
          
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div class="form-control">
              <label class="label" for="auscultation">
                <span class="label-text font-medium">{$_('medicalReport.breathing.auscultation')}</span>
              </label>
              <select id="auscultation" bind:value={form.auscultation} class="select select-bordered">
                <option value="clear">{$_('medicalReport.breathing.auscultationClear')}</option>
                <option value="abnormal">{$_('medicalReport.breathing.auscultationAbnormal')}</option>
              </select>
            </div>
            
            {#if form.auscultation === 'abnormal'}
              <div class="form-control">
                <label class="label" for="auscultationType">
                  <span class="label-text font-medium">{$_('medicalReport.breathing.auscultationType')}</span>
                </label>
                <input id="auscultationType" type="text" bind:value={form.auscultationType} placeholder={$_('medicalReport.breathing.auscultationTypePlaceholder')} class="input input-bordered" />
              </div>
            {/if}
          </div>
          
          <div class="divider my-2"></div>
          
          <div class="form-control">
            <!-- svelte-ignore a11y-label-has-associated-control -->
            <label class="label">
              <span class="label-text font-medium">{$_('medicalReport.breathing.action')}</span>
            </label>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-2">
              <select bind:value={form.oxygenDevice} class="select select-bordered">
                <option value="">{$_('medicalReport.breathing.oxygenNone')}</option>
                <option value="nasal">{$_('medicalReport.breathing.oxygenNasal')}</option>
                <option value="simpleMask">{$_('medicalReport.breathing.oxygenSimpleMask')}</option>
                <option value="nrb">{$_('medicalReport.breathing.oxygenNRB')}</option>
                <option value="niv">{$_('medicalReport.breathing.oxygenNIV')}</option>
              </select>
              {#if form.oxygenDevice}
                <input type="text" bind:value={form.oxygenFlow} placeholder={$_('medicalReport.breathing.oxygenFlow')} class="input input-bordered" />
              {/if}
            </div>
            <input type="text" bind:value={form.bAction} placeholder={$_('medicalReport.breathing.actionPlaceholder')} class="input input-bordered mt-2" />
          </div>
        </div>
      </div>

      <!-- C - CIRCULATION -->
      <div class="card bg-base-100 shadow-md border-l-4 border-error">
        <div class="card-body">
          <h2 class="card-title text-lg">{$_('medicalReport.circulation.title')}</h2>
          
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div class="form-control">
              <label class="label" for="extremities">
                <span class="label-text font-medium">{$_('medicalReport.circulation.extremities')}</span>
              </label>
              <select id="extremities" bind:value={form.extremities} class="select select-bordered">
                <option value="warm">{$_('medicalReport.circulation.extremitiesWarm')}</option>
                <option value="cold">{$_('medicalReport.circulation.extremitiesCold')}</option>
              </select>
            </div>
            
            <div class="form-control">
              <label class="label" for="pulse">
                <span class="label-text font-medium">{$_('medicalReport.circulation.pulse')}</span>
              </label>
              <input id="pulse" type="number" bind:value={form.pulse} class="input input-bordered" />
            </div>
          </div>
          
          <div class="form-control">
            <!-- svelte-ignore a11y-label-has-associated-control -->
            <label class="label">
              <span class="label-text font-medium">{$_('medicalReport.circulation.shockSigns')}</span>
            </label>
            <div class="flex flex-wrap gap-2">
              {#each chocKeys as key}
                <button 
                  type="button"
                  class="btn btn-sm"
                  class:btn-error={form.chocSigns.includes(key)}
                  class:btn-outline={!form.chocSigns.includes(key)}
                  on:click={() => form.chocSigns = toggleArrayItem(form.chocSigns, key)}
                >
                  {$_(`medicalReport.circulation.${key}`)}
                </button>
              {/each}
            </div>
          </div>
          
          <div class="form-control">
            <!-- svelte-ignore a11y-label-has-associated-control -->
            <label class="label">
              <span class="label-text font-medium">{$_('medicalReport.circulation.rightHeartSigns')}</span>
            </label>
            <div class="flex flex-wrap gap-2">
              {#each heartFailureKeys as key}
                <button 
                  type="button"
                  class="btn btn-sm"
                  class:btn-warning={form.heartFailureSigns.includes(key)}
                  class:btn-outline={!form.heartFailureSigns.includes(key)}
                  on:click={() => form.heartFailureSigns = toggleArrayItem(form.heartFailureSigns, key)}
                >
                  {$_(`medicalReport.circulation.${key}`)}
                </button>
              {/each}
            </div>
          </div>
          
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div class="form-control">
              <label class="label" for="bpRight">
                <span class="label-text font-medium">{$_('medicalReport.circulation.bpRight')}</span>
              </label>
              <input id="bpRight" type="text" bind:value={form.bpRight} placeholder={$_('medicalReport.circulation.bpPlaceholder')} class="input input-bordered" />
            </div>
            <div class="form-control">
              <label class="label" for="bpLeft">
                <span class="label-text font-medium">{$_('medicalReport.circulation.bpLeft')}</span>
              </label>
              <input id="bpLeft" type="text" bind:value={form.bpLeft} placeholder={$_('medicalReport.circulation.bpPlaceholder')} class="input input-bordered" />
            </div>
          </div>
          
          <!-- ECG Section -->
          <div class="bg-error/10 p-4 rounded-lg mt-2">
            <h3 class="font-semibold text-error mb-3">{$_('medicalReport.circulation.ecg.title')}</h3>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-2">
              <select bind:value={form.ecgRhythm} class="select select-bordered select-sm">
                <option value="sinus">{$_('medicalReport.circulation.ecg.rhythmSinus')}</option>
                <option value="irregular">{$_('medicalReport.circulation.ecg.rhythmIrregular')}</option>
                <option value="af">{$_('medicalReport.circulation.ecg.rhythmAF')}</option>
                <option value="flutter">{$_('medicalReport.circulation.ecg.rhythmFlutter')}</option>
              </select>
              {#if form.ecgRhythm === 'af' || form.ecgRhythm === 'flutter'}
                <input type="text" bind:value={form.ecgRate} placeholder={$_('medicalReport.circulation.ecg.ratePlaceholder')} class="input input-bordered input-sm" />
              {/if}
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-3 gap-2 mt-2">
              <select bind:value={form.ecgP} class="select select-bordered select-sm">
                <option value="normal">{$_('medicalReport.circulation.ecg.pNormal')}</option>
                <option value="ample">{$_('medicalReport.circulation.ecg.pAmple')}</option>
                <option value="biphasic">{$_('medicalReport.circulation.ecg.pBiphasic')}</option>
              </select>
              <select bind:value={form.ecgPR} class="select select-bordered select-sm">
                <option value="normal">{$_('medicalReport.circulation.ecg.prNormal')}</option>
                <option value="prolonged">{$_('medicalReport.circulation.ecg.prProlonged')}</option>
                <option value="short">{$_('medicalReport.circulation.ecg.prShort')}</option>
              </select>
              <select bind:value={form.ecgT} class="select select-bordered select-sm">
                <option value="normal">{$_('medicalReport.circulation.ecg.tNormal')}</option>
                <option value="ample">{$_('medicalReport.circulation.ecg.tAmple')}</option>
                <option value="flat">{$_('medicalReport.circulation.ecg.tFlat')}</option>
                <option value="inverted">{$_('medicalReport.circulation.ecg.tInverted')}</option>
              </select>
            </div>
            
            <div class="form-control mt-2">
              <select bind:value={form.ecgQRS} class="select select-bordered select-sm">
                <option value="narrow">{$_('medicalReport.circulation.ecg.qrsNarrow')}</option>
                <option value="wide">{$_('medicalReport.circulation.ecg.qrsWide')}</option>
              </select>
              {#if form.ecgQRS === 'wide'}
                <input type="text" bind:value={form.ecgQRSDetails} placeholder={$_('medicalReport.circulation.ecg.qrsDetails')} class="input input-bordered input-sm mt-2" />
                <label class="flex items-center gap-3 cursor-pointer mt-2">
                  <input type="checkbox" bind:checked={form.ecgScarbossa} class="toggle toggle-sm toggle-primary" />
                  <span class="text-sm">{$_('medicalReport.circulation.ecg.sgarbossa')}</span>
                </label>
              {/if}
            </div>
            
            <div class="form-control mt-2">
              <select bind:value={form.ecgST} class="select select-bordered select-sm">
                <option value="normal">{$_('medicalReport.circulation.ecg.stNormal')}</option>
                <option value="elevation">{$_('medicalReport.circulation.ecg.stElevation')}</option>
                <option value="depression">{$_('medicalReport.circulation.ecg.stDepression')}</option>
              </select>
              {#if form.ecgST !== 'normal'}
                <input type="text" bind:value={form.ecgSTTerritory} placeholder={$_('medicalReport.circulation.ecg.territory')} class="input input-bordered input-sm mt-2" />
              {/if}
            </div>
          </div>
        </div>
      </div>

      <!-- D - DISABILITY -->
      <div class="card bg-base-100 shadow-md border-l-4 border-warning">
        <div class="card-body">
          <h2 class="card-title text-lg">{$_('medicalReport.disability.title')}</h2>
          
          <div class="bg-warning/10 p-4 rounded-lg">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-3">
              <div class="form-control">
                <label class="label py-1" for="gcsE">
                  <span class="label-text font-medium">{$_('medicalReport.disability.gcsEyes')}</span>
                </label>
                <select id="gcsE" bind:value={form.gcsE} class="select select-bordered select-sm">
                  <option value={4}>{$_('medicalReport.disability.gcsEyes4')}</option>
                  <option value={3}>{$_('medicalReport.disability.gcsEyes3')}</option>
                  <option value={2}>{$_('medicalReport.disability.gcsEyes2')}</option>
                  <option value={1}>{$_('medicalReport.disability.gcsEyes1')}</option>
                </select>
              </div>
              <div class="form-control">
                <label class="label py-1" for="gcsV">
                  <span class="label-text font-medium">{$_('medicalReport.disability.gcsVerbal')}</span>
                </label>
                <select id="gcsV" bind:value={form.gcsV} class="select select-bordered select-sm">
                  <option value={5}>{$_('medicalReport.disability.gcsVerbal5')}</option>
                  <option value={4}>{$_('medicalReport.disability.gcsVerbal4')}</option>
                  <option value={3}>{$_('medicalReport.disability.gcsVerbal3')}</option>
                  <option value={2}>{$_('medicalReport.disability.gcsVerbal2')}</option>
                  <option value={1}>{$_('medicalReport.disability.gcsVerbal1')}</option>
                </select>
              </div>
              <div class="form-control">
                <label class="label py-1" for="gcsM">
                  <span class="label-text font-medium">{$_('medicalReport.disability.gcsMotor')}</span>
                </label>
                <select id="gcsM" bind:value={form.gcsM} class="select select-bordered select-sm">
                  <option value={6}>{$_('medicalReport.disability.gcsMotor6')}</option>
                  <option value={5}>{$_('medicalReport.disability.gcsMotor5')}</option>
                  <option value={4}>{$_('medicalReport.disability.gcsMotor4')}</option>
                  <option value={3}>{$_('medicalReport.disability.gcsMotor3')}</option>
                  <option value={2}>{$_('medicalReport.disability.gcsMotor2')}</option>
                  <option value={1}>{$_('medicalReport.disability.gcsMotor1')}</option>
                </select>
              </div>
            </div>
            <div class="text-center text-xl font-bold text-warning mt-3">{$_('medicalReport.disability.gcsTotal')} = {gcsTotal} / 15</div>
          </div>
          
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div class="form-control">
              <label class="label" for="pupils">
                <span class="label-text font-medium">{$_('medicalReport.disability.pupils')}</span>
              </label>
              <select id="pupils" bind:value={form.pupils} class="select select-bordered">
                <option value="perrl">{$_('medicalReport.disability.pupilsPERRL')}</option>
                <option value="abnormal">{$_('medicalReport.disability.pupilsAbnormal')}</option>
              </select>
            </div>
            {#if form.pupils === 'abnormal'}
              <div class="form-control">
                <label class="label" for="pupilsDetails">
                  <span class="label-text font-medium">{$_('medicalReport.disability.pupilsDetails')}</span>
                </label>
                <input id="pupilsDetails" type="text" bind:value={form.pupilsDetails} placeholder={$_('medicalReport.disability.pupilsDetailsPlaceholder')} class="input input-bordered" />
              </div>
            {/if}
          </div>
          
          <div class="form-control">
            <label class="label" for="neuroDeficit">
              <span class="label-text font-medium">{$_('medicalReport.disability.deficit')}</span>
            </label>
            <select id="neuroDeficit" bind:value={form.neuroDeficit} class="select select-bordered">
              <option value="none">{$_('medicalReport.disability.deficitNone')}</option>
              <option value="rightHemi">{$_('medicalReport.disability.deficitRightHemi')}</option>
              <option value="leftHemi">{$_('medicalReport.disability.deficitLeftHemi')}</option>
              <option value="para">{$_('medicalReport.disability.deficitPara')}</option>
              <option value="quad">{$_('medicalReport.disability.deficitQuad')}</option>
            </select>
            <label class="flex items-center gap-3 cursor-pointer mt-2">
              <input type="checkbox" bind:checked={form.aphasia} class="toggle toggle-primary" />
              <span>{$_('medicalReport.disability.aphasia')}</span>
            </label>
          </div>
          
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div class="form-control">
              <label class="label" for="gad">
                <span class="label-text font-medium">{$_('medicalReport.disability.glucose')}</span>
              </label>
              <input id="gad" type="number" step="0.01" bind:value={form.gad} class="input input-bordered" />
            </div>
            <div class="flex flex-col gap-2 justify-end">
              <label class="flex items-center gap-3 cursor-pointer">
                <input type="checkbox" bind:checked={form.meningealSigns} class="toggle toggle-primary" />
                <span>{$_('medicalReport.disability.meningealSigns')}</span>
              </label>
              <label class="flex items-center gap-3 cursor-pointer">
                <input type="checkbox" bind:checked={form.purpura} class="toggle toggle-primary" />
                <span>{$_('medicalReport.disability.purpura')}</span>
              </label>
            </div>
          </div>
        </div>
      </div>

      <!-- E - EXPOSURE -->
      <div class="card bg-base-100 shadow-md border-l-4 border-base-content/30">
        <div class="card-body">
          <h2 class="card-title text-lg">{$_('medicalReport.exposure.title')}</h2>
          
          <div class="form-control">
            <label class="label" for="terrainType">
              <span class="label-text font-medium">{$_('medicalReport.exposure.background')}</span>
            </label>
            <select id="terrainType" bind:value={form.terrainType} class="select select-bordered">
              <option value="none">{$_('medicalReport.exposure.backgroundNone')}</option>
              <option value="other">{$_('medicalReport.exposure.backgroundOther')}</option>
            </select>
            {#if form.terrainType === 'other'}
              <textarea bind:value={form.terrainDetails} rows="2" placeholder={$_('medicalReport.exposure.backgroundPlaceholder')} class="textarea textarea-bordered mt-2"></textarea>
            {/if}
          </div>
          
          <div class="flex flex-wrap items-center gap-4">
            <label class="flex items-center gap-3 cursor-pointer">
              <input type="checkbox" bind:checked={form.tabac} class="toggle toggle-primary" />
              <span>{$_('medicalReport.exposure.tobacco')}</span>
            </label>
            {#if form.tabac}
              <input type="text" bind:value={form.pa} placeholder={$_('medicalReport.exposure.tobaccoPY')} class="input input-bordered input-sm w-20" />
            {/if}
            
            <label class="flex items-center gap-3 cursor-pointer">
              <input type="checkbox" bind:checked={form.alcool} class="toggle toggle-primary" />
              <span>{$_('medicalReport.exposure.alcohol')}</span>
            </label>
          </div>
          
          <div class="form-control">
            <label class="label" for="hdm">
              <span class="label-text font-medium">{$_('medicalReport.exposure.historyOfIllness')}</span>
            </label>
            <textarea id="hdm" bind:value={form.hdm} rows="4" class="textarea textarea-bordered"></textarea>
          </div>
        </div>
      </div>
    </div>

    <!-- RIGHT COLUMN: PREVIEW -->
    <div class="lg:sticky lg:top-4 h-fit">
      <div class="card bg-base-100 shadow-lg max-h-[calc(100vh-2rem)] flex flex-col">
        <div class="card-body p-0">
          <div class="flex justify-between items-center p-4 bg-base-200 border-b border-base-300">
            <h2 class="font-semibold">{$_('medicalReport.preview')}</h2>
            <div class="flex gap-2">
              <button class="btn btn-sm btn-ghost" on:click={resetForm} title={$_('medicalReport.reset')}>
                🔄
              </button>
              <button class="btn btn-sm" class:btn-primary={!copied} class:btn-success={copied} on:click={copyToClipboard}>
                {copied ? $_('medicalReport.copied') : $_('medicalReport.copy')}
              </button>
            </div>
          </div>
          <div class="p-4 overflow-y-auto flex-1">
            <pre class="font-mono text-sm whitespace-pre-wrap break-words">{report}</pre>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<style>
  /* Minimal custom styles for specific needs */
  pre {
    line-height: 1.6;
  }
</style>
