// Dyskalemia Protocol - Evidence-Based Treatment
// References:
// 1. AHA Guidelines 2020 - Hyperkalemia Management
// 2. KDIGO Clinical Practice Guidelines
// 3. Palmer BF. NEJM 2021 - Potassium in Hypertension
// 4. Clase CM et al. Kidney Int 2020 - Potassium homeostasis
// 5. Mount DB. NEJM 2017 - Hyperkalemia
// 6. Crop MJ et al. Kidney Int 2007 - Hypokalemia

import type { 
  DyskalemiaParams, 
  DyskalemiaResult, 
  PotassiumTreatment,
  Reference
} from './types';

// ECG Changes Database
export const HYPERKALEMIA_ECG_FINDINGS = [
  { id: 'peaked_t', name: 'Peaked T waves', nameFr: 'Ondes T pointues', kLevel: 5.5 },
  { id: 'flat_p', name: 'Flattened P waves', nameFr: 'Ondes P aplaties', kLevel: 6.5 },
  { id: 'prolonged_pr', name: 'Prolonged PR', nameFr: 'PR allongé', kLevel: 6.5 },
  { id: 'wide_qrs', name: 'Widened QRS', nameFr: 'QRS élargi', kLevel: 7.0 },
  { id: 'sine_wave', name: 'Sine wave pattern', nameFr: 'Aspect sinusoïdal', kLevel: 8.0 },
  { id: 'vfib', name: 'VF/Cardiac arrest', nameFr: 'FV/Arrêt cardiaque', kLevel: 8.5 }
];

export const HYPOKALEMIA_ECG_FINDINGS = [
  { id: 'flat_t', name: 'Flattened T waves', nameFr: 'Ondes T aplaties', kLevel: 3.0 },
  { id: 'st_dep', name: 'ST depression', nameFr: 'Sous-décalage ST', kLevel: 2.8 },
  { id: 'u_wave', name: 'Prominent U waves', nameFr: 'Ondes U proéminentes', kLevel: 2.5 },
  { id: 'prolonged_qt', name: 'Prolonged QT/QU', nameFr: 'QT/QU allongé', kLevel: 2.5 },
  { id: 'pvc', name: 'PVCs/Arrhythmias', nameFr: 'ESV/Arythmies', kLevel: 2.0 }
];

