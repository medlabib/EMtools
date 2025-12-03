// GI Scores

import type { Calculator } from './types';

export const alvarado: Calculator = {
  id: 'alvarado',
  name: 'Alvarado Score (MANTRELS)',
  shortName: 'Alvarado',
  category: 'gi',
  description: 'Probabilité d\'appendicite aiguë',
  fields: [
    { id: 'migration', label: 'M - Migration de la douleur vers la FID', type: 'checkbox' },
    { id: 'anorexia', label: 'A - Anorexie', type: 'checkbox' },
    { id: 'nausea', label: 'N - Nausées/Vomissements', type: 'checkbox' },
    { id: 'tenderness', label: 'T - Sensibilité en FID', type: 'checkbox' },
    { id: 'rebound', label: 'R - Rebond (douleur à la décompression)', type: 'checkbox' },
    { id: 'elevation', label: 'E - Élévation de la température (> 37.5°C)', type: 'checkbox' },
    { id: 'leukocytosis', label: 'L - Leucocytose (> 10 000/mm³)', type: 'checkbox' },
    { id: 'shift', label: 'S - Shift (polynucléose > 75%)', type: 'checkbox' }
  ],
  calculate: (values) => {
    let score = 0;
    if (values.migration) score += 1;
    if (values.anorexia) score += 1;
    if (values.nausea) score += 1;
    if (values.tenderness) score += 2;
    if (values.rebound) score += 1;
    if (values.elevation) score += 1;
    if (values.leukocytosis) score += 2;
    if (values.shift) score += 1;
    return score;
  },
  interpretations: [
    { range: [0, 4], label: 'Faible probabilité', description: 'Appendicite peu probable. Surveillance ou sortie.', color: 'green' },
    { range: [5, 6], label: 'Probabilité intermédiaire', description: 'Appendicite possible. Imagerie (échographie/TDM).', color: 'yellow' },
    { range: [7, 8], label: 'Probabilité élevée', description: 'Appendicite probable. Avis chirurgical.', color: 'orange' },
    { range: [9, 10], label: 'Très haute probabilité', description: 'Appendicite très probable. Chirurgie.', color: 'red' }
  ],
  source: 'Alvarado A. Ann Emerg Med 1986',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/3963537/'
};

export const bisap: Calculator = {
  id: 'bisap',
  name: 'BISAP Score',
  shortName: 'BISAP',
  category: 'gi',
  description: 'Pronostic de la pancréatite aiguë dans les 24 premières heures',
  fields: [
    { id: 'bun', label: 'B - BUN/Urée > 25 mg/dL (8.9 mmol/L)', type: 'checkbox' },
    { id: 'impaired', label: 'I - Altération de l\'état mental (Glasgow < 15)', type: 'checkbox' },
    { id: 'sirs', label: 'S - SIRS (≥ 2 critères)', type: 'checkbox' },
    { id: 'age', label: 'A - Âge > 60 ans', type: 'checkbox' },
    { id: 'pleural', label: 'P - Épanchement pleural', type: 'checkbox' }
  ],
  calculate: (values) => {
    let score = 0;
    if (values.bun) score += 1;
    if (values.impaired) score += 1;
    if (values.sirs) score += 1;
    if (values.age) score += 1;
    if (values.pleural) score += 1;
    return score;
  },
  interpretations: [
    { range: [0, 0], label: 'Score 0', description: 'Mortalité < 1%.', color: 'green' },
    { range: [1, 1], label: 'Score 1', description: 'Mortalité < 2%.', color: 'green' },
    { range: [2, 2], label: 'Score 2', description: 'Mortalité 2-5%. Surveillance étroite.', color: 'yellow' },
    { range: [3, 3], label: 'Score 3', description: 'Mortalité 5-20%. Réanimation probable.', color: 'orange' },
    { range: [4, 5], label: 'Score 4-5', description: 'Mortalité > 20%. Réanimation.', color: 'red' }
  ],
  source: 'Wu BU et al. Gut 2008',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/18703447/'
};

