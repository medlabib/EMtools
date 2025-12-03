// PE/DVT Scores

import type { Calculator } from './types';

export const wellsPE: Calculator = {
  id: 'wells-pe',
  name: 'Wells Criteria for Pulmonary Embolism',
  shortName: 'Wells EP',
  category: 'pe-dvt',
  description: 'Probabilité pré-test d\'embolie pulmonaire',
  fields: [
    { id: 'dvtSigns', label: 'Signes cliniques de TVP (œdème MI, douleur à la palpation)', type: 'checkbox' },
    { id: 'alternative', label: 'EP est le diagnostic le plus probable', type: 'checkbox' },
    { id: 'hr100', label: 'Fréquence cardiaque > 100/min', type: 'checkbox' },
    { id: 'immobilization', label: 'Immobilisation ≥ 3 jours OU chirurgie < 4 semaines', type: 'checkbox' },
    { id: 'previousPE', label: 'Antécédent d\'EP ou TVP', type: 'checkbox' },
    { id: 'hemoptysis', label: 'Hémoptysie', type: 'checkbox' },
    { id: 'malignancy', label: 'Cancer (traitement actif, < 6 mois, palliatif)', type: 'checkbox' }
  ],
  calculate: (values) => {
    let score = 0;
    if (values.dvtSigns) score += 3;
    if (values.alternative) score += 3;
    if (values.hr100) score += 1.5;
    if (values.immobilization) score += 1.5;
    if (values.previousPE) score += 1.5;
    if (values.hemoptysis) score += 1;
    if (values.malignancy) score += 1;
    return score;
  },
  interpretations: [
    { range: [0, 1], label: 'Faible', description: 'Probabilité EP 1.3%. Appliquer PERC si applicable.', color: 'green' },
    { range: [1.5, 4], label: 'Intermédiaire', description: 'Probabilité EP 16%. D-dimères indiqués.', color: 'yellow' },
    { range: [4.5, 12.5], label: 'Élevé', description: 'Probabilité EP 38%. Angioscanner thoracique.', color: 'red' }
  ],
  source: 'Wells PS et al. Thromb Haemost 2000',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/10744147/'
};

export const percRule: Calculator = {
  id: 'perc',
  name: 'PERC Rule (PE Rule-out Criteria)',
  shortName: 'PERC',
  category: 'pe-dvt',
  description: 'Exclure l\'EP sans examens chez patients à faible risque',
  fields: [
    { id: 'age50', label: 'Âge ≥ 50 ans', type: 'checkbox' },
    { id: 'hr100', label: 'Fréquence cardiaque ≥ 100/min', type: 'checkbox' },
    { id: 'spo2', label: 'SpO2 < 95% en air ambiant', type: 'checkbox' },
    { id: 'hemoptysis', label: 'Hémoptysie', type: 'checkbox' },
    { id: 'estrogen', label: 'Prise d\'œstrogènes', type: 'checkbox' },
    { id: 'surgery', label: 'Chirurgie/traumatisme < 4 semaines', type: 'checkbox' },
    { id: 'previousPE', label: 'Antécédent d\'EP ou TVP', type: 'checkbox' },
    { id: 'legSwelling', label: 'Œdème unilatéral du membre inférieur', type: 'checkbox' }
  ],
  calculate: (values) => {
    let count = 0;
    if (values.age50) count++;
    if (values.hr100) count++;
    if (values.spo2) count++;
    if (values.hemoptysis) count++;
    if (values.estrogen) count++;
    if (values.surgery) count++;
    if (values.previousPE) count++;
    if (values.legSwelling) count++;
    return count;
  },
  interpretations: [
    { range: [0, 0], label: 'PERC négatif', description: 'EP exclue (< 2% risque). Pas de bilan complémentaire.', color: 'green' },
    { range: [1, 8], label: 'PERC positif', description: 'Ne permet pas d\'exclure l\'EP. Poursuivre le bilan.', color: 'orange' }
  ],
  source: 'Kline JA et al. J Thromb Haemost 2004',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/15304025/'
};

export const genevaRevised: Calculator = {
  id: 'geneva-revised',
  name: 'Revised Geneva Score',
  shortName: 'Geneva',
  category: 'pe-dvt',
  description: 'Score objectif de probabilité d\'EP (sans jugement clinique subjectif)',
  fields: [
    {
      id: 'age',
      label: 'Âge > 65 ans',
      type: 'checkbox'
    },
    { id: 'previousPE', label: 'Antécédent de TVP ou EP', type: 'checkbox' },
    { id: 'surgery', label: 'Chirurgie ou fracture < 1 mois', type: 'checkbox' },
    { id: 'malignancy', label: 'Cancer actif ou rémission < 1 an', type: 'checkbox' },
    { id: 'legPain', label: 'Douleur unilatérale du membre inférieur', type: 'checkbox' },
    { id: 'hemoptysis', label: 'Hémoptysie', type: 'checkbox' },
    {
      id: 'hr',
      label: 'Fréquence cardiaque',
      type: 'select',
      options: [
        { value: 0, label: '< 75/min' },
        { value: 3, label: '75-94/min' },
        { value: 5, label: '≥ 95/min' }
      ]
    },
    { id: 'legEdema', label: 'Œdème et douleur à la palpation du MI', type: 'checkbox' }
  ],
  calculate: (values) => {
    let score = 0;
    if (values.age) score += 1;
    if (values.previousPE) score += 3;
    if (values.surgery) score += 2;
    if (values.malignancy) score += 2;
    if (values.legPain) score += 3;
    if (values.hemoptysis) score += 2;
    score += values.hr as number;
    if (values.legEdema) score += 4;
    return score;
  },
  interpretations: [
    { range: [0, 3], label: 'Faible', description: 'Probabilité EP 8%. D-dimères indiqués.', color: 'green' },
    { range: [4, 10], label: 'Intermédiaire', description: 'Probabilité EP 29%. D-dimères ou angioscanner.', color: 'yellow' },
    { range: [11, 25], label: 'Élevé', description: 'Probabilité EP 74%. Angioscanner direct.', color: 'red' }
  ],
  source: 'Le Gal G et al. Ann Intern Med 2006',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/16461963/'
};

