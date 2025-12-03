// Vasoactive Drugs Database for PSE (Pousse-Seringue Électrique)

import type { VasoactiveDrug } from './types';

export const noradrenaline: VasoactiveDrug = {
  id: 'noradrenaline',
  name: 'Noradrénaline',
  genericName: 'Norepinephrine',
  category: 'vasopressor',
  description: 'Vasopresseur de première ligne pour le choc septique et distributif',
  concentrations: [
    { label: '0.5 mg/mL (8mg/16mL)', mgPerMl: 0.5, commonPrep: '8 mg dans 16 mL (seringue 20 mL)' },
    { label: '1 mg/mL (8mg/8mL)', mgPerMl: 1, commonPrep: '8 mg dans 8 mL NaCl (seringue 10 mL)' },
    { label: '0.25 mg/mL (8mg/32mL)', mgPerMl: 0.25, commonPrep: '8 mg dans 32 mL (seringue 50 mL)' },
    { label: '0.16 mg/mL (8mg/50mL)', mgPerMl: 0.16, commonPrep: '8 mg dans 50 mL (seringue 50 mL)' }
  ],
  defaultConcentrationIndex: 0,
  doseUnit: 'mcg/kg/min',
  doseRange: { min: 0.05, max: 3, typical: 0.2, step: 0.05 },
  indications: [
    'Choc septique (1ère ligne)',
    'Choc distributif',
    'Hypotension réfractaire au remplissage',
    'Choc cardiogénique (en association)'
  ],
  effects: {
    alpha: 'high',
    beta1: 'moderate',
    beta2: 'none',
    dopaminergic: 'none',
    vasopressin: 'none'
  },
  sideEffects: [
    'Vasoconstriction périphérique (ischémie digitale)',
    'Arythmies',
    'Hypertension',
    'Nécrose tissulaire si extravasation',
    'Bradycardie réflexe'
  ],
  contraindications: [
    'Hypovolémie non corrigée (relative)',
    'Thrombose vasculaire périphérique'
  ],
  notes: [
    'Voie veineuse centrale préférée',
    'Titrer pour PAM ≥ 65 mmHg',
    'Associer à la dobutamine si dysfonction cardiaque'
  ]
};

export const adrenaline: VasoactiveDrug = {
  id: 'adrenaline',
  name: 'Adrénaline',
  genericName: 'Epinephrine',
  category: 'mixed',
  description: 'Catécholamine mixte - inotrope et vasopresseur',
  concentrations: [
    { label: '0.1 mg/mL (1mg/10mL)', mgPerMl: 0.1, commonPrep: '1 mg dans 10 mL NaCl' },
    { label: '0.2 mg/mL (5mg/25mL)', mgPerMl: 0.2, commonPrep: '5 mg dans 25 mL (seringue 50 mL)' },
    { label: '0.5 mg/mL (5mg/10mL)', mgPerMl: 0.5, commonPrep: '5 mg dans 10 mL' },
    { label: '1 mg/mL (pur)', mgPerMl: 1, commonPrep: 'Non dilué (urgence)' }
  ],
  defaultConcentrationIndex: 1,
  doseUnit: 'mcg/kg/min',
  doseRange: { min: 0.01, max: 2, typical: 0.1, step: 0.01 },
  indications: [
    'Choc anaphylactique',
    'Arrêt cardiaque',
    'Choc cardiogénique',
    'Bronchospasme sévère',
    'Choc septique réfractaire'
  ],
  effects: {
    alpha: 'high',
    beta1: 'high',
    beta2: 'moderate',
    dopaminergic: 'none',
    vasopressin: 'none'
  },
  sideEffects: [
    'Tachycardie',
    'Arythmies ventriculaires',
    'Hypertension',
    'Hyperglycémie',
    'Hypokaliémie',
    'Acidose lactique',
    'Ischémie myocardique'
  ],
  contraindications: [
    'Arythmie ventriculaire non contrôlée (relative)',
    'Phéochromocytome'
  ],
  notes: [
    'Faibles doses (< 0.1): effet β prédominant (inotrope)',
    'Hautes doses (> 0.1): effet α prédominant (vasopresseur)',
    'Arrêt cardiaque: 1 mg IVD toutes les 3-5 min'
  ]
};

