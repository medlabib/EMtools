import '../../domain/entities/protocol.dart';

/// Complete list of emergency medicine protocols
/// Sources: HAS, SFMU, ERC/ILCOR Guidelines
final List<Protocol> allProtocols = [
  ...cardiologyProtocols,
  ...respiratoryProtocols,
  ...neurologyProtocols,
  ...traumaProtocols,
  ...sepsisProtocols,
  ...toxicologyProtocols,
  ...metabolicProtocols,
  ...pediatricProtocols,
  ...obstetricProtocols,
  ...analgesiaProtocols,
  ...resuscitationProtocols,
];

// ============================================================================
// CARDIOLOGY PROTOCOLS
// ============================================================================

final List<Protocol> cardiologyProtocols = [
  // ACR Adulte
  Protocol(
    id: 'acr-adulte',
    name: 'Arrêt Cardiorespiratoire Adulte',
    category: ProtocolCategory.cardiology,
    description: 'Prise en charge de l\'ACR selon les recommandations ERC 2021',
    indication: 'Patient en arrêt cardiorespiratoire (absence de pouls, absence de respiration efficace)',
    contraindication: 'Directives anticipées limitant la réanimation, signes de mort certaine',
    steps: [
      ProtocolStep(
        title: '1. Sécurité et reconnaissance',
        content: 'Vérifier la sécurité de la scène. Évaluer la conscience et la respiration.',
        bulletPoints: [
          'Secouer les épaules et appeler fort',
          'Regarder le thorax 10 secondes maximum',
          'Gasps = absence de respiration',
        ],
        warning: 'Ne pas perdre de temps à chercher le pouls si non formé',
      ),
      ProtocolStep(
        title: '2. Alerter et RCP de base',
        content: 'Alerter les secours (15/112) et débuter immédiatement la RCP.',
        bulletPoints: [
          'MCE: 100-120/min, profondeur 5-6 cm',
          'Ratio 30:2 sans voie aérienne avancée',
          'Minimiser les interruptions < 10 sec',
          'Changer de masseur toutes les 2 min',
        ],
        tip: 'Utiliser le métronome du scope ou une application',
      ),
      ProtocolStep(
        title: '3. Défibrillation',
        content: 'Analyser le rythme dès que le défibrillateur est disponible.',
        bulletPoints: [
          'Rythme choquable (FV/TV sans pouls): choc 150-200J biphasique',
          'Reprendre immédiatement MCE après le choc',
          'Analyser le rythme toutes les 2 min',
          'Rythme non choquable (asystolie/AESP): continuer RCP',
        ],
        warning: 'Ne pas interrompre le MCE pendant la charge',
      ),
      ProtocolStep(
        title: '4. Voies aériennes et ventilation',
        content: 'Sécuriser les voies aériennes progressivement.',
        bulletPoints: [
          'Canule oropharyngée + ballon-masque initialement',
          'IOT si opérateur expérimenté sans interrompre MCE',
          'Dispositif supraglottique si IOT difficile',
          'Ventilation 10/min une fois voie aérienne avancée',
        ],
        tip: 'La qualité du MCE prime sur l\'intubation',
      ),
      ProtocolStep(
        title: '5. Adrénaline',
        content: 'Administrer l\'adrénaline selon le rythme.',
        bulletPoints: [
          'Rythme non choquable: 1 mg IV dès que possible',
          'Rythme choquable: 1 mg IV après le 3ème choc',
          'Répéter 1 mg toutes les 3-5 minutes',
          'Voie IO si accès IV impossible',
        ],
      ),
      ProtocolStep(
        title: '6. Amiodarone (si rythme choquable)',
        content: 'Administrer après le 3ème choc inefficace.',
        bulletPoints: [
          '300 mg IV après le 3ème choc',
          '150 mg IV après le 5ème choc si toujours en FV/TV',
        ],
      ),
      ProtocolStep(
        title: '7. Causes réversibles (4H/4T)',
        content: 'Rechercher et traiter les causes réversibles.',
        bulletPoints: [
          'Hypoxie → oxygénation, ventilation',
          'Hypovolémie → remplissage, transfusion',
          'Hypo/Hyperkaliémie → correction ionique',
          'Hypothermie → réchauffement',
          'Thrombose coronaire → coronarographie',
          'Thrombose pulmonaire → thrombolyse',
          'Tamponnade → péricardiocentèse',
          'Pneumothorax sous Tension → exsufflation',
        ],
        warning: 'La thrombolyse nécessite 60-90 min de RCP après',
      ),
      ProtocolStep(
        title: '8. Soins post-ACR',
        content: 'Si RACS (Retour à une Activité Circulatoire Spontanée).',
        bulletPoints: [
          'Objectif SpO2 94-98%, éviter hyperoxie',
          'PAS > 100 mmHg (noradrénaline si besoin)',
          'Contrôle glycémique (éviter hypo/hyperglycémie)',
          'Contrôle température cible 32-36°C pendant 24h',
          'Coronarographie si suspicion SCA',
          'EEG et scanner cérébral',
        ],
      ),
    ],
    keyPoints: 'MCE de haute qualité est la priorité absolue. Minimiser les interruptions. Défibrillation précoce si rythme choquable.',
    source: 'ERC Guidelines 2021',
    sourceUrl: 'https://www.erc.edu',
    lastUpdated: 2021,
  ),

  // SCA ST+
  Protocol(
    id: 'sca-st-plus',
    name: 'SCA ST+ (STEMI)',
    category: ProtocolCategory.cardiology,
    description: 'Syndrome coronarien aigu avec sus-décalage du segment ST',
    indication: 'Douleur thoracique typique avec sus-décalage ST ≥ 1mm dans 2 dérivations contiguës ou BBG nouveau',
    contraindication: 'Voir contre-indications à la thrombolyse si applicable',
    steps: [
      ProtocolStep(
        title: '1. Évaluation initiale',
        content: 'Diagnostic et stratification rapide.',
        bulletPoints: [
          'ECG 12 dérivations < 10 min',
          'Monitoring continu (scope, SpO2)',
          'Voie veineuse périphérique',
          'Bilan: troponine, NFS, iono, créat, coag',
        ],
        warning: 'ECG 18 dérivations si suspicion infarctus inférieur ou postérieur',
      ),
      ProtocolStep(
        title: '2. Traitement antalgique et symptomatique',
        content: 'Soulager la douleur et stabiliser le patient.',
        bulletPoints: [
          'Morphine IV titrée si douleur intense (bolus 2-3 mg)',
          'O2 uniquement si SpO2 < 90%',
          'Position demi-assise',
        ],
        tip: 'Éviter O2 systématique (risque d\'hyperoxie)',
      ),
      ProtocolStep(
        title: '3. Traitement antithrombotique',
        content: 'Double antiagrégation plaquettaire.',
        bulletPoints: [
          'Aspirine 150-300 mg PO (ou 75-150 mg IV)',
          'Inhibiteur P2Y12: Ticagrelor 180 mg ou Prasugrel 60 mg',
          'Si > 75 ans ou < 60 kg: Clopidogrel 600 mg',
          'Anticoagulation: HNF 70-100 UI/kg IV ou Énoxaparine',
        ],
        warning: 'Prasugrel contre-indiqué si ATCD AVC/AIT ou > 75 ans',
      ),
      ProtocolStep(
        title: '4. Stratégie de reperfusion',
        content: 'Choix entre angioplastie primaire et thrombolyse.',
        bulletPoints: [
          'Angioplastie primaire si délai < 120 min (préféré)',
          'Thrombolyse si délai angioplastie > 120 min et symptômes < 12h',
          'Ténectéplase dose adaptée au poids',
          'Transfert pour coronarographie 2-24h après thrombolyse',
        ],
        tip: 'Contact direct avec cardiologue interventionnel',
      ),
      ProtocolStep(
        title: '5. Critères de reperfusion post-thrombolyse',
        content: 'Évaluer le succès de la thrombolyse à 60-90 min.',
        bulletPoints: [
          'Succès: réduction ST > 50%, disparition douleur',
          'Échec: coronarographie de sauvetage urgente',
        ],
      ),
      ProtocolStep(
        title: '6. Complications à surveiller',
        content: 'Surveillance des complications précoces.',
        bulletPoints: [
          'Troubles du rythme (FV, TV, BAV)',
          'Insuffisance cardiaque aiguë',
          'Choc cardiogénique',
          'Complications mécaniques (rupture, CIV)',
        ],
      ),
    ],
    keyPoints: 'Time is muscle. Objectif: premier contact médical → reperfusion < 120 min. ECG < 10 min.',
    source: 'ESC Guidelines 2023 - STEMI',
    sourceUrl: 'https://www.escardio.org',
    lastUpdated: 2023,
  ),

  // SCA ST-
  Protocol(
    id: 'sca-st-moins',
    name: 'SCA ST- (NSTEMI)',
    category: ProtocolCategory.cardiology,
    description: 'Syndrome coronarien aigu sans sus-décalage du ST',
    indication: 'Douleur thoracique avec modification ECG (sous-décalage ST, ondes T négatives) et/ou élévation troponine',
    steps: [
      ProtocolStep(
        title: '1. Diagnostic',
        content: 'Confirmer le diagnostic et stratifier le risque.',
        bulletPoints: [
          'ECG répété si premier normal',
          'Troponine hs à H0 et H1 (ou H3)',
          'Score GRACE pour stratification',
        ],
      ),
      ProtocolStep(
        title: '2. Stratification du risque (GRACE)',
        content: 'Déterminer le délai de coronarographie.',
        bulletPoints: [
          'Très haut risque (immédiat < 2h): instabilité HD, arythmie, douleur réfractaire',
          'Haut risque (< 24h): GRACE > 140, modification ST/T, élévation troponine',
          'Risque intermédiaire (< 72h): diabète, IRC, FEVG < 40%, angioplastie récente',
          'Bas risque: test d\'ischémie non invasif',
        ],
      ),
      ProtocolStep(
        title: '3. Traitement antithrombotique',
        content: 'Similaire au STEMI avec adaptation selon stratégie.',
        bulletPoints: [
          'Aspirine 150-300 mg',
          'Inhibiteur P2Y12 selon timing coronarographie',
          'Anticoagulation: Fondaparinux 2.5 mg SC (préféré si non urgent)',
          'ou Énoxaparine 1 mg/kg x2/j',
        ],
        tip: 'Ticagrelor en prétraitement si coronarographie prévue',
      ),
      ProtocolStep(
        title: '4. Traitements adjuvants',
        content: 'Optimisation du traitement médical.',
        bulletPoints: [
          'Bêtabloquant si FC > 70 et pas de CI',
          'IEC/ARA2 si FEVG altérée ou HTA',
          'Statine haute dose',
          'IPP si double antiagrégation',
        ],
      ),
    ],
    keyPoints: 'La stratification du risque guide le délai de coronarographie. Le score GRACE est essentiel.',
    source: 'ESC Guidelines 2023 - NSTE-ACS',
    sourceUrl: 'https://www.escardio.org',
    lastUpdated: 2023,
  ),

  // OAP
  Protocol(
    id: 'oap',
    name: 'Œdème Aigu du Poumon',
    category: ProtocolCategory.cardiology,
    description: 'Insuffisance cardiaque aiguë avec œdème pulmonaire',
    indication: 'Dyspnée aiguë avec signes de congestion pulmonaire et/ou systémique',
    steps: [
      ProtocolStep(
        title: '1. Évaluation immédiate',
        content: 'Évaluer la gravité et le profil hémodynamique.',
        bulletPoints: [
          'Position assise ou demi-assise',
          'Signes de gravité: tirage, cyanose, sueurs, troubles conscience',
          'Profil "chaud-humide" vs "froid-humide" (choc cardiogénique)',
          'Rechercher facteur déclenchant (SCA, arythmie, poussée HTA)',
        ],
        warning: 'Si PAS < 90 mmHg: choc cardiogénique → protocole spécifique',
      ),
      ProtocolStep(
        title: '2. Oxygénation',
        content: 'Corriger l\'hypoxémie rapidement.',
        bulletPoints: [
          'O2 haut débit si SpO2 < 90%',
          'VNI (CPAP/BiPAP) si persistance détresse',
          'CPAP 5-10 cmH2O ou BiPAP (IPAP 10-15, EPAP 5-10)',
          'Intubation si échec VNI ou trouble conscience',
        ],
        tip: 'VNI à privilégier, réduit le recours à l\'intubation',
      ),
      ProtocolStep(
        title: '3. Diurétiques',
        content: 'Réduire la surcharge hydrosodée.',
        bulletPoints: [
          'Furosémide 40-80 mg IV (si traitement chronique: dose ≥ dose habituelle)',
          'Répéter si réponse insuffisante',
          'Objectif diurèse > 100 mL/h les premières heures',
        ],
      ),
      ProtocolStep(
        title: '4. Vasodilatateurs (si PAS > 110 mmHg)',
        content: 'Réduire la post-charge et la congestion.',
        bulletPoints: [
          'Trinitrine sublinguale puis IVSE',
          'Dose: 1-2 mg/h, titrer jusqu\'à 10 mg/h',
          'Surveillance tensionnelle rapprochée',
        ],
        warning: 'CI si PAS < 110 mmHg ou prise récente d\'IPDE5',
      ),
      ProtocolStep(
        title: '5. Rechercher et traiter la cause',
        content: 'Identifier le facteur déclenchant.',
        bulletPoints: [
          'ECG: SCA? Arythmie?',
          'Troponine, BNP/NT-proBNP',
          'Échocardiographie',
          'Si SCA: stratégie de reperfusion',
          'Si FA rapide: contrôle fréquence/rythme',
        ],
      ),
    ],
    keyPoints: 'Position assise + O2/VNI + Diurétiques + Vasodilatateurs (si PAS ok). Identifier la cause.',
    source: 'ESC Guidelines 2021 - Heart Failure',
    sourceUrl: 'https://www.escardio.org',
    lastUpdated: 2021,
  ),

  // Troubles du rythme
  Protocol(
    id: 'troubles-rythme',
    name: 'Troubles du Rythme aux Urgences',
    category: ProtocolCategory.cardiology,
    description: 'Prise en charge des tachycardies et bradycardies instables',
    indication: 'Arythmie avec retentissement hémodynamique ou symptômes sévères',
    steps: [
      ProtocolStep(
        title: '1. Évaluation de l\'instabilité',
        content: 'Identifier les signes de mauvaise tolérance.',
        bulletPoints: [
          'Hypotension (PAS < 90 mmHg)',
          'Altération de la conscience',
          'Douleur thoracique ischémique',
          'Insuffisance cardiaque aiguë',
        ],
        warning: 'Patient instable = cardioversion/pacing en urgence',
      ),
      ProtocolStep(
        title: '2. Tachycardie instable',
        content: 'Cardioversion électrique synchronisée.',
        bulletPoints: [
          'Sédation rapide (midazolam, étomidate, kétamine)',
          'Mode synchrone obligatoire (sauf FV)',
          'QRS fin: 70-120J biphasique',
          'QRS large: 120-150J biphasique',
        ],
      ),
      ProtocolStep(
        title: '3. Tachycardie régulière à QRS fins (stable)',
        content: 'Manœuvres vagales puis adénosine.',
        bulletPoints: [
          'Manœuvres vagales (Valsalva modifié)',
          'Adénosine 6 mg IVD rapide puis 12 mg si échec',
          'Si FA: contrôle fréquence ou cardioversion selon durée',
        ],
        tip: 'Valsalva modifié: expiration forcée puis lever les jambes',
      ),
      ProtocolStep(
        title: '4. Tachycardie régulière à QRS larges (stable)',
        content: 'Traiter comme TV jusqu\'à preuve du contraire.',
        bulletPoints: [
          'Amiodarone 300 mg IV en 20-60 min',
          'Si TV confirmée: alternatives selon étiologie',
          'Ne jamais utiliser vérapamil si doute',
        ],
      ),
      ProtocolStep(
        title: '5. Bradycardie instable',
        content: 'Stimulation cardiaque.',
        bulletPoints: [
          'Atropine 0.5-1 mg IV (max 3 mg)',
          'Si échec: adrénaline IV 2-10 µg/min',
          'Pacing externe transcutané',
          'Pacing transveneux si échec',
        ],
        warning: 'Atropine inefficace si bloc infra-nodal ou cœur transplanté',
      ),
    ],
    keyPoints: 'Instable = choc électrique ou pacing. Stable = traitement médicamenteux selon le type.',
    source: 'ERC Guidelines 2021 - Arythmies péri-arrêt',
    sourceUrl: 'https://www.erc.edu',
    lastUpdated: 2021,
  ),
];

// ============================================================================
// RESPIRATORY PROTOCOLS
// ============================================================================

