// Sedation Drugs Database

import type { SedationDrug } from './types';

// =====================
// INDUCTION AGENTS
// =====================

export const propofol: SedationDrug = {
  id: 'propofol',
  name: 'Propofol',
  genericName: 'Propofol',
  drugClass: 'Hypnotique',
  role: ['induction', 'sedative'],
  sedationTypes: ['rsi', 'procedural', 'maintenance'],
  standardDose: 2,
  doseUnit: 'mg/kg',
  route: ['IV'],
  dosesByAge: [
    { ageGroup: 'adult', ageRange: '18-65 ans', dose: 1.5, notes: 'Titrer par bolus de 20-40 mg' },
    { ageGroup: 'elderly', ageRange: '> 65 ans', dose: 1, notes: 'Réduire de 30-50%' },
    { ageGroup: 'child', ageRange: '3-17 ans', dose: 2.5, notes: 'Doses plus élevées nécessaires' }
  ],
  maxSingleDose: 200,
  maxSingleDoseUnit: 'mg',
  onsetSeconds: 30,
  durationMinutes: 5,
  mechanism: 'Potentialisation GABA-A, dépression SNC',
  indications: [
    'Induction anesthésie',
    'Sédation procédurale',
    'Sédation en réanimation',
    'État de mal épileptique'
  ],
  advantages: [
    'Début d\'action rapide',
    'Réveil rapide et clair',
    'Propriétés antiémétiques',
    'Diminue la pression intracrânienne'
  ],
  sideEffects: [
    'Hypotension (dose-dépendante)',
    'Apnée',
    'Douleur à l\'injection',
    'Bradycardie',
    'Syndrome de perfusion du propofol (rare, doses élevées prolongées)'
  ],
  contraindications: [
    'Allergie aux œufs/soja (relative)',
    'Hypovolémie non corrigée',
    'Choc cardiogénique'
  ],
  precautions: [
    'Insuffisance cardiaque',
    'Personnes âgées',
    'Hypovolémie'
  ],
  concentrations: ['10 mg/mL', '20 mg/mL'],
  notes: [
    'Ajouter lidocaïne 20-40 mg pour réduire douleur injection',
    'Ne pas utiliser > 48h en réanimation (syndrome perfusion)',
    'Réduire dose si opioïde administré avant'
  ]
};

export const etomidate: SedationDrug = {
  id: 'etomidate',
  name: 'Étomidate',
  genericName: 'Etomidate',
  drugClass: 'Hypnotique',
  role: ['induction'],
  sedationTypes: ['rsi'],
  standardDose: 0.3,
  doseUnit: 'mg/kg',
  route: ['IV'],
  dosesByAge: [
    { ageGroup: 'adult', ageRange: '18-65 ans', dose: 0.3 },
    { ageGroup: 'elderly', ageRange: '> 65 ans', dose: 0.2, notes: 'Réduire légèrement' },
    { ageGroup: 'child', ageRange: '> 10 ans', dose: 0.3 }
  ],
  maxSingleDose: 40,
  maxSingleDoseUnit: 'mg',
  onsetSeconds: 30,
  durationMinutes: 5,
  mechanism: 'Potentialisation GABA-A',
  indications: [
    'ISR chez patient instable hémodynamiquement',
    'Cardioversion',
    'Patient coronarien'
  ],
  advantages: [
    'Stabilité hémodynamique',
    'Début d\'action rapide',
    'Pas de libération d\'histamine',
    'Diminue la pression intracrânienne'
  ],
  sideEffects: [
    'Myoclonies (30-80%)',
    'Nausées/vomissements au réveil',
    'Douleur à l\'injection',
    'Suppression surrénalienne (dose unique = cliniquement non significatif)'
  ],
  contraindications: [
    'Insuffisance surrénalienne connue',
    'Sepsis (controversé pour dose unique)'
  ],
  precautions: [
    'Épilepsie (myoclonies peuvent mimer convulsions)',
    'Porphyrie'
  ],
  concentrations: ['2 mg/mL'],
  notes: [
    'Agent de choix pour ISR chez patient instable',
    'Myoclonies réduites si curare administré avant',
    'Pas d\'utilisation en perfusion continue'
  ]
};