export const dobutamine: VasoactiveDrug = {
  id: 'dobutamine',
  name: 'Dobutamine',
  genericName: 'Dobutamine',
  category: 'inotrope',
  description: 'Inotrope pur - augmente le débit cardiaque sans vasoconstriction',
  concentrations: [
    { label: '5 mg/mL (250mg/50mL)', mgPerMl: 5, commonPrep: '250 mg dans 50 mL G5%' },
    { label: '2.5 mg/mL (250mg/100mL)', mgPerMl: 2.5, commonPrep: '250 mg dans 100 mL G5%' },
    { label: '10 mg/mL (500mg/50mL)', mgPerMl: 10, commonPrep: '500 mg dans 50 mL G5%' }
  ],
  defaultConcentrationIndex: 0,
  doseUnit: 'mcg/kg/min',
  doseRange: { min: 2.5, max: 20, typical: 5, step: 0.5 },
  indications: [
    'Choc cardiogénique',
    'Insuffisance cardiaque aiguë décompensée',
    'Bas débit cardiaque post-chirurgie',
    'Stress test pharmacologique'
  ],
  effects: {
    alpha: 'low',
    beta1: 'high',
    beta2: 'moderate',
    dopaminergic: 'none',
    vasopressin: 'none'
  },
  sideEffects: [
    'Tachycardie',
    'Arythmies',
    'Hypotension (vasodilatation β2)',
    'Céphalées',
    'Angor',
    'Hypokaliémie'
  ],
  contraindications: [
    'Cardiomyopathie obstructive',
    'Sténose aortique serrée',
    'Tamponnade',
    'Fibrillation auriculaire rapide'
  ],
  notes: [
    'Ne pas utiliser seule en cas d\'hypotension',
    'Associer à la noradrénaline si PAM basse',
    'Tachyphylaxie après 72h d\'utilisation continue'
  ]
};

export const dopamine: VasoactiveDrug = {
  id: 'dopamine',
  name: 'Dopamine',
  genericName: 'Dopamine',
  category: 'mixed',
  description: 'Effets dose-dépendants: dopaminergique, β puis α',
  concentrations: [
    { label: '5 mg/mL (200mg/40mL)', mgPerMl: 5, commonPrep: '200 mg dans 40 mL G5%' },
    { label: '4 mg/mL (200mg/50mL)', mgPerMl: 4, commonPrep: '200 mg dans 50 mL G5%' },
    { label: '8 mg/mL (400mg/50mL)', mgPerMl: 8, commonPrep: '400 mg dans 50 mL G5%' }
  ],
  defaultConcentrationIndex: 0,
  doseUnit: 'mcg/kg/min',
  doseRange: { min: 1, max: 20, typical: 5, step: 0.5 },
  indications: [
    'Bradycardie symptomatique',
    'Choc cardiogénique (2ème ligne)',
    'Bas débit rénal (controversé)'
  ],
  effects: {
    alpha: 'moderate',
    beta1: 'moderate',
    beta2: 'low',
    dopaminergic: 'moderate',
    vasopressin: 'none'
  },
  sideEffects: [
    'Tachycardie',
    'Arythmies',
    'Nausées, vomissements',
    'Ischémie périphérique',
    'Nécrose tissulaire'
  ],
  contraindications: [
    'Phéochromocytome',
    'Tachyarythmie non contrôlée',
    'Fibrillation ventriculaire'
  ],
  notes: [
    '1-3 mcg/kg/min: effet dopaminergique (rénal)',
    '3-10 mcg/kg/min: effet β1 (inotrope)',
    '> 10 mcg/kg/min: effet α (vasopresseur)',
    'Moins utilisée que noradrénaline pour le choc'
  ]
};

