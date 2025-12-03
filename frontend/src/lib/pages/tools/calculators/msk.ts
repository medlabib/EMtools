// MSK Rules (Orthopedic Decision Rules)

import type { Calculator } from './types';

export const ottawaAnkle: Calculator = {
  id: 'ottawa-ankle',
  name: 'Ottawa Ankle Rules',
  shortName: 'Ottawa Cheville',
  category: 'msk',
  description: 'Indication de radiographie après traumatisme de la cheville',
  fields: [
    { id: 'bonePostMalleolus', label: 'Douleur osseuse sur les 6 cm postérieurs de la malléole externe', type: 'checkbox' },
    { id: 'boneMedialMalleolus', label: 'Douleur osseuse sur les 6 cm postérieurs de la malléole interne', type: 'checkbox' },
    { id: 'boneBaseMetatarsal', label: 'Douleur osseuse sur la base du 5ème métatarsien', type: 'checkbox' },
    { id: 'boneNavicular', label: 'Douleur osseuse sur l\'os naviculaire', type: 'checkbox' },
    { id: 'unableToWalk', label: 'Incapable de faire 4 pas immédiatement et aux urgences', type: 'checkbox' }
  ],
  calculate: (values) => {
    const anklePositive = values.bonePostMalleolus || values.boneMedialMalleolus || values.unableToWalk;
    const footPositive = values.boneBaseMetatarsal || values.boneNavicular || values.unableToWalk;
    
    if (anklePositive || footPositive) return 1;
    return 0;
  },
  interpretations: [
    { range: [0, 0], label: 'Règle négative', description: 'Radiographie NON indiquée. Sensibilité ~100% pour fracture significative.', color: 'green' },
    { range: [1, 1], label: 'Règle positive', description: 'Radiographie indiquée (cheville et/ou pied selon critères).', color: 'yellow' }
  ],
  source: 'Stiell IG et al. JAMA 1993',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/8411587/'
};

export const ottawaKnee: Calculator = {
  id: 'ottawa-knee',
  name: 'Ottawa Knee Rules',
  shortName: 'Ottawa Genou',
  category: 'msk',
  description: 'Indication de radiographie après traumatisme du genou',
  fields: [
    { id: 'age55', label: 'Âge ≥ 55 ans', type: 'checkbox' },
    { id: 'fibulaHead', label: 'Douleur isolée sur la tête du péroné', type: 'checkbox' },
    { id: 'patella', label: 'Douleur isolée sur la rotule', type: 'checkbox' },
    { id: 'unableFlex90', label: 'Incapacité de fléchir le genou à 90°', type: 'checkbox' },
    { id: 'unableToWalk', label: 'Incapable de faire 4 pas immédiatement et aux urgences', type: 'checkbox' }
  ],
  calculate: (values) => {
    const positive = values.age55 || values.fibulaHead || values.patella || 
                     values.unableFlex90 || values.unableToWalk;
    return positive ? 1 : 0;
  },
  interpretations: [
    { range: [0, 0], label: 'Règle négative', description: 'Radiographie NON indiquée. Sensibilité ~100% pour fracture.', color: 'green' },
    { range: [1, 1], label: 'Règle positive', description: 'Radiographie du genou indiquée.', color: 'yellow' }
  ],
  source: 'Stiell IG et al. Ann Emerg Med 1995',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/7864338/'
};

export const nexusCSpine: Calculator = {
  id: 'nexus-c-spine',
  name: 'NEXUS C-Spine Rule',
  shortName: 'NEXUS',
  category: 'msk',
  description: 'Exclusion de lésion du rachis cervical sans imagerie',
  fields: [
    { id: 'focalDeficit', label: 'Déficit neurologique focal', type: 'checkbox' },
    { id: 'midlineSpinal', label: 'Douleur médiane du rachis cervical', type: 'checkbox' },
    { id: 'alteredConsciousness', label: 'Altération de la conscience', type: 'checkbox' },
    { id: 'intoxication', label: 'Intoxication', type: 'checkbox' },
    { id: 'distractingInjury', label: 'Lésion distractrice douloureuse', type: 'checkbox' }
  ],
  calculate: (values) => {
    const positive = values.focalDeficit || values.midlineSpinal || 
                     values.alteredConsciousness || values.intoxication || 
                     values.distractingInjury;
    return positive ? 1 : 0;
  },
  interpretations: [
    { range: [0, 0], label: 'Règle négative', description: 'Lésion cervicale cliniquement exclue. Pas d\'imagerie nécessaire.', color: 'green' },
    { range: [1, 1], label: 'Règle positive', description: 'Imagerie du rachis cervical indiquée.', color: 'yellow' }
  ],
  source: 'Hoffman JR et al. N Engl J Med 2000',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/10891517/'
};

export const canadianCSpine: Calculator = {
  id: 'canadian-c-spine',
  name: 'Canadian C-Spine Rule',
  shortName: 'C-Spine Canadien',
  category: 'msk',
  description: 'Indication d\'imagerie du rachis cervical après traumatisme',
  fields: [
    {
      id: 'highRiskFactor',
      label: 'Facteur de haut risque (un seul suffit)',
      type: 'select',
      options: [
        { value: 0, label: 'Aucun facteur de haut risque' },
        { value: 1, label: 'Âge ≥ 65 ans' },
        { value: 1, label: 'Mécanisme dangereux' },
        { value: 1, label: 'Paresthésies des extrémités' }
      ]
    },
    {
      id: 'lowRiskFactor',
      label: 'Facteur de faible risque (permet évaluation mobilité)',
      type: 'select',
      options: [
        { value: 0, label: 'Aucun facteur de faible risque' },
        { value: 1, label: 'AVP simple (arrière, basse vitesse, impact latéral)' },
        { value: 1, label: 'Position assise aux urgences' },
        { value: 1, label: 'Patient ambulatoire' },
        { value: 1, label: 'Douleur cervicale retardée' },
        { value: 1, label: 'Absence de douleur médiane' }
      ]
    },
    { id: 'canRotate45', label: 'Peut tourner le cou de 45° à gauche ET à droite', type: 'checkbox' }
  ],
  calculate: (values) => {
    // High risk = radiographie nécessaire
    if (values.highRiskFactor === 1) return 2;
    
    // No low risk factor = cannot assess rotation = radiographie
    if (values.lowRiskFactor === 0) return 2;
    
    // Low risk present, can we test rotation?
    if (values.canRotate45) return 0; // No imaging needed
    
    return 1; // Cannot rotate = imaging needed
  },
  interpretations: [
    { range: [0, 0], label: 'Règle négative', description: 'Pas d\'imagerie nécessaire. Retrait du collier cervical.', color: 'green' },
    { range: [1, 1], label: 'Mobilité impossible', description: 'Incapable de tourner le cou. Imagerie indiquée.', color: 'yellow' },
    { range: [2, 2], label: 'Haut risque', description: 'Imagerie du rachis cervical OBLIGATOIRE.', color: 'red' }
  ],
  source: 'Stiell IG et al. JAMA 2001',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/11594897/'
};

export const mskScores: Calculator[] = [
  ottawaAnkle,
  ottawaKnee,
  nexusCSpine,
  canadianCSpine
];
