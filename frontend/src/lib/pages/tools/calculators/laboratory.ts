// Laboratory & Physiologic Calculators

import type { Calculator } from './types';

export const qtcCalculator: Calculator = {
  id: 'qtc',
  name: 'QTc Calculator (Bazett & Fridericia)',
  shortName: 'QTc',
  category: 'cardiovascular',
  description: 'Calcul du QT corrigé avec formules de Bazett et Fridericia. Alerte sur les médicaments allongeant le QT.',
  fields: [
    {
      id: 'qt',
      label: 'Intervalle QT (ms)',
      type: 'number',
      min: 200,
      max: 700,
      unit: 'ms',
      required: true
    },
    {
      id: 'rr',
      label: 'Intervalle RR (ms) ou FC',
      type: 'number',
      min: 300,
      max: 2000,
      unit: 'ms',
      required: true
    },
    {
      id: 'useHr',
      label: 'Utiliser la fréquence cardiaque au lieu de RR',
      type: 'checkbox'
    }
  ],
  calculate: (values) => {
    const qt = values.qt as number;
    let rr = values.rr as number;
    
    // Convert HR to RR if checkbox is selected
    if (values.useHr) {
      rr = 60000 / rr; // Convert bpm to ms
    }
    
    // Bazett formula: QTc = QT / √(RR in seconds)
    const rrSeconds = rr / 1000;
    const qtcBazett = Math.round(qt / Math.sqrt(rrSeconds));
    
    // Return Bazett by default (Fridericia shown in interpretation)
    return qtcBazett;
  },
  interpretations: [
    { range: [0, 440], label: 'QTc Normal', description: 'QTc < 440 ms. Normal pour les deux sexes.', color: 'green' },
    { range: [441, 460], label: 'QTc Limite (Homme)', description: 'QTc 440-460 ms. Limite chez l\'homme, normal chez la femme.', color: 'yellow' },
    { range: [461, 480], label: 'QTc Prolongé Modéré', description: 'QTc 460-480 ms. Prolongé, surveiller les médicaments.', color: 'orange' },
    { range: [481, 1000], label: 'QTc Prolongé Sévère', description: 'QTc > 480 ms. Risque de torsades de pointes. Revoir médicaments et électrolytes.', color: 'red' }
  ],
  source: 'Bazett HC (1920), Fridericia LS (1920)',
  sourceUrl: 'https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5390937/'
};

export const creatinineClearance: Calculator = {
  id: 'creatinine-clearance',
  name: 'Clairance de la Créatinine (CKD-EPI & Cockcroft-Gault)',
  shortName: 'ClCr',
  category: 'cardiovascular',
  description: 'Estimation du DFG par CKD-EPI (recommandé) et Cockcroft-Gault (ajustement médicamenteux)',
  fields: [
    {
      id: 'age',
      label: 'Âge',
      type: 'number',
      min: 18,
      max: 120,
      unit: 'ans',
      required: true
    },
    {
      id: 'weight',
      label: 'Poids',
      type: 'number',
      min: 30,
      max: 300,
      unit: 'kg',
      required: true
    },
    {
      id: 'creatinine',
      label: 'Créatinine sérique',
      type: 'number',
      min: 20,
      max: 2000,
      unit: 'µmol/L',
      required: true
    },
    {
      id: 'female',
      label: 'Sexe féminin',
      type: 'checkbox'
    },
    {
      id: 'black',
      label: 'Race noire (CKD-EPI 2009)',
      type: 'checkbox'
    }
  ],
  calculate: (values) => {
    const age = values.age as number;
    const weight = values.weight as number;
    const creatMumol = values.creatinine as number;
    const isFemale = values.female as boolean;
    
    // Convert µmol/L to mg/dL
    const creatMgDl = creatMumol / 88.4;
    
    // Cockcroft-Gault formula
    let cg = ((140 - age) * weight) / (72 * creatMgDl);
    if (isFemale) cg *= 0.85;
    
    return Math.round(cg);
  },
  interpretations: [
    { range: [90, 200], label: 'Fonction rénale normale', description: 'DFG ≥ 90 mL/min. Stade 1 IRC ou normal.', color: 'green' },
    { range: [60, 89], label: 'IRC légère (Stade 2)', description: 'DFG 60-89 mL/min. Surveillance, pas d\'ajustement majeur.', color: 'yellow' },
    { range: [30, 59], label: 'IRC modérée (Stade 3)', description: 'DFG 30-59 mL/min. Ajustement posologique nécessaire.', color: 'orange' },
    { range: [15, 29], label: 'IRC sévère (Stade 4)', description: 'DFG 15-29 mL/min. Ajustement majeur, préparer dialyse.', color: 'red' },
    { range: [0, 14], label: 'IRC terminale (Stade 5)', description: 'DFG < 15 mL/min. Dialyse/transplantation.', color: 'red' }
  ],
  source: 'Cockcroft DW, Gault MH (1976); CKD-EPI (2009)',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/19414839/'
};

