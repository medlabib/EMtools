// Antibiotic Database - Tunisia Formulary

import type { Antibiotic } from './types';

export const antibiotics: Antibiotic[] = [
  // ============ PENICILLINS ============
  {
    id: 'amoxicillin',
    name: 'Clamoxyl®',
    genericName: 'Amoxicilline',
    class: 'penicillin',
    spectrum: 'broad-spectrum',
    route: ['PO', 'IV'],
    standardDose: {
      adult: '500mg - 1g',
      frequency: 'toutes les 8h',
      duration: '5-10 jours',
      maxDose: '6g/jour'
    },
    renalAdjustment: [
      { gfr: '30-59', dose: 'Pas d\'ajustement' },
      { gfr: '10-29', dose: '500mg/12h', notes: 'Réduire fréquence' },
      { gfr: '<10', dose: '500mg/24h', notes: 'Après dialyse si hémodialysé' }
    ],
    indications: [
      'Infections ORL (otite, sinusite, angine)',
      'Infections respiratoires basses',
      'Infections urinaires non compliquées',
      'Éradication H. pylori',
      'Endocardite (prophylaxie)'
    ],
    contraindications: [
      'Allergie aux pénicillines',
      'Mononucléose infectieuse (risque d\'éruption)'
    ],
    sideEffects: [
      'Diarrhée',
      'Nausées',
      'Éruption cutanée',
      'Candidose'
    ],
    interactions: [
      { drug: 'Méthotrexate', severity: 'major', effect: 'Augmentation toxicité MTX', recommendation: 'Surveiller fonction rénale et NFS' },
      { drug: 'Anticoagulants oraux', severity: 'moderate', effect: 'Augmentation effet anticoagulant', recommendation: 'Surveiller INR' },
      { drug: 'Allopurinol', severity: 'moderate', effect: 'Risque accru d\'éruption', recommendation: 'Surveillance cutanée' }
    ],
    monitoring: ['Fonction rénale si traitement prolongé'],
    pregnancyCategory: 'B',
    availableInTunisia: true,
    tunisiaPrice: '5-15 DT',
    requiresPrescription: true
  },
  {
    id: 'amoxicillin-clavulanate',
    name: 'Augmentin®',
    genericName: 'Amoxicilline/Acide clavulanique',
    class: 'penicillin',
    spectrum: 'broad-spectrum',
    route: ['PO', 'IV'],
    standardDose: {
      adult: '1g/125mg',
      frequency: 'toutes les 8-12h',
      duration: '5-10 jours',
      maxDose: '3g amox/jour'
    },
    renalAdjustment: [
      { gfr: '30-59', dose: '1g/12h' },
      { gfr: '10-29', dose: '500mg/12h' },
      { gfr: '<10', dose: '500mg/24h', notes: 'Éviter forme IV' }
    ],
    indications: [
      'Infections respiratoires (pneumonie, EABC)',
      'Infections ORL résistantes',
      'Infections cutanées (morsures, cellulite)',
      'Infections intra-abdominales',
      'Infections gynécologiques'
    ],
    contraindications: [
      'Allergie aux pénicillines',
      'Antécédent d\'ictère sous amox-clav',
      'Mononucléose infectieuse'
    ],
    sideEffects: [
      'Diarrhée (fréquente)',
      'Nausées, vomissements',
      'Candidose',
      'Hépatite (rare)'
    ],
    interactions: [
      { drug: 'Méthotrexate', severity: 'major', effect: 'Augmentation toxicité MTX', recommendation: 'CI relative' },
      { drug: 'Anticoagulants oraux', severity: 'moderate', effect: 'Augmentation effet', recommendation: 'Surveiller INR' },
      { drug: 'Mycophénolate', severity: 'moderate', effect: 'Diminution efficacité MMF', recommendation: 'Surveillance rejet' }
    ],
    monitoring: ['Fonction hépatique si > 14 jours', 'Fonction rénale'],
    pregnancyCategory: 'B',
    availableInTunisia: true,
    tunisiaPrice: '15-30 DT',
    requiresPrescription: true
  },
  {
    id: 'piperacillin-tazobactam',
    name: 'Tazocilline®',
    genericName: 'Pipéracilline/Tazobactam',
    class: 'penicillin',
    spectrum: 'broad-spectrum',
    route: ['IV'],
    standardDose: {
      adult: '4g/500mg',
      frequency: 'toutes les 6-8h',
      duration: '7-14 jours',
      maxDose: '16g pip/jour'
    },
    renalAdjustment: [
      { gfr: '20-40', dose: '3.375g/6h' },
      { gfr: '<20', dose: '2.25g/6h' },
      { gfr: 'HD', dose: '2.25g/8h', notes: 'Dose supplémentaire après dialyse' }
    ],
    indications: [
      'Infections nosocomiales sévères',
      'Pneumonies acquises à l\'hôpital',
      'Infections intra-abdominales',
      'Infections des tissus mous',
      'Neutropénie fébrile'
    ],
    contraindications: [
      'Allergie aux pénicillines'
    ],
    sideEffects: [
      'Diarrhée',
      'Thrombopénie',
      'Insuffisance rénale',
      'Convulsions (surdosage)'
    ],
    interactions: [
      { drug: 'Aminosides', severity: 'moderate', effect: 'Inactivation aminosides', recommendation: 'Espacer les administrations' },
      { drug: 'Méthotrexate', severity: 'major', effect: 'Toxicité accrue', recommendation: 'CI' },
      { drug: 'Anticoagulants', severity: 'moderate', effect: 'Saignement accru', recommendation: 'Surveiller' }
    ],
    monitoring: ['NFS (plaquettes)', 'Fonction rénale', 'Électrolytes'],
    pregnancyCategory: 'B',
    availableInTunisia: true,
    tunisiaPrice: '80-150 DT',
    requiresPrescription: true
  },

  // ============ CEPHALOSPORINS ============
  {
    id: 'cefazolin',
    name: 'Céfazoline®',
    genericName: 'Céfazoline',
    class: 'cephalosporin-1g',
    spectrum: 'gram-positive',
    route: ['IV', 'IM'],
    standardDose: {
      adult: '1-2g',
      frequency: 'toutes les 8h',
      duration: 'Variable',
      maxDose: '12g/jour'
    },
    renalAdjustment: [
      { gfr: '35-54', dose: 'Dose normale/12h' },
      { gfr: '11-34', dose: '50% dose/12h' },
      { gfr: '<10', dose: '50% dose/24h' }
    ],
    indications: [
      'Antibioprophylaxie chirurgicale',
      'Infections cutanées à staphylocoque',
      'Endocardite sur valve native (SAMS)',
      'Infections osseuses'
    ],
    contraindications: [
      'Allergie aux céphalosporines',
      'Allergie sévère aux pénicillines (10% réactivité croisée)'
    ],
    sideEffects: [
      'Réaction au site d\'injection',
      'Diarrhée',
      'Éruption cutanée'
    ],
    interactions: [
      { drug: 'Anticoagulants', severity: 'moderate', effect: 'Augmentation INR', recommendation: 'Surveiller INR' },
      { drug: 'Probénécide', severity: 'minor', effect: 'Augmentation concentration', recommendation: 'Peut être utilisé' }
    ],
    monitoring: ['Fonction rénale si prolongé'],
    pregnancyCategory: 'B',
    availableInTunisia: true,
    tunisiaPrice: '10-20 DT',
    requiresPrescription: true
  },
  {
    id: 'ceftriaxone',
    name: 'Rocéphine®',
    genericName: 'Ceftriaxone',
    class: 'cephalosporin-3g',
    spectrum: 'broad-spectrum',
    route: ['IV', 'IM'],
    standardDose: {
      adult: '1-2g',
      frequency: 'une fois par jour',
      duration: '7-14 jours',
      maxDose: '4g/jour'
    },
    renalAdjustment: [
      { gfr: '30-59', dose: 'Pas d\'ajustement' },
      { gfr: '<30', dose: 'Max 2g/jour', notes: 'Pas de dialyse' }
    ],
    hepaticAdjustment: 'Réduire dose si insuffisance hépatique ET rénale',
    indications: [
      'Méningite bactérienne',
      'Pneumonie communautaire sévère',
      'Pyélonéphrite',
      'Infections intra-abdominales',
      'Gonorrhée',
      'Maladie de Lyme'
    ],
    contraindications: [
      'Allergie aux céphalosporines',
      'Nouveau-né avec hyperbilirubinémie',
      'CI avec calcium IV chez nouveau-né'
    ],
    sideEffects: [
      'Diarrhée',
      'Lithiase biliaire (réversible)',
      'Éruption cutanée',
      'Colite à C. difficile'
    ],
    interactions: [
      { drug: 'Calcium IV', severity: 'major', effect: 'Précipitation (nouveau-né)', recommendation: 'CI chez nouveau-né' },
      { drug: 'Anticoagulants', severity: 'moderate', effect: 'Augmentation effet', recommendation: 'Surveiller INR' },
      { drug: 'Ringer lactate', severity: 'moderate', effect: 'Incompatibilité', recommendation: 'Ne pas mélanger' }
    ],
    monitoring: ['Échographie vésiculaire si prolongé', 'NFS'],
    pregnancyCategory: 'B',
    availableInTunisia: true,
    tunisiaPrice: '20-40 DT',
    requiresPrescription: true
  },
  {
    id: 'cefotaxime',
    name: 'Claforan®',
    genericName: 'Céfotaxime',
    class: 'cephalosporin-3g',
    spectrum: 'broad-spectrum',
    route: ['IV', 'IM'],
    standardDose: {
      adult: '1-2g',
      frequency: 'toutes les 6-8h',
      duration: '7-14 jours',
      maxDose: '12g/jour'
    },
    renalAdjustment: [
      { gfr: '20-50', dose: 'Réduire fréquence 8-12h' },
      { gfr: '<20', dose: '50% dose', notes: 'Dose post-dialyse' }
    ],
    indications: [
      'Méningite (préféré chez nouveau-né)',
      'Infections sévères',
      'Sepsis',
      'Alternative à ceftriaxone'
    ],
    contraindications: [
      'Allergie aux céphalosporines'
    ],
    sideEffects: [
      'Diarrhée',
      'Réaction au site d\'injection',
      'Éruption cutanée'
    ],
    interactions: [
      { drug: 'Probénécide', severity: 'minor', effect: 'Augmentation concentration', recommendation: 'Peut être utilisé' }
    ],
    monitoring: ['Fonction rénale'],
    pregnancyCategory: 'B',
    availableInTunisia: true,
    tunisiaPrice: '15-30 DT',
    requiresPrescription: true
  },

  // ============ CARBAPENEMS ============
  {
    id: 'imipenem',
    name: 'Tienam®',
    genericName: 'Imipénème/Cilastatine',
    class: 'carbapenem',
    spectrum: 'broad-spectrum',
    route: ['IV'],
    standardDose: {
      adult: '500mg',
      frequency: 'toutes les 6h',
      duration: '7-14 jours',
      maxDose: '4g/jour'
    },
    renalAdjustment: [
      { gfr: '41-70', dose: '500mg/8h' },
      { gfr: '21-40', dose: '500mg/12h' },
      { gfr: '<20', dose: '250mg/12h' }
    ],
    indications: [
      'Infections nosocomiales sévères',
      'Infections polymicrobiennes',
      'Infections à germes multirésistants',
      'Neutropénie fébrile'
    ],
    contraindications: [
      'Allergie aux carbapénèmes',
      'Allergie sévère aux pénicillines'
    ],
    sideEffects: [
      'Convulsions (dose-dépendant)',
      'Nausées, vomissements',
      'Diarrhée',
      'Thrombophlébite'
    ],
    interactions: [
      { drug: 'Acide valproïque', severity: 'major', effect: 'Diminution taux valproate', recommendation: 'CI - risque convulsions' },
      { drug: 'Ganciclovir', severity: 'major', effect: 'Convulsions', recommendation: 'CI' }
    ],
    monitoring: ['Fonction rénale', 'Surveillance neurologique'],
    pregnancyCategory: 'C',
    availableInTunisia: true,
    tunisiaPrice: '100-200 DT',
    requiresPrescription: true,
    notes: 'Réserver aux infections sévères. Risque convulsif surtout si IR ou dose élevée.'
  },
  {
    id: 'meropenem',
    name: 'Meronem®',
    genericName: 'Méropénème',
    class: 'carbapenem',
    spectrum: 'broad-spectrum',
    route: ['IV'],
    standardDose: {
      adult: '1g',
      frequency: 'toutes les 8h',
      duration: '7-14 jours',
      maxDose: '6g/jour'
    },
    renalAdjustment: [
      { gfr: '26-50', dose: '1g/12h' },
      { gfr: '10-25', dose: '500mg/12h' },
      { gfr: '<10', dose: '500mg/24h' }
    ],
    indications: [
      'Méningite nosocomiale',
      'Infections sévères multirésistantes',
      'Pneumonie nosocomiale',
      'Infections intra-abdominales compliquées'
    ],
    contraindications: [
      'Allergie aux carbapénèmes'
    ],
    sideEffects: [
      'Diarrhée',
      'Nausées',
      'Céphalées',
      'Moins de convulsions que imipénème'
    ],
    interactions: [
      { drug: 'Acide valproïque', severity: 'major', effect: 'Diminution taux valproate 60-100%', recommendation: 'CI formelle' },
      { drug: 'Probénécide', severity: 'moderate', effect: 'Augmentation concentration', recommendation: 'Éviter' }
    ],
    monitoring: ['Fonction rénale', 'Transaminases'],
    pregnancyCategory: 'B',
    availableInTunisia: true,
    tunisiaPrice: '150-300 DT',
    requiresPrescription: true,
    notes: 'Préféré à imipénème pour méningite (meilleure pénétration SNC, moins convulsivant)'
  },

  // ============ AMINOGLYCOSIDES ============
  {
    id: 'gentamicin',
    name: 'Gentalline®',
    genericName: 'Gentamicine',
    class: 'aminoglycoside',
    spectrum: 'gram-negative',
    route: ['IV', 'IM'],
    standardDose: {
      adult: '5-7 mg/kg',
      frequency: 'une fois par jour',
      duration: '3-5 jours',
      maxDose: '7 mg/kg/jour'
    },
    renalAdjustment: [
      { gfr: '40-60', dose: '60% dose', notes: 'Ou espacer à 36h' },
      { gfr: '20-40', dose: '30% dose', notes: 'Ou espacer à 48h' },
      { gfr: '<20', dose: 'Dosage', notes: 'Selon taux résiduels' }
    ],
    indications: [
      'Endocardite (en association)',
      'Sepsis sévère (en association)',
      'Pyélonéphrite compliquée',
      'Infections à Pseudomonas'
    ],
    contraindications: [
      'Insuffisance rénale sévère (relative)',
      'Myasthénie',
      'Grossesse (CI relative)'
    ],
    sideEffects: [
      'Néphrotoxicité',
      'Ototoxicité (irréversible)',
      'Blocage neuromusculaire'
    ],
    interactions: [
      { drug: 'Vancomycine', severity: 'major', effect: 'Néphrotoxicité additive', recommendation: 'Surveillance rénale rapprochée' },
      { drug: 'Diurétiques de l\'anse', severity: 'major', effect: 'Ototoxicité accrue', recommendation: 'Éviter ou surveiller' },
      { drug: 'AINS', severity: 'moderate', effect: 'Néphrotoxicité', recommendation: 'Éviter' },
      { drug: 'Curares', severity: 'moderate', effect: 'Bloc NM prolongé', recommendation: 'Surveillance en réa' }
    ],
    monitoring: ['Créatinine quotidienne', 'Taux résiduels < 1 mg/L', 'Pic si échec'],
    pregnancyCategory: 'D',
    availableInTunisia: true,
    tunisiaPrice: '5-15 DT',
    requiresPrescription: true,
    notes: 'DUJ (Dose Unique Journalière) préférée. Durée courte recommandée.'
  },
  {
    id: 'amikacin',
    name: 'Amiklin®',
    genericName: 'Amikacine',
    class: 'aminoglycoside',
    spectrum: 'gram-negative',
    route: ['IV', 'IM'],
    standardDose: {
      adult: '15-20 mg/kg',
      frequency: 'une fois par jour',
      duration: '3-5 jours',
      maxDose: '1.5g/jour'
    },
    renalAdjustment: [
      { gfr: '40-60', dose: 'Espacer à 36h' },
      { gfr: '20-40', dose: 'Espacer à 48h' },
      { gfr: '<20', dose: 'Selon dosages' }
    ],
    indications: [
      'Infections à BGN multirésistants',
      'Tuberculose multirésistante',
      'Sepsis sévère (en association)',
      'Endocardite'
    ],
    contraindications: [
      'Myasthénie',
      'Insuffisance rénale sévère (relative)'
    ],
    sideEffects: [
      'Néphrotoxicité',
      'Ototoxicité',
      'Blocage neuromusculaire'
    ],
    interactions: [
      { drug: 'Vancomycine', severity: 'major', effect: 'Néphrotoxicité', recommendation: 'Surveillance rapprochée' },
      { drug: 'Amphotéricine B', severity: 'major', effect: 'Néphrotoxicité', recommendation: 'Éviter' },
      { drug: 'Cisplatine', severity: 'major', effect: 'Ototoxicité', recommendation: 'CI' }
    ],
    monitoring: ['Créatinine', 'Taux résiduel < 5 mg/L', 'Pic 30-40 mg/L'],
    pregnancyCategory: 'D',
    availableInTunisia: true,
    tunisiaPrice: '20-40 DT',
    requiresPrescription: true
  },

  // ============ FLUOROQUINOLONES ============
  {
    id: 'ciprofloxacin',
    name: 'Ciflox®',
    genericName: 'Ciprofloxacine',
    class: 'fluoroquinolone',
    spectrum: 'broad-spectrum',
    route: ['PO', 'IV'],
    standardDose: {
      adult: '500mg PO / 400mg IV',
      frequency: 'toutes les 12h',
      duration: '7-14 jours',
      maxDose: '1.5g PO ou 1.2g IV/jour'
    },
    renalAdjustment: [
      { gfr: '30-50', dose: '250-500mg/12h' },
      { gfr: '<30', dose: '250-500mg/24h' }
    ],
    indications: [
      'Infections urinaires compliquées',
      'Prostatite',
      'Infections digestives',
      'Infections osseuses (en association)',
      'Infections à Pseudomonas'
    ],
    contraindications: [
      'Antécédent de tendinopathie sous FQ',
      'Enfant < 18 ans (sauf mucoviscidose)',
      'Grossesse, allaitement',
      'Myasthénie'
    ],
    sideEffects: [
      'Tendinopathie, rupture tendineuse',
      'Neuropathie périphérique',
      'Allongement QT',
      'Photosensibilisation',
      'Troubles digestifs'
    ],
    interactions: [
      { drug: 'Théophylline', severity: 'major', effect: 'Toxicité théophylline', recommendation: 'Réduire dose 50%' },
      { drug: 'Tizanidine', severity: 'major', effect: 'Toxicité tizanidine', recommendation: 'CI' },
      { drug: 'Antiacides/Fer/Calcium', severity: 'moderate', effect: 'Diminution absorption', recommendation: 'Espacer 2h' },
      { drug: 'Anticoagulants', severity: 'moderate', effect: 'Augmentation INR', recommendation: 'Surveiller INR' },
      { drug: 'AINS', severity: 'moderate', effect: 'Risque convulsions', recommendation: 'Prudence' }
    ],
    monitoring: ['Fonction rénale', 'ECG si facteurs de risque QT'],
    pregnancyCategory: 'C',
    availableInTunisia: true,
    tunisiaPrice: '10-25 DT',
    requiresPrescription: true,
    notes: 'Éviter si alternative existe. Risque de C. difficile élevé.'
  },
  {
    id: 'levofloxacin',
    name: 'Tavanic®',
    genericName: 'Lévofloxacine',
    class: 'fluoroquinolone',
    spectrum: 'broad-spectrum',
    route: ['PO', 'IV'],
    standardDose: {
      adult: '500-750mg',
      frequency: 'une fois par jour',
      duration: '5-14 jours',
      maxDose: '750mg/jour'
    },
    renalAdjustment: [
      { gfr: '20-49', dose: '500mg puis 250mg/24h' },
      { gfr: '<20', dose: '500mg puis 250mg/48h' }
    ],
    indications: [
      'Pneumonie communautaire',
      'EABC',
      'Sinusite aiguë (si échec)',
      'Infections urinaires',
      'Infections cutanées'
    ],
    contraindications: [
      'Antécédent tendinopathie sous FQ',
      'Épilepsie',
      'Myasthénie'
    ],
    sideEffects: [
      'Tendinopathie',
      'Neuropathie',
      'Allongement QT',
      'Hypoglycémie',
      'Troubles psychiatriques'
    ],
    interactions: [
      { drug: 'Médicaments allongeant QT', severity: 'major', effect: 'Torsades de pointes', recommendation: 'Éviter association' },
      { drug: 'Antidiabétiques', severity: 'moderate', effect: 'Dys glycémie', recommendation: 'Surveillance glycémique' },
      { drug: 'Corticoïdes', severity: 'moderate', effect: 'Risque tendineux accru', recommendation: 'Éviter association' }
    ],
    monitoring: ['ECG', 'Glycémie si diabétique', 'Symptômes tendineux'],
    pregnancyCategory: 'C',
    availableInTunisia: true,
    tunisiaPrice: '30-60 DT',
    requiresPrescription: true
  },

  // ============ MACROLIDES ============
  {
    id: 'azithromycin',
    name: 'Zithromax®',
    genericName: 'Azithromycine',
    class: 'macrolide',
    spectrum: 'atypical',
    route: ['PO', 'IV'],
    standardDose: {
      adult: '500mg J1, puis 250mg/jour',
      frequency: 'une fois par jour',
      duration: '3-5 jours (Z-pack)',
      maxDose: '500mg/jour'
    },
    renalAdjustment: [
      { gfr: '<10', dose: 'Prudence, pas d\'ajustement', notes: 'Élimination biliaire' }
    ],
    indications: [
      'Infections respiratoires (pneumonie atypique)',
      'Infections ORL',
      'IST (Chlamydia, gonorrhée)',
      'Maladie du légionnaire',
      'Prophylaxie MAC (VIH)'
    ],
    contraindications: [
      'Allergie aux macrolides',
      'Allongement QT',
      'Association avec ergotamine'
    ],
    sideEffects: [
      'Diarrhée',
      'Nausées',
      'Allongement QT',
      'Perte auditive (rare)'
    ],
    interactions: [
      { drug: 'Médicaments allongeant QT', severity: 'major', effect: 'Torsades de pointes', recommendation: 'Éviter' },
      { drug: 'Digoxine', severity: 'moderate', effect: 'Augmentation digoxinémie', recommendation: 'Surveiller' },
      { drug: 'Statines', severity: 'moderate', effect: 'Rhabdomyolyse', recommendation: 'Surveillance clinique' },
      { drug: 'Anticoagulants', severity: 'moderate', effect: 'Augmentation effet', recommendation: 'Surveiller INR' }
    ],
    monitoring: ['ECG si facteurs de risque'],
    pregnancyCategory: 'B',
    availableInTunisia: true,
    tunisiaPrice: '15-35 DT',
    requiresPrescription: true,
    notes: 'Moins d\'interactions que clarithromycine (pas d\'inhibition CYP3A4 significative)'
  },
  {
    id: 'clarithromycin',
    name: 'Zeclar®',
    genericName: 'Clarithromycine',
    class: 'macrolide',
    spectrum: 'atypical',
    route: ['PO', 'IV'],
    standardDose: {
      adult: '500mg',
      frequency: 'toutes les 12h',
      duration: '7-14 jours',
      maxDose: '1g/jour'
    },
    renalAdjustment: [
      { gfr: '<30', dose: '250mg/12h ou 500mg/24h' }
    ],
    indications: [
      'Éradication H. pylori',
      'Infections respiratoires',
      'Infections cutanées',
      'MAC (VIH)',
      'Maladie de Lyme'
    ],
    contraindications: [
      'Allergie aux macrolides',
      'Association colchicine + IR',
      'Allongement QT'
    ],
    sideEffects: [
      'Dysgueusie (goût métallique)',
      'Nausées',
      'Allongement QT',
      'Hépatotoxicité'
    ],
    interactions: [
      { drug: 'Colchicine', severity: 'major', effect: 'Toxicité colchicine mortelle', recommendation: 'CI si IR' },
      { drug: 'Statines', severity: 'major', effect: 'Rhabdomyolyse', recommendation: 'Arrêter statine' },
      { drug: 'Carbamazépine', severity: 'major', effect: 'Toxicité CBZ', recommendation: 'Surveillance taux' },
      { drug: 'Ergotamine', severity: 'major', effect: 'Ergotisme', recommendation: 'CI' }
    ],
    monitoring: ['Fonction hépatique', 'ECG'],
    pregnancyCategory: 'C',
    availableInTunisia: true,
    tunisiaPrice: '20-40 DT',
    requiresPrescription: true,
    notes: 'Inhibiteur puissant CYP3A4 - nombreuses interactions!'
  },

  // ============ GLYCOPEPTIDES ============
  {
    id: 'vancomycin',
    name: 'Vancocine®',
    genericName: 'Vancomycine',
    class: 'glycopeptide',
    spectrum: 'gram-positive',
    route: ['IV'],
    standardDose: {
      adult: '15-20 mg/kg',
      frequency: 'toutes les 8-12h',
      duration: '7-14 jours',
      maxDose: '2g/dose'
    },
    renalAdjustment: [
      { gfr: '50-80', dose: '15mg/kg/12h' },
      { gfr: '20-50', dose: '15mg/kg/24h' },
      { gfr: '<20', dose: 'Selon dosages', notes: 'Taux cible 15-20 mg/L' }
    ],
    indications: [
      'Infections à SARM',
      'Endocardite à staphylocoque',
      'Méningite à pneumocoque R',
      'Infections sur matériel',
      'Colite à C. difficile (PO)'
    ],
    contraindications: [
      'Allergie à la vancomycine'
    ],
    sideEffects: [
      'Red man syndrome (perfusion rapide)',
      'Néphrotoxicité',
      'Ototoxicité',
      'Thrombophlébite'
    ],
    interactions: [
      { drug: 'Aminosides', severity: 'major', effect: 'Néphrotoxicité synergique', recommendation: 'Surveillance créatinine' },
      { drug: 'Amphotéricine B', severity: 'major', effect: 'Néphrotoxicité', recommendation: 'Éviter' },
      { drug: 'Diurétiques de l\'anse', severity: 'moderate', effect: 'Ototoxicité', recommendation: 'Prudence' }
    ],
    monitoring: ['Taux résiduel (15-20 mg/L)', 'Créatinine', 'NFS'],
    pregnancyCategory: 'C',
    availableInTunisia: true,
    tunisiaPrice: '50-100 DT',
    requiresPrescription: true,
    notes: 'Perfuser en 1-2h pour éviter red man syndrome. Dosage obligatoire.'
  },

  // ============ NITROIMIDAZOLES ============
  {
    id: 'metronidazole',
    name: 'Flagyl®',
    genericName: 'Métronidazole',
    class: 'nitroimidazole',
    spectrum: 'anaerobic',
    route: ['PO', 'IV'],
    standardDose: {
      adult: '500mg',
      frequency: 'toutes les 8h',
      duration: '7-14 jours',
      maxDose: '4g/jour'
    },
    renalAdjustment: [
      { gfr: '<10', dose: '50% dose', notes: 'Ou espacer à 12h' }
    ],
    hepaticAdjustment: 'Réduire dose de 50% si insuffisance hépatique sévère',
    indications: [
      'Infections à anaérobies',
      'Colite à C. difficile',
      'Vaginose bactérienne',
      'Amibiase',
      'Giardiase',
      'H. pylori (en association)'
    ],
    contraindications: [
      'Premier trimestre grossesse',
      'Allaitement (relatif)'
    ],
    sideEffects: [
      'Nausées, goût métallique',
      'Neuropathie périphérique (prolongé)',
      'Effet antabuse avec alcool',
      'Leucopénie (rare)'
    ],
    interactions: [
      { drug: 'Alcool', severity: 'major', effect: 'Effet antabuse', recommendation: 'CI pendant traitement + 48h après' },
      { drug: 'Anticoagulants oraux', severity: 'major', effect: 'Augmentation INR importante', recommendation: 'Réduire dose AVK 30-50%' },
      { drug: 'Lithium', severity: 'moderate', effect: 'Toxicité lithium', recommendation: 'Surveiller lithémie' },
      { drug: 'Disulfiram', severity: 'major', effect: 'Psychose aiguë', recommendation: 'CI' }
    ],
    monitoring: ['NFS si prolongé', 'Symptômes neurologiques'],
    pregnancyCategory: 'B',
    availableInTunisia: true,
    tunisiaPrice: '5-15 DT',
    requiresPrescription: true
  },

  // ============ ANTIFUNGALS ============
  {
    id: 'fluconazole',
    name: 'Triflucan®',
    genericName: 'Fluconazole',
    class: 'antifungal',
    spectrum: 'antifungal',
    route: ['PO', 'IV'],
    standardDose: {
      adult: '200-400mg',
      frequency: 'une fois par jour',
      duration: '14-21 jours',
      maxDose: '800mg/jour'
    },
    renalAdjustment: [
      { gfr: '<50', dose: '50% dose', notes: 'Dose de charge normale' }
    ],
    indications: [
      'Candidose oropharyngée',
      'Candidose oesophagienne',
      'Candidémie',
      'Cryptococcose (entretien)',
      'Prophylaxie antifongique'
    ],
    contraindications: [
      'Allergie aux azolés',
      'Grossesse (1er trimestre)'
    ],
    sideEffects: [
      'Nausées',
      'Hépatotoxicité',
      'Allongement QT',
      'Éruption cutanée'
    ],
    interactions: [
      { drug: 'Médicaments allongeant QT', severity: 'major', effect: 'Torsades de pointes', recommendation: 'Éviter' },
      { drug: 'Ciclosporine', severity: 'major', effect: 'Néphrotoxicité', recommendation: 'Réduire dose ciclo 50%' },
      { drug: 'Tacrolimus', severity: 'major', effect: 'Toxicité tacro', recommendation: 'Réduire dose tacro' },
      { drug: 'Statines', severity: 'major', effect: 'Rhabdomyolyse', recommendation: 'Éviter ou réduire dose' },
      { drug: 'Anticoagulants oraux', severity: 'major', effect: 'Augmentation INR', recommendation: 'Surveiller étroitement' }
    ],
    monitoring: ['Transaminases', 'ECG', 'INR si AVK'],
    pregnancyCategory: 'D',
    availableInTunisia: true,
    tunisiaPrice: '30-80 DT',
    requiresPrescription: true,
    notes: 'Inhibiteur CYP2C9 et CYP3A4 - nombreuses interactions'
  },

  // ============ SULFONAMIDES ============
  {
    id: 'cotrimoxazole',
    name: 'Bactrim®',
    genericName: 'Sulfaméthoxazole/Triméthoprime',
    class: 'sulfonamide',
    spectrum: 'broad-spectrum',
    route: ['PO', 'IV'],
    standardDose: {
      adult: '800/160mg (Forte)',
      frequency: 'toutes les 12h',
      duration: '7-14 jours',
      maxDose: '1920/320mg/jour'
    },
    renalAdjustment: [
      { gfr: '15-30', dose: '50% dose' },
      { gfr: '<15', dose: 'Non recommandé', notes: 'Sauf PCP' }
    ],
    indications: [
      'Infections urinaires',
      'Pneumocystose (PCP)',
      'Infections à SARM-C',
      'Nocardiose',
      'Prophylaxie VIH'
    ],
    contraindications: [
      'Allergie aux sulfamides',
      'Insuffisance hépatique sévère',
      'Déficit en G6PD',
      'Grossesse (T1 et T3)'
    ],
    sideEffects: [
      'Éruption cutanée (Stevens-Johnson)',
      'Hyperkaliémie',
      'Cytopénies',
      'Néphrotoxicité',
      'Hépatotoxicité'
    ],
    interactions: [
      { drug: 'Méthotrexate', severity: 'major', effect: 'Toxicité MTX', recommendation: 'CI' },
      { drug: 'Anticoagulants', severity: 'major', effect: 'Augmentation INR significative', recommendation: 'Réduire AVK 25-50%' },
      { drug: 'IEC/ARA2', severity: 'moderate', effect: 'Hyperkaliémie', recommendation: 'Surveiller K+' },
      { drug: 'Phénytoïne', severity: 'moderate', effect: 'Toxicité phénytoïne', recommendation: 'Surveiller taux' }
    ],
    monitoring: ['NFS', 'Créatinine', 'Kaliémie', 'Transaminases'],
    pregnancyCategory: 'D',
    availableInTunisia: true,
    tunisiaPrice: '5-15 DT',
    requiresPrescription: true,
    notes: 'Risque d\'hyperkaliémie surtout chez sujet âgé/IR/IEC'
  }
];

// Get antibiotic by ID
export function getAntibioticById(id: string): Antibiotic | undefined {
  return antibiotics.find(a => a.id === id);
}

// Get antibiotics by class
export function getAntibioticsByClass(className: string): Antibiotic[] {
  return antibiotics.filter(a => a.class === className);
}

// Search antibiotics
export function searchAntibiotics(query: string): Antibiotic[] {
  const lowerQuery = query.toLowerCase();
  return antibiotics.filter(a =>
    a.name.toLowerCase().includes(lowerQuery) ||
    a.genericName.toLowerCase().includes(lowerQuery) ||
    a.indications.some(i => i.toLowerCase().includes(lowerQuery))
  );
}