final List<Protocol> respiratoryProtocols = [
  // Asthme aigu grave
  Protocol(
    id: 'aag',
    name: 'Asthme Aigu Grave',
    category: ProtocolCategory.respiratory,
    description: 'Exacerbation sévère d\'asthme mettant en jeu le pronostic vital',
    indication: 'DEP < 50%, impossibilité de parler, FR > 25, FC > 110, SpO2 < 92%',
    steps: [
      ProtocolStep(
        title: '1. Évaluation de la sévérité',
        content: 'Identifier les critères de gravité.',
        bulletPoints: [
          'DEP < 50% valeur théorique = AAG',
          'DEP < 33% ou inatteignable = asthme aigu très grave',
          'Signes de lutte, cyanose, silence auscultatoire',
          'Troubles de conscience, bradycardie = arrêt imminent',
        ],
        warning: 'Patient épuisé = alerte maximale, préparer intubation',
      ),
      ProtocolStep(
        title: '2. Oxygénothérapie et bronchodilatateurs',
        content: 'Traitement de première ligne.',
        bulletPoints: [
          'O2 pour SpO2 93-95%',
          'Salbutamol nébulisé 5 mg / 20 min x3 puis toutes les heures',
          'ou Salbutamol aérosol-doseur 4-10 bouffées avec chambre',
          'Ipratropium 0.5 mg nébulisé (ajouté au salbutamol)',
        ],
        tip: 'Nébulisation à l\'O2 6-8 L/min',
      ),
      ProtocolStep(
        title: '3. Corticothérapie',
        content: 'Systémique précoce.',
        bulletPoints: [
          'Méthylprednisolone 1-2 mg/kg IV',
          'ou Prednisone 1 mg/kg PO si patient peut avaler',
          'Effet en 4-6 heures',
        ],
      ),
      ProtocolStep(
        title: '4. Si échec ou asthme très grave',
        content: 'Escalade thérapeutique.',
        bulletPoints: [
          'Sulfate de magnésium 2g IV en 20 min',
          'Salbutamol IV: 0.1-0.2 µg/kg/min IVSE',
          'VNI si coopérant (attention auto-PEP)',
          'Adrénaline 0.5 mg IM si anaphylaxie associée',
        ],
        warning: 'Salbutamol IV = surveillance scope continue (hypokaliémie, arythmies)',
      ),
      ProtocolStep(
        title: '5. Intubation si nécessaire',
        content: 'Indication: épuisement, trouble conscience, arrêt.',
        bulletPoints: [
          'ISR avec kétamine (bronchodilatatrice)',
          'Ventilation: FR basse (10-12), I/E 1:4-5',
          'Tolérer hypercapnie permissive',
          'Attention au barotraumatisme',
        ],
        warning: 'L\'intubation peut précipiter l\'arrêt, préparer adrénaline',
      ),
    ],
    keyPoints: 'Bronchodilatateurs + O2 + corticoïdes précoces. Magnésium si sévère. Intubation = dernier recours.',
    source: 'GINA 2023, SFMU',
    sourceUrl: 'https://ginasthma.org',
    lastUpdated: 2023,
  ),

  // BPCO décompensée
  Protocol(
    id: 'bpco-decompensee',
    name: 'Exacerbation BPCO',
    category: ProtocolCategory.respiratory,
    description: 'Décompensation aiguë de BPCO',
    indication: 'Majoration dyspnée, volume et/ou purulence des expectorations',
    steps: [
      ProtocolStep(
        title: '1. Évaluation de la gravité',
        content: 'Stratifier le niveau de soins nécessaire.',
        bulletPoints: [
          'Détresse respiratoire aiguë',
          'Altération conscience, cyanose',
          'pH < 7.35, PaCO2 > 45 mmHg',
          'SpO2 < 88% sous O2',
          'Comorbidités sévères',
        ],
      ),
      ProtocolStep(
        title: '2. Oxygénothérapie contrôlée',
        content: 'Objectif SpO2 88-92%.',
        bulletPoints: [
          'Commencer à 24-28% (lunettes 1-2 L/min)',
          'Titrer pour SpO2 88-92%',
          'Gazométrie si SpO2 < 92% ou signes gravité',
          'Éviter hyperoxie (risque hypercapnie)',
        ],
        warning: 'SpO2 cible plus basse que population générale',
      ),
      ProtocolStep(
        title: '3. Bronchodilatateurs',
        content: 'Traitement systématique.',
        bulletPoints: [
          'Salbutamol 2.5-5 mg nébulisé / 20 min x3',
          'Ipratropium 0.5 mg ajouté aux nébulisations',
          'Puis espacement progressif selon réponse',
        ],
        tip: 'Nébulisation à l\'air si possible (risque hypercapnie si O2)',
      ),
      ProtocolStep(
        title: '4. Corticothérapie',
        content: 'Cure courte systématique.',
        bulletPoints: [
          'Prednisone 40 mg/j PO pendant 5 jours',
          'ou équivalent IV si voie orale impossible',
        ],
      ),
      ProtocolStep(
        title: '5. Antibiothérapie',
        content: 'Si critères d\'infection.',
        bulletPoints: [
          'Indication: purulence + augmentation volume ou dyspnée',
          'Amoxicilline-acide clavulanique 1g x3/j',
          'ou Pristinamycine si allergie',
          'Durée 5 jours',
        ],
      ),
      ProtocolStep(
        title: '6. VNI',
        content: 'Si acidose respiratoire.',
        bulletPoints: [
          'Indication: pH < 7.35 avec PaCO2 > 45 mmHg',
          'BiPAP: IPAP 10-20, EPAP 4-8 cmH2O',
          'Réévaluation gazométrie à H1-H2',
          'Réduction intubation et mortalité',
        ],
        warning: 'CI si coma, arrêt immine, vomissements actifs',
      ),
    ],
    keyPoints: 'O2 contrôlé (88-92%) + bronchodilatateurs + corticoïdes. VNI si acidose respiratoire.',
    source: 'GOLD 2024, SPLF',
    sourceUrl: 'https://goldcopd.org',
    lastUpdated: 2024,
  ),

  // Pneumothorax
  Protocol(
    id: 'pneumothorax',
    name: 'Pneumothorax',
    category: ProtocolCategory.respiratory,
    description: 'Prise en charge du pneumothorax spontané et traumatique',
    indication: 'Douleur thoracique brutale, dyspnée, asymétrie auscultatoire',
    steps: [
      ProtocolStep(
        title: '1. Évaluation clinique',
        content: 'Identifier le type et la gravité.',
        bulletPoints: [
          'Primaire: patient jeune, pas de pathologie pulmonaire',
          'Secondaire: BPCO, mucoviscidose, pathologie sous-jacente',
          'Traumatique: contexte évocateur',
          'Compressif: urgence vitale (déviation trachée, détresse)',
        ],
        warning: 'Pneumothorax compressif = exsufflation immédiate AVANT radio',
      ),
      ProtocolStep(
        title: '2. Pneumothorax compressif',
        content: 'Exsufflation à l\'aiguille en urgence.',
        bulletPoints: [
          '2ème espace intercostal, ligne médio-claviculaire',
          'Cathéter 14-16G, aiguille perpendiculaire',
          'Bruit de souffle = confirmation',
          'Puis drainage thoracique',
        ],
      ),
      ProtocolStep(
        title: '3. Pneumothorax primaire',
        content: 'Stratégie selon taille et symptômes.',
        bulletPoints: [
          '< 2 cm et asymptomatique: observation, contrôle radio',
          '> 2 cm ou symptomatique: exsufflation à l\'aiguille',
          'Si échec exsufflation: drainage thoracique',
        ],
        tip: 'Mesure à 2 cm du sommet sur la ligne médio-claviculaire',
      ),
      ProtocolStep(
        title: '4. Pneumothorax secondaire',
        content: 'Drainage plus souvent nécessaire.',
        bulletPoints: [
          'Hospitalisation systématique',
          'Drainage si > 1 cm ou symptomatique',
          'Calibre drain adapté (20-24 Fr)',
          'Aspiration -10 à -20 cmH2O si persistance',
        ],
      ),
      ProtocolStep(
        title: '5. Technique de drainage',
        content: 'Triangle de sécurité.',
        bulletPoints: [
          'Zone: 4-5ème EIC, ligne axillaire moyenne',
          'Anesthésie locale jusqu\'à plèvre',
          'Incision, dissection mousse, pénétration digitale',
          'Drain dirigé vers apex',
          'Fixation et connexion système aspiratif',
        ],
      ),
    ],
    keyPoints: 'Compressif = exsufflation immédiate. Primaire: selon taille. Secondaire: drainage plus large.',
    source: 'BTS Guidelines 2023',
    sourceUrl: 'https://www.brit-thoracic.org.uk',
    lastUpdated: 2023,
  ),

  // Embolie pulmonaire
  Protocol(
    id: 'ep',
    name: 'Embolie Pulmonaire',
    category: ProtocolCategory.respiratory,
    description: 'Diagnostic et traitement de l\'embolie pulmonaire',
    indication: 'Dyspnée brutale, douleur thoracique, facteurs de risque thrombo-embolique',
    steps: [
      ProtocolStep(
        title: '1. Évaluation probabilité clinique',
        content: 'Score de Wells ou Genève.',
        bulletPoints: [
          'Wells: ATCD TVP/EP, FC>100, immobilisation/chirurgie récente',
          'Hémoptysie, cancer, signes TVP',
          'Probabilité faible/intermédiaire/forte',
        ],
      ),
      ProtocolStep(
        title: '2. Stratégie diagnostique',
        content: 'Selon probabilité clinique.',
        bulletPoints: [
          'Probabilité faible/intermédiaire: D-dimères d\'abord',
          'D-dimères négatifs (seuil ajusté âge): EP exclue',
          'D-dimères positifs ou proba forte: angioscanner',
          'Si CI scanner: scintigraphie V/Q',
        ],
        tip: 'Seuil D-dimères ajusté: âge x 10 µg/L si > 50 ans',
      ),
      ProtocolStep(
        title: '3. Évaluation gravité',
        content: 'Stratification pronostique.',
        bulletPoints: [
          'Haut risque: instabilité HD (PAS < 90 ou chute > 40 mmHg)',
          'Risque intermédiaire: PESI ≥ III + dilatation VD + troponine +',
          'Bas risque: PESI I-II',
        ],
      ),
      ProtocolStep(
        title: '4. EP à haut risque (massive)',
        content: 'Traitement urgent.',
        bulletPoints: [
          'Anticoagulation: HNF bolus + IVSE',
          'Thrombolyse: Alteplase 100 mg/2h ou 0.6 mg/kg/15 min si ACR',
          'Support hémodynamique: remplissage prudent, noradrénaline',
          'Embolectomie/ECMO si CI thrombolyse ou échec',
        ],
        warning: 'Remplissage limité < 500 mL (éviter surcharge VD)',
      ),
      ProtocolStep(
        title: '5. EP non à haut risque',
        content: 'Anticoagulation standard.',
        bulletPoints: [
          'AOD en première intention (rivaroxaban, apixaban)',
          'ou HBPM puis AVK',
          'Durée: 3 mois si facteur déclenchant transitoire',
          '≥ 6 mois si idiopathique ou cancer',
        ],
      ),
    ],
    keyPoints: 'Probabilité clinique → D-dimères ou scanner direct. Haut risque = thrombolyse. AOD si stable.',
    source: 'ESC Guidelines 2019 - Embolie Pulmonaire',
    sourceUrl: 'https://www.escardio.org',
    lastUpdated: 2019,
  ),

  // Détresse respiratoire aiguë
  Protocol(
    id: 'dra',
    name: 'Détresse Respiratoire Aiguë',
    category: ProtocolCategory.respiratory,
    description: 'Approche diagnostique et thérapeutique de la détresse respiratoire',
    indication: 'FR > 25/min, signes de lutte, SpO2 < 92%, cyanose',
    steps: [
      ProtocolStep(
        title: '1. Évaluation immédiate',
        content: 'ABC et stabilisation.',
        bulletPoints: [
          'Position adaptée (assis si OAP, décubitus si trauma)',
          'Oxygénothérapie haut débit initial',
          'Voie veineuse périphérique',
          'Monitoring: SpO2, ECG, PA',
        ],
      ),
      ProtocolStep(
        title: '2. Orientation diagnostique',
        content: 'Examen clinique ciblé.',
        bulletPoints: [
          'Stridor inspiratoire: obstruction haute',
          'Wheezing: bronchospasme (asthme, BPCO)',
          'Crépitants bilatéraux: OAP, pneumopathie, SDRA',
          'Asymétrie auscultatoire: pneumothorax, épanchement',
          'Signes de TVP: embolie pulmonaire',
        ],
      ),
      ProtocolStep(
        title: '3. Examens complémentaires',
        content: 'Bilan adapté au contexte.',
        bulletPoints: [
          'Gazométrie artérielle',
          'Radio thorax',
          'ECG, troponine, BNP si cardiaque suspecté',
          'D-dimères si EP suspectée',
          'Angioscanner si EP probable',
        ],
      ),
      ProtocolStep(
        title: '4. Oxygénothérapie avancée',
        content: 'Escalade selon réponse.',
        bulletPoints: [
          'Lunettes/masque: objectif SpO2 selon pathologie',
          'Optiflow (HFNC): 30-60 L/min, FiO2 ajustée',
          'VNI: CPAP ou BiPAP selon indication',
          'Intubation si échec ou contre-indication VNI',
        ],
      ),
      ProtocolStep(
        title: '5. Critères d\'intubation',
        content: 'Ne pas retarder si indication claire.',
        bulletPoints: [
          'Arrêt respiratoire ou imminence',
          'Trouble de conscience (GCS < 8)',
          'Épuisement respiratoire',
          'Échec VNI avec aggravation',
          'Instabilité hémodynamique sévère',
        ],
      ),
    ],
    keyPoints: 'Stabiliser d\'abord, diagnostiquer ensuite. Adapter l\'O2 à la pathologie. Ne pas retarder l\'IOT.',
    source: 'SFMU - Détresse respiratoire',
    lastUpdated: 2022,
  ),
];

// ============================================================================
// NEUROLOGY PROTOCOLS
// ============================================================================

final List<Protocol> neurologyProtocols = [
  // AVC ischémique
  Protocol(
    id: 'avc-ischemique',
    name: 'AVC Ischémique',
    category: ProtocolCategory.neurology,
    description: 'Accident vasculaire cérébral ischémique - thrombolyse et thrombectomie',
    indication: 'Déficit neurologique focal brutal évocateur d\'AVC',
    contraindication: 'Voir CI thrombolyse',
    steps: [
      ProtocolStep(
        title: '1. Reconnaissance et alerte',
        content: 'Identifier l\'AVC et noter l\'heure de début.',
        bulletPoints: [
          'FAST: Face, Arm, Speech, Time',
          'Heure du dernier moment vu normal (DLMN)',
          'Alerte UNV (Unité Neuro-Vasculaire)',
          'Glycémie capillaire immédiate',
        ],
        warning: 'Chaque minute perdue = 1.9 million neurones détruits',
      ),
      ProtocolStep(
        title: '2. Imagerie cérébrale',
        content: 'Scanner ou IRM en urgence.',
        bulletPoints: [
          'Scanner sans injection: éliminer hémorragie',
          'IRM si disponible rapidement (diffusion)',
          'Angioscanner/ARM si thrombectomie envisagée',
          'Objectif: porte-imagerie < 25 min',
        ],
      ),
      ProtocolStep(
        title: '3. Évaluation clinique',
        content: 'Score NIHSS.',
        bulletPoints: [
          'NIHSS: quantifier le déficit (0-42)',
          'NIHSS ≥ 6: occlusion proximale probable',
          'Vérifier contre-indications thrombolyse',
        ],
      ),
      ProtocolStep(
        title: '4. Thrombolyse IV',
        content: 'Si éligible dans les délais.',
        bulletPoints: [
          'Alteplase 0.9 mg/kg (max 90 mg)',
          '10% en bolus, 90% en 1h',
          'Délai < 4h30 du DLMN',
          'PA < 185/110 avant et < 180/105 après',
          'Surveillance neurologique rapprochée',
        ],
        warning: 'CI absolues: hémorragie cérébrale, chirurgie récente, saignement actif',
      ),
      ProtocolStep(
        title: '5. Thrombectomie mécanique',
        content: 'Si occlusion proximale.',
        bulletPoints: [
          'Indication: occlusion artère proximale (carotide, M1, basilaire)',
          'Délai jusqu\'à 6h (voire 24h si mismatch)',
          'En complément ou alternative à thrombolyse',
          'Transfert centre de neuroradiologie interventionnelle',
        ],
      ),
      ProtocolStep(
        title: '6. Soins de support',
        content: 'Mesures générales.',
        bulletPoints: [
          'Position tête à 30° si HTIC, sinon à plat',
          'O2 si SpO2 < 94%',
          'Contrôle glycémique (éviter hypo/hyperglycémie)',
          'Antiagrégant: aspirine 160-300 mg après imagerie',
          'Prévention complications: TVP, pneumopathie',
        ],
      ),
    ],
    keyPoints: 'Time is brain. DLMN crucial. Thrombolyse < 4h30. Thrombectomie si occlusion proximale.',
    source: 'ESO Guidelines 2021, HAS',
    sourceUrl: 'https://eso-stroke.org',
    lastUpdated: 2021,
  ),

  // AVC hémorragique
  Protocol(
    id: 'avc-hemorragique',
    name: 'AVC Hémorragique',
    category: ProtocolCategory.neurology,
    description: 'Hémorragie intracérébrale spontanée',
    indication: 'Déficit neurologique brutal avec hémorragie au scanner',
    steps: [
      ProtocolStep(
        title: '1. Diagnostic',
        content: 'Confirmer l\'hémorragie et évaluer la gravité.',
        bulletPoints: [
          'Scanner cérébral sans injection',
          'Volume hématome (formule ABC/2)',
          'Score ICH pour pronostic',
          'Rechercher engagement',
        ],
      ),
      ProtocolStep(
        title: '2. Contrôle de la pression artérielle',
        content: 'Objectif tensionnel adapté.',
        bulletPoints: [
          'Si PAS 150-220: cible < 140 mmHg (sûr)',
          'Si PAS > 220: réduction progressive',
          'Nicardipine IVSE ou Urapidil',
          'Éviter chute brutale de PA',
        ],
        tip: 'Réduction PA limite expansion hématome',
      ),
      ProtocolStep(
        title: '3. Réversion anticoagulation',
        content: 'Si patient sous anticoagulant.',
        bulletPoints: [
          'AVK: Vitamine K 10 mg IV + CCP (25-50 UI/kg)',
          'Dabigatran: Idarucizumab 5g IV',
          'Anti-Xa (rivaroxaban, apixaban): Andexanet si disponible, sinon CCP',
          'Héparine: Protamine',
          'Objectif INR < 1.3 en < 4h',
        ],
        warning: 'Urgence vitale - reverser sans attendre les résultats',
      ),
      ProtocolStep(
        title: '4. Prise en charge HTIC',
        content: 'Si signes d\'hypertension intracrânienne.',
        bulletPoints: [
          'Tête à 30°',
          'Mannitol 20% 0.5-1 g/kg ou SSH 7.5%',
          'Intubation si GCS < 8',
          'Objectif PPC > 60 mmHg',
        ],
      ),
      ProtocolStep(
        title: '5. Indication chirurgicale',
        content: 'Discussion neurochirurgicale.',
        bulletPoints: [
          'Hématome cérébelleux > 3 cm avec dégradation',
          'Hydrocéphalie (DVE)',
          'Hématome lobaire > 30 mL près surface',
          'Évacuation rarement bénéfique pour hématomes profonds',
        ],
      ),
    ],
    keyPoints: 'Contrôle PA précoce. Reverser anticoagulation immédiatement. Avis neurochirurgical.',
    source: 'AHA/ASA Guidelines 2022',
    lastUpdated: 2022,
  ),

  // État de mal épileptique
  Protocol(
    id: 'eme',
    name: 'État de Mal Épileptique',
    category: ProtocolCategory.neurology,
    description: 'Crise convulsive prolongée ou répétée sans récupération',
    indication: 'Crise > 5 min ou crises répétées sans retour conscience',
    steps: [
      ProtocolStep(
        title: '1. Phase initiale (0-5 min)',
        content: 'Protection et évaluation.',
        bulletPoints: [
          'Protection: retirer obstacles, PLS si possible',
          'Chronométrer la crise',
          'Glycémie capillaire',
          'Voie veineuse périphérique',
          'O2 si SpO2 < 94%',
        ],
        warning: 'Ne rien mettre dans la bouche',
      ),
      ProtocolStep(
        title: '2. Phase précoce (5-20 min)',
        content: 'Benzodiazépines.',
        bulletPoints: [
          'Clonazépam 1 mg IV (0.015 mg/kg)',
          'ou Diazépam 10 mg IV ou IR (0.2-0.3 mg/kg)',
          'ou Midazolam 10 mg IM si pas d\'accès IV',
          'Répéter une fois à 5 min si échec',
        ],
        tip: 'Midazolam IM aussi efficace que diazépam IV',
      ),
      ProtocolStep(
        title: '3. Phase établie (20-40 min)',
        content: 'Antiépileptiques de 2ème ligne.',
        bulletPoints: [
          'Levetiracetam 60 mg/kg IV (max 4500 mg) en 10-15 min',
          'ou Valproate 40 mg/kg IV (max 3000 mg) en 10 min',
          'ou Fosphénytoïne 20 mg EP/kg IV en 10-15 min',
          'CI valproate: hépatopathie, grossesse',
          'CI fosphénytoïne: troubles conduction',
        ],
      ),
      ProtocolStep(
        title: '4. Phase réfractaire (> 40 min)',
        content: 'Anesthésie générale.',
        bulletPoints: [
          'Intubation et ventilation mécanique',
          'Thiopental: bolus 2-3 mg/kg puis 3-5 mg/kg/h',
          'ou Midazolam: bolus 0.2 mg/kg puis 0.1-0.4 mg/kg/h',
          'ou Propofol: bolus 2 mg/kg puis 5-10 mg/kg/h',
          'Monitoring EEG continu',
        ],
        warning: 'Propofol: risque syndrome de perfusion aux lipides',
      ),
      ProtocolStep(
        title: '5. Recherche étiologique',
        content: 'Identifier et traiter la cause.',
        bulletPoints: [
          'Sevrage/intoxication alcool, benzodiazépines',
          'Hypoglycémie (→ G30%)',
          'Hyponatrémie (→ correction prudente)',
          'Infection (→ PL si suspicion)',
          'AVC, tumeur, trauma (→ imagerie)',
        ],
      ),
    ],
    keyPoints: 'Traiter tôt: BZD → Antiépileptique 2ème ligne → Anesthésie si réfractaire. Chercher cause.',
    source: 'SFMU 2018, Recommandations formalisées d\'experts',
    lastUpdated: 2018,
  ),

  // Coma
  Protocol(
    id: 'coma',
    name: 'Coma - Évaluation et PEC',
    category: ProtocolCategory.neurology,
    description: 'Approche du patient comateux aux urgences',
    indication: 'Altération de conscience avec GCS < 9',
    steps: [
      ProtocolStep(
        title: '1. Stabilisation initiale',
        content: 'ABC en priorité.',
        bulletPoints: [
          'Protection voies aériennes: PLS, aspiration, Guedel',
          'Intubation si GCS ≤ 8 ou réflexes abolis',
          'Oxygénation',
          'Accès vasculaire, monitoring',
        ],
      ),
      ProtocolStep(
        title: '2. Évaluation neurologique',
        content: 'Examen ciblé.',
        bulletPoints: [
          'Score de Glasgow: E + V + M',
          'Pupilles: taille, réactivité, anisocorie',
          'Réflexes du tronc: cornéen, oculocéphalique',
          'Réponse motrice: localisation, décortication, décérébration',
          'Signes de latéralisation',
        ],
        warning: 'Anisocorie + coma = engagement jusqu\'à preuve du contraire',
      ),
      ProtocolStep(
        title: '3. Causes métaboliques urgentes',
        content: 'À éliminer immédiatement.',
        bulletPoints: [
          'Glycémie capillaire → si hypo: G30% 50 mL',
          'Si éthylisme/dénutrition: Thiamine 500 mg IV AVANT glucose',
          'Si suspicion opioïdes: Naloxone 0.4 mg IV (répétable)',
          'Si suspicion BZD: Flumazénil 0.2 mg (CI si épilepsie)',
        ],
      ),
      ProtocolStep(
        title: '4. Orientation diagnostique',
        content: 'Examens selon contexte.',
        bulletPoints: [
          'Scanner cérébral sans injection (hémorragie, AVC, HTIC)',
          'Biologie: glycémie, iono, calcium, ammoniémie, toxiques',
          'PL si fièvre et scanner normal',
          'EEG si suspicion état de mal non convulsif',
        ],
      ),
      ProtocolStep(
        title: '5. Étiologies principales',
        content: 'Causes à évoquer.',
        bulletPoints: [
          'Traumatique: hémorragie, contusion',
          'Vasculaire: AVC, hémorragie méningée',
          'Infectieux: méningite, encéphalite',
          'Métabolique: hypo/hyperglycémie, dysnatrémie',
          'Toxique: intoxication, sevrage',
          'Épileptique: post-critique, état de mal',
        ],
      ),
    ],
    keyPoints: 'ABC d\'abord. Glycémie + naloxone + thiamine si doute. Scanner précoce. Traiter la cause.',
    source: 'SFMU',
    lastUpdated: 2020,
  ),

  // Méningite
  Protocol(
    id: 'meningite',
    name: 'Méningite Bactérienne',
    category: ProtocolCategory.neurology,
    description: 'Suspicion et prise en charge de méningite bactérienne',
    indication: 'Syndrome méningé fébrile: céphalées, raideur de nuque, fièvre',
    steps: [
      ProtocolStep(
        title: '1. Reconnaissance',
        content: 'Signes évocateurs.',
        bulletPoints: [
          'Triade classique: fièvre, céphalées, raideur de nuque',
          'Troubles conscience, confusion',
          'Photophobie, vomissements',
          'Purpura → évoquer méningocoque',
        ],
        warning: 'Purpura fébrile = antibiothérapie IMMÉDIATE avant tout',
      ),
      ProtocolStep(
        title: '2. Purpura fulminans',
        content: 'Urgence absolue.',
        bulletPoints: [
          'Ceftriaxone 2g IV/IM IMMÉDIATEMENT (même préhospitalier)',
          'Remplissage vasculaire',
          'Puis suite de la prise en charge',
          'Ne pas attendre les examens',
        ],
      ),
      ProtocolStep(
        title: '3. Imagerie avant PL',
        content: 'Indications du scanner avant PL.',
        bulletPoints: [
          'Signes de focalisation neurologique',
          'Troubles de conscience (GCS < 11)',
          'Crises comitiales récentes',
          'Immunodépression sévère',
          'Œdème papillaire',
        ],
        tip: 'Si indication scanner: ATB avant scanner, PL après si normal',
      ),
      ProtocolStep(
        title: '4. Ponction lombaire',
        content: 'Analyse du LCR.',
        bulletPoints: [
          'Aspect macroscopique: trouble = bactérienne probable',
          'Biochimie: protéinorachie, glycorachie (vs glycémie)',
          'Cytologie: pléiocytose à PNN',
          'Bactériologie: direct, culture, PCR',
        ],
      ),
      ProtocolStep(
        title: '5. Antibiothérapie probabiliste',
        content: 'Sans attendre résultats si suspicion forte.',
        bulletPoints: [
          'Adulte < 50 ans: Ceftriaxone 2g x2/j',
          'Adulte > 50 ans ou ID: Ceftriaxone 2g x2 + Amoxicilline 2g x6',
          'Nourrisson: Ceftriaxone 100 mg/kg/j',
          'Si allergie vraie: Méropénème',
        ],
      ),
      ProtocolStep(
        title: '6. Dexaméthasone',
        content: 'Corticothérapie adjuvante.',
        bulletPoints: [
          'Dexaméthasone 10 mg x4/j pendant 4 jours',
          'Débuter AVANT ou avec la 1ère dose ATB',
          'Réduit mortalité/séquelles (surtout pneumocoque)',
        ],
      ),
    ],
    keyPoints: 'Purpura = ATB immédiat. Dexaméthasone + ATB sans retard. PL après scanner si indiqué.',
    source: 'SPILF 2018, HAS',
    lastUpdated: 2018,
  ),
];