export const vasopressine: VasoactiveDrug = {
  id: 'vasopressine',
  name: 'Vasopressine',
  genericName: 'Arginine Vasopressin',
  category: 'vasopressor',
  description: 'Vasopresseur non-catécholaminergique',
  concentrations: [
    { label: '0.4 UI/mL (20UI/50mL)', mgPerMl: 0.4, commonPrep: '20 UI dans 50 mL NaCl' },
    { label: '1 UI/mL (20UI/20mL)', mgPerMl: 1, commonPrep: '20 UI dans 20 mL NaCl' }
  ],
  defaultConcentrationIndex: 0,
  doseUnit: 'UI/min',
  doseRange: { min: 0.01, max: 0.04, typical: 0.03, step: 0.005 },
  indications: [
    'Choc septique réfractaire aux catécholamines',
    'Choc vasoplégique',
    'Diabète insipide central',
    'Hémorragie digestive (varices)'
  ],
  effects: {
    alpha: 'none',
    beta1: 'none',
    beta2: 'none',
    dopaminergic: 'none',
    vasopressin: 'high'
  },
  sideEffects: [
    'Ischémie digitale',
    'Ischémie mésentérique',
    'Hyponatrémie',
    'Bradycardie',
    'Vasoconstriction coronaire'
  ],
  contraindications: [
    'Insuffisance coronaire sévère',
    'Artériopathie périphérique sévère'
  ],
  notes: [
    'Dose fixe habituelle: 0.03 UI/min',
    'Ne pas titrer comme les catécholamines',
    'Épargne catécholaminergique',
    'Utile si tachyarythmie sous catécholamines'
  ]
};

export const milrinone: VasoactiveDrug = {
  id: 'milrinone',
  name: 'Milrinone',
  genericName: 'Milrinone',
  category: 'inotrope',
  description: 'Inhibiteur de la phosphodiestérase III - inotrope et vasodilatateur',
  concentrations: [
    { label: '0.2 mg/mL (10mg/50mL)', mgPerMl: 0.2, commonPrep: '10 mg dans 50 mL G5%' },
    { label: '0.4 mg/mL (20mg/50mL)', mgPerMl: 0.4, commonPrep: '20 mg dans 50 mL G5%' }
  ],
  defaultConcentrationIndex: 0,
  doseUnit: 'mcg/kg/min',
  doseRange: { min: 0.125, max: 0.75, typical: 0.375, step: 0.125 },
  indications: [
    'Insuffisance cardiaque aiguë',
    'Choc cardiogénique',
    'Post-chirurgie cardiaque',
    'HTAP (vasodilatation pulmonaire)'
  ],
  effects: {
    alpha: 'none',
    beta1: 'none',
    beta2: 'none',
    dopaminergic: 'none',
    vasopressin: 'none'
  },
  sideEffects: [
    'Hypotension (vasodilatation)',
    'Arythmies ventriculaires',
    'Thrombocytopénie',
    'Céphalées'
  ],
  contraindications: [
    'Sténose aortique ou pulmonaire sévère',
    'Cardiomyopathie obstructive',
    'Infarctus aigu (phase aiguë)'
  ],
  notes: [
    'Bolus optionnel: 50 mcg/kg en 10 min',
    'Réduire dose si insuffisance rénale',
    'Demi-vie longue (2-3h)',
    'Action indépendante des récepteurs β'
  ]
};

