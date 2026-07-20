import '../../domain/entities/antibiotic.dart';
import '../../core/l10n/localized.dart';

/// Antibiotics database for EMtools
/// Updated: 2025-2026 (US/EU guidelines: ASHP/IDSA, EUCAST, Sanford)
///
/// TRADEMARK NOTICE: Brand names (e.g., Augmentin®, Rocephine®) are registered
/// trademarks of their respective pharmaceutical companies. Their use here is
/// purely informational and does not imply endorsement or affiliation.
///
/// MEDICAL DISCLAIMER: This data is for educational purposes only. Always verify
/// dosages with official references before clinical use.
///
/// NOTE ON PREGNANCY LETTERS: The FDA A/B/C/D/X letter categories were phased out
/// (PLLR, 2015) and are retained here only as a quick legacy reference.

final List<Antibiotic> allAntibiotics = [
  // ============ PENICILLINS ============
  const Antibiotic(
    id: 'amoxicillin',
    name: 'Amoxil®',
    genericName: LString('Amoxicilline', 'Amoxicillin'),
    antibioticClass: AntibioticClass.penicillin,
    spectrum: SpectrumType.broad,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '500mg-1g',
      frequency: LString('toutes les 8h', 'every 8h'),
      duration: LString('5-10 jours', '5-10 days'),
      maxDose: LString('6g/jour', '6g/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '10-30', dose: LString('500mg q12h', '500mg q12h')),
      RenalAdjustment(gfr: '<10', dose: LString('500mg q24h', '500mg q24h')),
    ],
    indications: [
      LString('Otite moyenne aiguë', 'Acute otitis media'),
      LString('Sinusite bactérienne', 'Bacterial sinusitis'),
      LString('Pneumonie communautaire', 'Community-acquired pneumonia'),
      LString('Infection urinaire (si sensible)', 'Urinary tract infection (if susceptible)'),
      LString('H. pylori (en association)', 'H. pylori (combination therapy)'),
    ],
    contraindications: [
      LString('Allergie aux pénicillines', 'Penicillin allergy'),
      LString('Mononucléose infectieuse (risque rash)', 'Infectious mononucleosis (rash risk)'),
    ],
    sideEffects: [
      LString('Diarrhée', 'Diarrhea'),
      LString('Nausées', 'Nausea'),
      LString('Rash cutané', 'Skin rash'),
      LString('Réaction allergique', 'Allergic reaction'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Allopurinol',
        severity: InteractionSeverity.moderate,
        effect: LString('Augmentation risque rash cutané', 'Increased risk of skin rash'),
      ),
      DrugInteraction(
        drug: 'Methotrexate',
        severity: InteractionSeverity.major,
        effect: LString('Augmentation toxicité méthotrexate', 'Increased methotrexate toxicity'),
      ),
      DrugInteraction(
        drug: 'Warfarine',
        severity: InteractionSeverity.moderate,
        effect: LString('Augmentation INR', 'Increased INR'),
      ),
    ],
    pregnancyCategory: 'B',
    requiresPrescription: true,
  ),
  const Antibiotic(
    id: 'amoxicillin-clavulanate',
    name: 'Augmentin®',
    genericName: LString('Amoxicilline + Acide clavulanique', 'Amoxicillin + Clavulanate'),
    antibioticClass: AntibioticClass.penicillin,
    spectrum: SpectrumType.broad,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '875/125mg',
      frequency: LString('toutes les 12h (PO)', 'every 12h (PO)'),
      duration: LString('5-14 jours', '5-14 days'),
      maxDose: LString('3g/jour (amox, PO)', '3g/day (amox, PO)'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '10-30', dose: LString('500/125mg q12h', '500/125mg q12h')),
      RenalAdjustment(gfr: '<10', dose: LString('500/125mg q24h', '500/125mg q24h')),
    ],
    hepaticAdjustment: LString('Prudence si insuffisance hépatique', 'Caution in hepatic impairment'),
    indications: [
      LString('Infections ORL résistantes', 'Resistant ENT infections'),
      LString('Pneumonie d\'aspiration', 'Aspiration pneumonia'),
      LString('Infections urinaires compliquées', 'Complicated urinary tract infections'),
      LString('Infections peau et tissus mous', 'Skin and soft tissue infections'),
      LString('Morsures animales/humaines', 'Animal/human bites'),
    ],
    contraindications: [
      LString('Allergie aux pénicillines', 'Penicillin allergy'),
      LString('Antécédent d\'ictère/hépatite sous Augmentin', 'Prior cholestatic jaundice/hepatitis with co-amoxiclav'),
    ],
    sideEffects: [
      LString('Diarrhée (fréquent)', 'Diarrhea (common)'),
      LString('Hépatite cholestatique', 'Cholestatic hepatitis'),
      LString('Candidose', 'Candidiasis'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Allopurinol',
        severity: InteractionSeverity.moderate,
        effect: LString('Risque de rash', 'Rash risk'),
      ),
      DrugInteraction(
        drug: 'Contraceptifs oraux',
        severity: InteractionSeverity.minor,
        effect: LString('Diminution efficacité possible', 'Possible reduced efficacy'),
      ),
    ],
    pregnancyCategory: 'B',
    requiresPrescription: true,
  ),
  const Antibiotic(
    id: 'piperacillin-tazobactam',
    name: 'Tazocin® / Zosyn®',
    genericName: LString('Pipéracilline + Tazobactam', 'Piperacillin + Tazobactam'),
    antibioticClass: AntibioticClass.penicillin,
    spectrum: SpectrumType.broad,
    route: ['IV'],
    standardDose: DoseInfo(
      adult: '4.5g',
      frequency: LString('toutes les 6-8h (perfusion prolongée 4h)', 'every 6-8h (extended 4h infusion)'),
      duration: LString('Variable', 'Variable'),
      maxDose: LString('18g/jour', '18g/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '20-40', dose: LString('3.375g q6h', '3.375g q6h')),
      RenalAdjustment(gfr: '<20', dose: LString('2.25g q6h ou 3.375g q8h', '2.25g q6h or 3.375g q8h')),
    ],
    indications: [
      LString('Sepsis / choc septique (couverture empirique large)', 'Sepsis / septic shock (broad empiric cover)'),
      LString('Pneumonie nosocomiale / VAP', 'Hospital-acquired / ventilator-associated pneumonia'),
      LString('Infections intra-abdominales', 'Intra-abdominal infections'),
      LString('Neutropénie fébrile', 'Febrile neutropenia'),
      LString('Infection du pied diabétique', 'Diabetic foot infection'),
    ],
    contraindications: [
      LString('Allergie aux pénicillines', 'Penicillin allergy'),
    ],
    sideEffects: [
      LString('Diarrhée / C. difficile', 'Diarrhea / C. difficile'),
      LString('Néphrotoxicité (majorée avec vancomycine)', 'Nephrotoxicity (increased with vancomycin)'),
      LString('Thrombopénie', 'Thrombocytopenia'),
      LString('Hypokaliémie', 'Hypokalemia'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Vancomycine',
        severity: InteractionSeverity.moderate,
        effect: LString('Risque d\'insuffisance rénale aiguë accru', 'Increased risk of acute kidney injury'),
        recommendation: LString('Surveiller créatinine rapprochée', 'Monitor creatinine closely'),
      ),
      DrugInteraction(
        drug: 'Methotrexate',
        severity: InteractionSeverity.major,
        effect: LString('Toxicité méthotrexate', 'Methotrexate toxicity'),
      ),
    ],
    monitoring: [
      LString('Fonction rénale', 'Renal function'),
      LString('NFS si traitement prolongé', 'CBC if prolonged therapy'),
    ],
    pregnancyCategory: 'B',
    requiresPrescription: true,
    notes: LString('Perfusion prolongée (4h) recommandée pour optimiser le temps > CMI.',
        'Extended (4h) infusion recommended to optimise time > MIC.'),
  ),
  const Antibiotic(
    id: 'penicillin-g',
    name: 'Pénicilline G®',
    genericName: LString('Benzylpénicilline', 'Benzylpenicillin'),
    antibioticClass: AntibioticClass.penicillin,
    spectrum: SpectrumType.narrow,
    route: ['IV', 'IM'],
    standardDose: DoseInfo(
      adult: '2-4 MUI',
      frequency: LString('toutes les 4-6h', 'every 4-6h'),
      duration: LString('Variable', 'Variable'),
      maxDose: LString('24 MUI/jour', '24 MU/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '10-50', dose: LString('75% de la dose', '75% of dose')),
      RenalAdjustment(gfr: '<10', dose: LString('20-50% de la dose', '20-50% of dose')),
    ],
    indications: [
      LString('Syphilis', 'Syphilis'),
      LString('Méningite à méningocoque', 'Meningococcal meningitis'),
      LString('Érysipèle', 'Erysipelas'),
      LString('Gangrène gazeuse', 'Gas gangrene'),
      LString('Endocardite à streptocoque', 'Streptococcal endocarditis'),
    ],
    contraindications: [
      LString('Allergie aux pénicillines', 'Penicillin allergy'),
    ],
    sideEffects: [
      LString('Réaction Jarisch-Herxheimer (syphilis)', 'Jarisch-Herxheimer reaction (syphilis)'),
      LString('Convulsions (hautes doses)', 'Seizures (high doses)'),
      LString('Troubles électrolytiques (Na+, K+)', 'Electrolyte disturbances (Na+, K+)'),
    ],
    interactions: [],
    pregnancyCategory: 'B',
    requiresPrescription: true,
  ),

  // ============ CEPHALOSPORINS ============
  const Antibiotic(
    id: 'cefazolin',
    name: 'Céfacidal® / Ancef®',
    genericName: LString('Céfazoline', 'Cefazolin'),
    antibioticClass: AntibioticClass.cephalosporin,
    spectrum: SpectrumType.gramPositive,
    route: ['IV', 'IM'],
    standardDose: DoseInfo(
      adult: '1-2g',
      frequency: LString('toutes les 8h', 'every 8h'),
      duration: LString('Variable', 'Variable'),
      maxDose: LString('12g/jour', '12g/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '10-35', dose: LString('1-2g q12h', '1-2g q12h')),
      RenalAdjustment(gfr: '<10', dose: LString('1-2g q24h', '1-2g q24h')),
    ],
    indications: [
      LString('Antibioprophylaxie chirurgicale (1re intention)', 'Surgical prophylaxis (first-line)'),
      LString('Infections à SASM (MSSA)', 'MSSA infections'),
      LString('Infections cutanées', 'Skin infections'),
      LString('Endocardite à SASM', 'MSSA endocarditis'),
    ],
    contraindications: [
      LString('Allergie aux céphalosporines', 'Cephalosporin allergy'),
      LString('Anaphylaxie aux pénicillines', 'Penicillin anaphylaxis'),
    ],
    sideEffects: [
      LString('Réaction au point d\'injection', 'Injection site reaction'),
      LString('Rash', 'Rash'),
      LString('C. difficile', 'C. difficile'),
    ],
    interactions: [],
    pregnancyCategory: 'B',
    requiresPrescription: true,
    notes: LString('Agent de choix pour les infections à SASM (préféré aux pénicillines M).',
        'Agent of choice for MSSA infections (preferred over antistaphylococcal penicillins).'),
  ),
  const Antibiotic(
    id: 'cefalexin',
    name: 'Keforal®',
    genericName: LString('Céfalexine', 'Cephalexin'),
    antibioticClass: AntibioticClass.cephalosporin,
    spectrum: SpectrumType.gramPositive,
    route: ['PO'],
    standardDose: DoseInfo(
      adult: '500mg',
      frequency: LString('toutes les 6h', 'every 6h'),
      duration: LString('5-10 jours', '5-10 days'),
      maxDose: LString('4g/jour', '4g/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '10-50', dose: LString('500mg q8-12h', '500mg q8-12h')),
      RenalAdjustment(gfr: '<10', dose: LString('250-500mg q12-24h', '250-500mg q12-24h')),
    ],
    indications: [
      LString('Infections cutanées simples', 'Simple skin infections'),
      LString('Pharyngite à streptocoque', 'Streptococcal pharyngitis'),
      LString('Infection urinaire simple (alternative)', 'Simple urinary tract infection (alternative)'),
    ],
    contraindications: [
      LString('Allergie aux céphalosporines', 'Cephalosporin allergy'),
      LString('Allergie sévère aux pénicillines (croisée)', 'Severe penicillin allergy (cross-reactivity)'),
    ],
    sideEffects: [
      LString('Troubles digestifs', 'GI upset'),
      LString('C. difficile', 'C. difficile'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Metformine',
        severity: InteractionSeverity.moderate,
        effect: LString('Augmentation concentration metformine', 'Increased metformin concentration'),
      ),
    ],
    pregnancyCategory: 'B',
    requiresPrescription: true,
  ),
  const Antibiotic(
    id: 'cefuroxime',
    name: 'Zinnat® / Zinacef®',
    genericName: LString('Céfuroxime', 'Cefuroxime'),
    antibioticClass: AntibioticClass.cephalosporin,
    spectrum: SpectrumType.broad,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '500mg PO / 750mg-1.5g IV',
      frequency: LString('toutes les 8-12h', 'every 8-12h'),
      duration: LString('5-10 jours', '5-10 days'),
      maxDose: LString('4.5g/jour (IV)', '4.5g/day (IV)'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '10-20', dose: LString('750mg q12h (IV)', '750mg q12h (IV)')),
      RenalAdjustment(gfr: '<10', dose: LString('750mg q24h (IV)', '750mg q24h (IV)')),
    ],
    indications: [
      LString('Pneumonie communautaire', 'Community-acquired pneumonia'),
      LString('Sinusite / otite', 'Sinusitis / otitis'),
      LString('Infections urinaires', 'Urinary tract infections'),
      LString('Maladie de Lyme précoce (PO)', 'Early Lyme disease (PO)'),
    ],
    contraindications: [
      LString('Allergie aux céphalosporines', 'Cephalosporin allergy'),
    ],
    sideEffects: [
      LString('Troubles digestifs', 'GI upset'),
      LString('Rash', 'Rash'),
      LString('C. difficile', 'C. difficile'),
    ],
    interactions: [],
    pregnancyCategory: 'B',
    requiresPrescription: true,
  ),
  const Antibiotic(
    id: 'ceftriaxone',
    name: 'Rocephine®',
    genericName: LString('Ceftriaxone', 'Ceftriaxone'),
    antibioticClass: AntibioticClass.cephalosporin,
    spectrum: SpectrumType.broad,
    route: ['IV', 'IM'],
    standardDose: DoseInfo(
      adult: '1-2g',
      frequency: LString('une fois par jour', 'once daily'),
      duration: LString('Variable', 'Variable'),
      maxDose: LString('2g q12h (méningite)', '2g q12h (meningitis)'),
    ),
    renalAdjustment: [],
    hepaticAdjustment: LString('Pas d\'ajustement systématique', 'No routine adjustment'),
    indications: [
      LString('Pneumonie communautaire sévère', 'Severe community-acquired pneumonia'),
      LString('Méningite bactérienne', 'Bacterial meningitis'),
      LString('Pyélonéphrite aiguë', 'Acute pyelonephritis'),
      LString('Gonorrhée (500mg IM, 1g si >150kg)', 'Gonorrhea (500mg IM, 1g if >150kg)'),
      LString('Maladie de Lyme (formes disséminées)', 'Lyme disease (disseminated forms)'),
    ],
    contraindications: [
      LString('Allergie aux céphalosporines', 'Cephalosporin allergy'),
      LString('Nouveau-né avec hyperbilirubinémie', 'Neonate with hyperbilirubinemia'),
      LString('Administration concomitante de calcium IV (nouveau-né)', 'Concomitant IV calcium (neonate)'),
    ],
    sideEffects: [
      LString('Boue biliaire (pseudo-lithiase)', 'Biliary sludge (pseudolithiasis)'),
      LString('Diarrhée', 'Diarrhea'),
      LString('Douleur au point d\'injection', 'Injection site pain'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Calcium IV',
        severity: InteractionSeverity.major,
        effect: LString('Précipitation (fatale chez le nouveau-né)', 'Precipitation (fatal in neonates)'),
        recommendation: LString('Ne pas mélanger; espacer de 48h chez le nouveau-né', 'Do not co-administer; separate by 48h in neonates'),
      ),
      DrugInteraction(
        drug: 'AVK',
        severity: InteractionSeverity.moderate,
        effect: LString('Augmentation INR', 'Increased INR'),
      ),
    ],
    pregnancyCategory: 'B',
    requiresPrescription: true,
  ),
  const Antibiotic(
    id: 'cefotaxime',
    name: 'Claforan®',
    genericName: LString('Céfotaxime', 'Cefotaxime'),
    antibioticClass: AntibioticClass.cephalosporin,
    spectrum: SpectrumType.broad,
    route: ['IV', 'IM'],
    standardDose: DoseInfo(
      adult: '1-2g',
      frequency: LString('toutes les 8h', 'every 8h'),
      duration: LString('Variable', 'Variable'),
      maxDose: LString('12g/jour', '12g/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '10-50', dose: LString('1-2g q12h', '1-2g q12h')),
      RenalAdjustment(gfr: '<10', dose: LString('1-2g q24h', '1-2g q24h')),
    ],
    indications: [
      LString('Méningite bactérienne', 'Bacterial meningitis'),
      LString('Pneumonie nosocomiale', 'Hospital-acquired pneumonia'),
      LString('Sepsis', 'Sepsis'),
      LString('Péritonite bactérienne spontanée', 'Spontaneous bacterial peritonitis'),
    ],
    contraindications: [
      LString('Allergie aux céphalosporines', 'Cephalosporin allergy'),
    ],
    sideEffects: [
      LString('Rash', 'Rash'),
      LString('Fièvre médicamenteuse', 'Drug fever'),
      LString('Leucopénie', 'Leukopenia'),
    ],
    interactions: [],
    pregnancyCategory: 'B',
    requiresPrescription: true,
  ),
  const Antibiotic(
    id: 'ceftazidime',
    name: 'Fortum®',
    genericName: LString('Ceftazidime', 'Ceftazidime'),
    antibioticClass: AntibioticClass.cephalosporin,
    spectrum: SpectrumType.gramNegative,
    route: ['IV', 'IM'],
    standardDose: DoseInfo(
      adult: '2g',
      frequency: LString('toutes les 8h', 'every 8h'),
      duration: LString('7-14 jours', '7-14 days'),
      maxDose: LString('6g/jour', '6g/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '30-50', dose: LString('1g q12h', '1g q12h')),
      RenalAdjustment(gfr: '10-30', dose: LString('1g q24h', '1g q24h')),
      RenalAdjustment(gfr: '<10', dose: LString('500mg q24-48h', '500mg q24-48h')),
    ],
    indications: [
      LString('Infections à Pseudomonas', 'Pseudomonas infections'),
      LString('Neutropénie fébrile', 'Febrile neutropenia'),
      LString('Pneumonie nosocomiale', 'Hospital-acquired pneumonia'),
      LString('Méningite à Gram négatif', 'Gram-negative meningitis'),
    ],
    contraindications: [
      LString('Allergie aux céphalosporines', 'Cephalosporin allergy'),
    ],
    sideEffects: [
      LString('C. difficile', 'C. difficile'),
      LString('Neurotoxicité (si non ajusté)', 'Neurotoxicity (if not dose-adjusted)'),
      LString('Élévation des enzymes hépatiques', 'Elevated liver enzymes'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Aminosides',
        severity: InteractionSeverity.moderate,
        effect: LString('Néphrotoxicité additive', 'Additive nephrotoxicity'),
      ),
    ],
    pregnancyCategory: 'B',
    requiresPrescription: true,
  ),
  const Antibiotic(
    id: 'cefepime',
    name: 'Axepim® / Maxipime®',
    genericName: LString('Céfépime', 'Cefepime'),
    antibioticClass: AntibioticClass.cephalosporin,
    spectrum: SpectrumType.broad,
    route: ['IV', 'IM'],
    standardDose: DoseInfo(
      adult: '2g',
      frequency: LString('toutes les 8-12h', 'every 8-12h'),
      duration: LString('7-14 jours', '7-14 days'),
      maxDose: LString('6g/jour', '6g/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '30-60', dose: LString('2g q12h', '2g q12h')),
      RenalAdjustment(gfr: '11-29', dose: LString('2g q24h', '2g q24h')),
      RenalAdjustment(gfr: '<11', dose: LString('1g q24h', '1g q24h')),
    ],
    indications: [
      LString('Neutropénie fébrile', 'Febrile neutropenia'),
      LString('Pneumonie nosocomiale / VAP', 'Hospital-acquired / ventilator-associated pneumonia'),
      LString('Infections à Pseudomonas', 'Pseudomonas infections'),
      LString('Infections urinaires compliquées', 'Complicated urinary tract infections'),
    ],
    contraindications: [
      LString('Allergie aux céphalosporines', 'Cephalosporin allergy'),
    ],
    sideEffects: [
      LString('Neurotoxicité / encéphalopathie (si IR non ajustée)', 'Neurotoxicity / encephalopathy (if renal dose not adjusted)'),
      LString('C. difficile', 'C. difficile'),
      LString('Rash', 'Rash'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Aminosides',
        severity: InteractionSeverity.moderate,
        effect: LString('Néphrotoxicité additive', 'Additive nephrotoxicity'),
      ),
    ],
    monitoring: [
      LString('Fonction rénale (risque de neurotoxicité)', 'Renal function (neurotoxicity risk)'),
    ],
    pregnancyCategory: 'B',
    requiresPrescription: true,
    notes: LString('Ajuster impérativement à la fonction rénale (risque d\'encéphalopathie).',
        'Must be dose-adjusted to renal function (encephalopathy risk).'),
  ),

  // ============ CARBAPENEMS ============
  const Antibiotic(
    id: 'meropenem',
    name: 'Meronem® / Merrem®',
    genericName: LString('Méropénème', 'Meropenem'),
    antibioticClass: AntibioticClass.carbapenem,
    spectrum: SpectrumType.broad,
    route: ['IV'],
    standardDose: DoseInfo(
      adult: '1g',
      frequency: LString('toutes les 8h (2g q8h si méningite/Pseudomonas)', 'every 8h (2g q8h for meningitis/Pseudomonas)'),
      duration: LString('Variable', 'Variable'),
      maxDose: LString('6g/jour', '6g/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '26-50', dose: LString('1g q12h', '1g q12h')),
      RenalAdjustment(gfr: '10-25', dose: LString('500mg q12h', '500mg q12h')),
      RenalAdjustment(gfr: '<10', dose: LString('500mg q24h', '500mg q24h')),
    ],
    indications: [
      LString('Sepsis sévère / choc septique (BLSE)', 'Severe sepsis / septic shock (ESBL)'),
      LString('Infections intra-abdominales compliquées', 'Complicated intra-abdominal infections'),
      LString('Méningite bactérienne', 'Bacterial meningitis'),
      LString('Pneumonie nosocomiale / VAP', 'Hospital-acquired / ventilator-associated pneumonia'),
      LString('Neutropénie fébrile', 'Febrile neutropenia'),
    ],
    contraindications: [
      LString('Allergie aux carbapénèmes', 'Carbapenem allergy'),
      LString('Anaphylaxie aux bêta-lactamines', 'Beta-lactam anaphylaxis'),
    ],
    sideEffects: [
      LString('Convulsions (moins que l\'imipénème)', 'Seizures (less than imipenem)'),
      LString('Diarrhée / C. difficile', 'Diarrhea / C. difficile'),
      LString('Thrombocytose', 'Thrombocytosis'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Acide valproïque',
        severity: InteractionSeverity.major,
        effect: LString('Chute rapide des taux de valproate (risque convulsif)', 'Rapid fall in valproate levels (seizure risk)'),
        recommendation: LString('Association déconseillée', 'Avoid combination'),
      ),
    ],
    pregnancyCategory: 'B',
    requiresPrescription: true,
    notes: LString('Carbapénème de référence en réanimation; couvre les BLSE.',
        'Preferred carbapenem in critical care; covers ESBL producers.'),
  ),
  const Antibiotic(
    id: 'imipenem',
    name: 'Tienam®',
    genericName: LString('Imipénème/Cilastatine', 'Imipenem/Cilastatin'),
    antibioticClass: AntibioticClass.carbapenem,
    spectrum: SpectrumType.broad,
    route: ['IV'],
    standardDose: DoseInfo(
      adult: '500mg',
      frequency: LString('toutes les 6h', 'every 6h'),
      duration: LString('7-14 jours', '7-14 days'),
      maxDose: LString('4g/jour', '4g/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '20-40', dose: LString('250mg q6h', '250mg q6h')),
      RenalAdjustment(gfr: '<20', dose: LString('250mg q12h', '250mg q12h')),
    ],
    indications: [
      LString('Infections nosocomiales sévères', 'Severe nosocomial infections'),
      LString('Infections intra-abdominales compliquées', 'Complicated intra-abdominal infections'),
      LString('Infections à germes multirésistants (BLSE)', 'Multidrug-resistant infections (ESBL)'),
      LString('Neutropénie fébrile', 'Febrile neutropenia'),
    ],
    contraindications: [
      LString('Allergie aux carbapénèmes', 'Carbapenem allergy'),
      LString('Allergie sévère aux pénicillines', 'Severe penicillin allergy'),
      LString('Antécédents de convulsions', 'History of seizures'),
    ],
    sideEffects: [
      LString('Convulsions (surtout si IR ou fortes doses)', 'Seizures (especially with renal impairment or high doses)'),
      LString('Nausées / vomissements', 'Nausea / vomiting'),
      LString('Rash', 'Rash'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Acide valproïque',
        severity: InteractionSeverity.major,
        effect: LString('Diminution rapide des taux de valproate', 'Rapid reduction in valproate levels'),
        recommendation: LString('Contre-indiqué (risque convulsif)', 'Contraindicated (seizure risk)'),
      ),
      DrugInteraction(
        drug: 'Ganciclovir',
        severity: InteractionSeverity.major,
        effect: LString('Risque convulsif accru', 'Increased seizure risk'),
      ),
    ],
    pregnancyCategory: 'C',
    requiresPrescription: true,
  ),
  const Antibiotic(
    id: 'ertapenem',
    name: 'Invanz®',
    genericName: LString('Ertapénème', 'Ertapenem'),
    antibioticClass: AntibioticClass.carbapenem,
    spectrum: SpectrumType.broad,
    route: ['IV', 'IM'],
    standardDose: DoseInfo(
      adult: '1g',
      frequency: LString('une fois par jour', 'once daily'),
      duration: LString('7-14 jours', '7-14 days'),
      maxDose: LString('1g/jour', '1g/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '<30', dose: LString('500mg q24h', '500mg q24h')),
    ],
    indications: [
      LString('Infections intra-abdominales', 'Intra-abdominal infections'),
      LString('Pneumonie communautaire sévère', 'Severe community-acquired pneumonia'),
      LString('Infections du pied diabétique', 'Diabetic foot infections'),
      LString('Infections pelviennes aiguës', 'Acute pelvic infections'),
    ],
    contraindications: [
      LString('Allergie aux carbapénèmes', 'Carbapenem allergy'),
      LString('Allergie sévère aux pénicillines', 'Severe penicillin allergy'),
    ],
    sideEffects: [
      LString('Diarrhée', 'Diarrhea'),
      LString('Céphalées', 'Headache'),
      LString('Phlébite', 'Phlebitis'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Acide valproïque',
        severity: InteractionSeverity.major,
        effect: LString('Diminution des taux de valproate', 'Reduced valproate levels'),
        recommendation: LString('Contre-indiqué', 'Contraindicated'),
      ),
    ],
    pregnancyCategory: 'B',
    requiresPrescription: true,
    notes: LString('Ne couvre PAS Pseudomonas, Acinetobacter ni Enterococcus.',
        'Does NOT cover Pseudomonas, Acinetobacter or Enterococcus.'),
  ),

  // ============ AMINOGLYCOSIDES ============
  const Antibiotic(
    id: 'gentamicin',
    name: 'Gentamicine®',
    genericName: LString('Gentamicine', 'Gentamicin'),
    antibioticClass: AntibioticClass.aminoglycoside,
    spectrum: SpectrumType.gramNegative,
    route: ['IV', 'IM'],
    standardDose: DoseInfo(
      adult: '5-7 mg/kg',
      frequency: LString('une fois par jour (dose unique journalière)', 'once daily (extended-interval dosing)'),
      duration: LString('Court terme (<5j si possible)', 'Short course (<5 days if possible)'),
      maxDose: LString('Selon taux sériques', 'Guided by serum levels'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '40-60', dose: LString('Espacer à q36h ou ajuster', 'Extend to q36h or adjust')),
      RenalAdjustment(gfr: '20-40', dose: LString('Espacer à q48h ou ajuster', 'Extend to q48h or adjust')),
      RenalAdjustment(gfr: '<20', dose: LString('Dosage sérique obligatoire', 'Serum level monitoring mandatory')),
    ],
    indications: [
      LString('Sepsis à Gram négatif sévère', 'Severe Gram-negative sepsis'),
      LString('Endocardite (synergie)', 'Endocarditis (synergy)'),
      LString('Infections urinaires sévères', 'Severe urinary tract infections'),
    ],
    contraindications: [
      LString('Allergie aux aminosides', 'Aminoglycoside allergy'),
      LString('Myasthénie', 'Myasthenia gravis'),
      LString('Grossesse (risque de surdité fœtale)', 'Pregnancy (fetal ototoxicity risk)'),
    ],
    sideEffects: [
      LString('Néphrotoxicité (réversible)', 'Nephrotoxicity (reversible)'),
      LString('Ototoxicité (irréversible)', 'Ototoxicity (irreversible)'),
      LString('Blocage neuromusculaire', 'Neuromuscular blockade'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Diurétiques de l\'anse',
        severity: InteractionSeverity.moderate,
        effect: LString('Ototoxicité accrue', 'Increased ototoxicity'),
      ),
      DrugInteraction(
        drug: 'Autres néphrotoxiques',
        severity: InteractionSeverity.moderate,
        effect: LString('Néphrotoxicité accrue', 'Increased nephrotoxicity'),
      ),
    ],
    monitoring: [
      LString('Créatinine', 'Creatinine'),
      LString('Taux résiduel et pic', 'Trough and peak levels'),
    ],
    pregnancyCategory: 'D',
    requiresPrescription: true,
  ),
  const Antibiotic(
    id: 'amikacin',
    name: 'Amikacine®',
    genericName: LString('Amikacine', 'Amikacin'),
    antibioticClass: AntibioticClass.aminoglycoside,
    spectrum: SpectrumType.gramNegative,
    route: ['IV', 'IM'],
    standardDose: DoseInfo(
      adult: '15 mg/kg',
      frequency: LString('une fois par jour', 'once daily'),
      duration: LString('Court terme', 'Short course'),
      maxDose: LString('1.5g/jour', '1.5g/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '40-60', dose: LString('Espacer les doses / ajuster', 'Extend interval / adjust')),
      RenalAdjustment(gfr: '<40', dose: LString('Dosage sérique obligatoire', 'Serum level monitoring mandatory')),
    ],
    indications: [
      LString('Infections nosocomiales sévères', 'Severe nosocomial infections'),
      LString('Germes résistants à la gentamicine', 'Gentamicin-resistant organisms'),
      LString('Mycobactéries atypiques', 'Atypical mycobacteria'),
    ],
    contraindications: [
      LString('Allergie aux aminosides', 'Aminoglycoside allergy'),
      LString('Myasthénie', 'Myasthenia gravis'),
    ],
    sideEffects: [
      LString('Néphrotoxicité', 'Nephrotoxicity'),
      LString('Ototoxicité (auditive > vestibulaire)', 'Ototoxicity (auditory > vestibular)'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Néphrotoxiques',
        severity: InteractionSeverity.moderate,
        effect: LString('Risque rénal accru', 'Increased renal risk'),
      ),
    ],
    monitoring: [
      LString('Créatinine', 'Creatinine'),
      LString('Audiogramme si prolongé', 'Audiogram if prolonged'),
    ],
    pregnancyCategory: 'D',
    requiresPrescription: true,
  ),

  // ============ FLUOROQUINOLONES ============
  const Antibiotic(
    id: 'ciprofloxacin',
    name: 'Ciproxine® / Cipro®',
    genericName: LString('Ciprofloxacine', 'Ciprofloxacin'),
    antibioticClass: AntibioticClass.fluoroquinolone,
    spectrum: SpectrumType.gramNegative,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '500-750mg PO / 400mg IV',
      frequency: LString('toutes les 12h', 'every 12h'),
      duration: LString('5-14 jours', '5-14 days'),
      maxDose: LString('1.5g/jour (PO)', '1.5g/day (PO)'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '30-50', dose: LString('250-500mg q12h', '250-500mg q12h')),
      RenalAdjustment(gfr: '<30', dose: LString('500mg q24h', '500mg q24h')),
    ],
    indications: [
      LString('Pyélonéphrite / infections urinaires compliquées', 'Pyelonephritis / complicated UTI'),
      LString('Prostatite', 'Prostatitis'),
      LString('Infections à Pseudomonas', 'Pseudomonas infections'),
      LString('Diarrhée du voyageur', 'Traveler\'s diarrhea'),
      LString('Infections osseuses', 'Bone infections'),
    ],
    contraindications: [
      LString('Allergie aux quinolones', 'Quinolone allergy'),
      LString('Grossesse', 'Pregnancy'),
      LString('Antécédent de tendinopathie sous quinolone', 'Prior quinolone-associated tendinopathy'),
    ],
    sideEffects: [
      LString('Tendinite / rupture du tendon d\'Achille', 'Tendinitis / Achilles tendon rupture'),
      LString('Allongement du QT', 'QT prolongation'),
      LString('Confusion (sujet âgé)', 'Confusion (elderly)'),
      LString('Photosensibilité', 'Photosensitivity'),
      LString('Anévrisme / dissection aortique (rare)', 'Aortic aneurysm / dissection (rare)'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Théophylline',
        severity: InteractionSeverity.major,
        effect: LString('Toxicité de la théophylline', 'Theophylline toxicity'),
      ),
      DrugInteraction(
        drug: 'Antiacides / Fer / Calcium',
        severity: InteractionSeverity.moderate,
        effect: LString('Diminution de l\'absorption', 'Reduced absorption'),
        recommendation: LString('Espacer de 2-4h', 'Separate by 2-4h'),
      ),
      DrugInteraction(
        drug: 'Warfarine',
        severity: InteractionSeverity.moderate,
        effect: LString('Augmentation INR', 'Increased INR'),
      ),
    ],
    pregnancyCategory: 'C',
    requiresPrescription: true,
    notes: LString('FDA/EMA: réserver aux cas sans alternative (effets indésirables invalidants).',
        'FDA/EMA: reserve when no alternative exists (disabling adverse effects).'),
  ),
  const Antibiotic(
    id: 'levofloxacin',
    name: 'Tavanic® / Levaquin®',
    genericName: LString('Lévofloxacine', 'Levofloxacin'),
    antibioticClass: AntibioticClass.fluoroquinolone,
    spectrum: SpectrumType.broad,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '500-750mg',
      frequency: LString('une fois par jour', 'once daily'),
      duration: LString('5-14 jours', '5-14 days'),
      maxDose: LString('750mg/jour', '750mg/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '20-49', dose: LString('750mg puis 750mg q48h', '750mg then 750mg q48h')),
      RenalAdjustment(gfr: '10-19', dose: LString('750mg puis 500mg q48h', '750mg then 500mg q48h')),
    ],
    indications: [
      LString('Pneumonie communautaire', 'Community-acquired pneumonia'),
      LString('Sinusite aiguë', 'Acute sinusitis'),
      LString('Exacerbation de BPCO', 'COPD exacerbation'),
      LString('Infections urinaires compliquées', 'Complicated urinary tract infections'),
      LString('Infections peau et tissus mous', 'Skin and soft tissue infections'),
    ],
    contraindications: [
      LString('Allergie aux quinolones', 'Quinolone allergy'),
      LString('Épilepsie', 'Epilepsy'),
      LString('Grossesse', 'Pregnancy'),
      LString('Allongement du QT connu', 'Known QT prolongation'),
    ],
    sideEffects: [
      LString('Tendinopathie', 'Tendinopathy'),
      LString('Allongement du QT', 'QT prolongation'),
      LString('Dysglycémie (diabétiques)', 'Dysglycemia (diabetics)'),
      LString('Neuropathie périphérique', 'Peripheral neuropathy'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Antidiabétiques',
        severity: InteractionSeverity.moderate,
        effect: LString('Risque d\'hypo/hyperglycémie', 'Risk of hypo/hyperglycemia'),
      ),
      DrugInteraction(
        drug: 'AINS',
        severity: InteractionSeverity.moderate,
        effect: LString('Risque convulsif accru', 'Increased seizure risk'),
      ),
    ],
    pregnancyCategory: 'C',
    requiresPrescription: true,
  ),

  // ============ MACROLIDES ============
  const Antibiotic(
    id: 'azithromycin',
    name: 'Zithromax®',
    genericName: LString('Azithromycine', 'Azithromycin'),
    antibioticClass: AntibioticClass.macrolide,
    spectrum: SpectrumType.atypical,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '500mg',
      frequency: LString('J1 500mg puis 250mg J2-J5, 1x/j', 'day 1 500mg then 250mg days 2-5, once daily'),
      duration: LString('3-5 jours', '3-5 days'),
      maxDose: LString('500mg/jour', '500mg/day'),
    ),
    renalAdjustment: [],
    indications: [
      LString('Pneumonie atypique', 'Atypical pneumonia'),
      LString('Angine (si allergie à la pénicilline)', 'Pharyngitis (if penicillin allergy)'),
      LString('Urétrite à Chlamydia (dose unique 1g)', 'Chlamydia urethritis (single 1g dose)'),
      LString('Exacerbation de BPCO', 'COPD exacerbation'),
    ],
    contraindications: [
      LString('Allergie aux macrolides', 'Macrolide allergy'),
      LString('Insuffisance hépatique sévère', 'Severe hepatic impairment'),
    ],
    sideEffects: [
      LString('Troubles digestifs', 'GI upset'),
      LString('Allongement du QT', 'QT prolongation'),
      LString('Hépatotoxicité (rare)', 'Hepatotoxicity (rare)'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Médicaments allongeant le QT',
        severity: InteractionSeverity.major,
        effect: LString('Risque de torsades de pointes', 'Risk of torsades de pointes'),
      ),
      DrugInteraction(
        drug: 'Warfarine',
        severity: InteractionSeverity.minor,
        effect: LString('Augmentation possible de l\'INR', 'Possible increased INR'),
      ),
    ],
    pregnancyCategory: 'B',
    requiresPrescription: true,
  ),
  const Antibiotic(
    id: 'clarithromycin',
    name: 'Zeclar® / Biaxin®',
    genericName: LString('Clarithromycine', 'Clarithromycin'),
    antibioticClass: AntibioticClass.macrolide,
    spectrum: SpectrumType.atypical,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '500mg',
      frequency: LString('toutes les 12h', 'every 12h'),
      duration: LString('7-14 jours', '7-14 days'),
      maxDose: LString('1g/jour', '1g/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '<30', dose: LString('50% de la dose', '50% of dose')),
    ],
    indications: [
      LString('H. pylori (trithérapie)', 'H. pylori (triple therapy)'),
      LString('Pneumonie communautaire', 'Community-acquired pneumonia'),
      LString('Sinusite', 'Sinusitis'),
      LString('Infections à mycobactéries', 'Mycobacterial infections'),
    ],
    contraindications: [
      LString('Allergie aux macrolides', 'Macrolide allergy'),
      LString('Prise de simvastatine/lovastatine', 'Concurrent simvastatin/lovastatin'),
      LString('Allongement du QT', 'QT prolongation'),
    ],
    sideEffects: [
      LString('Goût métallique', 'Metallic taste'),
      LString('Troubles digestifs', 'GI upset'),
      LString('Allongement du QT', 'QT prolongation'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Statines',
        severity: InteractionSeverity.major,
        effect: LString('Rhabdomyolyse', 'Rhabdomyolysis'),
        recommendation: LString('Suspendre la statine pendant le traitement', 'Hold statin during therapy'),
      ),
      DrugInteraction(
        drug: 'Colchicine',
        severity: InteractionSeverity.major,
        effect: LString('Toxicité fatale de la colchicine', 'Fatal colchicine toxicity'),
        recommendation: LString('Contre-indiqué', 'Contraindicated'),
      ),
    ],
    pregnancyCategory: 'C',
    requiresPrescription: true,
    notes: LString('Inhibiteur puissant du CYP3A4.', 'Potent CYP3A4 inhibitor.'),
  ),

  // ============ GLYCOPEPTIDES ============
  const Antibiotic(
    id: 'vancomycin',
    name: 'Vancomycine',
    genericName: LString('Vancomycine', 'Vancomycin'),
    antibioticClass: AntibioticClass.glycopeptide,
    spectrum: SpectrumType.gramPositive,
    route: ['IV', 'PO (C. diff)'],
    standardDose: DoseInfo(
      adult: '15-20 mg/kg (dose de charge 25-30 mg/kg si sévère)',
      frequency: LString('toutes les 8-12h', 'every 8-12h'),
      duration: LString('Variable', 'Variable'),
      maxDose: LString('2g/dose', '2g/dose'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '40-60', dose: LString('Ajuster selon l\'AUC/dosage', 'Adjust per AUC/level')),
      RenalAdjustment(gfr: '<40', dose: LString('Dosage sérique / pilotage AUC', 'Serum level / AUC-guided')),
    ],
    indications: [
      LString('SARM (MRSA)', 'MRSA'),
      LString('Infections sévères à Gram positif', 'Severe Gram-positive infections'),
      LString('C. difficile (voie orale uniquement)', 'C. difficile (oral route only)'),
      LString('Méningite (en association)', 'Meningitis (combination therapy)'),
    ],
    contraindications: [
      LString('Allergie à la vancomycine', 'Vancomycin allergy'),
    ],
    sideEffects: [
      LString('Syndrome de perfusion (ex-« red man »)', 'Vancomycin infusion reaction (formerly «red man»)'),
      LString('Néphrotoxicité', 'Nephrotoxicity'),
      LString('Ototoxicité (rare)', 'Ototoxicity (rare)'),
      LString('Neutropénie (traitement prolongé)', 'Neutropenia (prolonged therapy)'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Aminosides',
        severity: InteractionSeverity.moderate,
        effect: LString('Néphrotoxicité additive', 'Additive nephrotoxicity'),
      ),
      DrugInteraction(
        drug: 'Pipéracilline-Tazobactam',
        severity: InteractionSeverity.moderate,
        effect: LString('Risque d\'IRA accru', 'Increased acute kidney injury risk'),
      ),
    ],
    monitoring: [
      LString('Pilotage AUC/CMI 400-600 mg·h/L (ASHP/IDSA 2020)', 'AUC/MIC-guided target 400-600 mg·h/L (ASHP/IDSA 2020)'),
      LString('Créatinine', 'Creatinine'),
    ],
    pregnancyCategory: 'C',
    requiresPrescription: true,
    notes: LString('Cible AUC/CMI 400-600 (ASHP/IDSA 2020); la surveillance par résiduelle seule 15-20 n\'est plus recommandée. Perfuser en ≥1-2h.',
        'Target AUC/MIC 400-600 (ASHP/IDSA 2020); trough-only 15-20 monitoring no longer recommended. Infuse over ≥1-2h.'),
  ),

  // ============ LINCOSAMIDES ============
  const Antibiotic(
    id: 'clindamycin',
    name: 'Dalacine® / Cleocin®',
    genericName: LString('Clindamycine', 'Clindamycin'),
    antibioticClass: AntibioticClass.lincosamide,
    spectrum: SpectrumType.gramPositive,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '600-900mg IV / 300-450mg PO',
      frequency: LString('toutes les 8h', 'every 8h'),
      duration: LString('Variable', 'Variable'),
      maxDose: LString('2.7g/jour (IV)', '2.7g/day (IV)'),
    ),
    renalAdjustment: [],
    hepaticAdjustment: LString('Prudence si insuffisance hépatique sévère', 'Caution in severe hepatic impairment'),
    indications: [
      LString('Infections à anaérobies', 'Anaerobic infections'),
      LString('Infections cutanées à SARM communautaire', 'Community-acquired MRSA skin infections'),
      LString('Fasciite nécrosante (anti-toxine, en association)', 'Necrotizing fasciitis (anti-toxin, combination)'),
      LString('Choc toxique streptococcique/staphylococcique', 'Streptococcal/staphylococcal toxic shock'),
    ],
    contraindications: [
      LString('Allergie à la clindamycine/lincomycine', 'Clindamycin/lincomycin allergy'),
    ],
    sideEffects: [
      LString('Colite à C. difficile (risque élevé)', 'C. difficile colitis (high risk)'),
      LString('Diarrhée', 'Diarrhea'),
      LString('Rash', 'Rash'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Curares',
        severity: InteractionSeverity.moderate,
        effect: LString('Potentialisation du blocage neuromusculaire', 'Potentiated neuromuscular blockade'),
      ),
    ],
    pregnancyCategory: 'B',
    requiresPrescription: true,
    notes: LString('Effet anti-toxinique utile dans les infections nécrosantes.',
        'Anti-toxin effect useful in necrotizing infections.'),
  ),

  // ============ OXAZOLIDINONES ============
  const Antibiotic(
    id: 'linezolid',
    name: 'Zyvoxid® / Zyvox®',
    genericName: LString('Linezolide', 'Linezolid'),
    antibioticClass: AntibioticClass.oxazolidinone,
    spectrum: SpectrumType.gramPositive,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '600mg',
      frequency: LString('toutes les 12h', 'every 12h'),
      duration: LString('10-14 jours (max ~28j)', '10-14 days (max ~28 days)'),
      maxDose: LString('1.2g/jour', '1.2g/day'),
    ),
    renalAdjustment: [],
    indications: [
      LString('SARM (alternative à la vancomycine)', 'MRSA (vancomycin alternative)'),
      LString('Entérocoque résistant à la vancomycine (ERV/VRE)', 'Vancomycin-resistant Enterococcus (VRE)'),
      LString('Pneumonie nosocomiale à Gram positif', 'Gram-positive hospital-acquired pneumonia'),
      LString('Infections peau et tissus mous compliquées', 'Complicated skin and soft tissue infections'),
    ],
    contraindications: [
      LString('Prise d\'IMAO ou dans les 2 semaines', 'MAOI use or within 2 weeks'),
    ],
    sideEffects: [
      LString('Thrombopénie / myelosuppression (>14j)', 'Thrombocytopenia / myelosuppression (>14 days)'),
      LString('Neuropathie périphérique/optique (prolongé)', 'Peripheral/optic neuropathy (prolonged)'),
      LString('Syndrome sérotoninergique', 'Serotonin syndrome'),
      LString('Acidose lactique', 'Lactic acidosis'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'ISRS / IRSNa',
        severity: InteractionSeverity.major,
        effect: LString('Syndrome sérotoninergique', 'Serotonin syndrome'),
        recommendation: LString('Éviter l\'association', 'Avoid combination'),
      ),
      DrugInteraction(
        drug: 'Aliments riches en tyramine',
        severity: InteractionSeverity.moderate,
        effect: LString('Poussée hypertensive (effet IMAO)', 'Hypertensive crisis (MAOI effect)'),
      ),
    ],
    monitoring: [
      LString('NFS hebdomadaire', 'Weekly CBC'),
    ],
    pregnancyCategory: 'C',
    requiresPrescription: true,
    notes: LString('Excellente biodisponibilité orale (~100%).', 'Excellent oral bioavailability (~100%).'),
  ),

  // ============ LIPOPEPTIDES ============
  const Antibiotic(
    id: 'daptomycin',
    name: 'Cubicin®',
    genericName: LString('Daptomycine', 'Daptomycin'),
    antibioticClass: AntibioticClass.lipopeptide,
    spectrum: SpectrumType.gramPositive,
    route: ['IV'],
    standardDose: DoseInfo(
      adult: '6-10 mg/kg',
      frequency: LString('une fois par jour', 'once daily'),
      duration: LString('Variable', 'Variable'),
      maxDose: LString('10 mg/kg/jour', '10 mg/kg/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '<30', dose: LString('Même dose q48h', 'Same dose q48h')),
    ],
    indications: [
      LString('Bactériémie à SARM / endocardite droite', 'MRSA bacteremia / right-sided endocarditis'),
      LString('Infections compliquées peau et tissus mous', 'Complicated skin and soft tissue infections'),
      LString('Entérocoque résistant à la vancomycine (VRE)', 'Vancomycin-resistant Enterococcus (VRE)'),
    ],
    contraindications: [
      LString('Pneumonie (inactivé par le surfactant)', 'Pneumonia (inactivated by surfactant)'),
    ],
    sideEffects: [
      LString('Élévation des CPK / myopathie', 'CPK elevation / myopathy'),
      LString('Pneumonie à éosinophiles', 'Eosinophilic pneumonia'),
      LString('Neuropathie', 'Neuropathy'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Statines',
        severity: InteractionSeverity.moderate,
        effect: LString('Risque de myopathie/rhabdomyolyse', 'Risk of myopathy/rhabdomyolysis'),
        recommendation: LString('Envisager de suspendre la statine', 'Consider holding statin'),
      ),
    ],
    monitoring: [
      LString('CPK hebdomadaire', 'Weekly CPK'),
    ],
    pregnancyCategory: 'B',
    requiresPrescription: true,
    notes: LString('NE PAS utiliser pour les pneumonies (inactivé par le surfactant pulmonaire).',
        'Do NOT use for pneumonia (inactivated by pulmonary surfactant).'),
  ),

  // ============ NITROIMIDAZOLES ============
  const Antibiotic(
    id: 'metronidazole',
    name: 'Flagyl®',
    genericName: LString('Métronidazole', 'Metronidazole'),
    antibioticClass: AntibioticClass.nitroimidazole,
    spectrum: SpectrumType.anaerobic,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '500mg',
      frequency: LString('toutes les 8h', 'every 8h'),
      duration: LString('7-14 jours', '7-14 days'),
      maxDose: LString('4g/jour', '4g/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '<10', dose: LString('50% de la dose', '50% of dose'), notes: LString('Ou espacer à q12h', 'Or extend to q12h')),
    ],
    hepaticAdjustment: LString('Réduire la dose de 50% si insuffisance hépatique sévère', 'Reduce dose by 50% in severe hepatic impairment'),
    indications: [
      LString('Infections à anaérobies', 'Anaerobic infections'),
      LString('Colite à C. difficile (non sévère)', 'C. difficile colitis (non-severe)'),
      LString('Vaginose bactérienne', 'Bacterial vaginosis'),
      LString('Amibiase', 'Amebiasis'),
      LString('Giardiase', 'Giardiasis'),
      LString('H. pylori (en association)', 'H. pylori (combination therapy)'),
    ],
    contraindications: [
      LString('Premier trimestre de grossesse', 'First trimester of pregnancy'),
      LString('Allaitement (relatif)', 'Breastfeeding (relative)'),
    ],
    sideEffects: [
      LString('Nausées, goût métallique', 'Nausea, metallic taste'),
      LString('Neuropathie périphérique (prolongé)', 'Peripheral neuropathy (prolonged)'),
      LString('Effet antabuse avec l\'alcool', 'Disulfiram-like reaction with alcohol'),
      LString('Leucopénie (rare)', 'Leukopenia (rare)'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Alcool',
        severity: InteractionSeverity.major,
        effect: LString('Effet antabuse', 'Disulfiram-like reaction'),
        recommendation: LString('CI pendant le traitement et 48h après', 'Contraindicated during and 48h after therapy'),
      ),
      DrugInteraction(
        drug: 'Anticoagulants oraux',
        severity: InteractionSeverity.major,
        effect: LString('Augmentation importante de l\'INR', 'Marked INR increase'),
        recommendation: LString('Réduire l\'AVK de 30-50%', 'Reduce VKA by 30-50%'),
      ),
      DrugInteraction(
        drug: 'Lithium',
        severity: InteractionSeverity.moderate,
        effect: LString('Toxicité du lithium', 'Lithium toxicity'),
        recommendation: LString('Surveiller la lithémie', 'Monitor lithium levels'),
      ),
    ],
    monitoring: [
      LString('NFS si prolongé', 'CBC if prolonged'),
      LString('Symptômes neurologiques', 'Neurological symptoms'),
    ],
    pregnancyCategory: 'B',
    requiresPrescription: true,
  ),

  // ============ TETRACYCLINES ============
  const Antibiotic(
    id: 'doxycycline',
    name: 'Vibramycine® / Vibravein®',
    genericName: LString('Doxycycline', 'Doxycycline'),
    antibioticClass: AntibioticClass.tetracycline,
    spectrum: SpectrumType.broad,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '100mg',
      frequency: LString('toutes les 12h', 'every 12h'),
      duration: LString('7-14 jours', '7-14 days'),
      maxDose: LString('200mg/jour', '200mg/day'),
    ),
    renalAdjustment: [],
    indications: [
      LString('Pneumonie communautaire / atypique', 'Community-acquired / atypical pneumonia'),
      LString('Infections à SARM communautaire', 'Community-acquired MRSA infections'),
      LString('Maladie de Lyme', 'Lyme disease'),
      LString('Rickettsioses', 'Rickettsial infections'),
      LString('IST (Chlamydia)', 'STIs (Chlamydia)'),
      LString('Acné / roséacée', 'Acne / rosacea'),
    ],
    contraindications: [
      LString('Grossesse', 'Pregnancy'),
      LString('Enfant < 8 ans (coloration dentaire)', 'Children < 8 years (tooth discoloration)'),
      LString('Allergie aux cyclines', 'Tetracycline allergy'),
    ],
    sideEffects: [
      LString('Photosensibilité', 'Photosensitivity'),
      LString('Œsophagite (prendre debout avec eau)', 'Esophagitis (take upright with water)'),
      LString('Troubles digestifs', 'GI upset'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Antiacides / Fer / Calcium',
        severity: InteractionSeverity.moderate,
        effect: LString('Diminution de l\'absorption', 'Reduced absorption'),
        recommendation: LString('Espacer de 2-3h', 'Separate by 2-3h'),
      ),
      DrugInteraction(
        drug: 'Warfarine',
        severity: InteractionSeverity.moderate,
        effect: LString('Augmentation INR', 'Increased INR'),
      ),
    ],
    pregnancyCategory: 'D',
    requiresPrescription: true,
  ),

  // ============ URINARY AGENTS ============
  const Antibiotic(
    id: 'nitrofurantoin',
    name: 'Furadantine® / Macrobid®',
    genericName: LString('Nitrofurantoïne', 'Nitrofurantoin'),
    antibioticClass: AntibioticClass.other,
    spectrum: SpectrumType.narrow,
    route: ['PO'],
    standardDose: DoseInfo(
      adult: '100mg (libération prolongée)',
      frequency: LString('toutes les 12h', 'every 12h'),
      duration: LString('5 jours', '5 days'),
      maxDose: LString('400mg/jour', '400mg/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '<30', dose: LString('Contre-indiqué', 'Contraindicated'), notes: LString('Inefficace + risque toxique', 'Ineffective + toxicity risk')),
    ],
    indications: [
      LString('Cystite aiguë simple (1re intention)', 'Acute uncomplicated cystitis (first-line)'),
      LString('Prophylaxie des infections urinaires récidivantes', 'Prophylaxis of recurrent UTIs'),
    ],
    contraindications: [
      LString('DFG < 30 mL/min', 'GFR < 30 mL/min'),
      LString('Grossesse à terme (≥38 SA)', 'Term pregnancy (≥38 weeks)'),
      LString('Déficit en G6PD', 'G6PD deficiency'),
      LString('Pyélonéphrite (ne pas utiliser)', 'Pyelonephritis (do not use)'),
    ],
    sideEffects: [
      LString('Troubles digestifs', 'GI upset'),
      LString('Fibrose/pneumopathie pulmonaire (prolongé)', 'Pulmonary fibrosis/pneumonitis (prolonged)'),
      LString('Coloration brune des urines', 'Brown urine discoloration'),
      LString('Neuropathie périphérique', 'Peripheral neuropathy'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Antiacides (magnésium)',
        severity: InteractionSeverity.minor,
        effect: LString('Diminution de l\'absorption', 'Reduced absorption'),
      ),
    ],
    pregnancyCategory: 'B',
    requiresPrescription: true,
    notes: LString('Réservé aux cystites basses; inefficace si DFG < 30.',
        'Restricted to lower UTIs; ineffective if GFR < 30.'),
  ),
  const Antibiotic(
    id: 'fosfomycin',
    name: 'Monuril® / Monurol®',
    genericName: LString('Fosfomycine trométamol', 'Fosfomycin trometamol'),
    antibioticClass: AntibioticClass.other,
    spectrum: SpectrumType.broad,
    route: ['PO'],
    standardDose: DoseInfo(
      adult: '3g',
      frequency: LString('dose unique', 'single dose'),
      duration: LString('1 jour', '1 day'),
      maxDose: LString('3g (dose unique)', '3g (single dose)'),
    ),
    renalAdjustment: [],
    indications: [
      LString('Cystite aiguë simple (1re intention)', 'Acute uncomplicated cystitis (first-line)'),
      LString('Cystite à BLSE (option orale)', 'ESBL cystitis (oral option)'),
    ],
    contraindications: [
      LString('DFG < 10 mL/min', 'GFR < 10 mL/min'),
    ],
    sideEffects: [
      LString('Diarrhée', 'Diarrhea'),
      LString('Nausées', 'Nausea'),
      LString('Céphalées', 'Headache'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Métoclopramide',
        severity: InteractionSeverity.minor,
        effect: LString('Diminution des concentrations de fosfomycine', 'Reduced fosfomycin concentrations'),
      ),
    ],
    pregnancyCategory: 'B',
    requiresPrescription: true,
    notes: LString('Dose orale unique pratique pour la cystite simple, y compris certaines BLSE.',
        'Convenient single oral dose for uncomplicated cystitis, including some ESBL strains.'),
  ),

  // ============ MONOBACTAMS ============
  const Antibiotic(
    id: 'aztreonam',
    name: 'Azactam®',
    genericName: LString('Aztréonam', 'Aztreonam'),
    antibioticClass: AntibioticClass.monobactam,
    spectrum: SpectrumType.gramNegative,
    route: ['IV', 'IM'],
    standardDose: DoseInfo(
      adult: '1-2g',
      frequency: LString('toutes les 8h', 'every 8h'),
      duration: LString('Variable', 'Variable'),
      maxDose: LString('8g/jour', '8g/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '10-30', dose: LString('50% de la dose', '50% of dose')),
      RenalAdjustment(gfr: '<10', dose: LString('25% de la dose', '25% of dose')),
    ],
    indications: [
      LString('Infections à Gram négatif chez l\'allergique aux bêta-lactamines', 'Gram-negative infections in beta-lactam-allergic patients'),
      LString('Infections à Pseudomonas', 'Pseudomonas infections'),
      LString('Infections urinaires / respiratoires à Gram négatif', 'Gram-negative urinary / respiratory infections'),
    ],
    contraindications: [
      LString('Allergie à l\'aztréonam', 'Aztreonam allergy'),
    ],
    sideEffects: [
      LString('Rash', 'Rash'),
      LString('Élévation des transaminases', 'Elevated transaminases'),
      LString('Phlébite', 'Phlebitis'),
    ],
    interactions: [],
    pregnancyCategory: 'B',
    requiresPrescription: true,
    notes: LString('Pas de réactivité croisée avec les pénicillines/céphalosporines (sauf ceftazidime).',
        'No cross-reactivity with penicillins/cephalosporins (except ceftazidime).'),
  ),

  // ============ ANTIFUNGALS ============
  const Antibiotic(
    id: 'fluconazole',
    name: 'Triflucan® / Diflucan®',
    genericName: LString('Fluconazole', 'Fluconazole'),
    antibioticClass: AntibioticClass.other,
    spectrum: SpectrumType.broad,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '200-400mg (jusqu\'à 800mg si candidémie)',
      frequency: LString('une fois par jour', 'once daily'),
      duration: LString('14-21 jours', '14-21 days'),
      maxDose: LString('800mg/jour', '800mg/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '<50', dose: LString('50% de la dose', '50% of dose'), notes: LString('Dose de charge normale', 'Normal loading dose')),
    ],
    indications: [
      LString('Candidose oropharyngée', 'Oropharyngeal candidiasis'),
      LString('Candidose œsophagienne', 'Esophageal candidiasis'),
      LString('Candidémie', 'Candidemia'),
      LString('Cryptococcose (entretien)', 'Cryptococcosis (maintenance)'),
      LString('Prophylaxie antifongique', 'Antifungal prophylaxis'),
    ],
    contraindications: [
      LString('Allergie aux azolés', 'Azole allergy'),
      LString('Grossesse (1er trimestre, hautes doses)', 'Pregnancy (first trimester, high doses)'),
    ],
    sideEffects: [
      LString('Nausées', 'Nausea'),
      LString('Hépatotoxicité', 'Hepatotoxicity'),
      LString('Allongement du QT', 'QT prolongation'),
      LString('Éruption cutanée', 'Skin rash'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Médicaments allongeant le QT',
        severity: InteractionSeverity.major,
        effect: LString('Torsades de pointes', 'Torsades de pointes'),
        recommendation: LString('Éviter', 'Avoid'),
      ),
      DrugInteraction(
        drug: 'Warfarine',
        severity: InteractionSeverity.major,
        effect: LString('Augmentation INR', 'Increased INR'),
        recommendation: LString('Surveiller étroitement', 'Monitor closely'),
      ),
      DrugInteraction(
        drug: 'Statines',
        severity: InteractionSeverity.major,
        effect: LString('Rhabdomyolyse', 'Rhabdomyolysis'),
        recommendation: LString('Éviter ou réduire la dose', 'Avoid or reduce dose'),
      ),
    ],
    monitoring: [
      LString('Transaminases', 'Transaminases'),
      LString('ECG', 'ECG'),
    ],
    pregnancyCategory: 'D',
    requiresPrescription: true,
    notes: LString('Inhibiteur du CYP2C9 et CYP3A4 – nombreuses interactions.',
        'CYP2C9 and CYP3A4 inhibitor – many interactions.'),
  ),

  // ============ SULFONAMIDES ============
  const Antibiotic(
    id: 'cotrimoxazole',
    name: 'Bactrim® / Septra®',
    genericName: LString('Sulfaméthoxazole/Triméthoprime', 'Sulfamethoxazole/Trimethoprim'),
    antibioticClass: AntibioticClass.sulfonamide,
    spectrum: SpectrumType.broad,
    route: ['PO', 'IV'],
    standardDose: DoseInfo(
      adult: '800/160mg (Forte)',
      frequency: LString('toutes les 12h', 'every 12h'),
      duration: LString('7-14 jours', '7-14 days'),
      maxDose: LString('Selon poids (PCP: 15-20 mg/kg/j de TMP)', 'Weight-based (PCP: 15-20 mg/kg/day of TMP)'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '15-30', dose: LString('50% de la dose', '50% of dose')),
      RenalAdjustment(gfr: '<15', dose: LString('Non recommandé', 'Not recommended'), notes: LString('Sauf PCP', 'Except PCP')),
    ],
    indications: [
      LString('Infections urinaires', 'Urinary tract infections'),
      LString('Pneumocystose (PCP)', 'Pneumocystis pneumonia (PCP)'),
      LString('Infections à SARM communautaire', 'Community-acquired MRSA infections'),
      LString('Nocardiose', 'Nocardiosis'),
      LString('Prophylaxie VIH', 'HIV prophylaxis'),
    ],
    contraindications: [
      LString('Allergie aux sulfamides', 'Sulfonamide allergy'),
      LString('Insuffisance hépatique sévère', 'Severe hepatic impairment'),
      LString('Déficit en G6PD', 'G6PD deficiency'),
      LString('Grossesse (T1 et T3)', 'Pregnancy (T1 and T3)'),
    ],
    sideEffects: [
      LString('Éruption cutanée (Stevens-Johnson)', 'Skin rash (Stevens-Johnson)'),
      LString('Hyperkaliémie', 'Hyperkalemia'),
      LString('Cytopénies', 'Cytopenias'),
      LString('Néphrotoxicité', 'Nephrotoxicity'),
      LString('Hépatotoxicité', 'Hepatotoxicity'),
    ],
    interactions: [
      DrugInteraction(
        drug: 'Methotrexate',
        severity: InteractionSeverity.major,
        effect: LString('Toxicité du méthotrexate', 'Methotrexate toxicity'),
        recommendation: LString('Contre-indiqué', 'Contraindicated'),
      ),
      DrugInteraction(
        drug: 'Anticoagulants',
        severity: InteractionSeverity.major,
        effect: LString('Augmentation significative de l\'INR', 'Significant INR increase'),
        recommendation: LString('Réduire l\'AVK de 25-50%', 'Reduce VKA by 25-50%'),
      ),
      DrugInteraction(
        drug: 'IEC / ARA2',
        severity: InteractionSeverity.moderate,
        effect: LString('Hyperkaliémie', 'Hyperkalemia'),
        recommendation: LString('Surveiller le K+', 'Monitor K+'),
      ),
    ],
    monitoring: [
      LString('NFS', 'CBC'),
      LString('Créatinine', 'Creatinine'),
      LString('Kaliémie', 'Potassium'),
    ],
    pregnancyCategory: 'D',
    requiresPrescription: true,
    notes: LString('Risque d\'hyperkaliémie surtout chez le sujet âgé/IR/sous IEC.',
        'Hyperkalemia risk especially in elderly / renal impairment / on ACE inhibitors.'),
  ),

  // ============ NEWER BETA-LACTAM / BETA-LACTAMASE INHIBITORS (reference) ============
  const Antibiotic(
    id: 'ceftazidime-avibactam',
    name: 'Zavicefta® / Avycaz®',
    genericName: LString('Ceftazidime + Avibactam', 'Ceftazidime + Avibactam'),
    antibioticClass: AntibioticClass.cephalosporin,
    spectrum: SpectrumType.gramNegative,
    route: ['IV'],
    standardDose: DoseInfo(
      adult: '2.5g',
      frequency: LString('toutes les 8h (perfusion 2h)', 'every 8h (2h infusion)'),
      duration: LString('Variable', 'Variable'),
      maxDose: LString('7.5g/jour', '7.5g/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '31-50', dose: LString('1.25g q8h', '1.25g q8h')),
      RenalAdjustment(gfr: '16-30', dose: LString('0.94g q12h', '0.94g q12h')),
    ],
    indications: [
      LString('Entérobactéries productrices de carbapénémases (KPC, OXA-48)', 'Carbapenemase-producing Enterobacterales (KPC, OXA-48)'),
      LString('Pseudomonas multirésistant', 'Multidrug-resistant Pseudomonas'),
      LString('Infections intra-abdominales/urinaires compliquées (MDR)', 'Complicated intra-abdominal/urinary infections (MDR)'),
    ],
    contraindications: [
      LString('Allergie aux céphalosporines', 'Cephalosporin allergy'),
    ],
    sideEffects: [
      LString('Diarrhée', 'Diarrhea'),
      LString('Nausées', 'Nausea'),
      LString('Réactions au point de perfusion', 'Infusion site reactions'),
    ],
    interactions: [],
    pregnancyCategory: 'B',
    requiresPrescription: true,
    notes: LString('Agent de recours pour BGN multirésistants; N\'agit PAS sur les métallo-bêta-lactamases (NDM).',
        'Last-resort agent for MDR Gram-negatives; NOT active against metallo-beta-lactamases (NDM).'),
  ),
  const Antibiotic(
    id: 'ceftolozane-tazobactam',
    name: 'Zerbaxa®',
    genericName: LString('Ceftolozane + Tazobactam', 'Ceftolozane + Tazobactam'),
    antibioticClass: AntibioticClass.cephalosporin,
    spectrum: SpectrumType.gramNegative,
    route: ['IV'],
    standardDose: DoseInfo(
      adult: '1.5g (3g pour la pneumonie)',
      frequency: LString('toutes les 8h', 'every 8h'),
      duration: LString('Variable', 'Variable'),
      maxDose: LString('9g/jour (pneumonie)', '9g/day (pneumonia)'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '30-50', dose: LString('750mg q8h', '750mg q8h')),
      RenalAdjustment(gfr: '15-29', dose: LString('375mg q8h', '375mg q8h')),
    ],
    indications: [
      LString('Pseudomonas multirésistant', 'Multidrug-resistant Pseudomonas'),
      LString('Infections intra-abdominales compliquées (avec métronidazole)', 'Complicated intra-abdominal infections (with metronidazole)'),
      LString('Pneumonie nosocomiale / VAP', 'Hospital-acquired / ventilator-associated pneumonia'),
    ],
    contraindications: [
      LString('Allergie aux céphalosporines', 'Cephalosporin allergy'),
    ],
    sideEffects: [
      LString('Diarrhée', 'Diarrhea'),
      LString('Nausées / vomissements', 'Nausea / vomiting'),
      LString('Élévation des transaminases', 'Elevated transaminases'),
    ],
    interactions: [],
    pregnancyCategory: 'B',
    requiresPrescription: true,
    notes: LString('Très actif sur Pseudomonas multirésistant; associer le métronidazole pour les anaérobies.',
        'Highly active against MDR Pseudomonas; add metronidazole for anaerobic cover.'),
  ),
  const Antibiotic(
    id: 'cefiderocol',
    name: 'Fetcroja® / Fetroja®',
    genericName: LString('Céfidérocol', 'Cefiderocol'),
    antibioticClass: AntibioticClass.cephalosporin,
    spectrum: SpectrumType.gramNegative,
    route: ['IV'],
    standardDose: DoseInfo(
      adult: '2g',
      frequency: LString('toutes les 8h (perfusion 3h)', 'every 8h (3h infusion)'),
      duration: LString('Variable', 'Variable'),
      maxDose: LString('6g/jour', '6g/day'),
    ),
    renalAdjustment: [
      RenalAdjustment(gfr: '30-59', dose: LString('1.5g q8h', '1.5g q8h')),
      RenalAdjustment(gfr: '15-29', dose: LString('1g q8h', '1g q8h')),
    ],
    indications: [
      LString('Bacilles à Gram négatif multirésistants (options limitées)', 'Multidrug-resistant Gram-negative bacilli (limited options)'),
      LString('Acinetobacter baumannii résistant aux carbapénèmes', 'Carbapenem-resistant Acinetobacter baumannii'),
      LString('Métallo-bêta-lactamases (NDM)', 'Metallo-beta-lactamases (NDM)'),
    ],
    contraindications: [
      LString('Allergie aux céphalosporines', 'Cephalosporin allergy'),
    ],
    sideEffects: [
      LString('Diarrhée / C. difficile', 'Diarrhea / C. difficile'),
      LString('Réactions au point de perfusion', 'Infusion site reactions'),
      LString('Élévation des transaminases', 'Elevated transaminases'),
    ],
    interactions: [],
    pregnancyCategory: 'B',
    requiresPrescription: true,
    notes: LString('Céphalosporine sidérophore « cheval de Troie »; réservée aux BGN multirésistants incluant les NDM.',
        'Siderophore «Trojan-horse» cephalosporin; reserved for MDR Gram-negatives including NDM.'),
  ),
];
