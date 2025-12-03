// Dyscalcemia Protocol - Evidence-Based Treatment
// References:
// 1. Shane E et al. J Clin Endocrinol Metab 2017 - Hypercalcemia
// 2. Bilezikian JP et al. NEJM 2018 - Hypoparathyroidism
// 3. Minisola S et al. BMJ 2015 - Hypercalcemia
// 4. Brandi ML et al. J Clin Endocrinol Metab 2016 - Hypoparathyroidism Guidelines
// 5. Endocrine Society Clinical Practice Guidelines

import type { 
  DyscalcemiaParams, 
  DyscalcemiaResult, 
  CalciumTreatment,
  Reference
} from './types';

// Symptoms Database
export const HYPERCALCEMIA_SYMPTOMS = [
  { id: 'fatigue', name: 'Fatigue/Weakness', nameFr: 'Fatigue/Faiblesse', severity: 'mild' },
  { id: 'constipation', name: 'Constipation', nameFr: 'Constipation', severity: 'mild' },
  { id: 'nausea', name: 'Nausea/Vomiting', nameFr: 'Nausées/Vomissements', severity: 'moderate' },
  { id: 'polyuria', name: 'Polyuria/Polydipsia', nameFr: 'Polyurie/Polydipsie', severity: 'moderate' },
  { id: 'confusion', name: 'Confusion/Altered mental status', nameFr: 'Confusion/Altération conscience', severity: 'severe' },
  { id: 'arrhythmia', name: 'Cardiac arrhythmias', nameFr: 'Arythmies cardiaques', severity: 'severe' },
  { id: 'coma', name: 'Obtundation/Coma', nameFr: 'Obnubilation/Coma', severity: 'critical' },
  { id: 'short_qt', name: 'Short QT interval', nameFr: 'QT court', severity: 'moderate' }
];

export const HYPOCALCEMIA_SYMPTOMS = [
  { id: 'paresthesias', name: 'Perioral/Extremity paresthesias', nameFr: 'Paresthésies péribuccales/extrémités', severity: 'mild' },
  { id: 'muscle_cramps', name: 'Muscle cramps', nameFr: 'Crampes musculaires', severity: 'mild' },
  { id: 'chvostek', name: "Chvostek's sign", nameFr: 'Signe de Chvostek', severity: 'moderate' },
  { id: 'trousseau', name: "Trousseau's sign", nameFr: 'Signe de Trousseau', severity: 'moderate' },
  { id: 'carpopedal', name: 'Carpopedal spasm', nameFr: 'Spasme carpopédal', severity: 'moderate' },
  { id: 'tetany', name: 'Tetany', nameFr: 'Tétanie', severity: 'severe' },
  { id: 'seizures', name: 'Seizures', nameFr: 'Convulsions', severity: 'severe' },
  { id: 'laryngospasm', name: 'Laryngospasm', nameFr: 'Laryngospasme', severity: 'critical' },
  { id: 'long_qt', name: 'Prolonged QT interval', nameFr: 'QT allongé', severity: 'severe' },
  { id: 'heart_failure', name: 'Heart failure', nameFr: 'Insuffisance cardiaque', severity: 'severe' }
];

