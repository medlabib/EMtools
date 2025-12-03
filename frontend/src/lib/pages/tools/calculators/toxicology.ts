// Toxicology Scores

import type { Calculator } from './types';

export const ciwaAr: Calculator = {
  id: 'ciwa-ar',
  name: 'CIWA-Ar (Alcohol Withdrawal)',
  shortName: 'CIWA-Ar',
  category: 'toxicology',
  description: 'Sévérité du sevrage alcoolique et guide de traitement',
  fields: [
    {
      id: 'nausea',
      label: 'Nausées et vomissements',
      type: 'select',
      options: [
        { value: 0, label: '0 - Absents' },
        { value: 1, label: '1 - Nausées légères sans vomissement' },
        { value: 4, label: '4 - Nausées intermittentes avec haut-le-cœur' },
        { value: 7, label: '7 - Nausées constantes, haut-le-cœur fréquents, vomissements' }
      ]
    },
    {
      id: 'tremor',
      label: 'Tremblements (bras tendus, doigts écartés)',
      type: 'select',
      options: [
        { value: 0, label: '0 - Absents' },
        { value: 1, label: '1 - Non visibles mais perceptibles au toucher' },
        { value: 4, label: '4 - Modérés, bras tendus' },
        { value: 7, label: '7 - Sévères, même bras non tendus' }
      ]
    },
    {
      id: 'sweating',
      label: 'Sueurs paroxystiques',
      type: 'select',
      options: [
        { value: 0, label: '0 - Absentes' },
        { value: 1, label: '1 - Sueurs à peine perceptibles, paumes moites' },
        { value: 4, label: '4 - Sueurs au front' },
        { value: 7, label: '7 - Sueurs profuses' }
      ]
    },
    {
      id: 'anxiety',
      label: 'Anxiété',
      type: 'select',
      options: [
        { value: 0, label: '0 - Calme' },
        { value: 1, label: '1 - Légèrement anxieux' },
        { value: 4, label: '4 - Modérément anxieux ou sur ses gardes' },
        { value: 7, label: '7 - Panique, équivalent à un état délirant aigu' }
      ]
    },
    {
      id: 'agitation',
      label: 'Agitation',
      type: 'select',
      options: [
        { value: 0, label: '0 - Activité normale' },
        { value: 1, label: '1 - Un peu plus que l\'activité normale' },
        { value: 4, label: '4 - Modérément agité' },
        { value: 7, label: '7 - Arpente constamment ou se débat' }
      ]
    },
    {
      id: 'tactile',
      label: 'Troubles tactiles',
      type: 'select',
      options: [
        { value: 0, label: '0 - Absents' },
        { value: 1, label: '1 - Paresthésies très légères' },
        { value: 2, label: '2 - Paresthésies légères' },
        { value: 3, label: '3 - Paresthésies modérées' },
        { value: 4, label: '4 - Hallucinations modérées' },
        { value: 5, label: '5 - Hallucinations sévères' },
        { value: 6, label: '6 - Hallucinations extrêmement sévères' },
        { value: 7, label: '7 - Hallucinations continues' }
      ]
    },
    {
      id: 'auditory',
      label: 'Troubles auditifs',
      type: 'select',
      options: [
        { value: 0, label: '0 - Absents' },
        { value: 1, label: '1 - Très légèrement effrayé' },
        { value: 2, label: '2 - Légèrement effrayé' },
        { value: 3, label: '3 - Modérément effrayé' },
        { value: 4, label: '4 - Hallucinations modérées' },
        { value: 5, label: '5 - Hallucinations sévères' },
        { value: 6, label: '6 - Hallucinations extrêmement sévères' },
        { value: 7, label: '7 - Hallucinations continues' }
      ]
    },
    {
      id: 'visual',
      label: 'Troubles visuels',
      type: 'select',
      options: [
        { value: 0, label: '0 - Absents' },
        { value: 1, label: '1 - Photosensibilité très légère' },
        { value: 2, label: '2 - Photosensibilité légère' },
        { value: 3, label: '3 - Photosensibilité modérée' },
        { value: 4, label: '4 - Hallucinations modérées' },
        { value: 5, label: '5 - Hallucinations sévères' },
        { value: 6, label: '6 - Hallucinations extrêmement sévères' },
        { value: 7, label: '7 - Hallucinations continues' }
      ]
    },
    {
      id: 'headache',
      label: 'Céphalées, sensation de tête pleine',
      type: 'select',
      options: [
        { value: 0, label: '0 - Absentes' },
        { value: 1, label: '1 - Très légères' },
        { value: 2, label: '2 - Légères' },
        { value: 3, label: '3 - Modérées' },
        { value: 4, label: '4 - Modérément sévères' },
        { value: 5, label: '5 - Sévères' },
        { value: 6, label: '6 - Très sévères' },
        { value: 7, label: '7 - Extrêmement sévères' }
      ]
    },
    {
      id: 'orientation',
      label: 'Orientation et obnubilation',
      type: 'select',
      options: [
        { value: 0, label: '0 - Orienté, peut faire des additions' },
        { value: 1, label: '1 - Incertain sur la date' },
        { value: 2, label: '2 - Désorienté dans le temps (< 2 jours)' },
        { value: 3, label: '3 - Désorienté dans le temps (> 2 jours)' },
        { value: 4, label: '4 - Désorienté dans l\'espace et/ou l\'identité' }
      ]
    }
  ],
  calculate: (values) => {
    return Object.values(values).reduce((sum: number, val) => sum + (val as number || 0), 0);
  },
  interpretations: [
    { range: [0, 8], label: 'Sevrage léger', description: 'Pas de traitement pharmacologique nécessaire. Surveillance.', color: 'green' },
    { range: [9, 15], label: 'Sevrage modéré', description: 'Benzodiazépines à envisager. Surveillance rapprochée.', color: 'yellow' },
    { range: [16, 20], label: 'Sevrage sévère', description: 'Benzodiazépines recommandées. Surveillance continue.', color: 'orange' },
    { range: [21, 67], label: 'Sevrage très sévère', description: 'Risque de delirium tremens. Soins intensifs. Benzodiazépines IV.', color: 'red' }
  ],
  source: 'Sullivan JT et al. Br J Addict 1989',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/2597811/'
};