// ============================================================================
// TRAUMA PROTOCOLS  
// ============================================================================

final List<Protocol> traumaProtocols = [
  // Polytraumatisme
  Protocol(
    id: 'polytrauma',
    name: 'Polytraumatisé',
    category: ProtocolCategory.trauma,
    description: 'Prise en charge initiale du patient polytraumatisé',
    indication: 'Traumatisme violent avec atteinte de plusieurs régions corporelles',
    steps: [
      ProtocolStep(
        title: '1. Préhospitalier - SAFE',
        content: 'Sécurité et conditionnement.',
        bulletPoints: [
          'Sécurité: scène sécurisée, protection équipe',
          'Alerter: renfort, trauma center',
          'Free: désincarcération',
          'Evaluate: bilan lésionnel rapide',
        ],
      ),
      ProtocolStep(
        title: '2. ABCDE',
        content: 'Évaluation systématique.',
        bulletPoints: [
          'A: Airway + protection rachis cervical',
          'B: Breathing (pneumothorax, volet)',
          'C: Circulation (hémorragie, remplissage)',
          'D: Disability (GCS, pupilles)',
          'E: Exposure (hypothermie)',
        ],
        warning: 'Immobilisation rachis cervical systématique jusqu\'à évaluation',
      ),
      ProtocolStep(
        title: '3. Contrôle hémorragique',
        content: 'Hémorragie = priorité.',
        bulletPoints: [
          'Compression directe',
          'Garrot si membre et hémorragie non contrôlable',
          'Packing si jonctionnel',
          'Acide tranexamique 1g IV < 3h du trauma (puis 1g/8h)',
        ],
      ),
      ProtocolStep(
        title: '4. Réanimation hémodynamique',
        content: 'Damage control resuscitation.',
        bulletPoints: [
          'Objectif PAS 80-90 mmHg (sans TC)',
          'Objectif PAS > 100 mmHg si TC associé',
          'Remplissage: cristalloïdes limités, sang précoce',
          'Ratio CGR:PFC:Plaquettes = 1:1:1',
          'Éviter hypothermie, acidose, coagulopathie',
        ],
        tip: 'Triade létale = hypothermie + acidose + coagulopathie',
      ),
      ProtocolStep(
        title: '5. Intubation et voies aériennes',
        content: 'Indications précoces.',
        bulletPoints: [
          'GCS ≤ 8',
          'Détresse respiratoire, SpO2 < 90%',
          'Trauma facial sévère',
          'ISR avec maintien en ligne du rachis',
        ],
      ),
      ProtocolStep(
        title: '6. Orientation et bilan',
        content: 'Trauma center et imagerie.',
        bulletPoints: [
          'Alerte trauma center',
          'Body-scanner si stable',
          'Échographie FAST si instable',
          'Bloc opératoire direct si instabilité majeure',
        ],
      ),
    ],
    keyPoints: 'ABCDE. Contrôle hémorragie. Damage control. Acide tranexamique précoce. Éviter triade létale.',
    source: 'SFMU, ATLS, Traumatologie Grave 2019',
    lastUpdated: 2019,
  ),

  // TC grave
  Protocol(
    id: 'tc-grave',
    name: 'Traumatisme Crânien Grave',
    category: ProtocolCategory.trauma,
    description: 'TC avec GCS ≤ 8 après réanimation',
    indication: 'Traumatisme crânien avec GCS ≤ 8',
    steps: [
      ProtocolStep(
        title: '1. Évaluation initiale',
        content: 'Après stabilisation ABCDE.',
        bulletPoints: [
          'GCS après correction hypoxie/hypotension',
          'Pupilles: anisocorie = engagement',
          'Signes de focalisation',
          'Mécanisme du trauma',
        ],
        warning: 'Toute anisocorie = engagement présumé → osmothérapie',
      ),
      ProtocolStep(
        title: '2. Objectifs hémodynamiques',
        content: 'Éviter agressions secondaires.',
        bulletPoints: [
          'PAS > 110 mmHg (idéal PAM > 80)',
          'SpO2 > 94%',
          'PaCO2 35-40 mmHg (éviter hypo/hypercapnie)',
          'Éviter hyperthermie, hyperglycémie',
        ],
      ),
      ProtocolStep(
        title: '3. Intubation',
        content: 'Protection voies aériennes.',
        bulletPoints: [
          'ISR avec stabilisation rachis cervical',
          'Kétamine + succinylcholine (ou rocuronium)',
          'Éviter hypotension lors de l\'induction',
        ],
      ),
      ProtocolStep(
        title: '4. Traitement engagement',
        content: 'Si mydriase ou signes HTIC.',
        bulletPoints: [
          'Mannitol 20% 0.5-1 g/kg IV rapide',
          'ou SSH 7.5% 100-150 mL',
          'Tête à 30°, éviter compression jugulaires',
          'Hyperventilation transitoire si engagement avéré (PaCO2 30-35)',
        ],
        warning: 'Hyperventilation seulement transitoire et si engagement',
      ),
      ProtocolStep(
        title: '5. Imagerie',
        content: 'Scanner cérébral en urgence.',
        bulletPoints: [
          'Scanner sans injection + rachis cervical',
          'Rechercher: hématome, contusion, engagement',
          'Indication neurochirurgicale urgente?',
        ],
      ),
      ProtocolStep(
        title: '6. Orientation',
        content: 'Neuroréanimation.',
        bulletPoints: [
          'Transfert trauma center avec neurochirurgie',
          'Monitoring PIC à discuter',
          'Sédation profonde initiale',
        ],
      ),
    ],
    keyPoints: 'Éviter agressions secondaires (hypoxie, hypotension). PAS > 110. Osmothérapie si engagement.',
    source: 'SFAR/SFMU 2016 - TC Grave',
    lastUpdated: 2016,
  ),

  // Choc hémorragique
  Protocol(
    id: 'choc-hemorragique',
    name: 'Choc Hémorragique',
    category: ProtocolCategory.trauma,
    description: 'Hypovolémie par saignement massif',
    indication: 'Saignement actif avec signes de choc (tachycardie, hypotension, marbrures)',
    steps: [
      ProtocolStep(
        title: '1. Reconnaissance',
        content: 'Identifier le choc hémorragique.',
        bulletPoints: [
          'Classe I: < 15% volémie, FC < 100',
          'Classe II: 15-30%, FC 100-120, anxiété',
          'Classe III: 30-40%, FC > 120, confusion',
          'Classe IV: > 40%, FC > 140, léthargie',
        ],
      ),
      ProtocolStep(
        title: '2. Contrôle hémorragique',
        content: 'Stopper le saignement.',
        bulletPoints: [
          'Compression directe',
          'Garrot artériel si membre (noter l\'heure)',
          'Packing hémostatique si jonctionnel',
          'Chirurgie/embolisation précoce',
        ],
      ),
      ProtocolStep(
        title: '3. Réanimation volémique',
        content: 'Damage control resuscitation.',
        bulletPoints: [
          'Objectif PAS 80-90 mmHg (hypotension permissive)',
          'Cristalloïdes limités à 1-2 L',
          'Transfusion précoce si besoin',
          'Concentrés de globules rouges (CGR)',
        ],
        warning: 'Hypotension permissive CI si TC associé',
      ),
      ProtocolStep(
        title: '4. Transfusion massive',
        content: 'Protocole si hémorragie grave.',
        bulletPoints: [
          'Activation protocole transfusion massive',
          'Ratio CGR:PFC:Plaquettes = 1:1:1',
          'Fibrinogène si < 1.5 g/L',
          'Objectif Hb > 7-9 g/dL',
        ],
      ),
      ProtocolStep(
        title: '5. Acide tranexamique',
        content: 'Administration précoce.',
        bulletPoints: [
          '1g IV en 10 min < 3h du trauma',
          'puis 1g IV sur 8h',
          'Réduit mortalité si administré tôt',
        ],
      ),
      ProtocolStep(
        title: '6. Éviter la triade létale',
        content: 'Hypothermie - Acidose - Coagulopathie.',
        bulletPoints: [
          'Réchauffement actif (couverture, solutés réchauffés)',
          'Corriger acidose (optimiser perfusion)',
          'Corriger coagulopathie (PFC, plaquettes, fibrinogène)',
          'Calcium si transfusion massive',
        ],
      ),
    ],
    keyPoints: 'Contrôle hémorragie. Acide tranexamique < 3h. Ratio 1:1:1. Éviter triade létale.',
    source: 'SFAR 2015 - Choc hémorragique traumatique',
    lastUpdated: 2015,
  ),

  // Damage control
  Protocol(
    id: 'damage-control',
    name: 'Damage Control',
    category: ProtocolCategory.trauma,
    description: 'Stratégie de réanimation chirurgicale abrégée',
    indication: 'Patient traumatisé instable avec hémorragie active',
    steps: [
      ProtocolStep(
        title: '1. Principe',
        content: 'Chirurgie écourtée puis réanimation.',
        bulletPoints: [
          'Contrôle hémorragie et contamination uniquement',
          'Packing hémostatique',
          'Fermeture temporaire',
          'Réanimation pour corriger physiologie',
          'Reprise chirurgicale à 24-48h',
        ],
      ),
      ProtocolStep(
        title: '2. Indications',
        content: 'Quand appliquer le damage control.',
        bulletPoints: [
          'pH < 7.2',
          'Température < 34°C',
          'Coagulopathie (TP < 50%, Fibrinogène < 1 g/L)',
          'Temps opératoire prévu > 90 min',
          'Transfusion > 10 CGR',
        ],
      ),
      ProtocolStep(
        title: '3. Damage control resuscitation',
        content: 'Réanimation associée.',
        bulletPoints: [
          'Hypotension permissive (PAS 80-90)',
          'Limiter cristalloïdes',
          'Transfusion précoce ratio 1:1:1',
          'Acide tranexamique',
          'Réchauffement actif',
        ],
      ),
      ProtocolStep(
        title: '4. Phase de réanimation',
        content: 'Objectifs de correction.',
        bulletPoints: [
          'Corriger hypothermie (T > 35°C)',
          'Corriger acidose (pH > 7.25)',
          'Corriger coagulopathie',
          'Stabilité hémodynamique',
          'Durée: 24-48h',
        ],
      ),
      ProtocolStep(
        title: '5. Reprise chirurgicale',
        content: 'Chirurgie définitive.',
        bulletPoints: [
          'Quand physiologie corrigée',
          'Ablation packing',
          'Réparation définitive des lésions',
          'Fermeture pariétale',
        ],
      ),
    ],
    keyPoints: 'Sauver la vie > réparer les lésions. Contrôle hémorragie rapide. Corriger physiologie puis reprise.',
    source: 'Principes de damage control - Traumatologie',
    lastUpdated: 2020,
  ),

  // Fractures ouvertes
  Protocol(
    id: 'fracture-ouverte',
    name: 'Fractures Ouvertes',
    category: ProtocolCategory.trauma,
    description: 'Prise en charge des fractures ouvertes',
    indication: 'Fracture avec effraction cutanée',
    steps: [
      ProtocolStep(
        title: '1. Classification Gustilo',
        content: 'Grader la fracture ouverte.',
        bulletPoints: [
          'Type I: plaie < 1 cm, contamination minime',
          'Type II: plaie 1-10 cm, dommages tissulaires modérés',
          'Type IIIA: > 10 cm mais couverture osseuse possible',
          'Type IIIB: nécessite lambeau de couverture',
          'Type IIIC: lésion vasculaire nécessitant réparation',
        ],
      ),
      ProtocolStep(
        title: '2. Soins immédiats',
        content: 'Aux urgences.',
        bulletPoints: [
          'Photo de la plaie avant pansement',
          'Lavage sérum physiologique',
          'Pansement stérile humide',
          'Immobilisation (attelle)',
          'Vérifier état vasculo-nerveux distal',
        ],
        warning: 'Ne pas explorer la plaie aux urgences',
      ),
      ProtocolStep(
        title: '3. Antibiothérapie',
        content: 'Selon grade.',
        bulletPoints: [
          'Gustilo I-II: Amoxicilline-ac. clav. 2g/8h pendant 48h',
          'Gustilo III: Amoxicilline-ac. clav. + Gentamicine 5 mg/kg/j',
          'Si allergie: Clindamycine + Gentamicine',
          'Contamination tellurique: ajouter pénicilline G ou métronidazole',
        ],
      ),
      ProtocolStep(
        title: '4. Prophylaxie antitétanique',
        content: 'Selon statut vaccinal.',
        bulletPoints: [
          'Vérifier vaccination',
          'Rappel si > 5 ans',
          'Immunoglobulines si statut inconnu ou incomplet',
        ],
      ),
      ProtocolStep(
        title: '5. Prise en charge chirurgicale',
        content: 'Au bloc opératoire.',
        bulletPoints: [
          'Délai < 6h (controversé mais raisonnable)',
          'Parage, lavage abondant',
          'Fixation: externe souvent préférée',
          'Couverture des parties molles',
        ],
      ),
    ],
    keyPoints: 'Photo. Pansement stérile. ATB précoce adaptée au grade. Chirurgie < 6h si possible.',
    source: 'SFCOT, Gustilo Classification',
    lastUpdated: 2020,
  ),
];
// ============================================================================
// SEPSIS PROTOCOLS
// ============================================================================

