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
    name: LString('Arrêt Cardiorespiratoire Adulte', 'Adult Cardiac Arrest'),
    category: ProtocolCategory.cardiology,
    description: LString('Prise en charge de l\'ACR selon les recommandations ERC 2021', 'Cardiac arrest management per ERC 2021 guidelines'),
    indication: LString('Patient en arrêt cardiorespiratoire (absence de pouls, absence de respiration efficace)', 'Patient in cardiac arrest (no pulse, no effective breathing)'),
    contraindication: LString('Directives anticipées limitant la réanimation, signes de mort certaine', 'Advance directives limiting resuscitation, signs of certain death'),
    steps: [
      ProtocolStep(
        title: LString('1. Sécurité et reconnaissance', '1. Safety and recognition'),
        content: LString('Vérifier la sécurité de la scène. Évaluer la conscience et la respiration.', 'Check scene safety. Assess consciousness and breathing.'),
        bulletPoints: [
          LString('Secouer les épaules et appeler fort', 'Shake shoulders and call loudly'),
          LString('Regarder le thorax 10 secondes maximum', 'Look at chest for no more than 10 seconds'),
          LString('Gasps = absence de respiration', 'Gasps = no breathing'),
        ],
        warning: LString('Ne pas perdre de temps à chercher le pouls si non formé', 'Do not waste time searching for a pulse if untrained'),
      ),
      ProtocolStep(
        title: LString('2. Alerter et RCP de base', '2. Alert and basic CPR'),
        content: LString('Alerter les secours (15/112) et débuter immédiatement la RCP.', 'Alert emergency services (15/112) and start CPR immediately.'),
        bulletPoints: [
          LString('MCE: 100-120/min, profondeur 5-6 cm', 'Chest compressions: 100-120/min, depth 5-6 cm'),
          LString('Ratio 30:2 sans voie aérienne avancée', '30:2 ratio without advanced airway'),
          LString('Minimiser les interruptions < 10 sec', 'Minimize interruptions < 10 sec'),
          LString('Changer de masseur toutes les 2 min', 'Switch compressor every 2 min'),
        ],
        tip: LString('Utiliser le métronome du scope ou une application', 'Use the monitor metronome or an app'),
      ),
      ProtocolStep(
        title: LString('3. Défibrillation', '3. Defibrillation'),
        content: LString('Analyser le rythme dès que le défibrillateur est disponible.', 'Analyze rhythm as soon as defibrillator is available.'),
        bulletPoints: [
          LString('Rythme choquable (FV/TV sans pouls): choc 150-200J biphasique', 'Shockable rhythm (VF/pulseless VT): shock 150-200J biphasic'),
          LString('Reprendre immédiatement MCE après le choc', 'Resume chest compressions immediately after shock'),
          LString('Analyser le rythme toutes les 2 min', 'Analyze rhythm every 2 min'),
          LString('Rythme non choquable (asystolie/AESP): continuer RCP', 'Non-shockable rhythm (asystole/PEA): continue CPR'),
        ],
        warning: LString('Ne pas interrompre le MCE pendant la charge', 'Do not interrupt compressions during charging'),
      ),
      ProtocolStep(
        title: LString('4. Voies aériennes et ventilation', '4. Airway and ventilation'),
        content: LString('Sécuriser les voies aériennes progressivement.', 'Secure the airway progressively.'),
        bulletPoints: [
          LString('Canule oropharyngée + ballon-masque initialement', 'Oropharyngeal airway + bag-valve-mask initially'),
          LString('IOT si opérateur expérimenté sans interrompre MCE', 'ETI if experienced operator without interrupting compressions'),
          LString('Dispositif supraglottique si IOT difficile', 'Supraglottic device if ETI difficult'),
          LString('Ventilation 10/min une fois voie aérienne avancée', 'Ventilate 10/min once advanced airway placed'),
        ],
        tip: LString('La qualité du MCE prime sur l\'intubation', 'Quality of compressions takes priority over intubation'),
      ),
      ProtocolStep(
        title: LString('5. Adrénaline', '5. Epinephrine'),
        content: LString('Administrer l\'adrénaline selon le rythme.', 'Administer epinephrine based on rhythm.'),
        bulletPoints: [
          LString('Rythme non choquable: 1 mg IV dès que possible', 'Non-shockable rhythm: 1 mg IV as soon as possible'),
          LString('Rythme choquable: 1 mg IV après le 3ème choc', 'Shockable rhythm: 1 mg IV after 3rd shock'),
          LString('Répéter 1 mg toutes les 3-5 minutes', 'Repeat 1 mg every 3-5 minutes'),
          LString('Voie IO si accès IV impossible', 'IO access if IV impossible'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Amiodarone (si rythme choquable)', '6. Amiodarone (if shockable rhythm)'),
        content: LString('Administrer après le 3ème choc inefficace.', 'Administer after 3rd unsuccessful shock.'),
        bulletPoints: [
          LString('300 mg IV après le 3ème choc', '300 mg IV after 3rd shock'),
          LString('150 mg IV après le 5ème choc si toujours en FV/TV', '150 mg IV after 5th shock if still in VF/VT'),
        ],
      ),
      ProtocolStep(
        title: LString('7. Causes réversibles (4H/4T)', '7. Reversible causes (4H/4T)'),
        content: LString('Rechercher et traiter les causes réversibles.', 'Identify and treat reversible causes.'),
        bulletPoints: [
          LString('Hypoxie → oxygénation, ventilation', 'Hypoxia → oxygenation, ventilation'),
          LString('Hypovolémie → remplissage, transfusion', 'Hypovolemia → fluid resuscitation, transfusion'),
          LString('Hypo/Hyperkaliémie → correction ionique', 'Hypo/Hyperkalemia → electrolyte correction'),
          LString('Hypothermie → réchauffement', 'Hypothermia → rewarming'),
          LString('Thrombose coronaire → coronarographie', 'Coronary thrombosis → coronary angiography'),
          LString('Thrombose pulmonaire → thrombolyse', 'Pulmonary thrombosis → thrombolysis'),
          LString('Tamponnade → péricardiocentèse', 'Tamponade → pericardiocentesis'),
          LString('Pneumothorax sous Tension → exsufflation', 'Tension pneumothorax → needle decompression'),
        ],
        warning: LString('La thrombolyse nécessite 60-90 min de RCP après', 'Thrombolysis requires 60-90 min of CPR afterwards'),
      ),
      ProtocolStep(
        title: LString('8. Soins post-ACR', '8. Post-cardiac arrest care'),
        content: LString('Si RACS (Retour à une Activité Circulatoire Spontanée).', 'If ROSC (Return of Spontaneous Circulation).'),
        bulletPoints: [
          LString('Objectif SpO2 94-98%, éviter hyperoxie', 'Target SpO2 94-98%, avoid hyperoxia'),
          LString('PAS > 100 mmHg (noradrénaline si besoin)', 'SBP > 100 mmHg (norepinephrine if needed)'),
          LString('Contrôle glycémique (éviter hypo/hyperglycémie)', 'Glycemic control (avoid hypo/hyperglycemia)'),
          LString('Contrôle température cible 32-36°C pendant 24h', 'Targeted temperature management 32-36°C for 24h'),
          LString('Coronarographie si suspicion SCA', 'Coronary angiography if ACS suspected'),
          LString('EEG et scanner cérébral', 'EEG and brain CT scan'),
        ],
      ),
    ],
    keyPoints: LString('MCE de haute qualité est la priorité absolue. Minimiser les interruptions. Défibrillation précoce si rythme choquable.', 'High-quality chest compressions are the absolute priority. Minimize interruptions. Early defibrillation if shockable rhythm.'),
    source: LString('ERC Guidelines 2021', 'ERC Guidelines 2021'),
    sourceUrl: 'https://www.erc.edu',
    lastUpdated: 2021,
  ),

  // SCA ST+
  Protocol(
    id: 'sca-st-plus',
    name: LString('SCA ST+ (STEMI)', 'STEMI (ST-Elevation MI)'),
    category: ProtocolCategory.cardiology,
    description: LString('Syndrome coronarien aigu avec sus-décalage du segment ST', 'Acute coronary syndrome with ST-segment elevation'),
    indication: LString('Douleur thoracique typique avec sus-décalage ST ≥ 1mm dans 2 dérivations contiguës ou BBG nouveau', 'Typical chest pain with ST elevation ≥ 1mm in 2 contiguous leads or new LBBB'),
    contraindication: LString('Voir contre-indications à la thrombolyse si applicable', 'See thrombolysis contraindications if applicable'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation initiale', '1. Initial assessment'),
        content: LString('Diagnostic et stratification rapide.', 'Rapid diagnosis and stratification.'),
        bulletPoints: [
          LString('ECG 12 dérivations < 10 min', '12-lead ECG < 10 min'),
          LString('Monitoring continu (scope, SpO2)', 'Continuous monitoring (telemetry, SpO2)'),
          LString('Voie veineuse périphérique', 'Peripheral IV access'),
          LString('Bilan: troponine, NFS, iono, créat, coag', 'Labs: troponin, CBC, electrolytes, creatinine, coagulation'),
        ],
        warning: LString('ECG 18 dérivations si suspicion infarctus inférieur ou postérieur', '18-lead ECG if inferior or posterior MI suspected'),
      ),
      ProtocolStep(
        title: LString('2. Traitement antalgique et symptomatique', '2. Analgesic and supportive treatment'),
        content: LString('Soulager la douleur et stabiliser le patient.', 'Relieve pain and stabilize the patient.'),
        bulletPoints: [
          LString('Morphine IV titrée si douleur intense (bolus 2-3 mg)', 'Titrated IV morphine if severe pain (2-3 mg bolus)'),
          LString('O2 uniquement si SpO2 < 90%', 'O2 only if SpO2 < 90%'),
          LString('Position demi-assise', 'Semi-upright position'),
        ],
        tip: LString('Éviter O2 systématique (risque d\'hyperoxie)', 'Avoid routine O2 (risk of hyperoxia)'),
      ),
      ProtocolStep(
        title: LString('3. Traitement antithrombotique', '3. Antithrombotic therapy'),
        content: LString('Double antiagrégation plaquettaire.', 'Dual antiplatelet therapy.'),
        bulletPoints: [
          LString('Aspirine 150-300 mg PO (ou 75-150 mg IV)', 'Aspirin 150-300 mg PO (or 75-150 mg IV)'),
          LString('Inhibiteur P2Y12: Ticagrelor 180 mg ou Prasugrel 60 mg', 'P2Y12 inhibitor: Ticagrelor 180 mg or Prasugrel 60 mg'),
          LString('Si > 75 ans ou < 60 kg: Clopidogrel 600 mg', 'If > 75 y/o or < 60 kg: Clopidogrel 600 mg'),
          LString('Anticoagulation: HNF 70-100 UI/kg IV ou Énoxaparine', 'Anticoagulation: UFH 70-100 IU/kg IV or Enoxaparin'),
        ],
        warning: LString('Prasugrel contre-indiqué si ATCD AVC/AIT ou > 75 ans', 'Prasugrel contraindicated if prior stroke/TIA or > 75 y/o'),
      ),
      ProtocolStep(
        title: LString('4. Stratégie de reperfusion', '4. Reperfusion strategy'),
        content: LString('Choix entre angioplastie primaire et thrombolyse.', 'Choice between primary PCI and thrombolysis.'),
        bulletPoints: [
          LString('Angioplastie primaire si délai < 120 min (préféré)', 'Primary PCI if delay < 120 min (preferred)'),
          LString('Thrombolyse si délai angioplastie > 120 min et symptômes < 12h', 'Thrombolysis if PCI delay > 120 min and symptoms < 12h'),
          LString('Ténectéplase dose adaptée au poids', 'Tenecteplase weight-adjusted dose'),
          LString('Transfert pour coronarographie 2-24h après thrombolyse', 'Transfer for angiography 2-24h post-thrombolysis'),
        ],
        tip: LString('Contact direct avec cardiologue interventionnel', 'Direct contact with interventional cardiologist'),
      ),
      ProtocolStep(
        title: LString('5. Critères de reperfusion post-thrombolyse', '5. Post-thrombolysis reperfusion criteria'),
        content: LString('Évaluer le succès de la thrombolyse à 60-90 min.', 'Assess thrombolysis success at 60-90 min.'),
        bulletPoints: [
          LString('Succès: réduction ST > 50%, disparition douleur', 'Success: ST reduction > 50%, pain resolution'),
          LString('Échec: coronarographie de sauvetage urgente', 'Failure: urgent rescue angiography'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Complications à surveiller', '6. Complications to monitor'),
        content: LString('Surveillance des complications précoces.', 'Monitor for early complications.'),
        bulletPoints: [
          LString('Troubles du rythme (FV, TV, BAV)', 'Arrhythmias (VF, VT, AV block)'),
          LString('Insuffisance cardiaque aiguë', 'Acute heart failure'),
          LString('Choc cardiogénique', 'Cardiogenic shock'),
          LString('Complications mécaniques (rupture, CIV)', 'Mechanical complications (rupture, VSD)'),
        ],
      ),
    ],
    keyPoints: LString('Time is muscle. Objectif: premier contact médical → reperfusion < 120 min. ECG < 10 min.', 'Time is muscle. Goal: first medical contact → reperfusion < 120 min. ECG < 10 min.'),
    source: LString('ESC Guidelines 2023 - STEMI', 'ESC Guidelines 2023 - STEMI'),
    sourceUrl: 'https://www.escardio.org',
    lastUpdated: 2023,
  ),

  // SCA ST-
  Protocol(
    id: 'sca-st-moins',
    name: LString('SCA ST- (NSTEMI)', 'NSTEMI (Non-ST-Elevation MI)'),
    category: ProtocolCategory.cardiology,
    description: LString('Syndrome coronarien aigu sans sus-décalage du ST', 'Acute coronary syndrome without ST elevation'),
    indication: LString('Douleur thoracique avec modification ECG (sous-décalage ST, ondes T négatives) et/ou élévation troponine', 'Chest pain with ECG changes (ST depression, T-wave inversion) and/or elevated troponin'),
    steps: [
      ProtocolStep(
        title: LString('1. Diagnostic', '1. Diagnosis'),
        content: LString('Confirmer le diagnostic et stratifier le risque.', 'Confirm diagnosis and stratify risk.'),
        bulletPoints: [
          LString('ECG répété si premier normal', 'Repeat ECG if first is normal'),
          LString('Troponine hs à H0 et H1 (ou H3)', 'hs-Troponin at H0 and H1 (or H3)'),
          LString('Score GRACE pour stratification', 'GRACE score for stratification'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Stratification du risque (GRACE)', '2. Risk stratification (GRACE)'),
        content: LString('Déterminer le délai de coronarographie.', 'Determine timing of coronary angiography.'),
        bulletPoints: [
          LString('Très haut risque (immédiat < 2h): instabilité HD, arythmie, douleur réfractaire', 'Very high risk (immediate < 2h): hemodynamic instability, arrhythmia, refractory pain'),
          LString('Haut risque (< 24h): GRACE > 140, modification ST/T, élévation troponine', 'High risk (< 24h): GRACE > 140, ST/T changes, troponin elevation'),
          LString('Risque intermédiaire (< 72h): diabète, IRC, FEVG < 40%, angioplastie récente', 'Intermediate risk (< 72h): diabetes, CKD, LVEF < 40%, recent PCI'),
          LString('Bas risque: test d\'ischémie non invasif', 'Low risk: non-invasive ischemia testing'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Traitement antithrombotique', '3. Antithrombotic therapy'),
        content: LString('Similaire au STEMI avec adaptation selon stratégie.', 'Similar to STEMI with strategy-based adaptation.'),
        bulletPoints: [
          LString('Aspirine 150-300 mg', 'Aspirin 150-300 mg'),
          LString('Inhibiteur P2Y12 selon timing coronarographie', 'P2Y12 inhibitor based on angiography timing'),
          LString('Anticoagulation: Fondaparinux 2.5 mg SC (préféré si non urgent)', 'Anticoagulation: Fondaparinux 2.5 mg SC (preferred if non-urgent)'),
          LString('ou Énoxaparine 1 mg/kg x2/j', 'or Enoxaparin 1 mg/kg BID'),
        ],
        tip: LString('Ticagrelor en prétraitement si coronarographie prévue', 'Ticagrelor pretreatment if angiography planned'),
      ),
      ProtocolStep(
        title: LString('4. Traitements adjuvants', '4. Adjunctive therapy'),
        content: LString('Optimisation du traitement médical.', 'Medical therapy optimization.'),
        bulletPoints: [
          LString('Bêtabloquant si FC > 70 et pas de CI', 'Beta-blocker if HR > 70 and no CI'),
          LString('IEC/ARA2 si FEVG altérée ou HTA', 'ACEI/ARB if reduced LVEF or hypertension'),
          LString('Statine haute dose', 'High-dose statin'),
          LString('IPP si double antiagrégation', 'PPI if dual antiplatelet therapy'),
        ],
      ),
    ],
    keyPoints: LString('La stratification du risque guide le délai de coronarographie. Le score GRACE est essentiel.', 'Risk stratification guides timing of angiography. GRACE score is essential.'),
    source: LString('ESC Guidelines 2023 - NSTE-ACS', 'ESC Guidelines 2023 - NSTE-ACS'),
    sourceUrl: 'https://www.escardio.org',
    lastUpdated: 2023,
  ),

  // OAP
  Protocol(
    id: 'oap',
    name: LString('Œdème Aigu du Poumon', 'Acute Pulmonary Edema'),
    category: ProtocolCategory.cardiology,
    description: LString('Insuffisance cardiaque aiguë avec œdème pulmonaire', 'Acute heart failure with pulmonary edema'),
    indication: LString('Dyspnée aiguë avec signes de congestion pulmonaire et/ou systémique', 'Acute dyspnea with signs of pulmonary and/or systemic congestion'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation immédiate', '1. Immediate assessment'),
        content: LString('Évaluer la gravité et le profil hémodynamique.', 'Assess severity and hemodynamic profile.'),
        bulletPoints: [
          LString('Position assise ou demi-assise', 'Upright or semi-upright position'),
          LString('Signes de gravité: tirage, cyanose, sueurs, troubles conscience', 'Severity signs: retractions, cyanosis, diaphoresis, altered consciousness'),
          LString('Profil "chaud-humide" vs "froid-humide" (choc cardiogénique)', '"Warm-wet" vs "cold-wet" profile (cardiogenic shock)'),
          LString('Rechercher facteur déclenchant (SCA, arythmie, poussée HTA)', 'Identify precipitant (ACS, arrhythmia, hypertensive crisis)'),
        ],
        warning: LString('Si PAS < 90 mmHg: choc cardiogénique → protocole spécifique', 'If SBP < 90 mmHg: cardiogenic shock → specific protocol'),
      ),
      ProtocolStep(
        title: LString('2. Oxygénation', '2. Oxygenation'),
        content: LString('Corriger l\'hypoxémie rapidement.', 'Correct hypoxemia rapidly.'),
        bulletPoints: [
          LString('O2 haut débit si SpO2 < 90%', 'High-flow O2 if SpO2 < 90%'),
          LString('VNI (CPAP/BiPAP) si persistance détresse', 'NIV (CPAP/BiPAP) if persistent distress'),
          LString('CPAP 5-10 cmH2O ou BiPAP (IPAP 10-15, EPAP 5-10)', 'CPAP 5-10 cmH2O or BiPAP (IPAP 10-15, EPAP 5-10)'),
          LString('Intubation si échec VNI ou trouble conscience', 'Intubation if NIV failure or altered consciousness'),
        ],
        tip: LString('VNI à privilégier, réduit le recours à l\'intubation', 'NIV preferred, reduces need for intubation'),
      ),
      ProtocolStep(
        title: LString('3. Diurétiques', '3. Diuretics'),
        content: LString('Réduire la surcharge hydrosodée.', 'Reduce fluid overload.'),
        bulletPoints: [
          LString('Furosémide 40-80 mg IV (si traitement chronique: dose ≥ dose habituelle)', 'Furosemide 40-80 mg IV (if on chronic diuretics: dose ≥ usual dose)'),
          LString('Répéter si réponse insuffisante', 'Repeat if insufficient response'),
          LString('Objectif diurèse > 100 mL/h les premières heures', 'Target urine output > 100 mL/h in first hours'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Vasodilatateurs (si PAS > 110 mmHg)', '4. Vasodilators (if SBP > 110 mmHg)'),
        content: LString('Réduire la post-charge et la congestion.', 'Reduce afterload and congestion.'),
        bulletPoints: [
          LString('Trinitrine sublinguale puis IVSE', 'Sublingual nitroglycerin then IV infusion'),
          LString('Dose: 1-2 mg/h, titrer jusqu\'à 10 mg/h', 'Dose: 1-2 mg/h, titrate up to 10 mg/h'),
          LString('Surveillance tensionnelle rapprochée', 'Close blood pressure monitoring'),
        ],
        warning: LString('CI si PAS < 110 mmHg ou prise récente d\'IPDE5', 'CI if SBP < 110 mmHg or recent PDE5 inhibitor use'),
      ),
      ProtocolStep(
        title: LString('5. Rechercher et traiter la cause', '5. Identify and treat the cause'),
        content: LString('Identifier le facteur déclenchant.', 'Identify the precipitating factor.'),
        bulletPoints: [
          LString('ECG: SCA? Arythmie?', 'ECG: ACS? Arrhythmia?'),
          LString('Troponine, BNP/NT-proBNP', 'Troponin, BNP/NT-proBNP'),
          LString('Échocardiographie', 'Echocardiography'),
          LString('Si SCA: stratégie de reperfusion', 'If ACS: reperfusion strategy'),
          LString('Si FA rapide: contrôle fréquence/rythme', 'If rapid AF: rate/rhythm control'),
        ],
      ),
    ],
    keyPoints: LString('Position assise + O2/VNI + Diurétiques + Vasodilatateurs (si PAS ok). Identifier la cause.', 'Upright position + O2/NIV + Diuretics + Vasodilators (if SBP ok). Identify the cause.'),
    source: LString('ESC Guidelines 2021 - Heart Failure', 'ESC Guidelines 2021 - Heart Failure'),
    sourceUrl: 'https://www.escardio.org',
    lastUpdated: 2021,
  ),

  // Troubles du rythme
  Protocol(
    id: 'troubles-rythme',
    name: LString('Troubles du Rythme aux Urgences', 'Emergency Arrhythmia Management'),
    category: ProtocolCategory.cardiology,
    description: LString('Prise en charge des tachycardies et bradycardies instables', 'Management of unstable tachycardias and bradycardias'),
    indication: LString('Arythmie avec retentissement hémodynamique ou symptômes sévères', 'Arrhythmia with hemodynamic compromise or severe symptoms'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation de l\'instabilité', '1. Instability assessment'),
        content: LString('Identifier les signes de mauvaise tolérance.', 'Identify signs of hemodynamic compromise.'),
        bulletPoints: [
          LString('Hypotension (PAS < 90 mmHg)', 'Hypotension (SBP < 90 mmHg)'),
          LString('Altération de la conscience', 'Altered consciousness'),
          LString('Douleur thoracique ischémique', 'Ischemic chest pain'),
          LString('Insuffisance cardiaque aiguë', 'Acute heart failure'),
        ],
        warning: LString('Patient instable = cardioversion/pacing en urgence', 'Unstable patient = emergency cardioversion/pacing'),
      ),
      ProtocolStep(
        title: LString('2. Tachycardie instable', '2. Unstable tachycardia'),
        content: LString('Cardioversion électrique synchronisée.', 'Synchronized electrical cardioversion.'),
        bulletPoints: [
          LString('Sédation rapide (midazolam, étomidate, kétamine)', 'Rapid sedation (midazolam, etomidate, ketamine)'),
          LString('Mode synchrone obligatoire (sauf FV)', 'Synchronized mode mandatory (except VF)'),
          LString('QRS fin: 70-120J biphasique', 'Narrow QRS: 70-120J biphasic'),
          LString('QRS large: 120-150J biphasique', 'Wide QRS: 120-150J biphasic'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Tachycardie régulière à QRS fins (stable)', '3. Regular narrow-QRS tachycardia (stable)'),
        content: LString('Manœuvres vagales puis adénosine.', 'Vagal maneuvers then adenosine.'),
        bulletPoints: [
          LString('Manœuvres vagales (Valsalva modifié)', 'Vagal maneuvers (modified Valsalva)'),
          LString('Adénosine 6 mg IVD rapide puis 12 mg si échec', 'Adenosine 6 mg rapid IV push then 12 mg if failed'),
          LString('Si FA: contrôle fréquence ou cardioversion selon durée', 'If AF: rate control or cardioversion based on duration'),
        ],
        tip: LString('Valsalva modifié: expiration forcée puis lever les jambes', 'Modified Valsalva: forced expiration then leg elevation'),
      ),
      ProtocolStep(
        title: LString('4. Tachycardie régulière à QRS larges (stable)', '4. Regular wide-QRS tachycardia (stable)'),
        content: LString('Traiter comme TV jusqu\'à preuve du contraire.', 'Treat as VT until proven otherwise.'),
        bulletPoints: [
          LString('Amiodarone 300 mg IV en 20-60 min', 'Amiodarone 300 mg IV over 20-60 min'),
          LString('Si TV confirmée: alternatives selon étiologie', 'If VT confirmed: alternatives based on etiology'),
          LString('Ne jamais utiliser vérapamil si doute', 'Never use verapamil if uncertain'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Bradycardie instable', '5. Unstable bradycardia'),
        content: LString('Stimulation cardiaque.', 'Cardiac pacing.'),
        bulletPoints: [
          LString('Atropine 0.5-1 mg IV (max 3 mg)', 'Atropine 0.5-1 mg IV (max 3 mg)'),
          LString('Si échec: adrénaline IV 2-10 µg/min', 'If failed: epinephrine IV 2-10 µg/min'),
          LString('Pacing externe transcutané', 'Transcutaneous external pacing'),
          LString('Pacing transveneux si échec', 'Transvenous pacing if failed'),
        ],
        warning: LString('Atropine inefficace si bloc infra-nodal ou cœur transplanté', 'Atropine ineffective in infranodal block or transplanted heart'),
      ),
    ],
    keyPoints: LString('Instable = choc électrique ou pacing. Stable = traitement médicamenteux selon le type.', 'Unstable = electrical shock or pacing. Stable = pharmacological treatment by type.'),
    source: LString('ERC Guidelines 2021 - Arythmies péri-arrêt', 'ERC Guidelines 2021 - Peri-arrest Arrhythmias'),
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
    name: LString('Asthme Aigu Grave', 'Severe Acute Asthma'),
    category: ProtocolCategory.respiratory,
    description: LString('Exacerbation sévère d\'asthme mettant en jeu le pronostic vital', 'Life-threatening severe asthma exacerbation'),
    indication: LString('DEP < 50%, impossibilité de parler, FR > 25, FC > 110, SpO2 < 92%', 'PEF < 50%, unable to speak, RR > 25, HR > 110, SpO2 < 92%'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation de la sévérité', '1. Severity assessment'),
        content: LString('Identifier les critères de gravité.', 'Identify severity criteria.'),
        bulletPoints: [
          LString('DEP < 50% valeur théorique = AAG', 'PEF < 50% predicted = severe acute asthma'),
          LString('DEP < 33% ou inatteignable = asthme aigu très grave', 'PEF < 33% or unmeasurable = near-fatal asthma'),
          LString('Signes de lutte, cyanose, silence auscultatoire', 'Respiratory distress, cyanosis, silent chest'),
          LString('Troubles de conscience, bradycardie = arrêt imminent', 'Altered consciousness, bradycardia = imminent arrest'),
        ],
        warning: LString('Patient épuisé = alerte maximale, préparer intubation', 'Exhausted patient = maximum alert, prepare intubation'),
      ),
      ProtocolStep(
        title: LString('2. Oxygénothérapie et bronchodilatateurs', '2. Oxygen therapy and bronchodilators'),
        content: LString('Traitement de première ligne.', 'First-line treatment.'),
        bulletPoints: [
          LString('O2 pour SpO2 93-95%', 'O2 to target SpO2 93-95%'),
          LString('Salbutamol nébulisé 5 mg / 20 min x3 puis toutes les heures', 'Nebulized salbutamol 5 mg / 20 min x3 then hourly'),
          LString('ou Salbutamol aérosol-doseur 4-10 bouffées avec chambre', 'or Salbutamol MDI 4-10 puffs with spacer'),
          LString('Ipratropium 0.5 mg nébulisé (ajouté au salbutamol)', 'Ipratropium 0.5 mg nebulized (added to salbutamol)'),
        ],
        tip: LString('Nébulisation à l\'O2 6-8 L/min', 'Nebulization driven by O2 6-8 L/min'),
      ),
      ProtocolStep(
        title: LString('3. Corticothérapie', '3. Corticosteroids'),
        content: LString('Systémique précoce.', 'Early systemic administration.'),
        bulletPoints: [
          LString('Méthylprednisolone 1-2 mg/kg IV', 'Methylprednisolone 1-2 mg/kg IV'),
          LString('ou Prednisone 1 mg/kg PO si patient peut avaler', 'or Prednisone 1 mg/kg PO if patient can swallow'),
          LString('Effet en 4-6 heures', 'Effect in 4-6 hours'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Si échec ou asthme très grave', '4. If failure or near-fatal asthma'),
        content: LString('Escalade thérapeutique.', 'Therapeutic escalation.'),
        bulletPoints: [
          LString('Sulfate de magnésium 2g IV en 20 min', 'Magnesium sulfate 2g IV over 20 min'),
          LString('Salbutamol IV: 0.1-0.2 µg/kg/min IVSE', 'IV salbutamol: 0.1-0.2 µg/kg/min continuous infusion'),
          LString('VNI si coopérant (attention auto-PEP)', 'NIV if cooperative (watch for auto-PEEP)'),
          LString('Adrénaline 0.5 mg IM si anaphylaxie associée', 'Epinephrine 0.5 mg IM if associated anaphylaxis'),
        ],
        warning: LString('Salbutamol IV = surveillance scope continue (hypokaliémie, arythmies)', 'IV salbutamol = continuous monitoring (hypokalemia, arrhythmias)'),
      ),
      ProtocolStep(
        title: LString('5. Intubation si nécessaire', '5. Intubation if necessary'),
        content: LString('Indication: épuisement, trouble conscience, arrêt.', 'Indication: exhaustion, altered consciousness, arrest.'),
        bulletPoints: [
          LString('ISR avec kétamine (bronchodilatatrice)', 'RSI with ketamine (bronchodilatory)'),
          LString('Ventilation: FR basse (10-12), I/E 1:4-5', 'Ventilation: low RR (10-12), I:E 1:4-5'),
          LString('Tolérer hypercapnie permissive', 'Tolerate permissive hypercapnia'),
          LString('Attention au barotraumatisme', 'Watch for barotrauma'),
        ],
        warning: LString('L\'intubation peut précipiter l\'arrêt, préparer adrénaline', 'Intubation may precipitate arrest, prepare epinephrine'),
      ),
    ],
    keyPoints: LString('Bronchodilatateurs + O2 + corticoïdes précoces. Magnésium si sévère. Intubation = dernier recours.', 'Bronchodilators + O2 + early corticosteroids. Magnesium if severe. Intubation = last resort.'),
    source: LString('GINA 2023, SFMU', 'GINA 2023, SFMU'),
    sourceUrl: 'https://ginasthma.org',
    lastUpdated: 2023,
  ),

  // BPCO décompensée
  Protocol(
    id: 'bpco-decompensee',
    name: LString('Exacerbation BPCO', 'COPD Exacerbation'),
    category: ProtocolCategory.respiratory,
    description: LString('Décompensation aiguë de BPCO', 'Acute COPD decompensation'),
    indication: LString('Majoration dyspnée, volume et/ou purulence des expectorations', 'Worsening dyspnea, sputum volume and/or purulence'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation de la gravité', '1. Severity assessment'),
        content: LString('Stratifier le niveau de soins nécessaire.', 'Stratify the level of care needed.'),
        bulletPoints: [
          LString('Détresse respiratoire aiguë', 'Acute respiratory distress'),
          LString('Altération conscience, cyanose', 'Altered consciousness, cyanosis'),
          LString('pH < 7.35, PaCO2 > 45 mmHg', 'pH < 7.35, PaCO2 > 45 mmHg'),
          LString('SpO2 < 88% sous O2', 'SpO2 < 88% on O2'),
          LString('Comorbidités sévères', 'Severe comorbidities'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Oxygénothérapie contrôlée', '2. Controlled oxygen therapy'),
        content: LString('Objectif SpO2 88-92%.', 'Target SpO2 88-92%.'),
        bulletPoints: [
          LString('Commencer à 24-28% (lunettes 1-2 L/min)', 'Start at 24-28% (nasal cannula 1-2 L/min)'),
          LString('Titrer pour SpO2 88-92%', 'Titrate to SpO2 88-92%'),
          LString('Gazométrie si SpO2 < 92% ou signes gravité', 'ABG if SpO2 < 92% or severity signs'),
          LString('Éviter hyperoxie (risque hypercapnie)', 'Avoid hyperoxia (risk of hypercapnia)'),
        ],
        warning: LString('SpO2 cible plus basse que population générale', 'Target SpO2 lower than general population'),
      ),
      ProtocolStep(
        title: LString('3. Bronchodilatateurs', '3. Bronchodilators'),
        content: LString('Traitement systématique.', 'Systematic treatment.'),
        bulletPoints: [
          LString('Salbutamol 2.5-5 mg nébulisé / 20 min x3', 'Salbutamol 2.5-5 mg nebulized / 20 min x3'),
          LString('Ipratropium 0.5 mg ajouté aux nébulisations', 'Ipratropium 0.5 mg added to nebulizations'),
          LString('Puis espacement progressif selon réponse', 'Then gradually space out based on response'),
        ],
        tip: LString('Nébulisation à l\'air si possible (risque hypercapnie si O2)', 'Air-driven nebulization if possible (hypercapnia risk with O2)'),
      ),
      ProtocolStep(
        title: LString('4. Corticothérapie', '4. Corticosteroids'),
        content: LString('Cure courte systématique.', 'Systematic short course.'),
        bulletPoints: [
          LString('Prednisone 40 mg/j PO pendant 5 jours', 'Prednisone 40 mg/day PO for 5 days'),
          LString('ou équivalent IV si voie orale impossible', 'or IV equivalent if oral route impossible'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Antibiothérapie', '5. Antibiotics'),
        content: LString('Si critères d\'infection.', 'If infection criteria met.'),
        bulletPoints: [
          LString('Indication: purulence + augmentation volume ou dyspnée', 'Indication: purulence + increased volume or dyspnea'),
          LString('Amoxicilline-acide clavulanique 1g x3/j', 'Amoxicillin-clavulanate 1g TID'),
          LString('ou Pristinamycine si allergie', 'or Pristinamycin if allergic'),
          LString('Durée 5 jours', 'Duration 5 days'),
        ],
      ),
      ProtocolStep(
        title: LString('6. VNI', '6. NIV'),
        content: LString('Si acidose respiratoire.', 'If respiratory acidosis.'),
        bulletPoints: [
          LString('Indication: pH < 7.35 avec PaCO2 > 45 mmHg', 'Indication: pH < 7.35 with PaCO2 > 45 mmHg'),
          LString('BiPAP: IPAP 10-20, EPAP 4-8 cmH2O', 'BiPAP: IPAP 10-20, EPAP 4-8 cmH2O'),
          LString('Réévaluation gazométrie à H1-H2', 'Re-evaluate ABG at H1-H2'),
          LString('Réduction intubation et mortalité', 'Reduces intubation and mortality'),
        ],
        warning: LString('CI si coma, arrêt immine, vomissements actifs', 'CI if coma, imminent arrest, active vomiting'),
      ),
    ],
    keyPoints: LString('O2 contrôlé (88-92%) + bronchodilatateurs + corticoïdes. VNI si acidose respiratoire.', 'Controlled O2 (88-92%) + bronchodilators + corticosteroids. NIV if respiratory acidosis.'),
    source: LString('GOLD 2024, SPLF', 'GOLD 2024, SPLF'),
    sourceUrl: 'https://goldcopd.org',
    lastUpdated: 2024,
  ),

  // Pneumothorax
  Protocol(
    id: 'pneumothorax',
    name: LString('Pneumothorax', 'Pneumothorax'),
    category: ProtocolCategory.respiratory,
    description: LString('Prise en charge du pneumothorax spontané et traumatique', 'Management of spontaneous and traumatic pneumothorax'),
    indication: LString('Douleur thoracique brutale, dyspnée, asymétrie auscultatoire', 'Sudden chest pain, dyspnea, asymmetric breath sounds'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation clinique', '1. Clinical assessment'),
        content: LString('Identifier le type et la gravité.', 'Identify type and severity.'),
        bulletPoints: [
          LString('Primaire: patient jeune, pas de pathologie pulmonaire', 'Primary: young patient, no lung disease'),
          LString('Secondaire: BPCO, mucoviscidose, pathologie sous-jacente', 'Secondary: COPD, cystic fibrosis, underlying lung disease'),
          LString('Traumatique: contexte évocateur', 'Traumatic: suggestive context'),
          LString('Compressif: urgence vitale (déviation trachée, détresse)', 'Tension: life-threatening (tracheal deviation, distress)'),
        ],
        warning: LString('Pneumothorax compressif = exsufflation immédiate AVANT radio', 'Tension pneumothorax = immediate needle decompression BEFORE X-ray'),
      ),
      ProtocolStep(
        title: LString('2. Pneumothorax compressif', '2. Tension pneumothorax'),
        content: LString('Exsufflation à l\'aiguille en urgence.', 'Emergency needle decompression.'),
        bulletPoints: [
          LString('2ème espace intercostal, ligne médio-claviculaire', '2nd intercostal space, midclavicular line'),
          LString('Cathéter 14-16G, aiguille perpendiculaire', '14-16G catheter, perpendicular needle'),
          LString('Bruit de souffle = confirmation', 'Rush of air = confirmation'),
          LString('Puis drainage thoracique', 'Then chest tube insertion'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Pneumothorax primaire', '3. Primary pneumothorax'),
        content: LString('Stratégie selon taille et symptômes.', 'Strategy based on size and symptoms.'),
        bulletPoints: [
          LString('< 2 cm et asymptomatique: observation, contrôle radio', '< 2 cm and asymptomatic: observation, follow-up X-ray'),
          LString('> 2 cm ou symptomatique: exsufflation à l\'aiguille', '> 2 cm or symptomatic: needle aspiration'),
          LString('Si échec exsufflation: drainage thoracique', 'If aspiration fails: chest tube insertion'),
        ],
        tip: LString('Mesure à 2 cm du sommet sur la ligne médio-claviculaire', 'Measured at 2 cm from apex at midclavicular line'),
      ),
      ProtocolStep(
        title: LString('4. Pneumothorax secondaire', '4. Secondary pneumothorax'),
        content: LString('Drainage plus souvent nécessaire.', 'Drainage more often required.'),
        bulletPoints: [
          LString('Hospitalisation systématique', 'Systematic hospitalization'),
          LString('Drainage si > 1 cm ou symptomatique', 'Drainage if > 1 cm or symptomatic'),
          LString('Calibre drain adapté (20-24 Fr)', 'Appropriate drain size (20-24 Fr)'),
          LString('Aspiration -10 à -20 cmH2O si persistance', 'Suction -10 to -20 cmH2O if persistent'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Technique de drainage', '5. Chest drain technique'),
        content: LString('Triangle de sécurité.', 'Triangle of safety.'),
        bulletPoints: [
          LString('Zone: 4-5ème EIC, ligne axillaire moyenne', 'Site: 4th-5th ICS, mid-axillary line'),
          LString('Anesthésie locale jusqu\'à plèvre', 'Local anesthesia down to pleura'),
          LString('Incision, dissection mousse, pénétration digitale', 'Incision, blunt dissection, digital exploration'),
          LString('Drain dirigé vers apex', 'Drain directed toward apex'),
          LString('Fixation et connexion système aspiratif', 'Secure and connect to suction system'),
        ],
      ),
    ],
    keyPoints: LString('Compressif = exsufflation immédiate. Primaire: selon taille. Secondaire: drainage plus large.', 'Tension = immediate decompression. Primary: based on size. Secondary: lower threshold for drainage.'),
    source: LString('BTS Guidelines 2023', 'BTS Guidelines 2023'),
    sourceUrl: 'https://www.brit-thoracic.org.uk',
    lastUpdated: 2023,
  ),

  // Embolie pulmonaire
  Protocol(
    id: 'ep',
    name: LString('Embolie Pulmonaire', 'Pulmonary Embolism'),
    category: ProtocolCategory.respiratory,
    description: LString('Diagnostic et traitement de l\'embolie pulmonaire', 'Diagnosis and treatment of pulmonary embolism'),
    indication: LString('Dyspnée brutale, douleur thoracique, facteurs de risque thrombo-embolique', 'Sudden dyspnea, chest pain, thromboembolic risk factors'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation probabilité clinique', '1. Clinical probability assessment'),
        content: LString('Score de Wells ou Genève.', 'Wells or Geneva score.'),
        bulletPoints: [
          LString('Wells: ATCD TVP/EP, FC>100, immobilisation/chirurgie récente', 'Wells: prior DVT/PE, HR>100, recent immobilization/surgery'),
          LString('Hémoptysie, cancer, signes TVP', 'Hemoptysis, cancer, DVT signs'),
          LString('Probabilité faible/intermédiaire/forte', 'Low/intermediate/high probability'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Stratégie diagnostique', '2. Diagnostic strategy'),
        content: LString('Selon probabilité clinique.', 'Based on clinical probability.'),
        bulletPoints: [
          LString('Probabilité faible/intermédiaire: D-dimères d\'abord', 'Low/intermediate probability: D-dimer first'),
          LString('D-dimères négatifs (seuil ajusté âge): EP exclue', 'Negative D-dimer (age-adjusted threshold): PE excluded'),
          LString('D-dimères positifs ou proba forte: angioscanner', 'Positive D-dimer or high probability: CT pulmonary angiography'),
          LString('Si CI scanner: scintigraphie V/Q', 'If CT contraindicated: V/Q scan'),
        ],
        tip: LString('Seuil D-dimères ajusté: âge x 10 µg/L si > 50 ans', 'Age-adjusted D-dimer threshold: age x 10 µg/L if > 50 y/o'),
      ),
      ProtocolStep(
        title: LString('3. Évaluation gravité', '3. Severity assessment'),
        content: LString('Stratification pronostique.', 'Prognostic stratification.'),
        bulletPoints: [
          LString('Haut risque: instabilité HD (PAS < 90 ou chute > 40 mmHg)', 'High risk: hemodynamic instability (SBP < 90 or drop > 40 mmHg)'),
          LString('Risque intermédiaire: PESI ≥ III + dilatation VD + troponine +', 'Intermediate risk: PESI ≥ III + RV dilation + troponin +'),
          LString('Bas risque: PESI I-II', 'Low risk: PESI I-II'),
        ],
      ),
      ProtocolStep(
        title: LString('4. EP à haut risque (massive)', '4. High-risk (massive) PE'),
        content: LString('Traitement urgent.', 'Urgent treatment.'),
        bulletPoints: [
          LString('Anticoagulation: HNF bolus + IVSE', 'Anticoagulation: UFH bolus + continuous infusion'),
          LString('Thrombolyse: Alteplase 100 mg/2h ou 0.6 mg/kg/15 min si ACR', 'Thrombolysis: Alteplase 100 mg/2h or 0.6 mg/kg/15 min if cardiac arrest'),
          LString('Support hémodynamique: remplissage prudent, noradrénaline', 'Hemodynamic support: cautious fluids, norepinephrine'),
          LString('Embolectomie/ECMO si CI thrombolyse ou échec', 'Embolectomy/ECMO if thrombolysis CI or failure'),
        ],
        warning: LString('Remplissage limité < 500 mL (éviter surcharge VD)', 'Fluid loading limited < 500 mL (avoid RV overload)'),
      ),
      ProtocolStep(
        title: LString('5. EP non à haut risque', '5. Non-high-risk PE'),
        content: LString('Anticoagulation standard.', 'Standard anticoagulation.'),
        bulletPoints: [
          LString('AOD en première intention (rivaroxaban, apixaban)', 'DOACs as first-line (rivaroxaban, apixaban)'),
          LString('ou HBPM puis AVK', 'or LMWH then VKA'),
          LString('Durée: 3 mois si facteur déclenchant transitoire', 'Duration: 3 months if transient precipitant'),
          LString('≥ 6 mois si idiopathique ou cancer', '≥ 6 months if unprovoked or cancer'),
        ],
      ),
    ],
    keyPoints: LString('Probabilité clinique → D-dimères ou scanner direct. Haut risque = thrombolyse. AOD si stable.', 'Clinical probability → D-dimer or direct CT. High risk = thrombolysis. DOACs if stable.'),
    source: LString('ESC Guidelines 2019 - Embolie Pulmonaire', 'ESC Guidelines 2019 - Pulmonary Embolism'),
    sourceUrl: 'https://www.escardio.org',
    lastUpdated: 2019,
  ),

  // Détresse respiratoire aiguë
  Protocol(
    id: 'dra',
    name: LString('Détresse Respiratoire Aiguë', 'Acute Respiratory Distress'),
    category: ProtocolCategory.respiratory,
    description: LString('Approche diagnostique et thérapeutique de la détresse respiratoire', 'Diagnostic and therapeutic approach to respiratory distress'),
    indication: LString('FR > 25/min, signes de lutte, SpO2 < 92%, cyanose', 'RR > 25/min, signs of respiratory distress, SpO2 < 92%, cyanosis'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation immédiate', '1. Immediate assessment'),
        content: LString('ABC et stabilisation.', 'ABC and stabilization.'),
        bulletPoints: [
          LString('Position adaptée (assis si OAP, décubitus si trauma)', 'Appropriate position (upright if APE, supine if trauma)'),
          LString('Oxygénothérapie haut débit initial', 'Initial high-flow oxygen therapy'),
          LString('Voie veineuse périphérique', 'Peripheral IV access'),
          LString('Monitoring: SpO2, ECG, PA', 'Monitoring: SpO2, ECG, BP'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Orientation diagnostique', '2. Diagnostic workup'),
        content: LString('Examen clinique ciblé.', 'Focused clinical examination.'),
        bulletPoints: [
          LString('Stridor inspiratoire: obstruction haute', 'Inspiratory stridor: upper airway obstruction'),
          LString('Wheezing: bronchospasme (asthme, BPCO)', 'Wheezing: bronchospasm (asthma, COPD)'),
          LString('Crépitants bilatéraux: OAP, pneumopathie, SDRA', 'Bilateral crackles: APE, pneumonia, ARDS'),
          LString('Asymétrie auscultatoire: pneumothorax, épanchement', 'Asymmetric breath sounds: pneumothorax, effusion'),
          LString('Signes de TVP: embolie pulmonaire', 'DVT signs: pulmonary embolism'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Examens complémentaires', '3. Investigations'),
        content: LString('Bilan adapté au contexte.', 'Context-appropriate workup.'),
        bulletPoints: [
          LString('Gazométrie artérielle', 'Arterial blood gas'),
          LString('Radio thorax', 'Chest X-ray'),
          LString('ECG, troponine, BNP si cardiaque suspecté', 'ECG, troponin, BNP if cardiac cause suspected'),
          LString('D-dimères si EP suspectée', 'D-dimer if PE suspected'),
          LString('Angioscanner si EP probable', 'CT angiography if PE likely'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Oxygénothérapie avancée', '4. Advanced oxygen therapy'),
        content: LString('Escalade selon réponse.', 'Escalate based on response.'),
        bulletPoints: [
          LString('Lunettes/masque: objectif SpO2 selon pathologie', 'Cannula/mask: SpO2 target based on condition'),
          LString('Optiflow (HFNC): 30-60 L/min, FiO2 ajustée', 'HFNC: 30-60 L/min, adjusted FiO2'),
          LString('VNI: CPAP ou BiPAP selon indication', 'NIV: CPAP or BiPAP based on indication'),
          LString('Intubation si échec ou contre-indication VNI', 'Intubation if NIV failure or contraindication'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Critères d\'intubation', '5. Intubation criteria'),
        content: LString('Ne pas retarder si indication claire.', 'Do not delay if indication is clear.'),
        bulletPoints: [
          LString('Arrêt respiratoire ou imminence', 'Respiratory arrest or imminent'),
          LString('Trouble de conscience (GCS < 8)', 'Altered consciousness (GCS < 8)'),
          LString('Épuisement respiratoire', 'Respiratory exhaustion'),
          LString('Échec VNI avec aggravation', 'NIV failure with worsening'),
          LString('Instabilité hémodynamique sévère', 'Severe hemodynamic instability'),
        ],
      ),
    ],
    keyPoints: LString('Stabiliser d\'abord, diagnostiquer ensuite. Adapter l\'O2 à la pathologie. Ne pas retarder l\'IOT.', 'Stabilize first, diagnose second. Tailor O2 to condition. Do not delay intubation.'),
    source: LString('SFMU - Détresse respiratoire', 'SFMU - Respiratory Distress'),
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
    name: LString('AVC Ischémique', 'Ischemic Stroke'),
    category: ProtocolCategory.neurology,
    description: LString('Accident vasculaire cérébral ischémique - thrombolyse et thrombectomie', 'Ischemic stroke - thrombolysis and thrombectomy'),
    indication: LString('Déficit neurologique focal brutal évocateur d\'AVC', 'Sudden focal neurological deficit suggestive of stroke'),
    contraindication: LString('Voir CI thrombolyse', 'See thrombolysis contraindications'),
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance et alerte', '1. Recognition and alert'),
        content: LString('Identifier l\'AVC et noter l\'heure de début.', 'Identify stroke and note time of onset.'),
        bulletPoints: [
          LString('FAST: Face, Arm, Speech, Time', 'FAST: Face, Arm, Speech, Time'),
          LString('Heure du dernier moment vu normal (DLMN)', 'Last known well time (LKW)'),
          LString('Alerte UNV (Unité Neuro-Vasculaire)', 'Alert stroke unit'),
          LString('Glycémie capillaire immédiate', 'Immediate capillary glucose'),
        ],
        warning: LString('Chaque minute perdue = 1.9 million neurones détruits', 'Every minute lost = 1.9 million neurons destroyed'),
      ),
      ProtocolStep(
        title: LString('2. Imagerie cérébrale', '2. Brain imaging'),
        content: LString('Scanner ou IRM en urgence.', 'Urgent CT or MRI.'),
        bulletPoints: [
          LString('Scanner sans injection: éliminer hémorragie', 'Non-contrast CT: rule out hemorrhage'),
          LString('IRM si disponible rapidement (diffusion)', 'MRI if rapidly available (diffusion)'),
          LString('Angioscanner/ARM si thrombectomie envisagée', 'CTA/MRA if thrombectomy considered'),
          LString('Objectif: porte-imagerie < 25 min', 'Goal: door-to-imaging < 25 min'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Évaluation clinique', '3. Clinical assessment'),
        content: LString('Score NIHSS.', 'NIHSS score.'),
        bulletPoints: [
          LString('NIHSS: quantifier le déficit (0-42)', 'NIHSS: quantify deficit (0-42)'),
          LString('NIHSS ≥ 6: occlusion proximale probable', 'NIHSS ≥ 6: likely proximal occlusion'),
          LString('Vérifier contre-indications thrombolyse', 'Check thrombolysis contraindications'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Thrombolyse IV', '4. IV Thrombolysis'),
        content: LString('Si éligible dans les délais.', 'If eligible within time window.'),
        bulletPoints: [
          LString('Alteplase 0.9 mg/kg (max 90 mg)', 'Alteplase 0.9 mg/kg (max 90 mg)'),
          LString('10% en bolus, 90% en 1h', '10% bolus, 90% over 1h'),
          LString('Délai < 4h30 du DLMN', 'Window < 4.5h from LKW'),
          LString('PA < 185/110 avant et < 180/105 après', 'BP < 185/110 before and < 180/105 after'),
          LString('Surveillance neurologique rapprochée', 'Close neurological monitoring'),
        ],
        warning: LString('CI absolues: hémorragie cérébrale, chirurgie récente, saignement actif', 'Absolute CI: cerebral hemorrhage, recent surgery, active bleeding'),
      ),
      ProtocolStep(
        title: LString('5. Thrombectomie mécanique', '5. Mechanical thrombectomy'),
        content: LString('Si occlusion proximale.', 'If proximal occlusion.'),
        bulletPoints: [
          LString('Indication: occlusion artère proximale (carotide, M1, basilaire)', 'Indication: proximal artery occlusion (carotid, M1, basilar)'),
          LString('Délai jusqu\'à 6h (voire 24h si mismatch)', 'Window up to 6h (up to 24h if mismatch)'),
          LString('En complément ou alternative à thrombolyse', 'As complement or alternative to thrombolysis'),
          LString('Transfert centre de neuroradiologie interventionnelle', 'Transfer to interventional neuroradiology center'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Soins de support', '6. Supportive care'),
        content: LString('Mesures générales.', 'General measures.'),
        bulletPoints: [
          LString('Position tête à 30° si HTIC, sinon à plat', 'Head of bed 30° if raised ICP, otherwise flat'),
          LString('O2 si SpO2 < 94%', 'O2 if SpO2 < 94%'),
          LString('Contrôle glycémique (éviter hypo/hyperglycémie)', 'Glycemic control (avoid hypo/hyperglycemia)'),
          LString('Antiagrégant: aspirine 160-300 mg après imagerie', 'Antiplatelet: aspirin 160-300 mg after imaging'),
          LString('Prévention complications: TVP, pneumopathie', 'Complication prevention: DVT, pneumonia'),
        ],
      ),
    ],
    keyPoints: LString('Time is brain. DLMN crucial. Thrombolyse < 4h30. Thrombectomie si occlusion proximale.', 'Time is brain. LKW crucial. Thrombolysis < 4.5h. Thrombectomy if proximal occlusion.'),
    source: LString('ESO Guidelines 2021, HAS', 'ESO Guidelines 2021, HAS'),
    sourceUrl: 'https://eso-stroke.org',
    lastUpdated: 2021,
  ),

  // AVC hémorragique
  Protocol(
    id: 'avc-hemorragique',
    name: LString('AVC Hémorragique', 'Hemorrhagic Stroke'),
    category: ProtocolCategory.neurology,
    description: LString('Hémorragie intracérébrale spontanée', 'Spontaneous intracerebral hemorrhage'),
    indication: LString('Déficit neurologique brutal avec hémorragie au scanner', 'Sudden neurological deficit with hemorrhage on CT'),
    steps: [
      ProtocolStep(
        title: LString('1. Diagnostic', '1. Diagnosis'),
        content: LString('Confirmer l\'hémorragie et évaluer la gravité.', 'Confirm hemorrhage and assess severity.'),
        bulletPoints: [
          LString('Scanner cérébral sans injection', 'Non-contrast brain CT'),
          LString('Volume hématome (formule ABC/2)', 'Hematoma volume (ABC/2 formula)'),
          LString('Score ICH pour pronostic', 'ICH score for prognosis'),
          LString('Rechercher engagement', 'Check for herniation'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Contrôle de la pression artérielle', '2. Blood pressure control'),
        content: LString('Objectif tensionnel adapté.', 'Adapted blood pressure target.'),
        bulletPoints: [
          LString('Si PAS 150-220: cible < 140 mmHg (sûr)', 'If SBP 150-220: target < 140 mmHg (safe)'),
          LString('Si PAS > 220: réduction progressive', 'If SBP > 220: gradual reduction'),
          LString('Nicardipine IVSE ou Urapidil', 'Nicardipine infusion or Urapidil'),
          LString('Éviter chute brutale de PA', 'Avoid abrupt BP drop'),
        ],
        tip: LString('Réduction PA limite expansion hématome', 'BP reduction limits hematoma expansion'),
      ),
      ProtocolStep(
        title: LString('3. Réversion anticoagulation', '3. Anticoagulation reversal'),
        content: LString('Si patient sous anticoagulant.', 'If patient on anticoagulant.'),
        bulletPoints: [
          LString('AVK: Vitamine K 10 mg IV + CCP (25-50 UI/kg)', 'VKA: Vitamin K 10 mg IV + PCC (25-50 IU/kg)'),
          LString('Dabigatran: Idarucizumab 5g IV', 'Dabigatran: Idarucizumab 5g IV'),
          LString('Anti-Xa (rivaroxaban, apixaban): Andexanet si disponible, sinon CCP', 'Anti-Xa (rivaroxaban, apixaban): Andexanet if available, otherwise PCC'),
          LString('Héparine: Protamine', 'Heparin: Protamine'),
          LString('Objectif INR < 1.3 en < 4h', 'Target INR < 1.3 within < 4h'),
        ],
        warning: LString('Urgence vitale - reverser sans attendre les résultats', 'Life-threatening emergency - reverse without waiting for results'),
      ),
      ProtocolStep(
        title: LString('4. Prise en charge HTIC', '4. Raised ICP management'),
        content: LString('Si signes d\'hypertension intracrânienne.', 'If signs of intracranial hypertension.'),
        bulletPoints: [
          LString('Tête à 30°', 'Head of bed 30°'),
          LString('Mannitol 20% 0.5-1 g/kg ou SSH 7.5%', 'Mannitol 20% 0.5-1 g/kg or HTS 7.5%'),
          LString('Intubation si GCS < 8', 'Intubation if GCS < 8'),
          LString('Objectif PPC > 60 mmHg', 'Target CPP > 60 mmHg'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Indication chirurgicale', '5. Surgical indication'),
        content: LString('Discussion neurochirurgicale.', 'Neurosurgical consultation.'),
        bulletPoints: [
          LString('Hématome cérébelleux > 3 cm avec dégradation', 'Cerebellar hematoma > 3 cm with deterioration'),
          LString('Hydrocéphalie (DVE)', 'Hydrocephalus (EVD)'),
          LString('Hématome lobaire > 30 mL près surface', 'Lobar hematoma > 30 mL near surface'),
          LString('Évacuation rarement bénéfique pour hématomes profonds', 'Evacuation rarely beneficial for deep hematomas'),
        ],
      ),
    ],
    keyPoints: LString('Contrôle PA précoce. Reverser anticoagulation immédiatement. Avis neurochirurgical.', 'Early BP control. Reverse anticoagulation immediately. Neurosurgical consultation.'),
    source: LString('AHA/ASA Guidelines 2022', 'AHA/ASA Guidelines 2022'),
    lastUpdated: 2022,
  ),

  // État de mal épileptique
  Protocol(
    id: 'eme',
    name: LString('État de Mal Épileptique', 'Status Epilepticus'),
    category: ProtocolCategory.neurology,
    description: LString('Crise convulsive prolongée ou répétée sans récupération', 'Prolonged or repeated seizures without recovery'),
    indication: LString('Crise > 5 min ou crises répétées sans retour conscience', 'Seizure > 5 min or repeated seizures without return of consciousness'),
    steps: [
      ProtocolStep(
        title: LString('1. Phase initiale (0-5 min)', '1. Initial phase (0-5 min)'),
        content: LString('Protection et évaluation.', 'Protection and assessment.'),
        bulletPoints: [
          LString('Protection: retirer obstacles, PLS si possible', 'Protection: remove hazards, recovery position if possible'),
          LString('Chronométrer la crise', 'Time the seizure'),
          LString('Glycémie capillaire', 'Capillary glucose'),
          LString('Voie veineuse périphérique', 'Peripheral IV access'),
          LString('O2 si SpO2 < 94%', 'O2 if SpO2 < 94%'),
        ],
        warning: LString('Ne rien mettre dans la bouche', 'Do not place anything in the mouth'),
      ),
      ProtocolStep(
        title: LString('2. Phase précoce (5-20 min)', '2. Early phase (5-20 min)'),
        content: LString('Benzodiazépines.', 'Benzodiazepines.'),
        bulletPoints: [
          LString('Clonazépam 1 mg IV (0.015 mg/kg)', 'Clonazepam 1 mg IV (0.015 mg/kg)'),
          LString('ou Diazépam 10 mg IV ou IR (0.2-0.3 mg/kg)', 'or Diazepam 10 mg IV or PR (0.2-0.3 mg/kg)'),
          LString('ou Midazolam 10 mg IM si pas d\'accès IV', 'or Midazolam 10 mg IM if no IV access'),
          LString('Répéter une fois à 5 min si échec', 'Repeat once at 5 min if failed'),
        ],
        tip: LString('Midazolam IM aussi efficace que diazépam IV', 'IM midazolam as effective as IV diazepam'),
      ),
      ProtocolStep(
        title: LString('3. Phase établie (20-40 min)', '3. Established phase (20-40 min)'),
        content: LString('Antiépileptiques de 2ème ligne.', 'Second-line antiepileptics.'),
        bulletPoints: [
          LString('Levetiracetam 60 mg/kg IV (max 4500 mg) en 10-15 min', 'Levetiracetam 60 mg/kg IV (max 4500 mg) over 10-15 min'),
          LString('ou Valproate 40 mg/kg IV (max 3000 mg) en 10 min', 'or Valproate 40 mg/kg IV (max 3000 mg) over 10 min'),
          LString('ou Fosphénytoïne 20 mg EP/kg IV en 10-15 min', 'or Fosphenytoin 20 mg PE/kg IV over 10-15 min'),
          LString('CI valproate: hépatopathie, grossesse', 'CI valproate: liver disease, pregnancy'),
          LString('CI fosphénytoïne: troubles conduction', 'CI fosphenytoin: conduction disorders'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Phase réfractaire (> 40 min)', '4. Refractory phase (> 40 min)'),
        content: LString('Anesthésie générale.', 'General anesthesia.'),
        bulletPoints: [
          LString('Intubation et ventilation mécanique', 'Intubation and mechanical ventilation'),
          LString('Thiopental: bolus 2-3 mg/kg puis 3-5 mg/kg/h', 'Thiopental: 2-3 mg/kg bolus then 3-5 mg/kg/h'),
          LString('ou Midazolam: bolus 0.2 mg/kg puis 0.1-0.4 mg/kg/h', 'or Midazolam: 0.2 mg/kg bolus then 0.1-0.4 mg/kg/h'),
          LString('ou Propofol: bolus 2 mg/kg puis 5-10 mg/kg/h', 'or Propofol: 2 mg/kg bolus then 5-10 mg/kg/h'),
          LString('Monitoring EEG continu', 'Continuous EEG monitoring'),
        ],
        warning: LString('Propofol: risque syndrome de perfusion aux lipides', 'Propofol: risk of propofol infusion syndrome'),
      ),
      ProtocolStep(
        title: LString('5. Recherche étiologique', '5. Etiological workup'),
        content: LString('Identifier et traiter la cause.', 'Identify and treat the cause.'),
        bulletPoints: [
          LString('Sevrage/intoxication alcool, benzodiazépines', 'Alcohol/benzodiazepine withdrawal or intoxication'),
          LString('Hypoglycémie (→ G30%)', 'Hypoglycemia (→ D30%)'),
          LString('Hyponatrémie (→ correction prudente)', 'Hyponatremia (→ cautious correction)'),
          LString('Infection (→ PL si suspicion)', 'Infection (→ LP if suspected)'),
          LString('AVC, tumeur, trauma (→ imagerie)', 'Stroke, tumor, trauma (→ imaging)'),
        ],
      ),
    ],
    keyPoints: LString('Traiter tôt: BZD → Antiépileptique 2ème ligne → Anesthésie si réfractaire. Chercher cause.', 'Treat early: BZD → 2nd-line AED → Anesthesia if refractory. Search for cause.'),
    source: LString('SFMU 2018, Recommandations formalisées d\'experts', 'SFMU 2018, Formal Expert Recommendations'),
    lastUpdated: 2018,
  ),

  // Coma
  Protocol(
    id: 'coma',
    name: LString('Coma - Évaluation et PEC', 'Coma - Assessment and Management'),
    category: ProtocolCategory.neurology,
    description: LString('Approche du patient comateux aux urgences', 'Approach to the comatose patient in the ED'),
    indication: LString('Altération de conscience avec GCS < 9', 'Altered consciousness with GCS < 9'),
    steps: [
      ProtocolStep(
        title: LString('1. Stabilisation initiale', '1. Initial stabilization'),
        content: LString('ABC en priorité.', 'ABC first.'),
        bulletPoints: [
          LString('Protection voies aériennes: PLS, aspiration, Guedel', 'Airway protection: recovery position, suction, OPA'),
          LString('Intubation si GCS ≤ 8 ou réflexes abolis', 'Intubation if GCS ≤ 8 or absent reflexes'),
          LString('Oxygénation', 'Oxygenation'),
          LString('Accès vasculaire, monitoring', 'Vascular access, monitoring'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Évaluation neurologique', '2. Neurological assessment'),
        content: LString('Examen ciblé.', 'Focused examination.'),
        bulletPoints: [
          LString('Score de Glasgow: E + V + M', 'Glasgow Coma Scale: E + V + M'),
          LString('Pupilles: taille, réactivité, anisocorie', 'Pupils: size, reactivity, anisocoria'),
          LString('Réflexes du tronc: cornéen, oculocéphalique', 'Brainstem reflexes: corneal, oculocephalic'),
          LString('Réponse motrice: localisation, décortication, décérébration', 'Motor response: localization, decorticate, decerebrate'),
          LString('Signes de latéralisation', 'Lateralizing signs'),
        ],
        warning: LString('Anisocorie + coma = engagement jusqu\'à preuve du contraire', 'Anisocoria + coma = herniation until proven otherwise'),
      ),
      ProtocolStep(
        title: LString('3. Causes métaboliques urgentes', '3. Urgent metabolic causes'),
        content: LString('À éliminer immédiatement.', 'Rule out immediately.'),
        bulletPoints: [
          LString('Glycémie capillaire → si hypo: G30% 50 mL', 'Capillary glucose → if low: D30% 50 mL'),
          LString('Si éthylisme/dénutrition: Thiamine 500 mg IV AVANT glucose', 'If alcoholism/malnutrition: Thiamine 500 mg IV BEFORE glucose'),
          LString('Si suspicion opioïdes: Naloxone 0.4 mg IV (répétable)', 'If opioid suspected: Naloxone 0.4 mg IV (repeatable)'),
          LString('Si suspicion BZD: Flumazénil 0.2 mg (CI si épilepsie)', 'If BZD suspected: Flumazenil 0.2 mg (CI if epilepsy)'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Orientation diagnostique', '4. Diagnostic workup'),
        content: LString('Examens selon contexte.', 'Investigations based on context.'),
        bulletPoints: [
          LString('Scanner cérébral sans injection (hémorragie, AVC, HTIC)', 'Non-contrast brain CT (hemorrhage, stroke, raised ICP)'),
          LString('Biologie: glycémie, iono, calcium, ammoniémie, toxiques', 'Labs: glucose, electrolytes, calcium, ammonia, toxicology'),
          LString('PL si fièvre et scanner normal', 'LP if fever and normal CT'),
          LString('EEG si suspicion état de mal non convulsif', 'EEG if non-convulsive status suspected'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Étiologies principales', '5. Main etiologies'),
        content: LString('Causes à évoquer.', 'Causes to consider.'),
        bulletPoints: [
          LString('Traumatique: hémorragie, contusion', 'Traumatic: hemorrhage, contusion'),
          LString('Vasculaire: AVC, hémorragie méningée', 'Vascular: stroke, subarachnoid hemorrhage'),
          LString('Infectieux: méningite, encéphalite', 'Infectious: meningitis, encephalitis'),
          LString('Métabolique: hypo/hyperglycémie, dysnatrémie', 'Metabolic: hypo/hyperglycemia, dysnatremia'),
          LString('Toxique: intoxication, sevrage', 'Toxic: intoxication, withdrawal'),
          LString('Épileptique: post-critique, état de mal', 'Epileptic: postictal, status epilepticus'),
        ],
      ),
    ],
    keyPoints: LString('ABC d\'abord. Glycémie + naloxone + thiamine si doute. Scanner précoce. Traiter la cause.', 'ABC first. Glucose + naloxone + thiamine if uncertain. Early CT. Treat the cause.'),
    source: LString('SFMU', 'SFMU'),
    lastUpdated: 2020,
  ),

  // Méningite
  Protocol(
    id: 'meningite',
    name: LString('Méningite Bactérienne', 'Bacterial Meningitis'),
    category: ProtocolCategory.neurology,
    description: LString('Suspicion et prise en charge de méningite bactérienne', 'Suspected bacterial meningitis management'),
    indication: LString('Syndrome méningé fébrile: céphalées, raideur de nuque, fièvre', 'Febrile meningeal syndrome: headache, neck stiffness, fever'),
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Recognition'),
        content: LString('Signes évocateurs.', 'Suggestive signs.'),
        bulletPoints: [
          LString('Triade classique: fièvre, céphalées, raideur de nuque', 'Classic triad: fever, headache, neck stiffness'),
          LString('Troubles conscience, confusion', 'Altered consciousness, confusion'),
          LString('Photophobie, vomissements', 'Photophobia, vomiting'),
          LString('Purpura → évoquer méningocoque', 'Purpura → suspect meningococcus'),
        ],
        warning: LString('Purpura fébrile = antibiothérapie IMMÉDIATE avant tout', 'Febrile purpura = IMMEDIATE antibiotics before anything'),
      ),
      ProtocolStep(
        title: LString('2. Purpura fulminans', '2. Purpura fulminans'),
        content: LString('Urgence absolue.', 'Absolute emergency.'),
        bulletPoints: [
          LString('Ceftriaxone 2g IV/IM IMMÉDIATEMENT (même préhospitalier)', 'Ceftriaxone 2g IV/IM IMMEDIATELY (even prehospital)'),
          LString('Remplissage vasculaire', 'Fluid resuscitation'),
          LString('Puis suite de la prise en charge', 'Then continue management'),
          LString('Ne pas attendre les examens', 'Do not wait for test results'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Imagerie avant PL', '3. Imaging before LP'),
        content: LString('Indications du scanner avant PL.', 'Indications for CT before LP.'),
        bulletPoints: [
          LString('Signes de focalisation neurologique', 'Focal neurological signs'),
          LString('Troubles de conscience (GCS < 11)', 'Altered consciousness (GCS < 11)'),
          LString('Crises comitiales récentes', 'Recent seizures'),
          LString('Immunodépression sévère', 'Severe immunosuppression'),
          LString('Œdème papillaire', 'Papilledema'),
        ],
        tip: LString('Si indication scanner: ATB avant scanner, PL après si normal', 'If CT indicated: antibiotics before CT, LP after if normal'),
      ),
      ProtocolStep(
        title: LString('4. Ponction lombaire', '4. Lumbar puncture'),
        content: LString('Analyse du LCR.', 'CSF analysis.'),
        bulletPoints: [
          LString('Aspect macroscopique: trouble = bactérienne probable', 'Gross appearance: turbid = likely bacterial'),
          LString('Biochimie: protéinorachie, glycorachie (vs glycémie)', 'Biochemistry: protein, glucose (vs serum glucose)'),
          LString('Cytologie: pléiocytose à PNN', 'Cytology: neutrophilic pleocytosis'),
          LString('Bactériologie: direct, culture, PCR', 'Microbiology: gram stain, culture, PCR'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Antibiothérapie probabiliste', '5. Empiric antibiotic therapy'),
        content: LString('Sans attendre résultats si suspicion forte.', 'Without waiting for results if strong suspicion.'),
        bulletPoints: [
          LString('Adulte < 50 ans: Ceftriaxone 2g x2/j', 'Adult < 50 y/o: Ceftriaxone 2g BID'),
          LString('Adulte > 50 ans ou ID: Ceftriaxone 2g x2 + Amoxicilline 2g x6', 'Adult > 50 y/o or immunocompromised: Ceftriaxone 2g BID + Amoxicillin 2g q4h'),
          LString('Nourrisson: Ceftriaxone 100 mg/kg/j', 'Infant: Ceftriaxone 100 mg/kg/day'),
          LString('Si allergie vraie: Méropénème', 'If true allergy: Meropenem'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Dexaméthasone', '6. Dexamethasone'),
        content: LString('Corticothérapie adjuvante.', 'Adjunctive corticosteroid therapy.'),
        bulletPoints: [
          LString('Dexaméthasone 10 mg x4/j pendant 4 jours', 'Dexamethasone 10 mg QID for 4 days'),
          LString('Débuter AVANT ou avec la 1ère dose ATB', 'Start BEFORE or with first antibiotic dose'),
          LString('Réduit mortalité/séquelles (surtout pneumocoque)', 'Reduces mortality/sequelae (especially pneumococcal)'),
        ],
      ),
    ],
    keyPoints: LString('Purpura = ATB immédiat. Dexaméthasone + ATB sans retard. PL après scanner si indiqué.', 'Purpura = immediate antibiotics. Dexamethasone + antibiotics without delay. LP after CT if indicated.'),
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
    name: LString('Polytraumatisé', 'Polytrauma Patient'),
    category: ProtocolCategory.trauma,
    description: LString('Prise en charge initiale du patient polytraumatisé', 'Initial management of the polytrauma patient'),
    indication: LString('Traumatisme violent avec atteinte de plusieurs régions corporelles', 'Violent trauma with multiple body region involvement'),
    steps: [
      ProtocolStep(
        title: LString('1. Préhospitalier - SAFE', '1. Prehospital - SAFE'),
        content: LString('Sécurité et conditionnement.', 'Safety and packaging.'),
        bulletPoints: [
          LString('Sécurité: scène sécurisée, protection équipe', 'Safety: secure scene, team protection'),
          LString('Alerter: renfort, trauma center', 'Alert: backup, trauma center'),
          LString('Free: désincarcération', 'Free: extrication'),
          LString('Evaluate: bilan lésionnel rapide', 'Evaluate: rapid injury assessment'),
        ],
      ),
      ProtocolStep(
        title: LString('2. ABCDE', '2. ABCDE'),
        content: LString('Évaluation systématique.', 'Systematic assessment.'),
        bulletPoints: [
          LString('A: Airway + protection rachis cervical', 'A: Airway + cervical spine protection'),
          LString('B: Breathing (pneumothorax, volet)', 'B: Breathing (pneumothorax, flail chest)'),
          LString('C: Circulation (hémorragie, remplissage)', 'C: Circulation (hemorrhage, fluid resuscitation)'),
          LString('D: Disability (GCS, pupilles)', 'D: Disability (GCS, pupils)'),
          LString('E: Exposure (hypothermie)', 'E: Exposure (hypothermia)'),
        ],
        warning: LString('Immobilisation rachis cervical systématique jusqu\'à évaluation', 'Systematic cervical spine immobilization until cleared'),
      ),
      ProtocolStep(
        title: LString('3. Contrôle hémorragique', '3. Hemorrhage control'),
        content: LString('Hémorragie = priorité.', 'Hemorrhage = priority.'),
        bulletPoints: [
          LString('Compression directe', 'Direct compression'),
          LString('Garrot si membre et hémorragie non contrôlable', 'Tourniquet if limb and uncontrollable bleeding'),
          LString('Packing si jonctionnel', 'Packing if junctional'),
          LString('Acide tranexamique 1g IV < 3h du trauma (puis 1g/8h)', 'Tranexamic acid 1g IV < 3h from trauma (then 1g/8h)'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Réanimation hémodynamique', '4. Hemodynamic resuscitation'),
        content: LString('Damage control resuscitation.', 'Damage control resuscitation.'),
        bulletPoints: [
          LString('Objectif PAS 80-90 mmHg (sans TC)', 'Target SBP 80-90 mmHg (without TBI)'),
          LString('Objectif PAS > 100 mmHg si TC associé', 'Target SBP > 100 mmHg if associated TBI'),
          LString('Remplissage: cristalloïdes limités, sang précoce', 'Fluids: limited crystalloids, early blood'),
          LString('Ratio CGR:PFC:Plaquettes = 1:1:1', 'Ratio pRBC:FFP:Platelets = 1:1:1'),
          LString('Éviter hypothermie, acidose, coagulopathie', 'Avoid hypothermia, acidosis, coagulopathy'),
        ],
        tip: LString('Triade létale = hypothermie + acidose + coagulopathie', 'Lethal triad = hypothermia + acidosis + coagulopathy'),
      ),
      ProtocolStep(
        title: LString('5. Intubation et voies aériennes', '5. Intubation and airway'),
        content: LString('Indications précoces.', 'Early indications.'),
        bulletPoints: [
          LString('GCS ≤ 8', 'GCS ≤ 8'),
          LString('Détresse respiratoire, SpO2 < 90%', 'Respiratory distress, SpO2 < 90%'),
          LString('Trauma facial sévère', 'Severe facial trauma'),
          LString('ISR avec maintien en ligne du rachis', 'RSI with in-line cervical stabilization'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Orientation et bilan', '6. Disposition and workup'),
        content: LString('Trauma center et imagerie.', 'Trauma center and imaging.'),
        bulletPoints: [
          LString('Alerte trauma center', 'Trauma center alert'),
          LString('Body-scanner si stable', 'Whole-body CT if stable'),
          LString('Échographie FAST si instable', 'FAST ultrasound if unstable'),
          LString('Bloc opératoire direct si instabilité majeure', 'Direct to OR if major instability'),
        ],
      ),
    ],
    keyPoints: LString('ABCDE. Contrôle hémorragie. Damage control. Acide tranexamique précoce. Éviter triade létale.', 'ABCDE. Hemorrhage control. Damage control. Early tranexamic acid. Avoid lethal triad.'),
    source: LString('SFMU, ATLS, Traumatologie Grave 2019', 'SFMU, ATLS, Traumatologie Grave 2019'),
    lastUpdated: 2019,
  ),

  // TC grave
  Protocol(
    id: 'tc-grave',
    name: LString('Traumatisme Crânien Grave', 'Severe Traumatic Brain Injury'),
    category: ProtocolCategory.trauma,
    description: LString('TC avec GCS ≤ 8 après réanimation', 'TBI with GCS ≤ 8 after resuscitation'),
    indication: LString('Traumatisme crânien avec GCS ≤ 8', 'Traumatic brain injury with GCS ≤ 8'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation initiale', '1. Initial assessment'),
        content: LString('Après stabilisation ABCDE.', 'After ABCDE stabilization.'),
        bulletPoints: [
          LString('GCS après correction hypoxie/hypotension', 'GCS after correcting hypoxia/hypotension'),
          LString('Pupilles: anisocorie = engagement', 'Pupils: anisocoria = herniation'),
          LString('Signes de focalisation', 'Focal neurological signs'),
          LString('Mécanisme du trauma', 'Mechanism of injury'),
        ],
        warning: LString('Toute anisocorie = engagement présumé → osmothérapie', 'Any anisocoria = presumed herniation → osmotherapy'),
      ),
      ProtocolStep(
        title: LString('2. Objectifs hémodynamiques', '2. Hemodynamic targets'),
        content: LString('Éviter agressions secondaires.', 'Avoid secondary insults.'),
        bulletPoints: [
          LString('PAS > 110 mmHg (idéal PAM > 80)', 'SBP > 110 mmHg (ideal MAP > 80)'),
          LString('SpO2 > 94%', 'SpO2 > 94%'),
          LString('PaCO2 35-40 mmHg (éviter hypo/hypercapnie)', 'PaCO2 35-40 mmHg (avoid hypo/hypercapnia)'),
          LString('Éviter hyperthermie, hyperglycémie', 'Avoid hyperthermia, hyperglycemia'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Intubation', '3. Intubation'),
        content: LString('Protection voies aériennes.', 'Airway protection.'),
        bulletPoints: [
          LString('ISR avec stabilisation rachis cervical', 'RSI with cervical spine stabilization'),
          LString('Kétamine + succinylcholine (ou rocuronium)', 'Ketamine + succinylcholine (or rocuronium)'),
          LString('Éviter hypotension lors de l\'induction', 'Avoid hypotension during induction'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Traitement engagement', '4. Herniation treatment'),
        content: LString('Si mydriase ou signes HTIC.', 'If mydriasis or signs of raised ICP.'),
        bulletPoints: [
          LString('Mannitol 20% 0.5-1 g/kg IV rapide', 'Mannitol 20% 0.5-1 g/kg rapid IV'),
          LString('ou SSH 7.5% 100-150 mL', 'or HTS 7.5% 100-150 mL'),
          LString('Tête à 30°, éviter compression jugulaires', 'Head elevated 30°, avoid jugular compression'),
          LString('Hyperventilation transitoire si engagement avéré (PaCO2 30-35)', 'Transient hyperventilation if confirmed herniation (PaCO2 30-35)'),
        ],
        warning: LString('Hyperventilation seulement transitoire et si engagement', 'Hyperventilation only transient and only if herniation'),
      ),
      ProtocolStep(
        title: LString('5. Imagerie', '5. Imaging'),
        content: LString('Scanner cérébral en urgence.', 'Emergency brain CT scan.'),
        bulletPoints: [
          LString('Scanner sans injection + rachis cervical', 'Non-contrast CT + cervical spine'),
          LString('Rechercher: hématome, contusion, engagement', 'Look for: hematoma, contusion, herniation'),
          LString('Indication neurochirurgicale urgente?', 'Urgent neurosurgical indication?'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Orientation', '6. Disposition'),
        content: LString('Neuroréanimation.', 'Neuro-ICU.'),
        bulletPoints: [
          LString('Transfert trauma center avec neurochirurgie', 'Transfer to trauma center with neurosurgery'),
          LString('Monitoring PIC à discuter', 'ICP monitoring to discuss'),
          LString('Sédation profonde initiale', 'Initial deep sedation'),
        ],
      ),
    ],
    keyPoints: LString('Éviter agressions secondaires (hypoxie, hypotension). PAS > 110. Osmothérapie si engagement.', 'Avoid secondary insults (hypoxia, hypotension). SBP > 110. Osmotherapy if herniation.'),
    source: LString('SFAR/SFMU 2016 - TC Grave', 'SFAR/SFMU 2016 - TC Grave'),
    lastUpdated: 2016,
  ),

  // Choc hémorragique
  Protocol(
    id: 'choc-hemorragique',
    name: LString('Choc Hémorragique', 'Hemorrhagic Shock'),
    category: ProtocolCategory.trauma,
    description: LString('Hypovolémie par saignement massif', 'Hypovolemia from massive bleeding'),
    indication: LString('Saignement actif avec signes de choc (tachycardie, hypotension, marbrures)', 'Active bleeding with signs of shock (tachycardia, hypotension, mottling)'),
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Recognition'),
        content: LString('Identifier le choc hémorragique.', 'Identify hemorrhagic shock.'),
        bulletPoints: [
          LString('Classe I: < 15% volémie, FC < 100', 'Class I: < 15% blood volume, HR < 100'),
          LString('Classe II: 15-30%, FC 100-120, anxiété', 'Class II: 15-30%, HR 100-120, anxiety'),
          LString('Classe III: 30-40%, FC > 120, confusion', 'Class III: 30-40%, HR > 120, confusion'),
          LString('Classe IV: > 40%, FC > 140, léthargie', 'Class IV: > 40%, HR > 140, lethargy'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Contrôle hémorragique', '2. Hemorrhage control'),
        content: LString('Stopper le saignement.', 'Stop the bleeding.'),
        bulletPoints: [
          LString('Compression directe', 'Direct compression'),
          LString('Garrot artériel si membre (noter l\'heure)', 'Arterial tourniquet if limb (note the time)'),
          LString('Packing hémostatique si jonctionnel', 'Hemostatic packing if junctional'),
          LString('Chirurgie/embolisation précoce', 'Early surgery/embolization'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Réanimation volémique', '3. Volume resuscitation'),
        content: LString('Damage control resuscitation.', 'Damage control resuscitation.'),
        bulletPoints: [
          LString('Objectif PAS 80-90 mmHg (hypotension permissive)', 'Target SBP 80-90 mmHg (permissive hypotension)'),
          LString('Cristalloïdes limités à 1-2 L', 'Crystalloids limited to 1-2 L'),
          LString('Transfusion précoce si besoin', 'Early transfusion if needed'),
          LString('Concentrés de globules rouges (CGR)', 'Packed red blood cells (pRBC)'),
        ],
        warning: LString('Hypotension permissive CI si TC associé', 'Permissive hypotension contraindicated if associated TBI'),
      ),
      ProtocolStep(
        title: LString('4. Transfusion massive', '4. Massive transfusion'),
        content: LString('Protocole si hémorragie grave.', 'Protocol if severe hemorrhage.'),
        bulletPoints: [
          LString('Activation protocole transfusion massive', 'Activate massive transfusion protocol'),
          LString('Ratio CGR:PFC:Plaquettes = 1:1:1', 'Ratio pRBC:FFP:Platelets = 1:1:1'),
          LString('Fibrinogène si < 1.5 g/L', 'Fibrinogen if < 1.5 g/L'),
          LString('Objectif Hb > 7-9 g/dL', 'Target Hb > 7-9 g/dL'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Acide tranexamique', '5. Tranexamic acid'),
        content: LString('Administration précoce.', 'Early administration.'),
        bulletPoints: [
          LString('1g IV en 10 min < 3h du trauma', '1g IV over 10 min < 3h from trauma'),
          LString('puis 1g IV sur 8h', 'then 1g IV over 8h'),
          LString('Réduit mortalité si administré tôt', 'Reduces mortality if given early'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Éviter la triade létale', '6. Avoid the lethal triad'),
        content: LString('Hypothermie - Acidose - Coagulopathie.', 'Hypothermia - Acidosis - Coagulopathy.'),
        bulletPoints: [
          LString('Réchauffement actif (couverture, solutés réchauffés)', 'Active rewarming (blankets, warmed fluids)'),
          LString('Corriger acidose (optimiser perfusion)', 'Correct acidosis (optimize perfusion)'),
          LString('Corriger coagulopathie (PFC, plaquettes, fibrinogène)', 'Correct coagulopathy (FFP, platelets, fibrinogen)'),
          LString('Calcium si transfusion massive', 'Calcium if massive transfusion'),
        ],
      ),
    ],
    keyPoints: LString('Contrôle hémorragie. Acide tranexamique < 3h. Ratio 1:1:1. Éviter triade létale.', 'Hemorrhage control. Tranexamic acid < 3h. Ratio 1:1:1. Avoid lethal triad.'),
    source: LString('SFAR 2015 - Choc hémorragique traumatique', 'SFAR 2015 - Choc hémorragique traumatique'),
    lastUpdated: 2015,
  ),

  // Damage control
  Protocol(
    id: 'damage-control',
    name: LString('Damage Control', 'Damage Control'),
    category: ProtocolCategory.trauma,
    description: LString('Stratégie de réanimation chirurgicale abrégée', 'Abbreviated surgical resuscitation strategy'),
    indication: LString('Patient traumatisé instable avec hémorragie active', 'Unstable trauma patient with active hemorrhage'),
    steps: [
      ProtocolStep(
        title: LString('1. Principe', '1. Principle'),
        content: LString('Chirurgie écourtée puis réanimation.', 'Abbreviated surgery then resuscitation.'),
        bulletPoints: [
          LString('Contrôle hémorragie et contamination uniquement', 'Control hemorrhage and contamination only'),
          LString('Packing hémostatique', 'Hemostatic packing'),
          LString('Fermeture temporaire', 'Temporary closure'),
          LString('Réanimation pour corriger physiologie', 'Resuscitation to correct physiology'),
          LString('Reprise chirurgicale à 24-48h', 'Surgical re-exploration at 24-48h'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Indications', '2. Indications'),
        content: LString('Quand appliquer le damage control.', 'When to apply damage control.'),
        bulletPoints: [
          LString('pH < 7.2', 'pH < 7.2'),
          LString('Température < 34°C', 'Temperature < 34°C'),
          LString('Coagulopathie (TP < 50%, Fibrinogène < 1 g/L)', 'Coagulopathy (PT < 50%, Fibrinogen < 1 g/L)'),
          LString('Temps opératoire prévu > 90 min', 'Expected operative time > 90 min'),
          LString('Transfusion > 10 CGR', 'Transfusion > 10 pRBC units'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Damage control resuscitation', '3. Damage control resuscitation'),
        content: LString('Réanimation associée.', 'Associated resuscitation.'),
        bulletPoints: [
          LString('Hypotension permissive (PAS 80-90)', 'Permissive hypotension (SBP 80-90)'),
          LString('Limiter cristalloïdes', 'Limit crystalloids'),
          LString('Transfusion précoce ratio 1:1:1', 'Early transfusion ratio 1:1:1'),
          LString('Acide tranexamique', 'Tranexamic acid'),
          LString('Réchauffement actif', 'Active rewarming'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Phase de réanimation', '4. Resuscitation phase'),
        content: LString('Objectifs de correction.', 'Correction targets.'),
        bulletPoints: [
          LString('Corriger hypothermie (T > 35°C)', 'Correct hypothermia (T > 35°C)'),
          LString('Corriger acidose (pH > 7.25)', 'Correct acidosis (pH > 7.25)'),
          LString('Corriger coagulopathie', 'Correct coagulopathy'),
          LString('Stabilité hémodynamique', 'Hemodynamic stability'),
          LString('Durée: 24-48h', 'Duration: 24-48h'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Reprise chirurgicale', '5. Definitive surgery'),
        content: LString('Chirurgie définitive.', 'Definitive surgery.'),
        bulletPoints: [
          LString('Quand physiologie corrigée', 'When physiology corrected'),
          LString('Ablation packing', 'Packing removal'),
          LString('Réparation définitive des lésions', 'Definitive repair of injuries'),
          LString('Fermeture pariétale', 'Abdominal wall closure'),
        ],
      ),
    ],
    keyPoints: LString('Sauver la vie > réparer les lésions. Contrôle hémorragie rapide. Corriger physiologie puis reprise.', 'Save life > repair injuries. Rapid hemorrhage control. Correct physiology then re-operate.'),
    source: LString('Principes de damage control - Traumatologie', 'Principes de damage control - Traumatologie'),
    lastUpdated: 2020,
  ),

  // Fractures ouvertes
  Protocol(
    id: 'fracture-ouverte',
    name: LString('Fractures Ouvertes', 'Open Fractures'),
    category: ProtocolCategory.trauma,
    description: LString('Prise en charge des fractures ouvertes', 'Management of open fractures'),
    indication: LString('Fracture avec effraction cutanée', 'Fracture with skin breach'),
    steps: [
      ProtocolStep(
        title: LString('1. Classification Gustilo', '1. Gustilo Classification'),
        content: LString('Grader la fracture ouverte.', 'Grade the open fracture.'),
        bulletPoints: [
          LString('Type I: plaie < 1 cm, contamination minime', 'Type I: wound < 1 cm, minimal contamination'),
          LString('Type II: plaie 1-10 cm, dommages tissulaires modérés', 'Type II: wound 1-10 cm, moderate tissue damage'),
          LString('Type IIIA: > 10 cm mais couverture osseuse possible', 'Type IIIA: > 10 cm but bone coverage possible'),
          LString('Type IIIB: nécessite lambeau de couverture', 'Type IIIB: requires flap coverage'),
          LString('Type IIIC: lésion vasculaire nécessitant réparation', 'Type IIIC: vascular injury requiring repair'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Soins immédiats', '2. Immediate care'),
        content: LString('Aux urgences.', 'In the emergency department.'),
        bulletPoints: [
          LString('Photo de la plaie avant pansement', 'Photograph wound before dressing'),
          LString('Lavage sérum physiologique', 'Normal saline irrigation'),
          LString('Pansement stérile humide', 'Moist sterile dressing'),
          LString('Immobilisation (attelle)', 'Immobilization (splint)'),
          LString('Vérifier état vasculo-nerveux distal', 'Check distal neurovascular status'),
        ],
        warning: LString('Ne pas explorer la plaie aux urgences', 'Do not explore the wound in the ED'),
      ),
      ProtocolStep(
        title: LString('3. Antibiothérapie', '3. Antibiotic therapy'),
        content: LString('Selon grade.', 'According to grade.'),
        bulletPoints: [
          LString('Gustilo I-II: Amoxicilline-ac. clav. 2g/8h pendant 48h', 'Gustilo I-II: Amoxicillin-clavulanate 2g/8h for 48h'),
          LString('Gustilo III: Amoxicilline-ac. clav. + Gentamicine 5 mg/kg/j', 'Gustilo III: Amoxicillin-clavulanate + Gentamicin 5 mg/kg/day'),
          LString('Si allergie: Clindamycine + Gentamicine', 'If allergy: Clindamycin + Gentamicin'),
          LString('Contamination tellurique: ajouter pénicilline G ou métronidazole', 'Soil contamination: add penicillin G or metronidazole'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Prophylaxie antitétanique', '4. Tetanus prophylaxis'),
        content: LString('Selon statut vaccinal.', 'According to vaccination status.'),
        bulletPoints: [
          LString('Vérifier vaccination', 'Check vaccination status'),
          LString('Rappel si > 5 ans', 'Booster if > 5 years'),
          LString('Immunoglobulines si statut inconnu ou incomplet', 'Immunoglobulins if status unknown or incomplete'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Prise en charge chirurgicale', '5. Surgical management'),
        content: LString('Au bloc opératoire.', 'In the operating room.'),
        bulletPoints: [
          LString('Délai < 6h (controversé mais raisonnable)', 'Timeframe < 6h (debated but reasonable)'),
          LString('Parage, lavage abondant', 'Debridement, copious irrigation'),
          LString('Fixation: externe souvent préférée', 'Fixation: external often preferred'),
          LString('Couverture des parties molles', 'Soft tissue coverage'),
        ],
      ),
    ],
    keyPoints: LString('Photo. Pansement stérile. ATB précoce adaptée au grade. Chirurgie < 6h si possible.', 'Photograph. Sterile dressing. Early antibiotics adapted to grade. Surgery < 6h if possible.'),
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
    name: LString('Choc Septique', 'Septic Shock'),
    category: ProtocolCategory.sepsis,
    description: LString('Sepsis avec hypotension nécessitant vasopresseurs et lactates > 2 mmol/L', 'Sepsis with hypotension requiring vasopressors and lactate > 2 mmol/L'),
    indication: LString('Sepsis avec hypotension persistante malgré remplissage et lactates élevés', 'Sepsis with persistent hypotension despite fluid resuscitation and elevated lactate'),
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance (Hour-1 Bundle)', '1. Recognition (Hour-1 Bundle)'),
        content: LString('Identification précoce.', 'Early identification.'),
        bulletPoints: [
          LString('Suspicion infection + qSOFA ≥ 2 ou SOFA ≥ 2', 'Suspected infection + qSOFA ≥ 2 or SOFA ≥ 2'),
          LString('qSOFA: FR ≥ 22, PAS ≤ 100, confusion', 'qSOFA: RR ≥ 22, SBP ≤ 100, altered mentation'),
          LString('Choc: vasopresseurs nécessaires pour PAM ≥ 65', 'Shock: vasopressors needed for MAP ≥ 65'),
          LString('Lactates > 2 mmol/L malgré remplissage', 'Lactate > 2 mmol/L despite fluid resuscitation'),
        ],
        warning: LString('Hour-1 Bundle = actions dans la première heure', 'Hour-1 Bundle = actions within the first hour'),
      ),
      ProtocolStep(
        title: LString('2. Prélèvements', '2. Sampling'),
        content: LString('Avant antibiothérapie si possible.', 'Before antibiotics if possible.'),
        bulletPoints: [
          LString('Lactates', 'Lactate level'),
          LString('Hémocultures (2 paires) < 45 min', 'Blood cultures (2 sets) < 45 min'),
          LString('Autres prélèvements selon foyer: ECBU, PL, ponction...', 'Other samples per source: urine, LP, aspiration...'),
          LString('Ne pas retarder ATB pour prélèvements', 'Do not delay antibiotics for sampling'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Antibiothérapie', '3. Antibiotic therapy'),
        content: LString('Dans l\'heure suivant reconnaissance.', 'Within one hour of recognition.'),
        bulletPoints: [
          LString('Large spectre probabiliste selon foyer suspecté', 'Broad-spectrum empirical therapy based on suspected source'),
          LString('Communautaire: Pipéracilline-tazobactam ou C3G + métronidazole', 'Community: Piperacillin-tazobactam or 3rd-gen cephalosporin + metronidazole'),
          LString('Nosocomial: adapter au risque BMR', 'Nosocomial: adjust for MDR risk'),
          LString('Réévaluer à 48-72h avec résultats', 'Reassess at 48-72h with results'),
        ],
        warning: LString('Chaque heure de retard = 7% mortalité en plus', 'Each hour of delay = 7% increase in mortality'),
      ),
      ProtocolStep(
        title: LString('4. Remplissage vasculaire', '4. Fluid resuscitation'),
        content: LString('Première ligne hémodynamique.', 'First-line hemodynamic support.'),
        bulletPoints: [
          LString('Cristalloïdes 30 mL/kg dans les 3 premières heures', 'Crystalloids 30 mL/kg within the first 3 hours'),
          LString('Réévaluer réponse au remplissage', 'Reassess fluid responsiveness'),
          LString('Objectif PAM ≥ 65 mmHg', 'Target MAP ≥ 65 mmHg'),
          LString('Attention si cardiopathie/SDRA', 'Caution if heart disease/ARDS'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Vasopresseurs', '5. Vasopressors'),
        content: LString('Si hypotension persistante.', 'If persistent hypotension.'),
        bulletPoints: [
          LString('Noradrénaline 1ère intention', 'Norepinephrine first-line'),
          LString('Débuter précocement si hypotension sévère', 'Start early if severe hypotension'),
          LString('Objectif PAM ≥ 65 mmHg', 'Target MAP ≥ 65 mmHg'),
          LString('VVC dès que possible (mais ne pas retarder)', 'CVC as soon as possible (but do not delay)'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Mesures associées', '6. Associated measures'),
        content: LString('Optimisation.', 'Optimization.'),
        bulletPoints: [
          LString('Contrôle du foyer infectieux (drainage, chirurgie)', 'Source control (drainage, surgery)'),
          LString('Si choc réfractaire: corticoïdes (hydrocortisone 200 mg/j)', 'If refractory shock: corticosteroids (hydrocortisone 200 mg/day)'),
          LString('Transfusion si Hb < 7 g/dL (seuil restrictif)', 'Transfusion if Hb < 7 g/dL (restrictive threshold)'),
          LString('Contrôle glycémique (< 1.8 g/L)', 'Glycemic control (< 1.8 g/L)'),
        ],
      ),
    ],
    keyPoints: LString('Hour-1: lactates + hémoc + ATB + remplissage + vasopresseurs si besoin. Contrôle du foyer.', 'Hour-1: lactate + blood cultures + antibiotics + fluids + vasopressors if needed. Source control.'),
    source: LString('Surviving Sepsis Campaign 2021', 'Surviving Sepsis Campaign 2021'),
    sourceUrl: 'https://www.sccm.org',
    lastUpdated: 2021,
  ),

  // Purpura fulminans
  Protocol(
    id: 'purpura-fulminans',
    name: LString('Purpura Fulminans', 'Purpura Fulminans'),
    category: ProtocolCategory.sepsis,
    description: LString('Urgence absolue - infection invasive à méningocoque', 'Absolute emergency - invasive meningococcal infection'),
    indication: LString('Fièvre + purpura nécrotique ou extensif', 'Fever + necrotic or spreading purpura'),
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Recognition'),
        content: LString('Identifier immédiatement.', 'Identify immediately.'),
        bulletPoints: [
          LString('Fièvre + purpura ne s\'effaçant pas à la vitropression', 'Fever + purpura non-blanching on pressure'),
          LString('Purpura extensif (> 3 mm), nécrotique, ecchymotique', 'Spreading purpura (> 3 mm), necrotic, ecchymotic'),
          LString('Altération de l\'état général', 'General deterioration'),
          LString('Méningocoque jusqu\'à preuve du contraire', 'Meningococcus until proven otherwise'),
        ],
        warning: LString('URGENCE ABSOLUE - mortalité 20-30%', 'ABSOLUTE EMERGENCY - mortality 20-30%'),
      ),
      ProtocolStep(
        title: LString('2. Antibiothérapie IMMÉDIATE', '2. IMMEDIATE antibiotic therapy'),
        content: LString('Avant tout transport ou examen.', 'Before any transport or workup.'),
        bulletPoints: [
          LString('Ceftriaxone 2g IV ou IM (enfant: 100 mg/kg)', 'Ceftriaxone 2g IV or IM (child: 100 mg/kg)'),
          LString('Alternative si allergie: Ciprofloxacine', 'Alternative if allergy: Ciprofloxacin'),
          LString('NE PAS ATTENDRE: hémocultures, VVP, résultats', 'DO NOT WAIT for: blood cultures, IV access, results'),
          LString('Injection IM si pas d\'accès IV immédiat', 'IM injection if no immediate IV access'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Réanimation hémodynamique', '3. Hemodynamic resuscitation'),
        content: LString('Traitement du choc.', 'Shock management.'),
        bulletPoints: [
          LString('Remplissage: NaCl 0.9% 20 mL/kg renouvelable', 'Fluids: NaCl 0.9% 20 mL/kg, repeatable'),
          LString('Noradrénaline précoce si choc', 'Early norepinephrine if shock'),
          LString('Objectif PAM > 65 mmHg', 'Target MAP > 65 mmHg'),
          LString('IOT si détresse respiratoire/troubles conscience', 'ETI if respiratory distress/altered consciousness'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Transfert', '4. Transfer'),
        content: LString('Vers réanimation.', 'To ICU.'),
        bulletPoints: [
          LString('Réanimation la plus proche', 'Nearest ICU'),
          LString('SMUR médicalisé', 'Physician-staffed ambulance'),
          LString('Pas de PL en préhospitalier', 'No LP in prehospital setting'),
          LString('Continuer réanimation pendant transport', 'Continue resuscitation during transport'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Mesures de santé publique', '5. Public health measures'),
        content: LString('Prophylaxie des contacts.', 'Contact prophylaxis.'),
        bulletPoints: [
          LString('Déclaration obligatoire ARS', 'Mandatory reporting to health authority'),
          LString('Prophylaxie contacts proches < 10 jours', 'Close contact prophylaxis < 10 days'),
          LString('Rifampicine 600 mg x2/j pendant 2 jours (adulte)', 'Rifampicin 600 mg x2/day for 2 days (adult)'),
          LString('ou Ceftriaxone 250 mg IM dose unique', 'or Ceftriaxone 250 mg IM single dose'),
        ],
      ),
    ],
    keyPoints: LString('Antibiotique IMMÉDIAT même préhospitalier. Ne rien attendre. Mortalité dépend du délai.', 'IMMEDIATE antibiotics even prehospital. Do not wait for anything. Mortality depends on delay.'),
    source: LString('Instruction DGS 2018, HCSP', 'Instruction DGS 2018, HCSP'),
    lastUpdated: 2018,
  ),

  // Pneumonie grave
  Protocol(
    id: 'pneumonie-grave',
    name: LString('Pneumonie Communautaire Grave', 'Severe Community-Acquired Pneumonia'),
    category: ProtocolCategory.sepsis,
    description: LString('Pneumonie avec critères de gravité nécessitant réanimation', 'Pneumonia with severity criteria requiring ICU'),
    indication: LString('Pneumonie + ≥ 1 critère majeur ou ≥ 3 critères mineurs ATS/IDSA', 'Pneumonia + ≥ 1 major or ≥ 3 minor ATS/IDSA criteria'),
    steps: [
      ProtocolStep(
        title: LString('1. Critères de gravité', '1. Severity criteria'),
        content: LString('Évaluation de la sévérité.', 'Severity assessment.'),
        bulletPoints: [
          LString('Majeurs: choc septique, ventilation mécanique', 'Major: septic shock, mechanical ventilation'),
          LString('Mineurs: FR ≥ 30, PaO2/FiO2 ≤ 250, confusion', 'Minor: RR ≥ 30, PaO2/FiO2 ≤ 250, confusion'),
          LString('Infiltrats multilobaires, urée > 7 mmol/L', 'Multilobar infiltrates, BUN > 7 mmol/L'),
          LString('Leucopénie, thrombopénie, hypothermie', 'Leukopenia, thrombocytopenia, hypothermia'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Prélèvements', '2. Sampling'),
        content: LString('Documentation microbiologique.', 'Microbiological documentation.'),
        bulletPoints: [
          LString('Hémocultures x2', 'Blood cultures x2'),
          LString('Antigénuries pneumocoque et légionelle', 'Pneumococcal and Legionella urinary antigens'),
          LString('ECBC ou aspiration trachéale si intubé', 'Sputum culture or tracheal aspirate if intubated'),
          LString('PCR grippe si épidémie', 'Influenza PCR if epidemic'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Antibiothérapie probabiliste', '3. Empirical antibiotic therapy'),
        content: LString('Sans attendre résultats.', 'Without waiting for results.'),
        bulletPoints: [
          LString('C3G (Ceftriaxone 2g/j) + Macrolide (Spiramycine ou Azithromycine)', '3rd-gen cephalosporin (Ceftriaxone 2g/day) + Macrolide (Spiramycin or Azithromycin)'),
          LString('ou C3G + Fluoroquinolone (Lévofloxacine)', 'or 3rd-gen cephalosporin + Fluoroquinolone (Levofloxacin)'),
          LString('Si risque Pseudomonas: Pipéracilline-tazobactam + Amikacine', 'If Pseudomonas risk: Piperacillin-tazobactam + Amikacin'),
          LString('Durée: 7 jours (14 si Légionelle)', 'Duration: 7 days (14 if Legionella)'),
        ],
        tip: LString('Macrolide couvre atypiques (Légionelle, Mycoplasme)', 'Macrolide covers atypicals (Legionella, Mycoplasma)'),
      ),
      ProtocolStep(
        title: LString('4. Support respiratoire', '4. Respiratory support'),
        content: LString('Selon gravité.', 'According to severity.'),
        bulletPoints: [
          LString('O2 pour SpO2 > 92%', 'O2 for SpO2 > 92%'),
          LString('VNI si IRA hypercapnique ou OAP associé', 'NIV if hypercapnic ARF or associated APE'),
          LString('HFNC (Optiflow) si IRA hypoxémique', 'HFNC (Optiflow) if hypoxemic ARF'),
          LString('IOT si détresse majeure, épuisement, choc', 'ETI if major distress, exhaustion, shock'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Mesures associées', '5. Associated measures'),
        content: LString('Optimisation.', 'Optimization.'),
        bulletPoints: [
          LString('Rééquilibration hydro-électrolytique', 'Fluid and electrolyte correction'),
          LString('Kinésithérapie respiratoire', 'Respiratory physiotherapy'),
          LString('Prévention thromboembolique', 'Thromboembolic prophylaxis'),
          LString('Corticoïdes discutés si choc', 'Corticosteroids discussed if shock'),
        ],
      ),
    ],
    keyPoints: LString('C3G + macrolide ou FQ. Documentation microbiologique. Support respiratoire adapté.', '3rd-gen cephalosporin + macrolide or FQ. Microbiological documentation. Adapted respiratory support.'),
    source: LString('SPILF/SPLF 2024 - Infections respiratoires basses', 'SPILF/SPLF 2024 - Infections respiratoires basses'),
    lastUpdated: 2024,
  ),

  // Fasciite nécrosante
  Protocol(
    id: 'fasciite-necrosante',
    name: LString('Fasciite Nécrosante', 'Necrotizing Fasciitis'),
    category: ProtocolCategory.sepsis,
    description: LString('Infection grave des tissus mous avec nécrose', 'Severe soft tissue infection with necrosis'),
    indication: LString('Douleur intense, signes généraux sévères, évolution rapide', 'Intense pain, severe systemic signs, rapid progression'),
    steps: [
      ProtocolStep(
        title: LString('1. Suspicion clinique', '1. Clinical suspicion'),
        content: LString('Reconnaître précocement.', 'Recognize early.'),
        bulletPoints: [
          LString('Douleur disproportionnée par rapport aux signes locaux', 'Pain disproportionate to local signs'),
          LString('Œdème induré dépassant érythème', 'Indurated edema extending beyond erythema'),
          LString('Crépitations sous-cutanées (gaz)', 'Subcutaneous crepitus (gas)'),
          LString('Signes systémiques: choc, confusion', 'Systemic signs: shock, confusion'),
          LString('Extension rapide (heures)', 'Rapid spread (hours)'),
        ],
        warning: LString('Score LRINEC peut aider mais ne pas retarder si suspicion forte', 'LRINEC score may help but do not delay if strong suspicion'),
      ),
      ProtocolStep(
        title: LString('2. Antibiothérapie urgente', '2. Urgent antibiotic therapy'),
        content: LString('Large spectre + anti-toxinique.', 'Broad-spectrum + anti-toxin.'),
        bulletPoints: [
          LString('Pipéracilline-tazobactam 4g x4/j', 'Piperacillin-tazobactam 4g x4/day'),
          LString('+ Clindamycine 600-900 mg x3/j (anti-toxinique)', '+ Clindamycin 600-900 mg x3/day (anti-toxin)'),
          LString('+ Amikacine 25 mg/kg/j si choc', '+ Amikacin 25 mg/kg/day if shock'),
          LString('Alternative: Méropénème si allergie', 'Alternative: Meropenem if allergy'),
        ],
        tip: LString('Clindamycine inhibe production de toxines', 'Clindamycin inhibits toxin production'),
      ),
      ProtocolStep(
        title: LString('3. Chirurgie urgente', '3. Urgent surgery'),
        content: LString('Débridement dans les 12-24h.', 'Debridement within 12-24h.'),
        bulletPoints: [
          LString('Exploration chirurgicale diagnostique et thérapeutique', 'Diagnostic and therapeutic surgical exploration'),
          LString('Débridement large de tous tissus nécrotiques', 'Wide debridement of all necrotic tissue'),
          LString('Reprises itératives (24-48h) jusqu\'à tissu sain', 'Iterative re-explorations (24-48h) until healthy tissue'),
          LString('Prélèvements peropératoires', 'Intraoperative cultures'),
        ],
        warning: LString('Retard chirurgical = surmortalité majeure', 'Surgical delay = major excess mortality'),
      ),
      ProtocolStep(
        title: LString('4. Réanimation', '4. Resuscitation'),
        content: LString('Support des défaillances.', 'Organ failure support.'),
        bulletPoints: [
          LString('Remplissage vasculaire', 'Fluid resuscitation'),
          LString('Vasopresseurs si choc', 'Vasopressors if shock'),
          LString('Ventilation mécanique si défaillance respi', 'Mechanical ventilation if respiratory failure'),
          LString('Épuration extra-rénale si IRA', 'Renal replacement therapy if AKI'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Thérapies adjuvantes', '5. Adjunctive therapies'),
        content: LString('Mesures complémentaires.', 'Complementary measures.'),
        bulletPoints: [
          LString('Immunoglobulines IV discutées si streptocoque A', 'IV immunoglobulins discussed if Group A Streptococcus'),
          LString('Oxygénothérapie hyperbare (si disponible)', 'Hyperbaric oxygen therapy (if available)'),
          LString('Prise en charge nutritionnelle', 'Nutritional support'),
        ],
      ),
    ],
    keyPoints: LString('Suspicion = chirurgie urgente + ATB large spectre avec clindamycine. Mortalité > 30%.', 'Suspicion = urgent surgery + broad-spectrum antibiotics with clindamycin. Mortality > 30%.'),
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
    name: LString('Intoxication Médicamenteuse', 'Drug Poisoning'),
    category: ProtocolCategory.toxicology,
    description: LString('Approche générale des intoxications médicamenteuses volontaires', 'General approach to intentional drug overdose'),
    indication: LString('Suspicion d\'ingestion médicamenteuse à visée suicidaire ou accidentelle', 'Suspected suicidal or accidental drug ingestion'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation initiale', '1. Initial assessment'),
        content: LString('Stabilisation et bilan.', 'Stabilization and workup.'),
        bulletPoints: [
          LString('ABCDE systématique', 'Systematic ABCDE'),
          LString('Glasgow, pupilles, glycémie', 'GCS, pupils, blood glucose'),
          LString('Monitoring continu: scope, SpO2, PA', 'Continuous monitoring: telemetry, SpO2, BP'),
          LString('Température (hypo/hyperthermie)', 'Temperature (hypo/hyperthermia)'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Anamnèse toxicologique', '2. Toxicological history'),
        content: LString('Recueillir informations.', 'Gather information.'),
        bulletPoints: [
          LString('Produit(s), quantité, heure d\'ingestion', 'Substance(s), quantity, time of ingestion'),
          LString('Symptômes et délai d\'apparition', 'Symptoms and time of onset'),
          LString('Co-intoxications (alcool++)', 'Co-ingestions (alcohol++)'),
          LString('ATCD psychiatriques, tentatives antérieures', 'Psychiatric history, previous attempts'),
          LString('Boîtes, ordonnances, témoins', 'Pill boxes, prescriptions, witnesses'),
        ],
        tip: LString('Appeler le centre antipoison si doute', 'Call poison control center if uncertain'),
      ),
      ProtocolStep(
        title: LString('3. Toxidromes', '3. Toxidromes'),
        content: LString('Orienter le diagnostic.', 'Guide the diagnosis.'),
        bulletPoints: [
          LString('Opioïdes: myosis, bradypnée, coma calme', 'Opioids: miosis, bradypnea, calm coma'),
          LString('Anticholinergique: mydriase, tachycardie, rétention', 'Anticholinergic: mydriasis, tachycardia, retention'),
          LString('Sympathomimétique: mydriase, HTA, hyperthermie', 'Sympathomimetic: mydriasis, hypertension, hyperthermia'),
          LString('Sérotoninergique: confusion, myoclonies, hyperthermie', 'Serotonergic: confusion, myoclonus, hyperthermia'),
          LString('Stabilisant de membrane: QRS large, troubles rythme', 'Sodium channel blocker: wide QRS, arrhythmias'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Examens complémentaires', '4. Investigations'),
        content: LString('Bilan ciblé.', 'Targeted workup.'),
        bulletPoints: [
          LString('ECG: QT, QRS (élargissement)', 'ECG: QT, QRS (widening)'),
          LString('Glycémie, iono, créatinine, lactates', 'Blood glucose, electrolytes, creatinine, lactate'),
          LString('Paracétamolémie systématique (si > 4h)', 'Routine acetaminophen level (if > 4h)'),
          LString('Dosages spécifiques si disponibles', 'Specific drug levels if available'),
          LString('Toxiques urinaires (orientation)', 'Urine drug screen (guidance)'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Décontamination digestive', '5. GI decontamination'),
        content: LString('Indications limitées.', 'Limited indications.'),
        bulletPoints: [
          LString('Charbon activé 1 g/kg si < 1h post-ingestion', 'Activated charcoal 1 g/kg if < 1h post-ingestion'),
          LString('CI: coma, vomissements, caustiques', 'CI: coma, vomiting, caustics'),
          LString('Lavage gastrique: exceptionnellement (ingestion massive < 1h)', 'Gastric lavage: exceptionally (massive ingestion < 1h)'),
          LString('Irrigation intestinale: toxiques à libération prolongée', 'Whole bowel irrigation: sustained-release toxins'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Antidotes principaux', '6. Main antidotes'),
        content: LString('Traitements spécifiques.', 'Specific treatments.'),
        bulletPoints: [
          LString('Paracétamol: N-acétylcystéine', 'Acetaminophen: N-acetylcysteine'),
          LString('Opioïdes: Naloxone', 'Opioids: Naloxone'),
          LString('Benzodiazépines: Flumazénil (CI si épilepsie, co-ingestion)', 'Benzodiazepines: Flumazenil (CI if epilepsy, co-ingestion)'),
          LString('Stabilisants membrane: bicarbonates molaires', 'Sodium channel blockers: molar bicarbonate'),
          LString('Digitaliques: anticorps anti-digoxine', 'Digoxin: anti-digoxin antibodies'),
        ],
      ),
    ],
    keyPoints: LString('ABCDE. Identifier toxidrome. ECG + paracétamolémie systématiques. Charbon < 1h. Antidotes spécifiques.', 'ABCDE. Identify toxidrome. Routine ECG + acetaminophen level. Charcoal < 1h. Specific antidotes.'),
    source: LString('SFMU - Toxicologie d\'urgence', 'SFMU - Toxicologie d\'urgence'),
    lastUpdated: 2020,
  ),

  // Intoxication CO
  Protocol(
    id: 'intox-co',
    name: LString('Intoxication au Monoxyde de Carbone', 'Carbon Monoxide Poisoning'),
    category: ProtocolCategory.toxicology,
    description: LString('Intoxication au CO - urgence collective possible', 'CO poisoning - possible mass casualty event'),
    indication: LString('Céphalées, nausées, confusion dans contexte évocateur (chauffage, incendie)', 'Headaches, nausea, confusion in suggestive context (heating, fire)'),
    steps: [
      ProtocolStep(
        title: LString('1. Suspicion et évacuation', '1. Suspicion and evacuation'),
        content: LString('Mesures de protection.', 'Protective measures.'),
        bulletPoints: [
          LString('Évacuer la zone contaminée', 'Evacuate the contaminated area'),
          LString('Aérer les locaux', 'Ventilate the premises'),
          LString('Rechercher autres victimes', 'Search for other victims'),
          LString('Signalement (pompiers, CAPTV)', 'Report (fire department, poison center)'),
        ],
        warning: LString('Ne pas entrer sans protection si concentration élevée', 'Do not enter without protection if high concentration'),
      ),
      ProtocolStep(
        title: LString('2. Signes cliniques', '2. Clinical signs'),
        content: LString('Gravité variable.', 'Variable severity.'),
        bulletPoints: [
          LString('Léger: céphalées, nausées, vertiges', 'Mild: headaches, nausea, dizziness'),
          LString('Modéré: confusion, faiblesse, dyspnée d\'effort', 'Moderate: confusion, weakness, exertional dyspnea'),
          LString('Sévère: coma, convulsions, arythmies', 'Severe: coma, seizures, arrhythmias'),
          LString('Coloration rosée = tardive et inconstante', 'Cherry-red color = late and inconsistent'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Oxygénothérapie normobare', '3. Normobaric oxygen therapy'),
        content: LString('Traitement immédiat.', 'Immediate treatment.'),
        bulletPoints: [
          LString('O2 100% au masque haute concentration', '100% O2 via non-rebreather mask'),
          LString('Durée: minimum 12 heures', 'Duration: minimum 12 hours'),
          LString('Demi-vie HbCO: 4-5h en air ambiant, 1h sous O2 100%', 'COHb half-life: 4-5h in ambient air, 1h on 100% O2'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Indications OHB', '4. HBO indications'),
        content: LString('Oxygénothérapie hyperbare.', 'Hyperbaric oxygen therapy.'),
        bulletPoints: [
          LString('Perte de connaissance', 'Loss of consciousness'),
          LString('Signes neurologiques', 'Neurological signs'),
          LString('Signes cardiaques (ischémie, arythmies)', 'Cardiac signs (ischemia, arrhythmias)'),
          LString('Grossesse', 'Pregnancy'),
          LString('HbCO > 25% (ou > 15% chez femme enceinte)', 'COHb > 25% (or > 15% in pregnant women)'),
        ],
        tip: LString('Contacter centre hyperbare si indication', 'Contact hyperbaric center if indicated'),
      ),
      ProtocolStep(
        title: LString('5. Bilan', '5. Workup'),
        content: LString('Examens complémentaires.', 'Investigations.'),
        bulletPoints: [
          LString('HbCO (attention: peut être normalisée à l\'arrivée)', 'COHb (caution: may have normalized on arrival)'),
          LString('Gazométrie (SaO2 normale malgré intox!)', 'Blood gas (SaO2 normal despite poisoning!)'),
          LString('ECG (ischémie, troubles rythme)', 'ECG (ischemia, arrhythmias)'),
          LString('Troponine si signes cardiaques', 'Troponin if cardiac signs'),
          LString('Lactates', 'Lactate'),
        ],
        warning: LString('SpO2 normale en cas d\'intox CO! Utiliser CO-oxymètre', 'SpO2 normal in CO poisoning! Use CO-oximeter'),
      ),
      ProtocolStep(
        title: LString('6. Surveillance', '6. Monitoring'),
        content: LString('Suivi des complications.', 'Complication follow-up.'),
        bulletPoints: [
          LString('Syndrome post-intervallaire (2-40 jours)', 'Delayed neuropsychiatric syndrome (2-40 days)'),
          LString('Troubles cognitifs, neurologiques', 'Cognitive and neurological deficits'),
          LString('Suivi spécialisé recommandé', 'Specialist follow-up recommended'),
        ],
      ),
    ],
    keyPoints: LString('Évacuer + O2 100% immédiat. OHB si gravité. SpO2 non fiable. Rechercher autres victimes.', 'Evacuate + immediate 100% O2. HBO if severe. SpO2 unreliable. Search for other victims.'),
    source: LString('SFMU 2017 - Intoxication CO', 'SFMU 2017 - Intoxication CO'),
    lastUpdated: 2017,
  ),

  // Intoxication éthylique aiguë
  Protocol(
    id: 'intox-alcool',
    name: LString('Intoxication Éthylique Aiguë', 'Acute Alcohol Intoxication'),
    category: ProtocolCategory.toxicology,
    description: LString('Ivresse aiguë et ses complications', 'Acute intoxication and its complications'),
    indication: LString('État d\'ivresse avec altération de conscience ou comportement', 'Intoxication with altered consciousness or behavior'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation gravité', '1. Severity assessment'),
        content: LString('Stadification clinique.', 'Clinical staging.'),
        bulletPoints: [
          LString('Excitation: euphorie, désinhibition, logorrhée', 'Excitement: euphoria, disinhibition, talkativeness'),
          LString('Ébriété: incoordination, dysarthrie', 'Inebriation: incoordination, dysarthria'),
          LString('Ivresse sévère: somnolence, confusion', 'Severe intoxication: drowsiness, confusion'),
          LString('Coma éthylique: GCS < 8, hypothermie, hypotension', 'Alcoholic coma: GCS < 8, hypothermia, hypotension'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Éliminer diagnostics différentiels', '2. Rule out differential diagnoses'),
        content: LString('Ne pas tout attribuer à l\'alcool.', 'Do not attribute everything to alcohol.'),
        bulletPoints: [
          LString('Traumatisme crânien (chute ++)', 'Head injury (fall ++)'),
          LString('Hypoglycémie', 'Hypoglycemia'),
          LString('Co-intoxication', 'Co-ingestion'),
          LString('AVC, méningite', 'Stroke, meningitis'),
          LString('Encéphalopathie hépatique, de Gayet-Wernicke', 'Hepatic encephalopathy, Wernicke encephalopathy'),
        ],
        warning: LString('Toujours scanner si doute ou trauma', 'Always CT scan if doubt or trauma'),
      ),
      ProtocolStep(
        title: LString('3. Prise en charge coma éthylique', '3. Management of alcoholic coma'),
        content: LString('Mesures de protection.', 'Protective measures.'),
        bulletPoints: [
          LString('PLS, prévention inhalation', 'Recovery position, aspiration prevention'),
          LString('Intubation si GCS ≤ 8 sans amélioration', 'Intubation if GCS ≤ 8 without improvement'),
          LString('Réchauffement si hypothermie', 'Rewarming if hypothermia'),
          LString('Hydratation IV (G5% avec électrolytes)', 'IV hydration (D5W with electrolytes)'),
          LString('Thiamine 500 mg IV AVANT glucose', 'Thiamine 500 mg IV BEFORE glucose'),
        ],
        warning: LString('Thiamine avant glucose = prévention Gayet-Wernicke', 'Thiamine before glucose = Wernicke prevention'),
      ),
      ProtocolStep(
        title: LString('4. Examens complémentaires', '4. Investigations'),
        content: LString('Bilan minimal.', 'Minimal workup.'),
        bulletPoints: [
          LString('Glycémie capillaire', 'Point-of-care glucose'),
          LString('Alcoolémie', 'Blood alcohol level'),
          LString('Iono, créat (déshydratation)', 'Electrolytes, creatinine (dehydration)'),
          LString('Scanner si trauma ou coma inexpliqué', 'CT scan if trauma or unexplained coma'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Surveillance', '5. Monitoring'),
        content: LString('Jusqu\'à dégrisement.', 'Until sobriety.'),
        bulletPoints: [
          LString('Surveillance GCS toutes les heures', 'GCS monitoring every hour'),
          LString('Prévention risque suicidaire', 'Suicide risk prevention'),
          LString('Évaluation psychiatrique si IMV', 'Psychiatric assessment if intentional'),
          LString('Information sur risques, orientation addictologie', 'Risk information, addiction referral'),
        ],
      ),
    ],
    keyPoints: LString('Éliminer TC et hypoglycémie. Thiamine AVANT glucose. PLS et surveillance jusqu\'à dégrisement.', 'Rule out TBI and hypoglycemia. Thiamine BEFORE glucose. Recovery position and monitoring until sober.'),
    source: LString('SFMU - Urgences et alcool', 'SFMU - Urgences et alcool'),
    lastUpdated: 2019,
  ),

  // Syndrome sérotoninergique
  Protocol(
    id: 'syndrome-serotoninergique',
    name: LString('Syndrome Sérotoninergique', 'Serotonin Syndrome'),
    category: ProtocolCategory.toxicology,
    description: LString('Excès de sérotonine - urgence thérapeutique', 'Serotonin excess - therapeutic emergency'),
    indication: LString('Triade: troubles neurocognitifs + dysautonomie + anomalies neuromusculaires', 'Triad: neurocognitive changes + autonomic dysregulation + neuromuscular abnormalities'),
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Recognition'),
        content: LString('Critères de Hunter.', 'Hunter criteria.'),
        bulletPoints: [
          LString('Prise sérotoninergique + UN des critères suivants:', 'Serotonergic agent + ONE of the following:'),
          LString('Clonus spontané', 'Spontaneous clonus'),
          LString('Clonus inductible + agitation/diaphorèse', 'Inducible clonus + agitation/diaphoresis'),
          LString('Tremor + hyperréflexie', 'Tremor + hyperreflexia'),
          LString('Hypertonie + T > 38°C + clonus/myoclonies', 'Hypertonia + T > 38°C + clonus/myoclonus'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Médicaments en cause', '2. Causative agents'),
        content: LString('Identifier les agents.', 'Identify the agents.'),
        bulletPoints: [
          LString('ISRS, IRSN, antidépresseurs tricycliques', 'SSRIs, SNRIs, tricyclic antidepressants'),
          LString('IMAO', 'MAOIs'),
          LString('Tramadol, fentanyl', 'Tramadol, fentanyl'),
          LString('Triptans, lithium', 'Triptans, lithium'),
          LString('MDMA, amphétamines', 'MDMA, amphetamines'),
          LString('Linézolide, bleu de méthylène', 'Linezolid, methylene blue'),
        ],
        tip: LString('Souvent surdosage ou association de sérotoninergiques', 'Often overdose or combination of serotonergic agents'),
      ),
      ProtocolStep(
        title: LString('3. Arrêt des agents', '3. Discontinuation of agents'),
        content: LString('Première mesure.', 'First measure.'),
        bulletPoints: [
          LString('Arrêter tous les agents sérotoninergiques', 'Stop all serotonergic agents'),
          LString('Amélioration habituelle en 24h', 'Usual improvement within 24h'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Traitement symptomatique', '4. Symptomatic treatment'),
        content: LString('Selon sévérité.', 'According to severity.'),
        bulletPoints: [
          LString('Léger: surveillance, benzodiazépines (agitation)', 'Mild: monitoring, benzodiazepines (agitation)'),
          LString('Modéré: refroidissement, BZD, réhydratation', 'Moderate: cooling, BZD, rehydration'),
          LString('Sévère: IOT, sédation, curarisation si hyperthermie majeure', 'Severe: ETI, sedation, neuromuscular blockade if major hyperthermia'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Antidote', '5. Antidote'),
        content: LString('Cyproheptadine.', 'Cyproheptadine.'),
        bulletPoints: [
          LString('Cyproheptadine (Périactine) 12 mg PO puis 4 mg/4h', 'Cyproheptadine (Periactin) 12 mg PO then 4 mg/4h'),
          LString('Anti-sérotoninergique', 'Anti-serotonergic'),
          LString('Non disponible en IV', 'Not available IV'),
          LString('Alternative: chlorpromazine 50-100 mg IM', 'Alternative: chlorpromazine 50-100 mg IM'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Diagnostic différentiel', '6. Differential diagnosis'),
        content: LString('Éliminer autres causes.', 'Rule out other causes.'),
        bulletPoints: [
          LString('Syndrome malin des neuroleptiques (rigidité > clonus)', 'Neuroleptic malignant syndrome (rigidity > clonus)'),
          LString('Hyperthermie maligne', 'Malignant hyperthermia'),
          LString('Syndrome anticholinergique', 'Anticholinergic syndrome'),
          LString('Infection, état de mal', 'Infection, status epilepticus'),
        ],
      ),
    ],
    keyPoints: LString('Arrêt des sérotoninergiques + BZD + refroidissement. Cyproheptadine si modéré/sévère.', 'Stop serotonergic agents + BZD + cooling. Cyproheptadine if moderate/severe.'),
    source: LString('Toxicologie clinique - Syndrome sérotoninergique', 'Toxicologie clinique - Syndrome sérotoninergique'),
    lastUpdated: 2020,
  ),

  // Antidotes
  Protocol(
    id: 'antidotes',
    name: LString('Principaux Antidotes', 'Main Antidotes'),
    category: ProtocolCategory.toxicology,
    description: LString('Antidotes des principales intoxications', 'Antidotes for major poisonings'),
    indication: LString('Intoxication identifiée avec antidote disponible', 'Identified poisoning with available antidote'),
    steps: [
      ProtocolStep(
        title: LString('Paracétamol → N-acétylcystéine', 'Acetaminophen → N-acetylcysteine'),
        content: LString('Protocole court ou long.', 'Short or long protocol.'),
        bulletPoints: [
          LString('Indication selon nomogramme de Rumack-Matthew', 'Indication per Rumack-Matthew nomogram'),
          LString('Protocole IV: 150 mg/kg/15min puis 50 mg/kg/4h puis 100 mg/kg/16h', 'IV protocol: 150 mg/kg/15min then 50 mg/kg/4h then 100 mg/kg/16h'),
          LString('Efficace si < 8h, efficacité diminuée après', 'Effective if < 8h, reduced efficacy after'),
        ],
      ),
      ProtocolStep(
        title: LString('Opioïdes → Naloxone', 'Opioids → Naloxone'),
        content: LString('Antagoniste µ.', 'µ-receptor antagonist.'),
        bulletPoints: [
          LString('Bolus 0.4 mg IV, répétable toutes les 2-3 min', 'Bolus 0.4 mg IV, repeatable every 2-3 min'),
          LString('Titration jusqu\'à FR > 12/min', 'Titrate until RR > 12/min'),
          LString('Attention durée d\'action courte (45 min)', 'Caution: short duration of action (45 min)'),
          LString('IVSE si opioïde longue durée', 'Continuous infusion if long-acting opioid'),
        ],
      ),
      ProtocolStep(
        title: LString('Benzodiazépines → Flumazénil', 'Benzodiazepines → Flumazenil'),
        content: LString('Utilisation restreinte.', 'Restricted use.'),
        bulletPoints: [
          LString('Flumazénil 0.2 mg IV, puis 0.1 mg/min jusqu\'à réveil', 'Flumazenil 0.2 mg IV, then 0.1 mg/min until awakening'),
          LString('CI: épilepsie, co-ingestion tricycliques', 'CI: epilepsy, co-ingestion of tricyclics'),
          LString('Risque convulsions si sevrage BZD', 'Seizure risk if BZD withdrawal'),
        ],
        warning: LString('Prudence extrême - risque convulsions', 'Extreme caution - seizure risk'),
      ),
      ProtocolStep(
        title: LString('Stabilisants de membrane → Bicarbonates', 'Sodium channel blockers → Bicarbonate'),
        content: LString('Alcalinisation.', 'Alkalinization.'),
        bulletPoints: [
          LString('Bicarbonate de sodium 84‰ molaire', 'Hypertonic sodium bicarbonate 8.4%'),
          LString('Bolus 1-2 mEq/kg si QRS > 100 ms', 'Bolus 1-2 mEq/kg if QRS > 100 ms'),
          LString('Objectif pH 7.50-7.55', 'Target pH 7.50-7.55'),
          LString('Indications: tricycliques, cocaïne, chloroquine...', 'Indications: tricyclics, cocaine, chloroquine...'),
        ],
      ),
      ProtocolStep(
        title: LString('Digitaliques → Anticorps anti-digoxine', 'Digoxin → Anti-digoxin antibodies'),
        content: LString('Fab anti-digitale.', 'Anti-digitalis Fab.'),
        bulletPoints: [
          LString('Digibind ou DigiFab', 'Digibind or DigiFab'),
          LString('Indications: arythmies, kaliémie > 5.5, choc', 'Indications: arrhythmias, potassium > 5.5, shock'),
          LString('Dose selon digoxinémie ou empirique 6-10 flacons', 'Dose per digoxin level or empiric 6-10 vials'),
        ],
      ),
      ProtocolStep(
        title: LString('Méthanol/Éthylène glycol → Fomépizole', 'Methanol/Ethylene glycol → Fomepizole'),
        content: LString('Inhibiteur ADH.', 'ADH inhibitor.'),
        bulletPoints: [
          LString('Fomépizole 15 mg/kg charge puis 10 mg/kg/12h', 'Fomepizole 15 mg/kg load then 10 mg/kg/12h'),
          LString('Alternative: éthanol IV (alcoolémie cible 1g/L)', 'Alternative: IV ethanol (target BAL 1g/L)'),
          LString('Hémodialyse si acidose sévère ou IRA', 'Hemodialysis if severe acidosis or AKI'),
        ],
      ),
      ProtocolStep(
        title: LString('Autres antidotes importants', 'Other important antidotes'),
        content: LString('Liste non exhaustive.', 'Non-exhaustive list.'),
        bulletPoints: [
          LString('Cyanures: Hydroxocobalamine (Cyanokit)', 'Cyanide: Hydroxocobalamin (Cyanokit)'),
          LString('Bêta-bloquants: Glucagon 5-10 mg IV', 'Beta-blockers: Glucagon 5-10 mg IV'),
          LString('Calcium-bloqueurs: Calcium + glucagon + insuline', 'Calcium channel blockers: Calcium + glucagon + insulin'),
          LString('Fer: Déféroxamine', 'Iron: Deferoxamine'),
          LString('Organophosphorés: Atropine + Pralidoxime', 'Organophosphates: Atropine + Pralidoxime'),
        ],
      ),
    ],
    keyPoints: LString('Chaque antidote a des indications précises. Centre antipoison disponible 24h/24.', 'Each antidote has specific indications. Poison control center available 24/7.'),
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
    name: LString('Acidocétose Diabétique', 'Diabetic Ketoacidosis'),
    category: ProtocolCategory.metabolic,
    description: LString('Décompensation métabolique du diabète avec cétose', 'Metabolic decompensation of diabetes with ketosis'),
    indication: LString('Glycémie > 2.5 g/L + pH < 7.3 + cétonémie > 3 mmol/L ou cétonurie ++', 'Blood glucose > 2.5 g/L + pH < 7.3 + ketonemia > 3 mmol/L or ketonuria ++'),
    steps: [
      ProtocolStep(
        title: LString('1. Diagnostic', '1. Diagnosis'),
        content: LString('Critères diagnostiques.', 'Diagnostic criteria.'),
        bulletPoints: [
          LString('Glycémie > 2.5 g/L (souvent > 3 g/L)', 'Blood glucose > 2.5 g/L (often > 3 g/L)'),
          LString('pH < 7.3 et/ou bicarbonates < 18 mmol/L', 'pH < 7.3 and/or bicarbonate < 18 mmol/L'),
          LString('Cétonémie > 3 mmol/L ou cétonurie ≥ ++', 'Ketonemia > 3 mmol/L or ketonuria ≥ ++'),
          LString('Trou anionique augmenté', 'Elevated anion gap'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Gravité', '2. Severity'),
        content: LString('Stratification.', 'Stratification.'),
        bulletPoints: [
          LString('Légère: pH 7.25-7.30, GCS normal', 'Mild: pH 7.25-7.30, normal GCS'),
          LString('Modérée: pH 7.00-7.24, GCS normal', 'Moderate: pH 7.00-7.24, normal GCS'),
          LString('Sévère: pH < 7.00, troubles conscience', 'Severe: pH < 7.00, altered consciousness'),
          LString('Critères USI: pH < 7.1, confusion, choc', 'ICU criteria: pH < 7.1, confusion, shock'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Remplissage vasculaire', '3. Fluid resuscitation'),
        content: LString('Priorité = réhydratation.', 'Priority = rehydration.'),
        bulletPoints: [
          LString('NaCl 0.9%: 1L/h pendant 2h puis 500 mL/h', 'NaCl 0.9%: 1L/h for 2h then 500 mL/h'),
          LString('Déficit hydrique 5-10 L en moyenne', 'Average fluid deficit 5-10 L'),
          LString('Relais G5% quand glycémie < 2.5 g/L', 'Switch to D5W when glucose < 2.5 g/L'),
          LString('Adapter si insuffisance cardiaque', 'Adjust if heart failure'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Insulinothérapie', '4. Insulin therapy'),
        content: LString('Après début du remplissage.', 'After starting fluids.'),
        bulletPoints: [
          LString('Insuline rapide IVSE 0.1 UI/kg/h', 'Rapid insulin infusion 0.1 IU/kg/h'),
          LString('Objectif: baisse glycémie 0.5-0.7 g/L/h', 'Target: glucose decrease 0.5-0.7 g/L/h'),
          LString('Maintenir IVSE tant que cétonémie > 0.5 mmol/L', 'Maintain infusion while ketonemia > 0.5 mmol/L'),
          LString('Ne pas arrêter insuline si glycémie basse: ajuster G5%', 'Do not stop insulin if glucose low: adjust D5W'),
        ],
        warning: LString('Ne pas arrêter insuline même si glycémie normale tant que cétose', 'Do not stop insulin even if glucose normal while ketosis persists'),
      ),
      ProtocolStep(
        title: LString('5. Potassium', '5. Potassium'),
        content: LString('Surveillance et supplémentation.', 'Monitoring and supplementation.'),
        bulletPoints: [
          LString('K+ souvent normal ou haut initialement malgré déficit total', 'K+ often normal or high initially despite total body deficit'),
          LString('Si K+ < 3.3 mmol/L: différer insuline, supplémenter d\'abord', 'If K+ < 3.3 mmol/L: defer insulin, supplement first'),
          LString('Si K+ 3.3-5.3: KCl 20-40 mEq/L de perfusion', 'If K+ 3.3-5.3: KCl 20-40 mEq/L of infusion'),
          LString('Si K+ > 5.3: pas de supplément, surveillance', 'If K+ > 5.3: no supplement, monitor'),
        ],
        warning: LString('Kaliémie peut chuter brutalement sous insuline', 'Potassium may drop abruptly with insulin'),
      ),
      ProtocolStep(
        title: LString('6. Bicarbonates', '6. Bicarbonate'),
        content: LString('Indications très limitées.', 'Very limited indications.'),
        bulletPoints: [
          LString('Seulement si pH < 6.9 (controversé)', 'Only if pH < 6.9 (controversial)'),
          LString('Pas de bénéfice prouvé si pH > 7.0', 'No proven benefit if pH > 7.0'),
          LString('Si utilisé: 100 mmol + 20 mEq KCl en 2h', 'If used: 100 mmol + 20 mEq KCl over 2h'),
        ],
      ),
      ProtocolStep(
        title: LString('7. Rechercher facteur déclenchant', '7. Identify precipitant'),
        content: LString('Toujours.', 'Always.'),
        bulletPoints: [
          LString('Infection (NFS, CRP, ECBU, radio thorax)', 'Infection (CBC, CRP, urine culture, chest X-ray)'),
          LString('Infarctus du myocarde (ECG, troponine)', 'Myocardial infarction (ECG, troponin)'),
          LString('Arrêt ou mauvaise observance insuline', 'Insulin discontinuation or poor compliance'),
          LString('Nouveau diabète', 'New-onset diabetes'),
        ],
      ),
    ],
    keyPoints: LString('Remplissage prioritaire. Insuline IVSE 0.1 UI/kg/h. K+ surveillance rapprochée. Traiter la cause.', 'Fluid resuscitation priority. Insulin infusion 0.1 IU/kg/h. Close K+ monitoring. Treat the cause.'),
    source: LString('ADA Standards 2024, SFD', 'ADA Standards 2024, SFD'),
    lastUpdated: 2024,
  ),

  // État hyperosmolaire
  Protocol(
    id: 'etat-hyperosmolaire',
    name: LString('État Hyperosmolaire Hyperglycémique', 'Hyperosmolar Hyperglycemic State'),
    category: ProtocolCategory.metabolic,
    description: LString('Décompensation hyperglycémique sans cétose majeure', 'Hyperglycemic decompensation without significant ketosis'),
    indication: LString('Glycémie > 6 g/L + Osmolarité > 320 mOsm/kg + absence cétose significative', 'Blood glucose > 6 g/L + Osmolality > 320 mOsm/kg + no significant ketosis'),
    steps: [
      ProtocolStep(
        title: LString('1. Caractéristiques', '1. Characteristics'),
        content: LString('Différences avec acidocétose.', 'Differences from DKA.'),
        bulletPoints: [
          LString('Patient souvent âgé, diabète type 2', 'Often elderly patient, type 2 diabetes'),
          LString('Glycémie très élevée (souvent > 6 g/L)', 'Very high glucose (often > 6 g/L)'),
          LString('Osmolarité > 320 mOsm/kg', 'Osmolality > 320 mOsm/kg'),
          LString('Déshydratation majeure (déficit 8-12 L)', 'Major dehydration (deficit 8-12 L)'),
          LString('Pas ou peu de cétose (pH > 7.30)', 'No or minimal ketosis (pH > 7.30)'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Réhydratation', '2. Rehydration'),
        content: LString('Objectif principal.', 'Primary goal.'),
        bulletPoints: [
          LString('NaCl 0.9% initialement: 1-1.5 L/h les 2 premières heures', 'NaCl 0.9% initially: 1-1.5 L/h for first 2 hours'),
          LString('Puis adapter selon natrémie corrigée et état HD', 'Then adjust per corrected sodium and hemodynamics'),
          LString('Si Na corrigée > 145: NaCl 0.45%', 'If corrected Na > 145: NaCl 0.45%'),
          LString('Correction lente: 10% déficit les 2 premières heures', 'Slow correction: 10% of deficit in first 2 hours'),
          LString('Reste sur 24-48h', 'Remainder over 24-48h'),
        ],
        warning: LString('Réhydratation trop rapide = risque œdème cérébral', 'Too-rapid rehydration = cerebral edema risk'),
      ),
      ProtocolStep(
        title: LString('3. Insulinothérapie', '3. Insulin therapy'),
        content: LString('Secondaire au remplissage.', 'Secondary to fluid resuscitation.'),
        bulletPoints: [
          LString('Débuter après 1-2h de remplissage', 'Start after 1-2h of fluids'),
          LString('Doses plus faibles: 0.05 UI/kg/h', 'Lower doses: 0.05 IU/kg/h'),
          LString('Objectif: baisse glycémie progressive', 'Target: gradual glucose decrease'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Potassium', '4. Potassium'),
        content: LString('Même vigilance que acidocétose.', 'Same vigilance as DKA.'),
        bulletPoints: [
          LString('Supplémentation selon kaliémie', 'Supplementation per potassium level'),
          LString('Surveillance rapprochée', 'Close monitoring'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Anticoagulation', '5. Anticoagulation'),
        content: LString('Prévention thrombose.', 'Thrombosis prevention.'),
        bulletPoints: [
          LString('Risque thromboembolique élevé', 'High thromboembolic risk'),
          LString('HBPM préventive systématique', 'Routine prophylactic LMWH'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Facteur déclenchant', '6. Precipitant'),
        content: LString('Infection fréquente.', 'Infection common.'),
        bulletPoints: [
          LString('Infection (50% des cas)', 'Infection (50% of cases)'),
          LString('Déshydratation, diarrhées', 'Dehydration, diarrhea'),
          LString('Médicaments (corticoïdes, diurétiques)', 'Medications (corticosteroids, diuretics)'),
          LString('AVC, IDM', 'Stroke, MI'),
        ],
      ),
    ],
    keyPoints: LString('Réhydratation massive mais progressive. Insuline après remplissage. Anticoagulation préventive.', 'Massive but gradual rehydration. Insulin after fluids. Prophylactic anticoagulation.'),
    source: LString('ADA Standards 2024', 'ADA Standards 2024'),
    lastUpdated: 2024,
  ),

  // Hyperkaliémie
  Protocol(
    id: 'hyperkaliemie',
    name: LString('Hyperkaliémie', 'Hyperkalemia'),
    category: ProtocolCategory.metabolic,
    description: LString('Kaliémie > 5.5 mmol/L', 'Potassium > 5.5 mmol/L'),
    indication: LString('K+ > 5.5 mmol/L et/ou signes ECG d\'hyperkaliémie', 'K+ > 5.5 mmol/L and/or ECG signs of hyperkalemia'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation gravité', '1. Severity assessment'),
        content: LString('Clinique et ECG.', 'Clinical and ECG.'),
        bulletPoints: [
          LString('Légère: 5.5-6.0 mmol/L, ECG normal', 'Mild: 5.5-6.0 mmol/L, normal ECG'),
          LString('Modérée: 6.0-6.5 mmol/L, ondes T pointues', 'Moderate: 6.0-6.5 mmol/L, peaked T waves'),
          LString('Sévère: > 6.5 mmol/L ou signes ECG majeurs', 'Severe: > 6.5 mmol/L or major ECG changes'),
          LString('ECG: ondes T amples, QRS large, bradycardie, FV', 'ECG: tall T waves, wide QRS, bradycardia, VF'),
        ],
        warning: LString('Toute hyperkaliémie symptomatique = urgence vitale', 'Any symptomatic hyperkalemia = life-threatening emergency'),
      ),
      ProtocolStep(
        title: LString('2. Protection myocardique', '2. Myocardial protection'),
        content: LString('Si ECG anormal ou K+ > 6.5.', 'If abnormal ECG or K+ > 6.5.'),
        bulletPoints: [
          LString('Gluconate de calcium 10%: 10-20 mL IV en 2-5 min', 'Calcium gluconate 10%: 10-20 mL IV over 2-5 min'),
          LString('Effet immédiat mais transitoire (30-60 min)', 'Immediate but transient effect (30-60 min)'),
          LString('Répétable si persistance anomalies ECG', 'Repeatable if ECG abnormalities persist'),
          LString('Ne modifie pas la kaliémie', 'Does not change potassium level'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Transfert intracellulaire', '3. Intracellular shift'),
        content: LString('Réduire la kaliémie.', 'Lower potassium.'),
        bulletPoints: [
          LString('Insuline 10 UI + G30% 50 mL IV (effet en 15-30 min)', 'Insulin 10 IU + D30% 50 mL IV (effect in 15-30 min)'),
          LString('Salbutamol nébulisé 10-20 mg (4-8 bouffées)', 'Nebulized salbutamol 10-20 mg (4-8 puffs)'),
          LString('Bicarbonates si acidose métabolique associée', 'Bicarbonate if associated metabolic acidosis'),
          LString('Effet transitoire: 2-6 heures', 'Transient effect: 2-6 hours'),
        ],
        tip: LString('Surveiller glycémie après insuline-glucose', 'Monitor glucose after insulin-dextrose'),
      ),
      ProtocolStep(
        title: LString('4. Élimination du potassium', '4. Potassium elimination'),
        content: LString('Réduction du pool total.', 'Total body potassium reduction.'),
        bulletPoints: [
          LString('Furosémide 40-80 mg IV si fonction rénale conservée', 'Furosemide 40-80 mg IV if renal function preserved'),
          LString('Résines échangeuses: Kayexalate 30-60g PO ou lavement', 'Exchange resins: Kayexalate 30-60g PO or enema'),
          LString('Patiromer ou SZC (nouveaux chélateurs)', 'Patiromer or SZC (newer binders)'),
          LString('Hémodialyse si sévère ou IRA anurique', 'Hemodialysis if severe or anuric AKI'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Traiter la cause', '5. Treat the cause'),
        content: LString('Étiologie.', 'Etiology.'),
        bulletPoints: [
          LString('Insuffisance rénale', 'Renal failure'),
          LString('Médicaments (IEC, ARA2, spironolactone, AINS)', 'Medications (ACEi, ARB, spironolactone, NSAIDs)'),
          LString('Acidose', 'Acidosis'),
          LString('Rhabdomyolyse, lyse tumorale', 'Rhabdomyolysis, tumor lysis'),
          LString('Insuffisance surrénale', 'Adrenal insufficiency'),
        ],
      ),
    ],
    keyPoints: LString('ECG systématique. Calcium si signes ECG. Insuline-glucose pour baisser K+. Dialyse si sévère.', 'Routine ECG. Calcium if ECG changes. Insulin-dextrose to lower K+. Dialysis if severe.'),
    source: LString('KDIGO, HAS', 'KDIGO, HAS'),
    lastUpdated: 2022,
  ),

  // Hyponatrémie
  Protocol(
    id: 'hyponatremie',
    name: LString('Hyponatrémie', 'Hyponatremia'),
    category: ProtocolCategory.metabolic,
    description: LString('Natrémie < 135 mmol/L', 'Sodium < 135 mmol/L'),
    indication: LString('Na+ < 135 mmol/L et/ou symptômes neurologiques', 'Na+ < 135 mmol/L and/or neurological symptoms'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation', '1. Assessment'),
        content: LString('Gravité et chronologie.', 'Severity and chronicity.'),
        bulletPoints: [
          LString('Aiguë (< 48h) vs chronique (> 48h ou inconnue)', 'Acute (< 48h) vs chronic (> 48h or unknown)'),
          LString('Légère: 130-135 mmol/L', 'Mild: 130-135 mmol/L'),
          LString('Modérée: 125-129 mmol/L', 'Moderate: 125-129 mmol/L'),
          LString('Sévère: < 125 mmol/L', 'Severe: < 125 mmol/L'),
          LString('Symptômes: céphalées, confusion, convulsions, coma', 'Symptoms: headaches, confusion, seizures, coma'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Hyponatrémie symptomatique sévère', '2. Severe symptomatic hyponatremia'),
        content: LString('Urgence thérapeutique.', 'Therapeutic emergency.'),
        bulletPoints: [
          LString('NaCl 3%: 100-150 mL en 20 min', '3% NaCl: 100-150 mL over 20 min'),
          LString('Répétable 2-3 fois si symptômes persistent', 'Repeatable 2-3 times if symptoms persist'),
          LString('Objectif initial: ↑ Na+ de 4-6 mmol/L', 'Initial target: ↑ Na+ by 4-6 mmol/L'),
          LString('Limite: ↑ < 10 mmol/L/24h (< 8 si chronique)', 'Limit: ↑ < 10 mmol/L/24h (< 8 if chronic)'),
        ],
        warning: LString('Correction trop rapide = myélinolyse centropontine', 'Too-rapid correction = osmotic demyelination syndrome'),
      ),
      ProtocolStep(
        title: LString('3. Classification étiologique', '3. Etiological classification'),
        content: LString('Selon volémie.', 'By volume status.'),
        bulletPoints: [
          LString('Hypovolémique: déshydratation, diurétiques, pertes digestives', 'Hypovolemic: dehydration, diuretics, GI losses'),
          LString('Euvolémique: SIADH, hypothyroïdie, insuffisance surrénale', 'Euvolemic: SIADH, hypothyroidism, adrenal insufficiency'),
          LString('Hypervolémique: insuffisance cardiaque, cirrhose, IRC', 'Hypervolemic: heart failure, cirrhosis, CKD'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Traitement selon cause', '4. Treatment by cause'),
        content: LString('Adapter au mécanisme.', 'Adapt to mechanism.'),
        bulletPoints: [
          LString('Hypovolémique: NaCl 0.9%', 'Hypovolemic: NaCl 0.9%'),
          LString('SIADH: restriction hydrique ± urée ± tolvaptan', 'SIADH: fluid restriction ± urea ± tolvaptan'),
          LString('Hypervolémique: restriction hydrique + diurétiques', 'Hypervolemic: fluid restriction + diuretics'),
          LString('Arrêt médicaments causaux', 'Stop causative medications'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Surveillance', '5. Monitoring'),
        content: LString('Contrôles rapprochés.', 'Frequent checks.'),
        bulletPoints: [
          LString('Natrémie toutes les 2-4h initialement', 'Sodium every 2-4h initially'),
          LString('Diurèse horaire', 'Hourly urine output'),
          LString('Si surcorrection: abaisser Na+ (G5%, desmopressine)', 'If overcorrection: lower Na+ (D5W, desmopressin)'),
        ],
      ),
    ],
    keyPoints: LString('Symptomatique sévère = NaCl 3%. Correction lente si chronique (< 10/24h). Traiter selon volémie.', 'Severe symptomatic = 3% NaCl. Slow correction if chronic (< 10/24h). Treat by volume status.'),
    source: LString('ESE 2014 - Hyponatremia', 'ESE 2014 - Hyponatremia'),
    lastUpdated: 2014,
  ),

  // Hypoglycémie
  Protocol(
    id: 'hypoglycemie',
    name: LString('Hypoglycémie', 'Hypoglycemia'),
    category: ProtocolCategory.metabolic,
    description: LString('Glycémie < 0.70 g/L avec ou sans symptômes', 'Blood glucose < 0.70 g/L with or without symptoms'),
    indication: LString('Glycémie < 0.70 g/L ou symptômes neuroglycopéniques', 'Blood glucose < 0.70 g/L or neuroglycopenic symptoms'),
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Recognition'),
        content: LString('Signes cliniques.', 'Clinical signs.'),
        bulletPoints: [
          LString('Neuroglycopéniques: confusion, troubles visuels, convulsions, coma', 'Neuroglycopenic: confusion, visual disturbances, seizures, coma'),
          LString('Adrénergiques: sueurs, tremblements, palpitations, faim', 'Adrenergic: sweating, tremor, palpitations, hunger'),
          LString('Seuil variable selon patients (diabétiques ++)', 'Variable threshold per patient (diabetics ++)'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Patient conscient', '2. Conscious patient'),
        content: LString('Resucrage oral.', 'Oral glucose.'),
        bulletPoints: [
          LString('15-20g de glucides rapides', '15-20g of fast-acting carbohydrates'),
          LString('3-4 morceaux de sucre ou jus de fruits', '3-4 sugar cubes or fruit juice'),
          LString('Recontrôle à 15 min', 'Recheck at 15 min'),
          LString('Répéter si glycémie toujours basse', 'Repeat if glucose still low'),
          LString('Puis collation avec sucres lents', 'Then snack with complex carbohydrates'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Patient inconscient ou ne pouvant avaler', '3. Unconscious patient or unable to swallow'),
        content: LString('Resucrage parentéral.', 'Parenteral glucose.'),
        bulletPoints: [
          LString('G30%: 20-40 mL IV (ou 50 mL G50%)', 'D30%: 20-40 mL IV (or 50 mL D50%)'),
          LString('ou Glucagon 1 mg IM/SC (si pas d\'accès IV)', 'or Glucagon 1 mg IM/SC (if no IV access)'),
          LString('Relais perfusion G10% après réveil', 'Maintenance D10% infusion after awakening'),
          LString('Glucagon moins efficace si réserves glycogène épuisées', 'Glucagon less effective if glycogen stores depleted'),
        ],
        warning: LString('Glucagon inefficace si intoxication alcoolique ou jeûne prolongé', 'Glucagon ineffective in alcohol intoxication or prolonged fasting'),
      ),
      ProtocolStep(
        title: LString('4. Causes à rechercher', '4. Causes to investigate'),
        content: LString('Étiologie.', 'Etiology.'),
        bulletPoints: [
          LString('Diabétique: insuline, sulfamides (surdosage, jeûne)', 'Diabetic: insulin, sulfonylureas (overdose, fasting)'),
          LString('Non diabétique: alcool, insuffisance surrénale', 'Non-diabetic: alcohol, adrenal insufficiency'),
          LString('Insuffisance hépatique, insuffisance rénale', 'Liver failure, renal failure'),
          LString('Insulinome, tumeurs', 'Insulinoma, tumors'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Surveillance et prévention', '5. Monitoring and prevention'),
        content: LString('Éviter récidive.', 'Prevent recurrence.'),
        bulletPoints: [
          LString('Surveillance glycémique rapprochée', 'Close glucose monitoring'),
          LString('Durée surveillance selon cause (sulfamides: 24-48h)', 'Monitoring duration per cause (sulfonylureas: 24-48h)'),
          LString('Éducation patient et entourage', 'Patient and family education'),
          LString('Adapter traitement antidiabétique', 'Adjust antidiabetic therapy'),
        ],
      ),
    ],
    keyPoints: LString('G30% IV si inconscient. Glucagon si pas d\'accès. Rechercher cause. Surveillance prolongée si sulfamides.', 'D30% IV if unconscious. Glucagon if no access. Investigate cause. Prolonged monitoring if sulfonylureas.'),
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
    name: LString('ACR Pédiatrique', 'Pediatric Cardiac Arrest'),
    category: ProtocolCategory.pediatric,
    description: LString('Arrêt cardiorespiratoire de l\'enfant selon ERC 2021', 'Pediatric cardiac arrest per ERC 2021 guidelines'),
    indication: LString('Enfant en arrêt cardiaque (absence de signes de vie)', 'Child in cardiac arrest (no signs of life)'),
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Recognition'),
        content: LString('Identifier l\'ACR.', 'Identify cardiac arrest.'),
        bulletPoints: [
          LString('Absence de réponse à stimulation', 'Unresponsive to stimulation'),
          LString('Absence de respiration normale (gasps = arrêt)', 'No normal breathing (gasps = arrest)'),
          LString('Pas de pouls perçu en 10 secondes (optionnel)', 'No pulse felt within 10 seconds (optional)'),
          LString('Alerter les secours (15/112)', 'Alert emergency services (15/112)'),
        ],
      ),
      ProtocolStep(
        title: LString('2. RCP de base', '2. Basic CPR'),
        content: LString('Commencer immédiatement.', 'Start immediately.'),
        bulletPoints: [
          LString('Commencer par 5 insufflations', 'Start with 5 rescue breaths'),
          LString('Puis MCE: 100-120/min', 'Then compressions: 100-120/min'),
          LString('Profondeur: 1/3 du thorax (4 cm nourrisson, 5 cm enfant)', 'Depth: 1/3 of chest (4 cm infant, 5 cm child)'),
          LString('Ratio 15:2 (si 2 secouristes professionnels)', 'Ratio 15:2 (if 2 professional rescuers)'),
          LString('Ratio 30:2 si seul', '30:2 ratio if alone'),
        ],
        tip: LString('5 insufflations d\'abord car cause souvent respiratoire chez l\'enfant', '5 breaths first because cause is often respiratory in children'),
      ),
      ProtocolStep(
        title: LString('3. Défibrillation', '3. Defibrillation'),
        content: LString('Dès que DSA disponible.', 'As soon as AED available.'),
        bulletPoints: [
          LString('Électrodes pédiatriques si < 8 ans ou < 25 kg', 'Pediatric pads if < 8 years or < 25 kg'),
          LString('Choc 4 J/kg', 'Shock 4 J/kg'),
          LString('Reprendre MCE immédiatement après choc', 'Resume compressions immediately after shock'),
          LString('Analyser toutes les 2 minutes', 'Analyze every 2 minutes'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Voies d\'administration', '4. Vascular access'),
        content: LString('Accès vasculaire.', 'Vascular access.'),
        bulletPoints: [
          LString('VVP en première intention', 'Peripheral IV first-line'),
          LString('Voie intra-osseuse si échec (< 60 sec)', 'Intraosseous if failed (< 60 sec)'),
          LString('Sites IO: tibia proximal, fémur distal', 'IO sites: proximal tibia, distal femur'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Adrénaline', '5. Epinephrine'),
        content: LString('Doses pédiatriques.', 'Pediatric doses.'),
        bulletPoints: [
          LString('10 µg/kg IV/IO (0.1 mL/kg adrénaline 1/10000)', '10 µg/kg IV/IO (0.1 mL/kg epinephrine 1:10,000)'),
          LString('Rythme non choquable: dès que possible', 'Non-shockable rhythm: as soon as possible'),
          LString('Rythme choquable: après 3ème choc', 'Shockable rhythm: after 3rd shock'),
          LString('Répéter toutes les 3-5 min', 'Repeat every 3-5 min'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Amiodarone', '6. Amiodarone'),
        content: LString('Si FV/TV réfractaire.', 'If refractory VF/VT.'),
        bulletPoints: [
          LString('5 mg/kg après le 3ème choc', '5 mg/kg after 3rd shock'),
          LString('Répéter 5 mg/kg après 5ème choc', 'Repeat 5 mg/kg after 5th shock'),
        ],
      ),
      ProtocolStep(
        title: LString('7. Causes réversibles', '7. Reversible causes'),
        content: LString('4H et 4T pédiatriques.', 'Pediatric 4H and 4T.'),
        bulletPoints: [
          LString('Hypoxie (cause la plus fréquente)', 'Hypoxia (most common cause)'),
          LString('Hypovolémie', 'Hypovolemia'),
          LString('Hypo/hyperkaliémie, hypoglycémie', 'Hypo/hyperkalemia, hypoglycemia'),
          LString('Hypothermie', 'Hypothermia'),
          LString('Tamponnade', 'Tamponade'),
          LString('Tension pneumothorax', 'Tension pneumothorax'),
          LString('Thrombose (EP rare chez enfant)', 'Thrombosis (PE rare in children)'),
          LString('Toxiques', 'Toxins'),
        ],
      ),
    ],
    keyPoints: LString('5 insufflations d\'abord. MCE 15:2. Adrénaline 10 µg/kg. Cause souvent respiratoire.', '5 breaths first. Compressions 15:2. Epinephrine 10 µg/kg. Cause often respiratory.'),
    source: LString('ERC Guidelines 2021 - Pediatric Life Support', 'ERC Guidelines 2021 - Pediatric Life Support'),
    sourceUrl: 'https://www.erc.edu',
    lastUpdated: 2021,
  ),

  // Bronchiolite
  Protocol(
    id: 'bronchiolite',
    name: LString('Bronchiolite Aiguë', 'Acute Bronchiolitis'),
    category: ProtocolCategory.pediatric,
    description: LString('Infection virale des voies aériennes inférieures du nourrisson', 'Viral lower respiratory tract infection in infants'),
    indication: LString('Nourrisson < 12 mois avec dyspnée sifflante et signes de lutte', 'Infant < 12 months with wheezing and respiratory distress'),
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: LString('1. Diagnostic clinique', '1. Clinical diagnosis'),
        content: LString('Reconnaître la bronchiolite.', 'Recognize bronchiolitis.'),
        bulletPoints: [
          LString('Nourrisson < 12 mois', 'Infant < 12 months'),
          LString('Rhinite puis toux, dyspnée', 'Rhinitis then cough, dyspnea'),
          LString('Sibilants ± crépitants', 'Wheezing ± crackles'),
          LString('Signes de lutte: tirage, battement ailes du nez', 'Signs of distress: retractions, nasal flaring'),
          LString('Premier épisode (sinon: asthme du nourrisson)', 'First episode (otherwise: infant asthma)'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Évaluation gravité', '2. Severity assessment'),
        content: LString('Critères d\'hospitalisation.', 'Hospitalization criteria.'),
        bulletPoints: [
          LString('Âge < 6 semaines', 'Age < 6 weeks'),
          LString('Prématurité < 34 SA', 'Prematurity < 34 weeks GA'),
          LString('SpO2 < 92% en air ambiant', 'SpO2 < 92% on room air'),
          LString('Difficultés alimentaires > 50% des apports', 'Feeding difficulties > 50% of intake'),
          LString('Apnées, épuisement', 'Apneas, exhaustion'),
          LString('Terrain: cardiopathie, pathologie respiratoire', 'Comorbidity: heart disease, respiratory disease'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Désobstruction rhinopharyngée', '3. Nasal clearance'),
        content: LString('Mesure essentielle.', 'Essential measure.'),
        bulletPoints: [
          LString('DRP au sérum physiologique', 'Nasal saline drops/suction'),
          LString('Avant les repas et au coucher', 'Before feeds and at bedtime'),
          LString('Fragmentation des repas', 'Smaller, frequent feeds'),
          LString('Position proclive dorsale 30°', 'Elevated head of bed 30°'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Oxygénothérapie', '4. Oxygen therapy'),
        content: LString('Si hypoxémie.', 'If hypoxemia.'),
        bulletPoints: [
          LString('Si SpO2 < 92%', 'If SpO2 < 92%'),
          LString('Objectif SpO2 > 92%', 'Target SpO2 > 92%'),
          LString('Lunettes nasales, débit adapté', 'Nasal cannula, adjusted flow'),
          LString('Optiflow (HFNC) si besoin élevé', 'HFNC if high requirement'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Hydratation/Nutrition', '5. Hydration/Nutrition'),
        content: LString('Maintenir les apports.', 'Maintain intake.'),
        bulletPoints: [
          LString('Fractionnement des repas', 'Smaller, frequent feeds'),
          LString('SNG si difficultés alimentaires > 50%', 'NG tube if feeding difficulties > 50%'),
          LString('Perfusion si alimentation impossible', 'IV fluids if feeding impossible'),
          LString('Surveillance diurèse', 'Monitor urine output'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Traitements NON recommandés', '6. NOT recommended treatments'),
        content: LString('À éviter.', 'To avoid.'),
        bulletPoints: [
          LString('Bronchodilatateurs (pas d\'efficacité prouvée)', 'Bronchodilators (no proven efficacy)'),
          LString('Corticoïdes', 'Corticosteroids'),
          LString('Antibiotiques (sauf surinfection)', 'Antibiotics (unless superinfection)'),
          LString('Kinésithérapie respiratoire systématique', 'Routine chest physiotherapy'),
        ],
        warning: LString('Pas de salbutamol en 1ère intention', 'No salbutamol as first-line'),
      ),
      ProtocolStep(
        title: LString('7. Critères de sortie', '7. Discharge criteria'),
        content: LString('Conditions de retour à domicile.', 'Conditions for discharge.'),
        bulletPoints: [
          LString('SpO2 > 92% en air ambiant', 'SpO2 > 92% on room air'),
          LString('Alimentation > 50% des besoins', 'Feeding > 50% of needs'),
          LString('Pas d\'apnée', 'No apnea'),
          LString('Parents formés à la surveillance', 'Parents trained in monitoring'),
        ],
      ),
    ],
    keyPoints: LString('DRP + O2 si besoin + hydratation. Pas de bronchodilatateurs ni corticoïdes. Hospitalisation si < 6 sem ou SpO2 < 92%.', 'Nasal clearance + O2 if needed + hydration. No bronchodilators or steroids. Hospitalize if < 6 wks or SpO2 < 92%.'),
    source: LString('HAS 2019 - Bronchiolite aiguë du nourrisson', 'HAS 2019 - Bronchiolite aiguë du nourrisson'),
    sourceUrl: 'https://www.has-sante.fr',
    lastUpdated: 2019,
  ),

  // Convulsions fébriles
  Protocol(
    id: 'convulsions-febriles',
    name: LString('Convulsions Fébriles', 'Febrile Seizures'),
    category: ProtocolCategory.pediatric,
    description: LString('Crise convulsive associée à la fièvre chez l\'enfant', 'Seizure associated with fever in children'),
    indication: LString('Enfant 6 mois - 5 ans avec convulsions et fièvre', 'Child 6 months-5 years with seizures and fever'),
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: LString('1. Prise en charge immédiate', '1. Immediate management'),
        content: LString('Pendant la crise.', 'During the seizure.'),
        bulletPoints: [
          LString('PLS, protection', 'Recovery position, protection'),
          LString('Déshabiller l\'enfant', 'Undress the child'),
          LString('Mesurer la température', 'Measure temperature'),
          LString('Noter l\'heure de début', 'Note the start time'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Si crise > 5 min', '2. If seizure > 5 min'),
        content: LString('Traitement anticonvulsivant.', 'Anticonvulsant treatment.'),
        bulletPoints: [
          LString('Diazépam intra-rectal 0.5 mg/kg (max 10 mg)', 'Rectal diazepam 0.5 mg/kg (max 10 mg)'),
          LString('ou Midazolam buccal/nasal 0.3 mg/kg', 'or Buccal/nasal midazolam 0.3 mg/kg'),
          LString('Répéter une fois après 5 min si échec', 'Repeat once after 5 min if failed'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Classification', '3. Classification'),
        content: LString('Simple vs complexe.', 'Simple vs complex.'),
        bulletPoints: [
          LString('Simple: < 15 min, généralisée, unique/24h, 1-5 ans, pas de déficit post-critique', 'Simple: < 15 min, generalized, single/24h, 1-5 yrs, no postictal deficit'),
          LString('Complexe: > 15 min, focale, répétée, < 1 an ou > 5 ans, déficit post-critique', 'Complex: > 15 min, focal, repeated, < 1 yr or > 5 yrs, postictal deficit'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Convulsion fébrile simple', '4. Simple febrile seizure'),
        content: LString('Bilan minimal.', 'Minimal workup.'),
        bulletPoints: [
          LString('Rechercher foyer infectieux', 'Look for infectious focus'),
          LString('Pas de bilan sanguin systématique', 'No routine blood tests'),
          LString('Pas de PL si > 12 mois et examen normal', 'No LP if > 12 months and normal exam'),
          LString('Pas d\'EEG', 'No EEG'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Convulsion fébrile complexe', '5. Complex febrile seizure'),
        content: LString('Bilan plus complet.', 'More complete workup.'),
        bulletPoints: [
          LString('PL si < 12 mois ou signes méningés', 'LP if < 12 months or meningeal signs'),
          LString('Bilan sanguin selon contexte', 'Blood tests per context'),
          LString('EEG à distance discuté', 'Delayed EEG discussed'),
          LString('Imagerie si signes focaux', 'Imaging if focal signs'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Traitement antipyrétique', '6. Antipyretic treatment'),
        content: LString('Confort de l\'enfant.', 'Child comfort.'),
        bulletPoints: [
          LString('Paracétamol 15 mg/kg/6h', 'Acetaminophen 15 mg/kg/6h'),
          LString('Ne prévient PAS les récidives', 'Does NOT prevent recurrence'),
          LString('Objectif: confort, pas la normothermie', 'Goal: comfort, not normothermia'),
        ],
      ),
      ProtocolStep(
        title: LString('7. Information parentale', '7. Parental education'),
        content: LString('Éducation.', 'Education.'),
        bulletPoints: [
          LString('Pronostic excellent pour CF simple', 'Excellent prognosis for simple FS'),
          LString('Récidive possible (30%)', 'Recurrence possible (30%)'),
          LString('CAT si récidive à domicile', 'Action plan if recurrence at home'),
          LString('Prescription diazépam rectal si récidive', 'Rectal diazepam prescription if recurrence'),
        ],
      ),
    ],
    keyPoints: LString('PLS + diazépam si > 5 min. CF simple = bénigne, bilan minimal. CF complexe = bilan selon clinique.', 'Recovery position + diazepam if > 5 min. Simple FS = benign, minimal workup. Complex FS = workup per clinical findings.'),
    source: LString('SFP, HAS', 'SFP, HAS'),
    lastUpdated: 2020,
  ),

  // Déshydratation aiguë
  Protocol(
    id: 'deshydratation-pediatrique',
    name: LString('Déshydratation Aiguë de l\'Enfant', 'Acute Pediatric Dehydration'),
    category: ProtocolCategory.pediatric,
    description: LString('Perte hydro-électrolytique aiguë chez l\'enfant', 'Acute fluid and electrolyte loss in children'),
    indication: LString('Enfant avec diarrhée/vomissements et signes de déshydratation', 'Child with diarrhea/vomiting and signs of dehydration'),
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation gravité', '1. Severity assessment'),
        content: LString('Classification OMS.', 'WHO classification.'),
        bulletPoints: [
          LString('Légère (< 5%): soif, muqueuses sèches', 'Mild (< 5%): thirst, dry mucous membranes'),
          LString('Modérée (5-9%): yeux cernés, pli cutané, oligourie', 'Moderate (5-9%): sunken eyes, skin tenting, oliguria'),
          LString('Sévère (≥ 10%): choc, trouble conscience, marbrures', 'Severe (≥ 10%): shock, altered consciousness, mottling'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Déshydratation légère-modérée', '2. Mild-moderate dehydration'),
        content: LString('Réhydratation orale.', 'Oral rehydration.'),
        bulletPoints: [
          LString('SRO (Soluté de Réhydratation Orale)', 'ORS (Oral Rehydration Solution)'),
          LString('Volume: 50-100 mL/kg sur 4h', 'Volume: 50-100 mL/kg over 4h'),
          LString('Petites quantités fréquentes', 'Small frequent amounts'),
          LString('Poursuivre allaitement', 'Continue breastfeeding'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Déshydratation sévère ou échec SRO', '3. Severe dehydration or ORS failure'),
        content: LString('Réhydratation IV.', 'IV rehydration.'),
        bulletPoints: [
          LString('Bolus NaCl 0.9%: 20 mL/kg en 20 min', 'NaCl 0.9% bolus: 20 mL/kg over 20 min'),
          LString('Répéter si choc persistant', 'Repeat if persistent shock'),
          LString('Puis perfusion d\'entretien', 'Then maintenance infusion'),
          LString('NaCl 0.9% + G5% selon glycémie', 'NaCl 0.9% + D5W per glucose level'),
        ],
        warning: LString('Si choc: remplissage rapide 20 mL/kg, répétable', 'If shock: rapid bolus 20 mL/kg, repeatable'),
      ),
      ProtocolStep(
        title: LString('4. Calcul des besoins', '4. Fluid calculation'),
        content: LString('Déficit + entretien + pertes.', 'Deficit + maintenance + ongoing losses.'),
        bulletPoints: [
          LString('Déficit = % déshydratation x poids (kg) x 10 = mL', 'Deficit = % dehydration x weight (kg) x 10 = mL'),
          LString('Entretien: règle des 4-2-1 mL/kg/h', 'Maintenance: 4-2-1 rule mL/kg/h'),
          LString('Pertes en cours: estimation', 'Ongoing losses: estimation'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Surveillance', '5. Monitoring'),
        content: LString('Réévaluation régulière.', 'Regular reassessment.'),
        bulletPoints: [
          LString('Poids (référence +++)', 'Weight (best reference +++)'),
          LString('Fréquence cardiaque, TRC', 'Heart rate, CRT'),
          LString('Diurèse', 'Urine output'),
          LString('État neurologique', 'Neurological status'),
          LString('Ionogramme si IV', 'Electrolytes if IV'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Réalimentation précoce', '6. Early refeeding'),
        content: LString('Ne pas prolonger le jeûne.', 'Do not prolong fasting.'),
        bulletPoints: [
          LString('Réalimentation dès que possible (< 4h)', 'Refeed as soon as possible (< 4h)'),
          LString('Alimentation normale adaptée à l\'âge', 'Normal age-appropriate diet'),
          LString('Pas de régime restrictif prolongé', 'No prolonged restrictive diet'),
        ],
      ),
    ],
    keyPoints: LString('SRO en première intention. IV si sévère ou échec. Poids = meilleur critère. Réalimentation précoce.', 'ORS first-line. IV if severe or failure. Weight = best criterion. Early refeeding.'),
    source: LString('ESPGHAN 2014, HAS', 'ESPGHAN 2014, HAS'),
    lastUpdated: 2014,
  ),

  // Laryngite aiguë
  Protocol(
    id: 'laryngite',
    name: LString('Laryngite Aiguë (Croup)', 'Acute Laryngitis (Croup)'),
    category: ProtocolCategory.pediatric,
    description: LString('Inflammation sous-glottique virale', 'Viral subglottic inflammation'),
    indication: LString('Enfant 6 mois - 3 ans avec stridor inspiratoire et toux aboyante', 'Child 6 months-3 years with inspiratory stridor and barking cough'),
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: LString('1. Diagnostic clinique', '1. Clinical diagnosis'),
        content: LString('Tableau typique.', 'Typical presentation.'),
        bulletPoints: [
          LString('Âge: 6 mois - 3 ans', 'Age: 6 months - 3 years'),
          LString('Début nocturne brutal', 'Sudden nocturnal onset'),
          LString('Toux aboyante ("chien")', 'Barking cough ("seal-like")'),
          LString('Stridor inspiratoire', 'Inspiratory stridor'),
          LString('Voix rauque', 'Hoarse voice'),
          LString('Fièvre modérée', 'Low-grade fever'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Score de gravité (Westley)', '2. Severity score (Westley)'),
        content: LString('Évaluer la sévérité.', 'Assess severity.'),
        bulletPoints: [
          LString('Stridor: 0 (absent) à 2 (au repos)', 'Stridor: 0 (absent) to 2 (at rest)'),
          LString('Tirage: 0 à 3', 'Retractions: 0 to 3'),
          LString('Entrée d\'air: 0 à 2', 'Air entry: 0 to 2'),
          LString('Cyanose: 0 ou 5', 'Cyanosis: 0 or 5'),
          LString('Conscience: 0 ou 5', 'Consciousness: 0 or 5'),
          LString('Léger: 0-2, Modéré: 3-7, Sévère: 8-11, Imminente: ≥ 12', 'Mild: 0-2, Moderate: 3-7, Severe: 8-11, Impending: ≥ 12'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Laryngite légère', '3. Mild croup'),
        content: LString('Traitement ambulatoire.', 'Outpatient treatment.'),
        bulletPoints: [
          LString('Dexaméthasone 0.15-0.6 mg/kg PO dose unique', 'Dexamethasone 0.15-0.6 mg/kg PO single dose'),
          LString('ou Prednisolone 1-2 mg/kg', 'or Prednisolone 1-2 mg/kg'),
          LString('Humidification (pas de preuve mais habituel)', 'Humidification (no evidence but common practice)'),
          LString('Surveillance parentale', 'Parental monitoring'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Laryngite modérée-sévère', '4. Moderate-severe croup'),
        content: LString('Traitement hospitalier.', 'Hospital treatment.'),
        bulletPoints: [
          LString('Dexaméthasone 0.6 mg/kg PO/IM/IV', 'Dexamethasone 0.6 mg/kg PO/IM/IV'),
          LString('Adrénaline nébulisée 0.5 mL/kg (max 5 mL) L-adrénaline 1‰', 'Nebulized epinephrine 0.5 mL/kg (max 5 mL) L-epinephrine 1:1000'),
          LString('Effet adrénaline transitoire: surveiller 2-4h', 'Epinephrine effect transient: monitor 2-4h'),
          LString('O2 si SpO2 < 92%', 'O2 if SpO2 < 92%'),
        ],
        tip: LString('Adrénaline = effet rapide mais transitoire', 'Epinephrine = rapid but transient effect'),
      ),
      ProtocolStep(
        title: LString('5. Laryngite sévère/échec', '5. Severe croup/failure'),
        content: LString('Escalade.', 'Escalation.'),
        bulletPoints: [
          LString('Répéter adrénaline nébulisée', 'Repeat nebulized epinephrine'),
          LString('Mélange hélium-O2 (Heliox) si disponible', 'Helium-O2 mixture (Heliox) if available'),
          LString('Intubation si détresse majeure (tube plus petit)', 'Intubation if major distress (smaller tube)'),
        ],
        warning: LString('Prévoir tube de plus petit calibre (œdème)', 'Plan for smaller tube size (edema)'),
      ),
      ProtocolStep(
        title: LString('6. Diagnostics différentiels', '6. Differential diagnoses'),
        content: LString('À éliminer.', 'To rule out.'),
        bulletPoints: [
          LString('Épiglottite (rare depuis vaccination Hib)', 'Epiglottitis (rare since Hib vaccination)'),
          LString('Corps étranger', 'Foreign body'),
          LString('Abcès rétropharyngé', 'Retropharyngeal abscess'),
          LString('Anaphylaxie', 'Anaphylaxis'),
        ],
      ),
    ],
    keyPoints: LString('Corticoïdes systématiques. Adrénaline nébulisée si modéré/sévère. Surveillance 2-4h après adrénaline.', 'Systemic corticosteroids. Nebulized epinephrine if moderate/severe. Monitor 2-4h after epinephrine.'),
    source: LString('SFP, Cochrane Review', 'SFP, Cochrane Review'),
    lastUpdated: 2021,
  ),

  // Choc pédiatrique
  Protocol(
    id: 'choc-pediatrique',
    name: LString('État de Choc Pédiatrique', 'Pediatric Shock'),
    category: ProtocolCategory.pediatric,
    description: LString('Insuffisance circulatoire aiguë de l\'enfant', 'Acute circulatory failure in children'),
    indication: LString('Tachycardie + signes d\'hypoperfusion (TRC > 3s, marbrures, troubles conscience)', 'Tachycardia + signs of hypoperfusion (CRT > 3s, mottling, altered consciousness)'),
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Recognition'),
        content: LString('Signes de choc.', 'Signs of shock.'),
        bulletPoints: [
          LString('Tachycardie (signe précoce)', 'Tachycardia (early sign)'),
          LString('TRC > 3 secondes', 'CRT > 3 seconds'),
          LString('Marbrures, extrémités froides', 'Mottling, cold extremities'),
          LString('Pouls filants', 'Thready pulses'),
          LString('Troubles conscience', 'Altered consciousness'),
          LString('Hypotension = signe TARDIF chez l\'enfant', 'Hypotension = LATE sign in children'),
        ],
        warning: LString('L\'hypotension est tardive chez l\'enfant. Ne pas l\'attendre!', 'Hypotension is late in children. Do not wait for it!'),
      ),
      ProtocolStep(
        title: LString('2. Accès vasculaire', '2. Vascular access'),
        content: LString('Rapide et efficace.', 'Rapid and effective.'),
        bulletPoints: [
          LString('VVP en priorité', 'Peripheral IV priority'),
          LString('Voie IO si échec < 60 secondes', 'IO access if failed < 60 seconds'),
          LString('Sites IO: tibia proximal ++', 'IO sites: proximal tibia ++'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Remplissage initial', '3. Initial fluid bolus'),
        content: LString('Bolus de cristalloïdes.', 'Crystalloid boluses.'),
        bulletPoints: [
          LString('NaCl 0.9% 20 mL/kg en 5-10 min', 'NaCl 0.9% 20 mL/kg over 5-10 min'),
          LString('Réévaluer après chaque bolus', 'Reassess after each bolus'),
          LString('Répéter jusqu\'à 60 mL/kg si nécessaire', 'Repeat up to 60 mL/kg if needed'),
          LString('Attention surcharge si cardiopathie', 'Caution fluid overload if heart disease'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Si choc réfractaire', '4. If refractory shock'),
        content: LString('Vasopresseurs.', 'Vasopressors.'),
        bulletPoints: [
          LString('Adrénaline 0.1-1 µg/kg/min (choc froid)', 'Epinephrine 0.1-1 µg/kg/min (cold shock)'),
          LString('Noradrénaline 0.1-1 µg/kg/min (choc chaud)', 'Norepinephrine 0.1-1 µg/kg/min (warm shock)'),
          LString('VVC si possible mais ne pas retarder traitement', 'CVC if possible but do not delay treatment'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Orientation étiologique', '5. Etiological workup'),
        content: LString('Adapter le traitement.', 'Adapt treatment.'),
        bulletPoints: [
          LString('Septique: ATB précoce, remplissage, vasopresseurs', 'Septic: early antibiotics, fluids, vasopressors'),
          LString('Hypovolémique: remplissage, transfusion si hémorragie', 'Hypovolemic: fluids, transfusion if hemorrhage'),
          LString('Cardiogénique: prudence remplissage, inotropes', 'Cardiogenic: cautious fluids, inotropes'),
          LString('Anaphylactique: adrénaline IM, remplissage', 'Anaphylactic: IM epinephrine, fluids'),
        ],
      ),
    ],
    keyPoints: LString('Tachycardie = signe précoce. Bolus 20 mL/kg répétés. IO si échec VVP. Hypotension = tardif.', 'Tachycardia = early sign. Repeated 20 mL/kg boluses. IO if PIV fails. Hypotension = late.'),
    source: LString('ERC 2021, ACCM Guidelines', 'ERC 2021, ACCM Guidelines'),
    lastUpdated: 2021,
  ),

  // Purpura de l'enfant
  Protocol(
    id: 'purpura-enfant',
    name: LString('Purpura de l\'Enfant', 'Pediatric Purpura'),
    category: ProtocolCategory.pediatric,
    description: LString('Conduite à tenir devant un purpura fébrile ou non', 'Management of febrile or non-febrile purpura'),
    indication: LString('Enfant avec lésions purpuriques (ne s\'effaçant pas à la vitropression)', 'Child with purpuric lesions (non-blanching on pressure)'),
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: LString('1. Purpura fébrile', '1. Febrile purpura'),
        content: LString('Urgence jusqu\'à preuve du contraire.', 'Emergency until proven otherwise.'),
        bulletPoints: [
          LString('Purpura + fièvre = méningocoque possible', 'Purpura + fever = possible meningococcus'),
          LString('Purpura extensif ou nécrotique = purpura fulminans', 'Extensive or necrotic purpura = purpura fulminans'),
          LString('Ceftriaxone 50-100 mg/kg IV/IM IMMÉDIAT', 'Ceftriaxone 50-100 mg/kg IV/IM IMMEDIATE'),
        ],
        warning: LString('Antibiotique AVANT tout bilan si purpura fébrile', 'Antibiotic BEFORE any workup if febrile purpura'),
      ),
      ProtocolStep(
        title: LString('2. Purpura non fébrile - Évaluation', '2. Non-febrile purpura - Assessment'),
        content: LString('Rechercher étiologie.', 'Investigate etiology.'),
        bulletPoints: [
          LString('Purpura pétéchial: thrombopénie?', 'Petechial purpura: thrombocytopenia?'),
          LString('Purpura vasculaire: territoire déclive', 'Vascular purpura: dependent areas'),
          LString('Ecchymoses: maltraitance?', 'Bruises: abuse?'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Purpura rhumatoïde (HSP)', '3. Henoch-Schönlein Purpura (IgA vasculitis)'),
        content: LString('Vascularite la plus fréquente.', 'Most common vasculitis.'),
        bulletPoints: [
          LString('Purpura vasculaire déclive + douleurs abdominales', 'Dependent vascular purpura + abdominal pain'),
          LString('Arthralgies', 'Joint pain'),
          LString('Atteinte rénale possible', 'Possible renal involvement'),
          LString('Traitement symptomatique', 'Symptomatic treatment'),
          LString('Surveillance fonction rénale', 'Monitor renal function'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Purpura thrombopénique immunologique (PTI)', '4. Immune Thrombocytopenic Purpura (ITP)'),
        content: LString('Thrombopénie isolée.', 'Isolated thrombocytopenia.'),
        bulletPoints: [
          LString('Plaquettes < 100 G/L, reste NFS normal', 'Platelets < 100 G/L, rest of CBC normal'),
          LString('Enfant en bon état général', 'Child in good general condition'),
          LString('Risque hémorragique si < 10-20 G/L', 'Bleeding risk if < 10-20 G/L'),
          LString('Traitement selon sévérité: surveillance, Ig IV, corticoïdes', 'Treatment per severity: monitoring, IV Ig, corticosteroids'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Bilan minimal', '5. Minimal workup'),
        content: LString('Examens à réaliser.', 'Tests to perform.'),
        bulletPoints: [
          LString('NFS plaquettes (thrombopénie?)', 'CBC with platelets (thrombocytopenia?)'),
          LString('TP/TCA (coagulopathie?)', 'PT/aPTT (coagulopathy?)'),
          LString('Si fièvre: CRP, hémocultures, PL selon contexte', 'If fever: CRP, blood cultures, LP per context'),
        ],
      ),
    ],
    keyPoints: LString('Purpura fébrile = ATB immédiat. Purpura non fébrile = NFS en premier. HSP = le plus fréquent en pédiatrie.', 'Febrile purpura = immediate antibiotics. Non-febrile = CBC first. HSP = most common in pediatrics.'),
    source: LString('Urgences pédiatriques', 'Urgences pédiatriques'),
    lastUpdated: 2020,
  ),

  // Anaphylaxie pédiatrique
  Protocol(
    id: 'anaphylaxie-pediatrique',
    name: LString('Anaphylaxie Pédiatrique', 'Pediatric Anaphylaxis'),
    category: ProtocolCategory.pediatric,
    description: LString('Réaction allergique systémique sévère de l\'enfant', 'Severe systemic allergic reaction in children'),
    indication: LString('Réaction allergique avec atteinte respiratoire et/ou hémodynamique', 'Allergic reaction with respiratory and/or hemodynamic compromise'),
    isPediatric: true,
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Recognition'),
        content: LString('Critères diagnostiques.', 'Diagnostic criteria.'),
        bulletPoints: [
          LString('Début brutal après exposition allergène', 'Sudden onset after allergen exposure'),
          LString('Cutané: urticaire, angioedème', 'Cutaneous: urticaria, angioedema'),
          LString('Respiratoire: bronchospasme, stridor, dyspnée', 'Respiratory: bronchospasm, stridor, dyspnea'),
          LString('Cardiovasculaire: hypotension, tachycardie', 'Cardiovascular: hypotension, tachycardia'),
          LString('Digestif: vomissements, douleurs abdominales', 'GI: vomiting, abdominal pain'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Adrénaline IM', '2. IM Epinephrine'),
        content: LString('Traitement de première ligne.', 'First-line treatment.'),
        bulletPoints: [
          LString('Adrénaline IM face antéro-latérale cuisse', 'IM epinephrine anterolateral thigh'),
          LString('< 6 ans: 150 µg (Anapen/Epipen Junior)', '< 6 years: 150 µg (Anapen/EpiPen Jr)'),
          LString('6-12 ans: 300 µg', '6-12 years: 300 µg'),
          LString('> 12 ans: 300-500 µg', '> 12 years: 300-500 µg'),
          LString('Répéter après 5 min si pas d\'amélioration', 'Repeat after 5 min if no improvement'),
        ],
        warning: LString('Ne pas retarder l\'adrénaline!', 'Do not delay epinephrine!'),
      ),
      ProtocolStep(
        title: LString('3. Position', '3. Positioning'),
        content: LString('Selon symptômes.', 'Per symptoms.'),
        bulletPoints: [
          LString('Allongé jambes surélevées si hypotension', 'Supine with legs elevated if hypotension'),
          LString('Assis si détresse respiratoire', 'Sitting up if respiratory distress'),
          LString('PLS si troubles conscience', 'Recovery position if altered consciousness'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Traitements associés', '4. Adjunctive treatments'),
        content: LString('Après adrénaline.', 'After epinephrine.'),
        bulletPoints: [
          LString('O2 haut débit', 'High-flow O2'),
          LString('Remplissage NaCl 0.9%: 20 mL/kg si hypotension', 'NaCl 0.9% bolus: 20 mL/kg if hypotension'),
          LString('Salbutamol nébulisé si bronchospasme', 'Nebulized salbutamol if bronchospasm'),
          LString('Antihistaminiques H1 (desloratadine, cétirizine)', 'H1 antihistamines (desloratadine, cetirizine)'),
          LString('Corticoïdes (prévention phase tardive)', 'Corticosteroids (late-phase prevention)'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Surveillance', '5. Monitoring'),
        content: LString('Risque de réaction biphasique.', 'Risk of biphasic reaction.'),
        bulletPoints: [
          LString('Observation minimum 6-8 heures', 'Minimum observation 6-8 hours'),
          LString('24h si réaction sévère', '24h if severe reaction'),
          LString('Risque récidive dans les 24h', 'Recurrence risk within 24h'),
        ],
      ),
      ProtocolStep(
        title: LString('6. À la sortie', '6. At discharge'),
        content: LString('Prévention et suivi.', 'Prevention and follow-up.'),
        bulletPoints: [
          LString('Prescription stylo auto-injecteur', 'Auto-injector pen prescription'),
          LString('Éducation utilisation', 'Usage education'),
          LString('PAI scolaire', 'School action plan'),
          LString('Consultation allergologie', 'Allergy consultation'),
        ],
      ),
    ],
    keyPoints: LString('Adrénaline IM précoce. Répéter si besoin. Surveillance 6-8h. Stylo auto-injecteur à la sortie.', 'Early IM epinephrine. Repeat if needed. Monitor 6-8h. Auto-injector at discharge.'),
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
    name: LString('Éclampsie', 'Eclampsia'),
    category: ProtocolCategory.obstetric,
    description: LString('Convulsions sur pré-éclampsie', 'Seizures complicating pre-eclampsia'),
    indication: LString('Femme enceinte > 20 SA ou post-partum avec convulsions', 'Pregnant woman > 20 weeks GA or postpartum with seizures'),
    steps: [
      ProtocolStep(
        title: LString('1. Prise en charge immédiate', '1. Immediate management'),
        content: LString('Pendant la crise.', 'During the seizure.'),
        bulletPoints: [
          LString('PLS, protection des voies aériennes', 'Recovery position, airway protection'),
          LString('O2 haut débit', 'High-flow O2'),
          LString('Ne pas tenter d\'arrêter la crise par contention', 'Do not attempt to restrain during the seizure'),
          LString('Voie veineuse périphérique', 'Peripheral IV access'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Sulfate de magnésium', '2. Magnesium sulfate'),
        content: LString('Traitement de référence.', 'First-line treatment.'),
        bulletPoints: [
          LString('Dose de charge: 4g IV en 20 min', 'Loading dose: 4g IV over 20 min'),
          LString('Puis entretien: 1g/h IVSE', 'Then maintenance: 1g/h continuous IV'),
          LString('Poursuivre 24-48h après dernière crise', 'Continue 24-48h after last seizure'),
          LString('Surveillance: réflexes, FR, diurèse', 'Monitoring: reflexes, RR, urine output'),
        ],
        warning: LString('Antidote si surdosage: Gluconate de calcium 1g IV', 'Antidote if overdose: Calcium gluconate 1g IV'),
      ),
      ProtocolStep(
        title: LString('3. Si récidive sous MgSO4', '3. If recurrence on MgSO4'),
        content: LString('Traitement de seconde ligne.', 'Second-line treatment.'),
        bulletPoints: [
          LString('Bolus supplémentaire MgSO4 2g IV', 'Additional MgSO4 bolus 2g IV'),
          LString('Si échec: Diazépam 10 mg IV', 'If failure: Diazepam 10 mg IV'),
          LString('ou Clonazépam 1 mg IV', 'or Clonazepam 1 mg IV'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Contrôle tensionnel', '4. Blood pressure control'),
        content: LString('Objectif PAS < 160, PAD < 110.', 'Target SBP < 160, DBP < 110.'),
        bulletPoints: [
          LString('Nicardipine IVSE (1-6 mg/h)', 'Nicardipine continuous IV (1-6 mg/h)'),
          LString('ou Labétalol IV (20 mg bolus puis IVSE)', 'or Labetalol IV (20 mg bolus then infusion)'),
          LString('Éviter chute brutale de PA (perfusion utéro-placentaire)', 'Avoid sudden BP drop (uteroplacental perfusion)'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Extraction fœtale', '5. Fetal delivery'),
        content: LString('Seul traitement définitif.', 'Only definitive treatment.'),
        bulletPoints: [
          LString('Décision après stabilisation maternelle', 'Decision after maternal stabilization'),
          LString('Césarienne le plus souvent', 'Cesarean section most often'),
          LString('Pas d\'attente si instabilité persistante', 'No delay if persistent instability'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Surveillance post-critique', '6. Post-ictal monitoring'),
        content: LString('Réanimation ou soins intensifs.', 'ICU or high-dependency care.'),
        bulletPoints: [
          LString('Monitoring materno-fœtal', 'Maternal-fetal monitoring'),
          LString('Surveillance MgSO4', 'MgSO4 monitoring'),
          LString('Bilan HELLP syndrome', 'HELLP syndrome workup'),
          LString('Scanner cérébral si atypie', 'Brain CT if atypical presentation'),
        ],
      ),
    ],
    keyPoints: LString('MgSO4 = traitement de référence. Contrôle PA sans chute brutale. Extraction fœtale après stabilisation.', 'MgSO4 = first-line treatment. BP control without sudden drop. Fetal delivery after stabilization.'),
    source: LString('CNGOF, Magpie Trial', 'CNGOF, Magpie Trial'),
    lastUpdated: 2020,
  ),

  // Hémorragie post-partum
  Protocol(
    id: 'hpp',
    name: LString('Hémorragie du Post-Partum', 'Postpartum Hemorrhage'),
    category: ProtocolCategory.obstetric,
    description: LString('Saignement > 500 mL (voie basse) ou > 1000 mL (césarienne)', 'Bleeding > 500 mL (vaginal) or > 1000 mL (cesarean)'),
    indication: LString('Hémorragie dans les 24h suivant l\'accouchement', 'Hemorrhage within 24h of delivery'),
    steps: [
      ProtocolStep(
        title: LString('1. Alerte et organisation', '1. Alert and team activation'),
        content: LString('Mobiliser l\'équipe.', 'Mobilize the team.'),
        bulletPoints: [
          LString('Appel obstétricien, anesthésiste, sage-femme', 'Call obstetrician, anesthesiologist, midwife'),
          LString('Alerter banque du sang', 'Alert blood bank'),
          LString('Chronométrer et quantifier les pertes', 'Time and quantify blood loss'),
          LString('Double voie veineuse gros calibre', 'Two large-bore IV lines'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Étiologies (4T)', '2. Etiologies (4T)'),
        content: LString('Rechercher la cause.', 'Identify the cause.'),
        bulletPoints: [
          LString('Tonus: atonie utérine (70%)', 'Tone: uterine atony (70%)'),
          LString('Tissu: rétention placentaire', 'Tissue: retained placenta'),
          LString('Trauma: déchirure cervico-vaginale, rupture utérine', 'Trauma: cervicovaginal tear, uterine rupture'),
          LString('Thrombine: coagulopathie', 'Thrombin: coagulopathy'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Traitement atonie utérine', '3. Uterine atony treatment'),
        content: LString('Première cause.', 'Most common cause.'),
        bulletPoints: [
          LString('Massage utérin bimanuel', 'Bimanual uterine massage'),
          LString('Oxytocine 5-10 UI IV puis 20-40 UI/500 mL en perfusion', 'Oxytocin 5-10 IU IV then 20-40 IU/500 mL infusion'),
          LString('Sulprostone (Nalador) 500 µg/h IVSE si échec', 'Sulprostone (Nalador) 500 µg/h IV if failure'),
          LString('Vidange vésicale', 'Bladder emptying'),
        ],
        warning: LString('Sulprostone: CI cardiovasculaires, max 1500 µg', 'Sulprostone: cardiovascular contraindications, max 1500 µg'),
      ),
      ProtocolStep(
        title: LString('4. Acide tranexamique', '4. Tranexamic acid'),
        content: LString('Systématique.', 'Systematic.'),
        bulletPoints: [
          LString('1g IV dès le diagnostic', '1g IV at diagnosis'),
          LString('Répéter 1g si saignement persistant à 30 min', 'Repeat 1g if bleeding persists at 30 min'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Réanimation', '5. Resuscitation'),
        content: LString('Support hémodynamique.', 'Hemodynamic support.'),
        bulletPoints: [
          LString('Remplissage cristalloïdes', 'Crystalloid infusion'),
          LString('Transfusion CGR si Hb < 7 g/dL ou instabilité', 'pRBC transfusion if Hb < 7 g/dL or instability'),
          LString('PFC, plaquettes, fibrinogène selon coagulation', 'FFP, platelets, fibrinogen based on coagulation'),
          LString('Objectif fibrinogène > 2 g/L', 'Target fibrinogen > 2 g/L'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Traitements invasifs', '6. Invasive treatments'),
        content: LString('Si échec médical.', 'If medical treatment fails.'),
        bulletPoints: [
          LString('Tamponnement intra-utérin (ballonnet)', 'Intrauterine tamponade (balloon)'),
          LString('Embolisation artérielle', 'Arterial embolization'),
          LString('Ligatures vasculaires', 'Vascular ligatures'),
          LString('Hystérectomie d\'hémostase (ultime recours)', 'Hemostatic hysterectomy (last resort)'),
        ],
      ),
    ],
    keyPoints: LString('4T pour étiologie. Oxytocine puis sulprostone. Acide tranexamique 1g. Escalade jusqu\'à embolisation/chirurgie.', '4T for etiology. Oxytocin then sulprostone. Tranexamic acid 1g. Escalate to embolization/surgery.'),
    source: LString('CNGOF 2014 - HPP', 'CNGOF 2014 - HPP'),
    lastUpdated: 2014,
  ),

  // Pré-éclampsie
  Protocol(
    id: 'pre-eclampsie',
    name: LString('Pré-éclampsie Sévère', 'Severe Pre-eclampsia'),
    category: ProtocolCategory.obstetric,
    description: LString('HTA gravidique avec protéinurie et atteinte d\'organe', 'Gestational hypertension with proteinuria and organ damage'),
    indication: LString('PA ≥ 160/110 + protéinurie + signes de gravité', 'BP ≥ 160/110 + proteinuria + severity signs'),
    steps: [
      ProtocolStep(
        title: LString('1. Critères de sévérité', '1. Severity criteria'),
        content: LString('Identifier les formes graves.', 'Identify severe forms.'),
        bulletPoints: [
          LString('PAS ≥ 160 ou PAD ≥ 110 mmHg', 'SBP ≥ 160 or DBP ≥ 110 mmHg'),
          LString('Protéinurie > 5 g/24h', 'Proteinuria > 5 g/24h'),
          LString('Oligurie < 500 mL/24h', 'Oliguria < 500 mL/24h'),
          LString('Céphalées, troubles visuels, ROT vifs', 'Headache, visual disturbances, brisk reflexes'),
          LString('Douleur épigastrique (HELLP)', 'Epigastric pain (HELLP)'),
          LString('Cytolyse hépatique, thrombopénie', 'Hepatic cytolysis, thrombocytopenia'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Traitement antihypertenseur', '2. Antihypertensive treatment'),
        content: LString('Urgence hypertensive.', 'Hypertensive emergency.'),
        bulletPoints: [
          LString('Objectif: PAS 140-150, PAD 90-100', 'Target: SBP 140-150, DBP 90-100'),
          LString('Nicardipine IVSE 1-6 mg/h', 'Nicardipine IV 1-6 mg/h'),
          LString('ou Labétalol IV 20 mg puis IVSE', 'or Labetalol IV 20 mg then infusion'),
          LString('Éviter baisse brutale (souffrance fœtale)', 'Avoid sudden drop (fetal distress)'),
        ],
        warning: LString('Ne pas descendre PA trop vite: risque fœtal', 'Do not lower BP too quickly: fetal risk'),
      ),
      ProtocolStep(
        title: LString('3. Prévention éclampsie', '3. Eclampsia prevention'),
        content: LString('Sulfate de magnésium.', 'Magnesium sulfate.'),
        bulletPoints: [
          LString('Indication: pré-éclampsie sévère', 'Indication: severe pre-eclampsia'),
          LString('Dose charge: 4g IV en 20 min', 'Loading dose: 4g IV over 20 min'),
          LString('Entretien: 1g/h IVSE', 'Maintenance: 1g/h continuous IV'),
          LString('Surveillance: réflexes, FR > 12, magnésémie', 'Monitoring: reflexes, RR > 12, magnesium levels'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Bilan HELLP', '4. HELLP workup'),
        content: LString('Rechercher complications.', 'Screen for complications.'),
        bulletPoints: [
          LString('Hémolyse: LDH, haptoglobine, schizocytes', 'Hemolysis: LDH, haptoglobin, schistocytes'),
          LString('Elevated Liver enzymes: ASAT, ALAT', 'Elevated Liver enzymes: AST, ALT'),
          LString('Low Platelets: < 100 G/L', 'Low Platelets: < 100 G/L'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Décision d\'extraction', '5. Delivery decision'),
        content: LString('Seul traitement définitif.', 'Only definitive treatment.'),
        bulletPoints: [
          LString('< 34 SA: corticoïdes pour maturation pulmonaire si possible', '< 34 weeks: corticosteroids for lung maturation if possible'),
          LString('≥ 34 SA: extraction à discuter', '≥ 34 weeks: delivery to discuss'),
          LString('Extraction urgente si: HELLP, HRP, souffrance fœtale', 'Urgent delivery if: HELLP, placental abruption, fetal distress'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Surveillance', '6. Monitoring'),
        content: LString('Monitoring continu.', 'Continuous monitoring.'),
        bulletPoints: [
          LString('Monitoring PA, SpO2', 'BP, SpO2 monitoring'),
          LString('RCF (rythme cardiaque fœtal)', 'FHR (fetal heart rate)'),
          LString('Bilan biologique répété', 'Repeat laboratory workup'),
          LString('Diurèse horaire', 'Hourly urine output'),
        ],
      ),
    ],
    keyPoints: LString('PA 140-150/90-100. MgSO4 si sévère. Bilan HELLP. Extraction = traitement définitif.', 'BP 140-150/90-100. MgSO4 if severe. HELLP workup. Delivery = definitive treatment.'),
    source: LString('CNGOF, ISSHP', 'CNGOF, ISSHP'),
    lastUpdated: 2020,
  ),

  // Accouchement inopiné
  Protocol(
    id: 'accouchement-inopine',
    name: LString('Accouchement Inopiné', 'Precipitous Delivery'),
    category: ProtocolCategory.obstetric,
    description: LString('Accouchement en dehors d\'une structure adaptée', 'Delivery outside an appropriate facility'),
    indication: LString('Accouchement imminent hors maternité', 'Imminent delivery outside maternity ward'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation', '1. Assessment'),
        content: LString('Imminence de l\'accouchement.', 'Imminence of delivery.'),
        bulletPoints: [
          LString('Envie de pousser irrépressible', 'Irresistible urge to push'),
          LString('Tête visible à la vulve', 'Head visible at the vulva'),
          LString('Contractions rapprochées intenses', 'Frequent intense contractions'),
          LString('Si transfert possible < 15 min: transférer', 'If transfer possible < 15 min: transfer'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Préparation', '2. Preparation'),
        content: LString('Matériel nécessaire.', 'Required equipment.'),
        bulletPoints: [
          LString('Gants stériles, champs', 'Sterile gloves, drapes'),
          LString('Clamps de cordon ou lacets stériles', 'Cord clamps or sterile ties'),
          LString('Ciseaux stériles', 'Sterile scissors'),
          LString('Couverture chaude pour le nouveau-né', 'Warm blanket for the newborn'),
          LString('Aspiration douce si disponible', 'Gentle suction if available'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Accouchement', '3. Delivery'),
        content: LString('Accompagner l\'expulsion.', 'Guide the expulsion.'),
        bulletPoints: [
          LString('Position gynécologique ou latérale', 'Lithotomy or lateral position'),
          LString('Soutenir le périnée (pas de protection rigide)', 'Support the perineum (no rigid guard)'),
          LString('Contrôler la sortie de la tête', 'Control head delivery'),
          LString('Vérifier absence de circulaire serré du cordon', 'Check for tight nuchal cord'),
          LString('Dégager les épaules avec rotation douce', 'Deliver shoulders with gentle rotation'),
        ],
        tip: LString('Ne pas tirer sur la tête, accompagner seulement', 'Do not pull on the head, only guide'),
      ),
      ProtocolStep(
        title: LString('4. Soins nouveau-né', '4. Newborn care'),
        content: LString('À la naissance.', 'At birth.'),
        bulletPoints: [
          LString('Sécher et stimuler', 'Dry and stimulate'),
          LString('Peau à peau avec la mère si va bien', 'Skin-to-skin with mother if well'),
          LString('Évaluer: cri, tonus, coloration', 'Assess: cry, tone, color'),
          LString('Aspiration si nécessaire', 'Suction if necessary'),
          LString('Garder au chaud +++', 'Keep warm +++'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Cordon ombilical', '5. Umbilical cord'),
        content: LString('Clampage.', 'Clamping.'),
        bulletPoints: [
          LString('Attendre 1-3 min si nouveau-né stable', 'Wait 1-3 min if newborn stable'),
          LString('Clamper à 2 et 5 cm de l\'ombilic', 'Clamp at 2 and 5 cm from umbilicus'),
          LString('Section entre les clamps', 'Cut between clamps'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Délivrance', '6. Placental delivery'),
        content: LString('Expulsion du placenta.', 'Placenta expulsion.'),
        bulletPoints: [
          LString('Attendre signes de décollement (15-30 min)', 'Wait for separation signs (15-30 min)'),
          LString('Ne pas tirer sur le cordon', 'Do not pull on the cord'),
          LString('Injection oxytocine 5-10 UI IM après délivrance', 'Oxytocin 5-10 IU IM after delivery'),
          LString('Vérifier intégrité du placenta', 'Check placenta integrity'),
          LString('Massage utérin', 'Uterine massage'),
        ],
        warning: LString('Ne jamais tirer sur le cordon: risque de rupture et d\'inversion utérine', 'Never pull on the cord: risk of rupture and uterine inversion'),
      ),
    ],
    keyPoints: LString('Accompagner sans tirer. Sécher et réchauffer le nouveau-né. Oxytocine après délivrance.', 'Guide without pulling. Dry and warm the newborn. Oxytocin after placental delivery.'),
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
    name: LString('Intubation en Séquence Rapide', 'Rapid Sequence Intubation'),
    category: ProtocolCategory.analgesia,
    description: LString('Technique d\'intubation pour estomac plein ou urgence', 'Intubation technique for full stomach or emergency'),
    indication: LString('Intubation en urgence, estomac plein, détresse vitale', 'Emergency intubation, full stomach, life-threatening distress'),
    steps: [
      ProtocolStep(
        title: LString('1. Préparation', '1. Preparation'),
        content: LString('Check-list avant ISR.', 'Pre-RSI checklist.'),
        bulletPoints: [
          LString('Vérifier matériel: laryngoscope, sondes (taille + 1 au-dessus et dessous)', 'Check equipment: laryngoscope, tubes (size + 1 above and below)'),
          LString('Aspiration fonctionnelle', 'Working suction'),
          LString('Monitorage: SpO2, capno, ECG, PA', 'Monitoring: SpO2, capnography, ECG, BP'),
          LString('Voie veineuse sûre', 'Secure IV access'),
          LString('Plan B: dispositif supraglottique, kit de cricothyroïdotomie', 'Plan B: supraglottic device, cricothyrotomy kit'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Préoxygénation', '2. Preoxygenation'),
        content: LString('Dénitrogénation.', 'Denitrogenation.'),
        bulletPoints: [
          LString('O2 100% pendant 3-5 min', '100% O2 for 3-5 min'),
          LString('Objectif: EtO2 > 90%', 'Target: EtO2 > 90%'),
          LString('Ou 8 inspirations profondes si urgent', 'Or 8 vital capacity breaths if urgent'),
          LString('VNI si hypoxémique (CPAP ou BiPAP)', 'NIV if hypoxemic (CPAP or BiPAP)'),
        ],
        tip: LString('Position proclive 30° améliore la préoxygénation', '30° head-up position improves preoxygenation'),
      ),
      ProtocolStep(
        title: LString('3. Induction', '3. Induction'),
        content: LString('Hypnotique + curare.', 'Hypnotic + neuromuscular blocker.'),
        bulletPoints: [
          LString('Hypnotique au choix:', 'Choice of hypnotic:'),
          LString('- Étomidate 0.3 mg/kg (stabilité HD)', '- Etomidate 0.3 mg/kg (hemodynamic stability)'),
          LString('- Kétamine 1-2 mg/kg (bronchospasme, choc)', '- Ketamine 1-2 mg/kg (bronchospasm, shock)'),
          LString('- Propofol 2-2.5 mg/kg (CI si instable)', '- Propofol 2-2.5 mg/kg (CI if unstable)'),
          LString('Curare:', 'Neuromuscular blocker:'),
          LString('- Succinylcholine 1 mg/kg (délai 60 sec, durée 6-10 min)', '- Succinylcholine 1 mg/kg (onset 60 sec, duration 6-10 min)'),
          LString('- Rocuronium 1.2 mg/kg (réversible par sugammadex)', '- Rocuronium 1.2 mg/kg (reversible with sugammadex)'),
        ],
        warning: LString('Succinylcholine CI: hyperkaliémie, myopathie, brûlure > 24h', 'Succinylcholine CI: hyperkalemia, myopathy, burn > 24h'),
      ),
      ProtocolStep(
        title: LString('4. Manœuvre de Sellick', '4. Sellick maneuver'),
        content: LString('Controversée mais habituelle.', 'Controversial but conventional.'),
        bulletPoints: [
          LString('Pression cricoïdienne dès perte de conscience', 'Cricoid pressure from loss of consciousness'),
          LString('Maintenir jusqu\'à vérification du ballonnet', 'Maintain until cuff verification'),
          LString('Relâcher si vomissement actif ou difficulté intubation', 'Release if active vomiting or difficult intubation'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Intubation', '5. Intubation'),
        content: LString('Sans ventilation intermédiaire.', 'Without intermediate ventilation.'),
        bulletPoints: [
          LString('Laryngoscopie dès fasciculations terminées ou 60 sec', 'Laryngoscopy once fasciculations end or at 60 sec'),
          LString('Pas de ventilation au masque entre induction et IOT', 'No bag-mask ventilation between induction and intubation'),
          LString('Vidéolaryngoscope si anticipation difficile', 'Video laryngoscope if anticipated difficulty'),
          LString('Vérification: capnographie +++, auscultation', 'Confirmation: capnography +++, auscultation'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Post-intubation', '6. Post-intubation'),
        content: LString('Sécurisation.', 'Securing.'),
        bulletPoints: [
          LString('Gonfler ballonnet', 'Inflate cuff'),
          LString('Fixer la sonde', 'Secure the tube'),
          LString('Vérifier position: capno, auscultation, radio', 'Verify position: capnography, auscultation, X-ray'),
          LString('Sédation d\'entretien', 'Maintenance sedation'),
          LString('Sonde gastrique', 'Gastric tube'),
        ],
      ),
    ],
    keyPoints: LString('Préoxygénation 3 min. Pas de ventilation intermédiaire. Succinylcholine ou rocuronium. Vérifier par capno.', 'Preoxygenation 3 min. No intermediate ventilation. Succinylcholine or rocuronium. Confirm with capnography.'),
    source: LString('SFAR/SFMU 2017 - Intubation difficile', 'SFAR/SFMU 2017 - Intubation difficile'),
    lastUpdated: 2017,
  ),

  // Analgésie aux urgences
  Protocol(
    id: 'analgesie-urgences',
    name: LString('Analgésie aux Urgences', 'Emergency Analgesia'),
    category: ProtocolCategory.analgesia,
    description: LString('Prise en charge de la douleur aux urgences', 'Pain management in the emergency department'),
    indication: LString('Patient douloureux aux urgences', 'Patient with pain in the ED'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation', '1. Assessment'),
        content: LString('Quantifier la douleur.', 'Quantify pain.'),
        bulletPoints: [
          LString('EVA ou EN (0-10)', 'VAS or NRS (0-10)'),
          LString('Légère: 1-3', 'Mild: 1-3'),
          LString('Modérée: 4-6', 'Moderate: 4-6'),
          LString('Sévère: 7-10', 'Severe: 7-10'),
          LString('Échelles comportementales si non communicant', 'Behavioral scales if non-communicative'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Douleur légère (EVA 1-3)', '2. Mild pain (VAS 1-3)'),
        content: LString('Palier 1.', 'Step 1 analgesics.'),
        bulletPoints: [
          LString('Paracétamol 1g PO/IV', 'Acetaminophen 1g PO/IV'),
          LString('Renouveler toutes les 6h si besoin', 'Repeat every 6h as needed'),
          LString('Maximum 4g/24h (3g si > 65 ans ou IHC)', 'Maximum 4g/24h (3g if > 65 yo or liver failure)'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Douleur modérée (EVA 4-6)', '3. Moderate pain (VAS 4-6)'),
        content: LString('Palier 1-2 + AINS.', 'Step 1-2 + NSAIDs.'),
        bulletPoints: [
          LString('Paracétamol + AINS si pas de CI', 'Acetaminophen + NSAIDs if no contraindication'),
          LString('Kétoprofène 100 mg IV ou Ibuprofène 400 mg PO', 'Ketoprofen 100 mg IV or Ibuprofen 400 mg PO'),
          LString('CI AINS: IR, UGD, grossesse 3T, allergie, HTA mal contrôlée', 'NSAID CI: renal failure, PUD, 3rd trimester, allergy, uncontrolled HTN'),
          LString('Tramadol 50-100 mg PO ou Codéine', 'Tramadol 50-100 mg PO or Codeine'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Douleur sévère (EVA 7-10)', '4. Severe pain (VAS 7-10)'),
        content: LString('Morphine.', 'Morphine.'),
        bulletPoints: [
          LString('Titration morphine IV:', 'IV morphine titration:'),
          LString('- Bolus initial: 0.05-0.1 mg/kg (2-3 mg)', '- Initial bolus: 0.05-0.1 mg/kg (2-3 mg)'),
          LString('- Réinjections 1-2 mg toutes les 5-10 min', '- Re-bolus 1-2 mg every 5-10 min'),
          LString('- Objectif EVA < 3', '- Target VAS < 3'),
          LString('Naloxone disponible', 'Naloxone available'),
        ],
        tip: LString('Réévaluer EVA après chaque injection', 'Reassess VAS after each injection'),
      ),
      ProtocolStep(
        title: LString('5. Alternatives et adjuvants', '5. Alternatives and adjuvants'),
        content: LString('Autres options.', 'Other options.'),
        bulletPoints: [
          LString('Kétamine faible dose 0.1-0.3 mg/kg (épargne morphinique)', 'Low-dose ketamine 0.1-0.3 mg/kg (opioid-sparing)'),
          LString('Bloc nerveux si lésion localisée', 'Nerve block if localized injury'),
          LString('MEOPA pour gestes douloureux', 'Nitrous oxide for painful procedures'),
          LString('Nefopam 20 mg IV (contre-indiqué si épilepsie)', 'Nefopam 20 mg IV (contraindicated if epilepsy)'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Populations particulières', '6. Special populations'),
        content: LString('Adapter les doses.', 'Adjust doses.'),
        bulletPoints: [
          LString('Sujet âgé: réduire doses, titration prudente', 'Elderly: reduce doses, careful titration'),
          LString('Insuffisant rénal: éviter AINS, adapter opioïdes', 'Renal failure: avoid NSAIDs, adjust opioids'),
          LString('Grossesse: paracétamol, éviter AINS T3', 'Pregnancy: acetaminophen, avoid NSAIDs in T3'),
          LString('Enfant: doses adaptées au poids', 'Children: weight-adjusted doses'),
        ],
      ),
    ],
    keyPoints: LString('Évaluer EVA. Palier 1-2 si modérée. Morphine titrée si sévère. Réévaluer systématiquement.', 'Assess VAS. Step 1-2 if moderate. Titrated morphine if severe. Reassess systematically.'),
    source: LString('SFMU 2019 - Analgésie aux urgences', 'SFMU 2019 - Analgésie aux urgences'),
    lastUpdated: 2019,
  ),

  // Sédation procédurale
  Protocol(
    id: 'sedation-procedurale',
    name: LString('Sédation Procédurale', 'Procedural Sedation'),
    category: ProtocolCategory.analgesia,
    description: LString('Sédation pour gestes douloureux aux urgences', 'Sedation for painful procedures in the ED'),
    indication: LString('Réduction de luxation, cardioversion, gestes douloureux', 'Dislocation reduction, cardioversion, painful procedures'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation pré-sédation', '1. Pre-sedation assessment'),
        content: LString('Critères de sécurité.', 'Safety criteria.'),
        bulletPoints: [
          LString('Jeûne (relatif selon urgence)', 'Fasting (relative depending on urgency)'),
          LString('Voies aériennes: Mallampati, ouverture bouche', 'Airway: Mallampati, mouth opening'),
          LString('Comorbidités: cardio, respi, obésité', 'Comorbidities: cardiac, respiratory, obesity'),
          LString('Médicaments et allergies', 'Medications and allergies'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Préparation', '2. Preparation'),
        content: LString('Environnement sécurisé.', 'Safe environment.'),
        bulletPoints: [
          LString('Matériel de réanimation disponible', 'Resuscitation equipment available'),
          LString('O2, aspiration, BAVU', 'O2, suction, bag-valve-mask'),
          LString('Antidotes prêts: flumazénil, naloxone', 'Antidotes ready: flumazenil, naloxone'),
          LString('Monitoring: SpO2, capno, ECG, PA', 'Monitoring: SpO2, capnography, ECG, BP'),
          LString('2 personnes: 1 pour sédation, 1 pour geste', '2 persons: 1 for sedation, 1 for procedure'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Protocoles courants', '3. Common protocols'),
        content: LString('Selon indication.', 'According to indication.'),
        bulletPoints: [
          LString('Propofol: 0.5-1 mg/kg IV, titrer par 0.25 mg/kg', 'Propofol: 0.5-1 mg/kg IV, titrate by 0.25 mg/kg'),
          LString('Kétamine: 1-2 mg/kg IV (dissociatif)', 'Ketamine: 1-2 mg/kg IV (dissociative)'),
          LString('Midazolam + Fentanyl: 0.05 mg/kg + 1 µg/kg', 'Midazolam + Fentanyl: 0.05 mg/kg + 1 µg/kg'),
          LString('MEOPA: inhalation pour gestes courts', 'Nitrous oxide: inhalation for short procedures'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Kétamine - spécificités', '4. Ketamine - specifics'),
        content: LString('Option intéressante.', 'Interesting option.'),
        bulletPoints: [
          LString('Maintien réflexes VAS et ventilation', 'Preserves airway reflexes and ventilation'),
          LString('Bronchodilatateur', 'Bronchodilator'),
          LString('Stabilité hémodynamique', 'Hemodynamic stability'),
          LString('Phénomènes émergence: prévenir par midazolam 1 mg', 'Emergence phenomena: prevent with midazolam 1 mg'),
          LString('CI relative: HTA, cardiopathie ischémique', 'Relative CI: hypertension, ischemic heart disease'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Surveillance', '5. Monitoring'),
        content: LString('Pendant et après.', 'During and after.'),
        bulletPoints: [
          LString('Monitoring continu pendant geste', 'Continuous monitoring during procedure'),
          LString('Surveillance post-sédation jusqu\'à réveil complet', 'Post-sedation monitoring until full recovery'),
          LString('Critères de sortie: orientation normale, marche stable', 'Discharge criteria: normal orientation, stable gait'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Gestion des complications', '6. Complication management'),
        content: LString('Réagir vite.', 'React quickly.'),
        bulletPoints: [
          LString('Désaturation: subluxation mâchoire, O2, ventilation', 'Desaturation: jaw thrust, O2, ventilation'),
          LString('Apnée: ventilation au masque, antagonistes', 'Apnea: bag-mask ventilation, antagonists'),
          LString('Hypotension: remplissage, réduire/arrêter sédatif', 'Hypotension: fluids, reduce/stop sedative'),
          LString('Vomissements: aspiration, position latérale', 'Vomiting: suction, lateral position'),
        ],
      ),
    ],
    keyPoints: LString('Environnement sécurisé. Titration. Monitoring continu. Surveillance jusqu\'à réveil complet.', 'Safe environment. Titration. Continuous monitoring. Monitor until full recovery.'),
    source: LString('ACEP - Procedural Sedation', 'ACEP - Procedural Sedation'),
    lastUpdated: 2020,
  ),

  // ALR aux urgences
  Protocol(
    id: 'alr-urgences',
    name: LString('Anesthésie Locorégionale aux Urgences', 'Regional Anesthesia in Emergency'),
    category: ProtocolCategory.analgesia,
    description: LString('Blocs nerveux périphériques pour analgésie', 'Peripheral nerve blocks for analgesia'),
    indication: LString('Analgésie localisée pour trauma, suture, exploration', 'Localized analgesia for trauma, suturing, exploration'),
    steps: [
      ProtocolStep(
        title: LString('1. Indications courantes', '1. Common indications'),
        content: LString('Blocs les plus utilisés.', 'Most commonly used blocks.'),
        bulletPoints: [
          LString('Bloc fémoral: fracture fémur, col fémoral', 'Femoral block: femur fracture, femoral neck'),
          LString('Bloc PENG: fracture hanche', 'PENG block: hip fracture'),
          LString('Bloc axillaire: trauma membre supérieur', 'Axillary block: upper limb trauma'),
          LString('Bloc de la gaine des fléchisseurs: plaie main', 'Flexor tendon sheath block: hand wound'),
          LString('Bloc digital: plaie doigt', 'Digital block: finger wound'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Contre-indications', '2. Contraindications'),
        content: LString('Situations à éviter.', 'Situations to avoid.'),
        bulletPoints: [
          LString('Infection au point de ponction', 'Infection at puncture site'),
          LString('Allergie vraie aux anesthésiques locaux', 'True allergy to local anesthetics'),
          LString('Troubles de coagulation sévères', 'Severe coagulation disorders'),
          LString('Refus du patient', 'Patient refusal'),
          LString('Atteinte neurologique préexistante du territoire', 'Pre-existing neurological deficit in the territory'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Anesthésiques locaux', '3. Local anesthetics'),
        content: LString('Produits et doses.', 'Agents and doses.'),
        bulletPoints: [
          LString('Lidocaïne 1-2%: délai rapide, durée 1-2h', 'Lidocaine 1-2%: rapid onset, duration 1-2h'),
          LString('Dose max: 4 mg/kg (7 mg/kg avec adrénaline)', 'Max dose: 4 mg/kg (7 mg/kg with epinephrine)'),
          LString('Ropivacaïne 0.5%: délai moyen, durée 4-8h', 'Ropivacaine 0.5%: moderate onset, duration 4-8h'),
          LString('Dose max: 3 mg/kg', 'Max dose: 3 mg/kg'),
          LString('Éviter adrénaline: extrémités (doigts, orteils)', 'Avoid epinephrine: extremities (fingers, toes)'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Bloc fémoral (technique)', '4. Femoral block (technique)'),
        content: LString('Fracture du fémur.', 'Femur fracture.'),
        bulletPoints: [
          LString('Repérage: 1-2 cm sous ligament inguinal, latéral à l\'artère', 'Landmark: 1-2 cm below inguinal ligament, lateral to artery'),
          LString('Échoguidage recommandé', 'Ultrasound guidance recommended'),
          LString('Volume: 20-30 mL ropivacaïne 0.5%', 'Volume: 20-30 mL ropivacaine 0.5%'),
          LString('Aspiration avant injection', 'Aspirate before injection'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Toxicité systémique (LAST)', '5. Local Anesthetic Systemic Toxicity (LAST)'),
        content: LString('Complication grave.', 'Serious complication.'),
        bulletPoints: [
          LString('Signes: goût métallique, acouphènes, convulsions, ACR', 'Signs: metallic taste, tinnitus, seizures, cardiac arrest'),
          LString('Arrêter injection', 'Stop injection'),
          LString('Intralipid 20%: 1.5 mL/kg bolus puis 0.25 mL/kg/min', 'Intralipid 20%: 1.5 mL/kg bolus then 0.25 mL/kg/min'),
          LString('RCP si ACR (éviter amiodarone)', 'CPR if cardiac arrest (avoid amiodarone)'),
        ],
        warning: LString('Toujours avoir Intralipid disponible', 'Always have Intralipid available'),
      ),
      ProtocolStep(
        title: LString('6. Documentation', '6. Documentation'),
        content: LString('Traçabilité.', 'Traceability.'),
        bulletPoints: [
          LString('Consentement', 'Consent'),
          LString('Produit, concentration, volume', 'Agent, concentration, volume'),
          LString('Heure, technique', 'Time, technique'),
          LString('Surveillance post-bloc', 'Post-block monitoring'),
        ],
      ),
    ],
    keyPoints: LString('Échoguidage recommandé. Respecter doses max. Intralipid disponible. Efficacité excellente.', 'Ultrasound guidance recommended. Respect max doses. Intralipid available. Excellent efficacy.'),
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
    name: LString('Choc Cardiogénique', 'Cardiogenic Shock'),
    category: ProtocolCategory.resuscitation,
    description: LString('Défaillance cardiaque aiguë avec hypoperfusion tissulaire', 'Acute cardiac failure with tissue hypoperfusion'),
    indication: LString('PAS < 90 mmHg avec signes d\'hypoperfusion et congestion', 'SBP < 90 mmHg with signs of hypoperfusion and congestion'),
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Recognition'),
        content: LString('Diagnostic clinique.', 'Clinical diagnosis.'),
        bulletPoints: [
          LString('Hypotension: PAS < 90 mmHg ou chute > 30 mmHg', 'Hypotension: SBP < 90 mmHg or drop > 30 mmHg'),
          LString('Signes d\'hypoperfusion: marbrures, confusion, oligurie', 'Hypoperfusion signs: mottling, confusion, oliguria'),
          LString('Signes de congestion: OAP, turgescence jugulaire', 'Congestion signs: pulmonary edema, jugular distension'),
          LString('IC bas débit + index cardiaque < 2.2 L/min/m²', 'Low cardiac output + cardiac index < 2.2 L/min/m²'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Étiologies à rechercher', '2. Etiologies to investigate'),
        content: LString('Causes principales.', 'Main causes.'),
        bulletPoints: [
          LString('SCA (80% des cas)', 'ACS (80% of cases)'),
          LString('Complications mécaniques: rupture, CIV, IM aiguë', 'Mechanical complications: rupture, VSD, acute MR'),
          LString('Myocardite aiguë', 'Acute myocarditis'),
          LString('Embolie pulmonaire massive', 'Massive pulmonary embolism'),
          LString('Tamponnade', 'Cardiac tamponade'),
          LString('Décompensation cardiopathie chronique', 'Decompensated chronic heart disease'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Oxygénation', '3. Oxygenation'),
        content: LString('Support respiratoire.', 'Respiratory support.'),
        bulletPoints: [
          LString('O2 si SpO2 < 90%', 'O2 if SpO2 < 90%'),
          LString('VNI si OAP toléré', 'NIV if tolerated pulmonary edema'),
          LString('Intubation si détresse majeure', 'Intubation if major distress'),
          LString('Attention: pression positive peut aggraver le choc', 'Caution: positive pressure may worsen shock'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Remplissage prudent', '4. Cautious fluid loading'),
        content: LString('Test de remplissage limité.', 'Limited fluid challenge.'),
        bulletPoints: [
          LString('250 mL NaCl si pas de congestion évidente', '250 mL NaCl if no obvious congestion'),
          LString('Réévaluer immédiatement', 'Reassess immediately'),
          LString('Éviter si signes de surcharge (OAP)', 'Avoid if signs of overload (pulmonary edema)'),
        ],
        warning: LString('Le remplissage peut aggraver la situation', 'Fluid loading may worsen the situation'),
      ),
      ProtocolStep(
        title: LString('5. Support inotrope', '5. Inotropic support'),
        content: LString('Première ligne médicamenteuse.', 'First-line pharmacotherapy.'),
        bulletPoints: [
          LString('Dobutamine 2.5-20 µg/kg/min (inotrope positif)', 'Dobutamine 2.5-20 µg/kg/min (positive inotrope)'),
          LString('Noradrénaline si hypotension profonde', 'Norepinephrine if profound hypotension'),
          LString('Adrénaline si choc réfractaire', 'Epinephrine if refractory shock'),
          LString('Éviter dopamine (plus d\'arythmies)', 'Avoid dopamine (more arrhythmias)'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Assistance circulatoire', '6. Mechanical circulatory support'),
        content: LString('Si choc réfractaire.', 'If refractory shock.'),
        bulletPoints: [
          LString('Ballon de contre-pulsion intra-aortique (CPBIA)', 'Intra-aortic balloon pump (IABP)'),
          LString('ECMO veino-artérielle', 'Veno-arterial ECMO'),
          LString('Impella (assistance ventriculaire)', 'Impella (ventricular assist)'),
          LString('Décision multidisciplinaire urgente', 'Urgent multidisciplinary decision'),
        ],
      ),
      ProtocolStep(
        title: LString('7. Traitement étiologique', '7. Etiological treatment'),
        content: LString('En parallèle.', 'In parallel.'),
        bulletPoints: [
          LString('SCA: coronarographie urgente', 'ACS: urgent coronary angiography'),
          LString('Complication mécanique: chirurgie', 'Mechanical complication: surgery'),
          LString('Tamponnade: péricardiocentèse', 'Tamponade: pericardiocentesis'),
          LString('EP massive: thrombolyse', 'Massive PE: thrombolysis'),
        ],
      ),
    ],
    keyPoints: LString('Identifier cause. Remplissage prudent. Dobutamine ± noradrénaline. ECMO si réfractaire. Traiter étiologie.', 'Identify cause. Cautious fluids. Dobutamine ± norepinephrine. ECMO if refractory. Treat etiology.'),
    source: LString('ESC Guidelines - Cardiogenic shock', 'ESC Guidelines - Cardiogenic shock'),
    lastUpdated: 2021,
  ),

  // Tamponnade
  Protocol(
    id: 'tamponnade',
    name: LString('Tamponnade Cardiaque', 'Cardiac Tamponade'),
    category: ProtocolCategory.resuscitation,
    description: LString('Compression cardiaque par épanchement péricardique', 'Cardiac compression by pericardial effusion'),
    indication: LString('Triade de Beck + instabilité hémodynamique', 'Beck\'s triad + hemodynamic instability'),
    steps: [
      ProtocolStep(
        title: LString('1. Reconnaissance', '1. Recognition'),
        content: LString('Signes cliniques.', 'Clinical signs.'),
        bulletPoints: [
          LString('Triade de Beck: hypotension, BDC assourdis, turgescence jugulaire', 'Beck\'s triad: hypotension, muffled heart sounds, jugular distension'),
          LString('Pouls paradoxal > 10 mmHg', 'Pulsus paradoxus > 10 mmHg'),
          LString('Tachycardie, dyspnée', 'Tachycardia, dyspnea'),
          LString('Contexte: trauma, péricardite, cancer, chirurgie cardiaque', 'Context: trauma, pericarditis, cancer, cardiac surgery'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Échocardiographie', '2. Echocardiography'),
        content: LString('Confirmation diagnostique.', 'Diagnostic confirmation.'),
        bulletPoints: [
          LString('Épanchement péricardique', 'Pericardial effusion'),
          LString('Collapsus diastolique OD puis VD', 'Diastolic collapse of RA then RV'),
          LString('Variation respiratoire des flux (> 25%)', 'Respiratory flow variation (> 25%)'),
          LString('VCI dilatée sans variation respiratoire', 'Dilated IVC without respiratory variation'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Mesures temporaires', '3. Temporizing measures'),
        content: LString('En attendant drainage.', 'While awaiting drainage.'),
        bulletPoints: [
          LString('Remplissage vasculaire 500-1000 mL', 'Volume loading 500-1000 mL'),
          LString('Position demi-assise', 'Semi-upright position'),
          LString('Éviter ventilation pression positive', 'Avoid positive pressure ventilation'),
          LString('Dobutamine si besoin', 'Dobutamine if needed'),
        ],
        warning: LString('Ne pas retarder le drainage', 'Do not delay drainage'),
      ),
      ProtocolStep(
        title: LString('4. Péricardiocentèse', '4. Pericardiocentesis'),
        content: LString('Geste salvateur.', 'Life-saving procedure.'),
        bulletPoints: [
          LString('Échoguidage +++', 'Ultrasound-guided +++'),
          LString('Voie sous-xiphoïdienne ou apicale', 'Subxiphoid or apical approach'),
          LString('Anesthésie locale', 'Local anesthesia'),
          LString('Aspiration progressive', 'Progressive aspiration'),
          LString('Laisser drain si récidive possible', 'Leave drain if recurrence possible'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Drainage chirurgical', '5. Surgical drainage'),
        content: LString('Indications.', 'Indications.'),
        bulletPoints: [
          LString('Tamponnade traumatique (hémopéricarde)', 'Traumatic tamponade (hemopericardium)'),
          LString('Épanchement cloisonné', 'Loculated effusion'),
          LString('Récidive après péricardiocentèse', 'Recurrence after pericardiocentesis'),
          LString('Nécessité de biopsie péricardique', 'Need for pericardial biopsy'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Causes à rechercher', '6. Etiologies to investigate'),
        content: LString('Étiologie.', 'Etiology.'),
        bulletPoints: [
          LString('Péricardite (virale, tuberculeuse)', 'Pericarditis (viral, tuberculous)'),
          LString('Néoplasie', 'Neoplasm'),
          LString('Urémique', 'Uremic'),
          LString('Dissection aortique', 'Aortic dissection'),
          LString('Iatrogène (cathétérisme, chirurgie)', 'Iatrogenic (catheterization, surgery)'),
          LString('Trauma', 'Trauma'),
        ],
      ),
    ],
    keyPoints: LString('Triade de Beck + écho. Remplissage en attendant. Péricardiocentèse échoguidée. Chirurgie si trauma.', 'Beck\'s triad + echo. Volume loading while waiting. Ultrasound-guided pericardiocentesis. Surgery if trauma.'),
    source: LString('ESC Guidelines - Pericardial diseases', 'ESC Guidelines - Pericardial diseases'),
    lastUpdated: 2015,
  ),

  // Remplissage vasculaire
  Protocol(
    id: 'remplissage-vasculaire',
    name: LString('Remplissage Vasculaire', 'Volume Resuscitation'),
    category: ProtocolCategory.resuscitation,
    description: LString('Stratégie de remplissage en réanimation', 'Fluid resuscitation strategy in critical care'),
    indication: LString('Hypovolémie, état de choc, précharge-dépendance', 'Hypovolemia, shock, preload-dependence'),
    steps: [
      ProtocolStep(
        title: LString('1. Évaluation de la volémie', '1. Volume status assessment'),
        content: LString('Critères cliniques et dynamiques.', 'Clinical and dynamic criteria.'),
        bulletPoints: [
          LString('Clinique: TRC, marbrures, diurèse', 'Clinical: CRT, mottling, urine output'),
          LString('Indices dynamiques: ΔPP > 13%, variations VCI', 'Dynamic indices: ΔPP > 13%, IVC variation'),
          LString('Lever de jambes passif: augmentation VES > 10%', 'Passive leg raise: SV increase > 10%'),
          LString('Test de remplissage: 250-500 mL et réévaluer', 'Fluid challenge: 250-500 mL and reassess'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Choix du soluté', '2. Fluid selection'),
        content: LString('Cristalloïdes en première intention.', 'Crystalloids as first-line.'),
        bulletPoints: [
          LString('NaCl 0.9%: isotonique, référence', 'NaCl 0.9%: isotonic, reference'),
          LString('Ringer lactate: plus physiologique, évite acidose hyperchlorémique', 'Ringer\'s lactate: more physiological, avoids hyperchloremic acidosis'),
          LString('Éviter HEA (risque rénal)', 'Avoid HES (renal risk)'),
          LString('Albumine: peu d\'indications en urgence', 'Albumin: few indications in emergency'),
        ],
        tip: LString('Ringer lactate préféré si gros volumes', 'Ringer\'s lactate preferred for large volumes'),
      ),
      ProtocolStep(
        title: LString('3. Objectifs', '3. Targets'),
        content: LString('Cibles hémodynamiques.', 'Hemodynamic targets.'),
        bulletPoints: [
          LString('PAM ≥ 65 mmHg (≥ 80 si HTA chronique)', 'MAP ≥ 65 mmHg (≥ 80 if chronic hypertension)'),
          LString('Diurèse > 0.5 mL/kg/h', 'Urine output > 0.5 mL/kg/h'),
          LString('Lactates en décroissance', 'Decreasing lactate'),
          LString('Amélioration clinique (marbrures, conscience)', 'Clinical improvement (mottling, consciousness)'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Limites du remplissage', '4. Fluid loading limits'),
        content: LString('Éviter la surcharge.', 'Avoid overload.'),
        bulletPoints: [
          LString('Surveillance signes congestifs', 'Monitor for congestion signs'),
          LString('Pas de volume fixe recommandé', 'No fixed volume recommended'),
          LString('Réévaluation après chaque bolus', 'Reassess after each bolus'),
          LString('Si pas de réponse après 2-3 L: vasopresseurs', 'If no response after 2-3 L: vasopressors'),
        ],
        warning: LString('Surcharge = risque SDRA, œdème cérébral', 'Overload = risk of ARDS, cerebral edema'),
      ),
      ProtocolStep(
        title: LString('5. Situations particulières', '5. Special situations'),
        content: LString('Adapter au contexte.', 'Adapt to context.'),
        bulletPoints: [
          LString('Choc septique: 30 mL/kg initial (guideline)', 'Septic shock: 30 mL/kg initial (guideline)'),
          LString('Choc cardiogénique: prudence ++', 'Cardiogenic shock: extreme caution'),
          LString('Choc hémorragique: hypotension permissive, transfusion précoce', 'Hemorrhagic shock: permissive hypotension, early transfusion'),
          LString('TC grave: éviter hypotension, limiter surcharge', 'Severe TBI: avoid hypotension, limit overload'),
        ],
      ),
    ],
    keyPoints: LString('Cristalloïdes en première ligne. Évaluer réponse au remplissage. Éviter surcharge. Adapter au contexte.', 'Crystalloids first-line. Assess fluid responsiveness. Avoid overload. Adapt to context.'),
    source: LString('Surviving Sepsis Campaign 2021, ESICM', 'Surviving Sepsis Campaign 2021, ESICM'),
    lastUpdated: 2021,
  ),

  // Support vasoactif
  Protocol(
    id: 'support-vasoactif',
    name: LString('Support Vasoactif', 'Vasopressor Support'),
    category: ProtocolCategory.resuscitation,
    description: LString('Utilisation des catécholamines en réanimation', 'Catecholamine use in critical care'),
    indication: LString('Choc persistant malgré remplissage adapté', 'Persistent shock despite adequate fluid resuscitation'),
    steps: [
      ProtocolStep(
        title: LString('1. Noradrénaline', '1. Norepinephrine'),
        content: LString('Vasopresseur de référence.', 'First-line vasopressor.'),
        bulletPoints: [
          LString('Indication: choc avec vasoplégie (septique, anaphylactique)', 'Indication: shock with vasoplegia (septic, anaphylactic)'),
          LString('Dose: 0.1-3 µg/kg/min', 'Dose: 0.1-3 µg/kg/min'),
          LString('Objectif: PAM ≥ 65 mmHg', 'Target: MAP ≥ 65 mmHg'),
          LString('VVC recommandée mais VVP possible initialement', 'CVC recommended but peripheral IV possible initially'),
        ],
        tip: LString('Peut être débuté sur VVP gros calibre < 4-6h', 'Can be started on large-bore peripheral IV < 4-6h'),
      ),
      ProtocolStep(
        title: LString('2. Adrénaline', '2. Epinephrine'),
        content: LString('Inotrope et vasopresseur.', 'Inotrope and vasopressor.'),
        bulletPoints: [
          LString('Indication: choc cardiogénique réfractaire, anaphylaxie', 'Indication: refractory cardiogenic shock, anaphylaxis'),
          LString('Dose: 0.1-1 µg/kg/min', 'Dose: 0.1-1 µg/kg/min'),
          LString('Effets: β1 (inotrope), α1 (vasopresseur), β2 (bronchodilatateur)', 'Effects: β1 (inotrope), α1 (vasopressor), β2 (bronchodilator)'),
          LString('Risque: tachycardie, arythmie, hyperlactatémie', 'Risk: tachycardia, arrhythmia, hyperlactatemia'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Dobutamine', '3. Dobutamine'),
        content: LString('Inotrope pur.', 'Pure inotrope.'),
        bulletPoints: [
          LString('Indication: choc cardiogénique avec PAM maintenue', 'Indication: cardiogenic shock with maintained MAP'),
          LString('Dose: 2.5-20 µg/kg/min', 'Dose: 2.5-20 µg/kg/min'),
          LString('Effet β1 prédominant', 'Predominant β1 effect'),
          LString('Attention: peut baisser la PA (effet β2)', 'Caution: may lower BP (β2 effect)'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Vasopressine/Terlipressine', '4. Vasopressin/Terlipressin'),
        content: LString('Deuxième ligne.', 'Second-line.'),
        bulletPoints: [
          LString('Indication: choc septique réfractaire à noradrénaline', 'Indication: septic shock refractory to norepinephrine'),
          LString('Vasopressine: 0.03 U/min (dose fixe)', 'Vasopressin: 0.03 U/min (fixed dose)'),
          LString('Épargne en catécholamines', 'Catecholamine-sparing'),
          LString('CI: ischémie mésentérique, coronaire', 'CI: mesenteric ischemia, coronary ischemia'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Choix selon type de choc', '5. Selection by shock type'),
        content: LString('Adaptation.', 'Adaptation.'),
        bulletPoints: [
          LString('Septique: Noradrénaline ± vasopressine ± dobutamine', 'Septic: Norepinephrine ± vasopressin ± dobutamine'),
          LString('Cardiogénique: Dobutamine ± noradrénaline', 'Cardiogenic: Dobutamine ± norepinephrine'),
          LString('Anaphylactique: Adrénaline', 'Anaphylactic: Epinephrine'),
          LString('Hémorragique: Noradrénaline (en attendant transfusion)', 'Hemorrhagic: Norepinephrine (while awaiting transfusion)'),
        ],
      ),
      ProtocolStep(
        title: LString('6. Surveillance', '6. Monitoring'),
        content: LString('Monitoring étroit.', 'Close monitoring.'),
        bulletPoints: [
          LString('PA invasive recommandée', 'Invasive BP recommended'),
          LString('VVC avec PVC', 'CVC with CVP'),
          LString('Débit cardiaque si disponible', 'Cardiac output if available'),
          LString('Lactates, ScvO2', 'Lactate, ScvO2'),
          LString('Échographie cardiaque', 'Cardiac ultrasound'),
        ],
      ),
    ],
    keyPoints: LString('Noradrénaline en 1ère ligne. Dobutamine si bas débit. Adapter au type de choc. VVC dès que possible.', 'Norepinephrine first-line. Dobutamine if low output. Adapt to shock type. CVC as soon as possible.'),
    source: LString('Surviving Sepsis Campaign 2021, ESICM', 'Surviving Sepsis Campaign 2021, ESICM'),
    lastUpdated: 2021,
  ),

  // Indications ECMO
  Protocol(
    id: 'ecmo-indications',
    name: LString('Indications ECMO', 'ECMO Indications'),
    category: ProtocolCategory.resuscitation,
    description: LString('Oxygénation par membrane extracorporelle', 'Extracorporeal membrane oxygenation'),
    indication: LString('Défaillance respiratoire ou cardiaque réfractaire', 'Refractory respiratory or cardiac failure'),
    steps: [
      ProtocolStep(
        title: LString('1. Types d\'ECMO', '1. Types of ECMO'),
        content: LString('VV vs VA.', 'VV vs VA.'),
        bulletPoints: [
          LString('ECMO VV (veino-veineuse): défaillance respiratoire isolée', 'VV ECMO (veno-venous): isolated respiratory failure'),
          LString('ECMO VA (veino-artérielle): défaillance cardiaque ± respiratoire', 'VA ECMO (veno-arterial): cardiac ± respiratory failure'),
        ],
      ),
      ProtocolStep(
        title: LString('2. Indications ECMO VV', '2. VV ECMO indications'),
        content: LString('SDRA réfractaire.', 'Refractory ARDS.'),
        bulletPoints: [
          LString('SDRA sévère (PaO2/FiO2 < 80) malgré optimisation', 'Severe ARDS (PaO2/FiO2 < 80) despite optimization'),
          LString('Ventilation protectrice impossible', 'Protective ventilation impossible'),
          LString('Hypercapnie réfractaire avec pH < 7.20', 'Refractory hypercapnia with pH < 7.20'),
          LString('Score Murray > 3', 'Murray score > 3'),
        ],
      ),
      ProtocolStep(
        title: LString('3. Indications ECMO VA', '3. VA ECMO indications'),
        content: LString('Choc cardiogénique réfractaire.', 'Refractory cardiogenic shock.'),
        bulletPoints: [
          LString('Choc cardiogénique réfractaire aux inotropes', 'Cardiogenic shock refractory to inotropes'),
          LString('ACR réfractaire (eCPR) dans conditions spécifiques', 'Refractory cardiac arrest (eCPR) under specific conditions'),
          LString('Post-chirurgie cardiaque', 'Post-cardiac surgery'),
          LString('Bridge vers transplantation ou récupération', 'Bridge to transplant or recovery'),
        ],
      ),
      ProtocolStep(
        title: LString('4. Contre-indications relatives', '4. Relative contraindications'),
        content: LString('À évaluer.', 'To evaluate.'),
        bulletPoints: [
          LString('Âge avancé (selon centres)', 'Advanced age (center-dependent)'),
          LString('Comorbidités majeures', 'Major comorbidities'),
          LString('Défaillance multiviscérale prolongée', 'Prolonged multi-organ failure'),
          LString('Pas de perspective de récupération ou transplantation', 'No prospect of recovery or transplantation'),
          LString('Anticoagulation impossible', 'Anticoagulation impossible'),
        ],
      ),
      ProtocolStep(
        title: LString('5. Critères eCPR', '5. eCPR criteria'),
        content: LString('ECMO pour ACR.', 'ECMO for cardiac arrest.'),
        bulletPoints: [
          LString('Âge < 70 ans (selon centres)', 'Age < 70 years (center-dependent)'),
          LString('No-flow < 5 min', 'No-flow < 5 min'),
          LString('Low-flow < 60-90 min', 'Low-flow < 60-90 min'),
          LString('Cause réversible identifiable', 'Identifiable reversible cause'),
          LString('Pas de comorbidité majeure', 'No major comorbidity'),
          LString('EtCO2 > 10 mmHg pendant RCP', 'EtCO2 > 10 mmHg during CPR'),
        ],
        warning: LString('Décision multidisciplinaire rapide', 'Rapid multidisciplinary decision'),
      ),
      ProtocolStep(
        title: LString('6. Organisation', '6. Organization'),
        content: LString('Mise en place.', 'Implementation.'),
        bulletPoints: [
          LString('Contact centre ECMO', 'Contact ECMO center'),
          LString('Transport médicalisé ou équipe mobile', 'Medicalized transport or mobile team'),
          LString('Canulation percutanée ou chirurgicale', 'Percutaneous or surgical cannulation'),
          LString('Anticoagulation par héparine', 'Heparin anticoagulation'),
        ],
      ),
    ],
    keyPoints: LString('VV = poumon, VA = cœur. Contacter centre ECMO précocement. eCPR = critères stricts.', 'VV = lung, VA = heart. Contact ECMO center early. eCPR = strict criteria.'),
    source: LString('ELSO Guidelines, SFAR', 'ELSO Guidelines, SFAR'),
    lastUpdated: 2021,
  ),
];
