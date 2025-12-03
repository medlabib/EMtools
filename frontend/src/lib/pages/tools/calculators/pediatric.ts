// Pediatric Scores

import type { Calculator } from './types';

export const pecarnHead: Calculator = {
  id: 'pecarn-head',
  name: 'PECARN Head CT Rule',
  shortName: 'PECARN',
  category: 'pediatric',
  description: 'Indication du scanner crânien chez l\'enfant après TC mineur',
  fields: [
    {
      id: 'ageGroup',
      label: 'Groupe d\'âge',
      type: 'select',
      options: [
        { value: 0, label: '< 2 ans' },
        { value: 1, label: '≥ 2 ans' }
      ]
    },
    { id: 'gcs14', label: 'GCS < 15', type: 'checkbox' },
    { id: 'alteredMental', label: 'Altération de l\'état mental (agitation, somnolence, questions répétitives, réponses lentes)', type: 'checkbox' },
    { id: 'baseFracture', label: 'Signes de fracture de la base du crâne', type: 'checkbox' },
    { id: 'palpableFracture', label: 'Fracture palpable du crâne (< 2 ans) / Signes de fracture (≥ 2 ans)', type: 'checkbox' },
    { id: 'hematoma', label: 'Hématome du cuir chevelu (occipital, pariétal ou temporal pour < 2 ans)', type: 'checkbox' },
    { id: 'lossOfConsciousness', label: 'Perte de connaissance ≥ 5 secondes', type: 'checkbox' },
    { id: 'severeMechanism', label: 'Mécanisme sévère (accident véhicule, chute > 0.9m si <2a ou >1.5m si ≥2a, objet à haute vélocité)', type: 'checkbox' },
    { id: 'notActingNormally', label: 'Comportement anormal selon les parents (< 2 ans)', type: 'checkbox' },
    { id: 'severeHeadache', label: 'Céphalées sévères (≥ 2 ans)', type: 'checkbox' },
    { id: 'vomiting', label: 'Vomissements (≥ 2 ans)', type: 'checkbox' }
  ],
  calculate: (values) => {
    const isUnder2 = values.ageGroup === 0;
    
    // High risk criteria (CT recommended)
    const highRisk = values.gcs14 || values.alteredMental || values.baseFracture || values.palpableFracture;
    
    // Intermediate risk criteria
    let intermediateRisk = false;
    if (isUnder2) {
      intermediateRisk = !!(values.hematoma || values.lossOfConsciousness || values.severeMechanism || values.notActingNormally);
    } else {
      intermediateRisk = !!(values.lossOfConsciousness || values.severeMechanism || values.severeHeadache || values.vomiting);
    }
    
    if (highRisk) return 2; // CT recommended
    if (intermediateRisk) return 1; // Observation vs CT
    return 0; // No CT needed
  },
  interpretations: [
    { range: [0, 0], label: 'Très faible risque', description: 'Risque lésion intracrânienne < 0.02%. Scanner NON indiqué.', color: 'green' },
    { range: [1, 1], label: 'Risque intermédiaire', description: 'Risque lésion 0.9%. Observation 4-6h OU scanner selon jugement clinique.', color: 'yellow' },
    { range: [2, 2], label: 'Haut risque', description: 'Risque lésion 4.4%. Scanner crânien RECOMMANDÉ.', color: 'red' }
  ],
  source: 'Kuppermann N et al. Lancet 2009',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/19758692/'
};

export const westleyCroup: Calculator = {
  id: 'westley-croup',
  name: 'Westley Croup Score',
  shortName: 'Westley',
  category: 'pediatric',
  description: 'Sévérité du croup (laryngo-trachéo-bronchite)',
  fields: [
    {
      id: 'stridor',
      label: 'Stridor',
      type: 'select',
      options: [
        { value: 0, label: 'Absent' },
        { value: 1, label: 'Au repos, avec stéthoscope' },
        { value: 2, label: 'Au repos, sans stéthoscope' }
      ]
    },
    {
      id: 'retraction',
      label: 'Tirage intercostal',
      type: 'select',
      options: [
        { value: 0, label: 'Absent' },
        { value: 1, label: 'Léger' },
        { value: 2, label: 'Modéré' },
        { value: 3, label: 'Sévère' }
      ]
    },
    {
      id: 'airEntry',
      label: 'Entrée d\'air',
      type: 'select',
      options: [
        { value: 0, label: 'Normale' },
        { value: 1, label: 'Diminuée' },
        { value: 2, label: 'Très diminuée' }
      ]
    },
    {
      id: 'cyanosis',
      label: 'Cyanose',
      type: 'select',
      options: [
        { value: 0, label: 'Absente' },
        { value: 4, label: 'À l\'agitation' },
        { value: 5, label: 'Au repos' }
      ]
    },
    {
      id: 'consciousness',
      label: 'Niveau de conscience',
      type: 'select',
      options: [
        { value: 0, label: 'Normal' },
        { value: 5, label: 'Altéré (désorienté)' }
      ]
    }
  ],
  calculate: (values) => {
    return Object.values(values).reduce((sum: number, val) => sum + (val as number || 0), 0);
  },
  interpretations: [
    { range: [0, 2], label: 'Léger', description: 'Croup léger. Traitement ambulatoire, corticoïdes PO.', color: 'green' },
    { range: [3, 5], label: 'Modéré', description: 'Croup modéré. Dexaméthasone + observation.', color: 'yellow' },
    { range: [6, 11], label: 'Sévère', description: 'Croup sévère. Épinéphrine nébulisée + hospitalisation.', color: 'orange' },
    { range: [12, 17], label: 'Insuffisance respiratoire', description: 'Insuffisance respiratoire imminente. Réanimation.', color: 'red' }
  ],
  source: 'Westley CR et al. Am J Dis Child 1978',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/308551/'
};