// Hypercalcemia Treatments
export const HYPERCALCEMIA_TREATMENTS: CalciumTreatment[] = [
  {
    id: 'iv_fluids',
    name: 'IV Normal Saline',
    nameFr: 'NaCl 0.9% IV',
    dose: '200-500 mL/h initially, then adjust to maintain UOP 100-150 mL/h',
    route: 'IV',
    indication: 'First-line for all significant hypercalcemia',
    notes: 'Volume expansion is the cornerstone. Corrects dehydration and enhances calciuresis. Target 3-6L/day if tolerated.',
    notesFr: 'L\'expansion volémique est la pierre angulaire. Corrige déshydratation et augmente calciurie. Cible 3-6L/jour si toléré.',
    contraindications: ['Severe heart failure', 'Severe renal failure'],
    urgency: 'immediate'
  },
  {
    id: 'furosemide',
    name: 'Furosemide',
    nameFr: 'Furosémide',
    dose: '20-40 mg IV as needed',
    route: 'IV',
    indication: 'Only after adequate volume repletion, if volume overload develops',
    notes: 'NOT first-line. Use only after euvolemia achieved or if signs of volume overload. Promotes calciuresis.',
    notesFr: 'PAS première intention. Utiliser seulement après euvolémie atteinte ou si surcharge. Favorise calciurie.',
    contraindications: ['Hypovolemia', 'Hypokalemia'],
    urgency: 'urgent'
  },
  {
    id: 'zoledronic_acid',
    name: 'Zoledronic Acid',
    nameFr: 'Acide Zolédronique',
    dose: '4 mg IV over 15-30 min',
    route: 'IV',
    indication: 'Malignancy-associated hypercalcemia, after rehydration',
    notes: 'Most potent bisphosphonate. Onset 24-48h, nadir 4-7 days. Reduce dose in renal impairment. Hydrate before.',
    notesFr: 'Bisphosphonate le plus puissant. Début 24-48h, nadir 4-7 jours. Réduire dose si IR. Hydrater avant.',
    contraindications: ['CrCl <30 mL/min', 'Acute renal failure'],
    urgency: 'urgent'
  },
  {
    id: 'pamidronate',
    name: 'Pamidronate',
    nameFr: 'Pamidronate',
    dose: '60-90 mg IV over 2-4 hours',
    route: 'IV',
    indication: 'Malignancy-associated hypercalcemia',
    notes: 'Alternative to zoledronic acid. Onset 24-48h. Can be used in moderate renal impairment.',
    notesFr: 'Alternative à l\'acide zolédronique. Début 24-48h. Peut être utilisé si IR modérée.',
    contraindications: ['Severe renal failure'],
    urgency: 'urgent'
  },
  {
    id: 'calcitonin',
    name: 'Calcitonin (Salmon)',
    nameFr: 'Calcitonine (Saumon)',
    dose: '4-8 IU/kg SC or IM q6-12h',
    route: 'IV',
    indication: 'Rapid but transient lowering, bridge until bisphosphonates work',
    notes: 'Fastest onset (2-4h). Tachyphylaxis in 24-72h. Use as bridge. Modest effect (1-2 mg/dL drop).',
    notesFr: 'Début le plus rapide (2-4h). Tachyphylaxie en 24-72h. Utiliser comme relais. Effet modeste (baisse 1-2 mg/dL).',
    contraindications: ['Salmon allergy'],
    urgency: 'immediate'
  },
  {
    id: 'denosumab',
    name: 'Denosumab',
    nameFr: 'Dénosumab',
    dose: '120 mg SC',
    route: 'IV',
    indication: 'Bisphosphonate-refractory hypercalcemia or renal failure',
    notes: 'RANKL inhibitor. Can use in renal failure. Risk of severe hypocalcemia - monitor closely.',
    notesFr: 'Inhibiteur RANKL. Utilisable si IR. Risque d\'hypocalcémie sévère - surveiller étroitement.',
    contraindications: ['Hypocalcemia'],
    urgency: 'urgent'
  },
  {
    id: 'glucocorticoids',
    name: 'Glucocorticoids',
    nameFr: 'Glucocorticoïdes',
    dose: 'Hydrocortisone 200-300 mg/day IV or Prednisone 20-40 mg/day PO',
    route: 'IV',
    indication: 'Vitamin D-mediated hypercalcemia: granulomatous diseases, lymphoma',
    notes: 'Effective for sarcoidosis, lymphoma, vitamin D intoxication. Onset 2-5 days.',
    notesFr: 'Efficace pour sarcoïdose, lymphome, intoxication vitamine D. Début 2-5 jours.',
    contraindications: ['Active infection (relative)'],
    urgency: 'urgent'
  },
  {
    id: 'dialysis',
    name: 'Hemodialysis',
    nameFr: 'Hémodialyse',
    dose: 'Low-calcium dialysate (1.0-1.25 mmol/L)',
    route: 'IV',
    indication: 'Severe hypercalcemia with renal failure or life-threatening symptoms',
    notes: 'Most rapid method. Reserve for: Ca >18 mg/dL, renal failure, refractory hypercalcemia, life-threatening symptoms.',
    notesFr: 'Méthode la plus rapide. Réserver pour: Ca >18 mg/dL, IR, hypercalcémie réfractaire, symptômes menaçant le pronostic vital.',
    contraindications: [],
    urgency: 'immediate'
  }
];

