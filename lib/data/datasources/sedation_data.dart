import '../../domain/entities/sedation.dart';
import '../../core/l10n/localized.dart';

/// Sedation Data Source
/// Updated: 2025 (Guidelines 2024/2025)
/// Includes RSI, Procedural Sedation, Analgesia, and reversal agents.
/// All clinician-facing free-text is bilingual (French / English) via [LString].
class SedationData {
  static final List<SedationDrug> allDrugs = [
    // =====================
    // INDUCTION AGENTS
    // =====================
    SedationDrug(
      id: 'propofol',
      name: 'Propofol',
      genericName: 'Propofol',
      drugClass: LString('Hypnotique', 'Hypnotic'),
      role: [DrugRole.induction, DrugRole.sedative],
      sedationTypes: [SedationType.rsi, SedationType.procedural, SedationType.maintenance],
      standardDose: 1.5,
      doseUnit: 'mg/kg',
      route: ['IV'],
      dosesByAge: [
        DoseByAge(ageGroup: AgeGroup.adult, ageRange: '18-65 ans', dose: 1.5, notes: LString('1.5-2.5 mg/kg', '1.5-2.5 mg/kg')),
        DoseByAge(ageGroup: AgeGroup.elderly, ageRange: '> 65 ans', dose: 1.0, notes: LString('Réduire dose (1 mg/kg)', 'Reduce dose (1 mg/kg)')),
        DoseByAge(ageGroup: AgeGroup.child, ageRange: '3-17 ans', dose: 2.5, notes: LString('2.5-3.5 mg/kg', '2.5-3.5 mg/kg')),
        DoseByAge(ageGroup: AgeGroup.infant, ageRange: '< 3 ans', dose: 3.0, notes: LString('3-4 mg/kg', '3-4 mg/kg')),
      ],
      onsetSeconds: 30,
      durationMinutes: 8,
      mechanism: LString('Agoniste GABA', 'GABA agonist'),
      indications: [
        LString('Induction anesthésie', 'Anesthesia induction'),
        LString('Sédation procédurale', 'Procedural sedation'),
        LString('État de mal épileptique réfractaire', 'Refractory status epilepticus'),
      ],
      advantages: [
        LString('Début et fin d\'action rapides', 'Rapid onset and offset'),
        LString('Propriétés antiémétiques', 'Antiemetic properties'),
        LString('Diminue la PIC', 'Lowers ICP'),
        LString('Bronchodilatateur léger', 'Mild bronchodilator'),
      ],
      sideEffects: [
        LString('Hypotension (vasodilatation + inotrope négatif)', 'Hypotension (vasodilation + negative inotropy)'),
        LString('Dépression respiratoire / Apnée', 'Respiratory depression / apnea'),
        LString('Douleur à l\'injection', 'Injection pain'),
        LString('Syndrome de perfusion du propofol (long cours)', 'Propofol infusion syndrome (prolonged use)'),
      ],
      contraindications: [
        LString('Allergie œuf/soja (théorique, rare)', 'Egg/soy allergy (theoretical, rare)'),
        LString('Instabilité hémodynamique sévère', 'Severe hemodynamic instability'),
      ],
      precautions: [
        LString('Hypotension: réduire dose ou choisir autre agent', 'Hypotension: reduce dose or choose another agent'),
        LString('Personnes âgées: réduire dose de 50%', 'Elderly: reduce dose by 50%'),
        LString('Injection lente pour sédation procédurale', 'Slow injection for procedural sedation'),
      ],
      concentrations: [LString('10 mg/mL (1%)', '10 mg/mL (1%)')],
      notes: [
        LString('Réduire dose si choc ou âge avancé', 'Reduce dose in shock or advanced age'),
        LString('Peut causer myoclonies (non épileptiques)', 'May cause myoclonus (non-epileptic)'),
        LString('Ne fournit aucune analgésie', 'Provides no analgesia'),
        LString('Kétofol (propofol + kétamine 1:1): meilleure stabilité hémodynamique et moindre dépression respiratoire pour la sédation procédurale', 'Ketofol (propofol + ketamine 1:1): better hemodynamic stability and less respiratory depression for procedural sedation'),
      ],
    ),

    SedationDrug(
      id: 'etomidate',
      name: 'Étomidate',
      genericName: 'Etomidate',
      drugClass: LString('Hypnotique', 'Hypnotic'),
      role: [DrugRole.induction],
      sedationTypes: [SedationType.rsi, SedationType.procedural],
      standardDose: 0.3,
      doseUnit: 'mg/kg',
      route: ['IV'],
      dosesByAge: [
        DoseByAge(ageGroup: AgeGroup.adult, ageRange: '18+ ans', dose: 0.3, notes: LString('0.2-0.4 mg/kg', '0.2-0.4 mg/kg')),
        DoseByAge(ageGroup: AgeGroup.child, ageRange: '< 18 ans', dose: 0.3),
        DoseByAge(ageGroup: AgeGroup.elderly, ageRange: '> 65 ans', dose: 0.2, notes: LString('0.15-0.2 mg/kg', '0.15-0.2 mg/kg')),
      ],
      onsetSeconds: 30,
      durationMinutes: 8,
      mechanism: LString('Agoniste GABA', 'GABA agonist'),
      indications: [
        LString('Induction ISR (surtout si instabilité hémodynamique)', 'RSI induction (especially if hemodynamic instability)'),
        LString('Sédation procédurale brève (réduction luxation)', 'Brief procedural sedation (dislocation reduction)'),
      ],
      advantages: [
        LString('Stabilité hémodynamique (neutre)', 'Hemodynamic stability (neutral)'),
        LString('Maintien pression perfusion cérébrale', 'Preserves cerebral perfusion pressure'),
        LString('Début d\'action rapide', 'Rapid onset'),
      ],
      sideEffects: [
        LString('Suppression surrénalienne (transitoire)', 'Adrenal suppression (transient)'),
        LString('Myoclonies (30-50%)', 'Myoclonus (30-50%)'),
        LString('Nausées/vomissements (fréquent)', 'Nausea/vomiting (frequent)'),
        LString('Douleur à l\'injection', 'Injection pain'),
      ],
      contraindications: [
        LString('Sepsis sévère (controverse suppression surrénale)', 'Severe sepsis (adrenal-suppression controversy)'),
        LString('Porphyrie', 'Porphyria'),
      ],
      precautions: [
        LString('Prémédication opioïde réduit myoclonies', 'Opioid premedication reduces myoclonus'),
        LString('Non recommandé pour sédation continue (maintien)', 'Not recommended for continuous (maintenance) sedation'),
      ],
      concentrations: [LString('2 mg/mL', '2 mg/mL')],
      notes: [
        LString('Agent de choix pour trauma/choc', 'Agent of choice for trauma/shock'),
        LString('Ne fournit aucune analgésie', 'Provides no analgesia'),
        LString('Myoclonies peuvent gêner l\'examen', 'Myoclonus may interfere with examination'),
      ],
    ),

    SedationDrug(
      id: 'ketamine',
      name: 'Kétamine',
      genericName: 'Ketamine',
      drugClass: LString('Anesthésique dissociatif', 'Dissociative anesthetic'),
      role: [DrugRole.induction, DrugRole.analgesic, DrugRole.sedative],
      sedationTypes: [SedationType.rsi, SedationType.procedural],
      standardDose: 1.5,
      doseUnit: 'mg/kg',
      route: ['IV', 'IM'],
      dosesByAge: [
        DoseByAge(ageGroup: AgeGroup.adult, ageRange: '18+ ans', dose: 1.5, notes: LString('ISR: 1.5-2 mg/kg. Sédation: 1 mg/kg', 'RSI: 1.5-2 mg/kg. Sedation: 1 mg/kg')),
        DoseByAge(ageGroup: AgeGroup.child, ageRange: '< 18 ans', dose: 1.5, notes: LString('ISR: 1.5-2 mg/kg. Sédation: 1 mg/kg', 'RSI: 1.5-2 mg/kg. Sedation: 1 mg/kg')),
      ],
      onsetSeconds: 45,
      durationMinutes: 15,
      mechanism: LString('Antagoniste NMDA', 'NMDA antagonist'),
      indications: [
        LString('Induction ISR (asthme, choc)', 'RSI induction (asthma, shock)'),
        LString('Sédation procédurale (enfants)', 'Procedural sedation (children)'),
        LString('Analgésie sévère', 'Severe analgesia'),
      ],
      advantages: [
        LString('Bronchodilatateur (choix pour asthme)', 'Bronchodilator (choice for asthma)'),
        LString('Maintien réflexes voies aériennes', 'Preserves airway reflexes'),
        LString('Maintien drive respiratoire', 'Preserves respiratory drive'),
        LString('Stabilité hémodynamique (catécholamines)', 'Hemodynamic stability (catecholamine release)'),
        LString('Analgésie puissante', 'Potent analgesia'),
      ],
      sideEffects: [
        LString('Hypertension, Tachycardie', 'Hypertension, tachycardia'),
        LString('Augmentation sécrétions salivaires', 'Increased salivary secretions'),
        LString('Laryngospasme (rare)', 'Laryngospasm (rare)'),
        LString('Réactions d\'émergence (hallucinations)', 'Emergence reactions (hallucinations)'),
        LString('Augmentation PIC (controverse - probablement sûr)', 'Raised ICP (controversial - probably safe)'),
      ],
      contraindications: [
        LString('Hypertension sévère non contrôlée', 'Severe uncontrolled hypertension'),
        LString('Psychose sévère', 'Severe psychosis'),
        LString('Pathologie oculaire (globe ouvert)', 'Ocular pathology (open globe)'),
      ],
      precautions: [
        LString('Atropine si hypersalivation', 'Atropine if hypersalivation'),
        LString('Injection lente (1 min) pour sédation procédurale', 'Slow injection (1 min) for procedural sedation'),
        LString('Risque laryngospasme', 'Laryngospasm risk'),
      ],
      concentrations: [LString('10 mg/mL', '10 mg/mL'), LString('50 mg/mL', '50 mg/mL')],
      notes: [
        LString('Dose IM: 4-5 mg/kg (délai 3-5 min)', 'IM dose: 4-5 mg/kg (onset 3-5 min)'),
        LString('Phénomènes d\'émergence: traiter avec midazolam', 'Emergence phenomena: treat with midazolam'),
        LString('Dissociation: yeux ouverts, nystagmus', 'Dissociation: open eyes, nystagmus'),
        LString('Kétofol (kétamine + propofol 1:1): stabilité hémodynamique pour la sédation procédurale', 'Ketofol (ketamine + propofol 1:1): hemodynamic stability for procedural sedation'),
      ],
    ),

    SedationDrug(
      id: 'midazolam',
      name: 'Midazolam',
      genericName: 'Midazolam',
      drugClass: LString('Benzodiazépine', 'Benzodiazepine'),
      role: [DrugRole.induction, DrugRole.sedative],
      sedationTypes: [SedationType.procedural, SedationType.maintenance, SedationType.rsi],
      standardDose: 0.1,
      doseUnit: 'mg/kg',
      route: ['IV', 'IM', 'IN'],
      dosesByAge: [
        DoseByAge(ageGroup: AgeGroup.adult, ageRange: '18-60 ans', dose: 0.1, notes: LString('Max 5 mg initial', 'Max 5 mg initial')),
        DoseByAge(ageGroup: AgeGroup.elderly, ageRange: '> 60 ans', dose: 0.05, notes: LString('Max 2.5 mg initial', 'Max 2.5 mg initial')),
        DoseByAge(ageGroup: AgeGroup.child, ageRange: '< 18 ans', dose: 0.1, notes: LString('Max 5 mg', 'Max 5 mg')),
      ],
      onsetSeconds: 120,
      durationMinutes: 45,
      mechanism: LString('Agoniste GABA', 'GABA agonist'),
      indications: [
        LString('Sédation procédurale', 'Procedural sedation'),
        LString('Anxiolyse', 'Anxiolysis'),
        LString('Amnésie', 'Amnesia'),
        LString('Convulsions', 'Seizures'),
        LString('Induction ISR (si choc et autres non dispo)', 'RSI induction (if shock and others unavailable)'),
      ],
      advantages: [
        LString('Amnésie antérograde puissante', 'Potent anterograde amnesia'),
        LString('Anxiolyse', 'Anxiolysis'),
        LString('Anticonvulsivant', 'Anticonvulsant'),
        LString('Réversible (flumazénil)', 'Reversible (flumazenil)'),
      ],
      sideEffects: [
        LString('Dépression respiratoire', 'Respiratory depression'),
        LString('Hypotension', 'Hypotension'),
        LString('Réaction paradoxale (agitation)', 'Paradoxical reaction (agitation)'),
      ],
      contraindications: [
        LString('Glaucome à angle fermé', 'Closed-angle glaucoma'),
        LString('Choc (dose-dépendant)', 'Shock (dose-dependent)'),
      ],
      precautions: [
        LString('Effet synergique avec opioïdes (dépression respi)', 'Synergistic with opioids (respiratory depression)'),
        LString('Réduire dose chez insuffisant rénal/hépatique', 'Reduce dose in renal/hepatic impairment'),
        LString('Surveillance cardio-respiratoire continue', 'Continuous cardiorespiratory monitoring'),
      ],
      concentrations: [LString('1 mg/mL', '1 mg/mL'), LString('5 mg/mL', '5 mg/mL')],
      notes: [
        LString('Début d\'action plus lent que propofol/étomidate', 'Slower onset than propofol/etomidate'),
        LString('Voie IN: 0.2-0.3 mg/kg (max 10 mg)', 'IN route: 0.2-0.3 mg/kg (max 10 mg)'),
        LString('Antidote: Flumazénil', 'Antidote: flumazenil'),
        LString('ISR: 0.2-0.3 mg/kg', 'RSI: 0.2-0.3 mg/kg'),
      ],
    ),

    SedationDrug(
      id: 'dexmedetomidine',
      name: 'Dexmédétomidine',
      genericName: 'Dexmedetomidine',
      drugClass: LString('Agoniste alpha-2', 'Alpha-2 agonist'),
      role: [DrugRole.sedative],
      sedationTypes: [SedationType.procedural, SedationType.maintenance],
      standardDose: 1.0,
      doseUnit: 'mcg/kg',
      route: ['IV'],
      dosesByAge: [
        DoseByAge(ageGroup: AgeGroup.adult, ageRange: '18+ ans', dose: 1.0, notes: LString('Charge 1 mcg/kg sur 10 min, puis 0.2-0.7 mcg/kg/h', 'Load 1 mcg/kg over 10 min, then 0.2-0.7 mcg/kg/h')),
        DoseByAge(ageGroup: AgeGroup.elderly, ageRange: '> 65 ans', dose: 0.5, notes: LString('Réduire charge (0.5 mcg/kg), risque bradycardie/hypotension', 'Reduce load (0.5 mcg/kg), bradycardia/hypotension risk')),
      ],
      onsetSeconds: 360,
      durationMinutes: 60,
      mechanism: LString('Agoniste alpha-2 adrénergique central', 'Central alpha-2 adrenergic agonist'),
      indications: [
        LString('Sédation procédurale (patient coopérant)', 'Procedural sedation (cooperative patient)'),
        LString('Sédation en réanimation (ventilé, sevrage)', 'ICU sedation (ventilated, weaning)'),
        LString('Sédation vigile (fibroscopie, intubation vigile)', 'Awake sedation (bronchoscopy, awake intubation)'),
      ],
      advantages: [
        LString('Sédation sans dépression respiratoire significative', 'Sedation without significant respiratory depression'),
        LString('Patient réveillable et coopérant', 'Arousable, cooperative patient'),
        LString('Analgésie légère et effet sympatholytique', 'Mild analgesia and sympatholytic effect'),
      ],
      sideEffects: [
        LString('Bradycardie', 'Bradycardia'),
        LString('Hypotension (ou hypertension transitoire au bolus)', 'Hypotension (or transient hypertension with bolus)'),
        LString('Sécheresse buccale', 'Dry mouth'),
      ],
      contraindications: [
        LString('Bloc auriculo-ventriculaire avancé (sans pacemaker)', 'Advanced AV block (without pacemaker)'),
        LString('Bradycardie sévère', 'Severe bradycardia'),
      ],
      precautions: [
        LString('Administrer la charge lentement (>10 min) pour éviter hypertension/bradycardie', 'Give the load slowly (>10 min) to avoid hypertension/bradycardia'),
        LString('Surveillance ECG et pression artérielle', 'ECG and blood-pressure monitoring'),
      ],
      concentrations: [LString('100 mcg/mL (à diluer)', '100 mcg/mL (to be diluted)'), LString('4 mcg/mL (dilué)', '4 mcg/mL (diluted)')],
      notes: [
        LString('Début lent - non adapté à l\'ISR', 'Slow onset - not suitable for RSI'),
        LString('Ne procure pas d\'amnésie fiable', 'Does not provide reliable amnesia'),
        LString('Peut réduire les besoins en opioïdes', 'May reduce opioid requirements'),
      ],
    ),

    // =====================
    // PARALYTICS
    // =====================
    SedationDrug(
      id: 'succinylcholine',
      name: 'Succinylcholine',
      genericName: 'Succinylcholine',
      drugClass: LString('Curare dépolarisant', 'Depolarizing neuromuscular blocker'),
      role: [DrugRole.paralytic],
      sedationTypes: [SedationType.rsi],
      standardDose: 1.5,
      doseUnit: 'mg/kg',
      route: ['IV', 'IM'],
      dosesByAge: [
        DoseByAge(ageGroup: AgeGroup.adult, ageRange: '18+ ans', dose: 1.5, notes: LString('1.0-1.5 mg/kg', '1.0-1.5 mg/kg')),
        DoseByAge(ageGroup: AgeGroup.child, ageRange: '1-17 ans', dose: 1.5, notes: LString('1.5-2.0 mg/kg', '1.5-2.0 mg/kg')),
        DoseByAge(ageGroup: AgeGroup.infant, ageRange: '< 1 an', dose: 2.0, notes: LString('2.0 mg/kg (plus grand Vd)', '2.0 mg/kg (larger Vd)')),
      ],
      onsetSeconds: 45,
      durationMinutes: 8,
      mechanism: LString('Agoniste récepteurs nicotiniques (dépolarisant)', 'Nicotinic receptor agonist (depolarizing)'),
      indications: [
        LString('ISR (gold standard pour délai)', 'RSI (gold standard for onset time)'),
        LString('Laryngospasme', 'Laryngospasm'),
      ],
      advantages: [
        LString('Début d\'action très rapide', 'Very rapid onset'),
        LString('Durée d\'action très courte', 'Very short duration'),
        LString('Conditions d\'intubation excellentes', 'Excellent intubating conditions'),
      ],
      sideEffects: [
        LString('Hyperkaliémie transitoire', 'Transient hyperkalemia'),
        LString('Fasciculations', 'Fasciculations'),
        LString('Bradycardie (surtout enfants)', 'Bradycardia (especially children)'),
        LString('Hyperthermie maligne', 'Malignant hyperthermia'),
        LString('Augmentation pression intra-oculaire/gastrique', 'Increased intraocular/gastric pressure'),
      ],
      contraindications: [
        LString('Hyperkaliémie connue ou suspectée', 'Known or suspected hyperkalemia'),
        LString('Antécédents hyperthermie maligne', 'History of malignant hyperthermia'),
        LString('Grands brûlés > 24h', 'Major burns > 24h'),
        LString('Trauma musculaire massif / Crush > 24h', 'Massive muscle trauma / crush > 24h'),
        LString('Dénervation musculaire (AVC, moelle) > 72h', 'Muscle denervation (stroke, cord) > 72h'),
        LString('Déficit en pseudocholinestérase', 'Pseudocholinesterase deficiency'),
      ],
      precautions: [
        LString('Atropine préventive chez enfants < 1 an', 'Prophylactic atropine in children < 1 year'),
        LString('Vérifier K+ chez insuffisants rénaux', 'Check K+ in renal failure'),
      ],
      concentrations: [LString('20 mg/mL', '20 mg/mL'), LString('50 mg/mL', '50 mg/mL')],
      notes: [
        LString('Dose IM: 3-4 mg/kg (max 150 mg)', 'IM dose: 3-4 mg/kg (max 150 mg)'),
        LString('Alternative: rocuronium si contre-indication', 'Alternative: rocuronium if contraindicated'),
        LString('Non réversé par le sugammadex (bloc dépolarisant)', 'Not reversed by sugammadex (depolarizing block)'),
      ],
    ),

    SedationDrug(
      id: 'rocuronium',
      name: 'Rocuronium',
      genericName: 'Rocuronium',
      drugClass: LString('Curare non-dépolarisant', 'Non-depolarizing neuromuscular blocker'),
      role: [DrugRole.paralytic],
      sedationTypes: [SedationType.rsi, SedationType.maintenance],
      standardDose: 1.2,
      doseUnit: 'mg/kg',
      route: ['IV'],
      dosesByAge: [
        DoseByAge(ageGroup: AgeGroup.adult, ageRange: '18+ ans', dose: 1.2, notes: LString('ISR: 1.2 mg/kg', 'RSI: 1.2 mg/kg')),
        DoseByAge(ageGroup: AgeGroup.child, ageRange: '1-17 ans', dose: 1.2),
        DoseByAge(ageGroup: AgeGroup.infant, ageRange: '< 1 an', dose: 1.2),
      ],
      onsetSeconds: 60,
      durationMinutes: 45,
      mechanism: LString('Antagoniste compétitif récepteurs nicotiniques', 'Competitive nicotinic receptor antagonist'),
      indications: [
        LString('ISR (alternative à succinylcholine)', 'RSI (alternative to succinylcholine)'),
        LString('Curarisation peropératoire', 'Intraoperative paralysis'),
        LString('Contre-indication à succinylcholine', 'Contraindication to succinylcholine'),
      ],
      advantages: [
        LString('Pas d\'hyperkaliémie', 'No hyperkalemia'),
        LString('Pas de fasciculations', 'No fasciculations'),
        LString('Réversible par sugammadex', 'Reversible with sugammadex'),
        LString('Pas de risque d\'hyperthermie maligne', 'No malignant hyperthermia risk'),
      ],
      sideEffects: [
        LString('Curarisation prolongée', 'Prolonged paralysis'),
        LString('Tachycardie légère', 'Mild tachycardia'),
        LString('Réaction allergique (rare)', 'Allergic reaction (rare)'),
      ],
      contraindications: [
        LString('Allergie connue', 'Known allergy'),
      ],
      precautions: [
        LString('Conditions intubation difficile (durée prolongée)', 'Difficult airway (prolonged duration)'),
        LString('Insuffisance hépatique: durée prolongée', 'Hepatic impairment: prolonged duration'),
        LString('Myasthénie: réduire dose', 'Myasthenia: reduce dose'),
      ],
      concentrations: [LString('10 mg/mL', '10 mg/mL')],
      notes: [
        LString('Sugammadex 16 mg/kg pour antagonisation immédiate (post-ISR); 2-4 mg/kg pour réversion de routine', 'Sugammadex 16 mg/kg for immediate reversal (post-RSI); 2-4 mg/kg for routine reversal'),
        LString('Dose entretien: 0.1-0.2 mg/kg', 'Maintenance dose: 0.1-0.2 mg/kg'),
        LString('Dose ISR élevée = conditions similaires à succinylcholine', 'High RSI dose = conditions similar to succinylcholine'),
        LString('Stocker au réfrigérateur', 'Store refrigerated'),
      ],
    ),

    // =====================
    // OPIOID ANALGESICS
    // =====================
    SedationDrug(
      id: 'fentanyl',
      name: 'Fentanyl',
      genericName: 'Fentanyl',
      drugClass: LString('Opioïde', 'Opioid'),
      role: [DrugRole.analgesic],
      sedationTypes: [SedationType.rsi, SedationType.procedural, SedationType.maintenance],
      standardDose: 2.0,
      doseUnit: 'mcg/kg',
      route: ['IV', 'IN'],
      dosesByAge: [
        DoseByAge(ageGroup: AgeGroup.adult, ageRange: '18-65 ans', dose: 1.0, notes: LString('Titrer par 25-50 mcg', 'Titrate by 25-50 mcg')),
        DoseByAge(ageGroup: AgeGroup.elderly, ageRange: '> 65 ans', dose: 0.5, notes: LString('Réduire de 50%', 'Reduce by 50%')),
        DoseByAge(ageGroup: AgeGroup.child, ageRange: '1-17 ans', dose: 1.0, notes: LString('Max 50 mcg', 'Max 50 mcg')),
        DoseByAge(ageGroup: AgeGroup.infant, ageRange: '< 1 an', dose: 1.0),
      ],
      maxSingleDose: 100,
      maxSingleDoseUnit: 'mcg',
      onsetSeconds: 90,
      durationMinutes: 45,
      mechanism: LString('Agoniste récepteurs mu opioïdes', 'Mu-opioid receptor agonist'),
      indications: [
        LString('Analgésie ISR', 'RSI analgesia'),
        LString('Sédation procédurale (avec hypnotique)', 'Procedural sedation (with a hypnotic)'),
        LString('Analgésie procédurale', 'Procedural analgesia'),
        LString('Atténuation réponse sympathique à l\'intubation', 'Blunting the sympathetic response to intubation'),
      ],
      advantages: [
        LString('Stabilité hémodynamique', 'Hemodynamic stability'),
        LString('Début d\'action rapide', 'Rapid onset'),
        LString('Pas de libération d\'histamine', 'No histamine release'),
        LString('Réversible (naloxone)', 'Reversible (naloxone)'),
      ],
      sideEffects: [
        LString('Dépression respiratoire', 'Respiratory depression'),
        LString('Rigidité thoracique (dose élevée rapide)', 'Chest-wall rigidity (rapid high dose)'),
        LString('Bradycardie', 'Bradycardia'),
        LString('Nausées/vomissements', 'Nausea/vomiting'),
        LString('Prurit', 'Pruritus'),
        LString('Rétention urinaire', 'Urinary retention'),
      ],
      contraindications: [
        LString('IMAO dans les 14 jours', 'MAOI within 14 days'),
      ],
      precautions: [
        LString('Insuffisance respiratoire', 'Respiratory failure'),
        LString('Injection lente pour éviter rigidité thoracique', 'Slow injection to avoid chest-wall rigidity'),
        LString('Réduire dose si autre dépresseur SNC', 'Reduce dose with other CNS depressants'),
      ],
      concentrations: [LString('50 mcg/mL', '50 mcg/mL')],
      notes: [
        LString('Voie IN: 1.5-2 mcg/kg (douleur pédiatrique)', 'IN route: 1.5-2 mcg/kg (pediatric pain)'),
        LString('Rigidité thoracique: traiter avec curare', 'Chest-wall rigidity: treat with a paralytic'),
        LString('Antidote: Naloxone 0.4-2 mg IV', 'Antidote: naloxone 0.4-2 mg IV'),
        LString('Pour ISR: administrer 3 min avant induction', 'For RSI: give 3 min before induction'),
      ],
    ),

    SedationDrug(
      id: 'morphine',
      name: 'Morphine',
      genericName: 'Morphine',
      drugClass: LString('Opioïde', 'Opioid'),
      role: [DrugRole.analgesic],
      sedationTypes: [SedationType.procedural],
      standardDose: 0.1,
      doseUnit: 'mg/kg',
      route: ['IV', 'SC', 'PO'],
      dosesByAge: [
        DoseByAge(ageGroup: AgeGroup.adult, ageRange: '18-65 ans', dose: 0.1, notes: LString('Titrer par 2-4 mg IV', 'Titrate by 2-4 mg IV')),
        DoseByAge(ageGroup: AgeGroup.elderly, ageRange: '> 65 ans', dose: 0.05, notes: LString('Réduire de 50%', 'Reduce by 50%')),
        DoseByAge(ageGroup: AgeGroup.child, ageRange: '1-17 ans', dose: 0.1, notes: LString('Max 5 mg', 'Max 5 mg')),
        DoseByAge(ageGroup: AgeGroup.infant, ageRange: '3-12 mois', dose: 0.05),
      ],
      maxSingleDose: 10,
      maxSingleDoseUnit: 'mg',
      onsetSeconds: 300,
      durationMinutes: 240,
      mechanism: LString('Agoniste récepteurs mu opioïdes', 'Mu-opioid receptor agonist'),
      indications: [
        LString('Douleur modérée à sévère', 'Moderate to severe pain'),
        LString('OAP cardiogénique', 'Cardiogenic pulmonary edema'),
        LString('Analgésie sédation procédurale', 'Procedural sedation analgesia'),
      ],
      advantages: [
        LString('Longue durée d\'action', 'Long duration of action'),
        LString('Économique', 'Inexpensive'),
        LString('Multiples voies d\'administration', 'Multiple routes of administration'),
      ],
      sideEffects: [
        LString('Dépression respiratoire', 'Respiratory depression'),
        LString('Hypotension (libération histamine)', 'Hypotension (histamine release)'),
        LString('Nausées/vomissements', 'Nausea/vomiting'),
        LString('Prurit', 'Pruritus'),
        LString('Rétention urinaire', 'Urinary retention'),
        LString('Constipation', 'Constipation'),
      ],
      contraindications: [
        LString('Asthme aigu sévère', 'Severe acute asthma'),
        LString('Insuffisance respiratoire', 'Respiratory failure'),
      ],
      precautions: [
        LString('Insuffisance rénale: métabolites actifs accumulés', 'Renal failure: active metabolites accumulate'),
        LString('Insuffisance hépatique: réduire dose', 'Hepatic impairment: reduce dose'),
      ],
      concentrations: [LString('1 mg/mL', '1 mg/mL'), LString('10 mg/mL', '10 mg/mL')],
      notes: [
        LString('Début plus lent que fentanyl - moins adapté ISR', 'Slower onset than fentanyl - less suited to RSI'),
        LString('Éviter en insuffisance rénale (M6G)', 'Avoid in renal failure (M6G)'),
        LString('Antidote: Naloxone 0.4-2 mg IV', 'Antidote: naloxone 0.4-2 mg IV'),
      ],
    ),

    // =====================
    // ADJUNCTS
    // =====================
    SedationDrug(
      id: 'atropine',
      name: 'Atropine',
      genericName: 'Atropine',
      drugClass: LString('Anticholinergique', 'Anticholinergic'),
      role: [DrugRole.adjunct],
      sedationTypes: [SedationType.rsi],
      standardDose: 0.02,
      doseUnit: 'mg/kg',
      route: ['IV'],
      dosesByAge: [
        DoseByAge(ageGroup: AgeGroup.adult, ageRange: '18+ ans', dose: 0.02, notes: LString('Min 0.5 mg, max 1 mg', 'Min 0.5 mg, max 1 mg')),
        DoseByAge(ageGroup: AgeGroup.child, ageRange: '< 18 ans', dose: 0.02, notes: LString('Min 0.1 mg, max 0.5 mg', 'Min 0.1 mg, max 0.5 mg')),
      ],
      onsetSeconds: 60,
      durationMinutes: 30,
      mechanism: LString('Antagoniste muscarinique', 'Muscarinic antagonist'),
      indications: [
        LString('Prévention bradycardie (succinylcholine)', 'Bradycardia prevention (succinylcholine)'),
        LString('Bradycardie symptomatique', 'Symptomatic bradycardia'),
        LString('Hypersalivation (kétamine)', 'Hypersalivation (ketamine)'),
      ],
      advantages: [
        LString('Prévient bradycardie réflexe', 'Prevents reflex bradycardia'),
        LString('Réduit sécrétions', 'Reduces secretions'),
      ],
      sideEffects: [
        LString('Tachycardie', 'Tachycardia'),
        LString('Sécheresse buccale', 'Dry mouth'),
        LString('Mydriase', 'Mydriasis'),
        LString('Rétention urinaire', 'Urinary retention'),
        LString('Confusion (âgé)', 'Confusion (elderly)'),
      ],
      contraindications: [
        LString('Glaucome à angle fermé', 'Closed-angle glaucoma'),
      ],
      precautions: [
        LString('Dose < 0.1 mg peut causer bradycardie paradoxale', 'Dose < 0.1 mg may cause paradoxical bradycardia'),
      ],
      concentrations: [LString('0.25 mg/mL', '0.25 mg/mL'), LString('1 mg/mL', '1 mg/mL')],
      notes: [
        LString('Systématique avant succinylcholine chez enfant < 1 an', 'Routine before succinylcholine in children < 1 year'),
        LString('Optionnel chez enfant 1-5 ans', 'Optional in children 1-5 years'),
        LString('Non nécessaire en routine chez adulte', 'Not routinely needed in adults'),
      ],
    ),

    SedationDrug(
      id: 'lidocaine',
      name: 'Lidocaïne',
      genericName: 'Lidocaine',
      drugClass: LString('Anesthésique local', 'Local anesthetic'),
      role: [DrugRole.adjunct],
      sedationTypes: [SedationType.rsi],
      standardDose: 1.5,
      doseUnit: 'mg/kg',
      route: ['IV'],
      dosesByAge: [
        DoseByAge(ageGroup: AgeGroup.adult, ageRange: '18+ ans', dose: 1.5),
        DoseByAge(ageGroup: AgeGroup.child, ageRange: '< 18 ans', dose: 1.5),
      ],
      maxSingleDose: 100,
      maxSingleDoseUnit: 'mg',
      onsetSeconds: 90,
      durationMinutes: 20,
      mechanism: LString('Blocage canaux sodiques, suppression toux', 'Sodium-channel blockade, cough suppression'),
      indications: [
        LString('Atténuation réflexe toux/laryngé', 'Blunting cough/laryngeal reflex'),
        LString('Réduction PIC lors intubation', 'ICP reduction during intubation'),
        LString('Prévention augmentation PIO', 'Prevention of raised intraocular pressure'),
        LString('Asthme/bronchospasme', 'Asthma/bronchospasm'),
      ],
      advantages: [
        LString('Réduit réponse hémodynamique à l\'intubation', 'Reduces the hemodynamic response to intubation'),
        LString('Bronchodilatation', 'Bronchodilation'),
        LString('Réduit la PIC', 'Reduces ICP'),
      ],
      sideEffects: [
        LString('Hypotension (dose élevée)', 'Hypotension (high dose)'),
        LString('Convulsions (surdosage)', 'Seizures (overdose)'),
        LString('Arythmies', 'Arrhythmias'),
      ],
      contraindications: [
        LString('Allergie aux anesthésiques locaux amides', 'Allergy to amide local anesthetics'),
        LString('BAV haut degré', 'High-grade AV block'),
        LString('Syndrome de Wolff-Parkinson-White', 'Wolff-Parkinson-White syndrome'),
      ],
      precautions: [
        LString('Insuffisance cardiaque', 'Heart failure'),
        LString('Insuffisance hépatique', 'Hepatic impairment'),
      ],
      concentrations: [LString('10 mg/mL', '10 mg/mL'), LString('20 mg/mL', '20 mg/mL')],
      notes: [
        LString('Administrer 3 min avant laryngoscopie', 'Give 3 min before laryngoscopy'),
        LString('Bénéfice contesté dans la littérature récente', 'Benefit disputed in recent literature'),
        LString('Utilisé principalement pour HTIC et asthme', 'Mainly used for raised ICP and asthma'),
      ],
    ),

    // =====================
    // REVERSAL AGENTS
    // =====================
    SedationDrug(
      id: 'naloxone',
      name: 'Naloxone',
      genericName: 'Naloxone',
      drugClass: LString('Antagoniste opioïde', 'Opioid antagonist'),
      role: [DrugRole.adjunct],
      sedationTypes: [SedationType.procedural, SedationType.rsi],
      standardDose: 0.04,
      doseUnit: 'mg',
      route: ['IV', 'IM', 'IN', 'SC'],
      dosesByAge: [
        DoseByAge(ageGroup: AgeGroup.adult, ageRange: '18+ ans', dose: 0.04, notes: LString('Titrer 0.04-0.4 mg IV q2-3 min; arrêt respiratoire: 0.4-2 mg', 'Titrate 0.04-0.4 mg IV q2-3 min; respiratory arrest: 0.4-2 mg')),
        DoseByAge(ageGroup: AgeGroup.child, ageRange: '< 18 ans', dose: 0.01, notes: LString('0.01 mg/kg IV, répéter jusqu\'à 0.1 mg/kg', '0.01 mg/kg IV, repeat up to 0.1 mg/kg')),
      ],
      onsetSeconds: 120,
      durationMinutes: 45,
      mechanism: LString('Antagoniste compétitif des récepteurs opioïdes', 'Competitive opioid receptor antagonist'),
      indications: [
        LString('Réversion de la dépression respiratoire aux opioïdes', 'Reversal of opioid-induced respiratory depression'),
        LString('Surdosage aux opioïdes', 'Opioid overdose'),
      ],
      advantages: [
        LString('Réversion rapide', 'Rapid reversal'),
        LString('Titrable', 'Titratable'),
        LString('Multiples voies (IV/IM/IN/SC)', 'Multiple routes (IV/IM/IN/SC)'),
      ],
      sideEffects: [
        LString('Syndrome de sevrage aigu', 'Acute withdrawal syndrome'),
        LString('Œdème pulmonaire aigu', 'Acute pulmonary edema'),
        LString('Agitation, tachycardie, hypertension', 'Agitation, tachycardia, hypertension'),
      ],
      contraindications: [
        LString('Aucune contre-indication absolue en urgence vitale', 'No absolute contraindication in a life-threatening emergency'),
      ],
      precautions: [
        LString('Durée d\'action < opioïdes longue durée: risque de re-sédation', 'Duration < long-acting opioids: risk of re-sedation'),
        LString('Titrer pour préserver l\'analgésie', 'Titrate to preserve analgesia'),
      ],
      concentrations: [LString('0.4 mg/mL', '0.4 mg/mL')],
      notes: [
        LString('Perfusion continue si opioïde de longue durée', 'Continuous infusion if long-acting opioid'),
        LString('Naloxone IN 4 mg (surdosage communautaire)', 'IN naloxone 4 mg (community overdose)'),
        LString('Surveillance prolongée après réversion', 'Extended monitoring after reversal'),
      ],
    ),

    SedationDrug(
      id: 'flumazenil',
      name: 'Flumazénil',
      genericName: 'Flumazenil',
      drugClass: LString('Antagoniste des benzodiazépines', 'Benzodiazepine antagonist'),
      role: [DrugRole.adjunct],
      sedationTypes: [SedationType.procedural],
      standardDose: 0.2,
      doseUnit: 'mg',
      route: ['IV'],
      dosesByAge: [
        DoseByAge(ageGroup: AgeGroup.adult, ageRange: '18+ ans', dose: 0.2, notes: LString('0.2 mg IV sur 15s, répéter 0.1-0.2 mg/min, max 1 mg', '0.2 mg IV over 15s, repeat 0.1-0.2 mg/min, max 1 mg')),
        DoseByAge(ageGroup: AgeGroup.child, ageRange: '< 18 ans', dose: 0.01, notes: LString('0.01 mg/kg IV (max 0.2 mg par dose)', '0.01 mg/kg IV (max 0.2 mg per dose)')),
      ],
      onsetSeconds: 60,
      durationMinutes: 45,
      mechanism: LString('Antagoniste compétitif du site benzodiazépine du récepteur GABA-A', 'Competitive antagonist at the GABA-A benzodiazepine site'),
      indications: [
        LString('Réversion de la sédation aux benzodiazépines (sédation procédurale)', 'Reversal of benzodiazepine sedation (procedural sedation)'),
      ],
      advantages: [
        LString('Réversion rapide de la sédation aux BZD', 'Rapid reversal of BZD sedation'),
      ],
      sideEffects: [
        LString('Convulsions (dépendance BZD ou co-ingestion pro-convulsivante)', 'Seizures (BZD dependence or pro-convulsant co-ingestion)'),
        LString('Arythmies', 'Arrhythmias'),
        LString('Agitation, syndrome de sevrage', 'Agitation, withdrawal syndrome'),
      ],
      contraindications: [
        LString('Dépendance chronique aux benzodiazépines', 'Chronic benzodiazepine dependence'),
        LString('Ingestion d\'antidépresseurs tricycliques / pro-convulsivants', 'Tricyclic antidepressant / pro-convulsant ingestion'),
        LString('Épilepsie traitée par benzodiazépines', 'Epilepsy treated with benzodiazepines'),
      ],
      precautions: [
        LString('NON recommandé en routine après sédation procédurale (risque de convulsions)', 'NOT recommended routinely after procedural sedation (seizure risk)'),
        LString('Durée d\'action < BZD longue durée: risque de re-sédation', 'Duration < long-acting BZD: risk of re-sedation'),
      ],
      concentrations: [LString('0.1 mg/mL', '0.1 mg/mL')],
      notes: [
        LString('Réserver aux surdosages iatrogènes purs en BZD', 'Reserve for pure iatrogenic BZD overdose'),
        LString('Surveillance prolongée: re-sédation possible', 'Extended monitoring: re-sedation possible'),
      ],
    ),

    SedationDrug(
      id: 'sugammadex',
      name: 'Sugammadex',
      genericName: 'Sugammadex',
      drugClass: LString('Agent de décurarisation (cyclodextrine)', 'Reversal agent (cyclodextrin)'),
      role: [DrugRole.adjunct],
      sedationTypes: [SedationType.rsi, SedationType.maintenance],
      standardDose: 16.0,
      doseUnit: 'mg/kg',
      route: ['IV'],
      dosesByAge: [
        DoseByAge(ageGroup: AgeGroup.adult, ageRange: '18+ ans', dose: 16.0, notes: LString('16 mg/kg: réversion immédiate (post-ISR rocuronium); 2-4 mg/kg: réversion de routine', '16 mg/kg: immediate reversal (post-RSI rocuronium); 2-4 mg/kg: routine reversal')),
        DoseByAge(ageGroup: AgeGroup.child, ageRange: '2-17 ans', dose: 16.0, notes: LString('Réversion de routine: 2-4 mg/kg', 'Routine reversal: 2-4 mg/kg')),
      ],
      onsetSeconds: 180,
      durationMinutes: 60,
      mechanism: LString('Encapsulation (chélation) du rocuronium/vécuronium', 'Encapsulates (chelates) rocuronium/vecuronium'),
      indications: [
        LString('Réversion du bloc neuromusculaire au rocuronium/vécuronium', 'Reversal of rocuronium/vecuronium neuromuscular block'),
        LString('Impossibilité d\'intuber/oxygéner après ISR au rocuronium', '"Can\'t intubate, can\'t oxygenate" after rocuronium RSI'),
      ],
      advantages: [
        LString('Réversion rapide même d\'un bloc profond', 'Rapid reversal even of deep block'),
        LString('Pas d\'effets muscariniques (vs néostigmine)', 'No muscarinic effects (vs neostigmine)'),
      ],
      sideEffects: [
        LString('Bradycardie/asystolie (rare)', 'Bradycardia/asystole (rare)'),
        LString('Réactions anaphylactiques', 'Anaphylactic reactions'),
        LString('Allongement transitoire du TCA/INR', 'Transient prolongation of aPTT/INR'),
      ],
      contraindications: [
        LString('Hypersensibilité connue au sugammadex', 'Known hypersensitivity to sugammadex'),
      ],
      precautions: [
        LString('Contraception hormonale inefficace pendant 7 jours', 'Hormonal contraception ineffective for 7 days'),
        LString('Ne réverse PAS le bloc dépolarisant (succinylcholine)', 'Does NOT reverse depolarizing block (succinylcholine)'),
        LString('Ne réverse pas la sédation aux benzodiazépines/opioïdes', 'Does not reverse benzodiazepine/opioid sedation'),
      ],
      concentrations: [LString('100 mg/mL', '100 mg/mL')],
      notes: [
        LString('Réversion immédiate post-ISR = 16 mg/kg', 'Immediate post-RSI reversal = 16 mg/kg'),
        LString('Réversion de routine = 2-4 mg/kg selon la profondeur du bloc', 'Routine reversal = 2-4 mg/kg depending on block depth'),
        LString('Agit uniquement sur rocuronium et vécuronium', 'Acts only on rocuronium and vecuronium'),
      ],
    ),
  ];
}