final List<Protocol> sepsisProtocols = [
  // Choc septique
  Protocol(
    id: 'choc-septique',
    name: 'Choc Septique',
    category: ProtocolCategory.sepsis,
    description: 'Sepsis avec hypotension nécessitant vasopresseurs et lactates > 2 mmol/L',
    indication: 'Sepsis avec hypotension persistante malgré remplissage et lactates élevés',
    steps: [
      ProtocolStep(
        title: '1. Reconnaissance (Hour-1 Bundle)',
        content: 'Identification précoce.',
        bulletPoints: [
          'Suspicion infection + qSOFA ≥ 2 ou SOFA ≥ 2',
          'qSOFA: FR ≥ 22, PAS ≤ 100, confusion',
          'Choc: vasopresseurs nécessaires pour PAM ≥ 65',
          'Lactates > 2 mmol/L malgré remplissage',
        ],
        warning: 'Hour-1 Bundle = actions dans la première heure',
      ),
      ProtocolStep(
        title: '2. Prélèvements',
        content: 'Avant antibiothérapie si possible.',
        bulletPoints: [
          'Lactates',
          'Hémocultures (2 paires) < 45 min',
          'Autres prélèvements selon foyer: ECBU, PL, ponction...',
          'Ne pas retarder ATB pour prélèvements',
        ],
      ),
      ProtocolStep(
        title: '3. Antibiothérapie',
        content: 'Dans l\'heure suivant reconnaissance.',
        bulletPoints: [
          'Large spectre probabiliste selon foyer suspecté',
          'Communautaire: Pipéracilline-tazobactam ou C3G + métronidazole',
          'Nosocomial: adapter au risque BMR',
          'Réévaluer à 48-72h avec résultats',
        ],
        warning: 'Chaque heure de retard = 7% mortalité en plus',
      ),
      ProtocolStep(
        title: '4. Remplissage vasculaire',
        content: 'Première ligne hémodynamique.',
        bulletPoints: [
          'Cristalloïdes 30 mL/kg dans les 3 premières heures',
          'Réévaluer réponse au remplissage',
          'Objectif PAM ≥ 65 mmHg',
          'Attention si cardiopathie/SDRA',
        ],
      ),
      ProtocolStep(
        title: '5. Vasopresseurs',
        content: 'Si hypotension persistante.',
        bulletPoints: [
          'Noradrénaline 1ère intention',
          'Débuter précocement si hypotension sévère',
          'Objectif PAM ≥ 65 mmHg',
          'VVC dès que possible (mais ne pas retarder)',
        ],
      ),
      ProtocolStep(
        title: '6. Mesures associées',
        content: 'Optimisation.',
        bulletPoints: [
          'Contrôle du foyer infectieux (drainage, chirurgie)',
          'Si choc réfractaire: corticoïdes (hydrocortisone 200 mg/j)',
          'Transfusion si Hb < 7 g/dL (seuil restrictif)',
          'Contrôle glycémique (< 1.8 g/L)',
        ],
      ),
    ],
    keyPoints: 'Hour-1: lactates + hémoc + ATB + remplissage + vasopresseurs si besoin. Contrôle du foyer.',
    source: 'Surviving Sepsis Campaign 2021',
    sourceUrl: 'https://www.sccm.org',
    lastUpdated: 2021,
  ),

  // Purpura fulminans
  Protocol(
    id: 'purpura-fulminans',
    name: 'Purpura Fulminans',
    category: ProtocolCategory.sepsis,
    description: 'Urgence absolue - infection invasive à méningocoque',
    indication: 'Fièvre + purpura nécrotique ou extensif',
    steps: [
      ProtocolStep(
        title: '1. Reconnaissance',
        content: 'Identifier immédiatement.',
        bulletPoints: [
          'Fièvre + purpura ne s\'effaçant pas à la vitropression',
          'Purpura extensif (> 3 mm), nécrotique, ecchymotique',
          'Altération de l\'état général',
          'Méningocoque jusqu\'à preuve du contraire',
        ],
        warning: 'URGENCE ABSOLUE - mortalité 20-30%',
      ),
      ProtocolStep(
        title: '2. Antibiothérapie IMMÉDIATE',
        content: 'Avant tout transport ou examen.',
        bulletPoints: [
          'Ceftriaxone 2g IV ou IM (enfant: 100 mg/kg)',
          'Alternative si allergie: Ciprofloxacine',
          'NE PAS ATTENDRE: hémocultures, VVP, résultats',
          'Injection IM si pas d\'accès IV immédiat',
        ],
      ),
      ProtocolStep(
        title: '3. Réanimation hémodynamique',
        content: 'Traitement du choc.',
        bulletPoints: [
          'Remplissage: NaCl 0.9% 20 mL/kg renouvelable',
          'Noradrénaline précoce si choc',
          'Objectif PAM > 65 mmHg',
          'IOT si détresse respiratoire/troubles conscience',
        ],
      ),
      ProtocolStep(
        title: '4. Transfert',
        content: 'Vers réanimation.',
        bulletPoints: [
          'Réanimation la plus proche',
          'SMUR médicalisé',
          'Pas de PL en préhospitalier',
          'Continuer réanimation pendant transport',
        ],
      ),
      ProtocolStep(
        title: '5. Mesures de santé publique',
        content: 'Prophylaxie des contacts.',
        bulletPoints: [
          'Déclaration obligatoire ARS',
          'Prophylaxie contacts proches < 10 jours',
          'Rifampicine 600 mg x2/j pendant 2 jours (adulte)',
          'ou Ceftriaxone 250 mg IM dose unique',
        ],
      ),
    ],
    keyPoints: 'Antibiotique IMMÉDIAT même préhospitalier. Ne rien attendre. Mortalité dépend du délai.',
    source: 'Instruction DGS 2018, HCSP',
    lastUpdated: 2018,
  ),

  // Pneumonie grave
  Protocol(
    id: 'pneumonie-grave',
    name: 'Pneumonie Communautaire Grave',
    category: ProtocolCategory.sepsis,
    description: 'Pneumonie avec critères de gravité nécessitant réanimation',
    indication: 'Pneumonie + ≥ 1 critère majeur ou ≥ 3 critères mineurs ATS/IDSA',
    steps: [
      ProtocolStep(
        title: '1. Critères de gravité',
        content: 'Évaluation de la sévérité.',
        bulletPoints: [
          'Majeurs: choc septique, ventilation mécanique',
          'Mineurs: FR ≥ 30, PaO2/FiO2 ≤ 250, confusion',
          'Infiltrats multilobaires, urée > 7 mmol/L',
          'Leucopénie, thrombopénie, hypothermie',
        ],
      ),
      ProtocolStep(
        title: '2. Prélèvements',
        content: 'Documentation microbiologique.',
        bulletPoints: [
          'Hémocultures x2',
          'Antigénuries pneumocoque et légionelle',
          'ECBC ou aspiration trachéale si intubé',
          'PCR grippe si épidémie',
        ],
      ),
      ProtocolStep(
        title: '3. Antibiothérapie probabiliste',
        content: 'Sans attendre résultats.',
        bulletPoints: [
          'C3G (Ceftriaxone 2g/j) + Macrolide (Spiramycine ou Azithromycine)',
          'ou C3G + Fluoroquinolone (Lévofloxacine)',
          'Si risque Pseudomonas: Pipéracilline-tazobactam + Amikacine',
          'Durée: 7 jours (14 si Légionelle)',
        ],
        tip: 'Macrolide couvre atypiques (Légionelle, Mycoplasme)',
      ),
      ProtocolStep(
        title: '4. Support respiratoire',
        content: 'Selon gravité.',
        bulletPoints: [
          'O2 pour SpO2 > 92%',
          'VNI si IRA hypercapnique ou OAP associé',
          'HFNC (Optiflow) si IRA hypoxémique',
          'IOT si détresse majeure, épuisement, choc',
        ],
      ),
      ProtocolStep(
        title: '5. Mesures associées',
        content: 'Optimisation.',
        bulletPoints: [
          'Rééquilibration hydro-électrolytique',
          'Kinésithérapie respiratoire',
          'Prévention thromboembolique',
          'Corticoïdes discutés si choc',
        ],
      ),
    ],
    keyPoints: 'C3G + macrolide ou FQ. Documentation microbiologique. Support respiratoire adapté.',
    source: 'SPILF/SPLF 2024 - Infections respiratoires basses',
    lastUpdated: 2024,
  ),

  // Fasciite nécrosante
  Protocol(
    id: 'fasciite-necrosante',
    name: 'Fasciite Nécrosante',
    category: ProtocolCategory.sepsis,
    description: 'Infection grave des tissus mous avec nécrose',
    indication: 'Douleur intense, signes généraux sévères, évolution rapide',
    steps: [
      ProtocolStep(
        title: '1. Suspicion clinique',
        content: 'Reconnaître précocement.',
        bulletPoints: [
          'Douleur disproportionnée par rapport aux signes locaux',
          'Œdème induré dépassant érythème',
          'Crépitations sous-cutanées (gaz)',
          'Signes systémiques: choc, confusion',
          'Extension rapide (heures)',
        ],
        warning: 'Score LRINEC peut aider mais ne pas retarder si suspicion forte',
      ),
      ProtocolStep(
        title: '2. Antibiothérapie urgente',
        content: 'Large spectre + anti-toxinique.',
        bulletPoints: [
          'Pipéracilline-tazobactam 4g x4/j',
          '+ Clindamycine 600-900 mg x3/j (anti-toxinique)',
          '+ Amikacine 25 mg/kg/j si choc',
          'Alternative: Méropénème si allergie',
        ],
        tip: 'Clindamycine inhibe production de toxines',
      ),
      ProtocolStep(
        title: '3. Chirurgie urgente',
        content: 'Débridement dans les 12-24h.',
        bulletPoints: [
          'Exploration chirurgicale diagnostique et thérapeutique',
          'Débridement large de tous tissus nécrotiques',
          'Reprises itératives (24-48h) jusqu\'à tissu sain',
          'Prélèvements peropératoires',
        ],
        warning: 'Retard chirurgical = surmortalité majeure',
      ),
      ProtocolStep(
        title: '4. Réanimation',
        content: 'Support des défaillances.',
        bulletPoints: [
          'Remplissage vasculaire',
          'Vasopresseurs si choc',
          'Ventilation mécanique si défaillance respi',
          'Épuration extra-rénale si IRA',
        ],
      ),
      ProtocolStep(
        title: '5. Thérapies adjuvantes',
        content: 'Mesures complémentaires.',
        bulletPoints: [
          'Immunoglobulines IV discutées si streptocoque A',
          'Oxygénothérapie hyperbare (si disponible)',
          'Prise en charge nutritionnelle',
        ],
      ),
    ],
    keyPoints: 'Suspicion = chirurgie urgente + ATB large spectre avec clindamycine. Mortalité > 30%.',
    source: 'IDSA 2014 - Skin and Soft Tissue Infections',
    lastUpdated: 2014,
  ),
];

// ============================================================================
// TOXICOLOGY PROTOCOLS
// ============================================================================

final List<Protocol> toxicologyProtocols = [
  // Intoxication médicamenteuse
  Protocol(
    id: 'intox-med',
    name: 'Intoxication Médicamenteuse',
    category: ProtocolCategory.toxicology,
    description: 'Approche générale des intoxications médicamenteuses volontaires',
    indication: 'Suspicion d\'ingestion médicamenteuse à visée suicidaire ou accidentelle',
    steps: [
      ProtocolStep(
        title: '1. Évaluation initiale',
        content: 'Stabilisation et bilan.',
        bulletPoints: [
          'ABCDE systématique',
          'Glasgow, pupilles, glycémie',
          'Monitoring continu: scope, SpO2, PA',
          'Température (hypo/hyperthermie)',
        ],
      ),
      ProtocolStep(
        title: '2. Anamnèse toxicologique',
        content: 'Recueillir informations.',
        bulletPoints: [
          'Produit(s), quantité, heure d\'ingestion',
          'Symptômes et délai d\'apparition',
          'Co-intoxications (alcool++)',
          'ATCD psychiatriques, tentatives antérieures',
          'Boîtes, ordonnances, témoins',
        ],
        tip: 'Appeler le centre antipoison si doute',
      ),
      ProtocolStep(
        title: '3. Toxidromes',
        content: 'Orienter le diagnostic.',
        bulletPoints: [
          'Opioïdes: myosis, bradypnée, coma calme',
          'Anticholinergique: mydriase, tachycardie, rétention',
          'Sympathomimétique: mydriase, HTA, hyperthermie',
          'Sérotoninergique: confusion, myoclonies, hyperthermie',
          'Stabilisant de membrane: QRS large, troubles rythme',
        ],
      ),
      ProtocolStep(
        title: '4. Examens complémentaires',
        content: 'Bilan ciblé.',
        bulletPoints: [
          'ECG: QT, QRS (élargissement)',
          'Glycémie, iono, créatinine, lactates',
          'Paracétamolémie systématique (si > 4h)',
          'Dosages spécifiques si disponibles',
          'Toxiques urinaires (orientation)',
        ],
      ),
      ProtocolStep(
        title: '5. Décontamination digestive',
        content: 'Indications limitées.',
        bulletPoints: [
          'Charbon activé 1 g/kg si < 1h post-ingestion',
          'CI: coma, vomissements, caustiques',
          'Lavage gastrique: exceptionnellement (ingestion massive < 1h)',
          'Irrigation intestinale: toxiques à libération prolongée',
        ],
      ),
      ProtocolStep(
        title: '6. Antidotes principaux',
        content: 'Traitements spécifiques.',
        bulletPoints: [
          'Paracétamol: N-acétylcystéine',
          'Opioïdes: Naloxone',
          'Benzodiazépines: Flumazénil (CI si épilepsie, co-ingestion)',
          'Stabilisants membrane: bicarbonates molaires',
          'Digitaliques: anticorps anti-digoxine',
        ],
      ),
    ],
    keyPoints: 'ABCDE. Identifier toxidrome. ECG + paracétamolémie systématiques. Charbon < 1h. Antidotes spécifiques.',
    source: 'SFMU - Toxicologie d\'urgence',
    lastUpdated: 2020,
  ),

  // Intoxication CO
  Protocol(
    id: 'intox-co',
    name: 'Intoxication au Monoxyde de Carbone',
    category: ProtocolCategory.toxicology,
    description: 'Intoxication au CO - urgence collective possible',
    indication: 'Céphalées, nausées, confusion dans contexte évocateur (chauffage, incendie)',
    steps: [
      ProtocolStep(
        title: '1. Suspicion et évacuation',
        content: 'Mesures de protection.',
        bulletPoints: [
          'Évacuer la zone contaminée',
          'Aérer les locaux',
          'Rechercher autres victimes',
          'Signalement (pompiers, CAPTV)',
        ],
        warning: 'Ne pas entrer sans protection si concentration élevée',
      ),
      ProtocolStep(
        title: '2. Signes cliniques',
        content: 'Gravité variable.',
        bulletPoints: [
          'Léger: céphalées, nausées, vertiges',
          'Modéré: confusion, faiblesse, dyspnée d\'effort',
          'Sévère: coma, convulsions, arythmies',
          'Coloration rosée = tardive et inconstante',
        ],
      ),
      ProtocolStep(
        title: '3. Oxygénothérapie normobare',
        content: 'Traitement immédiat.',
        bulletPoints: [
          'O2 100% au masque haute concentration',
          'Durée: minimum 12 heures',
          'Demi-vie HbCO: 4-5h en air ambiant, 1h sous O2 100%',
        ],
      ),
      ProtocolStep(
        title: '4. Indications OHB',
        content: 'Oxygénothérapie hyperbare.',
        bulletPoints: [
          'Perte de connaissance',
          'Signes neurologiques',
          'Signes cardiaques (ischémie, arythmies)',
          'Grossesse',
          'HbCO > 25% (ou > 15% chez femme enceinte)',
        ],
        tip: 'Contacter centre hyperbare si indication',
      ),
      ProtocolStep(
        title: '5. Bilan',
        content: 'Examens complémentaires.',
        bulletPoints: [
          'HbCO (attention: peut être normalisée à l\'arrivée)',
          'Gazométrie (SaO2 normale malgré intox!)',
          'ECG (ischémie, troubles rythme)',
          'Troponine si signes cardiaques',
          'Lactates',
        ],
        warning: 'SpO2 normale en cas d\'intox CO! Utiliser CO-oxymètre',
      ),
      ProtocolStep(
        title: '6. Surveillance',
        content: 'Suivi des complications.',
        bulletPoints: [
          'Syndrome post-intervallaire (2-40 jours)',
          'Troubles cognitifs, neurologiques',
          'Suivi spécialisé recommandé',
        ],
      ),
    ],
    keyPoints: 'Évacuer + O2 100% immédiat. OHB si gravité. SpO2 non fiable. Rechercher autres victimes.',
    source: 'SFMU 2017 - Intoxication CO',
    lastUpdated: 2017,
  ),

  // Intoxication éthylique aiguë
  Protocol(
    id: 'intox-alcool',
    name: 'Intoxication Éthylique Aiguë',
    category: ProtocolCategory.toxicology,
    description: 'Ivresse aiguë et ses complications',
    indication: 'État d\'ivresse avec altération de conscience ou comportement',
    steps: [
      ProtocolStep(
        title: '1. Évaluation gravité',
        content: 'Stadification clinique.',
        bulletPoints: [
          'Excitation: euphorie, désinhibition, logorrhée',
          'Ébriété: incoordination, dysarthrie',
          'Ivresse sévère: somnolence, confusion',
          'Coma éthylique: GCS < 8, hypothermie, hypotension',
        ],
      ),
      ProtocolStep(
        title: '2. Éliminer diagnostics différentiels',
        content: 'Ne pas tout attribuer à l\'alcool.',
        bulletPoints: [
          'Traumatisme crânien (chute ++)',
          'Hypoglycémie',
          'Co-intoxication',
          'AVC, méningite',
          'Encéphalopathie hépatique, de Gayet-Wernicke',
        ],
        warning: 'Toujours scanner si doute ou trauma',
      ),
      ProtocolStep(
        title: '3. Prise en charge coma éthylique',
        content: 'Mesures de protection.',
        bulletPoints: [
          'PLS, prévention inhalation',
          'Intubation si GCS ≤ 8 sans amélioration',
          'Réchauffement si hypothermie',
          'Hydratation IV (G5% avec électrolytes)',
          'Thiamine 500 mg IV AVANT glucose',
        ],
        warning: 'Thiamine avant glucose = prévention Gayet-Wernicke',
      ),
      ProtocolStep(
        title: '4. Examens complémentaires',
        content: 'Bilan minimal.',
        bulletPoints: [
          'Glycémie capillaire',
          'Alcoolémie',
          'Iono, créat (déshydratation)',
          'Scanner si trauma ou coma inexpliqué',
        ],
      ),
      ProtocolStep(
        title: '5. Surveillance',
        content: 'Jusqu\'à dégrisement.',
        bulletPoints: [
          'Surveillance GCS toutes les heures',
          'Prévention risque suicidaire',
          'Évaluation psychiatrique si IMV',
          'Information sur risques, orientation addictologie',
        ],
      ),
    ],
    keyPoints: 'Éliminer TC et hypoglycémie. Thiamine AVANT glucose. PLS et surveillance jusqu\'à dégrisement.',
    source: 'SFMU - Urgences et alcool',
    lastUpdated: 2019,
  ),

  // Syndrome sérotoninergique
  Protocol(
    id: 'syndrome-serotoninergique',
    name: 'Syndrome Sérotoninergique',
    category: ProtocolCategory.toxicology,
    description: 'Excès de sérotonine - urgence thérapeutique',
    indication: 'Triade: troubles neurocognitifs + dysautonomie + anomalies neuromusculaires',
    steps: [
      ProtocolStep(
        title: '1. Reconnaissance',
        content: 'Critères de Hunter.',
        bulletPoints: [
          'Prise sérotoninergique + UN des critères suivants:',
          'Clonus spontané',
          'Clonus inductible + agitation/diaphorèse',
          'Tremor + hyperréflexie',
          'Hypertonie + T > 38°C + clonus/myoclonies',
        ],
      ),
      ProtocolStep(
        title: '2. Médicaments en cause',
        content: 'Identifier les agents.',
        bulletPoints: [
          'ISRS, IRSN, antidépresseurs tricycliques',
          'IMAO',
          'Tramadol, fentanyl',
          'Triptans, lithium',
          'MDMA, amphétamines',
          'Linézolide, bleu de méthylène',
        ],
        tip: 'Souvent surdosage ou association de sérotoninergiques',
      ),
      ProtocolStep(
        title: '3. Arrêt des agents',
        content: 'Première mesure.',
        bulletPoints: [
          'Arrêter tous les agents sérotoninergiques',
          'Amélioration habituelle en 24h',
        ],
      ),
      ProtocolStep(
        title: '4. Traitement symptomatique',
        content: 'Selon sévérité.',
        bulletPoints: [
          'Léger: surveillance, benzodiazépines (agitation)',
          'Modéré: refroidissement, BZD, réhydratation',
          'Sévère: IOT, sédation, curarisation si hyperthermie majeure',
        ],
      ),
      ProtocolStep(
        title: '5. Antidote',
        content: 'Cyproheptadine.',
        bulletPoints: [
          'Cyproheptadine (Périactine) 12 mg PO puis 4 mg/4h',
          'Anti-sérotoninergique',
          'Non disponible en IV',
          'Alternative: chlorpromazine 50-100 mg IM',
        ],
      ),
      ProtocolStep(
        title: '6. Diagnostic différentiel',
        content: 'Éliminer autres causes.',
        bulletPoints: [
          'Syndrome malin des neuroleptiques (rigidité > clonus)',
          'Hyperthermie maligne',
          'Syndrome anticholinergique',
          'Infection, état de mal',
        ],
      ),
    ],
    keyPoints: 'Arrêt des sérotoninergiques + BZD + refroidissement. Cyproheptadine si modéré/sévère.',
    source: 'Toxicologie clinique - Syndrome sérotoninergique',
    lastUpdated: 2020,
  ),

  // Antidotes
  Protocol(
    id: 'antidotes',
    name: 'Principaux Antidotes',
    category: ProtocolCategory.toxicology,
    description: 'Antidotes des principales intoxications',
    indication: 'Intoxication identifiée avec antidote disponible',
    steps: [
      ProtocolStep(
        title: 'Paracétamol → N-acétylcystéine',
        content: 'Protocole court ou long.',
        bulletPoints: [
          'Indication selon nomogramme de Rumack-Matthew',
          'Protocole IV: 150 mg/kg/15min puis 50 mg/kg/4h puis 100 mg/kg/16h',
          'Efficace si < 8h, efficacité diminuée après',
        ],
      ),
      ProtocolStep(
        title: 'Opioïdes → Naloxone',
        content: 'Antagoniste µ.',
        bulletPoints: [
          'Bolus 0.4 mg IV, répétable toutes les 2-3 min',
          'Titration jusqu\'à FR > 12/min',
          'Attention durée d\'action courte (45 min)',
          'IVSE si opioïde longue durée',
        ],
      ),
      ProtocolStep(
        title: 'Benzodiazépines → Flumazénil',
        content: 'Utilisation restreinte.',
        bulletPoints: [
          'Flumazénil 0.2 mg IV, puis 0.1 mg/min jusqu\'à réveil',
          'CI: épilepsie, co-ingestion tricycliques',
          'Risque convulsions si sevrage BZD',
        ],
        warning: 'Prudence extrême - risque convulsions',
      ),
      ProtocolStep(
        title: 'Stabilisants de membrane → Bicarbonates',
        content: 'Alcalinisation.',
        bulletPoints: [
          'Bicarbonate de sodium 84‰ molaire',
          'Bolus 1-2 mEq/kg si QRS > 100 ms',
          'Objectif pH 7.50-7.55',
          'Indications: tricycliques, cocaïne, chloroquine...',
        ],
      ),
      ProtocolStep(
        title: 'Digitaliques → Anticorps anti-digoxine',
        content: 'Fab anti-digitale.',
        bulletPoints: [
          'Digibind ou DigiFab',
          'Indications: arythmies, kaliémie > 5.5, choc',
          'Dose selon digoxinémie ou empirique 6-10 flacons',
        ],
      ),
      ProtocolStep(
        title: 'Méthanol/Éthylène glycol → Fomépizole',
        content: 'Inhibiteur ADH.',
        bulletPoints: [
          'Fomépizole 15 mg/kg charge puis 10 mg/kg/12h',
          'Alternative: éthanol IV (alcoolémie cible 1g/L)',
          'Hémodialyse si acidose sévère ou IRA',
        ],
      ),
      ProtocolStep(
        title: 'Autres antidotes importants',
        content: 'Liste non exhaustive.',
        bulletPoints: [
          'Cyanures: Hydroxocobalamine (Cyanokit)',
          'Bêta-bloquants: Glucagon 5-10 mg IV',
          'Calcium-bloqueurs: Calcium + glucagon + insuline',
          'Fer: Déféroxamine',
          'Organophosphorés: Atropine + Pralidoxime',
        ],
      ),
    ],
    keyPoints: 'Chaque antidote a des indications précises. Centre antipoison disponible 24h/24.',
    source: 'CAPTV - Centres antipoison',
    lastUpdated: 2022,
  ),
];