export const ketamine: SedationDrug = {
  id: 'ketamine',
  name: 'Kétamine',
  genericName: 'Ketamine',
  drugClass: 'Anesthésique dissociatif',
  role: ['induction', 'analgesic', 'sedative'],
  sedationTypes: ['rsi', 'procedural'],
  standardDose: 1.5,
  doseUnit: 'mg/kg',
  route: ['IV', 'IM'],
  dosesByAge: [
    { ageGroup: 'adult', ageRange: '18-65 ans', dose: 1.5, notes: 'IV: 1-2 mg/kg, IM: 4-5 mg/kg' },
    { ageGroup: 'child', ageRange: '1-17 ans', dose: 1.5, notes: 'IV: 1-2 mg/kg, IM: 4-5 mg/kg' },
    { ageGroup: 'infant', ageRange: '< 1 an', dose: 2, notes: 'Doses plus élevées' }
  ],
  onsetSeconds: 60,
  durationMinutes: 15,
  mechanism: 'Antagoniste NMDA, anesthésie dissociative',
  indications: [
    'ISR asthme/bronchospasme',
    'Sédation procédurale pédiatrique',
    'Patient hypovolémique/en choc',
    'Analgésie (faibles doses)',
    'État de mal asthmatique'
  ],
  advantages: [
    'Maintien des réflexes protecteurs',
    'Bronchodilatation',
    'Stimulation cardiovasculaire',
    'Analgésie puissante',
    'Voie IM possible'
  ],
  sideEffects: [
    'Hallucinations / émergence dysphorique (adulte)',
    'Hypersalivation',
    'Augmentation PIC (controversé)',
    'Tachycardie, hypertension',
    'Nystagmus',
    'Laryngospasme (rare)',
    'Vomissements au réveil'
  ],
  contraindications: [
    'HTA mal contrôlée',
    'Prééclampsie/éclampsie',
    'Anévrisme, dissection aortique',
    'Psychose, schizophrénie',
    'Glaucome à angle fermé',
    'Lésion oculaire ouverte'
  ],
  precautions: [
    'Ajouter benzodiazépine chez l\'adulte pour prévenir émergence',
    'Atropine si hypersalivation problématique'
  ],
  concentrations: ['10 mg/mL', '50 mg/mL', '100 mg/mL'],
  dilution: 'Diluer à 10 mg/mL pour administration IV',
  notes: [
    'Agent de choix: asthme, hypovolémie, pédiatrie',
    'Dose analgésie: 0.1-0.3 mg/kg',
    'Prétraitement midazolam 0.03 mg/kg recommandé chez adulte',
    'Réflexes laryngés préservés mais pas protection complète'
  ]
};

export const midazolam: SedationDrug = {
  id: 'midazolam',
  name: 'Midazolam',
  genericName: 'Midazolam',
  drugClass: 'Benzodiazépine',
  role: ['sedative', 'adjunct'],
  sedationTypes: ['procedural', 'maintenance'],
  standardDose: 0.1,
  doseUnit: 'mg/kg',
  route: ['IV', 'IM', 'IN', 'PO'],
  dosesByAge: [
    { ageGroup: 'adult', ageRange: '18-65 ans', dose: 0.05, notes: 'Titrer par 1-2 mg' },
    { ageGroup: 'elderly', ageRange: '> 65 ans', dose: 0.025, notes: 'Réduire de 50%' },
    { ageGroup: 'child', ageRange: '1-17 ans', dose: 0.1, notes: 'Max 5 mg' },
    { ageGroup: 'infant', ageRange: '< 1 an', dose: 0.05 }
  ],
  maxSingleDose: 5,
  maxSingleDoseUnit: 'mg',
  onsetSeconds: 90,
  durationMinutes: 30,
  mechanism: 'Potentialisation GABA-A',
  indications: [
    'Anxiolyse pré-procédure',
    'Sédation procédurale (avec analgésique)',
    'Complément kétamine (prévention émergence)',
    'État de mal épileptique',
    'Sédation réanimation'
  ],
  advantages: [
    'Amnésie antérograde',
    'Anxiolyse',
    'Anticonvulsivant',
    'Antagoniste disponible (flumazénil)'
  ],
  sideEffects: [
    'Dépression respiratoire',
    'Hypotension',
    'Réaction paradoxale (enfant, âgé)',
    'Amnésie prolongée'
  ],
  contraindications: [
    'Myasthénie grave',
    'Insuffisance respiratoire sévère',
    'Glaucome aigu à angle fermé'
  ],
  precautions: [
    'Réduire dose si opioïde associé',
    'Insuffisance hépatique: réduire dose',
    'Obésité: calculer sur poids idéal'
  ],
  concentrations: ['1 mg/mL', '5 mg/mL'],
  notes: [
    'Pas d\'analgésie - associer à analgésique',
    'Voie IN: 0.2-0.3 mg/kg (convulsions enfant)',
    'Voie PO: 0.5 mg/kg (prémédication)',
    'Antidote: Flumazénil 0.2 mg IV'
  ]
};