export const glasgowBlatchford: Calculator = {
  id: 'glasgow-blatchford',
  name: 'Glasgow-Blatchford Score',
  shortName: 'GBS',
  category: 'gi',
  description: 'Nécessité d\'intervention en cas d\'hémorragie digestive haute',
  fields: [
    {
      id: 'bun',
      label: 'Urée sanguine (mmol/L)',
      type: 'select',
      options: [
        { value: 0, label: '< 6.5' },
        { value: 2, label: '6.5-7.9' },
        { value: 3, label: '8.0-9.9' },
        { value: 4, label: '10.0-24.9' },
        { value: 6, label: '≥ 25' }
      ]
    },
    {
      id: 'hbMen',
      label: 'Hémoglobine - Homme (g/dL)',
      type: 'select',
      options: [
        { value: 0, label: '≥ 13' },
        { value: 1, label: '12.0-12.9' },
        { value: 3, label: '10.0-11.9' },
        { value: 6, label: '< 10' }
      ]
    },
    {
      id: 'hbWomen',
      label: 'Hémoglobine - Femme (g/dL)',
      type: 'select',
      options: [
        { value: 0, label: '≥ 12' },
        { value: 1, label: '10.0-11.9' },
        { value: 6, label: '< 10' }
      ]
    },
    {
      id: 'sbp',
      label: 'Pression systolique (mmHg)',
      type: 'select',
      options: [
        { value: 0, label: '≥ 110' },
        { value: 1, label: '100-109' },
        { value: 2, label: '90-99' },
        { value: 3, label: '< 90' }
      ]
    },
    { id: 'pulse', label: 'Pouls ≥ 100/min', type: 'checkbox' },
    { id: 'melena', label: 'Méléna', type: 'checkbox' },
    { id: 'syncope', label: 'Syncope', type: 'checkbox' },
    { id: 'liver', label: 'Hépatopathie connue', type: 'checkbox' },
    { id: 'heart', label: 'Insuffisance cardiaque connue', type: 'checkbox' }
  ],
  calculate: (values) => {
    let score = 0;
    score += (values.bun as number) || 0;
    // Use max of men/women Hb scores
    const hbScore = Math.max((values.hbMen as number) || 0, (values.hbWomen as number) || 0);
    score += hbScore;
    score += (values.sbp as number) || 0;
    if (values.pulse) score += 1;
    if (values.melena) score += 1;
    if (values.syncope) score += 2;
    if (values.liver) score += 2;
    if (values.heart) score += 2;
    return score;
  },
  interpretations: [
    { range: [0, 0], label: 'Très faible risque', description: 'Score 0: sortie ambulatoire possible. VPN 100% pour intervention.', color: 'green' },
    { range: [1, 2], label: 'Faible risque', description: 'Faible probabilité d\'intervention. Surveillance.', color: 'green' },
    { range: [3, 5], label: 'Risque intermédiaire', description: 'Intervention possible. Hospitalisation.', color: 'yellow' },
    { range: [6, 11], label: 'Haut risque', description: 'Intervention probable. FOGD urgente.', color: 'orange' },
    { range: [12, 23], label: 'Très haut risque', description: 'Intervention très probable. Réanimation/transfusion.', color: 'red' }
  ],
  source: 'Blatchford O et al. Lancet 2000',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/11073017/'
};

export const rockall: Calculator = {
  id: 'rockall',
  name: 'Rockall Score',
  shortName: 'Rockall',
  category: 'gi',
  description: 'Risque de récidive hémorragique et mortalité après hémorragie digestive haute',
  fields: [
    {
      id: 'age',
      label: 'Âge',
      type: 'select',
      options: [
        { value: 0, label: '< 60 ans' },
        { value: 1, label: '60-79 ans' },
        { value: 2, label: '≥ 80 ans' }
      ]
    },
    {
      id: 'shock',
      label: 'État de choc',
      type: 'select',
      options: [
        { value: 0, label: 'Pas de choc (PAS ≥ 100, FC < 100)' },
        { value: 1, label: 'Tachycardie (PAS ≥ 100, FC ≥ 100)' },
        { value: 2, label: 'Hypotension (PAS < 100)' }
      ]
    },
    {
      id: 'comorbidity',
      label: 'Comorbidités',
      type: 'select',
      options: [
        { value: 0, label: 'Aucune' },
        { value: 2, label: 'Insuffisance cardiaque, coronaropathie, autre majeure' },
        { value: 3, label: 'Insuffisance rénale, hépatique, cancer métastatique' }
      ]
    },
    {
      id: 'diagnosis',
      label: 'Diagnostic endoscopique',
      type: 'select',
      options: [
        { value: 0, label: 'Mallory-Weiss, pas de lésion, pas de stigmates' },
        { value: 1, label: 'Tous les autres diagnostics' },
        { value: 2, label: 'Cancer digestif haut' }
      ]
    },
    {
      id: 'stigmata',
      label: 'Stigmates de saignement récent',
      type: 'select',
      options: [
        { value: 0, label: 'Aucun ou tache pigmentée' },
        { value: 2, label: 'Sang, caillot adhérent, vaisseau visible, saignement actif' }
      ]
    }
  ],
  calculate: (values) => {
    return Object.values(values).reduce((sum: number, val) => sum + (val as number || 0), 0);
  },
  interpretations: [
    { range: [0, 2], label: 'Faible risque', description: 'Mortalité < 5%. Sortie précoce possible.', color: 'green' },
    { range: [3, 4], label: 'Risque intermédiaire', description: 'Mortalité 11%. Hospitalisation.', color: 'yellow' },
    { range: [5, 6], label: 'Haut risque', description: 'Mortalité 25%. Surveillance étroite.', color: 'orange' },
    { range: [7, 11], label: 'Très haut risque', description: 'Mortalité > 40%. Réanimation.', color: 'red' }
  ],
  source: 'Rockall TA et al. Gut 1996',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/8707114/'
};

export const giScores: Calculator[] = [
  alvarado,
  bisap,
  glasgowBlatchford,
  rockall
];