// ============================================================================
// METABOLIC PROTOCOLS
// ============================================================================

final List<Protocol> metabolicProtocols = [
  // Acidocétose diabétique
  Protocol(
    id: 'acidocetose',
    name: 'Acidocétose Diabétique',
    category: ProtocolCategory.metabolic,
    description: 'Décompensation métabolique du diabète avec cétose',
    indication: 'Glycémie > 2.5 g/L + pH < 7.3 + cétonémie > 3 mmol/L ou cétonurie ++',
    steps: [
      ProtocolStep(
        title: '1. Diagnostic',
        content: 'Critères diagnostiques.',
        bulletPoints: [
          'Glycémie > 2.5 g/L (souvent > 3 g/L)',
          'pH < 7.3 et/ou bicarbonates < 18 mmol/L',
          'Cétonémie > 3 mmol/L ou cétonurie ≥ ++',
          'Trou anionique augmenté',
        ],
      ),
      ProtocolStep(
        title: '2. Gravité',
        content: 'Stratification.',
        bulletPoints: [
          'Légère: pH 7.25-7.30, GCS normal',
          'Modérée: pH 7.00-7.24, GCS normal',
          'Sévère: pH < 7.00, troubles conscience',
          'Critères USI: pH < 7.1, confusion, choc',
        ],
      ),
      ProtocolStep(
        title: '3. Remplissage vasculaire',
        content: 'Priorité = réhydratation.',
        bulletPoints: [
          'NaCl 0.9%: 1L/h pendant 2h puis 500 mL/h',
          'Déficit hydrique 5-10 L en moyenne',
          'Relais G5% quand glycémie < 2.5 g/L',
          'Adapter si insuffisance cardiaque',
        ],
      ),
      ProtocolStep(
        title: '4. Insulinothérapie',
        content: 'Après début du remplissage.',
        bulletPoints: [
          'Insuline rapide IVSE 0.1 UI/kg/h',
          'Objectif: baisse glycémie 0.5-0.7 g/L/h',
          'Maintenir IVSE tant que cétonémie > 0.5 mmol/L',
          'Ne pas arrêter insuline si glycémie basse: ajuster G5%',
        ],
        warning: 'Ne pas arrêter insuline même si glycémie normale tant que cétose',
      ),
      ProtocolStep(
        title: '5. Potassium',
        content: 'Surveillance et supplémentation.',
        bulletPoints: [
          'K+ souvent normal ou haut initialement malgré déficit total',
          'Si K+ < 3.3 mmol/L: différer insuline, supplémenter d\'abord',
          'Si K+ 3.3-5.3: KCl 20-40 mEq/L de perfusion',
          'Si K+ > 5.3: pas de supplément, surveillance',
        ],
        warning: 'Kaliémie peut chuter brutalement sous insuline',
      ),
      ProtocolStep(
        title: '6. Bicarbonates',
        content: 'Indications très limitées.',
        bulletPoints: [
          'Seulement si pH < 6.9 (controversé)',
          'Pas de bénéfice prouvé si pH > 7.0',
          'Si utilisé: 100 mmol + 20 mEq KCl en 2h',
        ],
      ),
      ProtocolStep(
        title: '7. Rechercher facteur déclenchant',
        content: 'Toujours.',
        bulletPoints: [
          'Infection (NFS, CRP, ECBU, radio thorax)',
          'Infarctus du myocarde (ECG, troponine)',
          'Arrêt ou mauvaise observance insuline',
          'Nouveau diabète',
        ],
      ),
    ],
    keyPoints: 'Remplissage prioritaire. Insuline IVSE 0.1 UI/kg/h. K+ surveillance rapprochée. Traiter la cause.',
    source: 'ADA Standards 2024, SFD',
    lastUpdated: 2024,
  ),

  // État hyperosmolaire
  Protocol(
    id: 'etat-hyperosmolaire',
    name: 'État Hyperosmolaire Hyperglycémique',
    category: ProtocolCategory.metabolic,
    description: 'Décompensation hyperglycémique sans cétose majeure',
    indication: 'Glycémie > 6 g/L + Osmolarité > 320 mOsm/kg + absence cétose significative',
    steps: [
      ProtocolStep(
        title: '1. Caractéristiques',
        content: 'Différences avec acidocétose.',
        bulletPoints: [
          'Patient souvent âgé, diabète type 2',
          'Glycémie très élevée (souvent > 6 g/L)',
          'Osmolarité > 320 mOsm/kg',
          'Déshydratation majeure (déficit 8-12 L)',
          'Pas ou peu de cétose (pH > 7.30)',
        ],
      ),
      ProtocolStep(
        title: '2. Réhydratation',
        content: 'Objectif principal.',
        bulletPoints: [
          'NaCl 0.9% initialement: 1-1.5 L/h les 2 premières heures',
          'Puis adapter selon natrémie corrigée et état HD',
          'Si Na corrigée > 145: NaCl 0.45%',
          'Correction lente: 10% déficit les 2 premières heures',
          'Reste sur 24-48h',
        ],
        warning: 'Réhydratation trop rapide = risque œdème cérébral',
      ),
      ProtocolStep(
        title: '3. Insulinothérapie',
        content: 'Secondaire au remplissage.',
        bulletPoints: [
          'Débuter après 1-2h de remplissage',
          'Doses plus faibles: 0.05 UI/kg/h',
          'Objectif: baisse glycémie progressive',
        ],
      ),
      ProtocolStep(
        title: '4. Potassium',
        content: 'Même vigilance que acidocétose.',
        bulletPoints: [
          'Supplémentation selon kaliémie',
          'Surveillance rapprochée',
        ],
      ),
      ProtocolStep(
        title: '5. Anticoagulation',
        content: 'Prévention thrombose.',
        bulletPoints: [
          'Risque thromboembolique élevé',
          'HBPM préventive systématique',
        ],
      ),
      ProtocolStep(
        title: '6. Facteur déclenchant',
        content: 'Infection fréquente.',
        bulletPoints: [
          'Infection (50% des cas)',
          'Déshydratation, diarrhées',
          'Médicaments (corticoïdes, diurétiques)',
          'AVC, IDM',
        ],
      ),
    ],
    keyPoints: 'Réhydratation massive mais progressive. Insuline après remplissage. Anticoagulation préventive.',
    source: 'ADA Standards 2024',
    lastUpdated: 2024,
  ),

  // Hyperkaliémie
  Protocol(
    id: 'hyperkaliemie',
    name: 'Hyperkaliémie',
    category: ProtocolCategory.metabolic,
    description: 'Kaliémie > 5.5 mmol/L',
    indication: 'K+ > 5.5 mmol/L et/ou signes ECG d\'hyperkaliémie',
    steps: [
      ProtocolStep(
        title: '1. Évaluation gravité',
        content: 'Clinique et ECG.',
        bulletPoints: [
          'Légère: 5.5-6.0 mmol/L, ECG normal',
          'Modérée: 6.0-6.5 mmol/L, ondes T pointues',
          'Sévère: > 6.5 mmol/L ou signes ECG majeurs',
          'ECG: ondes T amples, QRS large, bradycardie, FV',
        ],
        warning: 'Toute hyperkaliémie symptomatique = urgence vitale',
      ),
      ProtocolStep(
        title: '2. Protection myocardique',
        content: 'Si ECG anormal ou K+ > 6.5.',
        bulletPoints: [
          'Gluconate de calcium 10%: 10-20 mL IV en 2-5 min',
          'Effet immédiat mais transitoire (30-60 min)',
          'Répétable si persistance anomalies ECG',
          'Ne modifie pas la kaliémie',
        ],
      ),
      ProtocolStep(
        title: '3. Transfert intracellulaire',
        content: 'Réduire la kaliémie.',
        bulletPoints: [
          'Insuline 10 UI + G30% 50 mL IV (effet en 15-30 min)',
          'Salbutamol nébulisé 10-20 mg (4-8 bouffées)',
          'Bicarbonates si acidose métabolique associée',
          'Effet transitoire: 2-6 heures',
        ],
        tip: 'Surveiller glycémie après insuline-glucose',
      ),
      ProtocolStep(
        title: '4. Élimination du potassium',
        content: 'Réduction du pool total.',
        bulletPoints: [
          'Furosémide 40-80 mg IV si fonction rénale conservée',
          'Résines échangeuses: Kayexalate 30-60g PO ou lavement',
          'Patiromer ou SZC (nouveaux chélateurs)',
          'Hémodialyse si sévère ou IRA anurique',
        ],
      ),
      ProtocolStep(
        title: '5. Traiter la cause',
        content: 'Étiologie.',
        bulletPoints: [
          'Insuffisance rénale',
          'Médicaments (IEC, ARA2, spironolactone, AINS)',
          'Acidose',
          'Rhabdomyolyse, lyse tumorale',
          'Insuffisance surrénale',
        ],
      ),
    ],
    keyPoints: 'ECG systématique. Calcium si signes ECG. Insuline-glucose pour baisser K+. Dialyse si sévère.',
    source: 'KDIGO, HAS',
    lastUpdated: 2022,
  ),

  // Hyponatrémie
  Protocol(
    id: 'hyponatremie',
    name: 'Hyponatrémie',
    category: ProtocolCategory.metabolic,
    description: 'Natrémie < 135 mmol/L',
    indication: 'Na+ < 135 mmol/L et/ou symptômes neurologiques',
    steps: [
      ProtocolStep(
        title: '1. Évaluation',
        content: 'Gravité et chronologie.',
        bulletPoints: [
          'Aiguë (< 48h) vs chronique (> 48h ou inconnue)',
          'Légère: 130-135 mmol/L',
          'Modérée: 125-129 mmol/L',
          'Sévère: < 125 mmol/L',
          'Symptômes: céphalées, confusion, convulsions, coma',
        ],
      ),
      ProtocolStep(
        title: '2. Hyponatrémie symptomatique sévère',
        content: 'Urgence thérapeutique.',
        bulletPoints: [
          'NaCl 3%: 100-150 mL en 20 min',
          'Répétable 2-3 fois si symptômes persistent',
          'Objectif initial: ↑ Na+ de 4-6 mmol/L',
          'Limite: ↑ < 10 mmol/L/24h (< 8 si chronique)',
        ],
        warning: 'Correction trop rapide = myélinolyse centropontine',
      ),
      ProtocolStep(
        title: '3. Classification étiologique',
        content: 'Selon volémie.',
        bulletPoints: [
          'Hypovolémique: déshydratation, diurétiques, pertes digestives',
          'Euvolémique: SIADH, hypothyroïdie, insuffisance surrénale',
          'Hypervolémique: insuffisance cardiaque, cirrhose, IRC',
        ],
      ),
      ProtocolStep(
        title: '4. Traitement selon cause',
        content: 'Adapter au mécanisme.',
        bulletPoints: [
          'Hypovolémique: NaCl 0.9%',
          'SIADH: restriction hydrique ± urée ± tolvaptan',
          'Hypervolémique: restriction hydrique + diurétiques',
          'Arrêt médicaments causaux',
        ],
      ),
      ProtocolStep(
        title: '5. Surveillance',
        content: 'Contrôles rapprochés.',
        bulletPoints: [
          'Natrémie toutes les 2-4h initialement',
          'Diurèse horaire',
          'Si surcorrection: abaisser Na+ (G5%, desmopressine)',
        ],
      ),
    ],
    keyPoints: 'Symptomatique sévère = NaCl 3%. Correction lente si chronique (< 10/24h). Traiter selon volémie.',
    source: 'ESE 2014 - Hyponatremia',
    lastUpdated: 2014,
  ),

  // Hypoglycémie
  Protocol(
    id: 'hypoglycemie',
    name: 'Hypoglycémie',
    category: ProtocolCategory.metabolic,
    description: 'Glycémie < 0.70 g/L avec ou sans symptômes',
    indication: 'Glycémie < 0.70 g/L ou symptômes neuroglycopéniques',
    steps: [
      ProtocolStep(
        title: '1. Reconnaissance',
        content: 'Signes cliniques.',
        bulletPoints: [
          'Neuroglycopéniques: confusion, troubles visuels, convulsions, coma',
          'Adrénergiques: sueurs, tremblements, palpitations, faim',
          'Seuil variable selon patients (diabétiques ++)',
        ],
      ),
      ProtocolStep(
        title: '2. Patient conscient',
        content: 'Resucrage oral.',
        bulletPoints: [
          '15-20g de glucides rapides',
          '3-4 morceaux de sucre ou jus de fruits',
          'Recontrôle à 15 min',
          'Répéter si glycémie toujours basse',
          'Puis collation avec sucres lents',
        ],
      ),
      ProtocolStep(
        title: '3. Patient inconscient ou ne pouvant avaler',
        content: 'Resucrage parentéral.',
        bulletPoints: [
          'G30%: 20-40 mL IV (ou 50 mL G50%)',
          'ou Glucagon 1 mg IM/SC (si pas d\'accès IV)',
          'Relais perfusion G10% après réveil',
          'Glucagon moins efficace si réserves glycogène épuisées',
        ],
        warning: 'Glucagon inefficace si intoxication alcoolique ou jeûne prolongé',
      ),
      ProtocolStep(
        title: '4. Causes à rechercher',
        content: 'Étiologie.',
        bulletPoints: [
          'Diabétique: insuline, sulfamides (surdosage, jeûne)',
          'Non diabétique: alcool, insuffisance surrénale',
          'Insuffisance hépatique, insuffisance rénale',
          'Insulinome, tumeurs',
        ],
      ),
      ProtocolStep(
        title: '5. Surveillance et prévention',
        content: 'Éviter récidive.',
        bulletPoints: [
          'Surveillance glycémique rapprochée',
          'Durée surveillance selon cause (sulfamides: 24-48h)',
          'Éducation patient et entourage',
          'Adapter traitement antidiabétique',
        ],
      ),
    ],
    keyPoints: 'G30% IV si inconscient. Glucagon si pas d\'accès. Rechercher cause. Surveillance prolongée si sulfamides.',
    source: 'ADA, SFD',
    lastUpdated: 2024,
  ),
];
// ============================================================================
// PEDIATRIC PROTOCOLS
// ============================================================================

