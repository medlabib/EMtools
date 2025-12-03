// Sepsis & Infection Scores

import type { Calculator } from './types';

export const qsofa: Calculator = {
  id: 'qsofa',
  name: 'qSOFA Score',
  shortName: 'qSOFA',
  category: 'sepsis',
  description: 'Dépistage rapide du risque de sepsis hors réanimation',
  fields: [
    { id: 'rr22', label: 'Fréquence respiratoire ≥ 22/min', type: 'checkbox' },
    { id: 'gcs15', label: 'Altération de l\'état mental (Glasgow < 15)', type: 'checkbox' },
    { id: 'sbp100', label: 'Pression artérielle systolique ≤ 100 mmHg', type: 'checkbox' }
  ],
  calculate: (values) => {
    let score = 0;
    if (values.rr22) score += 1;
    if (values.gcs15) score += 1;
    if (values.sbp100) score += 1;
    return score;
  },
  interpretations: [
    { range: [0, 1], label: 'Faible risque', description: 'Mortalité hospitalière < 3%. Surveiller.', color: 'green' },
    { range: [2, 3], label: 'Haut risque', description: 'Mortalité hospitalière 10-24%. Rechercher dysfonction d\'organe (SOFA).', color: 'red' }
  ],
  source: 'Singer M et al. JAMA 2016 (Sepsis-3)',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/26903338/'
};

export const news2: Calculator = {
  id: 'news2',
  name: 'NEWS2 Score',
  shortName: 'NEWS2',
  category: 'sepsis',
  description: 'Score d\'alerte précoce - Détection de la détérioration clinique',
  fields: [
    {
      id: 'rr',
      label: 'Fréquence respiratoire',
      type: 'select',
      options: [
        { value: 3, label: '≤ 8/min' },
        { value: 1, label: '9-11/min' },
        { value: 0, label: '12-20/min' },
        { value: 2, label: '21-24/min' },
        { value: 3, label: '≥ 25/min' }
      ]
    },
    {
      id: 'spo2',
      label: 'SpO2 (Échelle 1 - standard)',
      type: 'select',
      options: [
        { value: 3, label: '≤ 91%' },
        { value: 2, label: '92-93%' },
        { value: 1, label: '94-95%' },
        { value: 0, label: '≥ 96%' }
      ]
    },
    { id: 'o2', label: 'Oxygène supplémentaire', type: 'checkbox' },
    {
      id: 'sbp',
      label: 'Pression systolique',
      type: 'select',
      options: [
        { value: 3, label: '≤ 90 mmHg' },
        { value: 2, label: '91-100 mmHg' },
        { value: 1, label: '101-110 mmHg' },
        { value: 0, label: '111-219 mmHg' },
        { value: 3, label: '≥ 220 mmHg' }
      ]
    },
    {
      id: 'hr',
      label: 'Fréquence cardiaque',
      type: 'select',
      options: [
        { value: 3, label: '≤ 40/min' },
        { value: 1, label: '41-50/min' },
        { value: 0, label: '51-90/min' },
        { value: 1, label: '91-110/min' },
        { value: 2, label: '111-130/min' },
        { value: 3, label: '≥ 131/min' }
      ]
    },
    {
      id: 'consciousness',
      label: 'État de conscience (ACVPU)',
      type: 'select',
      options: [
        { value: 0, label: 'A - Alerte' },
        { value: 3, label: 'C - Confusion nouvelle' },
        { value: 3, label: 'V - Répond à la voix' },
        { value: 3, label: 'P - Répond à la douleur' },
        { value: 3, label: 'U - Non répondant' }
      ]
    },
    {
      id: 'temp',
      label: 'Température',
      type: 'select',
      options: [
        { value: 3, label: '≤ 35.0°C' },
        { value: 1, label: '35.1-36.0°C' },
        { value: 0, label: '36.1-38.0°C' },
        { value: 1, label: '38.1-39.0°C' },
        { value: 2, label: '≥ 39.1°C' }
      ]
    }
  ],
  calculate: (values) => {
    let score = 0;
    score += (values.rr as number) || 0;
    score += (values.spo2 as number) || 0;
    if (values.o2) score += 2;
    score += (values.sbp as number) || 0;
    score += (values.hr as number) || 0;
    score += (values.consciousness as number) || 0;
    score += (values.temp as number) || 0;
    return score;
  },
  interpretations: [
    { range: [0, 0], label: 'Faible', description: 'Surveillance de routine.', color: 'green' },
    { range: [1, 4], label: 'Faible-Moyen', description: 'Surveillance accrue. Réévaluer dans 4-6h.', color: 'yellow' },
    { range: [5, 6], label: 'Moyen', description: 'Réponse urgente. Évaluation clinicien senior.', color: 'orange' },
    { range: [7, 20], label: 'Élevé', description: 'Réponse d\'urgence immédiate. Équipe réanimation.', color: 'red' }
  ],
  source: 'Royal College of Physicians 2017',
  sourceUrl: 'https://www.rcplondon.ac.uk/projects/outputs/national-early-warning-score-news-2'
};