// Hypocalcemia Treatments
export const HYPOCALCEMIA_TREATMENTS: CalciumTreatment[] = [
  {
    id: 'calcium_gluconate_iv',
    name: 'Calcium Gluconate 10%',
    nameFr: 'Gluconate de Calcium 10%',
    dose: '1-2 g (10-20 mL) IV over 10-20 min, then 0.5-1.5 mg/kg/h infusion',
    route: 'IV',
    indication: 'Symptomatic hypocalcemia, severe hypocalcemia',
    notes: '10 mL = 1g = 93 mg elemental Ca. Prefer over CaCl (safer for peripheral IV). Mix in D5W or NS. Avoid bicarbonate.',
    notesFr: '10 mL = 1g = 93 mg Ca élémentaire. Préférer au CaCl (plus sûr en périphérique). Diluer dans G5% ou NaCl. Éviter bicarbonate.',
    contraindications: ['Hypercalcemia', 'Digoxin toxicity (give slowly)'],
    urgency: 'immediate'
  },
  {
    id: 'calcium_chloride_iv',
    name: 'Calcium Chloride 10%',
    nameFr: 'Chlorure de Calcium 10%',
    dose: '500-1000 mg (5-10 mL) IV over 5-10 min via central line',
    route: 'IV',
    indication: 'Severe symptomatic hypocalcemia, cardiac arrest',
    notes: '10 mL = 1g = 273 mg elemental Ca (3x gluconate). Central line preferred. Extravasation causes severe necrosis.',
    notesFr: '10 mL = 1g = 273 mg Ca élémentaire (3x gluconate). Voie centrale préférée. Extravasation cause nécrose sévère.',
    contraindications: ['Peripheral IV (relative)', 'Digoxin toxicity'],
    urgency: 'immediate'
  },
  {
    id: 'calcium_carbonate',
    name: 'Calcium Carbonate',
    nameFr: 'Carbonate de Calcium',
    dose: '1-2 g (400-800 mg elemental Ca) PO TID with meals',
    route: 'PO',
    indication: 'Chronic hypocalcemia, maintenance therapy',
    notes: '40% elemental calcium. Take with food for best absorption. May cause constipation, GI upset.',
    notesFr: '40% calcium élémentaire. Prendre avec nourriture pour meilleure absorption. Peut causer constipation, troubles GI.',
    contraindications: ['Hypercalcemia', 'Severe hypophosphatemia'],
    urgency: 'routine'
  },
  {
    id: 'calcium_citrate',
    name: 'Calcium Citrate',
    nameFr: 'Citrate de Calcium',
    dose: '1-2 g PO TID',
    route: 'PO',
    indication: 'Chronic hypocalcemia, patients on PPIs or achlorhydria',
    notes: '21% elemental calcium. Better absorbed on empty stomach. Preferred if on acid suppression.',
    notesFr: '21% calcium élémentaire. Mieux absorbé à jeun. Préféré si anti-acides.',
    contraindications: ['Hypercalcemia'],
    urgency: 'routine'
  },
  {
    id: 'calcitriol',
    name: 'Calcitriol (1,25-dihydroxyvitamin D)',
    nameFr: 'Calcitriol (1,25-dihydroxyvitamine D)',
    dose: '0.25-2 mcg PO daily',
    route: 'PO',
    indication: 'Hypoparathyroidism, renal failure, vitamin D-dependent rickets',
    notes: 'Active vitamin D - does not require renal hydroxylation. Fastest onset. Risk of hypercalcemia.',
    notesFr: 'Vitamine D active - ne nécessite pas hydroxylation rénale. Début le plus rapide. Risque d\'hypercalcémie.',
    contraindications: ['Hypercalcemia', 'Vitamin D toxicity'],
    urgency: 'urgent'
  },
  {
    id: 'ergocalciferol',
    name: 'Ergocalciferol (Vitamin D2)',
    nameFr: 'Ergocalciférol (Vitamine D2)',
    dose: '50,000 IU PO weekly x 8 weeks, then maintenance',
    route: 'PO',
    indication: 'Vitamin D deficiency',
    notes: 'Requires hepatic and renal hydroxylation. Onset weeks. Check 25-OH vitamin D levels.',
    notesFr: 'Nécessite hydroxylation hépatique et rénale. Début en semaines. Vérifier 25-OH vitamine D.',
    contraindications: ['Hypercalcemia', 'Severe renal failure (prefer calcitriol)'],
    urgency: 'routine'
  },
  {
    id: 'magnesium',
    name: 'Magnesium Sulfate',
    nameFr: 'Sulfate de Magnésium',
    dose: '2-4 g IV over 1-2 hours',
    route: 'IV',
    indication: 'Hypomagnesemia-induced hypocalcemia',
    notes: 'CRITICAL: Hypocalcemia is refractory if Mg2+ not corrected. Hypomagnesemia impairs PTH secretion.',
    notesFr: 'CRITIQUE: Hypocalcémie réfractaire si Mg2+ non corrigé. Hypomagnésémie altère sécrétion PTH.',
    contraindications: ['Severe renal failure', 'Heart block'],
    urgency: 'urgent'
  }
];