export const cows: Calculator = {
  id: 'cows',
  name: 'COWS (Clinical Opiate Withdrawal Scale)',
  shortName: 'COWS',
  category: 'toxicology',
  description: 'Sévérité du sevrage aux opioïdes',
  fields: [
    {
      id: 'pulse',
      label: 'Fréquence cardiaque au repos',
      type: 'select',
      options: [
        { value: 0, label: '0 - ≤ 80/min' },
        { value: 1, label: '1 - 81-100/min' },
        { value: 2, label: '2 - 101-120/min' },
        { value: 4, label: '4 - > 120/min' }
      ]
    },
    {
      id: 'sweating',
      label: 'Sueurs (dernière demi-heure)',
      type: 'select',
      options: [
        { value: 0, label: '0 - Absentes' },
        { value: 1, label: '1 - Humidité légère sur les paumes' },
        { value: 2, label: '2 - Front en sueur' },
        { value: 3, label: '3 - Sueurs sur le visage' },
        { value: 4, label: '4 - Sueurs ruisselantes' }
      ]
    },
    {
      id: 'restlessness',
      label: 'Agitation (observation)',
      type: 'select',
      options: [
        { value: 0, label: '0 - Capable de rester assis' },
        { value: 1, label: '1 - Difficulté à rester assis, mais y arrive' },
        { value: 3, label: '3 - Se déplace fréquemment' },
        { value: 5, label: '5 - Incapable de rester assis plus de quelques secondes' }
      ]
    },
    {
      id: 'pupils',
      label: 'Taille des pupilles',
      type: 'select',
      options: [
        { value: 0, label: '0 - Normales ou myosis' },
        { value: 1, label: '1 - Possiblement dilatées' },
        { value: 2, label: '2 - Modérément dilatées' },
        { value: 5, label: '5 - Très dilatées' }
      ]
    },
    {
      id: 'boneJointAches',
      label: 'Douleurs osseuses ou articulaires',
      type: 'select',
      options: [
        { value: 0, label: '0 - Absentes' },
        { value: 1, label: '1 - Gêne légère diffuse' },
        { value: 2, label: '2 - Douleurs sévères diffuses' },
        { value: 4, label: '4 - Se frotte constamment les articulations ou les muscles' }
      ]
    },
    {
      id: 'runnyNose',
      label: 'Rhinorrhée ou larmoiement',
      type: 'select',
      options: [
        { value: 0, label: '0 - Absents' },
        { value: 1, label: '1 - Congestion nasale ou yeux humides' },
        { value: 2, label: '2 - Rhinorrhée ou larmoiement' },
        { value: 4, label: '4 - Rhinorrhée constante ou larmes coulantes' }
      ]
    },
    {
      id: 'gi',
      label: 'Troubles GI (crampes, nausées, vomissements, diarrhée)',
      type: 'select',
      options: [
        { value: 0, label: '0 - Absents' },
        { value: 1, label: '1 - Crampes légères' },
        { value: 2, label: '2 - Crampes modérées, nausées, selles molles' },
        { value: 3, label: '3 - Diarrhée ou vomissements' },
        { value: 5, label: '5 - Vomissements et diarrhée répétés' }
      ]
    },
    {
      id: 'tremor',
      label: 'Tremblement des mains tendues',
      type: 'select',
      options: [
        { value: 0, label: '0 - Absent' },
        { value: 1, label: '1 - Léger' },
        { value: 2, label: '2 - Modéré' },
        { value: 4, label: '4 - Sévère' }
      ]
    },
    {
      id: 'yawning',
      label: 'Bâillements (observation)',
      type: 'select',
      options: [
        { value: 0, label: '0 - Aucun' },
        { value: 1, label: '1 - Un ou deux' },
        { value: 2, label: '2 - Trois ou plus' },
        { value: 4, label: '4 - Plusieurs par minute' }
      ]
    },
    {
      id: 'anxiety',
      label: 'Anxiété ou irritabilité',
      type: 'select',
      options: [
        { value: 0, label: '0 - Aucune' },
        { value: 1, label: '1 - Patient anxieux' },
        { value: 2, label: '2 - Patient irritable' },
        { value: 4, label: '4 - Tellement irritable ou anxieux que participation difficile' }
      ]
    },
    {
      id: 'gooseflesh',
      label: 'Piloérection ("chair de poule")',
      type: 'select',
      options: [
        { value: 0, label: '0 - Peau lisse' },
        { value: 3, label: '3 - Piloérection palpable' },
        { value: 5, label: '5 - Piloérection visible' }
      ]
    }
  ],
  calculate: (values) => {
    return Object.values(values).reduce((sum: number, val) => sum + (val as number || 0), 0);
  },
  interpretations: [
    { range: [0, 4], label: 'Pas de sevrage', description: 'Pas de symptômes significatifs.', color: 'green' },
    { range: [5, 12], label: 'Sevrage léger', description: 'Traitement symptomatique.', color: 'green' },
    { range: [13, 24], label: 'Sevrage modéré', description: 'Envisager traitement de substitution.', color: 'yellow' },
    { range: [25, 36], label: 'Sevrage modérément sévère', description: 'Traitement de substitution recommandé.', color: 'orange' },
    { range: [37, 48], label: 'Sevrage sévère', description: 'Traitement intensif. Hospitalisation possible.', color: 'red' }
  ],
  source: 'Wesson DR, Ling W. J Psychoactive Drugs 2003',
  sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/12924748/'
};

export const toxicologyScores: Calculator[] = [
  ciwaAr,
  cows
];