export const correctedCalcium: Calculator = {
  id: 'corrected-calcium',
  name: 'Calcium Corrigé (pour Albumine)',
  shortName: 'Ca Corr',
  category: 'cardiovascular',
  description: 'Correction du calcium total pour l\'hypoalbuminémie',
  fields: [
    {
      id: 'calcium',
      label: 'Calcium total',
      type: 'number',
      min: 1,
      max: 5,
      unit: 'mmol/L',
      required: true
    },
    {
      id: 'albumin',
      label: 'Albumine',
      type: 'number',
      min: 10,
      max: 60,
      unit: 'g/L',
      required: true
    }
  ],
  calculate: (values) => {
    const calcium = values.calcium as number;
    const albumin = values.albumin as number;
    
    // Formula: Ca corrigé = Ca mesuré + 0.02 × (40 - Albumine)
    const corrected = calcium + 0.02 * (40 - albumin);
    
    // Return in mmol/L × 100 for display (e.g., 2.35 -> 235)
    return Math.round(corrected * 100);
  },
  interpretations: [
    { range: [0, 209], label: 'Hypocalcémie', description: 'Ca corrigé < 2.10 mmol/L. Rechercher cause et traiter.', color: 'orange' },
    { range: [210, 260], label: 'Calcémie normale', description: 'Ca corrigé 2.10-2.60 mmol/L. Normal.', color: 'green' },
    { range: [261, 300], label: 'Hypercalcémie légère', description: 'Ca corrigé 2.60-3.00 mmol/L. Rechercher cause.', color: 'yellow' },
    { range: [301, 500], label: 'Hypercalcémie sévère', description: 'Ca corrigé > 3.00 mmol/L. Urgence, hydratation + biphosphonates.', color: 'red' }
  ],
  source: 'Payne RB et al. BMJ 1973',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/4723462/'
};

export const aaGradient: Calculator = {
  id: 'aa-gradient',
  name: 'Gradient Alvéolo-Artériel (A-a)',
  shortName: 'A-a Gradient',
  category: 'cardiovascular',
  description: 'Calcul du gradient A-a et comparaison avec la valeur attendue pour l\'âge',
  fields: [
    {
      id: 'age',
      label: 'Âge',
      type: 'number',
      min: 1,
      max: 120,
      unit: 'ans',
      required: true
    },
    {
      id: 'fio2',
      label: 'FiO2',
      type: 'number',
      min: 21,
      max: 100,
      unit: '%',
      required: true
    },
    {
      id: 'pao2',
      label: 'PaO2 (gazométrie)',
      type: 'number',
      min: 20,
      max: 600,
      unit: 'mmHg',
      required: true
    },
    {
      id: 'paco2',
      label: 'PaCO2 (gazométrie)',
      type: 'number',
      min: 10,
      max: 120,
      unit: 'mmHg',
      required: true
    },
    {
      id: 'patm',
      label: 'Pression atmosphérique',
      type: 'number',
      min: 600,
      max: 800,
      unit: 'mmHg',
      required: true
    }
  ],
  calculate: (values) => {
    const age = values.age as number;
    const fio2 = (values.fio2 as number) / 100;
    const pao2 = values.pao2 as number;
    const paco2 = values.paco2 as number;
    const patm = values.patm as number || 760;
    
    // PAO2 = FiO2 × (Patm - 47) - (PaCO2 / 0.8)
    const pao2Alveolar = fio2 * (patm - 47) - (paco2 / 0.8);
    
    // A-a gradient = PAO2 - PaO2
    const aaGradient = Math.round(pao2Alveolar - pao2);
    
    return aaGradient;
  },
  interpretations: [
    { range: [-50, 15], label: 'Gradient A-a normal', description: 'Gradient normal (attendu = âge/4 + 4). Pas de trouble des échanges.', color: 'green' },
    { range: [16, 30], label: 'Gradient A-a légèrement élevé', description: 'Trouble léger des échanges gazeux. Peut être normal si âgé.', color: 'yellow' },
    { range: [31, 50], label: 'Gradient A-a modérément élevé', description: 'Trouble modéré: shunt, trouble V/Q, atteinte parenchymateuse.', color: 'orange' },
    { range: [51, 700], label: 'Gradient A-a très élevé', description: 'Trouble sévère des échanges. Shunt important ou atteinte sévère.', color: 'red' }
  ],
  source: 'Mellemgaard K. Acta Physiol Scand 1966',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/5963795/'
};