// References
export const DYSCALCEMIA_REFERENCES: Reference[] = [
  {
    id: 'shane2017',
    title: 'Hypercalcemia: Pathogenesis, Clinical Manifestations, Differential Diagnosis, and Management',
    source: 'J Clin Endocrinol Metab 2017',
    year: 2017
  },
  {
    id: 'bilezikian2018',
    title: 'Hypoparathyroidism in the Adult',
    source: 'N Engl J Med 2018;378:1677-1690',
    year: 2018
  },
  {
    id: 'minisola2015',
    title: 'Hypercalcemia',
    source: 'BMJ 2015;350:h2723',
    year: 2015
  },
  {
    id: 'brandi2016',
    title: 'Management of Hypoparathyroidism: Summary Statement and Guidelines',
    source: 'J Clin Endocrinol Metab 2016;101:2273-2283',
    year: 2016
  },
  {
    id: 'uptodate2024ca',
    title: 'Treatment of hypercalcemia',
    source: 'UpToDate 2024',
    year: 2024
  }
];

/**
 * Calculate corrected calcium for albumin
 * Formula: Corrected Ca = Total Ca + 0.8 × (4.0 - Albumin)
 * Reference: Payne RB et al. BMJ 1973
 */
export function calculateCorrectedCalcium(totalCa: number, albumin: number): number {
  // Assumes Ca in mg/dL and albumin in g/dL
  return totalCa + 0.8 * (4.0 - albumin);
}

/**
 * Convert calcium units
 * 1 mmol/L = 4 mg/dL (approximately)
 */
export function convertCalciumUnits(value: number, from: 'mg/dL' | 'mmol/L'): number {
  if (from === 'mg/dL') {
    return value / 4; // to mmol/L
  }
  return value * 4; // to mg/dL
}

/**
 * Classify hypercalcemia severity
 * Based on corrected calcium
 */
export function classifyHypercalcemiaSeverity(correctedCa: number): 'mild' | 'moderate' | 'severe' {
  if (correctedCa > 14) return 'severe';
  if (correctedCa > 12) return 'moderate';
  if (correctedCa > 10.5) return 'mild';
  return 'mild';
}

/**
 * Classify hypocalcemia severity
 */
export function classifyHypocalcemiaSeverity(
  correctedCa: number, 
  hasSymptoms: boolean, 
  symptoms: string[]
): 'mild' | 'moderate' | 'severe' {
  const hasSevereSymptoms = symptoms.some(s => 
    ['tetany', 'seizures', 'laryngospasm', 'long_qt', 'heart_failure'].includes(s)
  );
  
  if (correctedCa < 7.0 || hasSevereSymptoms) return 'severe';
  if (correctedCa < 8.0 || hasSymptoms) return 'moderate';
  if (correctedCa < 8.5) return 'mild';
  return 'mild';
}

/**
 * Get treatment recommendations for hypercalcemia
 */
