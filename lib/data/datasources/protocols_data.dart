import '../../core/l10n/localized.dart';
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
    name: LString('Arrêt Cardiorespiratoire Adulte', 'Arrêt Cardiorespiratoire Adulte'),
    category: ProtocolCategory.cardiology,
    description: LString('Prise en charge de l\'ACR selon les recommandations ERC 2021', 'Prise en charge de l\'ACR selon les recommandations ERC 2021'),
    indication: LString('Patient en arrêt cardiorespiratoire (absence de pouls, absence de respiration efficace)', 'Patient en arrêt cardiorespiratoire (absence de pouls, absence de respiration efficace)'),
    contraindication: LString('Directives anticipées limitant la réanimation, signes de mort certaine', 'Directives anticipées limitant la réanimation, signes de mort certaine'),
    steps: [
      ProtocolStep(
        title: LString('1. Sécurité et reconnaissance', '1. Sécurité et reconnaissance'),
        content: LString('Vérifier la sécurité de la scène. Évaluer la conscience et la respiration.', 'Vérifier la sécurité de la scène. Évaluer la conscience et la respiration.'),
        bulletPoints: [
          LString('Secouer les épaules et appeler fort', 'Secouer les épaules et appeler fort'),
          LString('Regarder le thorax 10 secondes maximum', 'Regarder le thorax 10 secondes maximum'),
          LString('Gasps = absence de respiration', 'Gasps = absence de respiration'),
        ],
        warning: LString('Ne pas perdre de temps à chercher le pouls si non formé', 'Ne pas perdre de temps à chercher le pouls si non formé'),
      ),
      ProtocolStep(
        title: LString('2. Alerter et RCP de base', '2. Alerter et RCP de base'),
        content: LString('Alerter les secours (15/112) et débuter immédiatement la RCP.', 'Alerter les secours (15/112) et débuter immédiatement la RCP.'),
        bulletPoints: [
          LString('MCE: 100-120/min, profondeur 5-6 cm', 'MCE: 100-120/min, profondeur 5-6 cm'),
          LString('Ratio 30:2 sans voie aérienne avancée', 'Ratio 30:2 sans voie aérienne avancée'),
          LString('Minimiser les interruptions < 10 sec', 'Minimiser les interruptions < 10 sec'),
          LString('Changer de masseur toutes les 2 min', 'Changer de masseur toutes les 2 min'),
        ],
        tip: LString('Utiliser le métronome du scope ou une application', 'Utiliser le métronome du scope ou une application'),
      ),
      ProtocolStep(
        title: LString('3. Défibrillation', '3. Défibrillation'),
        content: LString('Analyser le rythme dès que le défibrillateur est disponible.', 'Analyser le rythme dès que le défibrillateur est disponible.'),
        bulletPoints: [
          LString('Rythme choquable (FV/TV sans pouls): choc 150-200J biphasique', 'Rythme choquable (FV/TV sans pouls): choc 150-200J biphasique'),
          LString('Reprendre immédiatement MCE après le choc', 'Reprendre immédiatement MCE après le choc'),
          LString('Analyser le rythme toutes les 2 min', 'Analyser le rythme toutes les 2 min'),
          LString('Rythme non choquable (asystolie/AESP): continuer RCP', 'Rythme non choquable (asystolie/AESP): continuer RCP'),
        ],
        warning: LString('Ne pas interrompre le MCE pendant la charge', 'Ne pas interrompre le MCE pendant la charge'),
      ),
      ProtocolStep(
        title: LString('4. Voies aériennes et ventilation', '4. Voies aériennes et ventilation'),
        content: LString('Sécuriser les voies aériennes progressivement.', 'Sécuriser les voies aériennes progressivement.'),
        bulletPoints: [
          LString('Canule oropharyngée + ballon-masque initialement', 'Canule oropharyngée + ballon-masque initialement'),
          LString('IOT si opérateur expérimenté sans interrompre MCE', 'IOT si opérateur expérimenté sans interrompre MCE'),
          LString('Dispositif supraglottique si IOT difficile', 'Dispositif supraglottique si IOT difficile'),
          LString('Ventilation 10/min une fois voie aérienne avancée', 'Ventilation 10/min une fois voie aérienne avancée'),
        ],
        tip: LString('La qualité du MCE prime sur l\'intubation', 'La qualité du MCE prime sur l\'intubation'),
      ),
      ProtocolStep(
        title: LString('5. Adrénaline', '5. Adrénaline'),
        content: LString('Administrer l\'adrénaline selon le rythme.', 'Administrer l\'adrénaline selon le rythme.'),
        bulletPoints: [
          LString('Rythme non choquable: 1 mg IV dès que possible', 'Rythme non choquable: 1 mg IV dès que possible'),
          LString('Rythme choquable: 1 mg IV après le 3ème choc', 'Rythme choquable: 1 mg IV après le 3ème choc'),
          LString('Répéter 1 mg toutes les 3-5 minutes', 'Répéter 1 mg toutes les 3-5 minutes'),
          LString('Voie IO si accès IV impossible', 'Voie IO si accès IV impossible'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Amiodarone (si rythme choquable)', '6. Amiodarone (si rythme choquable)'),
        content: LString('Administrer après le 3ème choc inefficace.', 'Administrer après le 3ème choc inefficace.'),
        bulletPoints: [
          LString('300 mg IV après le 3ème choc', '300 mg IV après le 3ème choc'),
          LString('150 mg IV après le 5ème choc si toujours en FV/TV', '150 mg IV après le 5ème choc si toujours en FV/TV'),
        ],
      ),
      ProtocolStep(
        title: LString('7. Causes réversibles (4H/4T)', '7. Causes réversibles (4H/4T)'),
        content: LString('Rechercher et traiter les causes réversibles.', 'Rechercher et traiter les causes réversibles.'),
        bulletPoints: [
          LString('Hypoxie → oxygénation, ventilation', 'Hypoxie → oxygénation, ventilation'),
          LString('Hypovolémie → remplissage, transfusion', 'Hypovolémie → remplissage, transfusion'),
          LString('Hypo/Hyperkaliémie → correction ionique', 'Hypo/Hyperkaliémie → correction ionique'),
          LString('Hypothermie → réchauffement', 'Hypothermie → réchauffement'),
          LString('Thrombose coronaire → coronarographie', 'Thrombose coronaire → coronarographie'),
          LString('Thrombose pulmonaire → thrombolyse', 'Thrombose pulmonaire → thrombolyse'),
          LString('Tamponnade → péricardiocentèse', 'Tamponnade → péricardiocentèse'),
          LString('Pneumothorax sous Tension → exsufflation', 'Pneumothorax sous Tension → exsufflation'),
        ],
        warning: LString('La thrombolyse nécessite 60-90 min de RCP après', 'La thrombolyse nécessite 60-90 min de RCP après'),
      ),
      ProtocolStep(
        title: LString('8. Soins post-ACR', '8. Soins post-ACR'),
        content: LString('Si RACS (Retour à une Activité Circulatoire Spontanée).', 'Si RACS (Retour à une Activité Circulatoire Spontanée).'),
        bulletPoints: [
          LString('Objectif SpO2 94-98%, éviter hyperoxie', 'Objectif SpO2 94-98%, éviter hyperoxie'),
          LString('PAS > 100 mmHg (noradrénaline si besoin)', 'PAS > 100 mmHg (noradrénaline si besoin)'),
          LString('Contrôle glycémique (éviter hypo/hyperglycémie)', 'Contrôle glycémique (éviter hypo/hyperglycémie)'),
          LString('Contrôle température cible 32-36°C pendant 24h', 'Contrôle température cible 32-36°C pendant 24h'),
          LString('Coronarographie si suspicion SCA', 'Coronarographie si suspicion SCA'),
          LString('EEG et scanner cérébral', 'EEG et scanner cérébral'),
        ],
      ),
    ],
    keyPoints: LString('MCE de haute qualité est la priorité absolue. Minimiser les interruptions. Défibrillation précoce si rythme choquable.', 'MCE de haute qualité est la priorité absolue. Minimiser les interruptions. Défibrillation précoce si rythme choquable.'),
    source: LString('ERC Guidelines 2021', 'ERC Guidelines 2021'),
    sourceUrl: 'https://www.erc.edu',
    lastUpdated: 2021,
  ),

  // SCA ST+
  Protocol(
    id: 'sca-st-plus',
    name: LString('SCA ST+ (STEMI)', 'SCA ST+ (STEMI)'),
    category: ProtocolCategory.cardiology,
    description: LString('Syndrome coronarien aigu avec sus-décalage du segment ST', 'Syndrome coronarien aigu avec sus-décalage du segment ST'),
    indication: LString('Douleur thoracique typique avec sus-décalage ST ≥ 1mm dans 2 dérivations contiguës ou BBG nouveau', 'Douleur thoracique typique avec sus-décalage ST ≥ 1mm dans 2 dérivations contiguës ou BBG nouveau'),
    contraindication: LString('Voir contre-indications à la thrombolyse si applicable', 'Voir contre-indications à la thrombolyse si applicable'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation initiale', '1. Évaluation initiale'),
        content: LString('Diagnostic et stratification rapide.', 'Diagnostic et stratification rapide.'),
        bulletPoints: [
          LString('ECG 12 dérivations < 10 min', 'ECG 12 dérivations < 10 min'),
          LString('Monitoring continu (scope, SpO2)', 'Monitoring continu (scope, SpO2)'),
          LString('Voie veineuse périphérique', 'Voie veineuse périphérique'),
          LString('Bilan: troponine, NFS, iono, créat, coag', 'Bilan: troponine, NFS, iono, créat, coag'),
        ],
        warning: LString('ECG 18 dérivations si suspicion infarctus inférieur ou postérieur', 'ECG 18 dérivations si suspicion infarctus inférieur ou postérieur'),
      ),
      ProtocolStep(
        title: LString('2. Traitement antalgique et symptomatique', '2. Traitement antalgique et symptomatique'),
        content: LString('Soulager la douleur et stabiliser le patient.', 'Soulager la douleur et stabiliser le patient.'),
        bulletPoints: [
          LString('Morphine IV titrée si douleur intense (bolus 2-3 mg)', 'Morphine IV titrée si douleur intense (bolus 2-3 mg)'),
          LString('O2 uniquement si SpO2 < 90%', 'O2 uniquement si SpO2 < 90%'),
          LString('Position demi-assise', 'Position demi-assise'),
        ],
        tip: LString('Éviter O2 systématique (risque d\'hyperoxie)', 'Éviter O2 systématique (risque d\'hyperoxie)'),
      ),
      ProtocolStep(
        title: LString('3. Traitement antithrombotique', '3. Traitement antithrombotique'),
        content: LString('Double antiagrégation plaquettaire.', 'Double antiagrégation plaquettaire.'),
        bulletPoints: [
          LString('Aspirine 150-300 mg PO (ou 75-150 mg IV)', 'Aspirine 150-300 mg PO (ou 75-150 mg IV)'),
          LString('Inhibiteur P2Y12: Ticagrelor 180 mg ou Prasugrel 60 mg', 'Inhibiteur P2Y12: Ticagrelor 180 mg ou Prasugrel 60 mg'),
          LString('Si > 75 ans ou < 60 kg: Clopidogrel 600 mg', 'Si > 75 ans ou < 60 kg: Clopidogrel 600 mg'),
          LString('Anticoagulation: HNF 70-100 UI/kg IV ou Énoxaparine', 'Anticoagulation: HNF 70-100 UI/kg IV ou Énoxaparine'),
        ],
        warning: LString('Prasugrel contre-indiqué si ATCD AVC/AIT ou > 75 ans', 'Prasugrel contre-indiqué si ATCD AVC/AIT ou > 75 ans'),
      ),
      ProtocolStep(
        title: LString('4. Stratégie de reperfusion', '4. Stratégie de reperfusion'),
        content: LString('Choix entre angioplastie primaire et thrombolyse.', 'Choix entre angioplastie primaire et thrombolyse.'),
        bulletPoints: [
          LString('Angioplastie primaire si délai < 120 min (préféré)', 'Angioplastie primaire si délai < 120 min (préféré)'),
          LString('Thrombolyse si délai angioplastie > 120 min et symptômes < 12h', 'Thrombolyse si délai angioplastie > 120 min et symptômes < 12h'),
          LString('Ténectéplase dose adaptée au poids', 'Ténectéplase dose adaptée au poids'),
          LString('Transfert pour coronarographie 2-24h après thrombolyse', 'Transfert pour coronarographie 2-24h après thrombolyse'),
        ],
        tip: LString('Contact direct avec cardiologue interventionnel', 'Contact direct avec cardiologue interventionnel'),
      ),
      ProtocolStep(
        title: LString('5. Critères de reperfusion post-thrombolyse', '5. Critères de reperfusion post-thrombolyse'),
        content: LString('Évaluer le succès de la thrombolyse à 60-90 min.', 'Évaluer le succès de la thrombolyse à 60-90 min.'),
        bulletPoints: [
          LString('Succès: réduction ST > 50%, disparition douleur', 'Succès: réduction ST > 50%, disparition douleur'),
          LString('Échec: coronarographie de sauvetage urgente', 'Échec: coronarographie de sauvetage urgente'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Complications à surveiller', '6. Complications à surveiller'),
        content: LString('Surveillance des complications précoces.', 'Surveillance des complications précoces.'),
        bulletPoints: [
          LString('Troubles du rythme (FV, TV, BAV)', 'Troubles du rythme (FV, TV, BAV)'),
          LString('Insuffisance cardiaque aiguë', 'Insuffisance cardiaque aiguë'),
          LString('Choc cardiogénique', 'Choc cardiogénique'),
          LString('Complications mécaniques (rupture, CIV)', 'Complications mécaniques (rupture, CIV)'),
        ],
      ),
    ],
    keyPoints: LString('Time is muscle. Objectif: premier contact médical → reperfusion < 120 min. ECG < 10 min.', 'Time is muscle. Objectif: premier contact médical → reperfusion < 120 min. ECG < 10 min.'),
    source: LString('ESC Guidelines 2023 - STEMI', 'ESC Guidelines 2023 - STEMI'),
    sourceUrl: 'https://www.escardio.org',
    lastUpdated: 2023,
  ),

  // SCA ST-
  Protocol(
    id: 'sca-st-moins',
    name: LString('SCA ST- (NSTEMI)', 'SCA ST- (NSTEMI)'),
    category: ProtocolCategory.cardiology,
    description: LString('Syndrome coronarien aigu sans sus-décalage du ST', 'Syndrome coronarien aigu sans sus-décalage du ST'),
    indication: LString('Douleur thoracique avec modification ECG (sous-décalage ST, ondes T négatives) et/ou élévation troponine', 'Douleur thoracique avec modification ECG (sous-décalage ST, ondes T négatives) et/ou élévation troponine'),
    steps: [
      ProtocolStep(
        title: LString('1. Diagnostic', '1. Diagnostic'),
        content: LString('Confirmer le diagnostic et stratifier le risque.', 'Confirmer le diagnostic et stratifier le risque.'),
        bulletPoints: [
          LString('ECG répété si premier normal', 'ECG répété si premier normal'),
          LString('Troponine hs à H0 et H1 (ou H3)', 'Troponine hs à H0 et H1 (ou H3)'),
          LString('Score GRACE pour stratification', 'Score GRACE pour stratification'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Stratification du risque (GRACE)', '2. Stratification du risque (GRACE)'),
        content: LString('Déterminer le délai de coronarographie.', 'Déterminer le délai de coronarographie.'),
        bulletPoints: [
          LString('Très haut risque (immédiat < 2h): instabilité HD, arythmie, douleur réfractaire', 'Très haut risque (immédiat < 2h): instabilité HD, arythmie, douleur réfractaire'),
          LString('Haut risque (< 24h): GRACE > 140, modification ST/T, élévation troponine', 'Haut risque (< 24h): GRACE > 140, modification ST/T, élévation troponine'),
          LString('Risque intermédiaire (< 72h): diabète, IRC, FEVG < 40%, angioplastie récente', 'Risque intermédiaire (< 72h): diabète, IRC, FEVG < 40%, angioplastie récente'),
          LString('Bas risque: test d\'ischémie non invasif', 'Bas risque: test d\'ischémie non invasif'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Traitement antithrombotique', '3. Traitement antithrombotique'),
        content: LString('Similaire au STEMI avec adaptation selon stratégie.', 'Similaire au STEMI avec adaptation selon stratégie.'),
        bulletPoints: [
          LString('Aspirine 150-300 mg', 'Aspirine 150-300 mg'),
          LString('Inhibiteur P2Y12 selon timing coronarographie', 'Inhibiteur P2Y12 selon timing coronarographie'),
          LString('Anticoagulation: Fondaparinux 2.5 mg SC (préféré si non urgent)', 'Anticoagulation: Fondaparinux 2.5 mg SC (préféré si non urgent)'),
          LString('ou Énoxaparine 1 mg/kg x2/j', 'ou Énoxaparine 1 mg/kg x2/j'),
        ],
        tip: LString('Ticagrelor en prétraitement si coronarographie prévue', 'Ticagrelor en prétraitement si coronarographie prévue'),
      ),
      ProtocolStep(
        title: LString('4. Traitements adjuvants', '4. Traitements adjuvants'),
        content: LString('Optimisation du traitement médical.', 'Optimisation du traitement médical.'),
        bulletPoints: [
          LString('Bêtabloquant si FC > 70 et pas de CI', 'Bêtabloquant si FC > 70 et pas de CI'),
          LString('IEC/ARA2 si FEVG altérée ou HTA', 'IEC/ARA2 si FEVG altérée ou HTA'),
          LString('Statine haute dose', 'Statine haute dose'),
          LString('IPP si double antiagrégation', 'IPP si double antiagrégation'),
        ],
      ),
    ],
    keyPoints: LString('La stratification du risque guide le délai de coronarographie. Le score GRACE est essentiel.', 'La stratification du risque guide le délai de coronarographie. Le score GRACE est essentiel.'),
    source: LString('ESC Guidelines 2023 - NSTE-ACS', 'ESC Guidelines 2023 - NSTE-ACS'),
    sourceUrl: 'https://www.escardio.org',
    lastUpdated: 2023,
  ),

  // OAP
  Protocol(
    id: 'oap',
    name: LString('Œdème Aigu du Poumon', 'Œdème Aigu du Poumon'),
    category: ProtocolCategory.cardiology,
    description: LString('Insuffisance cardiaque aiguë avec œdème pulmonaire', 'Insuffisance cardiaque aiguë avec œdème pulmonaire'),
    indication: LString('Dyspnée aiguë avec signes de congestion pulmonaire et/ou systémique', 'Dyspnée aiguë avec signes de congestion pulmonaire et/ou systémique'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation immédiate', '1. Évaluation immédiate'),
        content: LString('Évaluer la gravité et le profil hémodynamique.', 'Évaluer la gravité et le profil hémodynamique.'),
        bulletPoints: [
          LString('Position assise ou demi-assise', 'Position assise ou demi-assise'),
          LString('Signes de gravité: tirage, cyanose, sueurs, troubles conscience', 'Signes de gravité: tirage, cyanose, sueurs, troubles conscience'),
          LString('Profil "chaud-humide" vs "froid-humide" (choc cardiogénique)', 'Profil "chaud-humide" vs "froid-humide" (choc cardiogénique)'),
          LString('Rechercher facteur déclenchant (SCA, arythmie, poussée HTA)', 'Rechercher facteur déclenchant (SCA, arythmie, poussée HTA)'),
        ],
        warning: LString('Si PAS < 90 mmHg: choc cardiogénique → protocole spécifique', 'Si PAS < 90 mmHg: choc cardiogénique → protocole spécifique'),
      ),
      ProtocolStep(
        title: LString('2. Oxygénation', '2. Oxygénation'),
        content: LString('Corriger l\'hypoxémie rapidement.', 'Corriger l\'hypoxémie rapidement.'),
        bulletPoints: [
          LString('O2 haut débit si SpO2 < 90%', 'O2 haut débit si SpO2 < 90%'),
          LString('VNI (CPAP/BiPAP) si persistance détresse', 'VNI (CPAP/BiPAP) si persistance détresse'),
          LString('CPAP 5-10 cmH2O ou BiPAP (IPAP 10-15, EPAP 5-10)', 'CPAP 5-10 cmH2O ou BiPAP (IPAP 10-15, EPAP 5-10)'),
          LString('Intubation si échec VNI ou trouble conscience', 'Intubation si échec VNI ou trouble conscience'),
        ],
        tip: LString('VNI à privilégier, réduit le recours à l\'intubation', 'VNI à privilégier, réduit le recours à l\'intubation'),
      ),
      ProtocolStep(
        title: LString('3. Diurétiques', '3. Diurétiques'),
        content: LString('Réduire la surcharge hydrosodée.', 'Réduire la surcharge hydrosodée.'),
        bulletPoints: [
          LString('Furosémide 40-80 mg IV (si traitement chronique: dose ≥ dose habituelle)', 'Furosémide 40-80 mg IV (si traitement chronique: dose ≥ dose habituelle)'),
          LString('Répéter si réponse insuffisante', 'Répéter si réponse insuffisante'),
          LString('Objectif diurèse > 100 mL/h les premières heures', 'Objectif diurèse > 100 mL/h les premières heures'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Vasodilatateurs (si PAS > 110 mmHg)', '4. Vasodilatateurs (si PAS > 110 mmHg)'),
        content: LString('Réduire la post-charge et la congestion.', 'Réduire la post-charge et la congestion.'),
        bulletPoints: [
          LString('Trinitrine sublinguale puis IVSE', 'Trinitrine sublinguale puis IVSE'),
          LString('Dose: 1-2 mg/h, titrer jusqu\'à 10 mg/h', 'Dose: 1-2 mg/h, titrer jusqu\'à 10 mg/h'),
          LString('Surveillance tensionnelle rapprochée', 'Surveillance tensionnelle rapprochée'),
        ],
        warning: LString('CI si PAS < 110 mmHg ou prise récente d\'IPDE5', 'CI si PAS < 110 mmHg ou prise récente d\'IPDE5'),
      ),
      ProtocolStep(
        title: LString('5. Rechercher et traiter la cause', '5. Rechercher et traiter la cause'),
        content: LString('Identifier le facteur déclenchant.', 'Identifier le facteur déclenchant.'),
        bulletPoints: [
          LString('ECG: SCA? Arythmie?', 'ECG: SCA? Arythmie?'),
          LString('Troponine, BNP/NT-proBNP', 'Troponine, BNP/NT-proBNP'),
          LString('Échocardiographie', 'Échocardiographie'),
          LString('Si SCA: stratégie de reperfusion', 'Si SCA: stratégie de reperfusion'),
          LString('Si FA rapide: contrôle fréquence/rythme', 'Si FA rapide: contrôle fréquence/rythme'),
        ],
      ),
    ],
    keyPoints: LString('Position assise + O2/VNI + Diurétiques + Vasodilatateurs (si PAS ok). Identifier la cause.', 'Position assise + O2/VNI + Diurétiques + Vasodilatateurs (si PAS ok). Identifier la cause.'),
    source: LString('ESC Guidelines 2021 - Heart Failure', 'ESC Guidelines 2021 - Heart Failure'),
    sourceUrl: 'https://www.escardio.org',
    lastUpdated: 2021,
  ),

  // Troubles du rythme
  Protocol(
    id: 'troubles-rythme',
    name: LString('Troubles du Rythme aux Urgences', 'Troubles du Rythme aux Urgences'),
    category: ProtocolCategory.cardiology,
    description: LString('Prise en charge des tachycardies et bradycardies instables', 'Prise en charge des tachycardies et bradycardies instables'),
    indication: LString('Arythmie avec retentissement hémodynamique ou symptômes sévères', 'Arythmie avec retentissement hémodynamique ou symptômes sévères'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation de l\'instabilité', '1. Évaluation de l\'instabilité'),
        content: LString('Identifier les signes de mauvaise tolérance.', 'Identifier les signes de mauvaise tolérance.'),
        bulletPoints: [
          LString('Hypotension (PAS < 90 mmHg)', 'Hypotension (PAS < 90 mmHg)'),
          LString('Altération de la conscience', 'Altération de la conscience'),
          LString('Douleur thoracique ischémique', 'Douleur thoracique ischémique'),
          LString('Insuffisance cardiaque aiguë', 'Insuffisance cardiaque aiguë'),
        ],
        warning: LString('Patient instable = cardioversion/pacing en urgence', 'Patient instable = cardioversion/pacing en urgence'),
      ),
      ProtocolStep(
        title: LString('2. Tachycardie instable', '2. Tachycardie instable'),
        content: LString('Cardioversion électrique synchronisée.', 'Cardioversion électrique synchronisée.'),
        bulletPoints: [
          LString('Sédation rapide (midazolam, étomidate, kétamine)', 'Sédation rapide (midazolam, étomidate, kétamine)'),
          LString('Mode synchrone obligatoire (sauf FV)', 'Mode synchrone obligatoire (sauf FV)'),
          LString('QRS fin: 70-120J biphasique', 'QRS fin: 70-120J biphasique'),
          LString('QRS large: 120-150J biphasique', 'QRS large: 120-150J biphasique'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Tachycardie régulière à QRS fins (stable)', '3. Tachycardie régulière à QRS fins (stable)'),
        content: LString('Manœuvres vagales puis adénosine.', 'Manœuvres vagales puis adénosine.'),
        bulletPoints: [
          LString('Manœuvres vagales (Valsalva modifié)', 'Manœuvres vagales (Valsalva modifié)'),
          LString('Adénosine 6 mg IVD rapide puis 12 mg si échec', 'Adénosine 6 mg IVD rapide puis 12 mg si échec'),
          LString('Si FA: contrôle fréquence ou cardioversion selon durée', 'Si FA: contrôle fréquence ou cardioversion selon durée'),
        ],
        tip: LString('Valsalva modifié: expiration forcée puis lever les jambes', 'Valsalva modifié: expiration forcée puis lever les jambes'),
      ),
      ProtocolStep(
        title: LString('4. Tachycardie régulière à QRS larges (stable)', '4. Tachycardie régulière à QRS larges (stable)'),
        content: LString('Traiter comme TV jusqu\'à preuve du contraire.', 'Traiter comme TV jusqu\'à preuve du contraire.'),
        bulletPoints: [
          LString('Amiodarone 300 mg IV en 20-60 min', 'Amiodarone 300 mg IV en 20-60 min'),
          LString('Si TV confirmée: alternatives selon étiologie', 'Si TV confirmée: alternatives selon étiologie'),
          LString('Ne jamais utiliser vérapamil si doute', 'Ne jamais utiliser vérapamil si doute'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Bradycardie instable', '5. Bradycardie instable'),
        content: LString('Stimulation cardiaque.', 'Stimulation cardiaque.'),
        bulletPoints: [
          LString('Atropine 0.5-1 mg IV (max 3 mg)', 'Atropine 0.5-1 mg IV (max 3 mg)'),
          LString('Si échec: adrénaline IV 2-10 µg/min', 'Si échec: adrénaline IV 2-10 µg/min'),
          LString('Pacing externe transcutané', 'Pacing externe transcutané'),
          LString('Pacing transveneux si échec', 'Pacing transveneux si échec'),
        ],
        warning: LString('Atropine inefficace si bloc infra-nodal ou cœur transplanté', 'Atropine inefficace si bloc infra-nodal ou cœur transplanté'),
      ),
    ],
    keyPoints: LString('Instable = choc électrique ou pacing. Stable = traitement médicamenteux selon le type.', 'Instable = choc électrique ou pacing. Stable = traitement médicamenteux selon le type.'),
    source: LString('ERC Guidelines 2021 - Arythmies péri-arrêt', 'ERC Guidelines 2021 - Arythmies péri-arrêt'),
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
    name: LString('Asthme Aigu Grave', 'Asthme Aigu Grave'),
    category: ProtocolCategory.respiratory,
    description: LString('Exacerbation sévère d\'asthme mettant en jeu le pronostic vital', 'Exacerbation sévère d\'asthme mettant en jeu le pronostic vital'),
    indication: LString('DEP < 50%, impossibilité de parler, FR > 25, FC > 110, SpO2 < 92%', 'DEP < 50%, impossibilité de parler, FR > 25, FC > 110, SpO2 < 92%'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation de la sévérité', '1. Évaluation de la sévérité'),
        content: LString('Identifier les critères de gravité.', 'Identifier les critères de gravité.'),
        bulletPoints: [
          LString('DEP < 50% valeur théorique = AAG', 'DEP < 50% valeur théorique = AAG'),
          LString('DEP < 33% ou inatteignable = asthme aigu très grave', 'DEP < 33% ou inatteignable = asthme aigu très grave'),
          LString('Signes de lutte, cyanose, silence auscultatoire', 'Signes de lutte, cyanose, silence auscultatoire'),
          LString('Troubles de conscience, bradycardie = arrêt imminent', 'Troubles de conscience, bradycardie = arrêt imminent'),
        ],
        warning: LString('Patient épuisé = alerte maximale, préparer intubation', 'Patient épuisé = alerte maximale, préparer intubation'),
      ),
      ProtocolStep(
        title: LString('2. Oxygénothérapie et bronchodilatateurs', '2. Oxygénothérapie et bronchodilatateurs'),
        content: LString('Traitement de première ligne.', 'Traitement de première ligne.'),
        bulletPoints: [
          LString('O2 pour SpO2 93-95%', 'O2 pour SpO2 93-95%'),
          LString('Salbutamol nébulisé 5 mg / 20 min x3 puis toutes les heures', 'Salbutamol nébulisé 5 mg / 20 min x3 puis toutes les heures'),
          LString('ou Salbutamol aérosol-doseur 4-10 bouffées avec chambre', 'ou Salbutamol aérosol-doseur 4-10 bouffées avec chambre'),
          LString('Ipratropium 0.5 mg nébulisé (ajouté au salbutamol)', 'Ipratropium 0.5 mg nébulisé (ajouté au salbutamol)'),
        ],
        tip: LString('Nébulisation à l\'O2 6-8 L/min', 'Nébulisation à l\'O2 6-8 L/min'),
      ),
      ProtocolStep(
        title: LString('3. Corticothérapie', '3. Corticothérapie'),
        content: LString('Systémique précoce.', 'Systémique précoce.'),
        bulletPoints: [
          LString('Méthylprednisolone 1-2 mg/kg IV', 'Méthylprednisolone 1-2 mg/kg IV'),
          LString('ou Prednisone 1 mg/kg PO si patient peut avaler', 'ou Prednisone 1 mg/kg PO si patient peut avaler'),
          LString('Effet en 4-6 heures', 'Effet en 4-6 heures'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Si échec ou asthme très grave', '4. Si échec ou asthme très grave'),
        content: LString('Escalade thérapeutique.', 'Escalade thérapeutique.'),
        bulletPoints: [
          LString('Sulfate de magnésium 2g IV en 20 min', 'Sulfate de magnésium 2g IV en 20 min'),
          LString('Salbutamol IV: 0.1-0.2 µg/kg/min IVSE', 'Salbutamol IV: 0.1-0.2 µg/kg/min IVSE'),
          LString('VNI si coopérant (attention auto-PEP)', 'VNI si coopérant (attention auto-PEP)'),
          LString('Adrénaline 0.5 mg IM si anaphylaxie associée', 'Adrénaline 0.5 mg IM si anaphylaxie associée'),
        ],
        warning: LString('Salbutamol IV = surveillance scope continue (hypokaliémie, arythmies)', 'Salbutamol IV = surveillance scope continue (hypokaliémie, arythmies)'),
      ),
      ProtocolStep(
        title: LString('5. Intubation si nécessaire', '5. Intubation si nécessaire'),
        content: LString('Indication: épuisement, trouble conscience, arrêt.', 'Indication: épuisement, trouble conscience, arrêt.'),
        bulletPoints: [
          LString('ISR avec kétamine (bronchodilatatrice)', 'ISR avec kétamine (bronchodilatatrice)'),
          LString('Ventilation: FR basse (10-12), I/E 1:4-5', 'Ventilation: FR basse (10-12), I/E 1:4-5'),
          LString('Tolérer hypercapnie permissive', 'Tolérer hypercapnie permissive'),
          LString('Attention au barotraumatisme', 'Attention au barotraumatisme'),
        ],
        warning: LString('L\'intubation peut précipiter l\'arrêt, préparer adrénaline', 'L\'intubation peut précipiter l\'arrêt, préparer adrénaline'),
      ),
    ],
    keyPoints: LString('Bronchodilatateurs + O2 + corticoïdes précoces. Magnésium si sévère. Intubation = dernier recours.', 'Bronchodilatateurs + O2 + corticoïdes précoces. Magnésium si sévère. Intubation = dernier recours.'),
    source: LString('GINA 2023, SFMU', 'GINA 2023, SFMU'),
    sourceUrl: 'https://ginasthma.org',
    lastUpdated: 2023,
  ),

  // BPCO décompensée
  Protocol(
    id: 'bpco-decompensee',
    name: LString('Exacerbation BPCO', 'Exacerbation BPCO'),
    category: ProtocolCategory.respiratory,
    description: LString('Décompensation aiguë de BPCO', 'Décompensation aiguë de BPCO'),
    indication: LString('Majoration dyspnée, volume et/ou purulence des expectorations', 'Majoration dyspnée, volume et/ou purulence des expectorations'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation de la gravité', '1. Évaluation de la gravité'),
        content: LString('Stratifier le niveau de soins nécessaire.', 'Stratifier le niveau de soins nécessaire.'),
        bulletPoints: [
          LString('Détresse respiratoire aiguë', 'Détresse respiratoire aiguë'),
          LString('Altération conscience, cyanose', 'Altération conscience, cyanose'),
          LString('pH < 7.35, PaCO2 > 45 mmHg', 'pH < 7.35, PaCO2 > 45 mmHg'),
          LString('SpO2 < 88% sous O2', 'SpO2 < 88% sous O2'),
          LString('Comorbidités sévères', 'Comorbidités sévères'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Oxygénothérapie contrôlée', '2. Oxygénothérapie contrôlée'),
        content: LString('Objectif SpO2 88-92%.', 'Objectif SpO2 88-92%.'),
        bulletPoints: [
          LString('Commencer à 24-28% (lunettes 1-2 L/min)', 'Commencer à 24-28% (lunettes 1-2 L/min)'),
          LString('Titrer pour SpO2 88-92%', 'Titrer pour SpO2 88-92%'),
          LString('Gazométrie si SpO2 < 92% ou signes gravité', 'Gazométrie si SpO2 < 92% ou signes gravité'),
          LString('Éviter hyperoxie (risque hypercapnie)', 'Éviter hyperoxie (risque hypercapnie)'),
        ],
        warning: LString('SpO2 cible plus basse que population générale', 'SpO2 cible plus basse que population générale'),
      ),
      ProtocolStep(
        title: LString('3. Bronchodilatateurs', '3. Bronchodilatateurs'),
        content: LString('Traitement systématique.', 'Traitement systématique.'),
        bulletPoints: [
          LString('Salbutamol 2.5-5 mg nébulisé / 20 min x3', 'Salbutamol 2.5-5 mg nébulisé / 20 min x3'),
          LString('Ipratropium 0.5 mg ajouté aux nébulisations', 'Ipratropium 0.5 mg ajouté aux nébulisations'),
          LString('Puis espacement progressif selon réponse', 'Puis espacement progressif selon réponse'),
        ],
        tip: LString('Nébulisation à l\'air si possible (risque hypercapnie si O2)', 'Nébulisation à l\'air si possible (risque hypercapnie si O2)'),
      ),
      ProtocolStep(
        title: LString('4. Corticothérapie', '4. Corticothérapie'),
        content: LString('Cure courte systématique.', 'Cure courte systématique.'),
        bulletPoints: [
          LString('Prednisone 40 mg/j PO pendant 5 jours', 'Prednisone 40 mg/j PO pendant 5 jours'),
          LString('ou équivalent IV si voie orale impossible', 'ou équivalent IV si voie orale impossible'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Antibiothérapie', '5. Antibiothérapie'),
        content: LString('Si critères d\'infection.', 'Si critères d\'infection.'),
        bulletPoints: [
          LString('Indication: purulence + augmentation volume ou dyspnée', 'Indication: purulence + augmentation volume ou dyspnée'),
          LString('Amoxicilline-acide clavulanique 1g x3/j', 'Amoxicilline-acide clavulanique 1g x3/j'),
          LString('ou Pristinamycine si allergie', 'ou Pristinamycine si allergie'),
          LString('Durée 5 jours', 'Durée 5 jours'),
        ],
      ),
      ProtocolStep(
        title: LString('6. VNI', '6. VNI'),
        content: LString('Si acidose respiratoire.', 'Si acidose respiratoire.'),
        bulletPoints: [
          LString('Indication: pH < 7.35 avec PaCO2 > 45 mmHg', 'Indication: pH < 7.35 avec PaCO2 > 45 mmHg'),
          LString('BiPAP: IPAP 10-20, EPAP 4-8 cmH2O', 'BiPAP: IPAP 10-20, EPAP 4-8 cmH2O'),
          LString('Réévaluation gazométrie à H1-H2', 'Réévaluation gazométrie à H1-H2'),
          LString('Réduction intubation et mortalité', 'Réduction intubation et mortalité'),
        ],
        warning: LString('CI si coma, arrêt immine, vomissements actifs', 'CI si coma, arrêt immine, vomissements actifs'),
      ),
    ],
    keyPoints: LString('O2 contrôlé (88-92%) + bronchodilatateurs + corticoïdes. VNI si acidose respiratoire.', 'O2 contrôlé (88-92%) + bronchodilatateurs + corticoïdes. VNI si acidose respiratoire.'),
    source: LString('GOLD 2024, SPLF', 'GOLD 2024, SPLF'),
    sourceUrl: 'https://goldcopd.org',
    lastUpdated: 2024,
  ),

  // Pneumothorax
  Protocol(
    id: 'pneumothorax',
    name: LString('Pneumothorax', 'Pneumothorax'),
    category: ProtocolCategory.respiratory,
    description: LString('Prise en charge du pneumothorax spontané et traumatique', 'Prise en charge du pneumothorax spontané et traumatique'),
    indication: LString('Douleur thoracique brutale, dyspnée, asymétrie auscultatoire', 'Douleur thoracique brutale, dyspnée, asymétrie auscultatoire'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation clinique', '1. Évaluation clinique'),
        content: LString('Identifier le type et la gravité.', 'Identifier le type et la gravité.'),
        bulletPoints: [
          LString('Primaire: patient jeune, pas de pathologie pulmonaire', 'Primaire: patient jeune, pas de pathologie pulmonaire'),
          LString('Secondaire: BPCO, mucoviscidose, pathologie sous-jacente', 'Secondaire: BPCO, mucoviscidose, pathologie sous-jacente'),
          LString('Traumatique: contexte évocateur', 'Traumatique: contexte évocateur'),
          LString('Compressif: urgence vitale (déviation trachée, détresse)', 'Compressif: urgence vitale (déviation trachée, détresse)'),
        ],
        warning: LString('Pneumothorax compressif = exsufflation immédiate AVANT radio', 'Pneumothorax compressif = exsufflation immédiate AVANT radio'),
      ),
      ProtocolStep(
        title: LString('2. Pneumothorax compressif', '2. Pneumothorax compressif'),
        content: LString('Exsufflation à l\'aiguille en urgence.', 'Exsufflation à l\'aiguille en urgence.'),
        bulletPoints: [
          LString('2ème espace intercostal, ligne médio-claviculaire', '2ème espace intercostal, ligne médio-claviculaire'),
          LString('Cathéter 14-16G, aiguille perpendiculaire', 'Cathéter 14-16G, aiguille perpendiculaire'),
          LString('Bruit de souffle = confirmation', 'Bruit de souffle = confirmation'),
          LString('Puis drainage thoracique', 'Puis drainage thoracique'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Pneumothorax primaire', '3. Pneumothorax primaire'),
        content: LString('Stratégie selon taille et symptômes.', 'Stratégie selon taille et symptômes.'),
        bulletPoints: [
          LString('< 2 cm et asymptomatique: observation, contrôle radio', '< 2 cm et asymptomatique: observation, contrôle radio'),
          LString('> 2 cm ou symptomatique: exsufflation à l\'aiguille', '> 2 cm ou symptomatique: exsufflation à l\'aiguille'),
          LString('Si échec exsufflation: drainage thoracique', 'Si échec exsufflation: drainage thoracique'),
        ],
        tip: LString('Mesure à 2 cm du sommet sur la ligne médio-claviculaire', 'Mesure à 2 cm du sommet sur la ligne médio-claviculaire'),
      ),
      ProtocolStep(
        title: LString('4. Pneumothorax secondaire', '4. Pneumothorax secondaire'),
        content: LString('Drainage plus souvent nécessaire.', 'Drainage plus souvent nécessaire.'),
        bulletPoints: [
          LString('Hospitalisation systématique', 'Hospitalisation systématique'),
          LString('Drainage si > 1 cm ou symptomatique', 'Drainage si > 1 cm ou symptomatique'),
          LString('Calibre drain adapté (20-24 Fr)', 'Calibre drain adapté (20-24 Fr)'),
          LString('Aspiration -10 à -20 cmH2O si persistance', 'Aspiration -10 à -20 cmH2O si persistance'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Technique de drainage', '5. Technique de drainage'),
        content: LString('Triangle de sécurité.', 'Triangle de sécurité.'),
        bulletPoints: [
          LString('Zone: 4-5ème EIC, ligne axillaire moyenne', 'Zone: 4-5ème EIC, ligne axillaire moyenne'),
          LString('Anesthésie locale jusqu\'à plèvre', 'Anesthésie locale jusqu\'à plèvre'),
          LString('Incision, dissection mousse, pénétration digitale', 'Incision, dissection mousse, pénétration digitale'),
          LString('Drain dirigé vers apex', 'Drain dirigé vers apex'),
          LString('Fixation et connexion système aspiratif', 'Fixation et connexion système aspiratif'),
        ],
      ),
    ],
    keyPoints: LString('Compressif = exsufflation immédiate. Primaire: selon taille. Secondaire: drainage plus large.', 'Compressif = exsufflation immédiate. Primaire: selon taille. Secondaire: drainage plus large.'),
    source: LString('BTS Guidelines 2023', 'BTS Guidelines 2023'),
    sourceUrl: 'https://www.brit-thoracic.org.uk',
    lastUpdated: 2023,
  ),

  // Embolie pulmonaire
  Protocol(
    id: 'ep',
    name: LString('Embolie Pulmonaire', 'Embolie Pulmonaire'),
    category: ProtocolCategory.respiratory,
    description: LString('Diagnostic et traitement de l\'embolie pulmonaire', 'Diagnostic et traitement de l\'embolie pulmonaire'),
    indication: LString('Dyspnée brutale, douleur thoracique, facteurs de risque thrombo-embolique', 'Dyspnée brutale, douleur thoracique, facteurs de risque thrombo-embolique'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation probabilité clinique', '1. Évaluation probabilité clinique'),
        content: LString('Score de Wells ou Genève.', 'Score de Wells ou Genève.'),
        bulletPoints: [
          LString('Wells: ATCD TVP/EP, FC>100, immobilisation/chirurgie récente', 'Wells: ATCD TVP/EP, FC>100, immobilisation/chirurgie récente'),
          LString('Hémoptysie, cancer, signes TVP', 'Hémoptysie, cancer, signes TVP'),
          LString('Probabilité faible/intermédiaire/forte', 'Probabilité faible/intermédiaire/forte'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Stratégie diagnostique', '2. Stratégie diagnostique'),
        content: LString('Selon probabilité clinique.', 'Selon probabilité clinique.'),
        bulletPoints: [
          LString('Probabilité faible/intermédiaire: D-dimères d\'abord', 'Probabilité faible/intermédiaire: D-dimères d\'abord'),
          LString('D-dimères négatifs (seuil ajusté âge): EP exclue', 'D-dimères négatifs (seuil ajusté âge): EP exclue'),
          LString('D-dimères positifs ou proba forte: angioscanner', 'D-dimères positifs ou proba forte: angioscanner'),
          LString('Si CI scanner: scintigraphie V/Q', 'Si CI scanner: scintigraphie V/Q'),
        ],
        tip: LString('Seuil D-dimères ajusté: âge x 10 µg/L si > 50 ans', 'Seuil D-dimères ajusté: âge x 10 µg/L si > 50 ans'),
      ),
      ProtocolStep(
        title: LString('3. Évaluation gravité', '3. Évaluation gravité'),
        content: LString('Stratification pronostique.', 'Stratification pronostique.'),
        bulletPoints: [
          LString('Haut risque: instabilité HD (PAS < 90 ou chute > 40 mmHg)', 'Haut risque: instabilité HD (PAS < 90 ou chute > 40 mmHg)'),
          LString('Risque intermédiaire: PESI ≥ III + dilatation VD + troponine +', 'Risque intermédiaire: PESI ≥ III + dilatation VD + troponine +'),
          LString('Bas risque: PESI I-II', 'Bas risque: PESI I-II'),
        ],
      ),
      ProtocolStep(
        title: LString('4. EP à haut risque (massive)', '4. EP à haut risque (massive)'),
        content: LString('Traitement urgent.', 'Traitement urgent.'),
        bulletPoints: [
          LString('Anticoagulation: HNF bolus + IVSE', 'Anticoagulation: HNF bolus + IVSE'),
          LString('Thrombolyse: Alteplase 100 mg/2h ou 0.6 mg/kg/15 min si ACR', 'Thrombolyse: Alteplase 100 mg/2h ou 0.6 mg/kg/15 min si ACR'),
          LString('Support hémodynamique: remplissage prudent, noradrénaline', 'Support hémodynamique: remplissage prudent, noradrénaline'),
          LString('Embolectomie/ECMO si CI thrombolyse ou échec', 'Embolectomie/ECMO si CI thrombolyse ou échec'),
        ],
        warning: LString('Remplissage limité < 500 mL (éviter surcharge VD)', 'Remplissage limité < 500 mL (éviter surcharge VD)'),
      ),
      ProtocolStep(
        title: LString('5. EP non à haut risque', '5. EP non à haut risque'),
        content: LString('Anticoagulation standard.', 'Anticoagulation standard.'),
        bulletPoints: [
          LString('AOD en première intention (rivaroxaban, apixaban)', 'AOD en première intention (rivaroxaban, apixaban)'),
          LString('ou HBPM puis AVK', 'ou HBPM puis AVK'),
          LString('Durée: 3 mois si facteur déclenchant transitoire', 'Durée: 3 mois si facteur déclenchant transitoire'),
          LString('≥ 6 mois si idiopathique ou cancer', '≥ 6 mois si idiopathique ou cancer'),
        ],
      ),
    ],
    keyPoints: LString('Probabilité clinique → D-dimères ou scanner direct. Haut risque = thrombolyse. AOD si stable.', 'Probabilité clinique → D-dimères ou scanner direct. Haut risque = thrombolyse. AOD si stable.'),
    source: LString('ESC Guidelines 2019 - Embolie Pulmonaire', 'ESC Guidelines 2019 - Embolie Pulmonaire'),
    sourceUrl: 'https://www.escardio.org',
    lastUpdated: 2019,
  ),

  // Détresse respiratoire aiguë
  Protocol(
    id: 'dra',
    name: LString('Détresse Respiratoire Aiguë', 'Détresse Respiratoire Aiguë'),
    category: ProtocolCategory.respiratory,
    description: LString('Approche diagnostique et thérapeutique de la détresse respiratoire', 'Approche diagnostique et thérapeutique de la détresse respiratoire'),
    indication: LString('FR > 25/min, signes de lutte, SpO2 < 92%, cyanose', 'FR > 25/min, signes de lutte, SpO2 < 92%, cyanose'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation immédiate', '1. Évaluation immédiate'),
        content: LString('ABC et stabilisation.', 'ABC et stabilisation.'),
        bulletPoints: [
          LString('Position adaptée (assis si OAP, décubitus si trauma)', 'Position adaptée (assis si OAP, décubitus si trauma)'),
          LString('Oxygénothérapie haut débit initial', 'Oxygénothérapie haut débit initial'),
          LString('Voie veineuse périphérique', 'Voie veineuse périphérique'),
          LString('Monitoring: SpO2, ECG, PA', 'Monitoring: SpO2, ECG, PA'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Orientation diagnostique', '2. Orientation diagnostique'),
        content: LString('Examen clinique ciblé.', 'Examen clinique ciblé.'),
        bulletPoints: [
          LString('Stridor inspiratoire: obstruction haute', 'Stridor inspiratoire: obstruction haute'),
          LString('Wheezing: bronchospasme (asthme, BPCO)', 'Wheezing: bronchospasme (asthme, BPCO)'),
          LString('Crépitants bilatéraux: OAP, pneumopathie, SDRA', 'Crépitants bilatéraux: OAP, pneumopathie, SDRA'),
          LString('Asymétrie auscultatoire: pneumothorax, épanchement', 'Asymétrie auscultatoire: pneumothorax, épanchement'),
          LString('Signes de TVP: embolie pulmonaire', 'Signes de TVP: embolie pulmonaire'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Examens complémentaires', '3. Examens complémentaires'),
        content: LString('Bilan adapté au contexte.', 'Bilan adapté au contexte.'),
        bulletPoints: [
          LString('Gazométrie artérielle', 'Gazométrie artérielle'),
          LString('Radio thorax', 'Radio thorax'),
          LString('ECG, troponine, BNP si cardiaque suspecté', 'ECG, troponine, BNP si cardiaque suspecté'),
          LString('D-dimères si EP suspectée', 'D-dimères si EP suspectée'),
          LString('Angioscanner si EP probable', 'Angioscanner si EP probable'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Oxygénothérapie avancée', '4. Oxygénothérapie avancée'),
        content: LString('Escalade selon réponse.', 'Escalade selon réponse.'),
        bulletPoints: [
          LString('Lunettes/masque: objectif SpO2 selon pathologie', 'Lunettes/masque: objectif SpO2 selon pathologie'),
          LString('Optiflow (HFNC): 30-60 L/min, FiO2 ajustée', 'Optiflow (HFNC): 30-60 L/min, FiO2 ajustée'),
          LString('VNI: CPAP ou BiPAP selon indication', 'VNI: CPAP ou BiPAP selon indication'),
          LString('Intubation si échec ou contre-indication VNI', 'Intubation si échec ou contre-indication VNI'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Critères d\'intubation', '5. Critères d\'intubation'),
        content: LString('Ne pas retarder si indication claire.', 'Ne pas retarder si indication claire.'),
        bulletPoints: [
          LString('Arrêt respiratoire ou imminence', 'Arrêt respiratoire ou imminence'),
          LString('Trouble de conscience (GCS < 8)', 'Trouble de conscience (GCS < 8)'),
          LString('Épuisement respiratoire', 'Épuisement respiratoire'),
          LString('Échec VNI avec aggravation', 'Échec VNI avec aggravation'),
          LString('Instabilité hémodynamique sévère', 'Instabilité hémodynamique sévère'),
        ],
      ),
    ],
    keyPoints: LString('Stabiliser d\'abord, diagnostiquer ensuite. Adapter l\'O2 à la pathologie. Ne pas retarder l\'IOT.', 'Stabiliser d\'abord, diagnostiquer ensuite. Adapter l\'O2 à la pathologie. Ne pas retarder l\'IOT.'),
    source: LString('SFMU - Détresse respiratoire', 'SFMU - Détresse respiratoire'),
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
    name: LString('AVC Ischémique', 'AVC Ischémique'),
    category: ProtocolCategory.neurology,
    description: LString('Accident vasculaire cérébral ischémique - thrombolyse et thrombectomie', 'Accident vasculaire cérébral ischémique - thrombolyse et thrombectomie'),
    indication: LString('Déficit neurologique focal brutal évocateur d\'AVC', 'Déficit neurologique focal brutal évocateur d\'AVC'),
    contraindication: LString('Voir CI thrombolyse', 'Voir CI thrombolyse'),
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance et alerte', '1. Reconnaissance et alerte'),
        content: LString('Identifier l\'AVC et noter l\'heure de début.', 'Identifier l\'AVC et noter l\'heure de début.'),
        bulletPoints: [
          LString('FAST: Face, Arm, Speech, Time', 'FAST: Face, Arm, Speech, Time'),
          LString('Heure du dernier moment vu normal (DLMN)', 'Heure du dernier moment vu normal (DLMN)'),
          LString('Alerte UNV (Unité Neuro-Vasculaire)', 'Alerte UNV (Unité Neuro-Vasculaire)'),
          LString('Glycémie capillaire immédiate', 'Glycémie capillaire immédiate'),
        ],
        warning: LString('Chaque minute perdue = 1.9 million neurones détruits', 'Chaque minute perdue = 1.9 million neurones détruits'),
      ),
      ProtocolStep(
        title: LString('2. Imagerie cérébrale', '2. Imagerie cérébrale'),
        content: LString('Scanner ou IRM en urgence.', 'Scanner ou IRM en urgence.'),
        bulletPoints: [
          LString('Scanner sans injection: éliminer hémorragie', 'Scanner sans injection: éliminer hémorragie'),
          LString('IRM si disponible rapidement (diffusion)', 'IRM si disponible rapidement (diffusion)'),
          LString('Angioscanner/ARM si thrombectomie envisagée', 'Angioscanner/ARM si thrombectomie envisagée'),
          LString('Objectif: porte-imagerie < 25 min', 'Objectif: porte-imagerie < 25 min'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Évaluation clinique', '3. Évaluation clinique'),
        content: LString('Score NIHSS.', 'Score NIHSS.'),
        bulletPoints: [
          LString('NIHSS: quantifier le déficit (0-42)', 'NIHSS: quantifier le déficit (0-42)'),
          LString('NIHSS ≥ 6: occlusion proximale probable', 'NIHSS ≥ 6: occlusion proximale probable'),
          LString('Vérifier contre-indications thrombolyse', 'Vérifier contre-indications thrombolyse'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Thrombolyse IV', '4. Thrombolyse IV'),
        content: LString('Si éligible dans les délais.', 'Si éligible dans les délais.'),
        bulletPoints: [
          LString('Alteplase 0.9 mg/kg (max 90 mg)', 'Alteplase 0.9 mg/kg (max 90 mg)'),
          LString('10% en bolus, 90% en 1h', '10% en bolus, 90% en 1h'),
          LString('Délai < 4h30 du DLMN', 'Délai < 4h30 du DLMN'),
          LString('PA < 185/110 avant et < 180/105 après', 'PA < 185/110 avant et < 180/105 après'),
          LString('Surveillance neurologique rapprochée', 'Surveillance neurologique rapprochée'),
        ],
        warning: LString('CI absolues: hémorragie cérébrale, chirurgie récente, saignement actif', 'CI absolues: hémorragie cérébrale, chirurgie récente, saignement actif'),
      ),
      ProtocolStep(
        title: LString('5. Thrombectomie mécanique', '5. Thrombectomie mécanique'),
        content: LString('Si occlusion proximale.', 'Si occlusion proximale.'),
        bulletPoints: [
          LString('Indication: occlusion artère proximale (carotide, M1, basilaire)', 'Indication: occlusion artère proximale (carotide, M1, basilaire)'),
          LString('Délai jusqu\'à 6h (voire 24h si mismatch)', 'Délai jusqu\'à 6h (voire 24h si mismatch)'),
          LString('En complément ou alternative à thrombolyse', 'En complément ou alternative à thrombolyse'),
          LString('Transfert centre de neuroradiologie interventionnelle', 'Transfert centre de neuroradiologie interventionnelle'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Soins de support', '6. Soins de support'),
        content: LString('Mesures générales.', 'Mesures générales.'),
        bulletPoints: [
          LString('Position tête à 30° si HTIC, sinon à plat', 'Position tête à 30° si HTIC, sinon à plat'),
          LString('O2 si SpO2 < 94%', 'O2 si SpO2 < 94%'),
          LString('Contrôle glycémique (éviter hypo/hyperglycémie)', 'Contrôle glycémique (éviter hypo/hyperglycémie)'),
          LString('Antiagrégant: aspirine 160-300 mg après imagerie', 'Antiagrégant: aspirine 160-300 mg après imagerie'),
          LString('Prévention complications: TVP, pneumopathie', 'Prévention complications: TVP, pneumopathie'),
        ],
      ),
    ],
    keyPoints: LString('Time is brain. DLMN crucial. Thrombolyse < 4h30. Thrombectomie si occlusion proximale.', 'Time is brain. DLMN crucial. Thrombolyse < 4h30. Thrombectomie si occlusion proximale.'),
    source: LString('ESO Guidelines 2021, HAS', 'ESO Guidelines 2021, HAS'),
    sourceUrl: 'https://eso-stroke.org',
    lastUpdated: 2021,
  ),

  // AVC hémorragique
  Protocol(
    id: 'avc-hemorragique',
    name: LString('AVC Hémorragique', 'AVC Hémorragique'),
    category: ProtocolCategory.neurology,
    description: LString('Hémorragie intracérébrale spontanée', 'Hémorragie intracérébrale spontanée'),
    indication: LString('Déficit neurologique brutal avec hémorragie au scanner', 'Déficit neurologique brutal avec hémorragie au scanner'),
    steps: [
      ProtocolStep(
        title: LString('1. Diagnostic', '1. Diagnostic'),
        content: LString('Confirmer l\'hémorragie et évaluer la gravité.', 'Confirmer l\'hémorragie et évaluer la gravité.'),
        bulletPoints: [
          LString('Scanner cérébral sans injection', 'Scanner cérébral sans injection'),
          LString('Volume hématome (formule ABC/2)', 'Volume hématome (formule ABC/2)'),
          LString('Score ICH pour pronostic', 'Score ICH pour pronostic'),
          LString('Rechercher engagement', 'Rechercher engagement'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Contrôle de la pression artérielle', '2. Contrôle de la pression artérielle'),
        content: LString('Objectif tensionnel adapté.', 'Objectif tensionnel adapté.'),
        bulletPoints: [
          LString('Si PAS 150-220: cible < 140 mmHg (sûr)', 'Si PAS 150-220: cible < 140 mmHg (sûr)'),
          LString('Si PAS > 220: réduction progressive', 'Si PAS > 220: réduction progressive'),
          LString('Nicardipine IVSE ou Urapidil', 'Nicardipine IVSE ou Urapidil'),
          LString('Éviter chute brutale de PA', 'Éviter chute brutale de PA'),
        ],
        tip: LString('Réduction PA limite expansion hématome', 'Réduction PA limite expansion hématome'),
      ),
      ProtocolStep(
        title: LString('3. Réversion anticoagulation', '3. Réversion anticoagulation'),
        content: LString('Si patient sous anticoagulant.', 'Si patient sous anticoagulant.'),
        bulletPoints: [
          LString('AVK: Vitamine K 10 mg IV + CCP (25-50 UI/kg)', 'AVK: Vitamine K 10 mg IV + CCP (25-50 UI/kg)'),
          LString('Dabigatran: Idarucizumab 5g IV', 'Dabigatran: Idarucizumab 5g IV'),
          LString('Anti-Xa (rivaroxaban, apixaban): Andexanet si disponible, sinon CCP', 'Anti-Xa (rivaroxaban, apixaban): Andexanet si disponible, sinon CCP'),
          LString('Héparine: Protamine', 'Héparine: Protamine'),
          LString('Objectif INR < 1.3 en < 4h', 'Objectif INR < 1.3 en < 4h'),
        ],
        warning: LString('Urgence vitale - reverser sans attendre les résultats', 'Urgence vitale - reverser sans attendre les résultats'),
      ),
      ProtocolStep(
        title: LString('4. Prise en charge HTIC', '4. Prise en charge HTIC'),
        content: LString('Si signes d\'hypertension intracrânienne.', 'Si signes d\'hypertension intracrânienne.'),
        bulletPoints: [
          LString('Tête à 30°', 'Tête à 30°'),
          LString('Mannitol 20% 0.5-1 g/kg ou SSH 7.5%', 'Mannitol 20% 0.5-1 g/kg ou SSH 7.5%'),
          LString('Intubation si GCS < 8', 'Intubation si GCS < 8'),
          LString('Objectif PPC > 60 mmHg', 'Objectif PPC > 60 mmHg'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Indication chirurgicale', '5. Indication chirurgicale'),
        content: LString('Discussion neurochirurgicale.', 'Discussion neurochirurgicale.'),
        bulletPoints: [
          LString('Hématome cérébelleux > 3 cm avec dégradation', 'Hématome cérébelleux > 3 cm avec dégradation'),
          LString('Hydrocéphalie (DVE)', 'Hydrocéphalie (DVE)'),
          LString('Hématome lobaire > 30 mL près surface', 'Hématome lobaire > 30 mL près surface'),
          LString('Évacuation rarement bénéfique pour hématomes profonds', 'Évacuation rarement bénéfique pour hématomes profonds'),
        ],
      ),
    ],
    keyPoints: LString('Contrôle PA précoce. Reverser anticoagulation immédiatement. Avis neurochirurgical.', 'Contrôle PA précoce. Reverser anticoagulation immédiatement. Avis neurochirurgical.'),
    source: LString('AHA/ASA Guidelines 2022', 'AHA/ASA Guidelines 2022'),
    lastUpdated: 2022,
  ),

  // État de mal épileptique
  Protocol(
    id: 'eme',
    name: LString('État de Mal Épileptique', 'État de Mal Épileptique'),
    category: ProtocolCategory.neurology,
    description: LString('Crise convulsive prolongée ou répétée sans récupération', 'Crise convulsive prolongée ou répétée sans récupération'),
    indication: LString('Crise > 5 min ou crises répétées sans retour conscience', 'Crise > 5 min ou crises répétées sans retour conscience'),
    steps: [
      ProtocolStep(
        title: LString('1. Phase initiale (0-5 min)', '1. Phase initiale (0-5 min)'),
        content: LString('Protection et évaluation.', 'Protection et évaluation.'),
        bulletPoints: [
          LString('Protection: retirer obstacles, PLS si possible', 'Protection: retirer obstacles, PLS si possible'),
          LString('Chronométrer la crise', 'Chronométrer la crise'),
          LString('Glycémie capillaire', 'Glycémie capillaire'),
          LString('Voie veineuse périphérique', 'Voie veineuse périphérique'),
          LString('O2 si SpO2 < 94%', 'O2 si SpO2 < 94%'),
        ],
        warning: LString('Ne rien mettre dans la bouche', 'Ne rien mettre dans la bouche'),
      ),
      ProtocolStep(
        title: LString('2. Phase précoce (5-20 min)', '2. Phase précoce (5-20 min)'),
        content: LString('Benzodiazépines.', 'Benzodiazépines.'),
        bulletPoints: [
          LString('Clonazépam 1 mg IV (0.015 mg/kg)', 'Clonazépam 1 mg IV (0.015 mg/kg)'),
          LString('ou Diazépam 10 mg IV ou IR (0.2-0.3 mg/kg)', 'ou Diazépam 10 mg IV ou IR (0.2-0.3 mg/kg)'),
          LString('ou Midazolam 10 mg IM si pas d\'accès IV', 'ou Midazolam 10 mg IM si pas d\'accès IV'),
          LString('Répéter une fois à 5 min si échec', 'Répéter une fois à 5 min si échec'),
        ],
        tip: LString('Midazolam IM aussi efficace que diazépam IV', 'Midazolam IM aussi efficace que diazépam IV'),
      ),
      ProtocolStep(
        title: LString('3. Phase établie (20-40 min)', '3. Phase établie (20-40 min)'),
        content: LString('Antiépileptiques de 2ème ligne.', 'Antiépileptiques de 2ème ligne.'),
        bulletPoints: [
          LString('Levetiracetam 60 mg/kg IV (max 4500 mg) en 10-15 min', 'Levetiracetam 60 mg/kg IV (max 4500 mg) en 10-15 min'),
          LString('ou Valproate 40 mg/kg IV (max 3000 mg) en 10 min', 'ou Valproate 40 mg/kg IV (max 3000 mg) en 10 min'),
          LString('ou Fosphénytoïne 20 mg EP/kg IV en 10-15 min', 'ou Fosphénytoïne 20 mg EP/kg IV en 10-15 min'),
          LString('CI valproate: hépatopathie, grossesse', 'CI valproate: hépatopathie, grossesse'),
          LString('CI fosphénytoïne: troubles conduction', 'CI fosphénytoïne: troubles conduction'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Phase réfractaire (> 40 min)', '4. Phase réfractaire (> 40 min)'),
        content: LString('Anesthésie générale.', 'Anesthésie générale.'),
        bulletPoints: [
          LString('Intubation et ventilation mécanique', 'Intubation et ventilation mécanique'),
          LString('Thiopental: bolus 2-3 mg/kg puis 3-5 mg/kg/h', 'Thiopental: bolus 2-3 mg/kg puis 3-5 mg/kg/h'),
          LString('ou Midazolam: bolus 0.2 mg/kg puis 0.1-0.4 mg/kg/h', 'ou Midazolam: bolus 0.2 mg/kg puis 0.1-0.4 mg/kg/h'),
          LString('ou Propofol: bolus 2 mg/kg puis 5-10 mg/kg/h', 'ou Propofol: bolus 2 mg/kg puis 5-10 mg/kg/h'),
          LString('Monitoring EEG continu', 'Monitoring EEG continu'),
        ],
        warning: LString('Propofol: risque syndrome de perfusion aux lipides', 'Propofol: risque syndrome de perfusion aux lipides'),
      ),
      ProtocolStep(
        title: LString('5. Recherche étiologique', '5. Recherche étiologique'),
        content: LString('Identifier et traiter la cause.', 'Identifier et traiter la cause.'),
        bulletPoints: [
          LString('Sevrage/intoxication alcool, benzodiazépines', 'Sevrage/intoxication alcool, benzodiazépines'),
          LString('Hypoglycémie (→ G30%)', 'Hypoglycémie (→ G30%)'),
          LString('Hyponatrémie (→ correction prudente)', 'Hyponatrémie (→ correction prudente)'),
          LString('Infection (→ PL si suspicion)', 'Infection (→ PL si suspicion)'),
          LString('AVC, tumeur, trauma (→ imagerie)', 'AVC, tumeur, trauma (→ imagerie)'),
        ],
      ),
    ],
    keyPoints: LString('Traiter tôt: BZD → Antiépileptique 2ème ligne → Anesthésie si réfractaire. Chercher cause.', 'Traiter tôt: BZD → Antiépileptique 2ème ligne → Anesthésie si réfractaire. Chercher cause.'),
    source: LString('SFMU 2018, Recommandations formalisées d\'experts', 'SFMU 2018, Recommandations formalisées d\'experts'),
    lastUpdated: 2018,
  ),

  // Coma
  Protocol(
    id: 'coma',
    name: LString('Coma - Évaluation et PEC', 'Coma - Évaluation et PEC'),
    category: ProtocolCategory.neurology,
    description: LString('Approche du patient comateux aux urgences', 'Approche du patient comateux aux urgences'),
    indication: LString('Altération de conscience avec GCS < 9', 'Altération de conscience avec GCS < 9'),
    steps: [
      ProtocolStep(
        title: LString('1. Stabilisation initiale', '1. Stabilisation initiale'),
        content: LString('ABC en priorité.', 'ABC en priorité.'),
        bulletPoints: [
          LString('Protection voies aériennes: PLS, aspiration, Guedel', 'Protection voies aériennes: PLS, aspiration, Guedel'),
          LString('Intubation si GCS ≤ 8 ou réflexes abolis', 'Intubation si GCS ≤ 8 ou réflexes abolis'),
          LString('Oxygénation', 'Oxygénation'),
          LString('Accès vasculaire, monitoring', 'Accès vasculaire, monitoring'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Évaluation neurologique', '2. Évaluation neurologique'),
        content: LString('Examen ciblé.', 'Examen ciblé.'),
        bulletPoints: [
          LString('Score de Glasgow: E + V + M', 'Score de Glasgow: E + V + M'),
          LString('Pupilles: taille, réactivité, anisocorie', 'Pupilles: taille, réactivité, anisocorie'),
          LString('Réflexes du tronc: cornéen, oculocéphalique', 'Réflexes du tronc: cornéen, oculocéphalique'),
          LString('Réponse motrice: localisation, décortication, décérébration', 'Réponse motrice: localisation, décortication, décérébration'),
          LString('Signes de latéralisation', 'Signes de latéralisation'),
        ],
        warning: LString('Anisocorie + coma = engagement jusqu\'à preuve du contraire', 'Anisocorie + coma = engagement jusqu\'à preuve du contraire'),
      ),
      ProtocolStep(
        title: LString('3. Causes métaboliques urgentes', '3. Causes métaboliques urgentes'),
        content: LString('À éliminer immédiatement.', 'À éliminer immédiatement.'),
        bulletPoints: [
          LString('Glycémie capillaire → si hypo: G30% 50 mL', 'Glycémie capillaire → si hypo: G30% 50 mL'),
          LString('Si éthylisme/dénutrition: Thiamine 500 mg IV AVANT glucose', 'Si éthylisme/dénutrition: Thiamine 500 mg IV AVANT glucose'),
          LString('Si suspicion opioïdes: Naloxone 0.4 mg IV (répétable)', 'Si suspicion opioïdes: Naloxone 0.4 mg IV (répétable)'),
          LString('Si suspicion BZD: Flumazénil 0.2 mg (CI si épilepsie)', 'Si suspicion BZD: Flumazénil 0.2 mg (CI si épilepsie)'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Orientation diagnostique', '4. Orientation diagnostique'),
        content: LString('Examens selon contexte.', 'Examens selon contexte.'),
        bulletPoints: [
          LString('Scanner cérébral sans injection (hémorragie, AVC, HTIC)', 'Scanner cérébral sans injection (hémorragie, AVC, HTIC)'),
          LString('Biologie: glycémie, iono, calcium, ammoniémie, toxiques', 'Biologie: glycémie, iono, calcium, ammoniémie, toxiques'),
          LString('PL si fièvre et scanner normal', 'PL si fièvre et scanner normal'),
          LString('EEG si suspicion état de mal non convulsif', 'EEG si suspicion état de mal non convulsif'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Étiologies principales', '5. Étiologies principales'),
        content: LString('Causes à évoquer.', 'Causes à évoquer.'),
        bulletPoints: [
          LString('Traumatique: hémorragie, contusion', 'Traumatique: hémorragie, contusion'),
          LString('Vasculaire: AVC, hémorragie méningée', 'Vasculaire: AVC, hémorragie méningée'),
          LString('Infectieux: méningite, encéphalite', 'Infectieux: méningite, encéphalite'),
          LString('Métabolique: hypo/hyperglycémie, dysnatrémie', 'Métabolique: hypo/hyperglycémie, dysnatrémie'),
          LString('Toxique: intoxication, sevrage', 'Toxique: intoxication, sevrage'),
          LString('Épileptique: post-critique, état de mal', 'Épileptique: post-critique, état de mal'),
        ],
      ),
    ],
    keyPoints: LString('ABC d\'abord. Glycémie + naloxone + thiamine si doute. Scanner précoce. Traiter la cause.', 'ABC d\'abord. Glycémie + naloxone + thiamine si doute. Scanner précoce. Traiter la cause.'),
    source: LString('SFMU', 'SFMU'),
    lastUpdated: 2020,
  ),

  // Méningite
  Protocol(
    id: 'meningite',
    name: LString('Méningite Bactérienne', 'Méningite Bactérienne'),
    category: ProtocolCategory.neurology,
    description: LString('Suspicion et prise en charge de méningite bactérienne', 'Suspicion et prise en charge de méningite bactérienne'),
    indication: LString('Syndrome méningé fébrile: céphalées, raideur de nuque, fièvre', 'Syndrome méningé fébrile: céphalées, raideur de nuque, fièvre'),
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Reconnaissance'),
        content: LString('Signes évocateurs.', 'Signes évocateurs.'),
        bulletPoints: [
          LString('Triade classique: fièvre, céphalées, raideur de nuque', 'Triade classique: fièvre, céphalées, raideur de nuque'),
          LString('Troubles conscience, confusion', 'Troubles conscience, confusion'),
          LString('Photophobie, vomissements', 'Photophobie, vomissements'),
          LString('Purpura → évoquer méningocoque', 'Purpura → évoquer méningocoque'),
        ],
        warning: LString('Purpura fébrile = antibiothérapie IMMÉDIATE avant tout', 'Purpura fébrile = antibiothérapie IMMÉDIATE avant tout'),
      ),
      ProtocolStep(
        title: LString('2. Purpura fulminans', '2. Purpura fulminans'),
        content: LString('Urgence absolue.', 'Urgence absolue.'),
        bulletPoints: [
          LString('Ceftriaxone 2g IV/IM IMMÉDIATEMENT (même préhospitalier)', 'Ceftriaxone 2g IV/IM IMMÉDIATEMENT (même préhospitalier)'),
          LString('Remplissage vasculaire', 'Remplissage vasculaire'),
          LString('Puis suite de la prise en charge', 'Puis suite de la prise en charge'),
          LString('Ne pas attendre les examens', 'Ne pas attendre les examens'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Imagerie avant PL', '3. Imagerie avant PL'),
        content: LString('Indications du scanner avant PL.', 'Indications du scanner avant PL.'),
        bulletPoints: [
          LString('Signes de focalisation neurologique', 'Signes de focalisation neurologique'),
          LString('Troubles de conscience (GCS < 11)', 'Troubles de conscience (GCS < 11)'),
          LString('Crises comitiales récentes', 'Crises comitiales récentes'),
          LString('Immunodépression sévère', 'Immunodépression sévère'),
          LString('Œdème papillaire', 'Œdème papillaire'),
        ],
        tip: LString('Si indication scanner: ATB avant scanner, PL après si normal', 'Si indication scanner: ATB avant scanner, PL après si normal'),
      ),
      ProtocolStep(
        title: LString('4. Ponction lombaire', '4. Ponction lombaire'),
        content: LString('Analyse du LCR.', 'Analyse du LCR.'),
        bulletPoints: [
          LString('Aspect macroscopique: trouble = bactérienne probable', 'Aspect macroscopique: trouble = bactérienne probable'),
          LString('Biochimie: protéinorachie, glycorachie (vs glycémie)', 'Biochimie: protéinorachie, glycorachie (vs glycémie)'),
          LString('Cytologie: pléiocytose à PNN', 'Cytologie: pléiocytose à PNN'),
          LString('Bactériologie: direct, culture, PCR', 'Bactériologie: direct, culture, PCR'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Antibiothérapie probabiliste', '5. Antibiothérapie probabiliste'),
        content: LString('Sans attendre résultats si suspicion forte.', 'Sans attendre résultats si suspicion forte.'),
        bulletPoints: [
          LString('Adulte < 50 ans: Ceftriaxone 2g x2/j', 'Adulte < 50 ans: Ceftriaxone 2g x2/j'),
          LString('Adulte > 50 ans ou ID: Ceftriaxone 2g x2 + Amoxicilline 2g x6', 'Adulte > 50 ans ou ID: Ceftriaxone 2g x2 + Amoxicilline 2g x6'),
          LString('Nourrisson: Ceftriaxone 100 mg/kg/j', 'Nourrisson: Ceftriaxone 100 mg/kg/j'),
          LString('Si allergie vraie: Méropénème', 'Si allergie vraie: Méropénème'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Dexaméthasone', '6. Dexaméthasone'),
        content: LString('Corticothérapie adjuvante.', 'Corticothérapie adjuvante.'),
        bulletPoints: [
          LString('Dexaméthasone 10 mg x4/j pendant 4 jours', 'Dexaméthasone 10 mg x4/j pendant 4 jours'),
          LString('Débuter AVANT ou avec la 1ère dose ATB', 'Débuter AVANT ou avec la 1ère dose ATB'),
          LString('Réduit mortalité/séquelles (surtout pneumocoque)', 'Réduit mortalité/séquelles (surtout pneumocoque)'),
        ],
      ),
    ],
    keyPoints: LString('Purpura = ATB immédiat. Dexaméthasone + ATB sans retard. PL après scanner si indiqué.', 'Purpura = ATB immédiat. Dexaméthasone + ATB sans retard. PL après scanner si indiqué.'),
    source: LString('SPILF 2018, HAS', 'SPILF 2018, HAS'),
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
    name: LString('Polytraumatisé', 'Polytraumatisé'),
    category: ProtocolCategory.trauma,
    description: LString('Prise en charge initiale du patient polytraumatisé', 'Prise en charge initiale du patient polytraumatisé'),
    indication: LString('Traumatisme violent avec atteinte de plusieurs régions corporelles', 'Traumatisme violent avec atteinte de plusieurs régions corporelles'),
    steps: [
      ProtocolStep(
        title: LString('1. Préhospitalier - SAFE', '1. Préhospitalier - SAFE'),
        content: LString('Sécurité et conditionnement.', 'Sécurité et conditionnement.'),
        bulletPoints: [
          LString('Sécurité: scène sécurisée, protection équipe', 'Sécurité: scène sécurisée, protection équipe'),
          LString('Alerter: renfort, trauma center', 'Alerter: renfort, trauma center'),
          LString('Free: désincarcération', 'Free: désincarcération'),
          LString('Evaluate: bilan lésionnel rapide', 'Evaluate: bilan lésionnel rapide'),
        ],
      ),
      ProtocolStep(
        title: LString('2. ABCDE', '2. ABCDE'),
        content: LString('Évaluation systématique.', 'Évaluation systématique.'),
        bulletPoints: [
          LString('A: Airway + protection rachis cervical', 'A: Airway + protection rachis cervical'),
          LString('B: Breathing (pneumothorax, volet)', 'B: Breathing (pneumothorax, volet)'),
          LString('C: Circulation (hémorragie, remplissage)', 'C: Circulation (hémorragie, remplissage)'),
          LString('D: Disability (GCS, pupilles)', 'D: Disability (GCS, pupilles)'),
          LString('E: Exposure (hypothermie)', 'E: Exposure (hypothermie)'),
        ],
        warning: LString('Immobilisation rachis cervical systématique jusqu\'à évaluation', 'Immobilisation rachis cervical systématique jusqu\'à évaluation'),
      ),
      ProtocolStep(
        title: LString('3. Contrôle hémorragique', '3. Contrôle hémorragique'),
        content: LString('Hémorragie = priorité.', 'Hémorragie = priorité.'),
        bulletPoints: [
          LString('Compression directe', 'Compression directe'),
          LString('Garrot si membre et hémorragie non contrôlable', 'Garrot si membre et hémorragie non contrôlable'),
          LString('Packing si jonctionnel', 'Packing si jonctionnel'),
          LString('Acide tranexamique 1g IV < 3h du trauma (puis 1g/8h)', 'Acide tranexamique 1g IV < 3h du trauma (puis 1g/8h)'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Réanimation hémodynamique', '4. Réanimation hémodynamique'),
        content: LString('Damage control resuscitation.', 'Damage control resuscitation.'),
        bulletPoints: [
          LString('Objectif PAS 80-90 mmHg (sans TC)', 'Objectif PAS 80-90 mmHg (sans TC)'),
          LString('Objectif PAS > 100 mmHg si TC associé', 'Objectif PAS > 100 mmHg si TC associé'),
          LString('Remplissage: cristalloïdes limités, sang précoce', 'Remplissage: cristalloïdes limités, sang précoce'),
          LString('Ratio CGR:PFC:Plaquettes = 1:1:1', 'Ratio CGR:PFC:Plaquettes = 1:1:1'),
          LString('Éviter hypothermie, acidose, coagulopathie', 'Éviter hypothermie, acidose, coagulopathie'),
        ],
        tip: LString('Triade létale = hypothermie + acidose + coagulopathie', 'Triade létale = hypothermie + acidose + coagulopathie'),
      ),
      ProtocolStep(
        title: LString('5. Intubation et voies aériennes', '5. Intubation et voies aériennes'),
        content: LString('Indications précoces.', 'Indications précoces.'),
        bulletPoints: [
          LString('GCS ≤ 8', 'GCS ≤ 8'),
          LString('Détresse respiratoire, SpO2 < 90%', 'Détresse respiratoire, SpO2 < 90%'),
          LString('Trauma facial sévère', 'Trauma facial sévère'),
          LString('ISR avec maintien en ligne du rachis', 'ISR avec maintien en ligne du rachis'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Orientation et bilan', '6. Orientation et bilan'),
        content: LString('Trauma center et imagerie.', 'Trauma center et imagerie.'),
        bulletPoints: [
          LString('Alerte trauma center', 'Alerte trauma center'),
          LString('Body-scanner si stable', 'Body-scanner si stable'),
          LString('Échographie FAST si instable', 'Échographie FAST si instable'),
          LString('Bloc opératoire direct si instabilité majeure', 'Bloc opératoire direct si instabilité majeure'),
        ],
      ),
    ],
    keyPoints: LString('ABCDE. Contrôle hémorragie. Damage control. Acide tranexamique précoce. Éviter triade létale.', 'ABCDE. Contrôle hémorragie. Damage control. Acide tranexamique précoce. Éviter triade létale.'),
    source: LString('SFMU, ATLS, Traumatologie Grave 2019', 'SFMU, ATLS, Traumatologie Grave 2019'),
    lastUpdated: 2019,
  ),

  // TC grave
  Protocol(
    id: 'tc-grave',
    name: LString('Traumatisme Crânien Grave', 'Traumatisme Crânien Grave'),
    category: ProtocolCategory.trauma,
    description: LString('TC avec GCS ≤ 8 après réanimation', 'TC avec GCS ≤ 8 après réanimation'),
    indication: LString('Traumatisme crânien avec GCS ≤ 8', 'Traumatisme crânien avec GCS ≤ 8'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation initiale', '1. Évaluation initiale'),
        content: LString('Après stabilisation ABCDE.', 'Après stabilisation ABCDE.'),
        bulletPoints: [
          LString('GCS après correction hypoxie/hypotension', 'GCS après correction hypoxie/hypotension'),
          LString('Pupilles: anisocorie = engagement', 'Pupilles: anisocorie = engagement'),
          LString('Signes de focalisation', 'Signes de focalisation'),
          LString('Mécanisme du trauma', 'Mécanisme du trauma'),
        ],
        warning: LString('Toute anisocorie = engagement présumé → osmothérapie', 'Toute anisocorie = engagement présumé → osmothérapie'),
      ),
      ProtocolStep(
        title: LString('2. Objectifs hémodynamiques', '2. Objectifs hémodynamiques'),
        content: LString('Éviter agressions secondaires.', 'Éviter agressions secondaires.'),
        bulletPoints: [
          LString('PAS > 110 mmHg (idéal PAM > 80)', 'PAS > 110 mmHg (idéal PAM > 80)'),
          LString('SpO2 > 94%', 'SpO2 > 94%'),
          LString('PaCO2 35-40 mmHg (éviter hypo/hypercapnie)', 'PaCO2 35-40 mmHg (éviter hypo/hypercapnie)'),
          LString('Éviter hyperthermie, hyperglycémie', 'Éviter hyperthermie, hyperglycémie'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Intubation', '3. Intubation'),
        content: LString('Protection voies aériennes.', 'Protection voies aériennes.'),
        bulletPoints: [
          LString('ISR avec stabilisation rachis cervical', 'ISR avec stabilisation rachis cervical'),
          LString('Kétamine + succinylcholine (ou rocuronium)', 'Kétamine + succinylcholine (ou rocuronium)'),
          LString('Éviter hypotension lors de l\'induction', 'Éviter hypotension lors de l\'induction'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Traitement engagement', '4. Traitement engagement'),
        content: LString('Si mydriase ou signes HTIC.', 'Si mydriase ou signes HTIC.'),
        bulletPoints: [
          LString('Mannitol 20% 0.5-1 g/kg IV rapide', 'Mannitol 20% 0.5-1 g/kg IV rapide'),
          LString('ou SSH 7.5% 100-150 mL', 'ou SSH 7.5% 100-150 mL'),
          LString('Tête à 30°, éviter compression jugulaires', 'Tête à 30°, éviter compression jugulaires'),
          LString('Hyperventilation transitoire si engagement avéré (PaCO2 30-35)', 'Hyperventilation transitoire si engagement avéré (PaCO2 30-35)'),
        ],
        warning: LString('Hyperventilation seulement transitoire et si engagement', 'Hyperventilation seulement transitoire et si engagement'),
      ),
      ProtocolStep(
        title: LString('5. Imagerie', '5. Imagerie'),
        content: LString('Scanner cérébral en urgence.', 'Scanner cérébral en urgence.'),
        bulletPoints: [
          LString('Scanner sans injection + rachis cervical', 'Scanner sans injection + rachis cervical'),
          LString('Rechercher: hématome, contusion, engagement', 'Rechercher: hématome, contusion, engagement'),
          LString('Indication neurochirurgicale urgente?', 'Indication neurochirurgicale urgente?'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Orientation', '6. Orientation'),
        content: LString('Neuroréanimation.', 'Neuroréanimation.'),
        bulletPoints: [
          LString('Transfert trauma center avec neurochirurgie', 'Transfert trauma center avec neurochirurgie'),
          LString('Monitoring PIC à discuter', 'Monitoring PIC à discuter'),
          LString('Sédation profonde initiale', 'Sédation profonde initiale'),
        ],
      ),
    ],
    keyPoints: LString('Éviter agressions secondaires (hypoxie, hypotension). PAS > 110. Osmothérapie si engagement.', 'Éviter agressions secondaires (hypoxie, hypotension). PAS > 110. Osmothérapie si engagement.'),
    source: LString('SFAR/SFMU 2016 - TC Grave', 'SFAR/SFMU 2016 - TC Grave'),
    lastUpdated: 2016,
  ),

  // Choc hémorragique
  Protocol(
    id: 'choc-hemorragique',
    name: LString('Choc Hémorragique', 'Choc Hémorragique'),
    category: ProtocolCategory.trauma,
    description: LString('Hypovolémie par saignement massif', 'Hypovolémie par saignement massif'),
    indication: LString('Saignement actif avec signes de choc (tachycardie, hypotension, marbrures)', 'Saignement actif avec signes de choc (tachycardie, hypotension, marbrures)'),
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Reconnaissance'),
        content: LString('Identifier le choc hémorragique.', 'Identifier le choc hémorragique.'),
        bulletPoints: [
          LString('Classe I: < 15% volémie, FC < 100', 'Classe I: < 15% volémie, FC < 100'),
          LString('Classe II: 15-30%, FC 100-120, anxiété', 'Classe II: 15-30%, FC 100-120, anxiété'),
          LString('Classe III: 30-40%, FC > 120, confusion', 'Classe III: 30-40%, FC > 120, confusion'),
          LString('Classe IV: > 40%, FC > 140, léthargie', 'Classe IV: > 40%, FC > 140, léthargie'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Contrôle hémorragique', '2. Contrôle hémorragique'),
        content: LString('Stopper le saignement.', 'Stopper le saignement.'),
        bulletPoints: [
          LString('Compression directe', 'Compression directe'),
          LString('Garrot artériel si membre (noter l\'heure)', 'Garrot artériel si membre (noter l\'heure)'),
          LString('Packing hémostatique si jonctionnel', 'Packing hémostatique si jonctionnel'),
          LString('Chirurgie/embolisation précoce', 'Chirurgie/embolisation précoce'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Réanimation volémique', '3. Réanimation volémique'),
        content: LString('Damage control resuscitation.', 'Damage control resuscitation.'),
        bulletPoints: [
          LString('Objectif PAS 80-90 mmHg (hypotension permissive)', 'Objectif PAS 80-90 mmHg (hypotension permissive)'),
          LString('Cristalloïdes limités à 1-2 L', 'Cristalloïdes limités à 1-2 L'),
          LString('Transfusion précoce si besoin', 'Transfusion précoce si besoin'),
          LString('Concentrés de globules rouges (CGR)', 'Concentrés de globules rouges (CGR)'),
        ],
        warning: LString('Hypotension permissive CI si TC associé', 'Hypotension permissive CI si TC associé'),
      ),
      ProtocolStep(
        title: LString('4. Transfusion massive', '4. Transfusion massive'),
        content: LString('Protocole si hémorragie grave.', 'Protocole si hémorragie grave.'),
        bulletPoints: [
          LString('Activation protocole transfusion massive', 'Activation protocole transfusion massive'),
          LString('Ratio CGR:PFC:Plaquettes = 1:1:1', 'Ratio CGR:PFC:Plaquettes = 1:1:1'),
          LString('Fibrinogène si < 1.5 g/L', 'Fibrinogène si < 1.5 g/L'),
          LString('Objectif Hb > 7-9 g/dL', 'Objectif Hb > 7-9 g/dL'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Acide tranexamique', '5. Acide tranexamique'),
        content: LString('Administration précoce.', 'Administration précoce.'),
        bulletPoints: [
          LString('1g IV en 10 min < 3h du trauma', '1g IV en 10 min < 3h du trauma'),
          LString('puis 1g IV sur 8h', 'puis 1g IV sur 8h'),
          LString('Réduit mortalité si administré tôt', 'Réduit mortalité si administré tôt'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Éviter la triade létale', '6. Éviter la triade létale'),
        content: LString('Hypothermie - Acidose - Coagulopathie.', 'Hypothermie - Acidose - Coagulopathie.'),
        bulletPoints: [
          LString('Réchauffement actif (couverture, solutés réchauffés)', 'Réchauffement actif (couverture, solutés réchauffés)'),
          LString('Corriger acidose (optimiser perfusion)', 'Corriger acidose (optimiser perfusion)'),
          LString('Corriger coagulopathie (PFC, plaquettes, fibrinogène)', 'Corriger coagulopathie (PFC, plaquettes, fibrinogène)'),
          LString('Calcium si transfusion massive', 'Calcium si transfusion massive'),
        ],
      ),
    ],
    keyPoints: LString('Contrôle hémorragie. Acide tranexamique < 3h. Ratio 1:1:1. Éviter triade létale.', 'Contrôle hémorragie. Acide tranexamique < 3h. Ratio 1:1:1. Éviter triade létale.'),
    source: LString('SFAR 2015 - Choc hémorragique traumatique', 'SFAR 2015 - Choc hémorragique traumatique'),
    lastUpdated: 2015,
  ),

  // Damage control
  Protocol(
    id: 'damage-control',
    name: LString('Damage Control', 'Damage Control'),
    category: ProtocolCategory.trauma,
    description: LString('Stratégie de réanimation chirurgicale abrégée', 'Stratégie de réanimation chirurgicale abrégée'),
    indication: LString('Patient traumatisé instable avec hémorragie active', 'Patient traumatisé instable avec hémorragie active'),
    steps: [
      ProtocolStep(
        title: LString('1. Principe', '1. Principe'),
        content: LString('Chirurgie écourtée puis réanimation.', 'Chirurgie écourtée puis réanimation.'),
        bulletPoints: [
          LString('Contrôle hémorragie et contamination uniquement', 'Contrôle hémorragie et contamination uniquement'),
          LString('Packing hémostatique', 'Packing hémostatique'),
          LString('Fermeture temporaire', 'Fermeture temporaire'),
          LString('Réanimation pour corriger physiologie', 'Réanimation pour corriger physiologie'),
          LString('Reprise chirurgicale à 24-48h', 'Reprise chirurgicale à 24-48h'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Indications', '2. Indications'),
        content: LString('Quand appliquer le damage control.', 'Quand appliquer le damage control.'),
        bulletPoints: [
          LString('pH < 7.2', 'pH < 7.2'),
          LString('Température < 34°C', 'Température < 34°C'),
          LString('Coagulopathie (TP < 50%, Fibrinogène < 1 g/L)', 'Coagulopathie (TP < 50%, Fibrinogène < 1 g/L)'),
          LString('Temps opératoire prévu > 90 min', 'Temps opératoire prévu > 90 min'),
          LString('Transfusion > 10 CGR', 'Transfusion > 10 CGR'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Damage control resuscitation', '3. Damage control resuscitation'),
        content: LString('Réanimation associée.', 'Réanimation associée.'),
        bulletPoints: [
          LString('Hypotension permissive (PAS 80-90)', 'Hypotension permissive (PAS 80-90)'),
          LString('Limiter cristalloïdes', 'Limiter cristalloïdes'),
          LString('Transfusion précoce ratio 1:1:1', 'Transfusion précoce ratio 1:1:1'),
          LString('Acide tranexamique', 'Acide tranexamique'),
          LString('Réchauffement actif', 'Réchauffement actif'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Phase de réanimation', '4. Phase de réanimation'),
        content: LString('Objectifs de correction.', 'Objectifs de correction.'),
        bulletPoints: [
          LString('Corriger hypothermie (T > 35°C)', 'Corriger hypothermie (T > 35°C)'),
          LString('Corriger acidose (pH > 7.25)', 'Corriger acidose (pH > 7.25)'),
          LString('Corriger coagulopathie', 'Corriger coagulopathie'),
          LString('Stabilité hémodynamique', 'Stabilité hémodynamique'),
          LString('Durée: 24-48h', 'Durée: 24-48h'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Reprise chirurgicale', '5. Reprise chirurgicale'),
        content: LString('Chirurgie définitive.', 'Chirurgie définitive.'),
        bulletPoints: [
          LString('Quand physiologie corrigée', 'Quand physiologie corrigée'),
          LString('Ablation packing', 'Ablation packing'),
          LString('Réparation définitive des lésions', 'Réparation définitive des lésions'),
          LString('Fermeture pariétale', 'Fermeture pariétale'),
        ],
      ),
    ],
    keyPoints: LString('Sauver la vie > réparer les lésions. Contrôle hémorragie rapide. Corriger physiologie puis reprise.', 'Sauver la vie > réparer les lésions. Contrôle hémorragie rapide. Corriger physiologie puis reprise.'),
    source: LString('Principes de damage control - Traumatologie', 'Principes de damage control - Traumatologie'),
    lastUpdated: 2020,
  ),

  // Fractures ouvertes
  Protocol(
    id: 'fracture-ouverte',
    name: LString('Fractures Ouvertes', 'Fractures Ouvertes'),
    category: ProtocolCategory.trauma,
    description: LString('Prise en charge des fractures ouvertes', 'Prise en charge des fractures ouvertes'),
    indication: LString('Fracture avec effraction cutanée', 'Fracture avec effraction cutanée'),
    steps: [
      ProtocolStep(
        title: LString('1. Classification Gustilo', '1. Classification Gustilo'),
        content: LString('Grader la fracture ouverte.', 'Grader la fracture ouverte.'),
        bulletPoints: [
          LString('Type I: plaie < 1 cm, contamination minime', 'Type I: plaie < 1 cm, contamination minime'),
          LString('Type II: plaie 1-10 cm, dommages tissulaires modérés', 'Type II: plaie 1-10 cm, dommages tissulaires modérés'),
          LString('Type IIIA: > 10 cm mais couverture osseuse possible', 'Type IIIA: > 10 cm mais couverture osseuse possible'),
          LString('Type IIIB: nécessite lambeau de couverture', 'Type IIIB: nécessite lambeau de couverture'),
          LString('Type IIIC: lésion vasculaire nécessitant réparation', 'Type IIIC: lésion vasculaire nécessitant réparation'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Soins immédiats', '2. Soins immédiats'),
        content: LString('Aux urgences.', 'Aux urgences.'),
        bulletPoints: [
          LString('Photo de la plaie avant pansement', 'Photo de la plaie avant pansement'),
          LString('Lavage sérum physiologique', 'Lavage sérum physiologique'),
          LString('Pansement stérile humide', 'Pansement stérile humide'),
          LString('Immobilisation (attelle)', 'Immobilisation (attelle)'),
          LString('Vérifier état vasculo-nerveux distal', 'Vérifier état vasculo-nerveux distal'),
        ],
        warning: LString('Ne pas explorer la plaie aux urgences', 'Ne pas explorer la plaie aux urgences'),
      ),
      ProtocolStep(
        title: LString('3. Antibiothérapie', '3. Antibiothérapie'),
        content: LString('Selon grade.', 'Selon grade.'),
        bulletPoints: [
          LString('Gustilo I-II: Amoxicilline-ac. clav. 2g/8h pendant 48h', 'Gustilo I-II: Amoxicilline-ac. clav. 2g/8h pendant 48h'),
          LString('Gustilo III: Amoxicilline-ac. clav. + Gentamicine 5 mg/kg/j', 'Gustilo III: Amoxicilline-ac. clav. + Gentamicine 5 mg/kg/j'),
          LString('Si allergie: Clindamycine + Gentamicine', 'Si allergie: Clindamycine + Gentamicine'),
          LString('Contamination tellurique: ajouter pénicilline G ou métronidazole', 'Contamination tellurique: ajouter pénicilline G ou métronidazole'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Prophylaxie antitétanique', '4. Prophylaxie antitétanique'),
        content: LString('Selon statut vaccinal.', 'Selon statut vaccinal.'),
        bulletPoints: [
          LString('Vérifier vaccination', 'Vérifier vaccination'),
          LString('Rappel si > 5 ans', 'Rappel si > 5 ans'),
          LString('Immunoglobulines si statut inconnu ou incomplet', 'Immunoglobulines si statut inconnu ou incomplet'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Prise en charge chirurgicale', '5. Prise en charge chirurgicale'),
        content: LString('Au bloc opératoire.', 'Au bloc opératoire.'),
        bulletPoints: [
          LString('Délai < 6h (controversé mais raisonnable)', 'Délai < 6h (controversé mais raisonnable)'),
          LString('Parage, lavage abondant', 'Parage, lavage abondant'),
          LString('Fixation: externe souvent préférée', 'Fixation: externe souvent préférée'),
          LString('Couverture des parties molles', 'Couverture des parties molles'),
        ],
      ),
    ],
    keyPoints: LString('Photo. Pansement stérile. ATB précoce adaptée au grade. Chirurgie < 6h si possible.', 'Photo. Pansement stérile. ATB précoce adaptée au grade. Chirurgie < 6h si possible.'),
    source: LString('SFCOT, Gustilo Classification', 'SFCOT, Gustilo Classification'),
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
    name: LString('Choc Septique', 'Choc Septique'),
    category: ProtocolCategory.sepsis,
    description: LString('Sepsis avec hypotension nécessitant vasopresseurs et lactates > 2 mmol/L', 'Sepsis avec hypotension nécessitant vasopresseurs et lactates > 2 mmol/L'),
    indication: LString('Sepsis avec hypotension persistante malgré remplissage et lactates élevés', 'Sepsis avec hypotension persistante malgré remplissage et lactates élevés'),
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance (Hour-1 Bundle)', '1. Reconnaissance (Hour-1 Bundle)'),
        content: LString('Identification précoce.', 'Identification précoce.'),
        bulletPoints: [
          LString('Suspicion infection + qSOFA ≥ 2 ou SOFA ≥ 2', 'Suspicion infection + qSOFA ≥ 2 ou SOFA ≥ 2'),
          LString('qSOFA: FR ≥ 22, PAS ≤ 100, confusion', 'qSOFA: FR ≥ 22, PAS ≤ 100, confusion'),
          LString('Choc: vasopresseurs nécessaires pour PAM ≥ 65', 'Choc: vasopresseurs nécessaires pour PAM ≥ 65'),
          LString('Lactates > 2 mmol/L malgré remplissage', 'Lactates > 2 mmol/L malgré remplissage'),
        ],
        warning: LString('Hour-1 Bundle = actions dans la première heure', 'Hour-1 Bundle = actions dans la première heure'),
      ),
      ProtocolStep(
        title: LString('2. Prélèvements', '2. Prélèvements'),
        content: LString('Avant antibiothérapie si possible.', 'Avant antibiothérapie si possible.'),
        bulletPoints: [
          LString('Lactates', 'Lactates'),
          LString('Hémocultures (2 paires) < 45 min', 'Hémocultures (2 paires) < 45 min'),
          LString('Autres prélèvements selon foyer: ECBU, PL, ponction...', 'Autres prélèvements selon foyer: ECBU, PL, ponction...'),
          LString('Ne pas retarder ATB pour prélèvements', 'Ne pas retarder ATB pour prélèvements'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Antibiothérapie', '3. Antibiothérapie'),
        content: LString('Dans l\'heure suivant reconnaissance.', 'Dans l\'heure suivant reconnaissance.'),
        bulletPoints: [
          LString('Large spectre probabiliste selon foyer suspecté', 'Large spectre probabiliste selon foyer suspecté'),
          LString('Communautaire: Pipéracilline-tazobactam ou C3G + métronidazole', 'Communautaire: Pipéracilline-tazobactam ou C3G + métronidazole'),
          LString('Nosocomial: adapter au risque BMR', 'Nosocomial: adapter au risque BMR'),
          LString('Réévaluer à 48-72h avec résultats', 'Réévaluer à 48-72h avec résultats'),
        ],
        warning: LString('Chaque heure de retard = 7% mortalité en plus', 'Chaque heure de retard = 7% mortalité en plus'),
      ),
      ProtocolStep(
        title: LString('4. Remplissage vasculaire', '4. Remplissage vasculaire'),
        content: LString('Première ligne hémodynamique.', 'Première ligne hémodynamique.'),
        bulletPoints: [
          LString('Cristalloïdes 30 mL/kg dans les 3 premières heures', 'Cristalloïdes 30 mL/kg dans les 3 premières heures'),
          LString('Réévaluer réponse au remplissage', 'Réévaluer réponse au remplissage'),
          LString('Objectif PAM ≥ 65 mmHg', 'Objectif PAM ≥ 65 mmHg'),
          LString('Attention si cardiopathie/SDRA', 'Attention si cardiopathie/SDRA'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Vasopresseurs', '5. Vasopresseurs'),
        content: LString('Si hypotension persistante.', 'Si hypotension persistante.'),
        bulletPoints: [
          LString('Noradrénaline 1ère intention', 'Noradrénaline 1ère intention'),
          LString('Débuter précocement si hypotension sévère', 'Débuter précocement si hypotension sévère'),
          LString('Objectif PAM ≥ 65 mmHg', 'Objectif PAM ≥ 65 mmHg'),
          LString('VVC dès que possible (mais ne pas retarder)', 'VVC dès que possible (mais ne pas retarder)'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Mesures associées', '6. Mesures associées'),
        content: LString('Optimisation.', 'Optimisation.'),
        bulletPoints: [
          LString('Contrôle du foyer infectieux (drainage, chirurgie)', 'Contrôle du foyer infectieux (drainage, chirurgie)'),
          LString('Si choc réfractaire: corticoïdes (hydrocortisone 200 mg/j)', 'Si choc réfractaire: corticoïdes (hydrocortisone 200 mg/j)'),
          LString('Transfusion si Hb < 7 g/dL (seuil restrictif)', 'Transfusion si Hb < 7 g/dL (seuil restrictif)'),
          LString('Contrôle glycémique (< 1.8 g/L)', 'Contrôle glycémique (< 1.8 g/L)'),
        ],
      ),
    ],
    keyPoints: LString('Hour-1: lactates + hémoc + ATB + remplissage + vasopresseurs si besoin. Contrôle du foyer.', 'Hour-1: lactates + hémoc + ATB + remplissage + vasopresseurs si besoin. Contrôle du foyer.'),
    source: LString('Surviving Sepsis Campaign 2021', 'Surviving Sepsis Campaign 2021'),
    sourceUrl: 'https://www.sccm.org',
    lastUpdated: 2021,
  ),

  // Purpura fulminans
  Protocol(
    id: 'purpura-fulminans',
    name: LString('Purpura Fulminans', 'Purpura Fulminans'),
    category: ProtocolCategory.sepsis,
    description: LString('Urgence absolue - infection invasive à méningocoque', 'Urgence absolue - infection invasive à méningocoque'),
    indication: LString('Fièvre + purpura nécrotique ou extensif', 'Fièvre + purpura nécrotique ou extensif'),
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Reconnaissance'),
        content: LString('Identifier immédiatement.', 'Identifier immédiatement.'),
        bulletPoints: [
          LString('Fièvre + purpura ne s\'effaçant pas à la vitropression', 'Fièvre + purpura ne s\'effaçant pas à la vitropression'),
          LString('Purpura extensif (> 3 mm), nécrotique, ecchymotique', 'Purpura extensif (> 3 mm), nécrotique, ecchymotique'),
          LString('Altération de l\'état général', 'Altération de l\'état général'),
          LString('Méningocoque jusqu\'à preuve du contraire', 'Méningocoque jusqu\'à preuve du contraire'),
        ],
        warning: LString('URGENCE ABSOLUE - mortalité 20-30%', 'URGENCE ABSOLUE - mortalité 20-30%'),
      ),
      ProtocolStep(
        title: LString('2. Antibiothérapie IMMÉDIATE', '2. Antibiothérapie IMMÉDIATE'),
        content: LString('Avant tout transport ou examen.', 'Avant tout transport ou examen.'),
        bulletPoints: [
          LString('Ceftriaxone 2g IV ou IM (enfant: 100 mg/kg)', 'Ceftriaxone 2g IV ou IM (enfant: 100 mg/kg)'),
          LString('Alternative si allergie: Ciprofloxacine', 'Alternative si allergie: Ciprofloxacine'),
          LString('NE PAS ATTENDRE: hémocultures, VVP, résultats', 'NE PAS ATTENDRE: hémocultures, VVP, résultats'),
          LString('Injection IM si pas d\'accès IV immédiat', 'Injection IM si pas d\'accès IV immédiat'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Réanimation hémodynamique', '3. Réanimation hémodynamique'),
        content: LString('Traitement du choc.', 'Traitement du choc.'),
        bulletPoints: [
          LString('Remplissage: NaCl 0.9% 20 mL/kg renouvelable', 'Remplissage: NaCl 0.9% 20 mL/kg renouvelable'),
          LString('Noradrénaline précoce si choc', 'Noradrénaline précoce si choc'),
          LString('Objectif PAM > 65 mmHg', 'Objectif PAM > 65 mmHg'),
          LString('IOT si détresse respiratoire/troubles conscience', 'IOT si détresse respiratoire/troubles conscience'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Transfert', '4. Transfert'),
        content: LString('Vers réanimation.', 'Vers réanimation.'),
        bulletPoints: [
          LString('Réanimation la plus proche', 'Réanimation la plus proche'),
          LString('SMUR médicalisé', 'SMUR médicalisé'),
          LString('Pas de PL en préhospitalier', 'Pas de PL en préhospitalier'),
          LString('Continuer réanimation pendant transport', 'Continuer réanimation pendant transport'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Mesures de santé publique', '5. Mesures de santé publique'),
        content: LString('Prophylaxie des contacts.', 'Prophylaxie des contacts.'),
        bulletPoints: [
          LString('Déclaration obligatoire ARS', 'Déclaration obligatoire ARS'),
          LString('Prophylaxie contacts proches < 10 jours', 'Prophylaxie contacts proches < 10 jours'),
          LString('Rifampicine 600 mg x2/j pendant 2 jours (adulte)', 'Rifampicine 600 mg x2/j pendant 2 jours (adulte)'),
          LString('ou Ceftriaxone 250 mg IM dose unique', 'ou Ceftriaxone 250 mg IM dose unique'),
        ],
      ),
    ],
    keyPoints: LString('Antibiotique IMMÉDIAT même préhospitalier. Ne rien attendre. Mortalité dépend du délai.', 'Antibiotique IMMÉDIAT même préhospitalier. Ne rien attendre. Mortalité dépend du délai.'),
    source: LString('Instruction DGS 2018, HCSP', 'Instruction DGS 2018, HCSP'),
    lastUpdated: 2018,
  ),

  // Pneumonie grave
  Protocol(
    id: 'pneumonie-grave',
    name: LString('Pneumonie Communautaire Grave', 'Pneumonie Communautaire Grave'),
    category: ProtocolCategory.sepsis,
    description: LString('Pneumonie avec critères de gravité nécessitant réanimation', 'Pneumonie avec critères de gravité nécessitant réanimation'),
    indication: LString('Pneumonie + ≥ 1 critère majeur ou ≥ 3 critères mineurs ATS/IDSA', 'Pneumonie + ≥ 1 critère majeur ou ≥ 3 critères mineurs ATS/IDSA'),
    steps: [
      ProtocolStep(
        title: LString('1. Critères de gravité', '1. Critères de gravité'),
        content: LString('Évaluation de la sévérité.', 'Évaluation de la sévérité.'),
        bulletPoints: [
          LString('Majeurs: choc septique, ventilation mécanique', 'Majeurs: choc septique, ventilation mécanique'),
          LString('Mineurs: FR ≥ 30, PaO2/FiO2 ≤ 250, confusion', 'Mineurs: FR ≥ 30, PaO2/FiO2 ≤ 250, confusion'),
          LString('Infiltrats multilobaires, urée > 7 mmol/L', 'Infiltrats multilobaires, urée > 7 mmol/L'),
          LString('Leucopénie, thrombopénie, hypothermie', 'Leucopénie, thrombopénie, hypothermie'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Prélèvements', '2. Prélèvements'),
        content: LString('Documentation microbiologique.', 'Documentation microbiologique.'),
        bulletPoints: [
          LString('Hémocultures x2', 'Hémocultures x2'),
          LString('Antigénuries pneumocoque et légionelle', 'Antigénuries pneumocoque et légionelle'),
          LString('ECBC ou aspiration trachéale si intubé', 'ECBC ou aspiration trachéale si intubé'),
          LString('PCR grippe si épidémie', 'PCR grippe si épidémie'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Antibiothérapie probabiliste', '3. Antibiothérapie probabiliste'),
        content: LString('Sans attendre résultats.', 'Sans attendre résultats.'),
        bulletPoints: [
          LString('C3G (Ceftriaxone 2g/j) + Macrolide (Spiramycine ou Azithromycine)', 'C3G (Ceftriaxone 2g/j) + Macrolide (Spiramycine ou Azithromycine)'),
          LString('ou C3G + Fluoroquinolone (Lévofloxacine)', 'ou C3G + Fluoroquinolone (Lévofloxacine)'),
          LString('Si risque Pseudomonas: Pipéracilline-tazobactam + Amikacine', 'Si risque Pseudomonas: Pipéracilline-tazobactam + Amikacine'),
          LString('Durée: 7 jours (14 si Légionelle)', 'Durée: 7 jours (14 si Légionelle)'),
        ],
        tip: LString('Macrolide couvre atypiques (Légionelle, Mycoplasme)', 'Macrolide couvre atypiques (Légionelle, Mycoplasme)'),
      ),
      ProtocolStep(
        title: LString('4. Support respiratoire', '4. Support respiratoire'),
        content: LString('Selon gravité.', 'Selon gravité.'),
        bulletPoints: [
          LString('O2 pour SpO2 > 92%', 'O2 pour SpO2 > 92%'),
          LString('VNI si IRA hypercapnique ou OAP associé', 'VNI si IRA hypercapnique ou OAP associé'),
          LString('HFNC (Optiflow) si IRA hypoxémique', 'HFNC (Optiflow) si IRA hypoxémique'),
          LString('IOT si détresse majeure, épuisement, choc', 'IOT si détresse majeure, épuisement, choc'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Mesures associées', '5. Mesures associées'),
        content: LString('Optimisation.', 'Optimisation.'),
        bulletPoints: [
          LString('Rééquilibration hydro-électrolytique', 'Rééquilibration hydro-électrolytique'),
          LString('Kinésithérapie respiratoire', 'Kinésithérapie respiratoire'),
          LString('Prévention thromboembolique', 'Prévention thromboembolique'),
          LString('Corticoïdes discutés si choc', 'Corticoïdes discutés si choc'),
        ],
      ),
    ],
    keyPoints: LString('C3G + macrolide ou FQ. Documentation microbiologique. Support respiratoire adapté.', 'C3G + macrolide ou FQ. Documentation microbiologique. Support respiratoire adapté.'),
    source: LString('SPILF/SPLF 2024 - Infections respiratoires basses', 'SPILF/SPLF 2024 - Infections respiratoires basses'),
    lastUpdated: 2024,
  ),

  // Fasciite nécrosante
  Protocol(
    id: 'fasciite-necrosante',
    name: LString('Fasciite Nécrosante', 'Fasciite Nécrosante'),
    category: ProtocolCategory.sepsis,
    description: LString('Infection grave des tissus mous avec nécrose', 'Infection grave des tissus mous avec nécrose'),
    indication: LString('Douleur intense, signes généraux sévères, évolution rapide', 'Douleur intense, signes généraux sévères, évolution rapide'),
    steps: [
      ProtocolStep(
        title: LString('1. Suspicion clinique', '1. Suspicion clinique'),
        content: LString('Reconnaître précocement.', 'Reconnaître précocement.'),
        bulletPoints: [
          LString('Douleur disproportionnée par rapport aux signes locaux', 'Douleur disproportionnée par rapport aux signes locaux'),
          LString('Œdème induré dépassant érythème', 'Œdème induré dépassant érythème'),
          LString('Crépitations sous-cutanées (gaz)', 'Crépitations sous-cutanées (gaz)'),
          LString('Signes systémiques: choc, confusion', 'Signes systémiques: choc, confusion'),
          LString('Extension rapide (heures)', 'Extension rapide (heures)'),
        ],
        warning: LString('Score LRINEC peut aider mais ne pas retarder si suspicion forte', 'Score LRINEC peut aider mais ne pas retarder si suspicion forte'),
      ),
      ProtocolStep(
        title: LString('2. Antibiothérapie urgente', '2. Antibiothérapie urgente'),
        content: LString('Large spectre + anti-toxinique.', 'Large spectre + anti-toxinique.'),
        bulletPoints: [
          LString('Pipéracilline-tazobactam 4g x4/j', 'Pipéracilline-tazobactam 4g x4/j'),
          LString('+ Clindamycine 600-900 mg x3/j (anti-toxinique)', '+ Clindamycine 600-900 mg x3/j (anti-toxinique)'),
          LString('+ Amikacine 25 mg/kg/j si choc', '+ Amikacine 25 mg/kg/j si choc'),
          LString('Alternative: Méropénème si allergie', 'Alternative: Méropénème si allergie'),
        ],
        tip: LString('Clindamycine inhibe production de toxines', 'Clindamycine inhibe production de toxines'),
      ),
      ProtocolStep(
        title: LString('3. Chirurgie urgente', '3. Chirurgie urgente'),
        content: LString('Débridement dans les 12-24h.', 'Débridement dans les 12-24h.'),
        bulletPoints: [
          LString('Exploration chirurgicale diagnostique et thérapeutique', 'Exploration chirurgicale diagnostique et thérapeutique'),
          LString('Débridement large de tous tissus nécrotiques', 'Débridement large de tous tissus nécrotiques'),
          LString('Reprises itératives (24-48h) jusqu\'à tissu sain', 'Reprises itératives (24-48h) jusqu\'à tissu sain'),
          LString('Prélèvements peropératoires', 'Prélèvements peropératoires'),
        ],
        warning: LString('Retard chirurgical = surmortalité majeure', 'Retard chirurgical = surmortalité majeure'),
      ),
      ProtocolStep(
        title: LString('4. Réanimation', '4. Réanimation'),
        content: LString('Support des défaillances.', 'Support des défaillances.'),
        bulletPoints: [
          LString('Remplissage vasculaire', 'Remplissage vasculaire'),
          LString('Vasopresseurs si choc', 'Vasopresseurs si choc'),
          LString('Ventilation mécanique si défaillance respi', 'Ventilation mécanique si défaillance respi'),
          LString('Épuration extra-rénale si IRA', 'Épuration extra-rénale si IRA'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Thérapies adjuvantes', '5. Thérapies adjuvantes'),
        content: LString('Mesures complémentaires.', 'Mesures complémentaires.'),
        bulletPoints: [
          LString('Immunoglobulines IV discutées si streptocoque A', 'Immunoglobulines IV discutées si streptocoque A'),
          LString('Oxygénothérapie hyperbare (si disponible)', 'Oxygénothérapie hyperbare (si disponible)'),
          LString('Prise en charge nutritionnelle', 'Prise en charge nutritionnelle'),
        ],
      ),
    ],
    keyPoints: LString('Suspicion = chirurgie urgente + ATB large spectre avec clindamycine. Mortalité > 30%.', 'Suspicion = chirurgie urgente + ATB large spectre avec clindamycine. Mortalité > 30%.'),
    source: LString('IDSA 2014 - Skin and Soft Tissue Infections', 'IDSA 2014 - Skin and Soft Tissue Infections'),
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
    name: LString('Intoxication Médicamenteuse', 'Intoxication Médicamenteuse'),
    category: ProtocolCategory.toxicology,
    description: LString('Approche générale des intoxications médicamenteuses volontaires', 'Approche générale des intoxications médicamenteuses volontaires'),
    indication: LString('Suspicion d\'ingestion médicamenteuse à visée suicidaire ou accidentelle', 'Suspicion d\'ingestion médicamenteuse à visée suicidaire ou accidentelle'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation initiale', '1. Évaluation initiale'),
        content: LString('Stabilisation et bilan.', 'Stabilisation et bilan.'),
        bulletPoints: [
          LString('ABCDE systématique', 'ABCDE systématique'),
          LString('Glasgow, pupilles, glycémie', 'Glasgow, pupilles, glycémie'),
          LString('Monitoring continu: scope, SpO2, PA', 'Monitoring continu: scope, SpO2, PA'),
          LString('Température (hypo/hyperthermie)', 'Température (hypo/hyperthermie)'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Anamnèse toxicologique', '2. Anamnèse toxicologique'),
        content: LString('Recueillir informations.', 'Recueillir informations.'),
        bulletPoints: [
          LString('Produit(s), quantité, heure d\'ingestion', 'Produit(s), quantité, heure d\'ingestion'),
          LString('Symptômes et délai d\'apparition', 'Symptômes et délai d\'apparition'),
          LString('Co-intoxications (alcool++)', 'Co-intoxications (alcool++)'),
          LString('ATCD psychiatriques, tentatives antérieures', 'ATCD psychiatriques, tentatives antérieures'),
          LString('Boîtes, ordonnances, témoins', 'Boîtes, ordonnances, témoins'),
        ],
        tip: LString('Appeler le centre antipoison si doute', 'Appeler le centre antipoison si doute'),
      ),
      ProtocolStep(
        title: LString('3. Toxidromes', '3. Toxidromes'),
        content: LString('Orienter le diagnostic.', 'Orienter le diagnostic.'),
        bulletPoints: [
          LString('Opioïdes: myosis, bradypnée, coma calme', 'Opioïdes: myosis, bradypnée, coma calme'),
          LString('Anticholinergique: mydriase, tachycardie, rétention', 'Anticholinergique: mydriase, tachycardie, rétention'),
          LString('Sympathomimétique: mydriase, HTA, hyperthermie', 'Sympathomimétique: mydriase, HTA, hyperthermie'),
          LString('Sérotoninergique: confusion, myoclonies, hyperthermie', 'Sérotoninergique: confusion, myoclonies, hyperthermie'),
          LString('Stabilisant de membrane: QRS large, troubles rythme', 'Stabilisant de membrane: QRS large, troubles rythme'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Examens complémentaires', '4. Examens complémentaires'),
        content: LString('Bilan ciblé.', 'Bilan ciblé.'),
        bulletPoints: [
          LString('ECG: QT, QRS (élargissement)', 'ECG: QT, QRS (élargissement)'),
          LString('Glycémie, iono, créatinine, lactates', 'Glycémie, iono, créatinine, lactates'),
          LString('Paracétamolémie systématique (si > 4h)', 'Paracétamolémie systématique (si > 4h)'),
          LString('Dosages spécifiques si disponibles', 'Dosages spécifiques si disponibles'),
          LString('Toxiques urinaires (orientation)', 'Toxiques urinaires (orientation)'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Décontamination digestive', '5. Décontamination digestive'),
        content: LString('Indications limitées.', 'Indications limitées.'),
        bulletPoints: [
          LString('Charbon activé 1 g/kg si < 1h post-ingestion', 'Charbon activé 1 g/kg si < 1h post-ingestion'),
          LString('CI: coma, vomissements, caustiques', 'CI: coma, vomissements, caustiques'),
          LString('Lavage gastrique: exceptionnellement (ingestion massive < 1h)', 'Lavage gastrique: exceptionnellement (ingestion massive < 1h)'),
          LString('Irrigation intestinale: toxiques à libération prolongée', 'Irrigation intestinale: toxiques à libération prolongée'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Antidotes principaux', '6. Antidotes principaux'),
        content: LString('Traitements spécifiques.', 'Traitements spécifiques.'),
        bulletPoints: [
          LString('Paracétamol: N-acétylcystéine', 'Paracétamol: N-acétylcystéine'),
          LString('Opioïdes: Naloxone', 'Opioïdes: Naloxone'),
          LString('Benzodiazépines: Flumazénil (CI si épilepsie, co-ingestion)', 'Benzodiazépines: Flumazénil (CI si épilepsie, co-ingestion)'),
          LString('Stabilisants membrane: bicarbonates molaires', 'Stabilisants membrane: bicarbonates molaires'),
          LString('Digitaliques: anticorps anti-digoxine', 'Digitaliques: anticorps anti-digoxine'),
        ],
      ),
    ],
    keyPoints: LString('ABCDE. Identifier toxidrome. ECG + paracétamolémie systématiques. Charbon < 1h. Antidotes spécifiques.', 'ABCDE. Identifier toxidrome. ECG + paracétamolémie systématiques. Charbon < 1h. Antidotes spécifiques.'),
    source: LString('SFMU - Toxicologie d\'urgence', 'SFMU - Toxicologie d\'urgence'),
    lastUpdated: 2020,
  ),

  // Intoxication CO
  Protocol(
    id: 'intox-co',
    name: LString('Intoxication au Monoxyde de Carbone', 'Intoxication au Monoxyde de Carbone'),
    category: ProtocolCategory.toxicology,
    description: LString('Intoxication au CO - urgence collective possible', 'Intoxication au CO - urgence collective possible'),
    indication: LString('Céphalées, nausées, confusion dans contexte évocateur (chauffage, incendie)', 'Céphalées, nausées, confusion dans contexte évocateur (chauffage, incendie)'),
    steps: [
      ProtocolStep(
        title: LString('1. Suspicion et évacuation', '1. Suspicion et évacuation'),
        content: LString('Mesures de protection.', 'Mesures de protection.'),
        bulletPoints: [
          LString('Évacuer la zone contaminée', 'Évacuer la zone contaminée'),
          LString('Aérer les locaux', 'Aérer les locaux'),
          LString('Rechercher autres victimes', 'Rechercher autres victimes'),
          LString('Signalement (pompiers, CAPTV)', 'Signalement (pompiers, CAPTV)'),
        ],
        warning: LString('Ne pas entrer sans protection si concentration élevée', 'Ne pas entrer sans protection si concentration élevée'),
      ),
      ProtocolStep(
        title: LString('2. Signes cliniques', '2. Signes cliniques'),
        content: LString('Gravité variable.', 'Gravité variable.'),
        bulletPoints: [
          LString('Léger: céphalées, nausées, vertiges', 'Léger: céphalées, nausées, vertiges'),
          LString('Modéré: confusion, faiblesse, dyspnée d\'effort', 'Modéré: confusion, faiblesse, dyspnée d\'effort'),
          LString('Sévère: coma, convulsions, arythmies', 'Sévère: coma, convulsions, arythmies'),
          LString('Coloration rosée = tardive et inconstante', 'Coloration rosée = tardive et inconstante'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Oxygénothérapie normobare', '3. Oxygénothérapie normobare'),
        content: LString('Traitement immédiat.', 'Traitement immédiat.'),
        bulletPoints: [
          LString('O2 100% au masque haute concentration', 'O2 100% au masque haute concentration'),
          LString('Durée: minimum 12 heures', 'Durée: minimum 12 heures'),
          LString('Demi-vie HbCO: 4-5h en air ambiant, 1h sous O2 100%', 'Demi-vie HbCO: 4-5h en air ambiant, 1h sous O2 100%'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Indications OHB', '4. Indications OHB'),
        content: LString('Oxygénothérapie hyperbare.', 'Oxygénothérapie hyperbare.'),
        bulletPoints: [
          LString('Perte de connaissance', 'Perte de connaissance'),
          LString('Signes neurologiques', 'Signes neurologiques'),
          LString('Signes cardiaques (ischémie, arythmies)', 'Signes cardiaques (ischémie, arythmies)'),
          LString('Grossesse', 'Grossesse'),
          LString('HbCO > 25% (ou > 15% chez femme enceinte)', 'HbCO > 25% (ou > 15% chez femme enceinte)'),
        ],
        tip: LString('Contacter centre hyperbare si indication', 'Contacter centre hyperbare si indication'),
      ),
      ProtocolStep(
        title: LString('5. Bilan', '5. Bilan'),
        content: LString('Examens complémentaires.', 'Examens complémentaires.'),
        bulletPoints: [
          LString('HbCO (attention: peut être normalisée à l\'arrivée)', 'HbCO (attention: peut être normalisée à l\'arrivée)'),
          LString('Gazométrie (SaO2 normale malgré intox!)', 'Gazométrie (SaO2 normale malgré intox!)'),
          LString('ECG (ischémie, troubles rythme)', 'ECG (ischémie, troubles rythme)'),
          LString('Troponine si signes cardiaques', 'Troponine si signes cardiaques'),
          LString('Lactates', 'Lactates'),
        ],
        warning: LString('SpO2 normale en cas d\'intox CO! Utiliser CO-oxymètre', 'SpO2 normale en cas d\'intox CO! Utiliser CO-oxymètre'),
      ),
      ProtocolStep(
        title: LString('6. Surveillance', '6. Surveillance'),
        content: LString('Suivi des complications.', 'Suivi des complications.'),
        bulletPoints: [
          LString('Syndrome post-intervallaire (2-40 jours)', 'Syndrome post-intervallaire (2-40 jours)'),
          LString('Troubles cognitifs, neurologiques', 'Troubles cognitifs, neurologiques'),
          LString('Suivi spécialisé recommandé', 'Suivi spécialisé recommandé'),
        ],
      ),
    ],
    keyPoints: LString('Évacuer + O2 100% immédiat. OHB si gravité. SpO2 non fiable. Rechercher autres victimes.', 'Évacuer + O2 100% immédiat. OHB si gravité. SpO2 non fiable. Rechercher autres victimes.'),
    source: LString('SFMU 2017 - Intoxication CO', 'SFMU 2017 - Intoxication CO'),
    lastUpdated: 2017,
  ),

  // Intoxication éthylique aiguë
  Protocol(
    id: 'intox-alcool',
    name: LString('Intoxication Éthylique Aiguë', 'Intoxication Éthylique Aiguë'),
    category: ProtocolCategory.toxicology,
    description: LString('Ivresse aiguë et ses complications', 'Ivresse aiguë et ses complications'),
    indication: LString('État d\'ivresse avec altération de conscience ou comportement', 'État d\'ivresse avec altération de conscience ou comportement'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation gravité', '1. Évaluation gravité'),
        content: LString('Stadification clinique.', 'Stadification clinique.'),
        bulletPoints: [
          LString('Excitation: euphorie, désinhibition, logorrhée', 'Excitation: euphorie, désinhibition, logorrhée'),
          LString('Ébriété: incoordination, dysarthrie', 'Ébriété: incoordination, dysarthrie'),
          LString('Ivresse sévère: somnolence, confusion', 'Ivresse sévère: somnolence, confusion'),
          LString('Coma éthylique: GCS < 8, hypothermie, hypotension', 'Coma éthylique: GCS < 8, hypothermie, hypotension'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Éliminer diagnostics différentiels', '2. Éliminer diagnostics différentiels'),
        content: LString('Ne pas tout attribuer à l\'alcool.', 'Ne pas tout attribuer à l\'alcool.'),
        bulletPoints: [
          LString('Traumatisme crânien (chute ++)', 'Traumatisme crânien (chute ++)'),
          LString('Hypoglycémie', 'Hypoglycémie'),
          LString('Co-intoxication', 'Co-intoxication'),
          LString('AVC, méningite', 'AVC, méningite'),
          LString('Encéphalopathie hépatique, de Gayet-Wernicke', 'Encéphalopathie hépatique, de Gayet-Wernicke'),
        ],
        warning: LString('Toujours scanner si doute ou trauma', 'Toujours scanner si doute ou trauma'),
      ),
      ProtocolStep(
        title: LString('3. Prise en charge coma éthylique', '3. Prise en charge coma éthylique'),
        content: LString('Mesures de protection.', 'Mesures de protection.'),
        bulletPoints: [
          LString('PLS, prévention inhalation', 'PLS, prévention inhalation'),
          LString('Intubation si GCS ≤ 8 sans amélioration', 'Intubation si GCS ≤ 8 sans amélioration'),
          LString('Réchauffement si hypothermie', 'Réchauffement si hypothermie'),
          LString('Hydratation IV (G5% avec électrolytes)', 'Hydratation IV (G5% avec électrolytes)'),
          LString('Thiamine 500 mg IV AVANT glucose', 'Thiamine 500 mg IV AVANT glucose'),
        ],
        warning: LString('Thiamine avant glucose = prévention Gayet-Wernicke', 'Thiamine avant glucose = prévention Gayet-Wernicke'),
      ),
      ProtocolStep(
        title: LString('4. Examens complémentaires', '4. Examens complémentaires'),
        content: LString('Bilan minimal.', 'Bilan minimal.'),
        bulletPoints: [
          LString('Glycémie capillaire', 'Glycémie capillaire'),
          LString('Alcoolémie', 'Alcoolémie'),
          LString('Iono, créat (déshydratation)', 'Iono, créat (déshydratation)'),
          LString('Scanner si trauma ou coma inexpliqué', 'Scanner si trauma ou coma inexpliqué'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Surveillance', '5. Surveillance'),
        content: LString('Jusqu\'à dégrisement.', 'Jusqu\'à dégrisement.'),
        bulletPoints: [
          LString('Surveillance GCS toutes les heures', 'Surveillance GCS toutes les heures'),
          LString('Prévention risque suicidaire', 'Prévention risque suicidaire'),
          LString('Évaluation psychiatrique si IMV', 'Évaluation psychiatrique si IMV'),
          LString('Information sur risques, orientation addictologie', 'Information sur risques, orientation addictologie'),
        ],
      ),
    ],
    keyPoints: LString('Éliminer TC et hypoglycémie. Thiamine AVANT glucose. PLS et surveillance jusqu\'à dégrisement.', 'Éliminer TC et hypoglycémie. Thiamine AVANT glucose. PLS et surveillance jusqu\'à dégrisement.'),
    source: LString('SFMU - Urgences et alcool', 'SFMU - Urgences et alcool'),
    lastUpdated: 2019,
  ),

  // Syndrome sérotoninergique
  Protocol(
    id: 'syndrome-serotoninergique',
    name: LString('Syndrome Sérotoninergique', 'Syndrome Sérotoninergique'),
    category: ProtocolCategory.toxicology,
    description: LString('Excès de sérotonine - urgence thérapeutique', 'Excès de sérotonine - urgence thérapeutique'),
    indication: LString('Triade: troubles neurocognitifs + dysautonomie + anomalies neuromusculaires', 'Triade: troubles neurocognitifs + dysautonomie + anomalies neuromusculaires'),
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Reconnaissance'),
        content: LString('Critères de Hunter.', 'Critères de Hunter.'),
        bulletPoints: [
          LString('Prise sérotoninergique + UN des critères suivants:', 'Prise sérotoninergique + UN des critères suivants:'),
          LString('Clonus spontané', 'Clonus spontané'),
          LString('Clonus inductible + agitation/diaphorèse', 'Clonus inductible + agitation/diaphorèse'),
          LString('Tremor + hyperréflexie', 'Tremor + hyperréflexie'),
          LString('Hypertonie + T > 38°C + clonus/myoclonies', 'Hypertonie + T > 38°C + clonus/myoclonies'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Médicaments en cause', '2. Médicaments en cause'),
        content: LString('Identifier les agents.', 'Identifier les agents.'),
        bulletPoints: [
          LString('ISRS, IRSN, antidépresseurs tricycliques', 'ISRS, IRSN, antidépresseurs tricycliques'),
          LString('IMAO', 'IMAO'),
          LString('Tramadol, fentanyl', 'Tramadol, fentanyl'),
          LString('Triptans, lithium', 'Triptans, lithium'),
          LString('MDMA, amphétamines', 'MDMA, amphétamines'),
          LString('Linézolide, bleu de méthylène', 'Linézolide, bleu de méthylène'),
        ],
        tip: LString('Souvent surdosage ou association de sérotoninergiques', 'Souvent surdosage ou association de sérotoninergiques'),
      ),
      ProtocolStep(
        title: LString('3. Arrêt des agents', '3. Arrêt des agents'),
        content: LString('Première mesure.', 'Première mesure.'),
        bulletPoints: [
          LString('Arrêter tous les agents sérotoninergiques', 'Arrêter tous les agents sérotoninergiques'),
          LString('Amélioration habituelle en 24h', 'Amélioration habituelle en 24h'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Traitement symptomatique', '4. Traitement symptomatique'),
        content: LString('Selon sévérité.', 'Selon sévérité.'),
        bulletPoints: [
          LString('Léger: surveillance, benzodiazépines (agitation)', 'Léger: surveillance, benzodiazépines (agitation)'),
          LString('Modéré: refroidissement, BZD, réhydratation', 'Modéré: refroidissement, BZD, réhydratation'),
          LString('Sévère: IOT, sédation, curarisation si hyperthermie majeure', 'Sévère: IOT, sédation, curarisation si hyperthermie majeure'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Antidote', '5. Antidote'),
        content: LString('Cyproheptadine.', 'Cyproheptadine.'),
        bulletPoints: [
          LString('Cyproheptadine (Périactine) 12 mg PO puis 4 mg/4h', 'Cyproheptadine (Périactine) 12 mg PO puis 4 mg/4h'),
          LString('Anti-sérotoninergique', 'Anti-sérotoninergique'),
          LString('Non disponible en IV', 'Non disponible en IV'),
          LString('Alternative: chlorpromazine 50-100 mg IM', 'Alternative: chlorpromazine 50-100 mg IM'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Diagnostic différentiel', '6. Diagnostic différentiel'),
        content: LString('Éliminer autres causes.', 'Éliminer autres causes.'),
        bulletPoints: [
          LString('Syndrome malin des neuroleptiques (rigidité > clonus)', 'Syndrome malin des neuroleptiques (rigidité > clonus)'),
          LString('Hyperthermie maligne', 'Hyperthermie maligne'),
          LString('Syndrome anticholinergique', 'Syndrome anticholinergique'),
          LString('Infection, état de mal', 'Infection, état de mal'),
        ],
      ),
    ],
    keyPoints: LString('Arrêt des sérotoninergiques + BZD + refroidissement. Cyproheptadine si modéré/sévère.', 'Arrêt des sérotoninergiques + BZD + refroidissement. Cyproheptadine si modéré/sévère.'),
    source: LString('Toxicologie clinique - Syndrome sérotoninergique', 'Toxicologie clinique - Syndrome sérotoninergique'),
    lastUpdated: 2020,
  ),

  // Antidotes
  Protocol(
    id: 'antidotes',
    name: LString('Principaux Antidotes', 'Principaux Antidotes'),
    category: ProtocolCategory.toxicology,
    description: LString('Antidotes des principales intoxications', 'Antidotes des principales intoxications'),
    indication: LString('Intoxication identifiée avec antidote disponible', 'Intoxication identifiée avec antidote disponible'),
    steps: [
      ProtocolStep(
        title: LString('Paracétamol → N-acétylcystéine', 'Paracétamol → N-acétylcystéine'),
        content: LString('Protocole court ou long.', 'Protocole court ou long.'),
        bulletPoints: [
          LString('Indication selon nomogramme de Rumack-Matthew', 'Indication selon nomogramme de Rumack-Matthew'),
          LString('Protocole IV: 150 mg/kg/15min puis 50 mg/kg/4h puis 100 mg/kg/16h', 'Protocole IV: 150 mg/kg/15min puis 50 mg/kg/4h puis 100 mg/kg/16h'),
          LString('Efficace si < 8h, efficacité diminuée après', 'Efficace si < 8h, efficacité diminuée après'),
        ],
      ),
      ProtocolStep(
        title: LString('Opioïdes → Naloxone', 'Opioïdes → Naloxone'),
        content: LString('Antagoniste µ.', 'Antagoniste µ.'),
        bulletPoints: [
          LString('Bolus 0.4 mg IV, répétable toutes les 2-3 min', 'Bolus 0.4 mg IV, répétable toutes les 2-3 min'),
          LString('Titration jusqu\'à FR > 12/min', 'Titration jusqu\'à FR > 12/min'),
          LString('Attention durée d\'action courte (45 min)', 'Attention durée d\'action courte (45 min)'),
          LString('IVSE si opioïde longue durée', 'IVSE si opioïde longue durée'),
        ],
      ),
      ProtocolStep(
        title: LString('Benzodiazépines → Flumazénil', 'Benzodiazépines → Flumazénil'),
        content: LString('Utilisation restreinte.', 'Utilisation restreinte.'),
        bulletPoints: [
          LString('Flumazénil 0.2 mg IV, puis 0.1 mg/min jusqu\'à réveil', 'Flumazénil 0.2 mg IV, puis 0.1 mg/min jusqu\'à réveil'),
          LString('CI: épilepsie, co-ingestion tricycliques', 'CI: épilepsie, co-ingestion tricycliques'),
          LString('Risque convulsions si sevrage BZD', 'Risque convulsions si sevrage BZD'),
        ],
        warning: LString('Prudence extrême - risque convulsions', 'Prudence extrême - risque convulsions'),
      ),
      ProtocolStep(
        title: LString('Stabilisants de membrane → Bicarbonates', 'Stabilisants de membrane → Bicarbonates'),
        content: LString('Alcalinisation.', 'Alcalinisation.'),
        bulletPoints: [
          LString('Bicarbonate de sodium 84‰ molaire', 'Bicarbonate de sodium 84‰ molaire'),
          LString('Bolus 1-2 mEq/kg si QRS > 100 ms', 'Bolus 1-2 mEq/kg si QRS > 100 ms'),
          LString('Objectif pH 7.50-7.55', 'Objectif pH 7.50-7.55'),
          LString('Indications: tricycliques, cocaïne, chloroquine...', 'Indications: tricycliques, cocaïne, chloroquine...'),
        ],
      ),
      ProtocolStep(
        title: LString('Digitaliques → Anticorps anti-digoxine', 'Digitaliques → Anticorps anti-digoxine'),
        content: LString('Fab anti-digitale.', 'Fab anti-digitale.'),
        bulletPoints: [
          LString('Digibind ou DigiFab', 'Digibind ou DigiFab'),
          LString('Indications: arythmies, kaliémie > 5.5, choc', 'Indications: arythmies, kaliémie > 5.5, choc'),
          LString('Dose selon digoxinémie ou empirique 6-10 flacons', 'Dose selon digoxinémie ou empirique 6-10 flacons'),
        ],
      ),
      ProtocolStep(
        title: LString('Méthanol/Éthylène glycol → Fomépizole', 'Méthanol/Éthylène glycol → Fomépizole'),
        content: LString('Inhibiteur ADH.', 'Inhibiteur ADH.'),
        bulletPoints: [
          LString('Fomépizole 15 mg/kg charge puis 10 mg/kg/12h', 'Fomépizole 15 mg/kg charge puis 10 mg/kg/12h'),
          LString('Alternative: éthanol IV (alcoolémie cible 1g/L)', 'Alternative: éthanol IV (alcoolémie cible 1g/L)'),
          LString('Hémodialyse si acidose sévère ou IRA', 'Hémodialyse si acidose sévère ou IRA'),
        ],
      ),
      ProtocolStep(
        title: LString('Autres antidotes importants', 'Autres antidotes importants'),
        content: LString('Liste non exhaustive.', 'Liste non exhaustive.'),
        bulletPoints: [
          LString('Cyanures: Hydroxocobalamine (Cyanokit)', 'Cyanures: Hydroxocobalamine (Cyanokit)'),
          LString('Bêta-bloquants: Glucagon 5-10 mg IV', 'Bêta-bloquants: Glucagon 5-10 mg IV'),
          LString('Calcium-bloqueurs: Calcium + glucagon + insuline', 'Calcium-bloqueurs: Calcium + glucagon + insuline'),
          LString('Fer: Déféroxamine', 'Fer: Déféroxamine'),
          LString('Organophosphorés: Atropine + Pralidoxime', 'Organophosphorés: Atropine + Pralidoxime'),
        ],
      ),
    ],
    keyPoints: LString('Chaque antidote a des indications précises. Centre antipoison disponible 24h/24.', 'Chaque antidote a des indications précises. Centre antipoison disponible 24h/24.'),
    source: LString('CAPTV - Centres antipoison', 'CAPTV - Centres antipoison'),
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
    name: LString('Acidocétose Diabétique', 'Acidocétose Diabétique'),
    category: ProtocolCategory.metabolic,
    description: LString('Décompensation métabolique du diabète avec cétose', 'Décompensation métabolique du diabète avec cétose'),
    indication: LString('Glycémie > 2.5 g/L + pH < 7.3 + cétonémie > 3 mmol/L ou cétonurie ++', 'Glycémie > 2.5 g/L + pH < 7.3 + cétonémie > 3 mmol/L ou cétonurie ++'),
    steps: [
      ProtocolStep(
        title: LString('1. Diagnostic', '1. Diagnostic'),
        content: LString('Critères diagnostiques.', 'Critères diagnostiques.'),
        bulletPoints: [
          LString('Glycémie > 2.5 g/L (souvent > 3 g/L)', 'Glycémie > 2.5 g/L (souvent > 3 g/L)'),
          LString('pH < 7.3 et/ou bicarbonates < 18 mmol/L', 'pH < 7.3 et/ou bicarbonates < 18 mmol/L'),
          LString('Cétonémie > 3 mmol/L ou cétonurie ≥ ++', 'Cétonémie > 3 mmol/L ou cétonurie ≥ ++'),
          LString('Trou anionique augmenté', 'Trou anionique augmenté'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Gravité', '2. Gravité'),
        content: LString('Stratification.', 'Stratification.'),
        bulletPoints: [
          LString('Légère: pH 7.25-7.30, GCS normal', 'Légère: pH 7.25-7.30, GCS normal'),
          LString('Modérée: pH 7.00-7.24, GCS normal', 'Modérée: pH 7.00-7.24, GCS normal'),
          LString('Sévère: pH < 7.00, troubles conscience', 'Sévère: pH < 7.00, troubles conscience'),
          LString('Critères USI: pH < 7.1, confusion, choc', 'Critères USI: pH < 7.1, confusion, choc'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Remplissage vasculaire', '3. Remplissage vasculaire'),
        content: LString('Priorité = réhydratation.', 'Priorité = réhydratation.'),
        bulletPoints: [
          LString('NaCl 0.9%: 1L/h pendant 2h puis 500 mL/h', 'NaCl 0.9%: 1L/h pendant 2h puis 500 mL/h'),
          LString('Déficit hydrique 5-10 L en moyenne', 'Déficit hydrique 5-10 L en moyenne'),
          LString('Relais G5% quand glycémie < 2.5 g/L', 'Relais G5% quand glycémie < 2.5 g/L'),
          LString('Adapter si insuffisance cardiaque', 'Adapter si insuffisance cardiaque'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Insulinothérapie', '4. Insulinothérapie'),
        content: LString('Après début du remplissage.', 'Après début du remplissage.'),
        bulletPoints: [
          LString('Insuline rapide IVSE 0.1 UI/kg/h', 'Insuline rapide IVSE 0.1 UI/kg/h'),
          LString('Objectif: baisse glycémie 0.5-0.7 g/L/h', 'Objectif: baisse glycémie 0.5-0.7 g/L/h'),
          LString('Maintenir IVSE tant que cétonémie > 0.5 mmol/L', 'Maintenir IVSE tant que cétonémie > 0.5 mmol/L'),
          LString('Ne pas arrêter insuline si glycémie basse: ajuster G5%', 'Ne pas arrêter insuline si glycémie basse: ajuster G5%'),
        ],
        warning: LString('Ne pas arrêter insuline même si glycémie normale tant que cétose', 'Ne pas arrêter insuline même si glycémie normale tant que cétose'),
      ),
      ProtocolStep(
        title: LString('5. Potassium', '5. Potassium'),
        content: LString('Surveillance et supplémentation.', 'Surveillance et supplémentation.'),
        bulletPoints: [
          LString('K+ souvent normal ou haut initialement malgré déficit total', 'K+ souvent normal ou haut initialement malgré déficit total'),
          LString('Si K+ < 3.3 mmol/L: différer insuline, supplémenter d\'abord', 'Si K+ < 3.3 mmol/L: différer insuline, supplémenter d\'abord'),
          LString('Si K+ 3.3-5.3: KCl 20-40 mEq/L de perfusion', 'Si K+ 3.3-5.3: KCl 20-40 mEq/L de perfusion'),
          LString('Si K+ > 5.3: pas de supplément, surveillance', 'Si K+ > 5.3: pas de supplément, surveillance'),
        ],
        warning: LString('Kaliémie peut chuter brutalement sous insuline', 'Kaliémie peut chuter brutalement sous insuline'),
      ),
      ProtocolStep(
        title: LString('6. Bicarbonates', '6. Bicarbonates'),
        content: LString('Indications très limitées.', 'Indications très limitées.'),
        bulletPoints: [
          LString('Seulement si pH < 6.9 (controversé)', 'Seulement si pH < 6.9 (controversé)'),
          LString('Pas de bénéfice prouvé si pH > 7.0', 'Pas de bénéfice prouvé si pH > 7.0'),
          LString('Si utilisé: 100 mmol + 20 mEq KCl en 2h', 'Si utilisé: 100 mmol + 20 mEq KCl en 2h'),
        ],
      ),
      ProtocolStep(
        title: LString('7. Rechercher facteur déclenchant', '7. Rechercher facteur déclenchant'),
        content: LString('Toujours.', 'Toujours.'),
        bulletPoints: [
          LString('Infection (NFS, CRP, ECBU, radio thorax)', 'Infection (NFS, CRP, ECBU, radio thorax)'),
          LString('Infarctus du myocarde (ECG, troponine)', 'Infarctus du myocarde (ECG, troponine)'),
          LString('Arrêt ou mauvaise observance insuline', 'Arrêt ou mauvaise observance insuline'),
          LString('Nouveau diabète', 'Nouveau diabète'),
        ],
      ),
    ],
    keyPoints: LString('Remplissage prioritaire. Insuline IVSE 0.1 UI/kg/h. K+ surveillance rapprochée. Traiter la cause.', 'Remplissage prioritaire. Insuline IVSE 0.1 UI/kg/h. K+ surveillance rapprochée. Traiter la cause.'),
    source: LString('ADA Standards 2024, SFD', 'ADA Standards 2024, SFD'),
    lastUpdated: 2024,
  ),

  // État hyperosmolaire
  Protocol(
    id: 'etat-hyperosmolaire',
    name: LString('État Hyperosmolaire Hyperglycémique', 'État Hyperosmolaire Hyperglycémique'),
    category: ProtocolCategory.metabolic,
    description: LString('Décompensation hyperglycémique sans cétose majeure', 'Décompensation hyperglycémique sans cétose majeure'),
    indication: LString('Glycémie > 6 g/L + Osmolarité > 320 mOsm/kg + absence cétose significative', 'Glycémie > 6 g/L + Osmolarité > 320 mOsm/kg + absence cétose significative'),
    steps: [
      ProtocolStep(
        title: LString('1. Caractéristiques', '1. Caractéristiques'),
        content: LString('Différences avec acidocétose.', 'Différences avec acidocétose.'),
        bulletPoints: [
          LString('Patient souvent âgé, diabète type 2', 'Patient souvent âgé, diabète type 2'),
          LString('Glycémie très élevée (souvent > 6 g/L)', 'Glycémie très élevée (souvent > 6 g/L)'),
          LString('Osmolarité > 320 mOsm/kg', 'Osmolarité > 320 mOsm/kg'),
          LString('Déshydratation majeure (déficit 8-12 L)', 'Déshydratation majeure (déficit 8-12 L)'),
          LString('Pas ou peu de cétose (pH > 7.30)', 'Pas ou peu de cétose (pH > 7.30)'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Réhydratation', '2. Réhydratation'),
        content: LString('Objectif principal.', 'Objectif principal.'),
        bulletPoints: [
          LString('NaCl 0.9% initialement: 1-1.5 L/h les 2 premières heures', 'NaCl 0.9% initialement: 1-1.5 L/h les 2 premières heures'),
          LString('Puis adapter selon natrémie corrigée et état HD', 'Puis adapter selon natrémie corrigée et état HD'),
          LString('Si Na corrigée > 145: NaCl 0.45%', 'Si Na corrigée > 145: NaCl 0.45%'),
          LString('Correction lente: 10% déficit les 2 premières heures', 'Correction lente: 10% déficit les 2 premières heures'),
          LString('Reste sur 24-48h', 'Reste sur 24-48h'),
        ],
        warning: LString('Réhydratation trop rapide = risque œdème cérébral', 'Réhydratation trop rapide = risque œdème cérébral'),
      ),
      ProtocolStep(
        title: LString('3. Insulinothérapie', '3. Insulinothérapie'),
        content: LString('Secondaire au remplissage.', 'Secondaire au remplissage.'),
        bulletPoints: [
          LString('Débuter après 1-2h de remplissage', 'Débuter après 1-2h de remplissage'),
          LString('Doses plus faibles: 0.05 UI/kg/h', 'Doses plus faibles: 0.05 UI/kg/h'),
          LString('Objectif: baisse glycémie progressive', 'Objectif: baisse glycémie progressive'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Potassium', '4. Potassium'),
        content: LString('Même vigilance que acidocétose.', 'Même vigilance que acidocétose.'),
        bulletPoints: [
          LString('Supplémentation selon kaliémie', 'Supplémentation selon kaliémie'),
          LString('Surveillance rapprochée', 'Surveillance rapprochée'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Anticoagulation', '5. Anticoagulation'),
        content: LString('Prévention thrombose.', 'Prévention thrombose.'),
        bulletPoints: [
          LString('Risque thromboembolique élevé', 'Risque thromboembolique élevé'),
          LString('HBPM préventive systématique', 'HBPM préventive systématique'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Facteur déclenchant', '6. Facteur déclenchant'),
        content: LString('Infection fréquente.', 'Infection fréquente.'),
        bulletPoints: [
          LString('Infection (50% des cas)', 'Infection (50% des cas)'),
          LString('Déshydratation, diarrhées', 'Déshydratation, diarrhées'),
          LString('Médicaments (corticoïdes, diurétiques)', 'Médicaments (corticoïdes, diurétiques)'),
          LString('AVC, IDM', 'AVC, IDM'),
        ],
      ),
    ],
    keyPoints: LString('Réhydratation massive mais progressive. Insuline après remplissage. Anticoagulation préventive.', 'Réhydratation massive mais progressive. Insuline après remplissage. Anticoagulation préventive.'),
    source: LString('ADA Standards 2024', 'ADA Standards 2024'),
    lastUpdated: 2024,
  ),

  // Hyperkaliémie
  Protocol(
    id: 'hyperkaliemie',
    name: LString('Hyperkaliémie', 'Hyperkaliémie'),
    category: ProtocolCategory.metabolic,
    description: LString('Kaliémie > 5.5 mmol/L', 'Kaliémie > 5.5 mmol/L'),
    indication: LString('K+ > 5.5 mmol/L et/ou signes ECG d\'hyperkaliémie', 'K+ > 5.5 mmol/L et/ou signes ECG d\'hyperkaliémie'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation gravité', '1. Évaluation gravité'),
        content: LString('Clinique et ECG.', 'Clinique et ECG.'),
        bulletPoints: [
          LString('Légère: 5.5-6.0 mmol/L, ECG normal', 'Légère: 5.5-6.0 mmol/L, ECG normal'),
          LString('Modérée: 6.0-6.5 mmol/L, ondes T pointues', 'Modérée: 6.0-6.5 mmol/L, ondes T pointues'),
          LString('Sévère: > 6.5 mmol/L ou signes ECG majeurs', 'Sévère: > 6.5 mmol/L ou signes ECG majeurs'),
          LString('ECG: ondes T amples, QRS large, bradycardie, FV', 'ECG: ondes T amples, QRS large, bradycardie, FV'),
        ],
        warning: LString('Toute hyperkaliémie symptomatique = urgence vitale', 'Toute hyperkaliémie symptomatique = urgence vitale'),
      ),
      ProtocolStep(
        title: LString('2. Protection myocardique', '2. Protection myocardique'),
        content: LString('Si ECG anormal ou K+ > 6.5.', 'Si ECG anormal ou K+ > 6.5.'),
        bulletPoints: [
          LString('Gluconate de calcium 10%: 10-20 mL IV en 2-5 min', 'Gluconate de calcium 10%: 10-20 mL IV en 2-5 min'),
          LString('Effet immédiat mais transitoire (30-60 min)', 'Effet immédiat mais transitoire (30-60 min)'),
          LString('Répétable si persistance anomalies ECG', 'Répétable si persistance anomalies ECG'),
          LString('Ne modifie pas la kaliémie', 'Ne modifie pas la kaliémie'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Transfert intracellulaire', '3. Transfert intracellulaire'),
        content: LString('Réduire la kaliémie.', 'Réduire la kaliémie.'),
        bulletPoints: [
          LString('Insuline 10 UI + G30% 50 mL IV (effet en 15-30 min)', 'Insuline 10 UI + G30% 50 mL IV (effet en 15-30 min)'),
          LString('Salbutamol nébulisé 10-20 mg (4-8 bouffées)', 'Salbutamol nébulisé 10-20 mg (4-8 bouffées)'),
          LString('Bicarbonates si acidose métabolique associée', 'Bicarbonates si acidose métabolique associée'),
          LString('Effet transitoire: 2-6 heures', 'Effet transitoire: 2-6 heures'),
        ],
        tip: LString('Surveiller glycémie après insuline-glucose', 'Surveiller glycémie après insuline-glucose'),
      ),
      ProtocolStep(
        title: LString('4. Élimination du potassium', '4. Élimination du potassium'),
        content: LString('Réduction du pool total.', 'Réduction du pool total.'),
        bulletPoints: [
          LString('Furosémide 40-80 mg IV si fonction rénale conservée', 'Furosémide 40-80 mg IV si fonction rénale conservée'),
          LString('Résines échangeuses: Kayexalate 30-60g PO ou lavement', 'Résines échangeuses: Kayexalate 30-60g PO ou lavement'),
          LString('Patiromer ou SZC (nouveaux chélateurs)', 'Patiromer ou SZC (nouveaux chélateurs)'),
          LString('Hémodialyse si sévère ou IRA anurique', 'Hémodialyse si sévère ou IRA anurique'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Traiter la cause', '5. Traiter la cause'),
        content: LString('Étiologie.', 'Étiologie.'),
        bulletPoints: [
          LString('Insuffisance rénale', 'Insuffisance rénale'),
          LString('Médicaments (IEC, ARA2, spironolactone, AINS)', 'Médicaments (IEC, ARA2, spironolactone, AINS)'),
          LString('Acidose', 'Acidose'),
          LString('Rhabdomyolyse, lyse tumorale', 'Rhabdomyolyse, lyse tumorale'),
          LString('Insuffisance surrénale', 'Insuffisance surrénale'),
        ],
      ),
    ],
    keyPoints: LString('ECG systématique. Calcium si signes ECG. Insuline-glucose pour baisser K+. Dialyse si sévère.', 'ECG systématique. Calcium si signes ECG. Insuline-glucose pour baisser K+. Dialyse si sévère.'),
    source: LString('KDIGO, HAS', 'KDIGO, HAS'),
    lastUpdated: 2022,
  ),

  // Hyponatrémie
  Protocol(
    id: 'hyponatremie',
    name: LString('Hyponatrémie', 'Hyponatrémie'),
    category: ProtocolCategory.metabolic,
    description: LString('Natrémie < 135 mmol/L', 'Natrémie < 135 mmol/L'),
    indication: LString('Na+ < 135 mmol/L et/ou symptômes neurologiques', 'Na+ < 135 mmol/L et/ou symptômes neurologiques'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation', '1. Évaluation'),
        content: LString('Gravité et chronologie.', 'Gravité et chronologie.'),
        bulletPoints: [
          LString('Aiguë (< 48h) vs chronique (> 48h ou inconnue)', 'Aiguë (< 48h) vs chronique (> 48h ou inconnue)'),
          LString('Légère: 130-135 mmol/L', 'Légère: 130-135 mmol/L'),
          LString('Modérée: 125-129 mmol/L', 'Modérée: 125-129 mmol/L'),
          LString('Sévère: < 125 mmol/L', 'Sévère: < 125 mmol/L'),
          LString('Symptômes: céphalées, confusion, convulsions, coma', 'Symptômes: céphalées, confusion, convulsions, coma'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Hyponatrémie symptomatique sévère', '2. Hyponatrémie symptomatique sévère'),
        content: LString('Urgence thérapeutique.', 'Urgence thérapeutique.'),
        bulletPoints: [
          LString('NaCl 3%: 100-150 mL en 20 min', 'NaCl 3%: 100-150 mL en 20 min'),
          LString('Répétable 2-3 fois si symptômes persistent', 'Répétable 2-3 fois si symptômes persistent'),
          LString('Objectif initial: ↑ Na+ de 4-6 mmol/L', 'Objectif initial: ↑ Na+ de 4-6 mmol/L'),
          LString('Limite: ↑ < 10 mmol/L/24h (< 8 si chronique)', 'Limite: ↑ < 10 mmol/L/24h (< 8 si chronique)'),
        ],
        warning: LString('Correction trop rapide = myélinolyse centropontine', 'Correction trop rapide = myélinolyse centropontine'),
      ),
      ProtocolStep(
        title: LString('3. Classification étiologique', '3. Classification étiologique'),
        content: LString('Selon volémie.', 'Selon volémie.'),
        bulletPoints: [
          LString('Hypovolémique: déshydratation, diurétiques, pertes digestives', 'Hypovolémique: déshydratation, diurétiques, pertes digestives'),
          LString('Euvolémique: SIADH, hypothyroïdie, insuffisance surrénale', 'Euvolémique: SIADH, hypothyroïdie, insuffisance surrénale'),
          LString('Hypervolémique: insuffisance cardiaque, cirrhose, IRC', 'Hypervolémique: insuffisance cardiaque, cirrhose, IRC'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Traitement selon cause', '4. Traitement selon cause'),
        content: LString('Adapter au mécanisme.', 'Adapter au mécanisme.'),
        bulletPoints: [
          LString('Hypovolémique: NaCl 0.9%', 'Hypovolémique: NaCl 0.9%'),
          LString('SIADH: restriction hydrique ± urée ± tolvaptan', 'SIADH: restriction hydrique ± urée ± tolvaptan'),
          LString('Hypervolémique: restriction hydrique + diurétiques', 'Hypervolémique: restriction hydrique + diurétiques'),
          LString('Arrêt médicaments causaux', 'Arrêt médicaments causaux'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Surveillance', '5. Surveillance'),
        content: LString('Contrôles rapprochés.', 'Contrôles rapprochés.'),
        bulletPoints: [
          LString('Natrémie toutes les 2-4h initialement', 'Natrémie toutes les 2-4h initialement'),
          LString('Diurèse horaire', 'Diurèse horaire'),
          LString('Si surcorrection: abaisser Na+ (G5%, desmopressine)', 'Si surcorrection: abaisser Na+ (G5%, desmopressine)'),
        ],
      ),
    ],
    keyPoints: LString('Symptomatique sévère = NaCl 3%. Correction lente si chronique (< 10/24h). Traiter selon volémie.', 'Symptomatique sévère = NaCl 3%. Correction lente si chronique (< 10/24h). Traiter selon volémie.'),
    source: LString('ESE 2014 - Hyponatremia', 'ESE 2014 - Hyponatremia'),
    lastUpdated: 2014,
  ),

  // Hypoglycémie
  Protocol(
    id: 'hypoglycemie',
    name: LString('Hypoglycémie', 'Hypoglycémie'),
    category: ProtocolCategory.metabolic,
    description: LString('Glycémie < 0.70 g/L avec ou sans symptômes', 'Glycémie < 0.70 g/L avec ou sans symptômes'),
    indication: LString('Glycémie < 0.70 g/L ou symptômes neuroglycopéniques', 'Glycémie < 0.70 g/L ou symptômes neuroglycopéniques'),
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Reconnaissance'),
        content: LString('Signes cliniques.', 'Signes cliniques.'),
        bulletPoints: [
          LString('Neuroglycopéniques: confusion, troubles visuels, convulsions, coma', 'Neuroglycopéniques: confusion, troubles visuels, convulsions, coma'),
          LString('Adrénergiques: sueurs, tremblements, palpitations, faim', 'Adrénergiques: sueurs, tremblements, palpitations, faim'),
          LString('Seuil variable selon patients (diabétiques ++)', 'Seuil variable selon patients (diabétiques ++)'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Patient conscient', '2. Patient conscient'),
        content: LString('Resucrage oral.', 'Resucrage oral.'),
        bulletPoints: [
          LString('15-20g de glucides rapides', '15-20g de glucides rapides'),
          LString('3-4 morceaux de sucre ou jus de fruits', '3-4 morceaux de sucre ou jus de fruits'),
          LString('Recontrôle à 15 min', 'Recontrôle à 15 min'),
          LString('Répéter si glycémie toujours basse', 'Répéter si glycémie toujours basse'),
          LString('Puis collation avec sucres lents', 'Puis collation avec sucres lents'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Patient inconscient ou ne pouvant avaler', '3. Patient inconscient ou ne pouvant avaler'),
        content: LString('Resucrage parentéral.', 'Resucrage parentéral.'),
        bulletPoints: [
          LString('G30%: 20-40 mL IV (ou 50 mL G50%)', 'G30%: 20-40 mL IV (ou 50 mL G50%)'),
          LString('ou Glucagon 1 mg IM/SC (si pas d\'accès IV)', 'ou Glucagon 1 mg IM/SC (si pas d\'accès IV)'),
          LString('Relais perfusion G10% après réveil', 'Relais perfusion G10% après réveil'),
          LString('Glucagon moins efficace si réserves glycogène épuisées', 'Glucagon moins efficace si réserves glycogène épuisées'),
        ],
        warning: LString('Glucagon inefficace si intoxication alcoolique ou jeûne prolongé', 'Glucagon inefficace si intoxication alcoolique ou jeûne prolongé'),
      ),
      ProtocolStep(
        title: LString('4. Causes à rechercher', '4. Causes à rechercher'),
        content: LString('Étiologie.', 'Étiologie.'),
        bulletPoints: [
          LString('Diabétique: insuline, sulfamides (surdosage, jeûne)', 'Diabétique: insuline, sulfamides (surdosage, jeûne)'),
          LString('Non diabétique: alcool, insuffisance surrénale', 'Non diabétique: alcool, insuffisance surrénale'),
          LString('Insuffisance hépatique, insuffisance rénale', 'Insuffisance hépatique, insuffisance rénale'),
          LString('Insulinome, tumeurs', 'Insulinome, tumeurs'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Surveillance et prévention', '5. Surveillance et prévention'),
        content: LString('Éviter récidive.', 'Éviter récidive.'),
        bulletPoints: [
          LString('Surveillance glycémique rapprochée', 'Surveillance glycémique rapprochée'),
          LString('Durée surveillance selon cause (sulfamides: 24-48h)', 'Durée surveillance selon cause (sulfamides: 24-48h)'),
          LString('Éducation patient et entourage', 'Éducation patient et entourage'),
          LString('Adapter traitement antidiabétique', 'Adapter traitement antidiabétique'),
        ],
      ),
    ],
    keyPoints: LString('G30% IV si inconscient. Glucagon si pas d\'accès. Rechercher cause. Surveillance prolongée si sulfamides.', 'G30% IV si inconscient. Glucagon si pas d\'accès. Rechercher cause. Surveillance prolongée si sulfamides.'),
    source: LString('ADA, SFD', 'ADA, SFD'),
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
    name: LString('ACR Pédiatrique', 'ACR Pédiatrique'),
    category: ProtocolCategory.pediatric,
    description: LString('Arrêt cardiorespiratoire de l\'enfant selon ERC 2021', 'Arrêt cardiorespiratoire de l\'enfant selon ERC 2021'),
    indication: LString('Enfant en arrêt cardiaque (absence de signes de vie)', 'Enfant en arrêt cardiaque (absence de signes de vie)'),
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Reconnaissance'),
        content: LString('Identifier l\'ACR.', 'Identifier l\'ACR.'),
        bulletPoints: [
          LString('Absence de réponse à stimulation', 'Absence de réponse à stimulation'),
          LString('Absence de respiration normale (gasps = arrêt)', 'Absence de respiration normale (gasps = arrêt)'),
          LString('Pas de pouls perçu en 10 secondes (optionnel)', 'Pas de pouls perçu en 10 secondes (optionnel)'),
          LString('Alerter les secours (15/112)', 'Alerter les secours (15/112)'),
        ],
      ),
      ProtocolStep(
        title: LString('2. RCP de base', '2. RCP de base'),
        content: LString('Commencer immédiatement.', 'Commencer immédiatement.'),
        bulletPoints: [
          LString('Commencer par 5 insufflations', 'Commencer par 5 insufflations'),
          LString('Puis MCE: 100-120/min', 'Puis MCE: 100-120/min'),
          LString('Profondeur: 1/3 du thorax (4 cm nourrisson, 5 cm enfant)', 'Profondeur: 1/3 du thorax (4 cm nourrisson, 5 cm enfant)'),
          LString('Ratio 15:2 (si 2 secouristes professionnels)', 'Ratio 15:2 (si 2 secouristes professionnels)'),
          LString('Ratio 30:2 si seul', 'Ratio 30:2 si seul'),
        ],
        tip: LString('5 insufflations d\'abord car cause souvent respiratoire chez l\'enfant', '5 insufflations d\'abord car cause souvent respiratoire chez l\'enfant'),
      ),
      ProtocolStep(
        title: LString('3. Défibrillation', '3. Défibrillation'),
        content: LString('Dès que DSA disponible.', 'Dès que DSA disponible.'),
        bulletPoints: [
          LString('Électrodes pédiatriques si < 8 ans ou < 25 kg', 'Électrodes pédiatriques si < 8 ans ou < 25 kg'),
          LString('Choc 4 J/kg', 'Choc 4 J/kg'),
          LString('Reprendre MCE immédiatement après choc', 'Reprendre MCE immédiatement après choc'),
          LString('Analyser toutes les 2 minutes', 'Analyser toutes les 2 minutes'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Voies d\'administration', '4. Voies d\'administration'),
        content: LString('Accès vasculaire.', 'Accès vasculaire.'),
        bulletPoints: [
          LString('VVP en première intention', 'VVP en première intention'),
          LString('Voie intra-osseuse si échec (< 60 sec)', 'Voie intra-osseuse si échec (< 60 sec)'),
          LString('Sites IO: tibia proximal, fémur distal', 'Sites IO: tibia proximal, fémur distal'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Adrénaline', '5. Adrénaline'),
        content: LString('Doses pédiatriques.', 'Doses pédiatriques.'),
        bulletPoints: [
          LString('10 µg/kg IV/IO (0.1 mL/kg adrénaline 1/10000)', '10 µg/kg IV/IO (0.1 mL/kg adrénaline 1/10000)'),
          LString('Rythme non choquable: dès que possible', 'Rythme non choquable: dès que possible'),
          LString('Rythme choquable: après 3ème choc', 'Rythme choquable: après 3ème choc'),
          LString('Répéter toutes les 3-5 min', 'Répéter toutes les 3-5 min'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Amiodarone', '6. Amiodarone'),
        content: LString('Si FV/TV réfractaire.', 'Si FV/TV réfractaire.'),
        bulletPoints: [
          LString('5 mg/kg après le 3ème choc', '5 mg/kg après le 3ème choc'),
          LString('Répéter 5 mg/kg après 5ème choc', 'Répéter 5 mg/kg après 5ème choc'),
        ],
      ),
      ProtocolStep(
        title: LString('7. Causes réversibles', '7. Causes réversibles'),
        content: LString('4H et 4T pédiatriques.', '4H et 4T pédiatriques.'),
        bulletPoints: [
          LString('Hypoxie (cause la plus fréquente)', 'Hypoxie (cause la plus fréquente)'),
          LString('Hypovolémie', 'Hypovolémie'),
          LString('Hypo/hyperkaliémie, hypoglycémie', 'Hypo/hyperkaliémie, hypoglycémie'),
          LString('Hypothermie', 'Hypothermie'),
          LString('Tamponnade', 'Tamponnade'),
          LString('Tension pneumothorax', 'Tension pneumothorax'),
          LString('Thrombose (EP rare chez enfant)', 'Thrombose (EP rare chez enfant)'),
          LString('Toxiques', 'Toxiques'),
        ],
      ),
    ],
    keyPoints: LString('5 insufflations d\'abord. MCE 15:2. Adrénaline 10 µg/kg. Cause souvent respiratoire.', '5 insufflations d\'abord. MCE 15:2. Adrénaline 10 µg/kg. Cause souvent respiratoire.'),
    source: LString('ERC Guidelines 2021 - Pediatric Life Support', 'ERC Guidelines 2021 - Pediatric Life Support'),
    sourceUrl: 'https://www.erc.edu',
    lastUpdated: 2021,
  ),

  // Bronchiolite
  Protocol(
    id: 'bronchiolite',
    name: LString('Bronchiolite Aiguë', 'Bronchiolite Aiguë'),
    category: ProtocolCategory.pediatric,
    description: LString('Infection virale des voies aériennes inférieures du nourrisson', 'Infection virale des voies aériennes inférieures du nourrisson'),
    indication: LString('Nourrisson < 12 mois avec dyspnée sifflante et signes de lutte', 'Nourrisson < 12 mois avec dyspnée sifflante et signes de lutte'),
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: LString('1. Diagnostic clinique', '1. Diagnostic clinique'),
        content: LString('Reconnaître la bronchiolite.', 'Reconnaître la bronchiolite.'),
        bulletPoints: [
          LString('Nourrisson < 12 mois', 'Nourrisson < 12 mois'),
          LString('Rhinite puis toux, dyspnée', 'Rhinite puis toux, dyspnée'),
          LString('Sibilants ± crépitants', 'Sibilants ± crépitants'),
          LString('Signes de lutte: tirage, battement ailes du nez', 'Signes de lutte: tirage, battement ailes du nez'),
          LString('Premier épisode (sinon: asthme du nourrisson)', 'Premier épisode (sinon: asthme du nourrisson)'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Évaluation gravité', '2. Évaluation gravité'),
        content: LString('Critères d\'hospitalisation.', 'Critères d\'hospitalisation.'),
        bulletPoints: [
          LString('Âge < 6 semaines', 'Âge < 6 semaines'),
          LString('Prématurité < 34 SA', 'Prématurité < 34 SA'),
          LString('SpO2 < 92% en air ambiant', 'SpO2 < 92% en air ambiant'),
          LString('Difficultés alimentaires > 50% des apports', 'Difficultés alimentaires > 50% des apports'),
          LString('Apnées, épuisement', 'Apnées, épuisement'),
          LString('Terrain: cardiopathie, pathologie respiratoire', 'Terrain: cardiopathie, pathologie respiratoire'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Désobstruction rhinopharyngée', '3. Désobstruction rhinopharyngée'),
        content: LString('Mesure essentielle.', 'Mesure essentielle.'),
        bulletPoints: [
          LString('DRP au sérum physiologique', 'DRP au sérum physiologique'),
          LString('Avant les repas et au coucher', 'Avant les repas et au coucher'),
          LString('Fragmentation des repas', 'Fragmentation des repas'),
          LString('Position proclive dorsale 30°', 'Position proclive dorsale 30°'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Oxygénothérapie', '4. Oxygénothérapie'),
        content: LString('Si hypoxémie.', 'Si hypoxémie.'),
        bulletPoints: [
          LString('Si SpO2 < 92%', 'Si SpO2 < 92%'),
          LString('Objectif SpO2 > 92%', 'Objectif SpO2 > 92%'),
          LString('Lunettes nasales, débit adapté', 'Lunettes nasales, débit adapté'),
          LString('Optiflow (HFNC) si besoin élevé', 'Optiflow (HFNC) si besoin élevé'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Hydratation/Nutrition', '5. Hydratation/Nutrition'),
        content: LString('Maintenir les apports.', 'Maintenir les apports.'),
        bulletPoints: [
          LString('Fractionnement des repas', 'Fractionnement des repas'),
          LString('SNG si difficultés alimentaires > 50%', 'SNG si difficultés alimentaires > 50%'),
          LString('Perfusion si alimentation impossible', 'Perfusion si alimentation impossible'),
          LString('Surveillance diurèse', 'Surveillance diurèse'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Traitements NON recommandés', '6. Traitements NON recommandés'),
        content: LString('À éviter.', 'À éviter.'),
        bulletPoints: [
          LString('Bronchodilatateurs (pas d\'efficacité prouvée)', 'Bronchodilatateurs (pas d\'efficacité prouvée)'),
          LString('Corticoïdes', 'Corticoïdes'),
          LString('Antibiotiques (sauf surinfection)', 'Antibiotiques (sauf surinfection)'),
          LString('Kinésithérapie respiratoire systématique', 'Kinésithérapie respiratoire systématique'),
        ],
        warning: LString('Pas de salbutamol en 1ère intention', 'Pas de salbutamol en 1ère intention'),
      ),
      ProtocolStep(
        title: LString('7. Critères de sortie', '7. Critères de sortie'),
        content: LString('Conditions de retour à domicile.', 'Conditions de retour à domicile.'),
        bulletPoints: [
          LString('SpO2 > 92% en air ambiant', 'SpO2 > 92% en air ambiant'),
          LString('Alimentation > 50% des besoins', 'Alimentation > 50% des besoins'),
          LString('Pas d\'apnée', 'Pas d\'apnée'),
          LString('Parents formés à la surveillance', 'Parents formés à la surveillance'),
        ],
      ),
    ],
    keyPoints: LString('DRP + O2 si besoin + hydratation. Pas de bronchodilatateurs ni corticoïdes. Hospitalisation si < 6 sem ou SpO2 < 92%.', 'DRP + O2 si besoin + hydratation. Pas de bronchodilatateurs ni corticoïdes. Hospitalisation si < 6 sem ou SpO2 < 92%.'),
    source: LString('HAS 2019 - Bronchiolite aiguë du nourrisson', 'HAS 2019 - Bronchiolite aiguë du nourrisson'),
    sourceUrl: 'https://www.has-sante.fr',
    lastUpdated: 2019,
  ),

  // Convulsions fébriles
  Protocol(
    id: 'convulsions-febriles',
    name: LString('Convulsions Fébriles', 'Convulsions Fébriles'),
    category: ProtocolCategory.pediatric,
    description: LString('Crise convulsive associée à la fièvre chez l\'enfant', 'Crise convulsive associée à la fièvre chez l\'enfant'),
    indication: LString('Enfant 6 mois - 5 ans avec convulsions et fièvre', 'Enfant 6 mois - 5 ans avec convulsions et fièvre'),
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: LString('1. Prise en charge immédiate', '1. Prise en charge immédiate'),
        content: LString('Pendant la crise.', 'Pendant la crise.'),
        bulletPoints: [
          LString('PLS, protection', 'PLS, protection'),
          LString('Déshabiller l\'enfant', 'Déshabiller l\'enfant'),
          LString('Mesurer la température', 'Mesurer la température'),
          LString('Noter l\'heure de début', 'Noter l\'heure de début'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Si crise > 5 min', '2. Si crise > 5 min'),
        content: LString('Traitement anticonvulsivant.', 'Traitement anticonvulsivant.'),
        bulletPoints: [
          LString('Diazépam intra-rectal 0.5 mg/kg (max 10 mg)', 'Diazépam intra-rectal 0.5 mg/kg (max 10 mg)'),
          LString('ou Midazolam buccal/nasal 0.3 mg/kg', 'ou Midazolam buccal/nasal 0.3 mg/kg'),
          LString('Répéter une fois après 5 min si échec', 'Répéter une fois après 5 min si échec'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Classification', '3. Classification'),
        content: LString('Simple vs complexe.', 'Simple vs complexe.'),
        bulletPoints: [
          LString('Simple: < 15 min, généralisée, unique/24h, 1-5 ans, pas de déficit post-critique', 'Simple: < 15 min, généralisée, unique/24h, 1-5 ans, pas de déficit post-critique'),
          LString('Complexe: > 15 min, focale, répétée, < 1 an ou > 5 ans, déficit post-critique', 'Complexe: > 15 min, focale, répétée, < 1 an ou > 5 ans, déficit post-critique'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Convulsion fébrile simple', '4. Convulsion fébrile simple'),
        content: LString('Bilan minimal.', 'Bilan minimal.'),
        bulletPoints: [
          LString('Rechercher foyer infectieux', 'Rechercher foyer infectieux'),
          LString('Pas de bilan sanguin systématique', 'Pas de bilan sanguin systématique'),
          LString('Pas de PL si > 12 mois et examen normal', 'Pas de PL si > 12 mois et examen normal'),
          LString('Pas d\'EEG', 'Pas d\'EEG'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Convulsion fébrile complexe', '5. Convulsion fébrile complexe'),
        content: LString('Bilan plus complet.', 'Bilan plus complet.'),
        bulletPoints: [
          LString('PL si < 12 mois ou signes méningés', 'PL si < 12 mois ou signes méningés'),
          LString('Bilan sanguin selon contexte', 'Bilan sanguin selon contexte'),
          LString('EEG à distance discuté', 'EEG à distance discuté'),
          LString('Imagerie si signes focaux', 'Imagerie si signes focaux'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Traitement antipyrétique', '6. Traitement antipyrétique'),
        content: LString('Confort de l\'enfant.', 'Confort de l\'enfant.'),
        bulletPoints: [
          LString('Paracétamol 15 mg/kg/6h', 'Paracétamol 15 mg/kg/6h'),
          LString('Ne prévient PAS les récidives', 'Ne prévient PAS les récidives'),
          LString('Objectif: confort, pas la normothermie', 'Objectif: confort, pas la normothermie'),
        ],
      ),
      ProtocolStep(
        title: LString('7. Information parentale', '7. Information parentale'),
        content: LString('Éducation.', 'Éducation.'),
        bulletPoints: [
          LString('Pronostic excellent pour CF simple', 'Pronostic excellent pour CF simple'),
          LString('Récidive possible (30%)', 'Récidive possible (30%)'),
          LString('CAT si récidive à domicile', 'CAT si récidive à domicile'),
          LString('Prescription diazépam rectal si récidive', 'Prescription diazépam rectal si récidive'),
        ],
      ),
    ],
    keyPoints: LString('PLS + diazépam si > 5 min. CF simple = bénigne, bilan minimal. CF complexe = bilan selon clinique.', 'PLS + diazépam si > 5 min. CF simple = bénigne, bilan minimal. CF complexe = bilan selon clinique.'),
    source: LString('SFP, HAS', 'SFP, HAS'),
    lastUpdated: 2020,
  ),

  // Déshydratation aiguë
  Protocol(
    id: 'deshydratation-pediatrique',
    name: LString('Déshydratation Aiguë de l\'Enfant', 'Déshydratation Aiguë de l\'Enfant'),
    category: ProtocolCategory.pediatric,
    description: LString('Perte hydro-électrolytique aiguë chez l\'enfant', 'Perte hydro-électrolytique aiguë chez l\'enfant'),
    indication: LString('Enfant avec diarrhée/vomissements et signes de déshydratation', 'Enfant avec diarrhée/vomissements et signes de déshydratation'),
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation gravité', '1. Évaluation gravité'),
        content: LString('Classification OMS.', 'Classification OMS.'),
        bulletPoints: [
          LString('Légère (< 5%): soif, muqueuses sèches', 'Légère (< 5%): soif, muqueuses sèches'),
          LString('Modérée (5-9%): yeux cernés, pli cutané, oligourie', 'Modérée (5-9%): yeux cernés, pli cutané, oligourie'),
          LString('Sévère (≥ 10%): choc, trouble conscience, marbrures', 'Sévère (≥ 10%): choc, trouble conscience, marbrures'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Déshydratation légère-modérée', '2. Déshydratation légère-modérée'),
        content: LString('Réhydratation orale.', 'Réhydratation orale.'),
        bulletPoints: [
          LString('SRO (Soluté de Réhydratation Orale)', 'SRO (Soluté de Réhydratation Orale)'),
          LString('Volume: 50-100 mL/kg sur 4h', 'Volume: 50-100 mL/kg sur 4h'),
          LString('Petites quantités fréquentes', 'Petites quantités fréquentes'),
          LString('Poursuivre allaitement', 'Poursuivre allaitement'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Déshydratation sévère ou échec SRO', '3. Déshydratation sévère ou échec SRO'),
        content: LString('Réhydratation IV.', 'Réhydratation IV.'),
        bulletPoints: [
          LString('Bolus NaCl 0.9%: 20 mL/kg en 20 min', 'Bolus NaCl 0.9%: 20 mL/kg en 20 min'),
          LString('Répéter si choc persistant', 'Répéter si choc persistant'),
          LString('Puis perfusion d\'entretien', 'Puis perfusion d\'entretien'),
          LString('NaCl 0.9% + G5% selon glycémie', 'NaCl 0.9% + G5% selon glycémie'),
        ],
        warning: LString('Si choc: remplissage rapide 20 mL/kg, répétable', 'Si choc: remplissage rapide 20 mL/kg, répétable'),
      ),
      ProtocolStep(
        title: LString('4. Calcul des besoins', '4. Calcul des besoins'),
        content: LString('Déficit + entretien + pertes.', 'Déficit + entretien + pertes.'),
        bulletPoints: [
          LString('Déficit = % déshydratation x poids (kg) x 10 = mL', 'Déficit = % déshydratation x poids (kg) x 10 = mL'),
          LString('Entretien: règle des 4-2-1 mL/kg/h', 'Entretien: règle des 4-2-1 mL/kg/h'),
          LString('Pertes en cours: estimation', 'Pertes en cours: estimation'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Surveillance', '5. Surveillance'),
        content: LString('Réévaluation régulière.', 'Réévaluation régulière.'),
        bulletPoints: [
          LString('Poids (référence +++)', 'Poids (référence +++)'),
          LString('Fréquence cardiaque, TRC', 'Fréquence cardiaque, TRC'),
          LString('Diurèse', 'Diurèse'),
          LString('État neurologique', 'État neurologique'),
          LString('Ionogramme si IV', 'Ionogramme si IV'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Réalimentation précoce', '6. Réalimentation précoce'),
        content: LString('Ne pas prolonger le jeûne.', 'Ne pas prolonger le jeûne.'),
        bulletPoints: [
          LString('Réalimentation dès que possible (< 4h)', 'Réalimentation dès que possible (< 4h)'),
          LString('Alimentation normale adaptée à l\'âge', 'Alimentation normale adaptée à l\'âge'),
          LString('Pas de régime restrictif prolongé', 'Pas de régime restrictif prolongé'),
        ],
      ),
    ],
    keyPoints: LString('SRO en première intention. IV si sévère ou échec. Poids = meilleur critère. Réalimentation précoce.', 'SRO en première intention. IV si sévère ou échec. Poids = meilleur critère. Réalimentation précoce.'),
    source: LString('ESPGHAN 2014, HAS', 'ESPGHAN 2014, HAS'),
    lastUpdated: 2014,
  ),

  // Laryngite aiguë
  Protocol(
    id: 'laryngite',
    name: LString('Laryngite Aiguë (Croup)', 'Laryngite Aiguë (Croup)'),
    category: ProtocolCategory.pediatric,
    description: LString('Inflammation sous-glottique virale', 'Inflammation sous-glottique virale'),
    indication: LString('Enfant 6 mois - 3 ans avec stridor inspiratoire et toux aboyante', 'Enfant 6 mois - 3 ans avec stridor inspiratoire et toux aboyante'),
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: LString('1. Diagnostic clinique', '1. Diagnostic clinique'),
        content: LString('Tableau typique.', 'Tableau typique.'),
        bulletPoints: [
          LString('Âge: 6 mois - 3 ans', 'Âge: 6 mois - 3 ans'),
          LString('Début nocturne brutal', 'Début nocturne brutal'),
          LString('Toux aboyante ("chien")', 'Toux aboyante ("chien")'),
          LString('Stridor inspiratoire', 'Stridor inspiratoire'),
          LString('Voix rauque', 'Voix rauque'),
          LString('Fièvre modérée', 'Fièvre modérée'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Score de gravité (Westley)', '2. Score de gravité (Westley)'),
        content: LString('Évaluer la sévérité.', 'Évaluer la sévérité.'),
        bulletPoints: [
          LString('Stridor: 0 (absent) à 2 (au repos)', 'Stridor: 0 (absent) à 2 (au repos)'),
          LString('Tirage: 0 à 3', 'Tirage: 0 à 3'),
          LString('Entrée d\'air: 0 à 2', 'Entrée d\'air: 0 à 2'),
          LString('Cyanose: 0 ou 5', 'Cyanose: 0 ou 5'),
          LString('Conscience: 0 ou 5', 'Conscience: 0 ou 5'),
          LString('Léger: 0-2, Modéré: 3-7, Sévère: 8-11, Imminente: ≥ 12', 'Léger: 0-2, Modéré: 3-7, Sévère: 8-11, Imminente: ≥ 12'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Laryngite légère', '3. Laryngite légère'),
        content: LString('Traitement ambulatoire.', 'Traitement ambulatoire.'),
        bulletPoints: [
          LString('Dexaméthasone 0.15-0.6 mg/kg PO dose unique', 'Dexaméthasone 0.15-0.6 mg/kg PO dose unique'),
          LString('ou Prednisolone 1-2 mg/kg', 'ou Prednisolone 1-2 mg/kg'),
          LString('Humidification (pas de preuve mais habituel)', 'Humidification (pas de preuve mais habituel)'),
          LString('Surveillance parentale', 'Surveillance parentale'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Laryngite modérée-sévère', '4. Laryngite modérée-sévère'),
        content: LString('Traitement hospitalier.', 'Traitement hospitalier.'),
        bulletPoints: [
          LString('Dexaméthasone 0.6 mg/kg PO/IM/IV', 'Dexaméthasone 0.6 mg/kg PO/IM/IV'),
          LString('Adrénaline nébulisée 0.5 mL/kg (max 5 mL) L-adrénaline 1‰', 'Adrénaline nébulisée 0.5 mL/kg (max 5 mL) L-adrénaline 1‰'),
          LString('Effet adrénaline transitoire: surveiller 2-4h', 'Effet adrénaline transitoire: surveiller 2-4h'),
          LString('O2 si SpO2 < 92%', 'O2 si SpO2 < 92%'),
        ],
        tip: LString('Adrénaline = effet rapide mais transitoire', 'Adrénaline = effet rapide mais transitoire'),
      ),
      ProtocolStep(
        title: LString('5. Laryngite sévère/échec', '5. Laryngite sévère/échec'),
        content: LString('Escalade.', 'Escalade.'),
        bulletPoints: [
          LString('Répéter adrénaline nébulisée', 'Répéter adrénaline nébulisée'),
          LString('Mélange hélium-O2 (Heliox) si disponible', 'Mélange hélium-O2 (Heliox) si disponible'),
          LString('Intubation si détresse majeure (tube plus petit)', 'Intubation si détresse majeure (tube plus petit)'),
        ],
        warning: LString('Prévoir tube de plus petit calibre (œdème)', 'Prévoir tube de plus petit calibre (œdème)'),
      ),
      ProtocolStep(
        title: LString('6. Diagnostics différentiels', '6. Diagnostics différentiels'),
        content: LString('À éliminer.', 'À éliminer.'),
        bulletPoints: [
          LString('Épiglottite (rare depuis vaccination Hib)', 'Épiglottite (rare depuis vaccination Hib)'),
          LString('Corps étranger', 'Corps étranger'),
          LString('Abcès rétropharyngé', 'Abcès rétropharyngé'),
          LString('Anaphylaxie', 'Anaphylaxie'),
        ],
      ),
    ],
    keyPoints: LString('Corticoïdes systématiques. Adrénaline nébulisée si modéré/sévère. Surveillance 2-4h après adrénaline.', 'Corticoïdes systématiques. Adrénaline nébulisée si modéré/sévère. Surveillance 2-4h après adrénaline.'),
    source: LString('SFP, Cochrane Review', 'SFP, Cochrane Review'),
    lastUpdated: 2021,
  ),

  // Choc pédiatrique
  Protocol(
    id: 'choc-pediatrique',
    name: LString('État de Choc Pédiatrique', 'État de Choc Pédiatrique'),
    category: ProtocolCategory.pediatric,
    description: LString('Insuffisance circulatoire aiguë de l\'enfant', 'Insuffisance circulatoire aiguë de l\'enfant'),
    indication: LString('Tachycardie + signes d\'hypoperfusion (TRC > 3s, marbrures, troubles conscience)', 'Tachycardie + signes d\'hypoperfusion (TRC > 3s, marbrures, troubles conscience)'),
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Reconnaissance'),
        content: LString('Signes de choc.', 'Signes de choc.'),
        bulletPoints: [
          LString('Tachycardie (signe précoce)', 'Tachycardie (signe précoce)'),
          LString('TRC > 3 secondes', 'TRC > 3 secondes'),
          LString('Marbrures, extrémités froides', 'Marbrures, extrémités froides'),
          LString('Pouls filants', 'Pouls filants'),
          LString('Troubles conscience', 'Troubles conscience'),
          LString('Hypotension = signe TARDIF chez l\'enfant', 'Hypotension = signe TARDIF chez l\'enfant'),
        ],
        warning: LString('L\'hypotension est tardive chez l\'enfant. Ne pas l\'attendre!', 'L\'hypotension est tardive chez l\'enfant. Ne pas l\'attendre!'),
      ),
      ProtocolStep(
        title: LString('2. Accès vasculaire', '2. Accès vasculaire'),
        content: LString('Rapide et efficace.', 'Rapide et efficace.'),
        bulletPoints: [
          LString('VVP en priorité', 'VVP en priorité'),
          LString('Voie IO si échec < 60 secondes', 'Voie IO si échec < 60 secondes'),
          LString('Sites IO: tibia proximal ++', 'Sites IO: tibia proximal ++'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Remplissage initial', '3. Remplissage initial'),
        content: LString('Bolus de cristalloïdes.', 'Bolus de cristalloïdes.'),
        bulletPoints: [
          LString('NaCl 0.9% 20 mL/kg en 5-10 min', 'NaCl 0.9% 20 mL/kg en 5-10 min'),
          LString('Réévaluer après chaque bolus', 'Réévaluer après chaque bolus'),
          LString('Répéter jusqu\'à 60 mL/kg si nécessaire', 'Répéter jusqu\'à 60 mL/kg si nécessaire'),
          LString('Attention surcharge si cardiopathie', 'Attention surcharge si cardiopathie'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Si choc réfractaire', '4. Si choc réfractaire'),
        content: LString('Vasopresseurs.', 'Vasopresseurs.'),
        bulletPoints: [
          LString('Adrénaline 0.1-1 µg/kg/min (choc froid)', 'Adrénaline 0.1-1 µg/kg/min (choc froid)'),
          LString('Noradrénaline 0.1-1 µg/kg/min (choc chaud)', 'Noradrénaline 0.1-1 µg/kg/min (choc chaud)'),
          LString('VVC si possible mais ne pas retarder traitement', 'VVC si possible mais ne pas retarder traitement'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Orientation étiologique', '5. Orientation étiologique'),
        content: LString('Adapter le traitement.', 'Adapter le traitement.'),
        bulletPoints: [
          LString('Septique: ATB précoce, remplissage, vasopresseurs', 'Septique: ATB précoce, remplissage, vasopresseurs'),
          LString('Hypovolémique: remplissage, transfusion si hémorragie', 'Hypovolémique: remplissage, transfusion si hémorragie'),
          LString('Cardiogénique: prudence remplissage, inotropes', 'Cardiogénique: prudence remplissage, inotropes'),
          LString('Anaphylactique: adrénaline IM, remplissage', 'Anaphylactique: adrénaline IM, remplissage'),
        ],
      ),
    ],
    keyPoints: LString('Tachycardie = signe précoce. Bolus 20 mL/kg répétés. IO si échec VVP. Hypotension = tardif.', 'Tachycardie = signe précoce. Bolus 20 mL/kg répétés. IO si échec VVP. Hypotension = tardif.'),
    source: LString('ERC 2021, ACCM Guidelines', 'ERC 2021, ACCM Guidelines'),
    lastUpdated: 2021,
  ),

  // Purpura de l'enfant
  Protocol(
    id: 'purpura-enfant',
    name: LString('Purpura de l\'Enfant', 'Purpura de l\'Enfant'),
    category: ProtocolCategory.pediatric,
    description: LString('Conduite à tenir devant un purpura fébrile ou non', 'Conduite à tenir devant un purpura fébrile ou non'),
    indication: LString('Enfant avec lésions purpuriques (ne s\'effaçant pas à la vitropression)', 'Enfant avec lésions purpuriques (ne s\'effaçant pas à la vitropression)'),
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: LString('1. Purpura fébrile', '1. Purpura fébrile'),
        content: LString('Urgence jusqu\'à preuve du contraire.', 'Urgence jusqu\'à preuve du contraire.'),
        bulletPoints: [
          LString('Purpura + fièvre = méningocoque possible', 'Purpura + fièvre = méningocoque possible'),
          LString('Purpura extensif ou nécrotique = purpura fulminans', 'Purpura extensif ou nécrotique = purpura fulminans'),
          LString('Ceftriaxone 50-100 mg/kg IV/IM IMMÉDIAT', 'Ceftriaxone 50-100 mg/kg IV/IM IMMÉDIAT'),
        ],
        warning: LString('Antibiotique AVANT tout bilan si purpura fébrile', 'Antibiotique AVANT tout bilan si purpura fébrile'),
      ),
      ProtocolStep(
        title: LString('2. Purpura non fébrile - Évaluation', '2. Purpura non fébrile - Évaluation'),
        content: LString('Rechercher étiologie.', 'Rechercher étiologie.'),
        bulletPoints: [
          LString('Purpura pétéchial: thrombopénie?', 'Purpura pétéchial: thrombopénie?'),
          LString('Purpura vasculaire: territoire déclive', 'Purpura vasculaire: territoire déclive'),
          LString('Ecchymoses: maltraitance?', 'Ecchymoses: maltraitance?'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Purpura rhumatoïde (HSP)', '3. Purpura rhumatoïde (HSP)'),
        content: LString('Vascularite la plus fréquente.', 'Vascularite la plus fréquente.'),
        bulletPoints: [
          LString('Purpura vasculaire déclive + douleurs abdominales', 'Purpura vasculaire déclive + douleurs abdominales'),
          LString('Arthralgies', 'Arthralgies'),
          LString('Atteinte rénale possible', 'Atteinte rénale possible'),
          LString('Traitement symptomatique', 'Traitement symptomatique'),
          LString('Surveillance fonction rénale', 'Surveillance fonction rénale'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Purpura thrombopénique immunologique (PTI)', '4. Purpura thrombopénique immunologique (PTI)'),
        content: LString('Thrombopénie isolée.', 'Thrombopénie isolée.'),
        bulletPoints: [
          LString('Plaquettes < 100 G/L, reste NFS normal', 'Plaquettes < 100 G/L, reste NFS normal'),
          LString('Enfant en bon état général', 'Enfant en bon état général'),
          LString('Risque hémorragique si < 10-20 G/L', 'Risque hémorragique si < 10-20 G/L'),
          LString('Traitement selon sévérité: surveillance, Ig IV, corticoïdes', 'Traitement selon sévérité: surveillance, Ig IV, corticoïdes'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Bilan minimal', '5. Bilan minimal'),
        content: LString('Examens à réaliser.', 'Examens à réaliser.'),
        bulletPoints: [
          LString('NFS plaquettes (thrombopénie?)', 'NFS plaquettes (thrombopénie?)'),
          LString('TP/TCA (coagulopathie?)', 'TP/TCA (coagulopathie?)'),
          LString('Si fièvre: CRP, hémocultures, PL selon contexte', 'Si fièvre: CRP, hémocultures, PL selon contexte'),
        ],
      ),
    ],
    keyPoints: LString('Purpura fébrile = ATB immédiat. Purpura non fébrile = NFS en premier. HSP = le plus fréquent en pédiatrie.', 'Purpura fébrile = ATB immédiat. Purpura non fébrile = NFS en premier. HSP = le plus fréquent en pédiatrie.'),
    source: LString('Urgences pédiatriques', 'Urgences pédiatriques'),
    lastUpdated: 2020,
  ),

  // Anaphylaxie pédiatrique
  Protocol(
    id: 'anaphylaxie-pediatrique',
    name: LString('Anaphylaxie Pédiatrique', 'Anaphylaxie Pédiatrique'),
    category: ProtocolCategory.pediatric,
    description: LString('Réaction allergique systémique sévère de l\'enfant', 'Réaction allergique systémique sévère de l\'enfant'),
    indication: LString('Réaction allergique avec atteinte respiratoire et/ou hémodynamique', 'Réaction allergique avec atteinte respiratoire et/ou hémodynamique'),
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Reconnaissance'),
        content: LString('Critères diagnostiques.', 'Critères diagnostiques.'),
        bulletPoints: [
          LString('Début brutal après exposition allergène', 'Début brutal après exposition allergène'),
          LString('Cutané: urticaire, angioedème', 'Cutané: urticaire, angioedème'),
          LString('Respiratoire: bronchospasme, stridor, dyspnée', 'Respiratoire: bronchospasme, stridor, dyspnée'),
          LString('Cardiovasculaire: hypotension, tachycardie', 'Cardiovasculaire: hypotension, tachycardie'),
          LString('Digestif: vomissements, douleurs abdominales', 'Digestif: vomissements, douleurs abdominales'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Adrénaline IM', '2. Adrénaline IM'),
        content: LString('Traitement de première ligne.', 'Traitement de première ligne.'),
        bulletPoints: [
          LString('Adrénaline IM face antéro-latérale cuisse', 'Adrénaline IM face antéro-latérale cuisse'),
          LString('< 6 ans: 150 µg (Anapen/Epipen Junior)', '< 6 ans: 150 µg (Anapen/Epipen Junior)'),
          LString('6-12 ans: 300 µg', '6-12 ans: 300 µg'),
          LString('> 12 ans: 300-500 µg', '> 12 ans: 300-500 µg'),
          LString('Répéter après 5 min si pas d\'amélioration', 'Répéter après 5 min si pas d\'amélioration'),
        ],
        warning: LString('Ne pas retarder l\'adrénaline!', 'Ne pas retarder l\'adrénaline!'),
      ),
      ProtocolStep(
        title: LString('3. Position', '3. Position'),
        content: LString('Selon symptômes.', 'Selon symptômes.'),
        bulletPoints: [
          LString('Allongé jambes surélevées si hypotension', 'Allongé jambes surélevées si hypotension'),
          LString('Assis si détresse respiratoire', 'Assis si détresse respiratoire'),
          LString('PLS si troubles conscience', 'PLS si troubles conscience'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Traitements associés', '4. Traitements associés'),
        content: LString('Après adrénaline.', 'Après adrénaline.'),
        bulletPoints: [
          LString('O2 haut débit', 'O2 haut débit'),
          LString('Remplissage NaCl 0.9%: 20 mL/kg si hypotension', 'Remplissage NaCl 0.9%: 20 mL/kg si hypotension'),
          LString('Salbutamol nébulisé si bronchospasme', 'Salbutamol nébulisé si bronchospasme'),
          LString('Antihistaminiques H1 (desloratadine, cétirizine)', 'Antihistaminiques H1 (desloratadine, cétirizine)'),
          LString('Corticoïdes (prévention phase tardive)', 'Corticoïdes (prévention phase tardive)'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Surveillance', '5. Surveillance'),
        content: LString('Risque de réaction biphasique.', 'Risque de réaction biphasique.'),
        bulletPoints: [
          LString('Observation minimum 6-8 heures', 'Observation minimum 6-8 heures'),
          LString('24h si réaction sévère', '24h si réaction sévère'),
          LString('Risque récidive dans les 24h', 'Risque récidive dans les 24h'),
        ],
      ),
      ProtocolStep(
        title: LString('6. À la sortie', '6. À la sortie'),
        content: LString('Prévention et suivi.', 'Prévention et suivi.'),
        bulletPoints: [
          LString('Prescription stylo auto-injecteur', 'Prescription stylo auto-injecteur'),
          LString('Éducation utilisation', 'Éducation utilisation'),
          LString('PAI scolaire', 'PAI scolaire'),
          LString('Consultation allergologie', 'Consultation allergologie'),
        ],
      ),
    ],
    keyPoints: LString('Adrénaline IM précoce. Répéter si besoin. Surveillance 6-8h. Stylo auto-injecteur à la sortie.', 'Adrénaline IM précoce. Répéter si besoin. Surveillance 6-8h. Stylo auto-injecteur à la sortie.'),
    source: LString('EAACI 2021 - Anaphylaxis Guidelines', 'EAACI 2021 - Anaphylaxis Guidelines'),
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
    name: LString('Éclampsie', 'Éclampsie'),
    category: ProtocolCategory.obstetric,
    description: LString('Convulsions sur pré-éclampsie', 'Convulsions sur pré-éclampsie'),
    indication: LString('Femme enceinte > 20 SA ou post-partum avec convulsions', 'Femme enceinte > 20 SA ou post-partum avec convulsions'),
    steps: [
      ProtocolStep(
        title: LString('1. Prise en charge immédiate', '1. Prise en charge immédiate'),
        content: LString('Pendant la crise.', 'Pendant la crise.'),
        bulletPoints: [
          LString('PLS, protection des voies aériennes', 'PLS, protection des voies aériennes'),
          LString('O2 haut débit', 'O2 haut débit'),
          LString('Ne pas tenter d\'arrêter la crise par contention', 'Ne pas tenter d\'arrêter la crise par contention'),
          LString('Voie veineuse périphérique', 'Voie veineuse périphérique'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Sulfate de magnésium', '2. Sulfate de magnésium'),
        content: LString('Traitement de référence.', 'Traitement de référence.'),
        bulletPoints: [
          LString('Dose de charge: 4g IV en 20 min', 'Dose de charge: 4g IV en 20 min'),
          LString('Puis entretien: 1g/h IVSE', 'Puis entretien: 1g/h IVSE'),
          LString('Poursuivre 24-48h après dernière crise', 'Poursuivre 24-48h après dernière crise'),
          LString('Surveillance: réflexes, FR, diurèse', 'Surveillance: réflexes, FR, diurèse'),
        ],
        warning: LString('Antidote si surdosage: Gluconate de calcium 1g IV', 'Antidote si surdosage: Gluconate de calcium 1g IV'),
      ),
      ProtocolStep(
        title: LString('3. Si récidive sous MgSO4', '3. Si récidive sous MgSO4'),
        content: LString('Traitement de seconde ligne.', 'Traitement de seconde ligne.'),
        bulletPoints: [
          LString('Bolus supplémentaire MgSO4 2g IV', 'Bolus supplémentaire MgSO4 2g IV'),
          LString('Si échec: Diazépam 10 mg IV', 'Si échec: Diazépam 10 mg IV'),
          LString('ou Clonazépam 1 mg IV', 'ou Clonazépam 1 mg IV'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Contrôle tensionnel', '4. Contrôle tensionnel'),
        content: LString('Objectif PAS < 160, PAD < 110.', 'Objectif PAS < 160, PAD < 110.'),
        bulletPoints: [
          LString('Nicardipine IVSE (1-6 mg/h)', 'Nicardipine IVSE (1-6 mg/h)'),
          LString('ou Labétalol IV (20 mg bolus puis IVSE)', 'ou Labétalol IV (20 mg bolus puis IVSE)'),
          LString('Éviter chute brutale de PA (perfusion utéro-placentaire)', 'Éviter chute brutale de PA (perfusion utéro-placentaire)'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Extraction fœtale', '5. Extraction fœtale'),
        content: LString('Seul traitement définitif.', 'Seul traitement définitif.'),
        bulletPoints: [
          LString('Décision après stabilisation maternelle', 'Décision après stabilisation maternelle'),
          LString('Césarienne le plus souvent', 'Césarienne le plus souvent'),
          LString('Pas d\'attente si instabilité persistante', 'Pas d\'attente si instabilité persistante'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Surveillance post-critique', '6. Surveillance post-critique'),
        content: LString('Réanimation ou soins intensifs.', 'Réanimation ou soins intensifs.'),
        bulletPoints: [
          LString('Monitoring materno-fœtal', 'Monitoring materno-fœtal'),
          LString('Surveillance MgSO4', 'Surveillance MgSO4'),
          LString('Bilan HELLP syndrome', 'Bilan HELLP syndrome'),
          LString('Scanner cérébral si atypie', 'Scanner cérébral si atypie'),
        ],
      ),
    ],
    keyPoints: LString('MgSO4 = traitement de référence. Contrôle PA sans chute brutale. Extraction fœtale après stabilisation.', 'MgSO4 = traitement de référence. Contrôle PA sans chute brutale. Extraction fœtale après stabilisation.'),
    source: LString('CNGOF, Magpie Trial', 'CNGOF, Magpie Trial'),
    lastUpdated: 2020,
  ),

  // Hémorragie post-partum
  Protocol(
    id: 'hpp',
    name: LString('Hémorragie du Post-Partum', 'Hémorragie du Post-Partum'),
    category: ProtocolCategory.obstetric,
    description: LString('Saignement > 500 mL (voie basse) ou > 1000 mL (césarienne)', 'Saignement > 500 mL (voie basse) ou > 1000 mL (césarienne)'),
    indication: LString('Hémorragie dans les 24h suivant l\'accouchement', 'Hémorragie dans les 24h suivant l\'accouchement'),
    steps: [
      ProtocolStep(
        title: LString('1. Alerte et organisation', '1. Alerte et organisation'),
        content: LString('Mobiliser l\'équipe.', 'Mobiliser l\'équipe.'),
        bulletPoints: [
          LString('Appel obstétricien, anesthésiste, sage-femme', 'Appel obstétricien, anesthésiste, sage-femme'),
          LString('Alerter banque du sang', 'Alerter banque du sang'),
          LString('Chronométrer et quantifier les pertes', 'Chronométrer et quantifier les pertes'),
          LString('Double voie veineuse gros calibre', 'Double voie veineuse gros calibre'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Étiologies (4T)', '2. Étiologies (4T)'),
        content: LString('Rechercher la cause.', 'Rechercher la cause.'),
        bulletPoints: [
          LString('Tonus: atonie utérine (70%)', 'Tonus: atonie utérine (70%)'),
          LString('Tissu: rétention placentaire', 'Tissu: rétention placentaire'),
          LString('Trauma: déchirure cervico-vaginale, rupture utérine', 'Trauma: déchirure cervico-vaginale, rupture utérine'),
          LString('Thrombine: coagulopathie', 'Thrombine: coagulopathie'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Traitement atonie utérine', '3. Traitement atonie utérine'),
        content: LString('Première cause.', 'Première cause.'),
        bulletPoints: [
          LString('Massage utérin bimanuel', 'Massage utérin bimanuel'),
          LString('Oxytocine 5-10 UI IV puis 20-40 UI/500 mL en perfusion', 'Oxytocine 5-10 UI IV puis 20-40 UI/500 mL en perfusion'),
          LString('Sulprostone (Nalador) 500 µg/h IVSE si échec', 'Sulprostone (Nalador) 500 µg/h IVSE si échec'),
          LString('Vidange vésicale', 'Vidange vésicale'),
        ],
        warning: LString('Sulprostone: CI cardiovasculaires, max 1500 µg', 'Sulprostone: CI cardiovasculaires, max 1500 µg'),
      ),
      ProtocolStep(
        title: LString('4. Acide tranexamique', '4. Acide tranexamique'),
        content: LString('Systématique.', 'Systématique.'),
        bulletPoints: [
          LString('1g IV dès le diagnostic', '1g IV dès le diagnostic'),
          LString('Répéter 1g si saignement persistant à 30 min', 'Répéter 1g si saignement persistant à 30 min'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Réanimation', '5. Réanimation'),
        content: LString('Support hémodynamique.', 'Support hémodynamique.'),
        bulletPoints: [
          LString('Remplissage cristalloïdes', 'Remplissage cristalloïdes'),
          LString('Transfusion CGR si Hb < 7 g/dL ou instabilité', 'Transfusion CGR si Hb < 7 g/dL ou instabilité'),
          LString('PFC, plaquettes, fibrinogène selon coagulation', 'PFC, plaquettes, fibrinogène selon coagulation'),
          LString('Objectif fibrinogène > 2 g/L', 'Objectif fibrinogène > 2 g/L'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Traitements invasifs', '6. Traitements invasifs'),
        content: LString('Si échec médical.', 'Si échec médical.'),
        bulletPoints: [
          LString('Tamponnement intra-utérin (ballonnet)', 'Tamponnement intra-utérin (ballonnet)'),
          LString('Embolisation artérielle', 'Embolisation artérielle'),
          LString('Ligatures vasculaires', 'Ligatures vasculaires'),
          LString('Hystérectomie d\'hémostase (ultime recours)', 'Hystérectomie d\'hémostase (ultime recours)'),
        ],
      ),
    ],
    keyPoints: LString('4T pour étiologie. Oxytocine puis sulprostone. Acide tranexamique 1g. Escalade jusqu\'à embolisation/chirurgie.', '4T pour étiologie. Oxytocine puis sulprostone. Acide tranexamique 1g. Escalade jusqu\'à embolisation/chirurgie.'),
    source: LString('CNGOF 2014 - HPP', 'CNGOF 2014 - HPP'),
    lastUpdated: 2014,
  ),

  // Pré-éclampsie
  Protocol(
    id: 'pre-eclampsie',
    name: LString('Pré-éclampsie Sévère', 'Pré-éclampsie Sévère'),
    category: ProtocolCategory.obstetric,
    description: LString('HTA gravidique avec protéinurie et atteinte d\'organe', 'HTA gravidique avec protéinurie et atteinte d\'organe'),
    indication: LString('PA ≥ 160/110 + protéinurie + signes de gravité', 'PA ≥ 160/110 + protéinurie + signes de gravité'),
    steps: [
      ProtocolStep(
        title: LString('1. Critères de sévérité', '1. Critères de sévérité'),
        content: LString('Identifier les formes graves.', 'Identifier les formes graves.'),
        bulletPoints: [
          LString('PAS ≥ 160 ou PAD ≥ 110 mmHg', 'PAS ≥ 160 ou PAD ≥ 110 mmHg'),
          LString('Protéinurie > 5 g/24h', 'Protéinurie > 5 g/24h'),
          LString('Oligurie < 500 mL/24h', 'Oligurie < 500 mL/24h'),
          LString('Céphalées, troubles visuels, ROT vifs', 'Céphalées, troubles visuels, ROT vifs'),
          LString('Douleur épigastrique (HELLP)', 'Douleur épigastrique (HELLP)'),
          LString('Cytolyse hépatique, thrombopénie', 'Cytolyse hépatique, thrombopénie'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Traitement antihypertenseur', '2. Traitement antihypertenseur'),
        content: LString('Urgence hypertensive.', 'Urgence hypertensive.'),
        bulletPoints: [
          LString('Objectif: PAS 140-150, PAD 90-100', 'Objectif: PAS 140-150, PAD 90-100'),
          LString('Nicardipine IVSE 1-6 mg/h', 'Nicardipine IVSE 1-6 mg/h'),
          LString('ou Labétalol IV 20 mg puis IVSE', 'ou Labétalol IV 20 mg puis IVSE'),
          LString('Éviter baisse brutale (souffrance fœtale)', 'Éviter baisse brutale (souffrance fœtale)'),
        ],
        warning: LString('Ne pas descendre PA trop vite: risque fœtal', 'Ne pas descendre PA trop vite: risque fœtal'),
      ),
      ProtocolStep(
        title: LString('3. Prévention éclampsie', '3. Prévention éclampsie'),
        content: LString('Sulfate de magnésium.', 'Sulfate de magnésium.'),
        bulletPoints: [
          LString('Indication: pré-éclampsie sévère', 'Indication: pré-éclampsie sévère'),
          LString('Dose charge: 4g IV en 20 min', 'Dose charge: 4g IV en 20 min'),
          LString('Entretien: 1g/h IVSE', 'Entretien: 1g/h IVSE'),
          LString('Surveillance: réflexes, FR > 12, magnésémie', 'Surveillance: réflexes, FR > 12, magnésémie'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Bilan HELLP', '4. Bilan HELLP'),
        content: LString('Rechercher complications.', 'Rechercher complications.'),
        bulletPoints: [
          LString('Hémolyse: LDH, haptoglobine, schizocytes', 'Hémolyse: LDH, haptoglobine, schizocytes'),
          LString('Elevated Liver enzymes: ASAT, ALAT', 'Elevated Liver enzymes: ASAT, ALAT'),
          LString('Low Platelets: < 100 G/L', 'Low Platelets: < 100 G/L'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Décision d\'extraction', '5. Décision d\'extraction'),
        content: LString('Seul traitement définitif.', 'Seul traitement définitif.'),
        bulletPoints: [
          LString('< 34 SA: corticoïdes pour maturation pulmonaire si possible', '< 34 SA: corticoïdes pour maturation pulmonaire si possible'),
          LString('≥ 34 SA: extraction à discuter', '≥ 34 SA: extraction à discuter'),
          LString('Extraction urgente si: HELLP, HRP, souffrance fœtale', 'Extraction urgente si: HELLP, HRP, souffrance fœtale'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Surveillance', '6. Surveillance'),
        content: LString('Monitoring continu.', 'Monitoring continu.'),
        bulletPoints: [
          LString('Monitoring PA, SpO2', 'Monitoring PA, SpO2'),
          LString('RCF (rythme cardiaque fœtal)', 'RCF (rythme cardiaque fœtal)'),
          LString('Bilan biologique répété', 'Bilan biologique répété'),
          LString('Diurèse horaire', 'Diurèse horaire'),
        ],
      ),
    ],
    keyPoints: LString('PA 140-150/90-100. MgSO4 si sévère. Bilan HELLP. Extraction = traitement définitif.', 'PA 140-150/90-100. MgSO4 si sévère. Bilan HELLP. Extraction = traitement définitif.'),
    source: LString('CNGOF, ISSHP', 'CNGOF, ISSHP'),
    lastUpdated: 2020,
  ),

  // Accouchement inopiné
  Protocol(
    id: 'accouchement-inopine',
    name: LString('Accouchement Inopiné', 'Accouchement Inopiné'),
    category: ProtocolCategory.obstetric,
    description: LString('Accouchement en dehors d\'une structure adaptée', 'Accouchement en dehors d\'une structure adaptée'),
    indication: LString('Accouchement imminent hors maternité', 'Accouchement imminent hors maternité'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation', '1. Évaluation'),
        content: LString('Imminence de l\'accouchement.', 'Imminence de l\'accouchement.'),
        bulletPoints: [
          LString('Envie de pousser irrépressible', 'Envie de pousser irrépressible'),
          LString('Tête visible à la vulve', 'Tête visible à la vulve'),
          LString('Contractions rapprochées intenses', 'Contractions rapprochées intenses'),
          LString('Si transfert possible < 15 min: transférer', 'Si transfert possible < 15 min: transférer'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Préparation', '2. Préparation'),
        content: LString('Matériel nécessaire.', 'Matériel nécessaire.'),
        bulletPoints: [
          LString('Gants stériles, champs', 'Gants stériles, champs'),
          LString('Clamps de cordon ou lacets stériles', 'Clamps de cordon ou lacets stériles'),
          LString('Ciseaux stériles', 'Ciseaux stériles'),
          LString('Couverture chaude pour le nouveau-né', 'Couverture chaude pour le nouveau-né'),
          LString('Aspiration douce si disponible', 'Aspiration douce si disponible'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Accouchement', '3. Accouchement'),
        content: LString('Accompagner l\'expulsion.', 'Accompagner l\'expulsion.'),
        bulletPoints: [
          LString('Position gynécologique ou latérale', 'Position gynécologique ou latérale'),
          LString('Soutenir le périnée (pas de protection rigide)', 'Soutenir le périnée (pas de protection rigide)'),
          LString('Contrôler la sortie de la tête', 'Contrôler la sortie de la tête'),
          LString('Vérifier absence de circulaire serré du cordon', 'Vérifier absence de circulaire serré du cordon'),
          LString('Dégager les épaules avec rotation douce', 'Dégager les épaules avec rotation douce'),
        ],
        tip: LString('Ne pas tirer sur la tête, accompagner seulement', 'Ne pas tirer sur la tête, accompagner seulement'),
      ),
      ProtocolStep(
        title: LString('4. Soins nouveau-né', '4. Soins nouveau-né'),
        content: LString('À la naissance.', 'À la naissance.'),
        bulletPoints: [
          LString('Sécher et stimuler', 'Sécher et stimuler'),
          LString('Peau à peau avec la mère si va bien', 'Peau à peau avec la mère si va bien'),
          LString('Évaluer: cri, tonus, coloration', 'Évaluer: cri, tonus, coloration'),
          LString('Aspiration si nécessaire', 'Aspiration si nécessaire'),
          LString('Garder au chaud +++', 'Garder au chaud +++'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Cordon ombilical', '5. Cordon ombilical'),
        content: LString('Clampage.', 'Clampage.'),
        bulletPoints: [
          LString('Attendre 1-3 min si nouveau-né stable', 'Attendre 1-3 min si nouveau-né stable'),
          LString('Clamper à 2 et 5 cm de l\'ombilic', 'Clamper à 2 et 5 cm de l\'ombilic'),
          LString('Section entre les clamps', 'Section entre les clamps'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Délivrance', '6. Délivrance'),
        content: LString('Expulsion du placenta.', 'Expulsion du placenta.'),
        bulletPoints: [
          LString('Attendre signes de décollement (15-30 min)', 'Attendre signes de décollement (15-30 min)'),
          LString('Ne pas tirer sur le cordon', 'Ne pas tirer sur le cordon'),
          LString('Injection oxytocine 5-10 UI IM après délivrance', 'Injection oxytocine 5-10 UI IM après délivrance'),
          LString('Vérifier intégrité du placenta', 'Vérifier intégrité du placenta'),
          LString('Massage utérin', 'Massage utérin'),
        ],
        warning: LString('Ne jamais tirer sur le cordon: risque de rupture et d\'inversion utérine', 'Ne jamais tirer sur le cordon: risque de rupture et d\'inversion utérine'),
      ),
    ],
    keyPoints: LString('Accompagner sans tirer. Sécher et réchauffer le nouveau-né. Oxytocine après délivrance.', 'Accompagner sans tirer. Sécher et réchauffer le nouveau-né. Oxytocine après délivrance.'),
    source: LString('Recommandations SFAR/SFMU', 'Recommandations SFAR/SFMU'),
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
    name: LString('Intubation en Séquence Rapide', 'Intubation en Séquence Rapide'),
    category: ProtocolCategory.analgesia,
    description: LString('Technique d\'intubation pour estomac plein ou urgence', 'Technique d\'intubation pour estomac plein ou urgence'),
    indication: LString('Intubation en urgence, estomac plein, détresse vitale', 'Intubation en urgence, estomac plein, détresse vitale'),
    steps: [
      ProtocolStep(
        title: LString('1. Préparation', '1. Préparation'),
        content: LString('Check-list avant ISR.', 'Check-list avant ISR.'),
        bulletPoints: [
          LString('Vérifier matériel: laryngoscope, sondes (taille + 1 au-dessus et dessous)', 'Vérifier matériel: laryngoscope, sondes (taille + 1 au-dessus et dessous)'),
          LString('Aspiration fonctionnelle', 'Aspiration fonctionnelle'),
          LString('Monitorage: SpO2, capno, ECG, PA', 'Monitorage: SpO2, capno, ECG, PA'),
          LString('Voie veineuse sûre', 'Voie veineuse sûre'),
          LString('Plan B: dispositif supraglottique, kit de cricothyroïdotomie', 'Plan B: dispositif supraglottique, kit de cricothyroïdotomie'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Préoxygénation', '2. Préoxygénation'),
        content: LString('Dénitrogénation.', 'Dénitrogénation.'),
        bulletPoints: [
          LString('O2 100% pendant 3-5 min', 'O2 100% pendant 3-5 min'),
          LString('Objectif: EtO2 > 90%', 'Objectif: EtO2 > 90%'),
          LString('Ou 8 inspirations profondes si urgent', 'Ou 8 inspirations profondes si urgent'),
          LString('VNI si hypoxémique (CPAP ou BiPAP)', 'VNI si hypoxémique (CPAP ou BiPAP)'),
        ],
        tip: LString('Position proclive 30° améliore la préoxygénation', 'Position proclive 30° améliore la préoxygénation'),
      ),
      ProtocolStep(
        title: LString('3. Induction', '3. Induction'),
        content: LString('Hypnotique + curare.', 'Hypnotique + curare.'),
        bulletPoints: [
          LString('Hypnotique au choix:', 'Hypnotique au choix:'),
          LString('- Étomidate 0.3 mg/kg (stabilité HD)', '- Étomidate 0.3 mg/kg (stabilité HD)'),
          LString('- Kétamine 1-2 mg/kg (bronchospasme, choc)', '- Kétamine 1-2 mg/kg (bronchospasme, choc)'),
          LString('- Propofol 2-2.5 mg/kg (CI si instable)', '- Propofol 2-2.5 mg/kg (CI si instable)'),
          LString('Curare:', 'Curare:'),
          LString('- Succinylcholine 1 mg/kg (délai 60 sec, durée 6-10 min)', '- Succinylcholine 1 mg/kg (délai 60 sec, durée 6-10 min)'),
          LString('- Rocuronium 1.2 mg/kg (réversible par sugammadex)', '- Rocuronium 1.2 mg/kg (réversible par sugammadex)'),
        ],
        warning: LString('Succinylcholine CI: hyperkaliémie, myopathie, brûlure > 24h', 'Succinylcholine CI: hyperkaliémie, myopathie, brûlure > 24h'),
      ),
      ProtocolStep(
        title: LString('4. Manœuvre de Sellick', '4. Manœuvre de Sellick'),
        content: LString('Controversée mais habituelle.', 'Controversée mais habituelle.'),
        bulletPoints: [
          LString('Pression cricoïdienne dès perte de conscience', 'Pression cricoïdienne dès perte de conscience'),
          LString('Maintenir jusqu\'à vérification du ballonnet', 'Maintenir jusqu\'à vérification du ballonnet'),
          LString('Relâcher si vomissement actif ou difficulté intubation', 'Relâcher si vomissement actif ou difficulté intubation'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Intubation', '5. Intubation'),
        content: LString('Sans ventilation intermédiaire.', 'Sans ventilation intermédiaire.'),
        bulletPoints: [
          LString('Laryngoscopie dès fasciculations terminées ou 60 sec', 'Laryngoscopie dès fasciculations terminées ou 60 sec'),
          LString('Pas de ventilation au masque entre induction et IOT', 'Pas de ventilation au masque entre induction et IOT'),
          LString('Vidéolaryngoscope si anticipation difficile', 'Vidéolaryngoscope si anticipation difficile'),
          LString('Vérification: capnographie +++, auscultation', 'Vérification: capnographie +++, auscultation'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Post-intubation', '6. Post-intubation'),
        content: LString('Sécurisation.', 'Sécurisation.'),
        bulletPoints: [
          LString('Gonfler ballonnet', 'Gonfler ballonnet'),
          LString('Fixer la sonde', 'Fixer la sonde'),
          LString('Vérifier position: capno, auscultation, radio', 'Vérifier position: capno, auscultation, radio'),
          LString('Sédation d\'entretien', 'Sédation d\'entretien'),
          LString('Sonde gastrique', 'Sonde gastrique'),
        ],
      ),
    ],
    keyPoints: LString('Préoxygénation 3 min. Pas de ventilation intermédiaire. Succinylcholine ou rocuronium. Vérifier par capno.', 'Préoxygénation 3 min. Pas de ventilation intermédiaire. Succinylcholine ou rocuronium. Vérifier par capno.'),
    source: LString('SFAR/SFMU 2017 - Intubation difficile', 'SFAR/SFMU 2017 - Intubation difficile'),
    lastUpdated: 2017,
  ),

  // Analgésie aux urgences
  Protocol(
    id: 'analgesie-urgences',
    name: LString('Analgésie aux Urgences', 'Analgésie aux Urgences'),
    category: ProtocolCategory.analgesia,
    description: LString('Prise en charge de la douleur aux urgences', 'Prise en charge de la douleur aux urgences'),
    indication: LString('Patient douloureux aux urgences', 'Patient douloureux aux urgences'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation', '1. Évaluation'),
        content: LString('Quantifier la douleur.', 'Quantifier la douleur.'),
        bulletPoints: [
          LString('EVA ou EN (0-10)', 'EVA ou EN (0-10)'),
          LString('Légère: 1-3', 'Légère: 1-3'),
          LString('Modérée: 4-6', 'Modérée: 4-6'),
          LString('Sévère: 7-10', 'Sévère: 7-10'),
          LString('Échelles comportementales si non communicant', 'Échelles comportementales si non communicant'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Douleur légère (EVA 1-3)', '2. Douleur légère (EVA 1-3)'),
        content: LString('Palier 1.', 'Palier 1.'),
        bulletPoints: [
          LString('Paracétamol 1g PO/IV', 'Paracétamol 1g PO/IV'),
          LString('Renouveler toutes les 6h si besoin', 'Renouveler toutes les 6h si besoin'),
          LString('Maximum 4g/24h (3g si > 65 ans ou IHC)', 'Maximum 4g/24h (3g si > 65 ans ou IHC)'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Douleur modérée (EVA 4-6)', '3. Douleur modérée (EVA 4-6)'),
        content: LString('Palier 1-2 + AINS.', 'Palier 1-2 + AINS.'),
        bulletPoints: [
          LString('Paracétamol + AINS si pas de CI', 'Paracétamol + AINS si pas de CI'),
          LString('Kétoprofène 100 mg IV ou Ibuprofène 400 mg PO', 'Kétoprofène 100 mg IV ou Ibuprofène 400 mg PO'),
          LString('CI AINS: IR, UGD, grossesse 3T, allergie, HTA mal contrôlée', 'CI AINS: IR, UGD, grossesse 3T, allergie, HTA mal contrôlée'),
          LString('Tramadol 50-100 mg PO ou Codéine', 'Tramadol 50-100 mg PO ou Codéine'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Douleur sévère (EVA 7-10)', '4. Douleur sévère (EVA 7-10)'),
        content: LString('Morphine.', 'Morphine.'),
        bulletPoints: [
          LString('Titration morphine IV:', 'Titration morphine IV:'),
          LString('- Bolus initial: 0.05-0.1 mg/kg (2-3 mg)', '- Bolus initial: 0.05-0.1 mg/kg (2-3 mg)'),
          LString('- Réinjections 1-2 mg toutes les 5-10 min', '- Réinjections 1-2 mg toutes les 5-10 min'),
          LString('- Objectif EVA < 3', '- Objectif EVA < 3'),
          LString('Naloxone disponible', 'Naloxone disponible'),
        ],
        tip: LString('Réévaluer EVA après chaque injection', 'Réévaluer EVA après chaque injection'),
      ),
      ProtocolStep(
        title: LString('5. Alternatives et adjuvants', '5. Alternatives et adjuvants'),
        content: LString('Autres options.', 'Autres options.'),
        bulletPoints: [
          LString('Kétamine faible dose 0.1-0.3 mg/kg (épargne morphinique)', 'Kétamine faible dose 0.1-0.3 mg/kg (épargne morphinique)'),
          LString('Bloc nerveux si lésion localisée', 'Bloc nerveux si lésion localisée'),
          LString('MEOPA pour gestes douloureux', 'MEOPA pour gestes douloureux'),
          LString('Nefopam 20 mg IV (contre-indiqué si épilepsie)', 'Nefopam 20 mg IV (contre-indiqué si épilepsie)'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Populations particulières', '6. Populations particulières'),
        content: LString('Adapter les doses.', 'Adapter les doses.'),
        bulletPoints: [
          LString('Sujet âgé: réduire doses, titration prudente', 'Sujet âgé: réduire doses, titration prudente'),
          LString('Insuffisant rénal: éviter AINS, adapter opioïdes', 'Insuffisant rénal: éviter AINS, adapter opioïdes'),
          LString('Grossesse: paracétamol, éviter AINS T3', 'Grossesse: paracétamol, éviter AINS T3'),
          LString('Enfant: doses adaptées au poids', 'Enfant: doses adaptées au poids'),
        ],
      ),
    ],
    keyPoints: LString('Évaluer EVA. Palier 1-2 si modérée. Morphine titrée si sévère. Réévaluer systématiquement.', 'Évaluer EVA. Palier 1-2 si modérée. Morphine titrée si sévère. Réévaluer systématiquement.'),
    source: LString('SFMU 2019 - Analgésie aux urgences', 'SFMU 2019 - Analgésie aux urgences'),
    lastUpdated: 2019,
  ),

  // Sédation procédurale
  Protocol(
    id: 'sedation-procedurale',
    name: LString('Sédation Procédurale', 'Sédation Procédurale'),
    category: ProtocolCategory.analgesia,
    description: LString('Sédation pour gestes douloureux aux urgences', 'Sédation pour gestes douloureux aux urgences'),
    indication: LString('Réduction de luxation, cardioversion, gestes douloureux', 'Réduction de luxation, cardioversion, gestes douloureux'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation pré-sédation', '1. Évaluation pré-sédation'),
        content: LString('Critères de sécurité.', 'Critères de sécurité.'),
        bulletPoints: [
          LString('Jeûne (relatif selon urgence)', 'Jeûne (relatif selon urgence)'),
          LString('Voies aériennes: Mallampati, ouverture bouche', 'Voies aériennes: Mallampati, ouverture bouche'),
          LString('Comorbidités: cardio, respi, obésité', 'Comorbidités: cardio, respi, obésité'),
          LString('Médicaments et allergies', 'Médicaments et allergies'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Préparation', '2. Préparation'),
        content: LString('Environnement sécurisé.', 'Environnement sécurisé.'),
        bulletPoints: [
          LString('Matériel de réanimation disponible', 'Matériel de réanimation disponible'),
          LString('O2, aspiration, BAVU', 'O2, aspiration, BAVU'),
          LString('Antidotes prêts: flumazénil, naloxone', 'Antidotes prêts: flumazénil, naloxone'),
          LString('Monitoring: SpO2, capno, ECG, PA', 'Monitoring: SpO2, capno, ECG, PA'),
          LString('2 personnes: 1 pour sédation, 1 pour geste', '2 personnes: 1 pour sédation, 1 pour geste'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Protocoles courants', '3. Protocoles courants'),
        content: LString('Selon indication.', 'Selon indication.'),
        bulletPoints: [
          LString('Propofol: 0.5-1 mg/kg IV, titrer par 0.25 mg/kg', 'Propofol: 0.5-1 mg/kg IV, titrer par 0.25 mg/kg'),
          LString('Kétamine: 1-2 mg/kg IV (dissociatif)', 'Kétamine: 1-2 mg/kg IV (dissociatif)'),
          LString('Midazolam + Fentanyl: 0.05 mg/kg + 1 µg/kg', 'Midazolam + Fentanyl: 0.05 mg/kg + 1 µg/kg'),
          LString('MEOPA: inhalation pour gestes courts', 'MEOPA: inhalation pour gestes courts'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Kétamine - spécificités', '4. Kétamine - spécificités'),
        content: LString('Option intéressante.', 'Option intéressante.'),
        bulletPoints: [
          LString('Maintien réflexes VAS et ventilation', 'Maintien réflexes VAS et ventilation'),
          LString('Bronchodilatateur', 'Bronchodilatateur'),
          LString('Stabilité hémodynamique', 'Stabilité hémodynamique'),
          LString('Phénomènes émergence: prévenir par midazolam 1 mg', 'Phénomènes émergence: prévenir par midazolam 1 mg'),
          LString('CI relative: HTA, cardiopathie ischémique', 'CI relative: HTA, cardiopathie ischémique'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Surveillance', '5. Surveillance'),
        content: LString('Pendant et après.', 'Pendant et après.'),
        bulletPoints: [
          LString('Monitoring continu pendant geste', 'Monitoring continu pendant geste'),
          LString('Surveillance post-sédation jusqu\'à réveil complet', 'Surveillance post-sédation jusqu\'à réveil complet'),
          LString('Critères de sortie: orientation normale, marche stable', 'Critères de sortie: orientation normale, marche stable'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Gestion des complications', '6. Gestion des complications'),
        content: LString('Réagir vite.', 'Réagir vite.'),
        bulletPoints: [
          LString('Désaturation: subluxation mâchoire, O2, ventilation', 'Désaturation: subluxation mâchoire, O2, ventilation'),
          LString('Apnée: ventilation au masque, antagonistes', 'Apnée: ventilation au masque, antagonistes'),
          LString('Hypotension: remplissage, réduire/arrêter sédatif', 'Hypotension: remplissage, réduire/arrêter sédatif'),
          LString('Vomissements: aspiration, position latérale', 'Vomissements: aspiration, position latérale'),
        ],
      ),
    ],
    keyPoints: LString('Environnement sécurisé. Titration. Monitoring continu. Surveillance jusqu\'à réveil complet.', 'Environnement sécurisé. Titration. Monitoring continu. Surveillance jusqu\'à réveil complet.'),
    source: LString('ACEP - Procedural Sedation', 'ACEP - Procedural Sedation'),
    lastUpdated: 2020,
  ),

  // ALR aux urgences
  Protocol(
    id: 'alr-urgences',
    name: LString('Anesthésie Locorégionale aux Urgences', 'Anesthésie Locorégionale aux Urgences'),
    category: ProtocolCategory.analgesia,
    description: LString('Blocs nerveux périphériques pour analgésie', 'Blocs nerveux périphériques pour analgésie'),
    indication: LString('Analgésie localisée pour trauma, suture, exploration', 'Analgésie localisée pour trauma, suture, exploration'),
    steps: [
      ProtocolStep(
        title: LString('1. Indications courantes', '1. Indications courantes'),
        content: LString('Blocs les plus utilisés.', 'Blocs les plus utilisés.'),
        bulletPoints: [
          LString('Bloc fémoral: fracture fémur, col fémoral', 'Bloc fémoral: fracture fémur, col fémoral'),
          LString('Bloc PENG: fracture hanche', 'Bloc PENG: fracture hanche'),
          LString('Bloc axillaire: trauma membre supérieur', 'Bloc axillaire: trauma membre supérieur'),
          LString('Bloc de la gaine des fléchisseurs: plaie main', 'Bloc de la gaine des fléchisseurs: plaie main'),
          LString('Bloc digital: plaie doigt', 'Bloc digital: plaie doigt'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Contre-indications', '2. Contre-indications'),
        content: LString('Situations à éviter.', 'Situations à éviter.'),
        bulletPoints: [
          LString('Infection au point de ponction', 'Infection au point de ponction'),
          LString('Allergie vraie aux anesthésiques locaux', 'Allergie vraie aux anesthésiques locaux'),
          LString('Troubles de coagulation sévères', 'Troubles de coagulation sévères'),
          LString('Refus du patient', 'Refus du patient'),
          LString('Atteinte neurologique préexistante du territoire', 'Atteinte neurologique préexistante du territoire'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Anesthésiques locaux', '3. Anesthésiques locaux'),
        content: LString('Produits et doses.', 'Produits et doses.'),
        bulletPoints: [
          LString('Lidocaïne 1-2%: délai rapide, durée 1-2h', 'Lidocaïne 1-2%: délai rapide, durée 1-2h'),
          LString('Dose max: 4 mg/kg (7 mg/kg avec adrénaline)', 'Dose max: 4 mg/kg (7 mg/kg avec adrénaline)'),
          LString('Ropivacaïne 0.5%: délai moyen, durée 4-8h', 'Ropivacaïne 0.5%: délai moyen, durée 4-8h'),
          LString('Dose max: 3 mg/kg', 'Dose max: 3 mg/kg'),
          LString('Éviter adrénaline: extrémités (doigts, orteils)', 'Éviter adrénaline: extrémités (doigts, orteils)'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Bloc fémoral (technique)', '4. Bloc fémoral (technique)'),
        content: LString('Fracture du fémur.', 'Fracture du fémur.'),
        bulletPoints: [
          LString('Repérage: 1-2 cm sous ligament inguinal, latéral à l\'artère', 'Repérage: 1-2 cm sous ligament inguinal, latéral à l\'artère'),
          LString('Échoguidage recommandé', 'Échoguidage recommandé'),
          LString('Volume: 20-30 mL ropivacaïne 0.5%', 'Volume: 20-30 mL ropivacaïne 0.5%'),
          LString('Aspiration avant injection', 'Aspiration avant injection'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Toxicité systémique (LAST)', '5. Toxicité systémique (LAST)'),
        content: LString('Complication grave.', 'Complication grave.'),
        bulletPoints: [
          LString('Signes: goût métallique, acouphènes, convulsions, ACR', 'Signes: goût métallique, acouphènes, convulsions, ACR'),
          LString('Arrêter injection', 'Arrêter injection'),
          LString('Intralipid 20%: 1.5 mL/kg bolus puis 0.25 mL/kg/min', 'Intralipid 20%: 1.5 mL/kg bolus puis 0.25 mL/kg/min'),
          LString('RCP si ACR (éviter amiodarone)', 'RCP si ACR (éviter amiodarone)'),
        ],
        warning: LString('Toujours avoir Intralipid disponible', 'Toujours avoir Intralipid disponible'),
      ),
      ProtocolStep(
        title: LString('6. Documentation', '6. Documentation'),
        content: LString('Traçabilité.', 'Traçabilité.'),
        bulletPoints: [
          LString('Consentement', 'Consentement'),
          LString('Produit, concentration, volume', 'Produit, concentration, volume'),
          LString('Heure, technique', 'Heure, technique'),
          LString('Surveillance post-bloc', 'Surveillance post-bloc'),
        ],
      ),
    ],
    keyPoints: LString('Échoguidage recommandé. Respecter doses max. Intralipid disponible. Efficacité excellente.', 'Échoguidage recommandé. Respecter doses max. Intralipid disponible. Efficacité excellente.'),
    source: LString('SFAR - ALR périphérique', 'SFAR - ALR périphérique'),
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
    name: LString('Choc Cardiogénique', 'Choc Cardiogénique'),
    category: ProtocolCategory.resuscitation,
    description: LString('Défaillance cardiaque aiguë avec hypoperfusion tissulaire', 'Défaillance cardiaque aiguë avec hypoperfusion tissulaire'),
    indication: LString('PAS < 90 mmHg avec signes d\'hypoperfusion et congestion', 'PAS < 90 mmHg avec signes d\'hypoperfusion et congestion'),
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Reconnaissance'),
        content: LString('Diagnostic clinique.', 'Diagnostic clinique.'),
        bulletPoints: [
          LString('Hypotension: PAS < 90 mmHg ou chute > 30 mmHg', 'Hypotension: PAS < 90 mmHg ou chute > 30 mmHg'),
          LString('Signes d\'hypoperfusion: marbrures, confusion, oligurie', 'Signes d\'hypoperfusion: marbrures, confusion, oligurie'),
          LString('Signes de congestion: OAP, turgescence jugulaire', 'Signes de congestion: OAP, turgescence jugulaire'),
          LString('IC bas débit + index cardiaque < 2.2 L/min/m²', 'IC bas débit + index cardiaque < 2.2 L/min/m²'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Étiologies à rechercher', '2. Étiologies à rechercher'),
        content: LString('Causes principales.', 'Causes principales.'),
        bulletPoints: [
          LString('SCA (80% des cas)', 'SCA (80% des cas)'),
          LString('Complications mécaniques: rupture, CIV, IM aiguë', 'Complications mécaniques: rupture, CIV, IM aiguë'),
          LString('Myocardite aiguë', 'Myocardite aiguë'),
          LString('Embolie pulmonaire massive', 'Embolie pulmonaire massive'),
          LString('Tamponnade', 'Tamponnade'),
          LString('Décompensation cardiopathie chronique', 'Décompensation cardiopathie chronique'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Oxygénation', '3. Oxygénation'),
        content: LString('Support respiratoire.', 'Support respiratoire.'),
        bulletPoints: [
          LString('O2 si SpO2 < 90%', 'O2 si SpO2 < 90%'),
          LString('VNI si OAP toléré', 'VNI si OAP toléré'),
          LString('Intubation si détresse majeure', 'Intubation si détresse majeure'),
          LString('Attention: pression positive peut aggraver le choc', 'Attention: pression positive peut aggraver le choc'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Remplissage prudent', '4. Remplissage prudent'),
        content: LString('Test de remplissage limité.', 'Test de remplissage limité.'),
        bulletPoints: [
          LString('250 mL NaCl si pas de congestion évidente', '250 mL NaCl si pas de congestion évidente'),
          LString('Réévaluer immédiatement', 'Réévaluer immédiatement'),
          LString('Éviter si signes de surcharge (OAP)', 'Éviter si signes de surcharge (OAP)'),
        ],
        warning: LString('Le remplissage peut aggraver la situation', 'Le remplissage peut aggraver la situation'),
      ),
      ProtocolStep(
        title: LString('5. Support inotrope', '5. Support inotrope'),
        content: LString('Première ligne médicamenteuse.', 'Première ligne médicamenteuse.'),
        bulletPoints: [
          LString('Dobutamine 2.5-20 µg/kg/min (inotrope positif)', 'Dobutamine 2.5-20 µg/kg/min (inotrope positif)'),
          LString('Noradrénaline si hypotension profonde', 'Noradrénaline si hypotension profonde'),
          LString('Adrénaline si choc réfractaire', 'Adrénaline si choc réfractaire'),
          LString('Éviter dopamine (plus d\'arythmies)', 'Éviter dopamine (plus d\'arythmies)'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Assistance circulatoire', '6. Assistance circulatoire'),
        content: LString('Si choc réfractaire.', 'Si choc réfractaire.'),
        bulletPoints: [
          LString('Ballon de contre-pulsion intra-aortique (CPBIA)', 'Ballon de contre-pulsion intra-aortique (CPBIA)'),
          LString('ECMO veino-artérielle', 'ECMO veino-artérielle'),
          LString('Impella (assistance ventriculaire)', 'Impella (assistance ventriculaire)'),
          LString('Décision multidisciplinaire urgente', 'Décision multidisciplinaire urgente'),
        ],
      ),
      ProtocolStep(
        title: LString('7. Traitement étiologique', '7. Traitement étiologique'),
        content: LString('En parallèle.', 'En parallèle.'),
        bulletPoints: [
          LString('SCA: coronarographie urgente', 'SCA: coronarographie urgente'),
          LString('Complication mécanique: chirurgie', 'Complication mécanique: chirurgie'),
          LString('Tamponnade: péricardiocentèse', 'Tamponnade: péricardiocentèse'),
          LString('EP massive: thrombolyse', 'EP massive: thrombolyse'),
        ],
      ),
    ],
    keyPoints: LString('Identifier cause. Remplissage prudent. Dobutamine ± noradrénaline. ECMO si réfractaire. Traiter étiologie.', 'Identifier cause. Remplissage prudent. Dobutamine ± noradrénaline. ECMO si réfractaire. Traiter étiologie.'),
    source: LString('ESC Guidelines - Cardiogenic shock', 'ESC Guidelines - Cardiogenic shock'),
    lastUpdated: 2021,
  ),

  // Tamponnade
  Protocol(
    id: 'tamponnade',
    name: LString('Tamponnade Cardiaque', 'Tamponnade Cardiaque'),
    category: ProtocolCategory.resuscitation,
    description: LString('Compression cardiaque par épanchement péricardique', 'Compression cardiaque par épanchement péricardique'),
    indication: LString('Triade de Beck + instabilité hémodynamique', 'Triade de Beck + instabilité hémodynamique'),
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Reconnaissance'),
        content: LString('Signes cliniques.', 'Signes cliniques.'),
        bulletPoints: [
          LString('Triade de Beck: hypotension, BDC assourdis, turgescence jugulaire', 'Triade de Beck: hypotension, BDC assourdis, turgescence jugulaire'),
          LString('Pouls paradoxal > 10 mmHg', 'Pouls paradoxal > 10 mmHg'),
          LString('Tachycardie, dyspnée', 'Tachycardie, dyspnée'),
          LString('Contexte: trauma, péricardite, cancer, chirurgie cardiaque', 'Contexte: trauma, péricardite, cancer, chirurgie cardiaque'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Échocardiographie', '2. Échocardiographie'),
        content: LString('Confirmation diagnostique.', 'Confirmation diagnostique.'),
        bulletPoints: [
          LString('Épanchement péricardique', 'Épanchement péricardique'),
          LString('Collapsus diastolique OD puis VD', 'Collapsus diastolique OD puis VD'),
          LString('Variation respiratoire des flux (> 25%)', 'Variation respiratoire des flux (> 25%)'),
          LString('VCI dilatée sans variation respiratoire', 'VCI dilatée sans variation respiratoire'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Mesures temporaires', '3. Mesures temporaires'),
        content: LString('En attendant drainage.', 'En attendant drainage.'),
        bulletPoints: [
          LString('Remplissage vasculaire 500-1000 mL', 'Remplissage vasculaire 500-1000 mL'),
          LString('Position demi-assise', 'Position demi-assise'),
          LString('Éviter ventilation pression positive', 'Éviter ventilation pression positive'),
          LString('Dobutamine si besoin', 'Dobutamine si besoin'),
        ],
        warning: LString('Ne pas retarder le drainage', 'Ne pas retarder le drainage'),
      ),
      ProtocolStep(
        title: LString('4. Péricardiocentèse', '4. Péricardiocentèse'),
        content: LString('Geste salvateur.', 'Geste salvateur.'),
        bulletPoints: [
          LString('Échoguidage +++', 'Échoguidage +++'),
          LString('Voie sous-xiphoïdienne ou apicale', 'Voie sous-xiphoïdienne ou apicale'),
          LString('Anesthésie locale', 'Anesthésie locale'),
          LString('Aspiration progressive', 'Aspiration progressive'),
          LString('Laisser drain si récidive possible', 'Laisser drain si récidive possible'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Drainage chirurgical', '5. Drainage chirurgical'),
        content: LString('Indications.', 'Indications.'),
        bulletPoints: [
          LString('Tamponnade traumatique (hémopéricarde)', 'Tamponnade traumatique (hémopéricarde)'),
          LString('Épanchement cloisonné', 'Épanchement cloisonné'),
          LString('Récidive après péricardiocentèse', 'Récidive après péricardiocentèse'),
          LString('Nécessité de biopsie péricardique', 'Nécessité de biopsie péricardique'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Causes à rechercher', '6. Causes à rechercher'),
        content: LString('Étiologie.', 'Étiologie.'),
        bulletPoints: [
          LString('Péricardite (virale, tuberculeuse)', 'Péricardite (virale, tuberculeuse)'),
          LString('Néoplasie', 'Néoplasie'),
          LString('Urémique', 'Urémique'),
          LString('Dissection aortique', 'Dissection aortique'),
          LString('Iatrogène (cathétérisme, chirurgie)', 'Iatrogène (cathétérisme, chirurgie)'),
          LString('Trauma', 'Trauma'),
        ],
      ),
    ],
    keyPoints: LString('Triade de Beck + écho. Remplissage en attendant. Péricardiocentèse échoguidée. Chirurgie si trauma.', 'Triade de Beck + écho. Remplissage en attendant. Péricardiocentèse échoguidée. Chirurgie si trauma.'),
    source: LString('ESC Guidelines - Pericardial diseases', 'ESC Guidelines - Pericardial diseases'),
    lastUpdated: 2015,
  ),

  // Remplissage vasculaire
  Protocol(
    id: 'remplissage-vasculaire',
    name: LString('Remplissage Vasculaire', 'Remplissage Vasculaire'),
    category: ProtocolCategory.resuscitation,
    description: LString('Stratégie de remplissage en réanimation', 'Stratégie de remplissage en réanimation'),
    indication: LString('Hypovolémie, état de choc, précharge-dépendance', 'Hypovolémie, état de choc, précharge-dépendance'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation de la volémie', '1. Évaluation de la volémie'),
        content: LString('Critères cliniques et dynamiques.', 'Critères cliniques et dynamiques.'),
        bulletPoints: [
          LString('Clinique: TRC, marbrures, diurèse', 'Clinique: TRC, marbrures, diurèse'),
          LString('Indices dynamiques: ΔPP > 13%, variations VCI', 'Indices dynamiques: ΔPP > 13%, variations VCI'),
          LString('Lever de jambes passif: augmentation VES > 10%', 'Lever de jambes passif: augmentation VES > 10%'),
          LString('Test de remplissage: 250-500 mL et réévaluer', 'Test de remplissage: 250-500 mL et réévaluer'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Choix du soluté', '2. Choix du soluté'),
        content: LString('Cristalloïdes en première intention.', 'Cristalloïdes en première intention.'),
        bulletPoints: [
          LString('NaCl 0.9%: isotonique, référence', 'NaCl 0.9%: isotonique, référence'),
          LString('Ringer lactate: plus physiologique, évite acidose hyperchlorémique', 'Ringer lactate: plus physiologique, évite acidose hyperchlorémique'),
          LString('Éviter HEA (risque rénal)', 'Éviter HEA (risque rénal)'),
          LString('Albumine: peu d\'indications en urgence', 'Albumine: peu d\'indications en urgence'),
        ],
        tip: LString('Ringer lactate préféré si gros volumes', 'Ringer lactate préféré si gros volumes'),
      ),
      ProtocolStep(
        title: LString('3. Objectifs', '3. Objectifs'),
        content: LString('Cibles hémodynamiques.', 'Cibles hémodynamiques.'),
        bulletPoints: [
          LString('PAM ≥ 65 mmHg (≥ 80 si HTA chronique)', 'PAM ≥ 65 mmHg (≥ 80 si HTA chronique)'),
          LString('Diurèse > 0.5 mL/kg/h', 'Diurèse > 0.5 mL/kg/h'),
          LString('Lactates en décroissance', 'Lactates en décroissance'),
          LString('Amélioration clinique (marbrures, conscience)', 'Amélioration clinique (marbrures, conscience)'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Limites du remplissage', '4. Limites du remplissage'),
        content: LString('Éviter la surcharge.', 'Éviter la surcharge.'),
        bulletPoints: [
          LString('Surveillance signes congestifs', 'Surveillance signes congestifs'),
          LString('Pas de volume fixe recommandé', 'Pas de volume fixe recommandé'),
          LString('Réévaluation après chaque bolus', 'Réévaluation après chaque bolus'),
          LString('Si pas de réponse après 2-3 L: vasopresseurs', 'Si pas de réponse après 2-3 L: vasopresseurs'),
        ],
        warning: LString('Surcharge = risque SDRA, œdème cérébral', 'Surcharge = risque SDRA, œdème cérébral'),
      ),
      ProtocolStep(
        title: LString('5. Situations particulières', '5. Situations particulières'),
        content: LString('Adapter au contexte.', 'Adapter au contexte.'),
        bulletPoints: [
          LString('Choc septique: 30 mL/kg initial (guideline)', 'Choc septique: 30 mL/kg initial (guideline)'),
          LString('Choc cardiogénique: prudence ++', 'Choc cardiogénique: prudence ++'),
          LString('Choc hémorragique: hypotension permissive, transfusion précoce', 'Choc hémorragique: hypotension permissive, transfusion précoce'),
          LString('TC grave: éviter hypotension, limiter surcharge', 'TC grave: éviter hypotension, limiter surcharge'),
        ],
      ),
    ],
    keyPoints: LString('Cristalloïdes en première ligne. Évaluer réponse au remplissage. Éviter surcharge. Adapter au contexte.', 'Cristalloïdes en première ligne. Évaluer réponse au remplissage. Éviter surcharge. Adapter au contexte.'),
    source: LString('Surviving Sepsis Campaign 2021, ESICM', 'Surviving Sepsis Campaign 2021, ESICM'),
    lastUpdated: 2021,
  ),

  // Support vasoactif
  Protocol(
    id: 'support-vasoactif',
    name: LString('Support Vasoactif', 'Support Vasoactif'),
    category: ProtocolCategory.resuscitation,
    description: LString('Utilisation des catécholamines en réanimation', 'Utilisation des catécholamines en réanimation'),
    indication: LString('Choc persistant malgré remplissage adapté', 'Choc persistant malgré remplissage adapté'),
    steps: [
      ProtocolStep(
        title: LString('1. Noradrénaline', '1. Noradrénaline'),
        content: LString('Vasopresseur de référence.', 'Vasopresseur de référence.'),
        bulletPoints: [
          LString('Indication: choc avec vasoplégie (septique, anaphylactique)', 'Indication: choc avec vasoplégie (septique, anaphylactique)'),
          LString('Dose: 0.1-3 µg/kg/min', 'Dose: 0.1-3 µg/kg/min'),
          LString('Objectif: PAM ≥ 65 mmHg', 'Objectif: PAM ≥ 65 mmHg'),
          LString('VVC recommandée mais VVP possible initialement', 'VVC recommandée mais VVP possible initialement'),
        ],
        tip: LString('Peut être débuté sur VVP gros calibre < 4-6h', 'Peut être débuté sur VVP gros calibre < 4-6h'),
      ),
      ProtocolStep(
        title: LString('2. Adrénaline', '2. Adrénaline'),
        content: LString('Inotrope et vasopresseur.', 'Inotrope et vasopresseur.'),
        bulletPoints: [
          LString('Indication: choc cardiogénique réfractaire, anaphylaxie', 'Indication: choc cardiogénique réfractaire, anaphylaxie'),
          LString('Dose: 0.1-1 µg/kg/min', 'Dose: 0.1-1 µg/kg/min'),
          LString('Effets: β1 (inotrope), α1 (vasopresseur), β2 (bronchodilatateur)', 'Effets: β1 (inotrope), α1 (vasopresseur), β2 (bronchodilatateur)'),
          LString('Risque: tachycardie, arythmie, hyperlactatémie', 'Risque: tachycardie, arythmie, hyperlactatémie'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Dobutamine', '3. Dobutamine'),
        content: LString('Inotrope pur.', 'Inotrope pur.'),
        bulletPoints: [
          LString('Indication: choc cardiogénique avec PAM maintenue', 'Indication: choc cardiogénique avec PAM maintenue'),
          LString('Dose: 2.5-20 µg/kg/min', 'Dose: 2.5-20 µg/kg/min'),
          LString('Effet β1 prédominant', 'Effet β1 prédominant'),
          LString('Attention: peut baisser la PA (effet β2)', 'Attention: peut baisser la PA (effet β2)'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Vasopressine/Terlipressine', '4. Vasopressine/Terlipressine'),
        content: LString('Deuxième ligne.', 'Deuxième ligne.'),
        bulletPoints: [
          LString('Indication: choc septique réfractaire à noradrénaline', 'Indication: choc septique réfractaire à noradrénaline'),
          LString('Vasopressine: 0.03 U/min (dose fixe)', 'Vasopressine: 0.03 U/min (dose fixe)'),
          LString('Épargne en catécholamines', 'Épargne en catécholamines'),
          LString('CI: ischémie mésentérique, coronaire', 'CI: ischémie mésentérique, coronaire'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Choix selon type de choc', '5. Choix selon type de choc'),
        content: LString('Adaptation.', 'Adaptation.'),
        bulletPoints: [
          LString('Septique: Noradrénaline ± vasopressine ± dobutamine', 'Septique: Noradrénaline ± vasopressine ± dobutamine'),
          LString('Cardiogénique: Dobutamine ± noradrénaline', 'Cardiogénique: Dobutamine ± noradrénaline'),
          LString('Anaphylactique: Adrénaline', 'Anaphylactique: Adrénaline'),
          LString('Hémorragique: Noradrénaline (en attendant transfusion)', 'Hémorragique: Noradrénaline (en attendant transfusion)'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Surveillance', '6. Surveillance'),
        content: LString('Monitoring étroit.', 'Monitoring étroit.'),
        bulletPoints: [
          LString('PA invasive recommandée', 'PA invasive recommandée'),
          LString('VVC avec PVC', 'VVC avec PVC'),
          LString('Débit cardiaque si disponible', 'Débit cardiaque si disponible'),
          LString('Lactates, ScvO2', 'Lactates, ScvO2'),
          LString('Échographie cardiaque', 'Échographie cardiaque'),
        ],
      ),
    ],
    keyPoints: LString('Noradrénaline en 1ère ligne. Dobutamine si bas débit. Adapter au type de choc. VVC dès que possible.', 'Noradrénaline en 1ère ligne. Dobutamine si bas débit. Adapter au type de choc. VVC dès que possible.'),
    source: LString('Surviving Sepsis Campaign 2021, ESICM', 'Surviving Sepsis Campaign 2021, ESICM'),
    lastUpdated: 2021,
  ),

  // Indications ECMO
  Protocol(
    id: 'ecmo-indications',
    name: LString('Indications ECMO', 'Indications ECMO'),
    category: ProtocolCategory.resuscitation,
    description: LString('Oxygénation par membrane extracorporelle', 'Oxygénation par membrane extracorporelle'),
    indication: LString('Défaillance respiratoire ou cardiaque réfractaire', 'Défaillance respiratoire ou cardiaque réfractaire'),
    steps: [
      ProtocolStep(
        title: LString('1. Types d\'ECMO', '1. Types d\'ECMO'),
        content: LString('VV vs VA.', 'VV vs VA.'),
        bulletPoints: [
          LString('ECMO VV (veino-veineuse): défaillance respiratoire isolée', 'ECMO VV (veino-veineuse): défaillance respiratoire isolée'),
          LString('ECMO VA (veino-artérielle): défaillance cardiaque ± respiratoire', 'ECMO VA (veino-artérielle): défaillance cardiaque ± respiratoire'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Indications ECMO VV', '2. Indications ECMO VV'),
        content: LString('SDRA réfractaire.', 'SDRA réfractaire.'),
        bulletPoints: [
          LString('SDRA sévère (PaO2/FiO2 < 80) malgré optimisation', 'SDRA sévère (PaO2/FiO2 < 80) malgré optimisation'),
          LString('Ventilation protectrice impossible', 'Ventilation protectrice impossible'),
          LString('Hypercapnie réfractaire avec pH < 7.20', 'Hypercapnie réfractaire avec pH < 7.20'),
          LString('Score Murray > 3', 'Score Murray > 3'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Indications ECMO VA', '3. Indications ECMO VA'),
        content: LString('Choc cardiogénique réfractaire.', 'Choc cardiogénique réfractaire.'),
        bulletPoints: [
          LString('Choc cardiogénique réfractaire aux inotropes', 'Choc cardiogénique réfractaire aux inotropes'),
          LString('ACR réfractaire (eCPR) dans conditions spécifiques', 'ACR réfractaire (eCPR) dans conditions spécifiques'),
          LString('Post-chirurgie cardiaque', 'Post-chirurgie cardiaque'),
          LString('Bridge vers transplantation ou récupération', 'Bridge vers transplantation ou récupération'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Contre-indications relatives', '4. Contre-indications relatives'),
        content: LString('À évaluer.', 'À évaluer.'),
        bulletPoints: [
          LString('Âge avancé (selon centres)', 'Âge avancé (selon centres)'),
          LString('Comorbidités majeures', 'Comorbidités majeures'),
          LString('Défaillance multiviscérale prolongée', 'Défaillance multiviscérale prolongée'),
          LString('Pas de perspective de récupération ou transplantation', 'Pas de perspective de récupération ou transplantation'),
          LString('Anticoagulation impossible', 'Anticoagulation impossible'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Critères eCPR', '5. Critères eCPR'),
        content: LString('ECMO pour ACR.', 'ECMO pour ACR.'),
        bulletPoints: [
          LString('Âge < 70 ans (selon centres)', 'Âge < 70 ans (selon centres)'),
          LString('No-flow < 5 min', 'No-flow < 5 min'),
          LString('Low-flow < 60-90 min', 'Low-flow < 60-90 min'),
          LString('Cause réversible identifiable', 'Cause réversible identifiable'),
          LString('Pas de comorbidité majeure', 'Pas de comorbidité majeure'),
          LString('EtCO2 > 10 mmHg pendant RCP', 'EtCO2 > 10 mmHg pendant RCP'),
        ],
        warning: LString('Décision multidisciplinaire rapide', 'Décision multidisciplinaire rapide'),
      ),
      ProtocolStep(
        title: LString('6. Organisation', '6. Organisation'),
        content: LString('Mise en place.', 'Mise en place.'),
        bulletPoints: [
          LString('Contact centre ECMO', 'Contact centre ECMO'),
          LString('Transport médicalisé ou équipe mobile', 'Transport médicalisé ou équipe mobile'),
          LString('Canulation percutanée ou chirurgicale', 'Canulation percutanée ou chirurgicale'),
          LString('Anticoagulation par héparine', 'Anticoagulation par héparine'),
        ],
      ),
    ],
    keyPoints: LString('VV = poumon, VA = cœur. Contacter centre ECMO précocement. eCPR = critères stricts.', 'VV = poumon, VA = cœur. Contacter centre ECMO précocement. eCPR = critères stricts.'),
    source: LString('ELSO Guidelines, SFAR', 'ELSO Guidelines, SFAR'),
    lastUpdated: 2021,
  ),
];