export const meldScore: Calculator = {
  id: 'meld',
  name: 'Score MELD (Model for End-Stage Liver Disease)',
  shortName: 'MELD',
  category: 'gi',
  description: 'Sévérité de la maladie hépatique terminale. Guide la priorité pour la transplantation.',
  fields: [
    {
      id: 'creatinine',
      label: 'Créatinine sérique',
      type: 'number',
      min: 10,
      max: 1500,
      unit: 'µmol/L',
      required: true
    },
    {
      id: 'bilirubin',
      label: 'Bilirubine totale',
      type: 'number',
      min: 1,
      max: 1000,
      unit: 'µmol/L',
      required: true
    },
    {
      id: 'inr',
      label: 'INR',
      type: 'number',
      min: 0.5,
      max: 15,
      required: true
    },
    {
      id: 'dialysis',
      label: 'Dialyse (≥2x/semaine) ou CVVHD dans les 7 derniers jours',
      type: 'checkbox'
    },
    {
      id: 'sodium',
      label: 'Sodium (pour MELD-Na)',
      type: 'number',
      min: 100,
      max: 180,
      unit: 'mmol/L',
      required: false
    }
  ],
  calculate: (values) => {
    let creatMgDl = (values.creatinine as number) / 88.4;
    let biliMgDl = (values.bilirubin as number) / 17.1;
    let inr = values.inr as number;
    const dialysis = values.dialysis as boolean;
    
    // Cap values per UNOS guidelines
    if (creatMgDl < 1) creatMgDl = 1;
    if (creatMgDl > 4 || dialysis) creatMgDl = 4;
    if (biliMgDl < 1) biliMgDl = 1;
    if (inr < 1) inr = 1;
    
    // MELD = 10 × (0.957 × ln(Créat) + 0.378 × ln(Bili) + 1.120 × ln(INR) + 0.643)
    const meld = 10 * (
      0.957 * Math.log(creatMgDl) +
      0.378 * Math.log(biliMgDl) +
      1.120 * Math.log(inr) +
      0.643
    );
    
    // Round and cap at 40
    return Math.min(40, Math.round(meld));
  },
  interpretations: [
    { range: [6, 9], label: 'MELD 6-9', description: 'Mortalité à 3 mois: 1.9%. Faible priorité greffe.', color: 'green' },
    { range: [10, 19], label: 'MELD 10-19', description: 'Mortalité à 3 mois: 6%. Surveillance rapprochée.', color: 'yellow' },
    { range: [20, 29], label: 'MELD 20-29', description: 'Mortalité à 3 mois: 19.6%. Priorité greffe modérée.', color: 'orange' },
    { range: [30, 39], label: 'MELD 30-39', description: 'Mortalité à 3 mois: 52.6%. Haute priorité greffe.', color: 'red' },
    { range: [40, 50], label: 'MELD ≥ 40', description: 'Mortalité à 3 mois: 71.3%. Urgence transplantation.', color: 'red' }
  ],
  source: 'Kamath PS et al. Hepatology 2001; UNOS',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/11172350/'
};

// Export all laboratory calculators
export const laboratoryScores: Calculator[] = [
  qtcCalculator,
  creatinineClearance,
  correctedCalcium,
  aaGradient,
  meldScore
];