// Hyperkalemia Treatments
export const HYPERKALEMIA_TREATMENTS: PotassiumTreatment[] = [
  {
    id: 'calcium_gluconate',
    name: 'Calcium Gluconate 10%',
    nameFr: 'Gluconate de Calcium 10%',
    dose: '10-20 mL (1-2g) IV over 2-3 min',
    route: 'IV',
    onset: '1-3 min',
    duration: '30-60 min',
    mechanism: 'cardioprotection',
    notes: 'First-line for ECG changes. Stabilizes cardiac membrane. Does NOT lower K+. Can repeat if ECG changes persist.',
    notesFr: 'Première intention si anomalies ECG. Stabilise la membrane cardiaque. NE DIMINUE PAS le K+. Répéter si anomalies ECG persistent.',
    contraindications: ['Digoxin toxicity (relative - give slowly over 20-30 min)'],
    urgency: 'immediate'
  },
  {
    id: 'calcium_chloride',
    name: 'Calcium Chloride 10%',
    nameFr: 'Chlorure de Calcium 10%',
    dose: '5-10 mL (500-1000 mg) IV over 2-3 min via central line',
    route: 'IV',
    onset: '1-3 min',
    duration: '30-60 min',
    mechanism: 'cardioprotection',
    notes: '3x more elemental calcium than gluconate. Prefer for cardiac arrest. Central line preferred (tissue necrosis risk).',
    notesFr: '3x plus de calcium élémentaire que gluconate. Préférer en arrêt cardiaque. Voie centrale préférée (risque nécrose tissulaire).',
    contraindications: ['Peripheral IV (relative)', 'Digoxin toxicity'],
    urgency: 'immediate'
  },
  {
    id: 'insulin_glucose',
    name: 'Regular Insulin + Dextrose',
    nameFr: 'Insuline Rapide + Glucose',
    dose: '10 units Regular Insulin IV + 25g Dextrose (50mL D50 or 250mL D10)',
    route: 'IV',
    onset: '15-30 min',
    duration: '4-6 hours',
    mechanism: 'shift',
    notes: 'Most effective shift therapy. Expect 0.5-1.2 mEq/L drop. Monitor glucose q1h x 4h (hypoglycemia common, up to 75%).',
    notesFr: 'Traitement de shift le plus efficace. Attendre baisse de 0.5-1.2 mEq/L. Surveiller glycémie /1h x 4h (hypoglycémie fréquente, jusqu\'à 75%).',
    contraindications: [],
    urgency: 'urgent'
  },
  {
    id: 'salbutamol_neb',
    name: 'Salbutamol (Albuterol) Nebulized',
    nameFr: 'Salbutamol Nébulisé',
    dose: '10-20 mg nebulized over 10-15 min',
    route: 'Nebulized',
    onset: '15-30 min',
    duration: '2-4 hours',
    mechanism: 'shift',
    notes: 'Additive effect with insulin. Expect 0.5-1.0 mEq/L drop. Higher doses needed than for bronchospasm. May cause tachycardia.',
    notesFr: 'Effet additif avec insuline. Attendre baisse de 0.5-1.0 mEq/L. Doses plus élevées que pour bronchospasme. Peut causer tachycardie.',
    contraindications: ['Severe CAD', 'Tachyarrhythmias'],
    urgency: 'urgent'
  },
  {
    id: 'sodium_bicarb',
    name: 'Sodium Bicarbonate',
    nameFr: 'Bicarbonate de Sodium',
    dose: '50-100 mEq IV over 5-10 min (if acidotic)',
    route: 'IV',
    onset: '15-30 min',
    duration: 'Variable',
    mechanism: 'shift',
    notes: 'Only effective if metabolic acidosis present. Limited efficacy in ESRD. Avoid if volume overloaded.',
    notesFr: 'Efficace uniquement si acidose métabolique présente. Efficacité limitée en IRT. Éviter si surcharge volémique.',
    contraindications: ['Volume overload', 'Severe hypocalcemia'],
    urgency: 'urgent'
  },
  {
    id: 'kayexalate',
    name: 'Sodium Polystyrene Sulfonate (SPS)',
    nameFr: 'Polystyrène Sulfonate de Sodium (Kayexalate)',
    dose: '15-30g PO with sorbitol, or 30-50g PR',
    route: 'PO',
    onset: '1-2 hours (PO), 30-60 min (PR)',
    duration: 'Hours',
    mechanism: 'elimination',
    notes: 'Exchanges Na+ for K+ in colon. Variable efficacy. Avoid sorbitol in post-op patients (intestinal necrosis reports).',
    notesFr: 'Échange Na+ contre K+ dans le côlon. Efficacité variable. Éviter sorbitol en post-op (cas de nécrose intestinale).',
    contraindications: ['Bowel obstruction', 'Post-operative ileus', 'Oral intake impossible (for PO)'],
    urgency: 'routine'
  },
  {
    id: 'patiromer',
    name: 'Patiromer (Veltassa)',
    nameFr: 'Patiromer (Veltassa)',
    dose: '8.4-25.2g PO daily',
    route: 'PO',
    onset: '7 hours (onset of action)',
    duration: 'Days',
    mechanism: 'elimination',
    notes: 'Non-sodium binder. Better tolerated than SPS. For chronic management. Separate from other meds by 3h.',
    notesFr: 'Chélateur sans sodium. Mieux toléré que SPS. Pour gestion chronique. Séparer des autres médicaments de 3h.',
    contraindications: ['Severe constipation', 'Bowel obstruction'],
    urgency: 'routine'
  },
  {
    id: 'zs9',
    name: 'Sodium Zirconium Cyclosilicate (Lokelma)',
    nameFr: 'Cyclosilicate de Zirconium Sodique (Lokelma)',
    dose: '10g TID x 48h, then 5-10g daily',
    route: 'PO',
    onset: '1-6 hours',
    duration: 'Days',
    mechanism: 'elimination',
    notes: 'Fastest onset of K+ binders. Can be used acutely. GI side effects minimal.',
    notesFr: 'Début d\'action le plus rapide des chélateurs de K+. Peut être utilisé en aigu. Effets secondaires GI minimes.',
    contraindications: ['Severe constipation'],
    urgency: 'routine'
  },
  {
    id: 'furosemide',
    name: 'Furosemide (Loop Diuretic)',
    nameFr: 'Furosémide (Diurétique de l\'anse)',
    dose: '40-80mg IV, adjust to response',
    route: 'IV',
    onset: '15-30 min',
    duration: '6 hours',
    mechanism: 'elimination',
    notes: 'Enhances renal K+ excretion. Requires adequate renal function. Monitor volume status.',
    notesFr: 'Augmente l\'excrétion rénale de K+. Nécessite fonction rénale adéquate. Surveiller volémie.',
    contraindications: ['Anuria', 'Severe volume depletion'],
    urgency: 'urgent'
  },
  {
    id: 'dialysis',
    name: 'Hemodialysis',
    nameFr: 'Hémodialyse',
    dose: 'Emergent HD with low K+ bath (0-2 mEq/L)',
    route: 'IV',
    onset: 'Immediate',
    duration: 'During session',
    mechanism: 'elimination',
    notes: 'Most effective K+ removal. Removes 25-50 mEq/h. Consider for: K+ >6.5 + ECG changes, refractory hyperkalemia, ESRD.',
    notesFr: 'Élimination de K+ la plus efficace. Élimine 25-50 mEq/h. Considérer si: K+ >6.5 + anomalies ECG, hyperkaliémie réfractaire, IRT.',
    contraindications: ['Hemodynamic instability (relative)'],
    urgency: 'immediate'
  }
];