final List<Protocol> pediatricProtocols = [
  // ACR pédiatrique
  Protocol(
    id: 'acr-pediatrique',
    name: 'ACR Pédiatrique',
    category: ProtocolCategory.pediatric,
    description: 'Arrêt cardiorespiratoire de l\'enfant selon ERC 2021',
    indication: 'Enfant en arrêt cardiaque (absence de signes de vie)',
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: '1. Reconnaissance',
        content: 'Identifier l\'ACR.',
        bulletPoints: [
          'Absence de réponse à stimulation',
          'Absence de respiration normale (gasps = arrêt)',
          'Pas de pouls perçu en 10 secondes (optionnel)',
          'Alerter les secours (15/112)',
        ],
      ),
      ProtocolStep(
        title: '2. RCP de base',
        content: 'Commencer immédiatement.',
        bulletPoints: [
          'Commencer par 5 insufflations',
          'Puis MCE: 100-120/min',
          'Profondeur: 1/3 du thorax (4 cm nourrisson, 5 cm enfant)',
          'Ratio 15:2 (si 2 secouristes professionnels)',
          'Ratio 30:2 si seul',
        ],
        tip: '5 insufflations d\'abord car cause souvent respiratoire chez l\'enfant',
      ),
      ProtocolStep(
        title: '3. Défibrillation',
        content: 'Dès que DSA disponible.',
        bulletPoints: [
          'Électrodes pédiatriques si < 8 ans ou < 25 kg',
          'Choc 4 J/kg',
          'Reprendre MCE immédiatement après choc',
          'Analyser toutes les 2 minutes',
        ],
      ),
      ProtocolStep(
        title: '4. Voies d\'administration',
        content: 'Accès vasculaire.',
        bulletPoints: [
          'VVP en première intention',
          'Voie intra-osseuse si échec (< 60 sec)',
          'Sites IO: tibia proximal, fémur distal',
        ],
      ),
      ProtocolStep(
        title: '5. Adrénaline',
        content: 'Doses pédiatriques.',
        bulletPoints: [
          '10 µg/kg IV/IO (0.1 mL/kg adrénaline 1/10000)',
          'Rythme non choquable: dès que possible',
          'Rythme choquable: après 3ème choc',
          'Répéter toutes les 3-5 min',
        ],
      ),
      ProtocolStep(
        title: '6. Amiodarone',
        content: 'Si FV/TV réfractaire.',
        bulletPoints: [
          '5 mg/kg après le 3ème choc',
          'Répéter 5 mg/kg après 5ème choc',
        ],
      ),
      ProtocolStep(
        title: '7. Causes réversibles',
        content: '4H et 4T pédiatriques.',
        bulletPoints: [
          'Hypoxie (cause la plus fréquente)',
          'Hypovolémie',
          'Hypo/hyperkaliémie, hypoglycémie',
          'Hypothermie',
          'Tamponnade',
          'Tension pneumothorax',
          'Thrombose (EP rare chez enfant)',
          'Toxiques',
        ],
      ),
    ],
    keyPoints: '5 insufflations d\'abord. MCE 15:2. Adrénaline 10 µg/kg. Cause souvent respiratoire.',
    source: 'ERC Guidelines 2021 - Pediatric Life Support',
    sourceUrl: 'https://www.erc.edu',
    lastUpdated: 2021,
  ),

  // Bronchiolite
  Protocol(
    id: 'bronchiolite',
    name: 'Bronchiolite Aiguë',
    category: ProtocolCategory.pediatric,
    description: 'Infection virale des voies aériennes inférieures du nourrisson',
    indication: 'Nourrisson < 12 mois avec dyspnée sifflante et signes de lutte',
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: '1. Diagnostic clinique',
        content: 'Reconnaître la bronchiolite.',
        bulletPoints: [
          'Nourrisson < 12 mois',
          'Rhinite puis toux, dyspnée',
          'Sibilants ± crépitants',
          'Signes de lutte: tirage, battement ailes du nez',
          'Premier épisode (sinon: asthme du nourrisson)',
        ],
      ),
      ProtocolStep(
        title: '2. Évaluation gravité',
        content: 'Critères d\'hospitalisation.',
        bulletPoints: [
          'Âge < 6 semaines',
          'Prématurité < 34 SA',
          'SpO2 < 92% en air ambiant',
          'Difficultés alimentaires > 50% des apports',
          'Apnées, épuisement',
          'Terrain: cardiopathie, pathologie respiratoire',
        ],
      ),
      ProtocolStep(
        title: '3. Désobstruction rhinopharyngée',
        content: 'Mesure essentielle.',
        bulletPoints: [
          'DRP au sérum physiologique',
          'Avant les repas et au coucher',
          'Fragmentation des repas',
          'Position proclive dorsale 30°',
        ],
      ),
      ProtocolStep(
        title: '4. Oxygénothérapie',
        content: 'Si hypoxémie.',
        bulletPoints: [
          'Si SpO2 < 92%',
          'Objectif SpO2 > 92%',
          'Lunettes nasales, débit adapté',
          'Optiflow (HFNC) si besoin élevé',
        ],
      ),
      ProtocolStep(
        title: '5. Hydratation/Nutrition',
        content: 'Maintenir les apports.',
        bulletPoints: [
          'Fractionnement des repas',
          'SNG si difficultés alimentaires > 50%',
          'Perfusion si alimentation impossible',
          'Surveillance diurèse',
        ],
      ),
      ProtocolStep(
        title: '6. Traitements NON recommandés',
        content: 'À éviter.',
        bulletPoints: [
          'Bronchodilatateurs (pas d\'efficacité prouvée)',
          'Corticoïdes',
          'Antibiotiques (sauf surinfection)',
          'Kinésithérapie respiratoire systématique',
        ],
        warning: 'Pas de salbutamol en 1ère intention',
      ),
      ProtocolStep(
        title: '7. Critères de sortie',
        content: 'Conditions de retour à domicile.',
        bulletPoints: [
          'SpO2 > 92% en air ambiant',
          'Alimentation > 50% des besoins',
          'Pas d\'apnée',
          'Parents formés à la surveillance',
        ],
      ),
    ],
    keyPoints: 'DRP + O2 si besoin + hydratation. Pas de bronchodilatateurs ni corticoïdes. Hospitalisation si < 6 sem ou SpO2 < 92%.',
    source: 'HAS 2019 - Bronchiolite aiguë du nourrisson',
    sourceUrl: 'https://www.has-sante.fr',
    lastUpdated: 2019,
  ),

  // Convulsions fébriles
  Protocol(
    id: 'convulsions-febriles',
    name: 'Convulsions Fébriles',
    category: ProtocolCategory.pediatric,
    description: 'Crise convulsive associée à la fièvre chez l\'enfant',
    indication: 'Enfant 6 mois - 5 ans avec convulsions et fièvre',
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: '1. Prise en charge immédiate',
        content: 'Pendant la crise.',
        bulletPoints: [
          'PLS, protection',
          'Déshabiller l\'enfant',
          'Mesurer la température',
          'Noter l\'heure de début',
        ],
      ),
      ProtocolStep(
        title: '2. Si crise > 5 min',
        content: 'Traitement anticonvulsivant.',
        bulletPoints: [
          'Diazépam intra-rectal 0.5 mg/kg (max 10 mg)',
          'ou Midazolam buccal/nasal 0.3 mg/kg',
          'Répéter une fois après 5 min si échec',
        ],
      ),
      ProtocolStep(
        title: '3. Classification',
        content: 'Simple vs complexe.',
        bulletPoints: [
          'Simple: < 15 min, généralisée, unique/24h, 1-5 ans, pas de déficit post-critique',
          'Complexe: > 15 min, focale, répétée, < 1 an ou > 5 ans, déficit post-critique',
        ],
      ),
      ProtocolStep(
        title: '4. Convulsion fébrile simple',
        content: 'Bilan minimal.',
        bulletPoints: [
          'Rechercher foyer infectieux',
          'Pas de bilan sanguin systématique',
          'Pas de PL si > 12 mois et examen normal',
          'Pas d\'EEG',
        ],
      ),
      ProtocolStep(
        title: '5. Convulsion fébrile complexe',
        content: 'Bilan plus complet.',
        bulletPoints: [
          'PL si < 12 mois ou signes méningés',
          'Bilan sanguin selon contexte',
          'EEG à distance discuté',
          'Imagerie si signes focaux',
        ],
      ),
      ProtocolStep(
        title: '6. Traitement antipyrétique',
        content: 'Confort de l\'enfant.',
        bulletPoints: [
          'Paracétamol 15 mg/kg/6h',
          'Ne prévient PAS les récidives',
          'Objectif: confort, pas la normothermie',
        ],
      ),
      ProtocolStep(
        title: '7. Information parentale',
        content: 'Éducation.',
        bulletPoints: [
          'Pronostic excellent pour CF simple',
          'Récidive possible (30%)',
          'CAT si récidive à domicile',
          'Prescription diazépam rectal si récidive',
        ],
      ),
    ],
    keyPoints: 'PLS + diazépam si > 5 min. CF simple = bénigne, bilan minimal. CF complexe = bilan selon clinique.',
    source: 'SFP, HAS',
    lastUpdated: 2020,
  ),

  // Déshydratation aiguë
  Protocol(
    id: 'deshydratation-pediatrique',
    name: 'Déshydratation Aiguë de l\'Enfant',
    category: ProtocolCategory.pediatric,
    description: 'Perte hydro-électrolytique aiguë chez l\'enfant',
    indication: 'Enfant avec diarrhée/vomissements et signes de déshydratation',
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: '1. Évaluation gravité',
        content: 'Classification OMS.',
        bulletPoints: [
          'Légère (< 5%): soif, muqueuses sèches',
          'Modérée (5-9%): yeux cernés, pli cutané, oligourie',
          'Sévère (≥ 10%): choc, trouble conscience, marbrures',
        ],
      ),
      ProtocolStep(
        title: '2. Déshydratation légère-modérée',
        content: 'Réhydratation orale.',
        bulletPoints: [
          'SRO (Soluté de Réhydratation Orale)',
          'Volume: 50-100 mL/kg sur 4h',
          'Petites quantités fréquentes',
          'Poursuivre allaitement',
        ],
      ),
      ProtocolStep(
        title: '3. Déshydratation sévère ou échec SRO',
        content: 'Réhydratation IV.',
        bulletPoints: [
          'Bolus NaCl 0.9%: 20 mL/kg en 20 min',
          'Répéter si choc persistant',
          'Puis perfusion d\'entretien',
          'NaCl 0.9% + G5% selon glycémie',
        ],
        warning: 'Si choc: remplissage rapide 20 mL/kg, répétable',
      ),
      ProtocolStep(
        title: '4. Calcul des besoins',
        content: 'Déficit + entretien + pertes.',
        bulletPoints: [
          'Déficit = % déshydratation x poids (kg) x 10 = mL',
          'Entretien: règle des 4-2-1 mL/kg/h',
          'Pertes en cours: estimation',
        ],
      ),
      ProtocolStep(
        title: '5. Surveillance',
        content: 'Réévaluation régulière.',
        bulletPoints: [
          'Poids (référence +++)',
          'Fréquence cardiaque, TRC',
          'Diurèse',
          'État neurologique',
          'Ionogramme si IV',
        ],
      ),
      ProtocolStep(
        title: '6. Réalimentation précoce',
        content: 'Ne pas prolonger le jeûne.',
        bulletPoints: [
          'Réalimentation dès que possible (< 4h)',
          'Alimentation normale adaptée à l\'âge',
          'Pas de régime restrictif prolongé',
        ],
      ),
    ],
    keyPoints: 'SRO en première intention. IV si sévère ou échec. Poids = meilleur critère. Réalimentation précoce.',
    source: 'ESPGHAN 2014, HAS',
    lastUpdated: 2014,
  ),

  // Laryngite aiguë
  Protocol(
    id: 'laryngite',
    name: 'Laryngite Aiguë (Croup)',
    category: ProtocolCategory.pediatric,
    description: 'Inflammation sous-glottique virale',
    indication: 'Enfant 6 mois - 3 ans avec stridor inspiratoire et toux aboyante',
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: '1. Diagnostic clinique',
        content: 'Tableau typique.',
        bulletPoints: [
          'Âge: 6 mois - 3 ans',
          'Début nocturne brutal',
          'Toux aboyante ("chien")',
          'Stridor inspiratoire',
          'Voix rauque',
          'Fièvre modérée',
        ],
      ),
      ProtocolStep(
        title: '2. Score de gravité (Westley)',
        content: 'Évaluer la sévérité.',
        bulletPoints: [
          'Stridor: 0 (absent) à 2 (au repos)',
          'Tirage: 0 à 3',
          'Entrée d\'air: 0 à 2',
          'Cyanose: 0 ou 5',
          'Conscience: 0 ou 5',
          'Léger: 0-2, Modéré: 3-7, Sévère: 8-11, Imminente: ≥ 12',
        ],
      ),
      ProtocolStep(
        title: '3. Laryngite légère',
        content: 'Traitement ambulatoire.',
        bulletPoints: [
          'Dexaméthasone 0.15-0.6 mg/kg PO dose unique',
          'ou Prednisolone 1-2 mg/kg',
          'Humidification (pas de preuve mais habituel)',
          'Surveillance parentale',
        ],
      ),
      ProtocolStep(
        title: '4. Laryngite modérée-sévère',
        content: 'Traitement hospitalier.',
        bulletPoints: [
          'Dexaméthasone 0.6 mg/kg PO/IM/IV',
          'Adrénaline nébulisée 0.5 mL/kg (max 5 mL) L-adrénaline 1‰',
          'Effet adrénaline transitoire: surveiller 2-4h',
          'O2 si SpO2 < 92%',
        ],
        tip: 'Adrénaline = effet rapide mais transitoire',
      ),
      ProtocolStep(
        title: '5. Laryngite sévère/échec',
        content: 'Escalade.',
        bulletPoints: [
          'Répéter adrénaline nébulisée',
          'Mélange hélium-O2 (Heliox) si disponible',
          'Intubation si détresse majeure (tube plus petit)',
        ],
        warning: 'Prévoir tube de plus petit calibre (œdème)',
      ),
      ProtocolStep(
        title: '6. Diagnostics différentiels',
        content: 'À éliminer.',
        bulletPoints: [
          'Épiglottite (rare depuis vaccination Hib)',
          'Corps étranger',
          'Abcès rétropharyngé',
          'Anaphylaxie',
        ],
      ),
    ],
    keyPoints: 'Corticoïdes systématiques. Adrénaline nébulisée si modéré/sévère. Surveillance 2-4h après adrénaline.',
    source: 'SFP, Cochrane Review',
    lastUpdated: 2021,
  ),

  // Choc pédiatrique
  Protocol(
    id: 'choc-pediatrique',
    name: 'État de Choc Pédiatrique',
    category: ProtocolCategory.pediatric,
    description: 'Insuffisance circulatoire aiguë de l\'enfant',
    indication: 'Tachycardie + signes d\'hypoperfusion (TRC > 3s, marbrures, troubles conscience)',
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: '1. Reconnaissance',
        content: 'Signes de choc.',
        bulletPoints: [
          'Tachycardie (signe précoce)',
          'TRC > 3 secondes',
          'Marbrures, extrémités froides',
          'Pouls filants',
          'Troubles conscience',
          'Hypotension = signe TARDIF chez l\'enfant',
        ],
        warning: 'L\'hypotension est tardive chez l\'enfant. Ne pas l\'attendre!',
      ),
      ProtocolStep(
        title: '2. Accès vasculaire',
        content: 'Rapide et efficace.',
        bulletPoints: [
          'VVP en priorité',
          'Voie IO si échec < 60 secondes',
          'Sites IO: tibia proximal ++',
        ],
      ),
      ProtocolStep(
        title: '3. Remplissage initial',
        content: 'Bolus de cristalloïdes.',
        bulletPoints: [
          'NaCl 0.9% 20 mL/kg en 5-10 min',
          'Réévaluer après chaque bolus',
          'Répéter jusqu\'à 60 mL/kg si nécessaire',
          'Attention surcharge si cardiopathie',
        ],
      ),
      ProtocolStep(
        title: '4. Si choc réfractaire',
        content: 'Vasopresseurs.',
        bulletPoints: [
          'Adrénaline 0.1-1 µg/kg/min (choc froid)',
          'Noradrénaline 0.1-1 µg/kg/min (choc chaud)',
          'VVC si possible mais ne pas retarder traitement',
        ],
      ),
      ProtocolStep(
        title: '5. Orientation étiologique',
        content: 'Adapter le traitement.',
        bulletPoints: [
          'Septique: ATB précoce, remplissage, vasopresseurs',
          'Hypovolémique: remplissage, transfusion si hémorragie',
          'Cardiogénique: prudence remplissage, inotropes',
          'Anaphylactique: adrénaline IM, remplissage',
        ],
      ),
    ],
    keyPoints: 'Tachycardie = signe précoce. Bolus 20 mL/kg répétés. IO si échec VVP. Hypotension = tardif.',
    source: 'ERC 2021, ACCM Guidelines',
    lastUpdated: 2021,
  ),

  // Purpura de l'enfant
  Protocol(
    id: 'purpura-enfant',
    name: 'Purpura de l\'Enfant',
    category: ProtocolCategory.pediatric,
    description: 'Conduite à tenir devant un purpura fébrile ou non',
    indication: 'Enfant avec lésions purpuriques (ne s\'effaçant pas à la vitropression)',
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: '1. Purpura fébrile',
        content: 'Urgence jusqu\'à preuve du contraire.',
        bulletPoints: [
          'Purpura + fièvre = méningocoque possible',
          'Purpura extensif ou nécrotique = purpura fulminans',
          'Ceftriaxone 50-100 mg/kg IV/IM IMMÉDIAT',
        ],
        warning: 'Antibiotique AVANT tout bilan si purpura fébrile',
      ),
      ProtocolStep(
        title: '2. Purpura non fébrile - Évaluation',
        content: 'Rechercher étiologie.',
        bulletPoints: [
          'Purpura pétéchial: thrombopénie?',
          'Purpura vasculaire: territoire déclive',
          'Ecchymoses: maltraitance?',
        ],
      ),
      ProtocolStep(
        title: '3. Purpura rhumatoïde (HSP)',
        content: 'Vascularite la plus fréquente.',
        bulletPoints: [
          'Purpura vasculaire déclive + douleurs abdominales',
          'Arthralgies',
          'Atteinte rénale possible',
          'Traitement symptomatique',
          'Surveillance fonction rénale',
        ],
      ),
      ProtocolStep(
        title: '4. Purpura thrombopénique immunologique (PTI)',
        content: 'Thrombopénie isolée.',
        bulletPoints: [
          'Plaquettes < 100 G/L, reste NFS normal',
          'Enfant en bon état général',
          'Risque hémorragique si < 10-20 G/L',
          'Traitement selon sévérité: surveillance, Ig IV, corticoïdes',
        ],
      ),
      ProtocolStep(
        title: '5. Bilan minimal',
        content: 'Examens à réaliser.',
        bulletPoints: [
          'NFS plaquettes (thrombopénie?)',
          'TP/TCA (coagulopathie?)',
          'Si fièvre: CRP, hémocultures, PL selon contexte',
        ],
      ),
    ],
    keyPoints: 'Purpura fébrile = ATB immédiat. Purpura non fébrile = NFS en premier. HSP = le plus fréquent en pédiatrie.',
    source: 'Urgences pédiatriques',
    lastUpdated: 2020,
  ),

  // Anaphylaxie pédiatrique
  Protocol(
    id: 'anaphylaxie-pediatrique',
    name: 'Anaphylaxie Pédiatrique',
    category: ProtocolCategory.pediatric,
    description: 'Réaction allergique systémique sévère de l\'enfant',
    indication: 'Réaction allergique avec atteinte respiratoire et/ou hémodynamique',
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: '1. Reconnaissance',
        content: 'Critères diagnostiques.',
        bulletPoints: [
          'Début brutal après exposition allergène',
          'Cutané: urticaire, angioedème',
          'Respiratoire: bronchospasme, stridor, dyspnée',
          'Cardiovasculaire: hypotension, tachycardie',
          'Digestif: vomissements, douleurs abdominales',
        ],
      ),
      ProtocolStep(
        title: '2. Adrénaline IM',
        content: 'Traitement de première ligne.',
        bulletPoints: [
          'Adrénaline IM face antéro-latérale cuisse',
          '< 6 ans: 150 µg (Anapen/Epipen Junior)',
          '6-12 ans: 300 µg',
          '> 12 ans: 300-500 µg',
          'Répéter après 5 min si pas d\'amélioration',
        ],
        warning: 'Ne pas retarder l\'adrénaline!',
      ),
      ProtocolStep(
        title: '3. Position',
        content: 'Selon symptômes.',
        bulletPoints: [
          'Allongé jambes surélevées si hypotension',
          'Assis si détresse respiratoire',
          'PLS si troubles conscience',
        ],
      ),
      ProtocolStep(
        title: '4. Traitements associés',
        content: 'Après adrénaline.',
        bulletPoints: [
          'O2 haut débit',
          'Remplissage NaCl 0.9%: 20 mL/kg si hypotension',
          'Salbutamol nébulisé si bronchospasme',
          'Antihistaminiques H1 (desloratadine, cétirizine)',
          'Corticoïdes (prévention phase tardive)',
        ],
      ),
      ProtocolStep(
        title: '5. Surveillance',
        content: 'Risque de réaction biphasique.',
        bulletPoints: [
          'Observation minimum 6-8 heures',
          '24h si réaction sévère',
          'Risque récidive dans les 24h',
        ],
      ),
      ProtocolStep(
        title: '6. À la sortie',
        content: 'Prévention et suivi.',
        bulletPoints: [
          'Prescription stylo auto-injecteur',
          'Éducation utilisation',
          'PAI scolaire',
          'Consultation allergologie',
        ],
      ),
    ],
    keyPoints: 'Adrénaline IM précoce. Répéter si besoin. Surveillance 6-8h. Stylo auto-injecteur à la sortie.',
    source: 'EAACI 2021 - Anaphylaxis Guidelines',
    lastUpdated: 2021,
  ),
];
// ============================================================================
// OBSTETRIC PROTOCOLS
// ============================================================================

