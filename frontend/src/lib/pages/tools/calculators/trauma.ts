// Trauma Scores

import type { Calculator } from './types';

export const glasgowComaScale: Calculator = {
  id: 'gcs',
  name: 'Glasgow Coma Scale (GCS)',
  shortName: 'GCS',
  category: 'trauma',
  description: 'Évaluation standardisée du niveau de conscience',
  fields: [
    {
      id: 'eye',
      label: 'Réponse oculaire (E)',
      type: 'select',
      options: [
        { value: 4, label: 'Spontanée', description: 'Yeux ouverts spontanément' },
        { value: 3, label: 'À la demande', description: 'Ouvre les yeux à la demande verbale' },
        { value: 2, label: 'À la douleur', description: 'Ouvre les yeux à la stimulation douloureuse' },
        { value: 1, label: 'Aucune', description: 'Pas d\'ouverture des yeux' }
      ]
    },
    {
      id: 'verbal',
      label: 'Réponse verbale (V)',
      type: 'select',
      options: [
        { value: 5, label: 'Orientée', description: 'Orienté dans le temps, l\'espace et la personne' },
        { value: 4, label: 'Confuse', description: 'Conversation confuse, désorienté' },
        { value: 3, label: 'Mots inappropriés', description: 'Mots inappropriés, incohérents' },
        { value: 2, label: 'Sons incompréhensibles', description: 'Sons incompréhensibles, gémissements' },
        { value: 1, label: 'Aucune', description: 'Pas de réponse verbale' }
      ]
    },
    {
      id: 'motor',
      label: 'Réponse motrice (M)',
      type: 'select',
      options: [
        { value: 6, label: 'Obéit aux ordres', description: 'Exécute les ordres simples' },
        { value: 5, label: 'Localise la douleur', description: 'Localise le stimulus douloureux' },
        { value: 4, label: 'Retrait à la douleur', description: 'Retrait en flexion à la douleur' },
        { value: 3, label: 'Flexion anormale', description: 'Décortication (flexion stéréotypée)' },
        { value: 2, label: 'Extension', description: 'Décérébration (extension stéréotypée)' },
        { value: 1, label: 'Aucune', description: 'Pas de réponse motrice' }
      ]
    }
  ],
  calculate: (values) => {
    return (values.eye as number) + (values.verbal as number) + (values.motor as number);
  },
  interpretations: [
    { range: [15, 15], label: 'Normal', description: 'Conscience normale', color: 'green' },
    { range: [13, 14], label: 'Léger', description: 'Traumatisme crânien léger', color: 'yellow' },
    { range: [9, 12], label: 'Modéré', description: 'Traumatisme crânien modéré', color: 'orange' },
    { range: [3, 8], label: 'Sévère', description: 'Traumatisme crânien sévère - Intubation recommandée', color: 'red' }
  ],
  source: 'Teasdale G, Jennett B. Lancet 1974',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/4136544/'
};

export const shockIndex: Calculator = {
  id: 'shock-index',
  name: 'Shock Index',
  shortName: 'SI',
  category: 'trauma',
  description: 'Détection précoce du choc occulte (FC/TAS)',
  fields: [
    {
      id: 'heartRate',
      label: 'Fréquence cardiaque',
      type: 'number',
      min: 30,
      max: 250,
      unit: 'bpm'
    },
    {
      id: 'systolicBP',
      label: 'Pression artérielle systolique',
      type: 'number',
      min: 40,
      max: 250,
      unit: 'mmHg'
    }
  ],
  calculate: (values) => {
    const hr = values.heartRate as number;
    const sbp = values.systolicBP as number;
    if (!sbp || sbp === 0) return 0;
    return Math.round((hr / sbp) * 100) / 100;
  },
  interpretations: [
    { range: [0, 0.5], label: 'Normal bas', description: 'Pas de signe de choc', color: 'green' },
    { range: [0.5, 0.7], label: 'Normal', description: 'Valeur normale', color: 'green' },
    { range: [0.7, 0.9], label: 'Élevé', description: 'Choc compensé possible', color: 'yellow' },
    { range: [0.9, 1.1], label: 'Très élevé', description: 'Choc probable - Transfusion massive à considérer', color: 'orange' },
    { range: [1.1, 10], label: 'Critique', description: 'Choc sévère - Réanimation urgente', color: 'red' }
  ],
  source: 'Allgöwer M, Burri C. Dtsch Med Wochenschr 1967',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/4860946/'
};

