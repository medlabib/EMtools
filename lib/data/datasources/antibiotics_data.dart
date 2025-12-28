import '../../domain/entities/antibiotic.dart';

/// Antibiotics database for EMtools
/// Updated: 2025 (Latest Recommendations)
/// 
/// TRADEMARK NOTICE: Brand names (e.g., Augmentin®, Rocephine®) are registered
/// trademarks of their respective pharmaceutical companies. Their use here is
/// purely informational and does not imply endorsement or affiliation.
/// 
/// MEDICAL DISCLAIMER: This data is for educational purposes only. Always verify
/// dosages with official references before clinical use.

final List<Antibiotic> allAntibiotics = [
  // ============ PENICILLINS ============
  const Antibiotic(
    id: 'amoxicillin',
    name: 'Amoxal®',
    genericName: 'Amoxicilline',
    antibioticClass: AntibioticClass.penicillin,
    spectrum: SpectrumType.broad,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '1g',
      frequency: 'toutes les 8h',
      duration: '7-10 jours',
      maxDose: '6g/jour',
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '10-30', dose: '500mg q12h'),
      RenalAdjustment(gfr: '<10', dose: '500mg q24h'),
    ],
    indications: [
      'Otite moyenne aiguë',
      'Sinusite bactérienne',
      'Pneumonie communautaire',
      'Infection urinaire (si sensible)',
      'H. pylori (en association)',
    ],
    contraindications: [
      'Allergie aux pénicillines',
      'Mononucléose infectieuse (risque rash)',
    ],
    sideEffects: [
      'Diarrhée',
      'Nausées',
      'Rash cutané',
      'Réaction allergique',
    ],
    interactions: [
      DrugInteraction(
        drug: 'Allopurinol',
        severity: InteractionSeverity.moderate,
        effect: 'Augmentation risque rash cutané',
      ),
      DrugInteraction(
        drug: 'Méthotrexate',
        severity: InteractionSeverity.major,
        effect: 'Augmentation toxicité méthotrexate',
      ),
      DrugInteraction(
        drug: 'Warfarine',
        severity: InteractionSeverity.moderate,
        effect: 'Augmentation INR',
      ),
    ],
    pregnancyCategory: 'B',
    availableInTunisia: true,
    tunisiaPrice: '5-15 DT',
    requiresPrescription: true,
  ),
  const Antibiotic(
    id: 'amoxicillin-clavulanate',
    name: 'Augmentin®',
    genericName: 'Amoxicilline + Acide Clavulanique',
    antibioticClass: AntibioticClass.penicillin,
    spectrum: SpectrumType.broad,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '1g/125mg',
      frequency: 'toutes les 8h',
      duration: '7-14 jours',
      maxDose: '3g/jour (amox)',
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '10-30', dose: '500/62.5mg q12h'),
      RenalAdjustment(gfr: '<10', dose: '500/62.5mg q24h'),
    ],
    hepaticAdjustment: 'Prudence si insuffisance hépatique',
    indications: [
      'Infections ORL résistantes',
      'Pneumonie d\'aspiration',
      'Infections urinaires compliquées',
      'Infections peau et tissus mous',
      'Morsures animales',
    ],
    contraindications: [
      'Allergie aux pénicillines',
      'Antécédent d\'ictère/hépatite sous Augmentin',
    ],
    sideEffects: [
      'Diarrhée (fréquent)',
      'Hépatite cholestatique',
      'Candidose',
    ],
    interactions: [
      DrugInteraction(
        drug: 'Allopurinol',
        severity: InteractionSeverity.moderate,
        effect: 'Risque rash',
      ),
      DrugInteraction(
        drug: 'Contraceptifs oraux',
        severity: InteractionSeverity.minor,
        effect: 'Diminution efficacité possible',
      ),
    ],
    pregnancyCategory: 'B',
    availableInTunisia: true,
    tunisiaPrice: '15-30 DT',
    requiresPrescription: true,
  ),
  const Antibiotic(
    id: 'penicillin-g',
    name: 'Pénicilline G®',
    genericName: 'Benzylpénicilline',
    antibioticClass: AntibioticClass.penicillin,
    spectrum: SpectrumType.narrow,
    route: ['IV', 'IM'],
    standardDose: DoseInfo(
      adult: '2-4 millions UI',
      frequency: 'toutes les 4-6h',
      duration: 'Variable',
      maxDose: '24 millions UI/jour',
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '10-50', dose: '75% dose normale'),
      RenalAdjustment(gfr: '<10', dose: '20-50% dose normale'),
    ],
    indications: [
      'Syphilis',
      'Méningite à méningocoque',
      'Érysipèle',
      'Gangrène gazeuse',
      'Endocardite à streptocoque',
    ],
    contraindications: [
      'Allergie aux pénicillines',
    ],
    sideEffects: [
      'Réaction Jarisch-Herxheimer (syphilis)',
      'Convulsions (hautes doses)',
      'Troubles électrolytiques (Na+, K+)',
    ],
    interactions: [],
    pregnancyCategory: 'B',
    availableInTunisia: true,
    tunisiaPrice: '< 5 DT',
    requiresPrescription: true,
  ),

  // ============ CEPHALOSPORINS ============
  const Antibiotic(
    id: 'cefalexin',
    name: 'Keforal®',
    genericName: 'Céfalexine',
    antibioticClass: AntibioticClass.cephalosporin,
    spectrum: SpectrumType.gramPositive,
    route: ['PO'],
    standardDose: DoseInfo(
      adult: '500mg',
      frequency: 'toutes les 6h',
      duration: '7-10 jours',
      maxDose: '4g/jour',
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '10-50', dose: '500mg q8-12h'),
      RenalAdjustment(gfr: '<10', dose: '250-500mg q12-24h'),
    ],
    indications: [
      'Infections cutanées simples',
      'Pharyngite à streptocoque',
      'Infection urinaire simple (alternative)',
    ],
    contraindications: [
      'Allergie aux céphalosporines',
      'Allergie sévère aux pénicillines (croisée)',
    ],
    sideEffects: [
      'Troubles digestifs',
      'C. difficile',
    ],
    interactions: [
      DrugInteraction(
        drug: 'Metformine',
        severity: InteractionSeverity.moderate,
        effect: 'Augmentation concentration metformine',
      ),
    ],
    pregnancyCategory: 'B',
    availableInTunisia: true,
    tunisiaPrice: '10-20 DT',
    requiresPrescription: true,
  ),
  const Antibiotic(
    id: 'ceftriaxone',
    name: 'Rocephine®',
    genericName: 'Ceftriaxone',
    antibioticClass: AntibioticClass.cephalosporin,
    spectrum: SpectrumType.broad,
    route: ['IV', 'IM'],
    standardDose: DoseInfo(
      adult: '1-2g',
      frequency: 'une fois par jour',
      duration: 'Variable',
      maxDose: '4g/jour (méningite)',
    ),
    renalAdjustment: [], // Pas d'ajustement nécessaire
    hepaticAdjustment: 'Pas d\'ajustement nécessaire',
    indications: [
      'Pneumonie communautaire sévère',
      'Méningite bactérienne',
      'Pyélonéphrite aiguë',
      'Gonorrhée',
      'Maladie de Lyme',
    ],
    contraindications: [
      'Allergie aux céphalosporines',
      'Nouveau-né avec hyperbilirubinémie',
      'Administration concomitante de Calcium IV',
    ],
    sideEffects: [
      'Boue biliaire (pseudo-lithiase)',
      'Diarrhée',
      'Douleur au point d\'injection',
    ],
    interactions: [
      DrugInteraction(
        drug: 'Calcium IV',
        severity: InteractionSeverity.major,
        effect: 'Précipitation (fatal chez nouveau-né)',
        recommendation: 'Ne pas mélanger, espacer de 48h chez nouveau-né',
      ),
      DrugInteraction(
        drug: 'AVK',
        severity: InteractionSeverity.moderate,
        effect: 'Augmentation INR',
      ),
    ],
    pregnancyCategory: 'B',
    availableInTunisia: true,
    tunisiaPrice: '15-40 DT',
    requiresPrescription: true,
  ),
  const Antibiotic(
    id: 'cefotaxime',
    name: 'Claforan®',
    genericName: 'Céfotaxime',
    antibioticClass: AntibioticClass.cephalosporin,
    spectrum: SpectrumType.broad,
    route: ['IV', 'IM'],
    standardDose: DoseInfo(
      adult: '1-2g',
      frequency: 'toutes les 8h',
      duration: 'Variable',
      maxDose: '12g/jour',
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '10-50', dose: '1-2g q12h'),
      RenalAdjustment(gfr: '<10', dose: '1-2g q24h'),
    ],
    indications: [
      'Méningite bactérienne',
      'Pneumonie nosocomiale',
      'Sepsis',
      'Péritonite spontanée',
    ],
    contraindications: [
      'Allergie aux céphalosporines',
    ],
    sideEffects: [
      'Rash',
      'Fièvre médicamenteuse',
      'Leucopénie',
    ],
    interactions: [],
    pregnancyCategory: 'B',
    availableInTunisia: true,
    tunisiaPrice: '10-30 DT',
    requiresPrescription: true,
  ),
  const Antibiotic(
    id: 'ceftazidime',
    name: 'Fortum®',
    genericName: 'Ceftazidime',
    antibioticClass: AntibioticClass.cephalosporin,
    spectrum: SpectrumType.gramNegative,
    route: ['IV', 'IM'],
    standardDose: DoseInfo(
      adult: '1-2g',
      frequency: 'toutes les 8h',
      duration: '7-14 jours',
      maxDose: '6g/jour',
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '30-50', dose: '1g q12h'),
      RenalAdjustment(gfr: '10-30', dose: '1g q24h'),
      RenalAdjustment(gfr: '<10', dose: '500mg q24-48h'),
    ],
    indications: [
      'Infections à Pseudomonas',
      'Neutropénie fébrile',
      'Pneumonie nosocomiale',
      'Méningite à Gram négatif',
    ],
    contraindications: [
      'Allergie aux céphalosporines',
    ],
    sideEffects: [
      'C. difficile',
      'Neurotoxicité (si non ajusté)',
      'Élévation enzymes hépatiques',
    ],
    interactions: [
      DrugInteraction(
        drug: 'Aminosides',
        severity: InteractionSeverity.moderate,
        effect: 'Néphrotoxicité additive',
      ),
    ],
    pregnancyCategory: 'B',
    availableInTunisia: true,
    tunisiaPrice: '20-50 DT',
    requiresPrescription: true,
  ),

  // ============ CARBAPENEMS ============
  const Antibiotic(
    id: 'imipenem',
    name: 'Tienam®',
    genericName: 'Imipénème/Cilastatine',
    antibioticClass: AntibioticClass.carbapenem,
    spectrum: SpectrumType.broad,
    route: ['IV'],
    standardDose: DoseInfo(
      adult: '500mg',
      frequency: 'toutes les 6h',
      duration: '7-14 jours',
      maxDose: '4g/jour',
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '20-40', dose: '250mg q6h'),
      RenalAdjustment(gfr: '<20', dose: '250mg q12h'),
    ],
    indications: [
      'Infections nosocomiales sévères',
      'Infections intra-abdominales compliquées',
      'Infections à germes multirésistants (BLSE)',
      'Neutropénie fébrile',
    ],
    contraindications: [
      'Allergie aux carbapénèmes',
      'Allergie sévère aux pénicillines',
      'Antécédents de convulsions',
    ],
    sideEffects: [
      'Convulsions (surtout si IR ou fortes doses)',
      'Nausées/Vomissements',
      'Rash',
    ],
    interactions: [
      DrugInteraction(
        drug: 'Acide valproïque',
        severity: InteractionSeverity.major,
        effect: 'Diminution rapide des taux de valproate',
        recommendation: 'Contre-indiqué, risque convulsif',
      ),
      DrugInteraction(
        drug: 'Ganciclovir',
        severity: InteractionSeverity.major,
        effect: 'Risque convulsif accru',
      ),
    ],
    pregnancyCategory: 'C',
    availableInTunisia: true,
    tunisiaPrice: 'Hôpital',
    requiresPrescription: true,
  ),
  const Antibiotic(
    id: 'ertapenem',
    name: 'Invanz®',
    genericName: 'Ertapénème',
    antibioticClass: AntibioticClass.carbapenem,
    spectrum: SpectrumType.broad,
    route: ['IV', 'IM'],
    standardDose: DoseInfo(
      adult: '1g',
      frequency: 'une fois par jour',
      duration: '7-14 jours',
      maxDose: '1g/jour',
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '<30', dose: '500mg q24h'),
    ],
    indications: [
      'Infections intra-abdominales',
      'Pneumonie communautaire sévère',
      'Infections du pied diabétique',
      'Infections pelviennes aiguës',
    ],
    contraindications: [
      'Allergie aux carbapénèmes',
      'Allergie sévère aux pénicillines',
    ],
    sideEffects: [
      'Diarrhée',
      'Céphalées',
      'Phlébite',
    ],
    interactions: [
      DrugInteraction(
        drug: 'Acide valproïque',
        severity: InteractionSeverity.major,
        effect: 'Diminution taux valproate',
        recommendation: 'Contre-indiqué',
      ),
    ],
    pregnancyCategory: 'B',
    availableInTunisia: true,
    tunisiaPrice: 'Hôpital',
    requiresPrescription: true,
    notes: 'Ne couvre PAS Pseudomonas ni Enterococcus',
  ),

  // ============ AMINOGLYCOSIDES ============
  const Antibiotic(
    id: 'gentamicin',
    name: 'Gentamicine®',
    genericName: 'Gentamicine',
    antibioticClass: AntibioticClass.aminoglycoside,
    spectrum: SpectrumType.gramNegative,
    route: ['IV', 'IM'],
    standardDose: DoseInfo(
      adult: '5-7 mg/kg',
      frequency: 'une fois par jour (DUJ)',
      duration: 'Court terme (<5j)',
      maxDose: 'Selon taux sériques',
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '40-60', dose: 'q36h ou ajuster dose'),
      RenalAdjustment(gfr: '20-40', dose: 'q48h ou ajuster dose'),
      RenalAdjustment(gfr: '<20', dose: 'Dosage sérique obligatoire'),
    ],
    indications: [
      'Sepsis à Gram négatif sévère',
      'Endocardite (synergie)',
      'Infections urinaires sévères',
    ],
    contraindications: [
      'Allergie aux aminosides',
      'Myasthénie',
      'Grossesse (risque surdité fœtale)',
    ],
    sideEffects: [
      'Néphrotoxicité (réversible)',
      'Ototoxicité (irréversible)',
      'Blocage neuromusculaire',
    ],
    interactions: [
      DrugInteraction(
        drug: 'Diurétiques de l\'anse',
        severity: InteractionSeverity.moderate,
        effect: 'Ototoxicité accrue',
      ),
      DrugInteraction(
        drug: 'Autres néphrotoxiques',
        severity: InteractionSeverity.moderate,
        effect: 'Néphrotoxicité accrue',
      ),
    ],
    monitoring: ['Créatinine', 'Dosage résiduel et pic'],
    pregnancyCategory: 'D',
    availableInTunisia: true,
    tunisiaPrice: '< 10 DT',
    requiresPrescription: true,
  ),
  const Antibiotic(
    id: 'amikacin',
    name: 'Amikacine®',
    genericName: 'Amikacine',
    antibioticClass: AntibioticClass.aminoglycoside,
    spectrum: SpectrumType.gramNegative,
    route: ['IV', 'IM'],
    standardDose: DoseInfo(
      adult: '15 mg/kg',
      frequency: 'une fois par jour',
      duration: 'Court terme',
      maxDose: '1.5g/jour',
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: 'Ajuster selon clairance', dose: 'Espacer les doses'),
    ],
    indications: [
      'Infections nosocomiales sévères',
      'Germes résistants à la gentamicine',
      'Mycobactéries atypiques',
    ],
    contraindications: [
      'Allergie aux aminosides',
      'Myasthénie',
    ],
    sideEffects: [
      'Néphrotoxicité',
      'Ototoxicité (auditive > vestibulaire)',
    ],
    interactions: [
      DrugInteraction(
        drug: 'Néphrotoxiques',
        severity: InteractionSeverity.moderate,
        effect: 'Risque rénal accru',
      ),
    ],
    monitoring: ['Créatinine', 'Audiogramme si prolongé'],
    pregnancyCategory: 'D',
    availableInTunisia: true,
    tunisiaPrice: '10-30 DT',
    requiresPrescription: true,
  ),

  // ============ FLUOROQUINOLONES ============
  const Antibiotic(
    id: 'ciprofloxacin',
    name: 'Ciproxine®',
    genericName: 'Ciprofloxacine',
    antibioticClass: AntibioticClass.fluoroquinolone,
    spectrum: SpectrumType.gramNegative,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '500mg',
      frequency: 'toutes les 12h',
      duration: '7-14 jours',
      maxDose: '1.5g/jour',
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '30-50', dose: '250-500mg q12h'),
      RenalAdjustment(gfr: '<30', dose: '500mg q24h'),
    ],
    indications: [
      'Infections urinaires (pyélonéphrite)',
      'Prostatite',
      'Infections à Pseudomonas',
      'Diarrhée du voyageur',
      'Infections osseuses',
    ],
    contraindications: [
      'Allergie aux quinolones',
      'Grossesse',
      'Enfant (sauf mucoviscidose)',
      'Tendinopathie',
    ],
    sideEffects: [
      'Tendinite / Rupture tendon d\'Achille',
      'Allongement QT',
      'Confusion (sujet âgé)',
      'Photosensibilité',
      'Anévrisme aortique (rare)',
    ],
    interactions: [
      DrugInteraction(
        drug: 'Théophylline',
        severity: InteractionSeverity.major,
        effect: 'Toxicité théophylline',
      ),
      DrugInteraction(
        drug: 'Antiocides/Fer/Calcium',
        severity: InteractionSeverity.moderate,
        effect: 'Diminution absorption Cipro',
        recommendation: 'Espacer de 2-4h',
      ),
      DrugInteraction(
        drug: 'Warfarine',
        severity: InteractionSeverity.moderate,
        effect: 'Augmentation INR',
      ),
    ],
    pregnancyCategory: 'C',
    availableInTunisia: true,
    tunisiaPrice: '15-40 DT',
    requiresPrescription: true,
  ),
  const Antibiotic(
    id: 'levofloxacin',
    name: 'Tavanic®',
    genericName: 'Lévofloxacine',
    antibioticClass: AntibioticClass.fluoroquinolone,
    spectrum: SpectrumType.broad,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '500mg ou 750mg',
      frequency: 'une fois par jour',
      duration: '5-14 jours',
      maxDose: '750mg/jour',
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '20-50', dose: '750mg puis 750mg q48h'),
      RenalAdjustment(gfr: '10-19', dose: '750mg puis 500mg q48h'),
    ],
    indications: [
      'Pneumonie communautaire',
      'Sinusite aiguë',
      'Exacerbation BPCO',
      'Infections urinaires compliquées',
      'Infections peau et tissus mous',
    ],
    contraindications: [
      'Allergie aux quinolones',
      'Épilepsie',
      'Grossesse',
      'Allongement QT connu',
    ],
    sideEffects: [
      'Tendinopathie',
      'Allongement QT',
      'Dysglycémie (diabétiques)',
      'Neuropathie périphérique',
    ],
    interactions: [
      DrugInteraction(
        drug: 'Antidiabétiques',
        severity: InteractionSeverity.moderate,
        effect: 'Risque hypo/hyperglycémie',
      ),
      DrugInteraction(
        drug: 'AINS',
        severity: InteractionSeverity.moderate,
        effect: 'Risque convulsif accru',
      ),
    ],
    pregnancyCategory: 'C',
    availableInTunisia: true,
    tunisiaPrice: '30-60 DT',
    requiresPrescription: true,
  ),

  // ============ MACROLIDES ============
  const Antibiotic(
    id: 'azithromycin',
    name: 'Zitromax®',
    genericName: 'Azithromycine',
    antibioticClass: AntibioticClass.macrolide,
    spectrum: SpectrumType.atypical,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '500mg J1 puis 250mg J2-J5',
      frequency: 'une fois par jour',
      duration: '3-5 jours',
      maxDose: '500mg/jour',
    ),
    renalAdjustment: [], // Pas d'ajustement
    indications: [
      'Pneumonie atypique',
      'Angine (si allergie pénicilline)',
      'Urétrite à Chlamydia (dose unique 1g)',
      'BPCO exacerbation',
    ],
    contraindications: [
      'Allergie aux macrolides',
      'Insuffisance hépatique sévère',
    ],
    sideEffects: [
      'Troubles digestifs',
      'Allongement QT',
      'Hépatotoxicité (rare)',
    ],
    interactions: [
      DrugInteraction(
        drug: 'Médicaments allongeant QT',
        severity: InteractionSeverity.major,
        effect: 'Risque torsades de pointes',
      ),
      DrugInteraction(
        drug: 'Warfarine',
        severity: InteractionSeverity.minor,
        effect: 'Possible augmentation INR',
      ),
    ],
    pregnancyCategory: 'B',
    availableInTunisia: true,
    tunisiaPrice: '15-30 DT',
    requiresPrescription: true,
  ),
  const Antibiotic(
    id: 'clarithromycin',
    name: 'Zeclar®',
    genericName: 'Clarithromycine',
    antibioticClass: AntibioticClass.macrolide,
    spectrum: SpectrumType.atypical,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '500mg',
      frequency: 'toutes les 12h',
      duration: '7-14 jours',
      maxDose: '1g/jour',
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '<30', dose: '50% dose'),
    ],
    indications: [
      'H. pylori (trithérapie)',
      'Pneumonie communautaire',
      'Sinusite',
      'Infections à mycobactéries',
    ],
    contraindications: [
      'Allergie aux macrolides',
      'Prise de statines (simvastatine)',
      'Allongement QT',
    ],
    sideEffects: [
      'Goût métallique',
      'Troubles digestifs',
      'Allongement QT',
    ],
    interactions: [
      DrugInteraction(
        drug: 'Statines',
        severity: InteractionSeverity.major,
        effect: 'Rhabdomyolyse',
        recommendation: 'Arrêter statine pendant traitement',
      ),
      DrugInteraction(
        drug: 'Colchicine',
        severity: InteractionSeverity.major,
        effect: 'Toxicité colchicine fatale',
        recommendation: 'Contre-indiqué',
      ),
    ],
    pregnancyCategory: 'C',
    availableInTunisia: true,
    tunisiaPrice: '20-40 DT',
    requiresPrescription: true,
    notes: 'Inhibiteur puissant du CYP3A4',
  ),

  // ============ GLYCOPEPTIDES ============
  const Antibiotic(
    id: 'vancomycin',
    name: 'Vancomycine',
    genericName: 'Vancomycine',
    antibioticClass: AntibioticClass.glycopeptide,
    spectrum: SpectrumType.gramPositive,
    route: ['IV', 'PO (C. diff)'],
    standardDose: DoseInfo(
      adult: '15-20 mg/kg',
      frequency: 'toutes les 8-12h',
      duration: 'Variable',
      maxDose: '2g/dose',
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '40-60', dose: 'q24h'),
      RenalAdjustment(gfr: '<40', dose: 'Selon taux sériques'),
    ],
    indications: [
      'SARM (MRSA)',
      'Infections sévères à Gram positif',
      'C. difficile (voie orale uniquement)',
      'Méningite (en association)',
    ],
    contraindications: [
      'Allergie à la vancomycine',
    ],
    sideEffects: [
      'Red Man Syndrome (perfusion rapide)',
      'Néphrotoxicité',
      'Ototoxicité (rare)',
      'Neutropénie (prolongé)',
    ],
    interactions: [
      DrugInteraction(
        drug: 'Aminosides',
        severity: InteractionSeverity.moderate,
        effect: 'Néphrotoxicité additive',
      ),
      DrugInteraction(
        drug: 'Pipéracilline-Tazobactam',
        severity: InteractionSeverity.moderate,
        effect: 'Risque IRA accru',
      ),
    ],
    monitoring: ['Taux résiduel (cible 15-20 mg/L sévère)', 'Créatinine'],
    pregnancyCategory: 'C',
    availableInTunisia: true,
    tunisiaPrice: '50-100 DT',
    requiresPrescription: true,
    notes: 'Perfuser en 1-2h pour éviter red man syndrome. Dosage obligatoire.',
  ),

  // ============ NITROIMIDAZOLES ============
  const Antibiotic(
    id: 'metronidazole',
    name: 'Flagyl®',
    genericName: 'Métronidazole',
    antibioticClass: AntibioticClass.nitroimidazole,
    spectrum: SpectrumType.anaerobic,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '500mg',
      frequency: 'toutes les 8h',
      duration: '7-14 jours',
      maxDose: '4g/jour',
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '<10', dose: '50% dose', notes: 'Ou espacer à 12h'),
    ],
    hepaticAdjustment: 'Réduire dose de 50% si insuffisance hépatique sévère',
    indications: [
      'Infections à anaérobies',
      'Colite à C. difficile',
      'Vaginose bactérienne',
      'Amibiase',
      'Giardiase',
      'H. pylori (en association)',
    ],
    contraindications: [
      'Premier trimestre grossesse',
      'Allaitement (relatif)',
    ],
    sideEffects: [
      'Nausées, goût métallique',
      'Neuropathie périphérique (prolongé)',
      'Effet antabuse avec alcool',
      'Leucopénie (rare)',
    ],
    interactions: [
      DrugInteraction(
        drug: 'Alcool',
        severity: InteractionSeverity.major,
        effect: 'Effet antabuse',
        recommendation: 'CI pendant traitement + 48h après',
      ),
      DrugInteraction(
        drug: 'Anticoagulants oraux',
        severity: InteractionSeverity.major,
        effect: 'Augmentation INR importante',
        recommendation: 'Réduire dose AVK 30-50%',
      ),
      DrugInteraction(
        drug: 'Lithium',
        severity: InteractionSeverity.moderate,
        effect: 'Toxicité lithium',
        recommendation: 'Surveiller lithémie',
      ),
      DrugInteraction(
        drug: 'Disulfiram',
        severity: InteractionSeverity.major,
        effect: 'Psychose aiguë',
        recommendation: 'CI',
      ),
    ],
    monitoring: ['NFS si prolongé', 'Symptômes neurologiques'],
    pregnancyCategory: 'B',
    availableInTunisia: true,
    tunisiaPrice: '5-15 DT',
    requiresPrescription: true,
  ),

  // ============ ANTIFUNGALS ============
  const Antibiotic(
    id: 'fluconazole',
    name: 'Triflucan®',
    genericName: 'Fluconazole',
    antibioticClass: AntibioticClass.other, // Mapped to other as antifungal is not in enum
    spectrum: SpectrumType.broad, // Mapped to broad as antifungal is not in enum
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '200-400mg',
      frequency: 'une fois par jour',
      duration: '14-21 jours',
      maxDose: '800mg/jour',
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '<50', dose: '50% dose', notes: 'Dose de charge normale'),
    ],
    indications: [
      'Candidose oropharyngée',
      'Candidose oesophagienne',
      'Candidémie',
      'Cryptococcose (entretien)',
      'Prophylaxie antifongique',
    ],
    contraindications: [
      'Allergie aux azolés',
      'Grossesse (1er trimestre)',
    ],
    sideEffects: [
      'Nausées',
      'Hépatotoxicité',
      'Allongement QT',
      'Éruption cutanée',
    ],
    interactions: [
      DrugInteraction(
        drug: 'Médicaments allongeant QT',
        severity: InteractionSeverity.major,
        effect: 'Torsades de pointes',
        recommendation: 'Éviter',
      ),
      DrugInteraction(
        drug: 'Ciclosporine',
        severity: InteractionSeverity.major,
        effect: 'Néphrotoxicité',
        recommendation: 'Réduire dose ciclo 50%',
      ),
      DrugInteraction(
        drug: 'Tacrolimus',
        severity: InteractionSeverity.major,
        effect: 'Toxicité tacro',
        recommendation: 'Réduire dose tacro',
      ),
      DrugInteraction(
        drug: 'Statines',
        severity: InteractionSeverity.major,
        effect: 'Rhabdomyolyse',
        recommendation: 'Éviter ou réduire dose',
      ),
      DrugInteraction(
        drug: 'Anticoagulants oraux',
        severity: InteractionSeverity.major,
        effect: 'Augmentation INR',
        recommendation: 'Surveiller étroitement',
      ),
    ],
    monitoring: ['Transaminases', 'ECG', 'INR si AVK'],
    pregnancyCategory: 'D',
    availableInTunisia: true,
    tunisiaPrice: '30-80 DT',
    requiresPrescription: true,
    notes: 'Inhibiteur CYP2C9 et CYP3A4 - nombreuses interactions',
  ),

  // ============ SULFONAMIDES ============
  const Antibiotic(
    id: 'cotrimoxazole',
    name: 'Bactrim®',
    genericName: 'Sulfaméthoxazole/Triméthoprime',
    antibioticClass: AntibioticClass.sulfonamide,
    spectrum: SpectrumType.broad,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '800/160mg (Forte)',
      frequency: 'toutes les 12h',
      duration: '7-14 jours',
      maxDose: '1920/320mg/jour',
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '15-30', dose: '50% dose'),
      RenalAdjustment(gfr: '<15', dose: 'Non recommandé', notes: 'Sauf PCP'),
    ],
    indications: [
      'Infections urinaires',
      'Pneumocystose (PCP)',
      'Infections à SARM-C',
      'Nocardiose',
      'Prophylaxie VIH',
    ],
    contraindications: [
      'Allergie aux sulfamides',
      'Insuffisance hépatique sévère',
      'Déficit en G6PD',
      'Grossesse (T1 et T3)',
    ],
    sideEffects: [
      'Éruption cutanée (Stevens-Johnson)',
      'Hyperkaliémie',
      'Cytopénies',
      'Néphrotoxicité',
      'Hépatotoxicité',
    ],
    interactions: [
      DrugInteraction(
        drug: 'Méthotrexate',
        severity: InteractionSeverity.major,
        effect: 'Toxicité MTX',
        recommendation: 'CI',
      ),
      DrugInteraction(
        drug: 'Anticoagulants',
        severity: InteractionSeverity.major,
        effect: 'Augmentation INR significative',
        recommendation: 'Réduire AVK 25-50%',
      ),
      DrugInteraction(
        drug: 'IEC/ARA2',
        severity: InteractionSeverity.moderate,
        effect: 'Hyperkaliémie',
        recommendation: 'Surveiller K+',
      ),
      DrugInteraction(
        drug: 'Phénytoïne',
        severity: InteractionSeverity.moderate,
        effect: 'Toxicité phénytoïne',
        recommendation: 'Surveiller taux',
      ),
    ],
    monitoring: ['NFS', 'Créatinine', 'Kaliémie', 'Transaminases'],
    pregnancyCategory: 'D',
    availableInTunisia: true,
    tunisiaPrice: '5-15 DT',
    requiresPrescription: true,
    notes: 'Risque d\'hyperkaliémie surtout chez sujet âgé/IR/IEC',
  ),
];