// =====================
// PARALYTIC AGENTS
// =====================

export const succinylcholine: SedationDrug = {
  id: 'succinylcholine',
  name: 'Succinylcholine',
  genericName: 'Suxamethonium',
  drugClass: 'Curare dépolarisant',
  role: ['paralytic'],
  sedationTypes: ['rsi'],
  standardDose: 1.5,
  doseUnit: 'mg/kg',
  route: ['IV', 'IM'],
  dosesByAge: [
    { ageGroup: 'adult', ageRange: '18+ ans', dose: 1.5 },
    { ageGroup: 'child', ageRange: '1-17 ans', dose: 2 },
    { ageGroup: 'infant', ageRange: '< 1 an', dose: 2 }
  ],
  onsetSeconds: 45,
  durationMinutes: 8,
  mechanism: 'Agoniste récepteurs nicotiniques - dépolarisation prolongée',
  indications: [
    'ISR (curarisation rapide)',
    'Laryngospasme',
    'Électroconvulsivothérapie'
  ],
  advantages: [
    'Début d\'action le plus rapide',
    'Courte durée d\'action',
    'IM possible si accès IV impossible'
  ],
  sideEffects: [
    'Hyperkaliémie (↑ 0.5-1 mEq/L)',
    'Fasciculations',
    'Bradycardie (surtout 2ème dose)',
    'Hypertension intracrânienne',
    'Hyperthermie maligne',
    'Myalgies post-opératoires',
    'Trismus massétérin'
  ],
  contraindications: [
    'ATCD hyperthermie maligne',
    'Myopathie/dystrophie musculaire',
    'Hyperkaliémie',
    'Brûlures > 24h (jusqu\'à 1 an après)',
    'Dénervation (AVC > 72h, lésion médullaire)',
    'Immobilisation prolongée',
    'Rhabdomyolyse',
    'Insuffisance rénale avec hyperkaliémie'
  ],
  precautions: [
    'Atropine prête si bradycardie',
    'Déficit en pseudocholinestérase: curarisation prolongée'
  ],
  concentrations: ['20 mg/mL', '50 mg/mL'],
  notes: [
    'IM: 4-5 mg/kg si pas d\'accès IV',
    'Prétraitement non recommandé en routine',
    'Durée plus longue chez enfant',
    'Alternative: rocuronium si contre-indication'
  ]
};

export const rocuronium: SedationDrug = {
  id: 'rocuronium',
  name: 'Rocuronium',
  genericName: 'Rocuronium',
  drugClass: 'Curare non-dépolarisant',
  role: ['paralytic'],
  sedationTypes: ['rsi', 'maintenance'],
  standardDose: 1.2,
  doseUnit: 'mg/kg',
  route: ['IV'],
  dosesByAge: [
    { ageGroup: 'adult', ageRange: '18+ ans', dose: 1.2, notes: 'ISR: 1.2 mg/kg' },
    { ageGroup: 'child', ageRange: '1-17 ans', dose: 1.2 },
    { ageGroup: 'infant', ageRange: '< 1 an', dose: 1.2 }
  ],
  onsetSeconds: 60,
  durationMinutes: 45,
  mechanism: 'Antagoniste compétitif récepteurs nicotiniques',
  indications: [
    'ISR (alternative à succinylcholine)',
    'Curarisation peropératoire',
    'Contre-indication à succinylcholine'
  ],
  advantages: [
    'Pas d\'hyperkaliémie',
    'Pas de fasciculations',
    'Réversible par sugammadex',
    'Pas de risque d\'hyperthermie maligne'
  ],
  sideEffects: [
    'Curarisation prolongée',
    'Tachycardie légère',
    'Réaction allergique (rare)'
  ],
  contraindications: [
    'Allergie connue'
  ],
  precautions: [
    'Conditions intubation difficile (durée prolongée)',
    'Insuffisance hépatique: durée prolongée',
    'Myasthénie: réduire dose'
  ],
  concentrations: ['10 mg/mL'],
  notes: [
    'Sugammadex 16 mg/kg pour antagonisation immédiate',
    'Dose entretien: 0.1-0.2 mg/kg',
    'Dose ISR élevée = conditions similaires à succinylcholine',
    'Stocker au réfrigérateur'
  ]
};

// =====================
// OPIOID ANALGESICS
// =====================