export const curb65: Calculator = {
  id: 'curb65',
  name: 'CURB-65 Score',
  shortName: 'CURB-65',
  category: 'sepsis',
  description: 'Sévérité de la pneumonie communautaire et orientation',
  fields: [
    { id: 'confusion', label: 'C - Confusion nouvelle', type: 'checkbox' },
    { id: 'urea', label: 'U - Urée > 7 mmol/L (0.42 g/L)', type: 'checkbox' },
    { id: 'rr30', label: 'R - Fréquence respiratoire ≥ 30/min', type: 'checkbox' },
    { id: 'bp', label: 'B - TA systolique < 90 mmHg OU diastolique ≤ 60 mmHg', type: 'checkbox' },
    { id: 'age65', label: '65 - Âge ≥ 65 ans', type: 'checkbox' }
  ],
  calculate: (values) => {
    let score = 0;
    if (values.confusion) score += 1;
    if (values.urea) score += 1;
    if (values.rr30) score += 1;
    if (values.bp) score += 1;
    if (values.age65) score += 1;
    return score;
  },
  interpretations: [
    { range: [0, 1], label: 'Faible mortalité', description: 'Mortalité < 3%. Traitement ambulatoire possible.', color: 'green' },
    { range: [2, 2], label: 'Mortalité intermédiaire', description: 'Mortalité 9%. Hospitalisation courte ou surveillance rapprochée.', color: 'yellow' },
    { range: [3, 5], label: 'Haute mortalité', description: 'Mortalité 15-40%. Hospitalisation, envisager réanimation si ≥4.', color: 'red' }
  ],
  source: 'Lim WS et al. Thorax 2003',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/12728155/'
};

export const lrinec: Calculator = {
  id: 'lrinec',
  name: 'LRINEC Score',
  shortName: 'LRINEC',
  category: 'sepsis',
  description: 'Différencier fasciite nécrosante des autres infections cutanées',
  fields: [
    {
      id: 'crp',
      label: 'CRP (mg/L)',
      type: 'select',
      options: [
        { value: 0, label: '< 150' },
        { value: 4, label: '≥ 150' }
      ]
    },
    {
      id: 'wbc',
      label: 'Leucocytes (×10⁹/L)',
      type: 'select',
      options: [
        { value: 0, label: '< 15' },
        { value: 1, label: '15-25' },
        { value: 2, label: '> 25' }
      ]
    },
    {
      id: 'hb',
      label: 'Hémoglobine (g/dL)',
      type: 'select',
      options: [
        { value: 0, label: '> 13.5' },
        { value: 1, label: '11-13.5' },
        { value: 2, label: '< 11' }
      ]
    },
    {
      id: 'sodium',
      label: 'Sodium (mmol/L)',
      type: 'select',
      options: [
        { value: 0, label: '≥ 135' },
        { value: 2, label: '< 135' }
      ]
    },
    {
      id: 'creatinine',
      label: 'Créatinine (µmol/L)',
      type: 'select',
      options: [
        { value: 0, label: '≤ 141' },
        { value: 2, label: '> 141' }
      ]
    },
    {
      id: 'glucose',
      label: 'Glycémie (mmol/L)',
      type: 'select',
      options: [
        { value: 0, label: '≤ 10' },
        { value: 1, label: '> 10' }
      ]
    }
  ],
  calculate: (values) => {
    let score = 0;
    score += (values.crp as number) || 0;
    score += (values.wbc as number) || 0;
    score += (values.hb as number) || 0;
    score += (values.sodium as number) || 0;
    score += (values.creatinine as number) || 0;
    score += (values.glucose as number) || 0;
    return score;
  },
  interpretations: [
    { range: [0, 5], label: 'Faible risque', description: 'Probabilité de fasciite nécrosante < 50%.', color: 'green' },
    { range: [6, 7], label: 'Risque intermédiaire', description: 'Probabilité de fasciite nécrosante 50-75%. Imagerie urgente.', color: 'yellow' },
    { range: [8, 13], label: 'Haut risque', description: 'Probabilité de fasciite nécrosante > 75%. Exploration chirurgicale urgente.', color: 'red' }
  ],
  source: 'Wong CH et al. Crit Care Med 2004',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/15241098/'
};

export const centor: Calculator = {
  id: 'centor',
  name: 'Centor Criteria (Modified)',
  shortName: 'Centor',
  category: 'sepsis',
  description: 'Probabilité d\'angine streptococcique (SGA)',
  fields: [
    { id: 'exudate', label: 'Exsudat ou gonflement amygdalien', type: 'checkbox' },
    { id: 'adenopathy', label: 'Adénopathies cervicales antérieures sensibles', type: 'checkbox' },
    { id: 'fever', label: 'Fièvre (T° > 38°C) ou histoire de fièvre', type: 'checkbox' },
    { id: 'noCough', label: 'Absence de toux', type: 'checkbox' },
    {
      id: 'age',
      label: 'Âge',
      type: 'select',
      options: [
        { value: 1, label: '3-14 ans' },
        { value: 0, label: '15-44 ans' },
        { value: -1, label: '≥ 45 ans' }
      ]
    }
  ],
  calculate: (values) => {
    let score = 0;
    if (values.exudate) score += 1;
    if (values.adenopathy) score += 1;
    if (values.fever) score += 1;
    if (values.noCough) score += 1;
    score += (values.age as number) || 0;
    return score;
  },
  interpretations: [
    { range: [-1, 0], label: 'Très faible', description: 'Probabilité SGA 1-2.5%. Pas d\'ATB ni TDR.', color: 'green' },
    { range: [1, 1], label: 'Faible', description: 'Probabilité SGA 5-10%. TDR optionnel.', color: 'green' },
    { range: [2, 3], label: 'Modéré', description: 'Probabilité SGA 11-35%. TDR recommandé.', color: 'yellow' },
    { range: [4, 5], label: 'Élevé', description: 'Probabilité SGA 51-53%. TDR ou ATB empirique.', color: 'red' }
  ],
  source: 'McIsaac WJ et al. CMAJ 2000',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/10680463/'
};

export const sepsisScores: Calculator[] = [
  qsofa,
  news2,
  curb65,
  lrinec,
  centor
];