export const isoproterenol: VasoactiveDrug = {
  id: 'isoproterenol',
  name: 'Isoprénaline',
  genericName: 'Isoproterenol',
  category: 'inotrope',
  description: 'Agoniste β pur - chronotrope et inotrope positif',
  concentrations: [
    { label: '0.02 mg/mL (1mg/50mL)', mgPerMl: 0.02, commonPrep: '1 mg dans 50 mL G5%' },
    { label: '0.04 mg/mL (2mg/50mL)', mgPerMl: 0.04, commonPrep: '2 mg dans 50 mL G5%' }
  ],
  defaultConcentrationIndex: 0,
  doseUnit: 'mcg/min',
  doseRange: { min: 1, max: 20, typical: 5, step: 1 },
  indications: [
    'Bradycardie sévère réfractaire à l\'atropine',
    'BAV complet en attente de pacemaker',
    'Torsades de pointe (↑ FC)',
    'Test de provocation (Brugada)'
  ],
  effects: {
    alpha: 'none',
    beta1: 'high',
    beta2: 'high',
    dopaminergic: 'none',
    vasopressin: 'none'
  },
  sideEffects: [
    'Tachycardie excessive',
    'Arythmies ventriculaires',
    'Hypotension (β2)',
    'Flush',
    'Tremblements',
    'Angor'
  ],
  contraindications: [
    'Tachyarythmie',
    'Intoxication digitalique',
    'Cardiopathie ischémique sévère'
  ],
  notes: [
    'Dose non basée sur le poids',
    'Titrer pour FC cible',
    'Solution de temporisation avant pacing'
  ]
};

export const nicardipine: VasoactiveDrug = {
  id: 'nicardipine',
  name: 'Nicardipine',
  genericName: 'Nicardipine',
  category: 'vasodilator',
  description: 'Inhibiteur calcique - vasodilatateur artériel',
  concentrations: [
    { label: '0.2 mg/mL (10mg/50mL)', mgPerMl: 0.2, commonPrep: '10 mg dans 50 mL NaCl' },
    { label: '0.5 mg/mL (25mg/50mL)', mgPerMl: 0.5, commonPrep: '25 mg dans 50 mL NaCl' },
    { label: '1 mg/mL (50mg/50mL)', mgPerMl: 1, commonPrep: '50 mg dans 50 mL NaCl' }
  ],
  defaultConcentrationIndex: 0,
  doseUnit: 'mg/h',
  doseRange: { min: 1, max: 15, typical: 5, step: 0.5 },
  indications: [
    'Urgence hypertensive',
    'HTA périopératoire',
    'Dissection aortique',
    'AVC hémorragique'
  ],
  effects: {
    alpha: 'none',
    beta1: 'none',
    beta2: 'none',
    dopaminergic: 'none',
    vasopressin: 'none'
  },
  sideEffects: [
    'Hypotension',
    'Tachycardie réflexe',
    'Céphalées',
    'Flush',
    'Nausées',
    'Phlébite au site d\'injection'
  ],
  contraindications: [
    'Sténose aortique sévère',
    'Choc cardiogénique',
    'Insuffisance cardiaque décompensée'
  ],
  notes: [
    'Début d\'action: 5-10 min',
    'Augmenter par paliers de 2.5 mg/h toutes les 5-15 min',
    'Changer de site de perfusion toutes les 12h (phlébite)'
  ]
};

export const nitroprusside: VasoactiveDrug = {
  id: 'nitroprusside',
  name: 'Nitroprussiate de sodium',
  genericName: 'Sodium Nitroprusside',
  category: 'vasodilator',
  description: 'Vasodilatateur artériel et veineux puissant',
  concentrations: [
    { label: '0.5 mg/mL (25mg/50mL)', mgPerMl: 0.5, commonPrep: '25 mg dans 50 mL G5% (protéger de la lumière)' },
    { label: '1 mg/mL (50mg/50mL)', mgPerMl: 1, commonPrep: '50 mg dans 50 mL G5%' }
  ],
  defaultConcentrationIndex: 0,
  doseUnit: 'mcg/kg/min',
  doseRange: { min: 0.25, max: 10, typical: 2, step: 0.25 },
  indications: [
    'Urgence hypertensive sévère',
    'Dissection aortique (avec β-bloquant)',
    'Insuffisance cardiaque aiguë',
    'Hypotension contrôlée peropératoire'
  ],
  effects: {
    alpha: 'none',
    beta1: 'none',
    beta2: 'none',
    dopaminergic: 'none',
    vasopressin: 'none'
  },
  sideEffects: [
    'Hypotension',
    'Tachycardie réflexe',
    'Céphalées',
    'Nausées',
    'Toxicité au cyanure (doses élevées ou prolongées)',
    'Méthémoglobinémie'
  ],
  contraindications: [
    'Insuffisance hépatique sévère',
    'Déficit en vitamine B12',
    'Atrophie optique de Leber',
    'Shunt artério-veineux'
  ],
  notes: [
    'PROTÉGER DE LA LUMIÈRE (tubulure opaque)',
    'Surveillance thiocyanatémie si > 48h',
    'Antidote: hydroxocobalamine',
    'Début d\'action immédiat, arrêt effet en 1-2 min'
  ]
};