export const fentanyl: SedationDrug = {
  id: 'fentanyl',
  name: 'Fentanyl',
  genericName: 'Fentanyl',
  drugClass: 'Opioïde',
  role: ['analgesic'],
  sedationTypes: ['rsi', 'procedural', 'maintenance'],
  standardDose: 2,
  doseUnit: 'mcg/kg',
  route: ['IV', 'IN'],
  dosesByAge: [
    { ageGroup: 'adult', ageRange: '18-65 ans', dose: 1, notes: 'Titrer par 25-50 mcg' },
    { ageGroup: 'elderly', ageRange: '> 65 ans', dose: 0.5, notes: 'Réduire de 50%' },
    { ageGroup: 'child', ageRange: '1-17 ans', dose: 1, notes: 'Max 50 mcg' },
    { ageGroup: 'infant', ageRange: '< 1 an', dose: 1 }
  ],
  maxSingleDose: 100,
  maxSingleDoseUnit: 'mcg',
  onsetSeconds: 90,
  durationMinutes: 45,
  mechanism: 'Agoniste récepteurs mu opioïdes',
  indications: [
    'Analgésie ISR',
    'Sédation procédurale (avec hypnotique)',
    'Analgésie procédurale',
    'Atténuation réponse sympathique à l\'intubation'
  ],
  advantages: [
    'Stabilité hémodynamique',
    'Début d\'action rapide',
    'Pas de libération d\'histamine',
    'Réversible (naloxone)'
  ],
  sideEffects: [
    'Dépression respiratoire',
    'Rigidité thoracique (dose élevée rapide)',
    'Bradycardie',
    'Nausées/vomissements',
    'Prurit',
    'Rétention urinaire'
  ],
  contraindications: [
    'IMAO dans les 14 jours'
  ],
  precautions: [
    'Insuffisance respiratoire',
    'Injection lente pour éviter rigidité thoracique',
    'Réduire dose si autre dépresseur SNC'
  ],
  concentrations: ['50 mcg/mL'],
  notes: [
    'Voie IN: 1.5-2 mcg/kg (douleur pédiatrique)',
    'Rigidité thoracique: traiter avec curare',
    'Antidote: Naloxone 0.4-2 mg IV',
    'Pour ISR: administrer 3 min avant induction'
  ]
};

export const morphine: SedationDrug = {
  id: 'morphine',
  name: 'Morphine',
  genericName: 'Morphine',
  drugClass: 'Opioïde',
  role: ['analgesic'],
  sedationTypes: ['procedural'],
  standardDose: 0.1,
  doseUnit: 'mg/kg',
  route: ['IV', 'SC', 'PO'],
  dosesByAge: [
    { ageGroup: 'adult', ageRange: '18-65 ans', dose: 0.1, notes: 'Titrer par 2-4 mg IV' },
    { ageGroup: 'elderly', ageRange: '> 65 ans', dose: 0.05, notes: 'Réduire de 50%' },
    { ageGroup: 'child', ageRange: '1-17 ans', dose: 0.1, notes: 'Max 5 mg' },
    { ageGroup: 'infant', ageRange: '3-12 mois', dose: 0.05 }
  ],
  maxSingleDose: 10,
  maxSingleDoseUnit: 'mg',
  onsetSeconds: 300,
  durationMinutes: 240,
  mechanism: 'Agoniste récepteurs mu opioïdes',
  indications: [
    'Douleur modérée à sévère',
    'OAP cardiogénique',
    'Analgésie sédation procédurale'
  ],
  advantages: [
    'Longue durée d\'action',
    'Économique',
    'Multiples voies d\'administration'
  ],
  sideEffects: [
    'Dépression respiratoire',
    'Hypotension (libération histamine)',
    'Nausées/vomissements',
    'Prurit',
    'Rétention urinaire',
    'Constipation'
  ],
  contraindications: [
    'Asthme aigu sévère',
    'Insuffisance respiratoire'
  ],
  precautions: [
    'Insuffisance rénale: métabolites actifs accumulés',
    'Insuffisance hépatique: réduire dose'
  ],
  concentrations: ['1 mg/mL', '10 mg/mL'],
  notes: [
    'Début plus lent que fentanyl - moins adapté ISR',
    'Éviter en insuffisance rénale (M6G)',
    'Antidote: Naloxone 0.4-2 mg IV'
  ]
};

// =====================
// ADJUNCTS
// =====================

