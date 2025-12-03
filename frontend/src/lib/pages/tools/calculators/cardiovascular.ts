// Cardiovascular Scores

import type { Calculator } from './types';

export const heartScore: Calculator = {
  id: 'heart',
  name: 'HEART Score',
  shortName: 'HEART',
  category: 'cardiovascular',
  description: 'Stratification du risque de syndrome coronarien aigu aux urgences',
  fields: [
    {
      id: 'history',
      label: 'Histoire clinique',
      type: 'select',
      options: [
        { value: 0, label: 'Peu suspecte', description: 'Atypique pour SCA' },
        { value: 1, label: 'Modérément suspecte', description: 'Éléments typiques et atypiques' },
        { value: 2, label: 'Très suspecte', description: 'Typique pour SCA' }
      ]
    },
    {
      id: 'ecg',
      label: 'ECG',
      type: 'select',
      options: [
        { value: 0, label: 'Normal', description: 'Complètement normal' },
        { value: 1, label: 'Anomalies non spécifiques', description: 'BBG, HVG, repolarisation non spécifique' },
        { value: 2, label: 'Déviation ST significative', description: 'Sous-décalage ST, sus-décalage ST' }
      ]
    },
    {
      id: 'age',
      label: 'Âge',
      type: 'select',
      options: [
        { value: 0, label: '< 45 ans' },
        { value: 1, label: '45-64 ans' },
        { value: 2, label: '≥ 65 ans' }
      ]
    },
    {
      id: 'riskFactors',
      label: 'Facteurs de risque',
      type: 'select',
      options: [
        { value: 0, label: 'Aucun facteur de risque connu' },
        { value: 1, label: '1-2 facteurs de risque', description: 'HTA, diabète, tabac, dyslipidémie, obésité, ATCD familiaux' },
        { value: 2, label: '≥ 3 facteurs OU athérosclérose connue', description: 'ATCD IDM, AVC, AOMI, revascularisation' }
      ]
    },
    {
      id: 'troponin',
      label: 'Troponine',
      type: 'select',
      options: [
        { value: 0, label: '≤ limite normale' },
        { value: 1, label: '1-3x limite normale' },
        { value: 2, label: '> 3x limite normale' }
      ]
    }
  ],
  calculate: (values) => {
    return (values.history as number) + (values.ecg as number) + 
           (values.age as number) + (values.riskFactors as number) + (values.troponin as number);
  },
  interpretations: [
    { range: [0, 3], label: 'Faible risque', description: 'MACE < 2% à 6 semaines. Sortie possible avec suivi.', color: 'green' },
    { range: [4, 6], label: 'Risque modéré', description: 'MACE 12-16%. Hospitalisation pour observation/tests.', color: 'orange' },
    { range: [7, 10], label: 'Risque élevé', description: 'MACE > 50%. Stratégie invasive précoce.', color: 'red' }
  ],
  source: 'Six AJ et al. Neth Heart J 2008',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/18665203/'
};

export const cha2ds2vasc: Calculator = {
  id: 'cha2ds2-vasc',
  name: 'CHA₂DS₂-VASc Score',
  shortName: 'CHA₂DS₂-VASc',
  category: 'cardiovascular',
  description: 'Risque d\'AVC dans la fibrillation auriculaire - Guide l\'anticoagulation',
  fields: [
    { id: 'chf', label: 'Insuffisance cardiaque / FEVG ≤ 40%', type: 'checkbox' },
    { id: 'hypertension', label: 'Hypertension', type: 'checkbox' },
    { id: 'age75', label: 'Âge ≥ 75 ans', type: 'checkbox' },
    { id: 'diabetes', label: 'Diabète', type: 'checkbox' },
    { id: 'stroke', label: 'AVC / AIT / Thromboembolie (antécédent)', type: 'checkbox' },
    { id: 'vascular', label: 'Maladie vasculaire (IDM, AOMI, plaque aortique)', type: 'checkbox' },
    { id: 'age65', label: 'Âge 65-74 ans', type: 'checkbox' },
    { id: 'female', label: 'Sexe féminin', type: 'checkbox' }
  ],
  calculate: (values) => {
    let score = 0;
    if (values.chf) score += 1;
    if (values.hypertension) score += 1;
    if (values.age75) score += 2;
    if (values.diabetes) score += 1;
    if (values.stroke) score += 2;
    if (values.vascular) score += 1;
    if (values.age65 && !values.age75) score += 1;
    if (values.female) score += 1;
    return score;
  },
  interpretations: [
    { range: [0, 0], label: 'Faible (homme)', description: 'Risque AVC 0%/an. Pas d\'anticoagulation.', color: 'green' },
    { range: [1, 1], label: 'Faible-modéré', description: 'Risque AVC 1.3%/an. Considérer anticoagulation.', color: 'yellow' },
    { range: [2, 2], label: 'Modéré', description: 'Risque AVC 2.2%/an. Anticoagulation recommandée.', color: 'orange' },
    { range: [3, 9], label: 'Élevé', description: 'Risque AVC ≥ 3.2%/an. Anticoagulation indiquée.', color: 'red' }
  ],
  source: 'Lip GY et al. Chest 2010',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/19762550/'
};