// Hypokalemia Treatments
export const HYPOKALEMIA_TREATMENTS: PotassiumTreatment[] = [
  {
    id: 'kcl_iv_peripheral',
    name: 'KCl IV (Peripheral)',
    nameFr: 'KCl IV (Périphérique)',
    dose: '10-20 mEq in 100-250 mL NS over 1-2 hours',
    route: 'IV',
    onset: 'Immediate',
    duration: 'Variable',
    mechanism: 'replacement',
    notes: 'Max concentration: 40 mEq/L peripheral. Max rate: 10 mEq/h peripheral. Use infusion pump. Monitor for phlebitis.',
    notesFr: 'Concentration max: 40 mEq/L périphérique. Débit max: 10 mEq/h périphérique. Utiliser pompe. Surveiller phlébite.',
    contraindications: ['Renal failure', 'Hyperkalemia', 'Severe tissue damage at site'],
    urgency: 'urgent'
  },
  {
    id: 'kcl_iv_central',
    name: 'KCl IV (Central Line)',
    nameFr: 'KCl IV (Voie Centrale)',
    dose: '10-40 mEq in 100 mL NS over 1 hour',
    route: 'IV',
    onset: 'Immediate',
    duration: 'Variable',
    mechanism: 'replacement',
    notes: 'Max rate: 20 mEq/h via central line with cardiac monitoring. Can use higher concentrations (up to 200 mEq/L).',
    notesFr: 'Débit max: 20 mEq/h par voie centrale avec monitoring cardiaque. Concentrations plus élevées possibles (jusqu\'à 200 mEq/L).',
    contraindications: ['Renal failure', 'Hyperkalemia'],
    urgency: 'urgent'
  },
  {
    id: 'kcl_oral',
    name: 'KCl Oral',
    nameFr: 'KCl Oral',
    dose: '40-100 mEq/day in divided doses',
    route: 'PO',
    onset: '1-2 hours',
    duration: 'Variable',
    mechanism: 'replacement',
    notes: 'Preferred for mild-moderate hypokalemia. Take with food. Extended-release formulations reduce GI irritation.',
    notesFr: 'Préféré pour hypokaliémie légère-modérée. Prendre avec nourriture. Formules à libération prolongée réduisent irritation GI.',
    contraindications: ['GI obstruction', 'Severe nausea/vomiting', 'NPO status'],
    urgency: 'routine'
  },
  {
    id: 'magnesium',
    name: 'Magnesium Sulfate',
    nameFr: 'Sulfate de Magnésium',
    dose: '2-4g IV over 1-2 hours, then 1-2g/h if needed',
    route: 'IV',
    onset: 'Minutes',
    duration: 'Variable',
    mechanism: 'replacement',
    notes: 'ESSENTIAL: Correct hypomagnesemia for refractory hypokalemia. K+ repletion fails if Mg2+ low. Check Mg2+ level.',
    notesFr: 'ESSENTIEL: Corriger hypomagnésémie pour hypokaliémie réfractaire. Repletion K+ échoue si Mg2+ bas. Vérifier niveau Mg2+.',
    contraindications: ['Severe renal failure', 'Heart block'],
    urgency: 'urgent'
  },
  {
    id: 'spironolactone',
    name: 'Spironolactone (K+ sparing)',
    nameFr: 'Spironolactone (Épargneur K+)',
    dose: '25-100mg PO daily',
    route: 'PO',
    onset: 'Days',
    duration: 'Chronic',
    mechanism: 'elimination',
    notes: 'For chronic hypokalemia from hyperaldosteronism or diuretic use. Monitor K+ closely when initiating.',
    notesFr: 'Pour hypokaliémie chronique par hyperaldostéronisme ou diurétiques. Surveiller K+ étroitement à l\'initiation.',
    contraindications: ['Hyperkalemia', 'Severe renal failure', 'Addison disease'],
    urgency: 'routine'
  }
];