export const atropine: SedationDrug = {
  id: 'atropine',
  name: 'Atropine',
  genericName: 'Atropine',
  drugClass: 'Anticholinergique',
  role: ['adjunct'],
  sedationTypes: ['rsi'],
  standardDose: 0.02,
  doseUnit: 'mg/kg',
  route: ['IV'],
  dosesByAge: [
    { ageGroup: 'adult', ageRange: '18+ ans', dose: 0.02, notes: 'Min 0.5 mg, max 1 mg' },
    { ageGroup: 'child', ageRange: '< 18 ans', dose: 0.02, notes: 'Min 0.1 mg, max 0.5 mg' }
  ],
  onsetSeconds: 60,
  durationMinutes: 30,
  mechanism: 'Antagoniste muscarinique',
  indications: [
    'Prévention bradycardie (succinylcholine)',
    'Bradycardie symptomatique',
    'Hypersalivation (kétamine)'
  ],
  advantages: [
    'Prévient bradycardie réflexe',
    'Réduit sécrétions'
  ],
  sideEffects: [
    'Tachycardie',
    'Sécheresse buccale',
    'Mydriase',
    'Rétention urinaire',
    'Confusion (âgé)'
  ],
  contraindications: [
    'Glaucome à angle fermé'
  ],
  precautions: [
    'Dose < 0.1 mg peut causer bradycardie paradoxale'
  ],
  concentrations: ['0.25 mg/mL', '1 mg/mL'],
  notes: [
    'Systématique avant succinylcholine chez enfant < 1 an',
    'Optionnel chez enfant 1-5 ans',
    'Non nécessaire en routine chez adulte'
  ]
};

export const lidocaine: SedationDrug = {
  id: 'lidocaine',
  name: 'Lidocaïne',
  genericName: 'Lidocaine',
  drugClass: 'Anesthésique local',
  role: ['adjunct'],
  sedationTypes: ['rsi'],
  standardDose: 1.5,
  doseUnit: 'mg/kg',
  route: ['IV'],
  dosesByAge: [
    { ageGroup: 'adult', ageRange: '18+ ans', dose: 1.5 },
    { ageGroup: 'child', ageRange: '< 18 ans', dose: 1.5 }
  ],
  maxSingleDose: 100,
  maxSingleDoseUnit: 'mg',
  onsetSeconds: 90,
  durationMinutes: 20,
  mechanism: 'Blocage canaux sodiques, suppression toux',
  indications: [
    'Atténuation réflexe toux/laryngé',
    'Réduction PIC lors intubation',
    'Prévention augmentation PIO',
    'Asthme/bronchospasme'
  ],
  advantages: [
    'Réduit réponse hémodynamique à l\'intubation',
    'Bronchodilatation',
    'Réduit la PIC'
  ],
  sideEffects: [
    'Hypotension (dose élevée)',
    'Convulsions (surdosage)',
    'Arythmies'
  ],
  contraindications: [
    'Allergie aux anesthésiques locaux amides',
    'BAV haut degré',
    'Syndrome de Wolff-Parkinson-White'
  ],
  precautions: [
    'Insuffisance cardiaque',
    'Insuffisance hépatique'
  ],
  concentrations: ['10 mg/mL', '20 mg/mL'],
  notes: [
    'Administrer 3 min avant laryngoscopie',
    'Bénéfice contesté dans la littérature récente',
    'Utilisé principalement pour HTIC et asthme'
  ]
};

// Export all drugs
export const sedationDrugs: SedationDrug[] = [
  // Induction
  propofol,
  etomidate,
  ketamine,
  midazolam,
  // Paralytic
  succinylcholine,
  rocuronium,
  // Analgesic
  fentanyl,
  morphine,
  // Adjunct
  atropine,
  lidocaine
];

// Helper functions
export function getDrugById(id: string): SedationDrug | undefined {
  return sedationDrugs.find(drug => drug.id === id);
}

export function getDrugsByRole(role: string): SedationDrug[] {
  return sedationDrugs.filter(drug => drug.role.includes(role as any));
}

export function getDrugsBySedationType(type: string): SedationDrug[] {
  return sedationDrugs.filter(drug => drug.sedationTypes.includes(type as any));
}

// Role labels
export const roleLabels: Record<string, string> = {
  induction: 'Agents d\'induction',
  paralytic: 'Curares',
  analgesic: 'Analgésiques',
  sedative: 'Sédatifs',
  adjunct: 'Adjuvants'
};

// Sedation type labels
export const sedationTypeLabels: Record<string, string> = {
  rsi: 'Induction Séquence Rapide (ISR)',
  procedural: 'Sédation Procédurale',
  maintenance: 'Sédation d\'Entretien'
};