export const nitroglycerin: VasoactiveDrug = {
  id: 'nitroglycerin',
  name: 'Trinitrine',
  genericName: 'Nitroglycerin',
  category: 'vasodilator',
  description: 'Vasodilatateur veineux > artériel - Réduction précharge',
  concentrations: [
    { label: '1 mg/mL (50mg/50mL)', mgPerMl: 1, commonPrep: '50 mg dans 50 mL G5%' },
    { label: '0.4 mg/mL (20mg/50mL)', mgPerMl: 0.4, commonPrep: '20 mg dans 50 mL G5%' }
  ],
  defaultConcentrationIndex: 0,
  doseUnit: 'mcg/min',
  doseRange: { min: 5, max: 200, typical: 20, step: 5 },
  indications: [
    'Syndrome coronaire aigu',
    'OAP cardiogénique',
    'Urgence hypertensive',
    'Spasme coronaire'
  ],
  effects: {
    alpha: 'none',
    beta1: 'none',
    beta2: 'none',
    dopaminergic: 'none',
    vasopressin: 'none'
  },
  sideEffects: [
    'Hypotension',
    'Céphalées',
    'Tachycardie réflexe',
    'Flush',
    'Méthémoglobinémie (rare)'
  ],
  contraindications: [
    'Hypotension',
    'Choc cardiogénique',
    'Utilisation de sildénafil/tadalafil (24-48h)',
    'Sténose aortique sévère',
    'IDM droit'
  ],
  notes: [
    'Dose non basée sur le poids',
    'Tachyphylaxie après 24-48h',
    'Utiliser tubulure spéciale (adsorption PVC)'
  ]
};

// Export all drugs
export const vasoactiveDrugs: VasoactiveDrug[] = [
  noradrenaline,
  adrenaline,
  dobutamine,
  dopamine,
  vasopressine,
  milrinone,
  isoproterenol,
  nicardipine,
  nitroprusside,
  nitroglycerin
];

// Helper to get drug by ID
export function getDrugById(id: string): VasoactiveDrug | undefined {
  return vasoactiveDrugs.find(drug => drug.id === id);
}

// Category labels
export const categoryLabels: Record<string, string> = {
  vasopressor: 'Vasopresseurs',
  inotrope: 'Inotropes',
  vasodilator: 'Vasodilatateurs',
  mixed: 'Mixtes'
};

// Calculate flow rate for PSE
export function calculateFlowRate(
  drug: VasoactiveDrug,
  patientWeightKg: number,
  dose: number,
  concentrationMgPerMl: number
): number {
  // Convert dose to mcg/min based on dose unit
  let mcgPerMin: number;
  
  switch (drug.doseUnit) {
    case 'mcg/kg/min':
      mcgPerMin = dose * patientWeightKg;
      break;
    case 'mcg/min':
      mcgPerMin = dose;
      break;
    case 'mg/h':
      mcgPerMin = (dose * 1000) / 60; // mg/h to mcg/min
      break;
    case 'UI/min':
      // For vasopressin, concentration is in UI/mL
      const uiPerMin = dose;
      const uiPerMl = concentrationMgPerMl; // Actually UI/mL for vasopressin
      return (uiPerMin / uiPerMl) * 60; // mL/h
    default:
      mcgPerMin = dose;
  }
  
  // Convert to mg/min
  const mgPerMin = mcgPerMin / 1000;
  
  // Calculate mL/min
  const mlPerMin = mgPerMin / concentrationMgPerMl;
  
  // Convert to mL/h
  return mlPerMin * 60;
}