export const pas: Calculator = {
  id: 'pas',
  name: 'Pediatric Appendicitis Score (PAS)',
  shortName: 'PAS',
  category: 'pediatric',
  description: 'Probabilité d\'appendicite chez l\'enfant',
  fields: [
    { id: 'migration', label: 'Migration de la douleur vers la FID', type: 'checkbox' },
    { id: 'anorexia', label: 'Anorexie', type: 'checkbox' },
    { id: 'nausea', label: 'Nausées/Vomissements', type: 'checkbox' },
    { id: 'rlfTenderness', label: 'Sensibilité en FID', type: 'checkbox' },
    { id: 'coughPain', label: 'Douleur à la toux/percussion/sautillement', type: 'checkbox' },
    { id: 'fever', label: 'Fièvre (T° ≥ 38°C)', type: 'checkbox' },
    { id: 'leukocytosis', label: 'Leucocytose > 10 000/mm³', type: 'checkbox' },
    { id: 'neutrophilia', label: 'Polynucléose neutrophile (PNN > 75%)', type: 'checkbox' }
  ],
  calculate: (values) => {
    let score = 0;
    if (values.migration) score += 1;
    if (values.anorexia) score += 1;
    if (values.nausea) score += 1;
    if (values.rlfTenderness) score += 2;
    if (values.coughPain) score += 2;
    if (values.fever) score += 1;
    if (values.leukocytosis) score += 1;
    if (values.neutrophilia) score += 1;
    return score;
  },
  interpretations: [
    { range: [0, 3], label: 'Faible probabilité', description: 'Appendicite peu probable. Surveillance ou réévaluation.', color: 'green' },
    { range: [4, 6], label: 'Probabilité intermédiaire', description: 'Appendicite possible. Imagerie recommandée (échographie).', color: 'yellow' },
    { range: [7, 10], label: 'Haute probabilité', description: 'Appendicite probable. Avis chirurgical.', color: 'red' }
  ],
  source: 'Samuel M. J Pediatr Surg 2002',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/12149680/'
};

export const dehydration: Calculator = {
  id: 'clinical-dehydration-scale',
  name: 'Clinical Dehydration Scale (CDS)',
  shortName: 'CDS',
  category: 'pediatric',
  description: 'Évaluation de la déshydratation chez l\'enfant 1 mois - 5 ans',
  fields: [
    {
      id: 'appearance',
      label: 'Apparence générale',
      type: 'select',
      options: [
        { value: 0, label: 'Normale' },
        { value: 1, label: 'Assoiffé, agité ou léthargique mais irritable au toucher' },
        { value: 2, label: 'Somnolent, hypotonique, froid, sudation; ± comateux' }
      ]
    },
    {
      id: 'eyes',
      label: 'Yeux',
      type: 'select',
      options: [
        { value: 0, label: 'Normaux' },
        { value: 1, label: 'Légèrement enfoncés' },
        { value: 2, label: 'Très enfoncés' }
      ]
    },
    {
      id: 'mucous',
      label: 'Muqueuses (langue)',
      type: 'select',
      options: [
        { value: 0, label: 'Humides' },
        { value: 1, label: 'Collantes' },
        { value: 2, label: 'Sèches' }
      ]
    },
    {
      id: 'tears',
      label: 'Larmes',
      type: 'select',
      options: [
        { value: 0, label: 'Présentes' },
        { value: 1, label: 'Diminuées' },
        { value: 2, label: 'Absentes' }
      ]
    }
  ],
  calculate: (values) => {
    return Object.values(values).reduce((sum: number, val) => sum + (val as number || 0), 0);
  },
  interpretations: [
    { range: [0, 0], label: 'Pas de déshydratation', description: 'Hydratation normale. Réhydratation orale à domicile.', color: 'green' },
    { range: [1, 4], label: 'Légère à modérée', description: 'Déshydratation 3-6%. Réhydratation orale supervisée.', color: 'yellow' },
    { range: [5, 8], label: 'Modérée à sévère', description: 'Déshydratation > 6%. Réhydratation IV probable.', color: 'red' }
  ],
  source: 'Friedman JN et al. Pediatrics 2004',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/15520095/'
};

export const pediatricScores: Calculator[] = [
  pecarnHead,
  westleyCroup,
  pas,
  dehydration
];
