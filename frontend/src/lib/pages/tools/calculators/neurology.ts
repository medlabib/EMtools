// Neurology Scores

import type { Calculator } from './types';

export const nihss: Calculator = {
  id: 'nihss',
  name: 'NIH Stroke Scale',
  shortName: 'NIHSS',
  category: 'neurology',
  description: 'Sévérité de l\'AVC ischémique et éligibilité à la thrombolyse',
  fields: [
    {
      id: 'consciousness',
      label: '1a. Niveau de conscience',
      type: 'select',
      options: [
        { value: 0, label: '0 - Éveillé, réactif' },
        { value: 1, label: '1 - Non éveillé mais réveillable' },
        { value: 2, label: '2 - Non éveillé, réponses réflexes' },
        { value: 3, label: '3 - Coma, réponses réflexes absentes' }
      ]
    },
    {
      id: 'questions',
      label: '1b. Questions (mois, âge)',
      type: 'select',
      options: [
        { value: 0, label: '0 - Répond correctement aux deux' },
        { value: 1, label: '1 - Répond correctement à une seule' },
        { value: 2, label: '2 - Aucune réponse correcte' }
      ]
    },
    {
      id: 'commands',
      label: '1c. Ordres (ouvrir/fermer yeux, serrer main)',
      type: 'select',
      options: [
        { value: 0, label: '0 - Exécute correctement les deux' },
        { value: 1, label: '1 - Exécute correctement un seul' },
        { value: 2, label: '2 - N\'exécute aucun ordre' }
      ]
    },
    {
      id: 'gaze',
      label: '2. Oculomotricité (regard horizontal)',
      type: 'select',
      options: [
        { value: 0, label: '0 - Normal' },
        { value: 1, label: '1 - Paralysie partielle du regard' },
        { value: 2, label: '2 - Déviation forcée ou paralysie totale' }
      ]
    },
    {
      id: 'visual',
      label: '3. Champ visuel',
      type: 'select',
      options: [
        { value: 0, label: '0 - Normal' },
        { value: 1, label: '1 - Hémianopsie partielle' },
        { value: 2, label: '2 - Hémianopsie complète' },
        { value: 3, label: '3 - Cécité bilatérale' }
      ]
    },
    {
      id: 'facialPalsy',
      label: '4. Paralysie faciale',
      type: 'select',
      options: [
        { value: 0, label: '0 - Absente' },
        { value: 1, label: '1 - Mineure (effacement sillon)' },
        { value: 2, label: '2 - Partielle (inférieure)' },
        { value: 3, label: '3 - Complète (supérieure et inférieure)' }
      ]
    },
    {
      id: 'motorArmLeft',
      label: '5a. Motricité bras gauche',
      type: 'select',
      options: [
        { value: 0, label: '0 - Maintient 10 sec' },
        { value: 1, label: '1 - Chute en < 10 sec sans toucher le lit' },
        { value: 2, label: '2 - Effort contre pesanteur mais chute' },
        { value: 3, label: '3 - Pas d\'effort contre pesanteur' },
        { value: 4, label: '4 - Aucun mouvement' }
      ]
    },
    {
      id: 'motorArmRight',
      label: '5b. Motricité bras droit',
      type: 'select',
      options: [
        { value: 0, label: '0 - Maintient 10 sec' },
        { value: 1, label: '1 - Chute en < 10 sec sans toucher le lit' },
        { value: 2, label: '2 - Effort contre pesanteur mais chute' },
        { value: 3, label: '3 - Pas d\'effort contre pesanteur' },
        { value: 4, label: '4 - Aucun mouvement' }
      ]
    },
    {
      id: 'motorLegLeft',
      label: '6a. Motricité jambe gauche',
      type: 'select',
      options: [
        { value: 0, label: '0 - Maintient 5 sec' },
        { value: 1, label: '1 - Chute en < 5 sec sans toucher le lit' },
        { value: 2, label: '2 - Effort contre pesanteur mais chute' },
        { value: 3, label: '3 - Pas d\'effort contre pesanteur' },
        { value: 4, label: '4 - Aucun mouvement' }
      ]
    },
    {
      id: 'motorLegRight',
      label: '6b. Motricité jambe droite',
      type: 'select',
      options: [
        { value: 0, label: '0 - Maintient 5 sec' },
        { value: 1, label: '1 - Chute en < 5 sec sans toucher le lit' },
        { value: 2, label: '2 - Effort contre pesanteur mais chute' },
        { value: 3, label: '3 - Pas d\'effort contre pesanteur' },
        { value: 4, label: '4 - Aucun mouvement' }
      ]
    },
    {
      id: 'ataxia',
      label: '7. Ataxie des membres',
      type: 'select',
      options: [
        { value: 0, label: '0 - Absente' },
        { value: 1, label: '1 - Présente sur un membre' },
        { value: 2, label: '2 - Présente sur deux membres' }
      ]
    },
    {
      id: 'sensory',
      label: '8. Sensibilité',
      type: 'select',
      options: [
        { value: 0, label: '0 - Normale' },
        { value: 1, label: '1 - Hypoesthésie légère à modérée' },
        { value: 2, label: '2 - Anesthésie' }
      ]
    },
    {
      id: 'language',
      label: '9. Langage',
      type: 'select',
      options: [
        { value: 0, label: '0 - Normal' },
        { value: 1, label: '1 - Aphasie légère à modérée' },
        { value: 2, label: '2 - Aphasie sévère' },
        { value: 3, label: '3 - Mutisme ou aphasie globale' }
      ]
    },
    {
      id: 'dysarthria',
      label: '10. Dysarthrie',
      type: 'select',
      options: [
        { value: 0, label: '0 - Absente' },
        { value: 1, label: '1 - Légère à modérée' },
        { value: 2, label: '2 - Sévère, incompréhensible' }
      ]
    },
    {
      id: 'neglect',
      label: '11. Extinction/Négligence',
      type: 'select',
      options: [
        { value: 0, label: '0 - Absente' },
        { value: 1, label: '1 - Partielle (une modalité)' },
        { value: 2, label: '2 - Complète (plus d\'une modalité)' }
      ]
    }
  ],
  calculate: (values) => {
    return Object.values(values).reduce((sum: number, val) => sum + (val as number || 0), 0);
  },
  interpretations: [
    { range: [0, 4], label: 'Mineur', description: 'AVC mineur. Thrombolyse à discuter.', color: 'green' },
    { range: [5, 15], label: 'Modéré', description: 'Déficit modéré. Éligible à la thrombolyse.', color: 'yellow' },
    { range: [16, 20], label: 'Sévère', description: 'Déficit sévère. Discuter thrombolyse + thrombectomie.', color: 'orange' },
    { range: [21, 42], label: 'Très sévère', description: 'Pronostic sombre. Risque hémorragique accru.', color: 'red' }
  ],
  source: 'Brott T et al. Stroke 1989',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/2749846/'
};