export function getHypercalcemiaTreatments(params: DyscalcemiaParams): DyscalcemiaResult {
  const correctedCa = calculateCorrectedCalcium(params.totalCalcium, params.albumin);
  const severity = classifyHypercalcemiaSeverity(correctedCa);
  const treatments: CalciumTreatment[] = [];
  const warnings: string[] = [];
  
  // Always start with IV fluids
  treatments.push(HYPERCALCEMIA_TREATMENTS.find(t => t.id === 'iv_fluids')!);
  
  // Calcitonin for rapid effect in severe cases
  if (severity === 'severe' || params.hasSymptoms) {
    treatments.push(HYPERCALCEMIA_TREATMENTS.find(t => t.id === 'calcitonin')!);
    warnings.push('🕐 Calcitonine: effet rapide (2-4h) mais transitoire. Associer bisphosphonate.');
  }
  
  // Bisphosphonate for malignancy
  if (params.renalFunction !== 'dialysis') {
    treatments.push(HYPERCALCEMIA_TREATMENTS.find(t => t.id === 'zoledronic_acid')!);
  }
  
  // Dialysis for severe + renal failure
  if (params.renalFunction === 'dialysis' || (severity === 'severe' && params.renalFunction === 'impaired')) {
    treatments.push(HYPERCALCEMIA_TREATMENTS.find(t => t.id === 'dialysis')!);
    warnings.push('🔴 Hémodialyse urgente recommandée si symptômes sévères ou Ca > 18 mg/dL');
  }
  
  // Glucocorticoids if granulomatous disease suspected
  if (severity === 'severe') {
    warnings.push('💡 Considérer glucocorticoïdes si sarcoïdose, lymphome, ou intoxication vitamine D suspectée');
  }
  
  return {
    correctedCalcium: correctedCa,
    severity,
    treatments,
    warnings,
    targetRange: [8.5, 10.5]
  };
}

/**
 * Get treatment recommendations for hypocalcemia
 */
export function getHypocalcemiaTreatments(params: DyscalcemiaParams): DyscalcemiaResult {
  const correctedCa = calculateCorrectedCalcium(params.totalCalcium, params.albumin);
  const severity = classifyHypocalcemiaSeverity(correctedCa, params.hasSymptoms, params.symptoms);
  const treatments: CalciumTreatment[] = [];
  const warnings: string[] = [];
  
  // Magnesium check
  warnings.push('📋 Vérifier magnésémie - L\'hypocalcémie peut être réfractaire si hypomagnésémie');
  
  // Severe/symptomatic: IV calcium
  if (severity === 'severe' || params.hasSymptoms) {
    treatments.push(HYPOCALCEMIA_TREATMENTS.find(t => t.id === 'calcium_gluconate_iv')!);
    
    if (severity === 'severe') {
      warnings.push('🚨 Monitoring ECG continu pendant perfusion de calcium');
    }
  }
  
  // Magnesium replacement
  treatments.push(HYPOCALCEMIA_TREATMENTS.find(t => t.id === 'magnesium')!);
  
  // Calcitriol for hypoparathyroidism or renal failure
  if (params.renalFunction === 'impaired' || params.renalFunction === 'dialysis') {
    treatments.push(HYPOCALCEMIA_TREATMENTS.find(t => t.id === 'calcitriol')!);
    warnings.push('💡 Calcitriol préféré si insuffisance rénale (pas d\'hydroxylation rénale nécessaire)');
  }
  
  // Oral calcium for maintenance
  treatments.push(HYPOCALCEMIA_TREATMENTS.find(t => t.id === 'calcium_carbonate')!);
  
  // Vitamin D for deficiency
  treatments.push(HYPOCALCEMIA_TREATMENTS.find(t => t.id === 'ergocalciferol')!);
  
  return {
    correctedCalcium: correctedCa,
    severity,
    treatments,
    warnings,
    targetRange: [8.5, 10.5]
  };
}

/**
 * Calculate calcium infusion requirements
 * Rough estimate for acute IV replacement
 */
export function calculateCalciumInfusion(
  currentCa: number, 
  targetCa: number = 8.0,
  weight: number
): { bolusGluconateML: number; infusionRateMgH: number; note: string } {
  const deficit = targetCa - currentCa;
  
  if (deficit <= 0) {
    return {
      bolusGluconateML: 0,
      infusionRateMgH: 0,
      note: 'Pas de déficit calcique'
    };
  }
  
  // Bolus: typically 1-2g calcium gluconate for symptomatic hypocalcemia
  const bolusGluconateML = deficit < 1 ? 10 : 20; // 10-20 mL of 10% gluconate
  
  // Infusion: 0.5-1.5 mg elemental Ca/kg/h
  // 10% calcium gluconate: 93 mg elemental Ca per 10 mL
  const infusionRateMgH = Math.round(weight * 1); // 1 mg/kg/h as middle ground
  
  return {
    bolusGluconateML,
    infusionRateMgH,
    note: `Bolus: ${bolusGluconateML} mL gluconate Ca 10% sur 10-20 min, puis perfusion ${infusionRateMgH} mg Ca élémentaire/h`
  };
}