export const hasbled: Calculator = {
  id: 'has-bled',
  name: 'HAS-BLED Score',
  shortName: 'HAS-BLED',
  category: 'cardiovascular',
  description: 'Risque de saignement majeur sous anticoagulation',
  fields: [
    { id: 'hypertension', label: 'HTA non contrôlée (> 160 mmHg systolique)', type: 'checkbox' },
    { id: 'renal', label: 'Insuffisance rénale (dialyse, transplant, créat > 200)', type: 'checkbox' },
    { id: 'liver', label: 'Insuffisance hépatique (cirrhose, bili > 2x, AST/ALT > 3x)', type: 'checkbox' },
    { id: 'stroke', label: 'Antécédent d\'AVC', type: 'checkbox' },
    { id: 'bleeding', label: 'Antécédent de saignement majeur ou prédisposition', type: 'checkbox' },
    { id: 'labile', label: 'INR labile (TTR < 60%) - si sous AVK', type: 'checkbox' },
    { id: 'elderly', label: 'Âge > 65 ans', type: 'checkbox' },
    { id: 'drugs', label: 'Médicaments (antiplaquettaires, AINS)', type: 'checkbox' },
    { id: 'alcohol', label: 'Alcool (≥ 8 verres/semaine)', type: 'checkbox' }
  ],
  calculate: (values) => {
    let score = 0;
    if (values.hypertension) score += 1;
    if (values.renal) score += 1;
    if (values.liver) score += 1;
    if (values.stroke) score += 1;
    if (values.bleeding) score += 1;
    if (values.labile) score += 1;
    if (values.elderly) score += 1;
    if (values.drugs) score += 1;
    if (values.alcohol) score += 1;
    return score;
  },
  interpretations: [
    { range: [0, 0], label: 'Très faible', description: 'Risque saignement 1.13%/an', color: 'green' },
    { range: [1, 1], label: 'Faible', description: 'Risque saignement 1.02%/an', color: 'green' },
    { range: [2, 2], label: 'Modéré', description: 'Risque saignement 1.88%/an', color: 'yellow' },
    { range: [3, 9], label: 'Élevé', description: 'Risque saignement ≥ 3.74%/an. Corriger facteurs modifiables.', color: 'orange' }
  ],
  source: 'Pisters R et al. Chest 2010',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/20299623/'
};

export const canadianSyncope: Calculator = {
  id: 'canadian-syncope',
  name: 'Canadian Syncope Risk Score',
  shortName: 'CSRS',
  category: 'cardiovascular',
  description: 'Prédiction des événements graves à 30 jours après syncope',
  fields: [
    {
      id: 'predisposition',
      label: 'Prédisposition vasovagale',
      type: 'select',
      options: [
        { value: -1, label: 'Oui (chaleur, station debout prolongée, émotion, douleur)', description: 'Facteur protecteur' },
        { value: 0, label: 'Non' }
      ]
    },
    {
      id: 'heartDisease',
      label: 'Antécédent de maladie cardiaque',
      type: 'select',
      options: [
        { value: 0, label: 'Non' },
        { value: 1, label: 'Oui (coronaropathie, FA, ICC, valvulopathie)' }
      ]
    },
    {
      id: 'sbp',
      label: 'Pression systolique < 90 ou > 180 mmHg',
      type: 'select',
      options: [
        { value: 0, label: 'Non (90-180 mmHg)' },
        { value: 2, label: 'Oui (< 90 ou > 180 mmHg)' }
      ]
    },
    {
      id: 'troponin',
      label: 'Troponine élevée (> 99e percentile)',
      type: 'select',
      options: [
        { value: 0, label: 'Non' },
        { value: 2, label: 'Oui' }
      ]
    },
    {
      id: 'axis',
      label: 'Axe QRS anormal (< -30° ou > 100°)',
      type: 'select',
      options: [
        { value: 0, label: 'Non' },
        { value: 1, label: 'Oui' }
      ]
    },
    {
      id: 'qrs',
      label: 'QRS > 130 ms',
      type: 'select',
      options: [
        { value: 0, label: 'Non' },
        { value: 1, label: 'Oui' }
      ]
    },
    {
      id: 'qtc',
      label: 'QTc > 480 ms',
      type: 'select',
      options: [
        { value: 0, label: 'Non' },
        { value: 2, label: 'Oui' }
      ]
    },
    {
      id: 'edDiagnosis',
      label: 'Diagnostic aux urgences',
      type: 'select',
      options: [
        { value: 0, label: 'Syncope vasovagale' },
        { value: 2, label: 'Syncope cardiaque' },
        { value: -2, label: 'Présyncope vasovagale' }
      ]
    }
  ],
  calculate: (values) => {
    return (values.predisposition as number) + (values.heartDisease as number) +
           (values.sbp as number) + (values.troponin as number) +
           (values.axis as number) + (values.qrs as number) +
           (values.qtc as number) + (values.edDiagnosis as number);
  },
  interpretations: [
    { range: [-3, -2], label: 'Très faible', description: 'Risque 0.4%. Sortie sûre.', color: 'green' },
    { range: [-1, 0], label: 'Faible', description: 'Risque 1.2%. Sortie possible.', color: 'green' },
    { range: [1, 3], label: 'Modéré', description: 'Risque 3-5%. Considérer observation.', color: 'yellow' },
    { range: [4, 5], label: 'Élevé', description: 'Risque 9%. Hospitalisation recommandée.', color: 'orange' },
    { range: [6, 11], label: 'Très élevé', description: 'Risque > 18%. Hospitalisation indiquée.', color: 'red' }
  ],
  source: 'Thiruganasambandamoorthy V et al. CMAJ 2016',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/27378464/'
};

export const cardiovascularScores: Calculator[] = [
  heartScore,
  cha2ds2vasc,
  hasbled,
  canadianSyncope
];