export const abcd2: Calculator = {
  id: 'abcd2',
  name: 'ABCD² Score for TIA',
  shortName: 'ABCD²',
  category: 'neurology',
  description: 'Risque d\'AVC après un AIT',
  fields: [
    { id: 'age60', label: 'Âge ≥ 60 ans', type: 'checkbox' },
    { id: 'bp140', label: 'TA ≥ 140/90 mmHg', type: 'checkbox' },
    {
      id: 'clinical',
      label: 'Présentation clinique',
      type: 'select',
      options: [
        { value: 0, label: 'Autre symptôme' },
        { value: 1, label: 'Trouble de la parole sans faiblesse' },
        { value: 2, label: 'Faiblesse unilatérale' }
      ]
    },
    {
      id: 'duration',
      label: 'Durée des symptômes',
      type: 'select',
      options: [
        { value: 0, label: '< 10 minutes' },
        { value: 1, label: '10-59 minutes' },
        { value: 2, label: '≥ 60 minutes' }
      ]
    },
    { id: 'diabetes', label: 'Diabète', type: 'checkbox' }
  ],
  calculate: (values) => {
    let score = 0;
    if (values.age60) score += 1;
    if (values.bp140) score += 1;
    score += (values.clinical as number) || 0;
    score += (values.duration as number) || 0;
    if (values.diabetes) score += 1;
    return score;
  },
  interpretations: [
    { range: [0, 3], label: 'Faible risque', description: 'Risque AVC 2j: 1%. Bilan ambulatoire rapide possible.', color: 'green' },
    { range: [4, 5], label: 'Risque modéré', description: 'Risque AVC 2j: 4%. Hospitalisation recommandée.', color: 'yellow' },
    { range: [6, 7], label: 'Haut risque', description: 'Risque AVC 2j: 8%. Hospitalisation urgente.', color: 'red' }
  ],
  source: 'Johnston SC et al. Lancet 2007',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/17258668/'
};