export const spesi: Calculator = {
  id: 'spesi',
  name: 'Simplified PESI Score',
  shortName: 'sPESI',
  category: 'pe-dvt',
  description: 'Pronostic de l\'EP confirmée - Sélection pour traitement ambulatoire',
  fields: [
    { id: 'age80', label: 'Âge > 80 ans', type: 'checkbox' },
    { id: 'cancer', label: 'Cancer', type: 'checkbox' },
    { id: 'cardiopulmonary', label: 'Maladie cardiopulmonaire chronique', type: 'checkbox' },
    { id: 'hr110', label: 'Fréquence cardiaque ≥ 110/min', type: 'checkbox' },
    { id: 'sbp100', label: 'Pression systolique < 100 mmHg', type: 'checkbox' },
    { id: 'spo2', label: 'SpO2 < 90%', type: 'checkbox' }
  ],
  calculate: (values) => {
    let score = 0;
    if (values.age80) score += 1;
    if (values.cancer) score += 1;
    if (values.cardiopulmonary) score += 1;
    if (values.hr110) score += 1;
    if (values.sbp100) score += 1;
    if (values.spo2) score += 1;
    return score;
  },
  interpretations: [
    { range: [0, 0], label: 'Faible risque', description: 'Mortalité 30j 1%. Traitement ambulatoire possible.', color: 'green' },
    { range: [1, 6], label: 'Haut risque', description: 'Mortalité 30j 10.9%. Hospitalisation recommandée.', color: 'red' }
  ],
  source: 'Jiménez D et al. Arch Intern Med 2010',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/20696951/'
};

export const wellsDVT: Calculator = {
  id: 'wells-dvt',
  name: 'Wells Criteria for DVT',
  shortName: 'Wells TVP',
  category: 'pe-dvt',
  description: 'Probabilité pré-test de thrombose veineuse profonde',
  fields: [
    { id: 'cancer', label: 'Cancer actif (traitement < 6 mois ou palliatif)', type: 'checkbox' },
    { id: 'paralysis', label: 'Paralysie, parésie ou immobilisation plâtrée du MI', type: 'checkbox' },
    { id: 'bedridden', label: 'Alitement > 3 jours OU chirurgie majeure < 12 semaines', type: 'checkbox' },
    { id: 'tenderness', label: 'Sensibilité le long du trajet veineux profond', type: 'checkbox' },
    { id: 'legSwelling', label: 'Œdème de tout le membre inférieur', type: 'checkbox' },
    { id: 'calfSwelling', label: 'Mollet > 3 cm par rapport au côté asymptomatique', type: 'checkbox' },
    { id: 'pittingEdema', label: 'Œdème prenant le godet (plus important côté symptomatique)', type: 'checkbox' },
    { id: 'collateralVeins', label: 'Veines superficielles collatérales (non variqueuses)', type: 'checkbox' },
    { id: 'previousDVT', label: 'Antécédent documenté de TVP', type: 'checkbox' },
    { id: 'alternativeDiagnosis', label: 'Diagnostic alternatif au moins aussi probable que TVP', type: 'checkbox' }
  ],
  calculate: (values) => {
    let score = 0;
    if (values.cancer) score += 1;
    if (values.paralysis) score += 1;
    if (values.bedridden) score += 1;
    if (values.tenderness) score += 1;
    if (values.legSwelling) score += 1;
    if (values.calfSwelling) score += 1;
    if (values.pittingEdema) score += 1;
    if (values.collateralVeins) score += 1;
    if (values.previousDVT) score += 1;
    if (values.alternativeDiagnosis) score -= 2;
    return score;
  },
  interpretations: [
    { range: [-2, 0], label: 'Faible', description: 'Probabilité TVP 5%. D-dimères indiqués.', color: 'green' },
    { range: [1, 2], label: 'Modéré', description: 'Probabilité TVP 17%. D-dimères ou écho-doppler.', color: 'yellow' },
    { range: [3, 9], label: 'Élevé', description: 'Probabilité TVP 53%. Écho-doppler direct.', color: 'red' }
  ],
  source: 'Wells PS et al. Lancet 1997',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/9217107/'
};

export const peDvtScores: Calculator[] = [
  wellsPE,
  percRule,
  genevaRevised,
  spesi,
  wellsDVT
];