// References
export const DYSKALEMIA_REFERENCES: Reference[] = [
  {
    id: 'mount2017',
    title: 'Clinical Manifestations and Treatment of Hyperkalemia',
    source: 'N Engl J Med 2017;377:1623-1632',
    year: 2017,
    url: 'https://doi.org/10.1056/NEJMc1714197'
  },
  {
    id: 'palmer2021',
    title: 'Potassium in Hypertension',
    source: 'N Engl J Med 2021;385:1130-1142',
    year: 2021
  },
  {
    id: 'kdigo2020',
    title: 'KDIGO Clinical Practice Guidelines for Potassium',
    source: 'Kidney Int 2020',
    year: 2020
  },
  {
    id: 'aha2020',
    title: 'AHA ACLS Guidelines - Hyperkalemia',
    source: 'Circulation 2020',
    year: 2020
  },
  {
    id: 'uptodate2024k',
    title: 'Treatment of hyperkalemia in adults',
    source: 'UpToDate 2024',
    year: 2024
  }
];

/**
 * Classify hyperkalemia severity
 * Based on AHA/KDIGO guidelines
 */
export function classifyHyperkalemiaSeverity(k: number, hasECGChanges: boolean): 'normal' | 'mild' | 'moderate' | 'severe' | 'critical' {
  if (k >= 7.0 || hasECGChanges) return 'critical';
  if (k >= 6.5) return 'severe';
  if (k >= 6.0) return 'moderate';
  if (k >= 5.5) return 'mild';
  return 'normal'; // K < 5.5 is normal range
}

/**
 * Classify hypokalemia severity
 */
export function classifyHypokalemiaSeverity(k: number, hasECGChanges: boolean, hasSymptoms: boolean): 'mild' | 'moderate' | 'severe' | 'critical' {
  if (k < 2.5 || hasECGChanges) return 'critical';
  if (k < 3.0 || hasSymptoms) return 'severe';
  if (k < 3.5) return 'moderate';
  return 'mild';
}

/**
 * Get recommended treatments for hyperkalemia
 */
export function getHyperkalemiaTreatments(params: DyskalemiaParams): DyskalemiaResult {
  const severity = classifyHyperkalemiaSeverity(params.potassium, params.hasECGChanges);
  const treatments: PotassiumTreatment[] = [];
  const warnings: string[] = [];
  
  // Critical/Severe: Start with calcium for cardioprotection
  if (params.hasECGChanges || severity === 'critical' || severity === 'severe') {
    if (params.isOnDigoxin) {
      warnings.push('⚠️ Patient on Digoxin: Give calcium slowly over 20-30 min, diluted in D5W');
    }
    treatments.push(HYPERKALEMIA_TREATMENTS.find(t => t.id === 'calcium_gluconate')!);
  }
  
  // Add shift therapies
  treatments.push(HYPERKALEMIA_TREATMENTS.find(t => t.id === 'insulin_glucose')!);
  
  if (severity !== 'mild') {
    treatments.push(HYPERKALEMIA_TREATMENTS.find(t => t.id === 'salbutamol_neb')!);
  }
  
  // Add elimination therapies
  if (params.renalFunction === 'dialysis') {
    treatments.push(HYPERKALEMIA_TREATMENTS.find(t => t.id === 'dialysis')!);
  } else if (params.renalFunction === 'normal') {
    treatments.push(HYPERKALEMIA_TREATMENTS.find(t => t.id === 'furosemide')!);
  }
  
  // K+ binders for maintenance
  if (severity !== 'critical') {
    treatments.push(HYPERKALEMIA_TREATMENTS.find(t => t.id === 'zs9')!);
  }
  
  // Monitoring
  const monitoringInterval = severity === 'critical' ? 'q1h' : severity === 'severe' ? 'q2h' : 'q4-6h';
  
  return {
    severity,
    treatments,
    monitoringInterval,
    targetRange: [3.5, 5.0],
    warnings
  };
}