final List<Protocol> obstetricProtocols = [
  // Éclampsie
  Protocol(
    id: 'eclampsie',
    name: 'Éclampsie',
    category: ProtocolCategory.obstetric,
    description: 'Convulsions sur pré-éclampsie',
    indication: 'Femme enceinte > 20 SA ou post-partum avec convulsions',
    steps: [
      ProtocolStep(
        title: '1. Prise en charge immédiate',
        content: 'Pendant la crise.',
        bulletPoints: [
          'PLS, protection des voies aériennes',
          'O2 haut débit',
          'Ne pas tenter d\'arrêter la crise par contention',
          'Voie veineuse périphérique',
        ],
      ),
      ProtocolStep(
        title: '2. Sulfate de magnésium',
        content: 'Traitement de référence.',
        bulletPoints: [
          'Dose de charge: 4g IV en 20 min',
          'Puis entretien: 1g/h IVSE',
          'Poursuivre 24-48h après dernière crise',
          'Surveillance: réflexes, FR, diurèse',
        ],
        warning: 'Antidote si surdosage: Gluconate de calcium 1g IV',
      ),
      ProtocolStep(
        title: '3. Si récidive sous MgSO4',
        content: 'Traitement de seconde ligne.',
        bulletPoints: [
          'Bolus supplémentaire MgSO4 2g IV',
          'Si échec: Diazépam 10 mg IV',
          'ou Clonazépam 1 mg IV',
        ],
      ),
      ProtocolStep(
        title: '4. Contrôle tensionnel',
        content: 'Objectif PAS < 160, PAD < 110.',
        bulletPoints: [
          'Nicardipine IVSE (1-6 mg/h)',
          'ou Labétalol IV (20 mg bolus puis IVSE)',
          'Éviter chute brutale de PA (perfusion utéro-placentaire)',
        ],
      ),
      ProtocolStep(
        title: '5. Extraction fœtale',
        content: 'Seul traitement définitif.',
        bulletPoints: [
          'Décision après stabilisation maternelle',
          'Césarienne le plus souvent',
          'Pas d\'attente si instabilité persistante',
        ],
      ),
      ProtocolStep(
        title: '6. Surveillance post-critique',
        content: 'Réanimation ou soins intensifs.',
        bulletPoints: [
          'Monitoring materno-fœtal',
          'Surveillance MgSO4',
          'Bilan HELLP syndrome',
          'Scanner cérébral si atypie',
        ],
      ),
    ],
    keyPoints: 'MgSO4 = traitement de référence. Contrôle PA sans chute brutale. Extraction fœtale après stabilisation.',
    source: 'CNGOF, Magpie Trial',
    lastUpdated: 2020,
  ),

  // Hémorragie post-partum
  Protocol(
    id: 'hpp',
    name: 'Hémorragie du Post-Partum',
    category: ProtocolCategory.obstetric,
    description: 'Saignement > 500 mL (voie basse) ou > 1000 mL (césarienne)',
    indication: 'Hémorragie dans les 24h suivant l\'accouchement',
    steps: [
      ProtocolStep(
        title: '1. Alerte et organisation',
        content: 'Mobiliser l\'équipe.',
        bulletPoints: [
          'Appel obstétricien, anesthésiste, sage-femme',
          'Alerter banque du sang',
          'Chronométrer et quantifier les pertes',
          'Double voie veineuse gros calibre',
        ],
      ),
      ProtocolStep(
        title: '2. Étiologies (4T)',
        content: 'Rechercher la cause.',
        bulletPoints: [
          'Tonus: atonie utérine (70%)',
          'Tissu: rétention placentaire',
          'Trauma: déchirure cervico-vaginale, rupture utérine',
          'Thrombine: coagulopathie',
        ],
      ),
      ProtocolStep(
        title: '3. Traitement atonie utérine',
        content: 'Première cause.',
        bulletPoints: [
          'Massage utérin bimanuel',
          'Oxytocine 5-10 UI IV puis 20-40 UI/500 mL en perfusion',
          'Sulprostone (Nalador) 500 µg/h IVSE si échec',
          'Vidange vésicale',
        ],
        warning: 'Sulprostone: CI cardiovasculaires, max 1500 µg',
      ),
      ProtocolStep(
        title: '4. Acide tranexamique',
        content: 'Systématique.',
        bulletPoints: [
          '1g IV dès le diagnostic',
          'Répéter 1g si saignement persistant à 30 min',
        ],
      ),
      ProtocolStep(
        title: '5. Réanimation',
        content: 'Support hémodynamique.',
        bulletPoints: [
          'Remplissage cristalloïdes',
          'Transfusion CGR si Hb < 7 g/dL ou instabilité',
          'PFC, plaquettes, fibrinogène selon coagulation',
          'Objectif fibrinogène > 2 g/L',
        ],
      ),
      ProtocolStep(
        title: '6. Traitements invasifs',
        content: 'Si échec médical.',
        bulletPoints: [
          'Tamponnement intra-utérin (ballonnet)',
          'Embolisation artérielle',
          'Ligatures vasculaires',
          'Hystérectomie d\'hémostase (ultime recours)',
        ],
      ),
    ],
    keyPoints: '4T pour étiologie. Oxytocine puis sulprostone. Acide tranexamique 1g. Escalade jusqu\'à embolisation/chirurgie.',
    source: 'CNGOF 2014 - HPP',
    lastUpdated: 2014,
  ),

  // Pré-éclampsie
  Protocol(
    id: 'pre-eclampsie',
    name: 'Pré-éclampsie Sévère',
    category: ProtocolCategory.obstetric,
    description: 'HTA gravidique avec protéinurie et atteinte d\'organe',
    indication: 'PA ≥ 160/110 + protéinurie + signes de gravité',
    steps: [
      ProtocolStep(
        title: '1. Critères de sévérité',
        content: 'Identifier les formes graves.',
        bulletPoints: [
          'PAS ≥ 160 ou PAD ≥ 110 mmHg',
          'Protéinurie > 5 g/24h',
          'Oligurie < 500 mL/24h',
          'Céphalées, troubles visuels, ROT vifs',
          'Douleur épigastrique (HELLP)',
          'Cytolyse hépatique, thrombopénie',
        ],
      ),
      ProtocolStep(
        title: '2. Traitement antihypertenseur',
        content: 'Urgence hypertensive.',
        bulletPoints: [
          'Objectif: PAS 140-150, PAD 90-100',
          'Nicardipine IVSE 1-6 mg/h',
          'ou Labétalol IV 20 mg puis IVSE',
          'Éviter baisse brutale (souffrance fœtale)',
        ],
        warning: 'Ne pas descendre PA trop vite: risque fœtal',
      ),
      ProtocolStep(
        title: '3. Prévention éclampsie',
        content: 'Sulfate de magnésium.',
        bulletPoints: [
          'Indication: pré-éclampsie sévère',
          'Dose charge: 4g IV en 20 min',
          'Entretien: 1g/h IVSE',
          'Surveillance: réflexes, FR > 12, magnésémie',
        ],
      ),
      ProtocolStep(
        title: '4. Bilan HELLP',
        content: 'Rechercher complications.',
        bulletPoints: [
          'Hémolyse: LDH, haptoglobine, schizocytes',
          'Elevated Liver enzymes: ASAT, ALAT',
          'Low Platelets: < 100 G/L',
        ],
      ),
      ProtocolStep(
        title: '5. Décision d\'extraction',
        content: 'Seul traitement définitif.',
        bulletPoints: [
          '< 34 SA: corticoïdes pour maturation pulmonaire si possible',
          '≥ 34 SA: extraction à discuter',
          'Extraction urgente si: HELLP, HRP, souffrance fœtale',
        ],
      ),
      ProtocolStep(
        title: '6. Surveillance',
        content: 'Monitoring continu.',
        bulletPoints: [
          'Monitoring PA, SpO2',
          'RCF (rythme cardiaque fœtal)',
          'Bilan biologique répété',
          'Diurèse horaire',
        ],
      ),
    ],
    keyPoints: 'PA 140-150/90-100. MgSO4 si sévère. Bilan HELLP. Extraction = traitement définitif.',
    source: 'CNGOF, ISSHP',
    lastUpdated: 2020,
  ),

  // Accouchement inopiné
  Protocol(
    id: 'accouchement-inopine',
    name: 'Accouchement Inopiné',
    category: ProtocolCategory.obstetric,
    description: 'Accouchement en dehors d\'une structure adaptée',
    indication: 'Accouchement imminent hors maternité',
    steps: [
      ProtocolStep(
        title: '1. Évaluation',
        content: 'Imminence de l\'accouchement.',
        bulletPoints: [
          'Envie de pousser irrépressible',
          'Tête visible à la vulve',
          'Contractions rapprochées intenses',
          'Si transfert possible < 15 min: transférer',
        ],
      ),
      ProtocolStep(
        title: '2. Préparation',
        content: 'Matériel nécessaire.',
        bulletPoints: [
          'Gants stériles, champs',
          'Clamps de cordon ou lacets stériles',
          'Ciseaux stériles',
          'Couverture chaude pour le nouveau-né',
          'Aspiration douce si disponible',
        ],
      ),
      ProtocolStep(
        title: '3. Accouchement',
        content: 'Accompagner l\'expulsion.',
        bulletPoints: [
          'Position gynécologique ou latérale',
          'Soutenir le périnée (pas de protection rigide)',
          'Contrôler la sortie de la tête',
          'Vérifier absence de circulaire serré du cordon',
          'Dégager les épaules avec rotation douce',
        ],
        tip: 'Ne pas tirer sur la tête, accompagner seulement',
      ),
      ProtocolStep(
        title: '4. Soins nouveau-né',
        content: 'À la naissance.',
        bulletPoints: [
          'Sécher et stimuler',
          'Peau à peau avec la mère si va bien',
          'Évaluer: cri, tonus, coloration',
          'Aspiration si nécessaire',
          'Garder au chaud +++',
        ],
      ),
      ProtocolStep(
        title: '5. Cordon ombilical',
        content: 'Clampage.',
        bulletPoints: [
          'Attendre 1-3 min si nouveau-né stable',
          'Clamper à 2 et 5 cm de l\'ombilic',
          'Section entre les clamps',
        ],
      ),
      ProtocolStep(
        title: '6. Délivrance',
        content: 'Expulsion du placenta.',
        bulletPoints: [
          'Attendre signes de décollement (15-30 min)',
          'Ne pas tirer sur le cordon',
          'Injection oxytocine 5-10 UI IM après délivrance',
          'Vérifier intégrité du placenta',
          'Massage utérin',
        ],
        warning: 'Ne jamais tirer sur le cordon: risque de rupture et d\'inversion utérine',
      ),
    ],
    keyPoints: 'Accompagner sans tirer. Sécher et réchauffer le nouveau-né. Oxytocine après délivrance.',
    source: 'Recommandations SFAR/SFMU',
    lastUpdated: 2020,
  ),
];

// ============================================================================
// ANALGESIA / SEDATION PROTOCOLS
// ============================================================================

final List<Protocol> analgesiaProtocols = [
  // ISR
  Protocol(
    id: 'isr',
    name: 'Intubation en Séquence Rapide',
    category: ProtocolCategory.analgesia,
    description: 'Technique d\'intubation pour estomac plein ou urgence',
    indication: 'Intubation en urgence, estomac plein, détresse vitale',
    steps: [
      ProtocolStep(
        title: '1. Préparation',
        content: 'Check-list avant ISR.',
        bulletPoints: [
          'Vérifier matériel: laryngoscope, sondes (taille + 1 au-dessus et dessous)',
          'Aspiration fonctionnelle',
          'Monitorage: SpO2, capno, ECG, PA',
          'Voie veineuse sûre',
          'Plan B: dispositif supraglottique, kit de cricothyroïdotomie',
        ],
      ),
      ProtocolStep(
        title: '2. Préoxygénation',
        content: 'Dénitrogénation.',
        bulletPoints: [
          'O2 100% pendant 3-5 min',
          'Objectif: EtO2 > 90%',
          'Ou 8 inspirations profondes si urgent',
          'VNI si hypoxémique (CPAP ou BiPAP)',
        ],
        tip: 'Position proclive 30° améliore la préoxygénation',
      ),
      ProtocolStep(
        title: '3. Induction',
        content: 'Hypnotique + curare.',
        bulletPoints: [
          'Hypnotique au choix:',
          '- Étomidate 0.3 mg/kg (stabilité HD)',
          '- Kétamine 1-2 mg/kg (bronchospasme, choc)',
          '- Propofol 2-2.5 mg/kg (CI si instable)',
          'Curare:',
          '- Succinylcholine 1 mg/kg (délai 60 sec, durée 6-10 min)',
          '- Rocuronium 1.2 mg/kg (réversible par sugammadex)',
        ],
        warning: 'Succinylcholine CI: hyperkaliémie, myopathie, brûlure > 24h',
      ),
      ProtocolStep(
        title: '4. Manœuvre de Sellick',
        content: 'Controversée mais habituelle.',
        bulletPoints: [
          'Pression cricoïdienne dès perte de conscience',
          'Maintenir jusqu\'à vérification du ballonnet',
          'Relâcher si vomissement actif ou difficulté intubation',
        ],
      ),
      ProtocolStep(
        title: '5. Intubation',
        content: 'Sans ventilation intermédiaire.',
        bulletPoints: [
          'Laryngoscopie dès fasciculations terminées ou 60 sec',
          'Pas de ventilation au masque entre induction et IOT',
          'Vidéolaryngoscope si anticipation difficile',
          'Vérification: capnographie +++, auscultation',
        ],
      ),
      ProtocolStep(
        title: '6. Post-intubation',
        content: 'Sécurisation.',
        bulletPoints: [
          'Gonfler ballonnet',
          'Fixer la sonde',
          'Vérifier position: capno, auscultation, radio',
          'Sédation d\'entretien',
          'Sonde gastrique',
        ],
      ),
    ],
    keyPoints: 'Préoxygénation 3 min. Pas de ventilation intermédiaire. Succinylcholine ou rocuronium. Vérifier par capno.',
    source: 'SFAR/SFMU 2017 - Intubation difficile',
    lastUpdated: 2017,
  ),

  // Analgésie aux urgences
  Protocol(
    id: 'analgesie-urgences',
    name: 'Analgésie aux Urgences',
    category: ProtocolCategory.analgesia,
    description: 'Prise en charge de la douleur aux urgences',
    indication: 'Patient douloureux aux urgences',
    steps: [
      ProtocolStep(
        title: '1. Évaluation',
        content: 'Quantifier la douleur.',
        bulletPoints: [
          'EVA ou EN (0-10)',
          'Légère: 1-3',
          'Modérée: 4-6',
          'Sévère: 7-10',
          'Échelles comportementales si non communicant',
        ],
      ),
      ProtocolStep(
        title: '2. Douleur légère (EVA 1-3)',
        content: 'Palier 1.',
        bulletPoints: [
          'Paracétamol 1g PO/IV',
          'Renouveler toutes les 6h si besoin',
          'Maximum 4g/24h (3g si > 65 ans ou IHC)',
        ],
      ),
      ProtocolStep(
        title: '3. Douleur modérée (EVA 4-6)',
        content: 'Palier 1-2 + AINS.',
        bulletPoints: [
          'Paracétamol + AINS si pas de CI',
          'Kétoprofène 100 mg IV ou Ibuprofène 400 mg PO',
          'CI AINS: IR, UGD, grossesse 3T, allergie, HTA mal contrôlée',
          'Tramadol 50-100 mg PO ou Codéine',
        ],
      ),
      ProtocolStep(
        title: '4. Douleur sévère (EVA 7-10)',
        content: 'Morphine.',
        bulletPoints: [
          'Titration morphine IV:',
          '- Bolus initial: 0.05-0.1 mg/kg (2-3 mg)',
          '- Réinjections 1-2 mg toutes les 5-10 min',
          '- Objectif EVA < 3',
          'Naloxone disponible',
        ],
        tip: 'Réévaluer EVA après chaque injection',
      ),
      ProtocolStep(
        title: '5. Alternatives et adjuvants',
        content: 'Autres options.',
        bulletPoints: [
          'Kétamine faible dose 0.1-0.3 mg/kg (épargne morphinique)',
          'Bloc nerveux si lésion localisée',
          'MEOPA pour gestes douloureux',
          'Nefopam 20 mg IV (contre-indiqué si épilepsie)',
        ],
      ),
      ProtocolStep(
        title: '6. Populations particulières',
        content: 'Adapter les doses.',
        bulletPoints: [
          'Sujet âgé: réduire doses, titration prudente',
          'Insuffisant rénal: éviter AINS, adapter opioïdes',
          'Grossesse: paracétamol, éviter AINS T3',
          'Enfant: doses adaptées au poids',
        ],
      ),
    ],
    keyPoints: 'Évaluer EVA. Palier 1-2 si modérée. Morphine titrée si sévère. Réévaluer systématiquement.',
    source: 'SFMU 2019 - Analgésie aux urgences',
    lastUpdated: 2019,
  ),

  // Sédation procédurale
  Protocol(
    id: 'sedation-procedurale',
    name: 'Sédation Procédurale',
    category: ProtocolCategory.analgesia,
    description: 'Sédation pour gestes douloureux aux urgences',
    indication: 'Réduction de luxation, cardioversion, gestes douloureux',
    steps: [
      ProtocolStep(
        title: '1. Évaluation pré-sédation',
        content: 'Critères de sécurité.',
        bulletPoints: [
          'Jeûne (relatif selon urgence)',
          'Voies aériennes: Mallampati, ouverture bouche',
          'Comorbidités: cardio, respi, obésité',
          'Médicaments et allergies',
        ],
      ),
      ProtocolStep(
        title: '2. Préparation',
        content: 'Environnement sécurisé.',
        bulletPoints: [
          'Matériel de réanimation disponible',
          'O2, aspiration, BAVU',
          'Antidotes prêts: flumazénil, naloxone',
          'Monitoring: SpO2, capno, ECG, PA',
          '2 personnes: 1 pour sédation, 1 pour geste',
        ],
      ),
      ProtocolStep(
        title: '3. Protocoles courants',
        content: 'Selon indication.',
        bulletPoints: [
          'Propofol: 0.5-1 mg/kg IV, titrer par 0.25 mg/kg',
          'Kétamine: 1-2 mg/kg IV (dissociatif)',
          'Midazolam + Fentanyl: 0.05 mg/kg + 1 µg/kg',
          'MEOPA: inhalation pour gestes courts',
        ],
      ),
      ProtocolStep(
        title: '4. Kétamine - spécificités',
        content: 'Option intéressante.',
        bulletPoints: [
          'Maintien réflexes VAS et ventilation',
          'Bronchodilatateur',
          'Stabilité hémodynamique',
          'Phénomènes émergence: prévenir par midazolam 1 mg',
          'CI relative: HTA, cardiopathie ischémique',
        ],
      ),
      ProtocolStep(
        title: '5. Surveillance',
        content: 'Pendant et après.',
        bulletPoints: [
          'Monitoring continu pendant geste',
          'Surveillance post-sédation jusqu\'à réveil complet',
          'Critères de sortie: orientation normale, marche stable',
        ],
      ),
      ProtocolStep(
        title: '6. Gestion des complications',
        content: 'Réagir vite.',
        bulletPoints: [
          'Désaturation: subluxation mâchoire, O2, ventilation',
          'Apnée: ventilation au masque, antagonistes',
          'Hypotension: remplissage, réduire/arrêter sédatif',
          'Vomissements: aspiration, position latérale',
        ],
      ),
    ],
    keyPoints: 'Environnement sécurisé. Titration. Monitoring continu. Surveillance jusqu\'à réveil complet.',
    source: 'ACEP - Procedural Sedation',
    lastUpdated: 2020,
  ),

  // ALR aux urgences
  Protocol(
    id: 'alr-urgences',
    name: 'Anesthésie Locorégionale aux Urgences',
    category: ProtocolCategory.analgesia,
    description: 'Blocs nerveux périphériques pour analgésie',
    indication: 'Analgésie localisée pour trauma, suture, exploration',
    steps: [
      ProtocolStep(
        title: '1. Indications courantes',
        content: 'Blocs les plus utilisés.',
        bulletPoints: [
          'Bloc fémoral: fracture fémur, col fémoral',
          'Bloc PENG: fracture hanche',
          'Bloc axillaire: trauma membre supérieur',
          'Bloc de la gaine des fléchisseurs: plaie main',
          'Bloc digital: plaie doigt',
        ],
      ),
      ProtocolStep(
        title: '2. Contre-indications',
        content: 'Situations à éviter.',
        bulletPoints: [
          'Infection au point de ponction',
          'Allergie vraie aux anesthésiques locaux',
          'Troubles de coagulation sévères',
          'Refus du patient',
          'Atteinte neurologique préexistante du territoire',
        ],
      ),
      ProtocolStep(
        title: '3. Anesthésiques locaux',
        content: 'Produits et doses.',
        bulletPoints: [
          'Lidocaïne 1-2%: délai rapide, durée 1-2h',
          'Dose max: 4 mg/kg (7 mg/kg avec adrénaline)',
          'Ropivacaïne 0.5%: délai moyen, durée 4-8h',
          'Dose max: 3 mg/kg',
          'Éviter adrénaline: extrémités (doigts, orteils)',
        ],
      ),
      ProtocolStep(
        title: '4. Bloc fémoral (technique)',
        content: 'Fracture du fémur.',
        bulletPoints: [
          'Repérage: 1-2 cm sous ligament inguinal, latéral à l\'artère',
          'Échoguidage recommandé',
          'Volume: 20-30 mL ropivacaïne 0.5%',
          'Aspiration avant injection',
        ],
      ),
      ProtocolStep(
        title: '5. Toxicité systémique (LAST)',
        content: 'Complication grave.',
        bulletPoints: [
          'Signes: goût métallique, acouphènes, convulsions, ACR',
          'Arrêter injection',
          'Intralipid 20%: 1.5 mL/kg bolus puis 0.25 mL/kg/min',
          'RCP si ACR (éviter amiodarone)',
        ],
        warning: 'Toujours avoir Intralipid disponible',
      ),
      ProtocolStep(
        title: '6. Documentation',
        content: 'Traçabilité.',
        bulletPoints: [
          'Consentement',
          'Produit, concentration, volume',
          'Heure, technique',
          'Surveillance post-bloc',
        ],
      ),
    ],
    keyPoints: 'Échoguidage recommandé. Respecter doses max. Intralipid disponible. Efficacité excellente.',
    source: 'SFAR - ALR périphérique',
    lastUpdated: 2019,
  ),
];