export const ichScore: Calculator = {
  id: 'ich',
  name: 'ICH Score',
  shortName: 'ICH',
  category: 'neurology',
  description: 'Mortalité à 30 jours après hémorragie intracérébrale',
  fields: [
    {
      id: 'gcs',
      label: 'Score de Glasgow',
      type: 'select',
      options: [
        { value: 0, label: '13-15' },
        { value: 1, label: '5-12' },
        { value: 2, label: '3-4' }
      ]
    },
    {
      id: 'volume',
      label: 'Volume de l\'hématome (ABC/2)',
      type: 'select',
      options: [
        { value: 0, label: '< 30 mL' },
        { value: 1, label: '≥ 30 mL' }
      ]
    },
    { id: 'ivh', label: 'Hémorragie intraventriculaire', type: 'checkbox' },
    { id: 'infratentorial', label: 'Origine infratentorielle', type: 'checkbox' },
    { id: 'age80', label: 'Âge ≥ 80 ans', type: 'checkbox' }
  ],
  calculate: (values) => {
    let score = 0;
    score += (values.gcs as number) || 0;
    score += (values.volume as number) || 0;
    if (values.ivh) score += 1;
    if (values.infratentorial) score += 1;
    if (values.age80) score += 1;
    return score;
  },
  interpretations: [
    { range: [0, 0], label: '0', description: 'Mortalité 30j: 0%', color: 'green' },
    { range: [1, 1], label: '1', description: 'Mortalité 30j: 13%', color: 'yellow' },
    { range: [2, 2], label: '2', description: 'Mortalité 30j: 26%', color: 'orange' },
    { range: [3, 3], label: '3', description: 'Mortalité 30j: 72%', color: 'red' },
    { range: [4, 4], label: '4', description: 'Mortalité 30j: 97%', color: 'red' },
    { range: [5, 6], label: '5-6', description: 'Mortalité 30j: 100%', color: 'red' }
  ],
  source: 'Hemphill JC et al. Stroke 2001',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/11283388/'
};

export const huntHess: Calculator = {
  id: 'hunt-hess',
  name: 'Hunt and Hess Scale',
  shortName: 'Hunt-Hess',
  category: 'neurology',
  description: 'Classification clinique de l\'hémorragie sous-arachnoïdienne',
  fields: [
    {
      id: 'grade',
      label: 'Présentation clinique',
      type: 'select',
      options: [
        { value: 1, label: 'Grade 1 - Asymptomatique ou céphalées légères' },
        { value: 2, label: 'Grade 2 - Céphalées modérées à sévères, raideur de nuque, +/- atteinte nerfs crâniens' },
        { value: 3, label: 'Grade 3 - Confusion, somnolence, déficit focal léger' },
        { value: 4, label: 'Grade 4 - Stupeur, hémiparésie modérée à sévère' },
        { value: 5, label: 'Grade 5 - Coma, rigidité de décérébration' }
      ]
    }
  ],
  calculate: (values) => {
    return (values.grade as number) || 0;
  },
  interpretations: [
    { range: [1, 1], label: 'Grade 1', description: 'Bon pronostic. Mortalité ~1%.', color: 'green' },
    { range: [2, 2], label: 'Grade 2', description: 'Bon pronostic. Mortalité ~5%.', color: 'green' },
    { range: [3, 3], label: 'Grade 3', description: 'Pronostic intermédiaire. Mortalité ~19%.', color: 'yellow' },
    { range: [4, 4], label: 'Grade 4', description: 'Pronostic réservé. Mortalité ~42%.', color: 'orange' },
    { range: [5, 5], label: 'Grade 5', description: 'Pronostic très sombre. Mortalité ~77%.', color: 'red' }
  ],
  source: 'Hunt WE, Hess RM. J Neurosurg 1968',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/5635959/'
};

export const neurologyScores: Calculator[] = [
  nihss,
  abcd2,
  ichScore,
  huntHess
];