/**
 * Get recommended treatments for hypokalemia
 */
export function getHypokalemiaTreatments(params: DyskalemiaParams): DyskalemiaResult {
  const severity = classifyHypokalemiaSeverity(params.potassium, params.hasECGChanges, params.hasMuscleWeakness);
  const treatments: PotassiumTreatment[] = [];
  const warnings: string[] = [];
  
  // Always check/correct magnesium
  warnings.push('📋 Vérifier magnésémie - L\'hypokaliémie réfractaire est souvent due à l\'hypomagnésémie');
  
  if (params.magnesium && params.magnesium < 1.8) {
    treatments.push(HYPOKALEMIA_TREATMENTS.find(t => t.id === 'magnesium')!);
  }
  
  // IV replacement for severe/critical
  if (severity === 'critical' || severity === 'severe') {
    if (params.potassium < 2.5) {
      treatments.push(HYPOKALEMIA_TREATMENTS.find(t => t.id === 'kcl_iv_central')!);
      warnings.push('🚨 K+ < 2.5 mEq/L: Voie centrale recommandée pour repletion rapide avec monitoring cardiaque');
    } else {
      treatments.push(HYPOKALEMIA_TREATMENTS.find(t => t.id === 'kcl_iv_peripheral')!);
    }
  }
  
  // Oral for mild/moderate
  if (severity === 'mild' || severity === 'moderate') {
    treatments.push(HYPOKALEMIA_TREATMENTS.find(t => t.id === 'kcl_oral')!);
  }
  
  // K+ sparing diuretic for chronic
  if (params.renalFunction === 'normal') {
    treatments.push(HYPOKALEMIA_TREATMENTS.find(t => t.id === 'spironolactone')!);
  }
  
  // Digoxin warning
  if (params.isOnDigoxin) {
    warnings.push('⚠️ Patient sous Digoxine: L\'hypokaliémie augmente la toxicité digitalique - Correction urgente');
  }
  
  const monitoringInterval = severity === 'critical' ? 'q1-2h' : severity === 'severe' ? 'q2-4h' : 'q6-12h';
  
  return {
    severity,
    treatments,
    monitoringInterval,
    targetRange: [3.5, 5.0],
    warnings
  };
}

/**
 * Calculate K+ deficit (rough estimate)
 * Rule of thumb: 1 mEq/L drop in serum K+ ≈ 100-200 mEq total body deficit
 */
export function estimatePotassiumDeficit(currentK: number, targetK: number = 4.0): { deficit: number; note: string } {
  const delta = targetK - currentK;
  
  if (delta <= 0) {
    return { deficit: 0, note: 'Pas de déficit' };
  }
  
  // Rough estimation: first 3-3.5 mEq/L represents larger deficit
  let deficit = 0;
  
  if (currentK < 3.0) {
    deficit = 200 + (3.0 - currentK) * 200 + (targetK - 3.0) * 100;
  } else {
    deficit = delta * 100;
  }
  
  return {
    deficit: Math.round(deficit),
    note: `Estimation grossière: ${Math.round(deficit)} mEq. Le déficit réel peut être plus important.`
  };
}

/**
 * Get potassium replacement rate recommendation
 */
export function getReplacementRateRecommendation(severity: 'mild' | 'moderate' | 'severe' | 'critical', route: 'peripheral' | 'central'): string {
  if (severity === 'critical' || severity === 'severe') {
    if (route === 'central') {
      return '10-20 mEq/h via voie centrale avec monitoring ECG continu';
    }
    return '10 mEq/h max via voie périphérique (concentration max 40 mEq/L)';
  }
  return '10 mEq/h max via voie périphérique ou 40-80 mEq/jour PO en doses fractionnées';
}