export const revisedTraumaScore: Calculator = {
  id: 'rts',
  name: 'Revised Trauma Score (RTS)',
  shortName: 'RTS',
  category: 'trauma',
  description: 'Score de triage pour orientation vers un centre de traumatologie',
  fields: [
    {
      id: 'gcs',
      label: 'Glasgow Coma Scale',
      type: 'select',
      options: [
        { value: 4, label: '13-15' },
        { value: 3, label: '9-12' },
        { value: 2, label: '6-8' },
        { value: 1, label: '4-5' },
        { value: 0, label: '3' }
      ]
    },
    {
      id: 'sbp',
      label: 'Pression artérielle systolique',
      type: 'select',
      options: [
        { value: 4, label: '> 89 mmHg' },
        { value: 3, label: '76-89 mmHg' },
        { value: 2, label: '50-75 mmHg' },
        { value: 1, label: '1-49 mmHg' },
        { value: 0, label: '0 mmHg' }
      ]
    },
    {
      id: 'rr',
      label: 'Fréquence respiratoire',
      type: 'select',
      options: [
        { value: 4, label: '10-29/min' },
        { value: 3, label: '> 29/min' },
        { value: 2, label: '6-9/min' },
        { value: 1, label: '1-5/min' },
        { value: 0, label: '0/min' }
      ]
    }
  ],
  calculate: (values) => {
    // RTS = 0.9368 × GCS + 0.7326 × SBP + 0.2908 × RR
    const gcs = values.gcs as number;
    const sbp = values.sbp as number;
    const rr = values.rr as number;
    return Math.round((0.9368 * gcs + 0.7326 * sbp + 0.2908 * rr) * 100) / 100;
  },
  interpretations: [
    { range: [7.84, 8], label: 'Excellent', description: 'Pronostic excellent', color: 'green' },
    { range: [6, 7.84], label: 'Bon', description: 'Pronostic favorable', color: 'yellow' },
    { range: [4, 6], label: 'Modéré', description: 'Centre de trauma recommandé', color: 'orange' },
    { range: [0, 4], label: 'Critique', description: 'Pronostic sombre - Centre de trauma niveau 1', color: 'red' }
  ],
  source: 'Champion HR et al. J Trauma 1989',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/2716524/'
};

export const fourScore: Calculator = {
  id: 'four-score',
  name: 'FOUR Score',
  shortName: 'FOUR',
  category: 'trauma',
  description: 'Alternative au GCS pour patients intubés - Full Outline of UnResponsiveness',
  fields: [
    {
      id: 'eye',
      label: 'Réponse oculaire',
      type: 'select',
      options: [
        { value: 4, label: 'Paupières ouvertes, suit du regard' },
        { value: 3, label: 'Paupières ouvertes, ne suit pas' },
        { value: 2, label: 'Paupières fermées, ouverture à la voix forte' },
        { value: 1, label: 'Paupières fermées, ouverture à la douleur' },
        { value: 0, label: 'Paupières fermées malgré la douleur' }
      ]
    },
    {
      id: 'motor',
      label: 'Réponse motrice',
      type: 'select',
      options: [
        { value: 4, label: 'Exécute les ordres (pouce levé, poing, signe de paix)' },
        { value: 3, label: 'Localise la douleur' },
        { value: 2, label: 'Flexion à la douleur' },
        { value: 1, label: 'Extension à la douleur' },
        { value: 0, label: 'Aucune réponse ou myoclonies généralisées' }
      ]
    },
    {
      id: 'brainstem',
      label: 'Réflexes du tronc cérébral',
      type: 'select',
      options: [
        { value: 4, label: 'Réflexes pupillaires et cornéens présents' },
        { value: 3, label: 'Une pupille dilatée et fixe' },
        { value: 2, label: 'Réflexe pupillaire OU cornéen absent' },
        { value: 1, label: 'Réflexes pupillaires ET cornéens absents' },
        { value: 0, label: 'Réflexes pupillaires, cornéens ET de toux absents' }
      ]
    },
    {
      id: 'respiration',
      label: 'Respiration',
      type: 'select',
      options: [
        { value: 4, label: 'Respiration régulière, non intubé' },
        { value: 3, label: 'Respiration de Cheyne-Stokes' },
        { value: 2, label: 'Respiration irrégulière' },
        { value: 1, label: 'Intubé, déclenche le respirateur' },
        { value: 0, label: 'Intubé, ne déclenche pas le respirateur / Apnée' }
      ]
    }
  ],
  calculate: (values) => {
    return (values.eye as number) + (values.motor as number) + 
           (values.brainstem as number) + (values.respiration as number);
  },
  interpretations: [
    { range: [16, 16], label: 'Normal', description: 'Conscience normale', color: 'green' },
    { range: [12, 15], label: 'Altéré', description: 'Altération modérée de la conscience', color: 'yellow' },
    { range: [8, 11], label: 'Sévère', description: 'Altération sévère', color: 'orange' },
    { range: [0, 7], label: 'Critique', description: 'Coma profond - Évaluation herniation', color: 'red' }
  ],
  source: 'Wijdicks EF et al. Ann Neurol 2005',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/15984004/'
};

export const traumaScores: Calculator[] = [
  glasgowComaScale,
  fourScore,
  shockIndex,
  revisedTraumaScore
];