// ============================================================================
// RESUSCITATION PROTOCOLS
// ============================================================================

final List<Protocol> resuscitationProtocols = [
  // Choc cardiogénique
  Protocol(
    id: 'choc-cardiogenique',
    name: 'Choc Cardiogénique',
    category: ProtocolCategory.resuscitation,
    description: 'Défaillance cardiaque aiguë avec hypoperfusion tissulaire',
    indication: 'PAS < 90 mmHg avec signes d\'hypoperfusion et congestion',
    steps: [
      ProtocolStep(
        title: '1. Reconnaissance',
        content: 'Diagnostic clinique.',
        bulletPoints: [
          'Hypotension: PAS < 90 mmHg ou chute > 30 mmHg',
          'Signes d\'hypoperfusion: marbrures, confusion, oligurie',
          'Signes de congestion: OAP, turgescence jugulaire',
          'IC bas débit + index cardiaque < 2.2 L/min/m²',
        ],
      ),
      ProtocolStep(
        title: '2. Étiologies à rechercher',
        content: 'Causes principales.',
        bulletPoints: [
          'SCA (80% des cas)',
          'Complications mécaniques: rupture, CIV, IM aiguë',
          'Myocardite aiguë',
          'Embolie pulmonaire massive',
          'Tamponnade',
          'Décompensation cardiopathie chronique',
        ],
      ),
      ProtocolStep(
        title: '3. Oxygénation',
        content: 'Support respiratoire.',
        bulletPoints: [
          'O2 si SpO2 < 90%',
          'VNI si OAP toléré',
          'Intubation si détresse majeure',
          'Attention: pression positive peut aggraver le choc',
        ],
      ),
      ProtocolStep(
        title: '4. Remplissage prudent',
        content: 'Test de remplissage limité.',
        bulletPoints: [
          '250 mL NaCl si pas de congestion évidente',
          'Réévaluer immédiatement',
          'Éviter si signes de surcharge (OAP)',
        ],
        warning: 'Le remplissage peut aggraver la situation',
      ),
      ProtocolStep(
        title: '5. Support inotrope',
        content: 'Première ligne médicamenteuse.',
        bulletPoints: [
          'Dobutamine 2.5-20 µg/kg/min (inotrope positif)',
          'Noradrénaline si hypotension profonde',
          'Adrénaline si choc réfractaire',
          'Éviter dopamine (plus d\'arythmies)',
        ],
      ),
      ProtocolStep(
        title: '6. Assistance circulatoire',
        content: 'Si choc réfractaire.',
        bulletPoints: [
          'Ballon de contre-pulsion intra-aortique (CPBIA)',
          'ECMO veino-artérielle',
          'Impella (assistance ventriculaire)',
          'Décision multidisciplinaire urgente',
        ],
      ),
      ProtocolStep(
        title: '7. Traitement étiologique',
        content: 'En parallèle.',
        bulletPoints: [
          'SCA: coronarographie urgente',
          'Complication mécanique: chirurgie',
          'Tamponnade: péricardiocentèse',
          'EP massive: thrombolyse',
        ],
      ),
    ],
    keyPoints: 'Identifier cause. Remplissage prudent. Dobutamine ± noradrénaline. ECMO si réfractaire. Traiter étiologie.',
    source: 'ESC Guidelines - Cardiogenic shock',
    lastUpdated: 2021,
  ),

  // Tamponnade
  Protocol(
    id: 'tamponnade',
    name: 'Tamponnade Cardiaque',
    category: ProtocolCategory.resuscitation,
    description: 'Compression cardiaque par épanchement péricardique',
    indication: 'Triade de Beck + instabilité hémodynamique',
    steps: [
      ProtocolStep(
        title: '1. Reconnaissance',
        content: 'Signes cliniques.',
        bulletPoints: [
          'Triade de Beck: hypotension, BDC assourdis, turgescence jugulaire',
          'Pouls paradoxal > 10 mmHg',
          'Tachycardie, dyspnée',
          'Contexte: trauma, péricardite, cancer, chirurgie cardiaque',
        ],
      ),
      ProtocolStep(
        title: '2. Échocardiographie',
        content: 'Confirmation diagnostique.',
        bulletPoints: [
          'Épanchement péricardique',
          'Collapsus diastolique OD puis VD',
          'Variation respiratoire des flux (> 25%)',
          'VCI dilatée sans variation respiratoire',
        ],
      ),
      ProtocolStep(
        title: '3. Mesures temporaires',
        content: 'En attendant drainage.',
        bulletPoints: [
          'Remplissage vasculaire 500-1000 mL',
          'Position demi-assise',
          'Éviter ventilation pression positive',
          'Dobutamine si besoin',
        ],
        warning: 'Ne pas retarder le drainage',
      ),
      ProtocolStep(
        title: '4. Péricardiocentèse',
        content: 'Geste salvateur.',
        bulletPoints: [
          'Échoguidage +++',
          'Voie sous-xiphoïdienne ou apicale',
          'Anesthésie locale',
          'Aspiration progressive',
          'Laisser drain si récidive possible',
        ],
      ),
      ProtocolStep(
        title: '5. Drainage chirurgical',
        content: 'Indications.',
        bulletPoints: [
          'Tamponnade traumatique (hémopéricarde)',
          'Épanchement cloisonné',
          'Récidive après péricardiocentèse',
          'Nécessité de biopsie péricardique',
        ],
      ),
      ProtocolStep(
        title: '6. Causes à rechercher',
        content: 'Étiologie.',
        bulletPoints: [
          'Péricardite (virale, tuberculeuse)',
          'Néoplasie',
          'Urémique',
          'Dissection aortique',
          'Iatrogène (cathétérisme, chirurgie)',
          'Trauma',
        ],
      ),
    ],
    keyPoints: 'Triade de Beck + écho. Remplissage en attendant. Péricardiocentèse échoguidée. Chirurgie si trauma.',
    source: 'ESC Guidelines - Pericardial diseases',
    lastUpdated: 2015,
  ),

  // Remplissage vasculaire
  Protocol(
    id: 'remplissage-vasculaire',
    name: 'Remplissage Vasculaire',
    category: ProtocolCategory.resuscitation,
    description: 'Stratégie de remplissage en réanimation',
    indication: 'Hypovolémie, état de choc, précharge-dépendance',
    steps: [
      ProtocolStep(
        title: '1. Évaluation de la volémie',
        content: 'Critères cliniques et dynamiques.',
        bulletPoints: [
          'Clinique: TRC, marbrures, diurèse',
          'Indices dynamiques: ΔPP > 13%, variations VCI',
          'Lever de jambes passif: augmentation VES > 10%',
          'Test de remplissage: 250-500 mL et réévaluer',
        ],
      ),
      ProtocolStep(
        title: '2. Choix du soluté',
        content: 'Cristalloïdes en première intention.',
        bulletPoints: [
          'NaCl 0.9%: isotonique, référence',
          'Ringer lactate: plus physiologique, évite acidose hyperchlorémique',
          'Éviter HEA (risque rénal)',
          'Albumine: peu d\'indications en urgence',
        ],
        tip: 'Ringer lactate préféré si gros volumes',
      ),
      ProtocolStep(
        title: '3. Objectifs',
        content: 'Cibles hémodynamiques.',
        bulletPoints: [
          'PAM ≥ 65 mmHg (≥ 80 si HTA chronique)',
          'Diurèse > 0.5 mL/kg/h',
          'Lactates en décroissance',
          'Amélioration clinique (marbrures, conscience)',
        ],
      ),
      ProtocolStep(
        title: '4. Limites du remplissage',
        content: 'Éviter la surcharge.',
        bulletPoints: [
          'Surveillance signes congestifs',
          'Pas de volume fixe recommandé',
          'Réévaluation après chaque bolus',
          'Si pas de réponse après 2-3 L: vasopresseurs',
        ],
        warning: 'Surcharge = risque SDRA, œdème cérébral',
      ),
      ProtocolStep(
        title: '5. Situations particulières',
        content: 'Adapter au contexte.',
        bulletPoints: [
          'Choc septique: 30 mL/kg initial (guideline)',
          'Choc cardiogénique: prudence ++',
          'Choc hémorragique: hypotension permissive, transfusion précoce',
          'TC grave: éviter hypotension, limiter surcharge',
        ],
      ),
    ],
    keyPoints: 'Cristalloïdes en première ligne. Évaluer réponse au remplissage. Éviter surcharge. Adapter au contexte.',
    source: 'Surviving Sepsis Campaign 2021, ESICM',
    lastUpdated: 2021,
  ),

  // Support vasoactif
  Protocol(
    id: 'support-vasoactif',
    name: 'Support Vasoactif',
    category: ProtocolCategory.resuscitation,
    description: 'Utilisation des catécholamines en réanimation',
    indication: 'Choc persistant malgré remplissage adapté',
    steps: [
      ProtocolStep(
        title: '1. Noradrénaline',
        content: 'Vasopresseur de référence.',
        bulletPoints: [
          'Indication: choc avec vasoplégie (septique, anaphylactique)',
          'Dose: 0.1-3 µg/kg/min',
          'Objectif: PAM ≥ 65 mmHg',
          'VVC recommandée mais VVP possible initialement',
        ],
        tip: 'Peut être débuté sur VVP gros calibre < 4-6h',
      ),
      ProtocolStep(
        title: '2. Adrénaline',
        content: 'Inotrope et vasopresseur.',
        bulletPoints: [
          'Indication: choc cardiogénique réfractaire, anaphylaxie',
          'Dose: 0.1-1 µg/kg/min',
          'Effets: β1 (inotrope), α1 (vasopresseur), β2 (bronchodilatateur)',
          'Risque: tachycardie, arythmie, hyperlactatémie',
        ],
      ),
      ProtocolStep(
        title: '3. Dobutamine',
        content: 'Inotrope pur.',
        bulletPoints: [
          'Indication: choc cardiogénique avec PAM maintenue',
          'Dose: 2.5-20 µg/kg/min',
          'Effet β1 prédominant',
          'Attention: peut baisser la PA (effet β2)',
        ],
      ),
      ProtocolStep(
        title: '4. Vasopressine/Terlipressine',
        content: 'Deuxième ligne.',
        bulletPoints: [
          'Indication: choc septique réfractaire à noradrénaline',
          'Vasopressine: 0.03 U/min (dose fixe)',
          'Épargne en catécholamines',
          'CI: ischémie mésentérique, coronaire',
        ],
      ),
      ProtocolStep(
        title: '5. Choix selon type de choc',
        content: 'Adaptation.',
        bulletPoints: [
          'Septique: Noradrénaline ± vasopressine ± dobutamine',
          'Cardiogénique: Dobutamine ± noradrénaline',
          'Anaphylactique: Adrénaline',
          'Hémorragique: Noradrénaline (en attendant transfusion)',
        ],
      ),
      ProtocolStep(
        title: '6. Surveillance',
        content: 'Monitoring étroit.',
        bulletPoints: [
          'PA invasive recommandée',
          'VVC avec PVC',
          'Débit cardiaque si disponible',
          'Lactates, ScvO2',
          'Échographie cardiaque',
        ],
      ),
    ],
    keyPoints: 'Noradrénaline en 1ère ligne. Dobutamine si bas débit. Adapter au type de choc. VVC dès que possible.',
    source: 'Surviving Sepsis Campaign 2021, ESICM',
    lastUpdated: 2021,
  ),

  // Indications ECMO
  Protocol(
    id: 'ecmo-indications',
    name: 'Indications ECMO',
    category: ProtocolCategory.resuscitation,
    description: 'Oxygénation par membrane extracorporelle',
    indication: 'Défaillance respiratoire ou cardiaque réfractaire',
    steps: [
      ProtocolStep(
        title: '1. Types d\'ECMO',
        content: 'VV vs VA.',
        bulletPoints: [
          'ECMO VV (veino-veineuse): défaillance respiratoire isolée',
          'ECMO VA (veino-artérielle): défaillance cardiaque ± respiratoire',
        ],
      ),
      ProtocolStep(
        title: '2. Indications ECMO VV',
        content: 'SDRA réfractaire.',
        bulletPoints: [
          'SDRA sévère (PaO2/FiO2 < 80) malgré optimisation',
          'Ventilation protectrice impossible',
          'Hypercapnie réfractaire avec pH < 7.20',
          'Score Murray > 3',
        ],
      ),
      ProtocolStep(
        title: '3. Indications ECMO VA',
        content: 'Choc cardiogénique réfractaire.',
        bulletPoints: [
          'Choc cardiogénique réfractaire aux inotropes',
          'ACR réfractaire (eCPR) dans conditions spécifiques',
          'Post-chirurgie cardiaque',
          'Bridge vers transplantation ou récupération',
        ],
      ),
      ProtocolStep(
        title: '4. Contre-indications relatives',
        content: 'À évaluer.',
        bulletPoints: [
          'Âge avancé (selon centres)',
          'Comorbidités majeures',
          'Défaillance multiviscérale prolongée',
          'Pas de perspective de récupération ou transplantation',
          'Anticoagulation impossible',
        ],
      ),
      ProtocolStep(
        title: '5. Critères eCPR',
        content: 'ECMO pour ACR.',
        bulletPoints: [
          'Âge < 70 ans (selon centres)',
          'No-flow < 5 min',
          'Low-flow < 60-90 min',
          'Cause réversible identifiable',
          'Pas de comorbidité majeure',
          'EtCO2 > 10 mmHg pendant RCP',
        ],
        warning: 'Décision multidisciplinaire rapide',
      ),
      ProtocolStep(
        title: '6. Organisation',
        content: 'Mise en place.',
        bulletPoints: [
          'Contact centre ECMO',
          'Transport médicalisé ou équipe mobile',
          'Canulation percutanée ou chirurgicale',
          'Anticoagulation par héparine',
        ],
      ),
    ],
    keyPoints: 'VV = poumon, VA = cœur. Contacter centre ECMO précocement. eCPR = critères stricts.',
    source: 'ELSO Guidelines, SFAR',
    lastUpdated: 2021,
  ),
];
