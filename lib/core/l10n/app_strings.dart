import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/providers/language_provider.dart';

const _en = <String, String>{
  // General
  'appName': 'EMtools',
  'appSubtitle': 'Emergency Medical Tools',
  'guest': 'Guest',

  // Navigation
  'dashboard': 'Dashboard',
  'tools': 'Tools',
  'settings': 'Settings',
  'admin': 'Administration',
  'logout': 'Log out',
  'login': 'Log in',
  'register': 'Register',

  // Common Actions
  'save': 'Save',
  'cancel': 'Cancel',
  'delete': 'Delete',
  'edit': 'Edit',
  'add': 'Add',
  'search': 'Search',
  'filter': 'Filter',
  'reset': 'Reset',
  'calculate': 'Calculate',
  'copy': 'Copy',
  'share': 'Share',
  'generate': 'Generate',
  'clear': 'Clear',
  'confirm': 'Confirm',
  'close': 'Close',
  'back': 'Back',
  'next': 'Next',
  'previous': 'Previous',
  'yes': 'Yes',
  'no': 'No',
  'ok': 'OK',
  'loading': 'Loading...',
  'error': 'Error',
  'success': 'Success',
  'warning': 'Warning',
  'info': 'Information',

  // Patient parameters
  'weight': 'Weight',
  'age': 'Age',
  'years': 'years',
  'months': 'months',
  'height': 'Height',
  'sex': 'Sex',
  'male': 'Male',
  'female': 'Female',

  // Time
  'justNow': 'Just now',
  'minutesAgo': '{0} min ago',
  'hoursAgo': '{0}h ago',
  'daysAgo': '{0} days ago',

  // Dashboard
  'welcome': 'Welcome',
  'welcomeBack': 'Welcome back',
  'welcomeMessage': 'Select a tool from the menu to get started.',
  'quickAccess': 'Quick Access',
  'recentTools': 'Recent Tools',
  'recentActivity': 'Recent Activity',
  'allTools': 'All Tools',
  'viewAllTools': 'View all tools',
  'favorites': 'Favorites',
  'searchTools': 'Search for a tool...',
  'toolsAvailable': 'Tools',

  // Activity messages
  'calculatorUsed': 'Calculator used',
  'bloodGasAnalyzed': 'Blood gas analyzed',
  'arterialBlood': 'Arterial blood',
  'reportGenerated': 'Report generated',
  'icuAdmission': 'ICU admission',

  // Greetings
  'goodNight': 'Good night',
  'goodMorning': 'Good morning',
  'goodAfternoon': 'Good afternoon',
  'goodEvening': 'Good evening',

  // Stats
  'statScores': 'Clinical Scores',
  'statProtocols': 'Protocols',
  'statTools': 'Tools',

  // Tools
  'toolsTitle': 'Medical Tools',
  'toolsSubtitle': 'Select a category',
  'calculators': 'Calculators',
  'calculatorsDesc': 'Medical scores and calculators',
  'bloodGas': 'Blood Gas',
  'bloodGasDesc': 'Arterial blood gas analyzer',
  'vasoactive': 'Vasoactive Drugs',
  'vasoactiveDesc': 'Infusion rate calculator',
  'sedation': 'Sedation',
  'sedationDesc': 'Sedation/analgesia doses',
  'medicalReport': 'ABCDE Assessment',
  'medicalReportDesc': 'Structured ABCDE evaluation',
  'antibiotics': 'Antibiotics',
  'antibioticsDesc': 'Prescription guide',
  'antibioticsGuide': 'Antibiotic Guide',
  'antibioticsSubtitle': 'Spectrum, dosage and adjustments',
  'protocols': 'Protocols',
  'protocolsDesc': '55+ emergency protocols',
  'rcpTimer': 'CPR Timer',
  'rcpTimerDesc': 'Timer, cycles, epinephrine',
  'searchAntibiotic': 'Search antibiotic...',
  'noAntibioticFound': 'No antibiotic found',
  'tryAnotherSearch': 'Try another search',
  'all': 'All',
  'penicillins': 'Penicillins',
  'cephalosporins': 'Cephalosporins',
  'carbapenems': 'Carbapenems',
  'aminoglycosides': 'Aminoglycosides',
  'fluoroquinolones': 'Fluoroquinolones',
  'macrolides': 'Macrolides',
  'glycopeptides': 'Glycopeptides',
  'tetracyclines': 'Tetracyclines',
  'sulfonamides': 'Sulfonamides',
  'nitroimidazoles': 'Nitroimidazoles',
  'others': 'Others',
  'oxazolidinones': 'Oxazolidinones',
  'lipopeptides': 'Lipopeptides',
  'lincosamides': 'Lincosamides',
  'monobactams': 'Monobactams',
  'metabolic': 'Metabolic',
  'metabolicDesc': 'Metabolic calculations',
  'paste': 'Paste',
  'pasteDesc': 'Notes and secure sharing',
  'searchTool': 'Search for a tool...',
  'toolsCount': '{0} result{1} for "{2}"',
  'noFavorites': 'No favorites',
  'addFavoritesHint': 'Tap ⭐ to add favorites',
  'noToolFound': 'No tool found',

  // Tool category chips
  'favoritesCategory': '⭐ Favorites',
  'calculatorsCategory': 'Calculators',
  'emergencyCategory': 'Emergencies',
  'icuCategory': 'Intensive Care',
  'toolsCategory': 'Tools',

  // Calculators
  'calculatorCategories': 'Categories',
  'selectCalculator': 'Select a calculator',
  'result': 'Result',
  'interpretation': 'Interpretation',
  'source': 'Source',
  'references': 'References',
  'trauma': 'Trauma',
  'sepsis': 'Sepsis / Infection',
  'peDvt': 'PE / DVT',
  'cardiovascular': 'Cardiovascular',
  'neurology': 'Neurology',
  'gi': 'Gastrointestinal',
  'toxicology': 'Toxicology',
  'msk': 'MSK / Orthopedics',
  'pediatric': 'Pediatrics',
  'laboratory': 'Laboratory',

  // Blood Gas
  'bloodGasTitle': 'Blood Gas Analyzer',
  'arterial': 'Arterial',
  'venous': 'Venous',
  'pH': 'pH',
  'pCO2': 'pCO2',
  'pO2': 'pO2',
  'hCO3': 'HCO3-',
  'baseExcess': 'Base Excess',
  'lactate': 'Lactate',
  'sodium': 'Sodium',
  'potassium': 'Potassium',
  'chloride': 'Chloride',
  'glucose': 'Glucose',
  'hemoglobin': 'Hemoglobin',
  'saturation': 'Saturation',
  'fio2': 'FiO2',
  'temperature': 'Temperature',
  'primaryDisorder': 'Primary Disorder',
  'compensation': 'Compensation',
  'anionGap': 'Anion Gap',
  'correctedAnionGap': 'Corrected AG',
  'deltaRatio': 'Delta Ratio',
  'oxygenation': 'Oxygenation',
  'paoFio2Ratio': 'PaO2/FiO2 Ratio',
  'aaGradient': 'A-a Gradient',
  'normalValues': 'Normal Values',
  'metabolicAcidosis': 'Metabolic Acidosis',
  'metabolicAlkalosis': 'Metabolic Alkalosis',
  'respiratoryAcidosis': 'Respiratory Acidosis',
  'respiratoryAlkalosis': 'Respiratory Alkalosis',
  'mixed': 'Mixed Disorder',
  'compensated': 'Compensated',
  'uncompensated': 'Uncompensated',
  'partiallyCompensated': 'Partially Compensated',

  // Vasoactive Drugs
  'vasoactiveTitle': 'Vasoactive Drugs',
  'drugSelection': 'Drug Selection',
  'patientWeight': 'Patient Weight',
  'targetDose': 'Target Dose',
  'concentration': 'Concentration',
  'infusionRate': 'Infusion Rate',
  'dilution': 'Dilution',
  'syringe': 'Syringe',
  'pump': 'Pump',
  'norepinephrine': 'Norepinephrine',
  'epinephrine': 'Epinephrine',
  'dopamine': 'Dopamine',
  'dobutamine': 'Dobutamine',
  'milrinone': 'Milrinone',
  'vasopressin': 'Vasopressin',
  'phenylephrine': 'Phenylephrine',

  // Sedation
  'sedationTitle': 'Sedation Calculator',
  'sedationAnalgesia': 'Sedation & Analgesia',
  'sedationScore': 'Sedation Score',
  'targetRASS': 'Target RASS',
  'currentRASS': 'Current RASS',
  'bolus': 'Bolus',
  'maintenance': 'Maintenance',
  'propofol': 'Propofol',
  'midazolam': 'Midazolam',
  'ketamine': 'Ketamine',
  'fentanyl': 'Fentanyl',
  'morphine': 'Morphine',
  'dexmedetomidine': 'Dexmedetomidine',
  'rsiTab': 'RSI',
  'proceduralTab': 'Procedural',
  'allDrugsTab': 'All',
  'premedication': 'Premedication / Adjuvants',
  'induction': 'Induction',
  'paralysis': 'Paralysis',
  'proceduralOptions': 'Procedural sedation options',
  'doseCalculation': 'Dose calculation',
  'concentrations': 'Concentrations',
  'mechanism': 'Mechanism of action',
  'indications': 'Indications',
  'contraindications': 'Contraindications',
  'sideEffects': 'Side effects',
  'precautions': 'Precautions',
  'onset': 'Onset',
  'duration': 'Duration',
  'maxReached': 'Max dose reached',
  'infant': 'Infant',
  'child': 'Child',
  'adult': 'Adult',
  'elderly': 'Elderly',
  'ageGroup': 'Age group',
  'patientParameters': 'Patient Parameters',
  'drugClass': 'Class',
  'totalDose': 'Total Dose',
  'perKg': 'per kg',
  'seconds': 'seconds',
  'minutes': 'minutes',
  'tapForDetails': 'Tap for details',
  'allSedationDrugs': 'All Drugs',
  'searchDrugs': 'Search drug...',
  'noDrugsFound': 'No drugs found',
  'rapidSequence': 'Rapid Sequence Intubation',
  'proceduralSedation': 'Procedural Sedation',

  // Medical Report
  'medicalReportTitle': 'ABCDE Assessment',
  'patientInfo': 'Patient Information',
  'chiefComplaint': 'Chief Complaint',
  'historyOfPresentIllness': 'History of Present Illness',
  'pastMedicalHistory': 'Past Medical History',
  'medications': 'Medications',
  'allergies': 'Allergies',
  'familyHistory': 'Family History',
  'socialHistory': 'Social History',
  'physicalExam': 'Physical Exam',
  'vitalSigns': 'Vital Signs',
  'assessment': 'Assessment',
  'plan': 'Plan',
  'diagnosis': 'Diagnosis',
  'differentialDiagnosis': 'Differential Diagnosis',
  'investigations': 'Investigations',
  'treatment': 'Treatment',
  'followUp': 'Follow-up',
  'notes': 'Notes',
  'generateReport': 'Generate Report',
  'copyReport': 'Copy Report',
  'shareReport': 'Share Report',

  // Settings
  'settingsTitle': 'Settings',
  'appearance': 'Appearance',
  'theme': 'Theme',
  'lightTheme': 'Light',
  'darkTheme': 'Dark',
  'systemTheme': 'System',
  'language': 'Language',
  'french': 'Français',
  'english': 'English',
  'arabic': 'العربية',
  'notifications': 'Notifications',
  'about': 'About',
  'version': 'Version',
  'termsOfService': 'Terms of Service',
  'privacyPolicy': 'Privacy Policy',
  'licenses': 'Licenses',
  'contactUs': 'Contact Us',
  'rateApp': 'Rate the App',
  'darkMode': 'Dark mode',

  // Auth
  'email': 'Email Address',
  'password': 'Password',
  'confirmPassword': 'Confirm Password',
  'fullName': 'Full Name',
  'username': 'Username',
  'forgotPassword': 'Forgot Password?',
  'resetPassword': 'Reset Password',
  'noAccount': 'No account yet?',
  'haveAccount': 'Already have an account?',
  'createAccount': 'Create Account',
  'signIn': 'Sign In',
  'signOut': 'Sign Out',
  'signUp': 'Sign Up',

  // Admin
  'adminTitle': 'Administration',
  'users': 'Users',
  'userManagement': 'User Management',
  'statistics': 'Statistics',
  'analytics': 'Analytics',
  'systemSettings': 'System Settings',
  'logs': 'Logs',
  'active': 'Active',
  'inactive': 'Inactive',
  'banned': 'Banned',
  'role': 'Role',
  'adminRole': 'Administrator',
  'userRole': 'User',
  'moderatorRole': 'Moderator',

  // Errors
  'errorGeneric': 'An error occurred. Please try again.',
  'errorNetwork': 'Connection error. Check your internet connection.',
  'errorServer': 'Server error. Please try again later.',
  'errorAuth': 'Authentication error. Please log in again.',
  'errorNotFound': 'Resource not found.',
  'errorValidation': 'Please check the entered information.',
  'errorRequired': 'This field is required',
  'errorInvalidEmail': 'Invalid email address',
  'errorPasswordLength': 'Password must be at least 8 characters',
  'errorPasswordMatch': 'Passwords do not match',

  // Success Messages
  'successSaved': 'Saved successfully',
  'successDeleted': 'Deleted successfully',
  'successCopied': 'Copied to clipboard',
  'successUpdated': 'Updated successfully',
  'successLogout': 'Logged out successfully',
  'successLogin': 'Logged in successfully',

  // Units
  'kg': 'kg',
  'lbs': 'lbs',
  'cm': 'cm',
  'm': 'm',
  'mmHg': 'mmHg',
  'kPa': 'kPa',
  'mgDl': 'mg/dL',
  'mmolL': 'mmol/L',
  'gDl': 'g/dL',
  'percent': '%',
  'bpm': 'bpm',
  'perMin': '/min',
  'mcgKgMin': 'µg/kg/min',
  'mgKgH': 'mg/kg/h',
  'mlH': 'mL/h',
  'celsius': '°C',
  'fahrenheit': '°F',

  // App shell
  'addPatientMeds': 'Add patient medications',
  'noInteractionsDetected': 'No interactions detected',
  'searchProtocols': 'Search protocols...',
  'noProtocolsFound': 'No protocols found',
  'noEventsRecorded': 'No events recorded',
  'pediatricsOnly': 'Pediatrics only',
  'protocolsPlural': 'protocols',
  'protocolCount': '{0} protocol{1}',
  'favoritesCount': '{0} favorite{1}',
  'totalLabel': 'Total: {0}',
  'patientWeightLabel': 'Patient Weight',

  'dashboardTab': 'Dashboard',
  'toolsTab': 'Tools',
  'settingsTab': 'Settings',

  // Medical Report UI labels
  'formTab': 'Form',
  'previewTab': 'Preview',
  'patientName': 'Patient Name',
  'traumaContext': 'Trauma Context',
  'traumaSubtitle': 'Activate to add trauma details',
  'mechanismOfInjury': 'Mechanism of injury',
  'airwayStatus': 'Airway Status',
  'deviceAction': 'Device / Action',
  'breathing': 'Respiration',
  'respiratoryRate': 'Respiratory Rate (/min)',
  'spo2Label': 'SpO2 (%)',
  'workOfBreathing': 'Work of Breathing',
  'wobSuprasternal': 'Suprasternal retraction',
  'wobSubcostal': 'Subcostal retraction',
  'wobIntercostal': 'Intercostal retraction',
  'wobParadoxical': 'Paradoxical breathing',
  'wobGasping': 'Gasping',
  'chestExpansion': 'Chest Expansion',
  'ribCrepitus': 'Rib Crepitus',
  'ribCrepitusHint': 'Location (ex: R5-R7 left)',
  'subcuEmphysema': 'Subcutaneous Emphysema',
  'subcuEmphysemaSub': 'Crepitus on palpation',
  'lungAuscultation': 'Lung Auscultation',
  'lungAuscultationHint': 'Ex: symmetric breath sounds, bibasilar crackles, diffuse wheezing...',
  'oxygenDevice': 'O2 Device',
  'flowRate': 'Flow Rate (L/min)',
  'breathingAction': 'Breathing Actions',
  'breathingActionHint': 'Ex: Intubation, chest tube...',
  'circulation': 'Circulation',
  'extremities': 'Extremities',
  'shockSigns': 'Peripheral Shock Signs',
  'mottling': 'Mottling',
  'crtProlonged': 'CRT > 3s',
  'weakPulse': 'Weak Pulse',
  'pulseAsymmetry': 'Pulse Asymmetry',
  'heartFailureSigns': 'Right Heart Signs',
  'jugularDistension': 'Jugular Distension',
  'peripheralEdema': 'Peripheral Edema',
  'bpRight': 'BP Right',
  'bpLeft': 'BP Left',
  'heartRate': 'Heart Rate (bpm)',
  'rhythm': 'Rhythm',
  'ventricularRate': 'Ventricular Rate',
  'pWave': 'P Wave',
  'prInterval': 'PR Interval',
  'tWave': 'T Wave',
  'qrs': 'QRS',
  'blockType': 'Block Type',
  'sgarbossaCriteria': 'Sgarbossa Criteria',
  'sgarbossaSubtitle': 'ST discordance > 5mm or concordance',
  'stSegment': 'ST Segment',
  'stSegmentHint': 'Ex: isoelectric, ST elevation V1-V4, lateral depression...',
  'pupils': 'Pupils',
  'pupilDetails': 'Pupil Details',
  'neuroDeficit': 'Neurological Deficit',
  'neuroDeficitHint': 'Ex: no deficit, right hemiparesis, paraplegia...',
  'associatedAphasia': 'Associated Aphasia',
  'capGlucose': 'Capillary Glucose (g/dL)',
  'warningSigns': 'Warning Signs',
  'meningealSyndrome': 'Meningeal Syndrome',
  'purpura': 'Purpura',
  'gcsScore': 'Glasgow Coma Scale (GCS)',
  'gcsEyes': 'Eyes (E)',
  'gcsVerbal': 'Verbal (V)',
  'gcsMotor': 'Motor (M)',
  'exposure': 'Exposure',
  'hpiLabel': 'History of Present Illness',
  'pastHistory': 'Past Medical History',
  'smoking': 'Smoking',
  'alcohol': 'Alcohol',
  'restOfExam': 'Rest of Physical Exam',
  'reAbdomen': 'Soft non-tender abdomen',
  'reCalves': 'Soft calves',
  'reDehydration': 'No signs of dehydration',
  'reDefense': 'No guarding or rigidity',
  'reBHA': 'Bowel sounds present',
  'reMass': 'No palpable mass',
  'reEdema': 'No lower limb edema',
  'reSkinFold': 'No skin tenting',
  'reLymphNodes': 'No lymphadenopathy',
  'reKidneys': 'Normal renal angles',
  'otherFindings': 'Other findings...',
  'catSection': 'Plan (CAT)',
  'catHospitalize': 'Hospitalization',
  'catMonitor': 'Telemetry monitoring',
  'catConditioning': 'Conditioning',
  'catIVLine': 'IV access',
  'catLabs': 'Lab work',
  'catCTBrain': 'Head CT',
  'catCTBody': 'CT Thorax/Abdomen/Pelvis',
  'catChestXray': 'Chest X-ray',
  'catECG18': '18-lead ECG',
  'catUltrasound': 'Ultrasound',
  'catConsult': 'Specialist consult',
  'catFluids': 'IV fluids',
  'catOxygen': 'Oxygen therapy',
  'catIntubation': 'Endotracheal intubation',
  'catAntibiotics': 'Antibiotics',
  'catAnalgesics': 'Analgesics',
  'catObserve': 'Observation',
  'catDischarge': 'Discharge with prescription',
  'catDetails': 'Plan details...',
  'reportPreview': 'Report Preview',
  'reportWillAppear': 'The report will appear here',
  'airwayLabel': 'Airway',
  'abcdeSubtitle': 'Structured ABCDE Assessment',
  // Context section
  'contextSection': 'Context',
  // Airway dropdown
  'airwayClear': 'Clear',
  'airwayObstructed': 'Obstructed',
  'airwayThreatened': 'Threatened',
  // Chest expansion
  'chestSymmetric': 'Symmetric',
  'chestAsymmetric': 'Asymmetric',
  // Oxygen device
  'oxygenNone': 'None',
  'oxygenNasal': 'Nasal cannula',
  'oxygenSimpleMask': 'Simple mask',
  'oxygenNRB': 'Non-rebreather',
  'oxygenNIV': 'NIV',
  // Extremities
  'extremitiesWarm': 'Warm, well perfused',
  'extremitiesCold': 'Cold',
  'extremitiesCyanotic': 'Cyanotic',
  // Heart failure signs
  'hjrLabel': 'HJR',
  // ECG rhythm
  'ecgSinus': 'Sinus',
  'ecgIrregular': 'Irregular',
  'ecgAFib': 'AFib',
  'ecgFlutter': 'Flutter',
  // ECG components
  'ecgNormal': 'Normal',
  'ecgTall': 'Tall',
  'ecgBiphasic': 'Biphasic',
  'ecgProlonged': 'Prolonged',
  'ecgShort': 'Short',
  'ecgFlat': 'Flat',
  'ecgInverted': 'Inverted',
  // QRS
  'qrsNarrow': 'Narrow (< 120ms)',
  'qrsWide': 'Wide (≥ 120ms)',
  // Pupils
  'pupilsPERRL': 'PERRL (reactive)',
  'pupilsAnisocoria': 'Anisocoria',
  'pupilsFixed': 'Fixed',

  // Antibiotic Detail
  'infoTab': 'Information',
  'renalDoseTab': 'Renal Dose',
  'interactionsTab': 'Interactions',
  'standardDosage': 'Standard Dosage',
  'additionalInformation': 'Additional Information',
  'pregnancyCategoryLabel': 'Pregnancy Category',
  'gfrCalculator': 'GFR Calculator',
  'gfrLabel': 'GFR:',
  'recommendedDose': 'Recommended Dose',
  'referenceTable': 'Reference Table',
  'mlPerMin': 'mL/min',

  // Blood Gas UI
  'completeAnalysis': 'Complete analysis with ventilation',
  'calculatedParameters': 'Calculated Parameters',
  'vtPerKgPBW': 'Vt/kg PBW',
  'drivingPressureMetric': 'Driving Pressure',
  'caO2': 'CaO₂',
  'bloodGasSection': 'Blood Gas',
  'biochemistrySection': 'Biochemistry',
  'albumin': 'Albumin',
  'ventilatorSection': 'Ventilator',
  'vt': 'Vt',
  'respiratoryRateLabel': 'RR',
  'peep': 'PEEP',
  'pplat': 'Pplat',
  'ppeak': 'Ppeak',
  'referencesFormulas': 'References & Formulas',
  'winterFormula': "Winter's Formula",
  'aaGradientRef': 'A-a Gradient',
  'pfRatioBerlin': 'P/F Ratio (Berlin 2012)',
  'arterialO2Content': 'Arterial O2 Content',
  'adrogueMadiasFormula': "Adrogue-Madias Formula",
  'pbwFormula': 'PBW (Ideal Body Weight)',
  'disclaimerTool': '⚠️ This tool is for informational purposes only. Clinical decisions must always be based on medical judgment.',

  // RCP Timer
  'unknownRhythm': 'Unknown',
  'vfPulselessVt': 'VF/Pulseless VT',
  'asystoleRhythm': 'Asystole',
  'peaRhythm': 'PEA',
  'roscRhythm': 'ROSC',
  'cprStarted': 'CPR started',
  'cprPaused': 'CPR paused',
  'adrenalineAdministered': 'Adrenaline administered ({0}mg total)',
  'shockDelivered': 'Shock #{0}',
  'amiodaroneAdministered': 'Amiodarone administered',
  'rhythmRecorded': 'Rhythm: {0}',
  'cycleCompleteMsg': 'Cycle {0} complete - Check rhythm!',
  'adrenalineNow': 'Adrenaline 1mg IV/IO now!',
  'cprSettings': 'CPR Settings',
  'adrenalineInterval': 'Adrenaline Interval',
  'recommendationRhythm': 'Recommendation: 3–5 min depending on rhythm',
  'metronomeSizeLabel': 'Metronome Size',
  'vibrationLabel': 'Vibration',
  'hapticFeedbackDesc': 'Haptic feedback for alerts',
  'soundLabel': 'Sound',
  'soundAlertsDesc': 'Audible alerts (coming soon)',
  'cprTimerTitle': 'CPR Timer',
  'historyLabel': 'History',
  'cprInProgress': 'CPR IN PROGRESS',
  'totalTime': 'Total Time',
  'cycleLabel': 'Cycle',
  'secondsRemaining': '{0}s remaining',
  'adrenalineLabel': 'Adrenaline',
  'nowExcl': 'NOW!',
  'totalMg': 'Total: {0} mg',
  'metronomeCompressions': 'Compression Metronome',
  'targetRate': 'Target: 100–120/min',
  'compressionsCount': 'Compressions: {0}',
  'cardiacRhythm': 'Cardiac Rhythm',
  'shockableRhythmMsg': 'Shockable rhythm — Defibrillation indicated',
  'done': 'DONE',
  'roscPostArrest': 'ROSC — Post-cardiac arrest care',
  'quickActions': 'Quick Actions',
  'shocksCount': '{0} shocks',
  'shockAction': 'Shock ({0})',
  'amiodaroneLabel': 'Amiodarone',
  'pauseLabel': 'PAUSE',
  'startLabel': 'START',
  'eventHistory': 'Event History',

  // Protocol Detail
  'protocolNotFound': 'Protocol not found',
  'pediatricsBadge': 'Pediatrics',
  'expandAll': 'Expand all',
  'collapseAll': 'Collapse all',
  'viewSource': 'View source',
  'keyPointsSection': 'Key Points',
  'sourceLabel': 'Source',
  'protocolSteps': 'Protocol Steps',
  'lastUpdated': 'Last updated: {0}',
  'stepsCountLabel': '{0} steps',

  // Settings
  'appDisclaimer': '⚠️ This application is a decision-support tool and does not replace clinical judgment.',

  // Vasoactive
  'vasopressors': 'Vasopressors',
  'inotropes': 'Inotropes',
  'vasodilators': 'Vasodilators',
  'mixedCategory': 'Mixed',
  'pumpRate': 'Pump Rate',
  'pumpCalculator': 'Pump Calculator',
  'concentrationPreparation': 'Concentration / Preparation',
  'doseLabel': 'Dose',
  'typicalDose': 'Typical: {0}',
  'uiPerMin': 'UI/min',
  'syringeVolume': 'Syringe Volume',
  'receptorEffects': 'Receptor Effects',

  // Metabolic
  'metabolicDisorders': 'Metabolic Disorders',
  'metabolicSubtitle': 'Sodium • Potassium • Calcium',
  'sodiumTab': 'Sodium',
  'potassiumTab': 'Potassium',
  'calciumTab': 'Calcium',
  'sodiumParameters': 'Sodium Parameters',
  'hyponatremia': 'Hyponatremia',
  'hypernatremia': 'Hypernatremia',
  'currentNa': 'Current Na (mEq/L)',
  'targetNa': 'Target Na (mEq/L)',
  'correctionMode': 'Correction Mode',
  'chronic': 'Chronic (>48h)',
  'acute': 'Acute (<48h)',
  'soluteSelection': 'Solution Selection',
  'soluteA': 'Solute A',
  'soluteB': 'Solute B',
  'infusionRates': 'Infusion Rates',
  'totalFlowRate': 'Total Flow Rate',
  'predictedVariation': 'Predicted Variation',
  'detailLabel': 'Details',
  'totalBodyWater': 'Total Body Water',
  'freeWaterDeficit': 'Free Water Deficit',
  'sodiumDeficitLabel': 'Sodium Deficit',
  'kaliemia': 'Kalemia',
  'potassiumLevel': 'Potassium (mEq/L)',
  'ecgFindings': 'ECG Findings',
  'typicallySeenK': 'Typically seen if K > {0}',
  'recommendedTreatments': 'Recommended Treatments',
  'calcemia': 'Calcemia',
  'calciumTotal': 'Total Calcium (mg/dL)',
  'albuminLabel': 'Albumin (g/dL)',
  'correctedCalcium': 'Corrected Calcium',
  'formulaLabel': 'Formula',
  'calciumFormula': 'Corrected Ca = Total Ca + 0.8 × (4 - Albumin)',
  'normalValuesRange': 'Normal values: 8.5 - 10.5 mg/dL',
  'criticalStatus': 'Critical',
  'elevatedStatus': 'Elevated',
  'lowStatus': 'Low',
  'normalStatus': 'Normal',
  'hypocalcemiaSevere': 'Severe Hypocalcemia',
  'hypocalcemia': 'Hypocalcemia',
  'hypercalcemiaSevere': 'Severe Hypercalcemia',
  'hypercalcemia': 'Hypercalcemia',
  'urgencyImmediate': 'Immediate',
  'urgencyUrgent': 'Urgent',
  'urgencyAdjunct': 'Adjunct',
  'urgencyDefinitive': 'Definitive',
  'naRateRecoHypoAcute': '1-2 mEq/L/h (max 8-10 mEq/L/24h)',
  'naRateRecoHypoChronic': '≤0.5 mEq/L/h (max 8 mEq/L/24h)',
  'naRateRecoHyperAcute': '1-2 mEq/L/h (max 12 mEq/L/24h)',
  'naRateRecoHyperChronic': '≤0.5 mEq/L/h (max 10-12 mEq/L/24h)',
  'naRateWarningHypoAcute': 'Rapid correction acceptable if onset <48h',
  'naRateWarningHypoChronic': '⚠️ Risk of central pontine myelinolysis if correction too rapid',
  'naRateWarningHyperAcute': 'Rapid correction possible if onset <24h',
  'naRateWarningHyperChronic': '⚠️ Risk of cerebral edema if correction too rapid',
  'naSafeMarginHypoAcute': '✓ Safe: ≤10 mEq/L in 24h, ≤18 mEq/L in 48h',
  'naSafeMarginHypoChronic': '✓ Safe: ≤8 mEq/L in 24h (10-12 if Na<120 + symptoms)',
  'naSafeMarginHyperAcute': '✓ Safe: ≤12 mEq/L in 24h (if acute)',
  'naSafeMarginHyperChronic': '✓ Safe: ≤10 mEq/L in 24h (chronic)',
  'naDangerMarginHypoAcute': '⚠️ ODS Danger: >10-12 mEq/L in 24h',
  'naDangerMarginHypoChronic': '⚠️ ODS Danger: >8 mEq/L in 24h if chronic',
  'naDangerMarginHyperAcute': '⚠️ Danger: Cerebral edema if >12 mEq/L/24h',
  'naDangerMarginHyperChronic': '⚠️ Danger: Cerebral edema if >12 mEq/L/24h',
  'soluteATotalLabel': 'Solute A ({0})',
  'soluteBTotalLabel': 'Solute B ({0})',
  'correctionRateTitle': 'Recommended Rate ({0})',

  // Sedation
  'newborn': 'Newborn',
};

const _fr = <String, String>{
  // General
  'appName': 'EMtools',
  'appSubtitle': 'Outils Médicaux d\'Urgence',
  'guest': 'Invité',

  // Navigation
  'dashboard': 'Tableau de Bord',
  'tools': 'Outils',
  'settings': 'Paramètres',
  'admin': 'Administration',
  'logout': 'Déconnexion',
  'login': 'Connexion',
  'register': 'Inscription',

  // Common Actions
  'save': 'Enregistrer',
  'cancel': 'Annuler',
  'delete': 'Supprimer',
  'edit': 'Modifier',
  'add': 'Ajouter',
  'search': 'Rechercher',
  'filter': 'Filtrer',
  'reset': 'Réinitialiser',
  'calculate': 'Calculer',
  'copy': 'Copier',
  'share': 'Partager',
  'generate': 'Générer',
  'clear': 'Effacer',
  'confirm': 'Confirmer',
  'close': 'Fermer',
  'back': 'Retour',
  'next': 'Suivant',
  'previous': 'Précédent',
  'yes': 'Oui',
  'no': 'Non',
  'ok': 'OK',
  'loading': 'Chargement...',
  'error': 'Erreur',
  'success': 'Succès',
  'warning': 'Attention',
  'info': 'Information',

  // Patient parameters
  'weight': 'Poids',
  'age': 'Âge',
  'years': 'ans',
  'months': 'mois',
  'height': 'Taille',
  'sex': 'Sexe',
  'male': 'Homme',
  'female': 'Femme',

  // Time
  'justNow': 'À l\'instant',
  'minutesAgo': 'Il y a {0} min',
  'hoursAgo': 'Il y a {0}h',
  'daysAgo': 'Il y a {0} jours',

  // Dashboard
  'welcome': 'Bienvenue',
  'welcomeBack': 'Bon retour',
  'welcomeMessage': 'Sélectionnez un outil dans le menu pour commencer.',
  'quickAccess': 'Accès Rapide',
  'recentTools': 'Outils Récents',
  'recentActivity': 'Activité Récente',
  'allTools': 'Tous les Outils',
  'viewAllTools': 'Voir tous les outils',
  'favorites': 'Favoris',
  'searchTools': 'Rechercher un outil...',
  'toolsAvailable': 'Outils',

  // Activity messages
  'calculatorUsed': 'Calculateur utilisé',
  'bloodGasAnalyzed': 'Gazométrie analysée',
  'arterialBlood': 'Sang artériel',
  'reportGenerated': 'Rapport généré',
  'icuAdmission': 'Admission aux soins intensifs',

  // Greetings
  'goodNight': 'Bonne nuit',
  'goodMorning': 'Bonjour',
  'goodAfternoon': 'Bon après-midi',
  'goodEvening': 'Bonsoir',

  // Stats
  'statScores': 'Scores cliniques',
  'statProtocols': 'Protocoles',
  'statTools': 'Outils',

  // Tools
  'toolsTitle': 'Outils Médicaux',
  'toolsSubtitle': 'Sélectionnez une catégorie',
  'calculators': 'Calculateurs',
  'calculatorsDesc': 'Scores et calculateurs médicaux',
  'bloodGas': 'Gazométrie',
  'bloodGasDesc': 'Analyseur de gaz du sang',
  'vasoactive': 'Drogues Vasoactives',
  'vasoactiveDesc': 'Calcul des posologies',
  'sedation': 'Sédation',
  'sedationDesc': 'Doses de sédation/analgésie',
  'medicalReport': 'Évaluation ABCDE',
  'medicalReportDesc': 'Évaluation structurée ABCDE',
  'antibiotics': 'Antibiotiques',
  'antibioticsDesc': 'Guide de prescription',
  'antibioticsGuide': 'Guide Antibiotiques',
  'antibioticsSubtitle': 'Spectre, posologie et ajustements',
  'protocols': 'Protocoles',
  'protocolsDesc': '55+ protocoles d\'urgence',
  'rcpTimer': 'Chronomètre RCP',
  'rcpTimerDesc': 'Timer, cycles, adrénaline',
  'searchAntibiotic': 'Rechercher un antibiotique...',
  'noAntibioticFound': 'Aucun antibiotique trouvé',
  'tryAnotherSearch': 'Essayez une autre recherche',
  'all': 'Tous',
  'penicillins': 'Pénicillines',
  'cephalosporins': 'Céphalosporines',
  'carbapenems': 'Carbapénèmes',
  'aminoglycosides': 'Aminosides',
  'fluoroquinolones': 'Fluoroquinolones',
  'macrolides': 'Macrolides',
  'glycopeptides': 'Glycopeptides',
  'tetracyclines': 'Tétracyclines',
  'sulfonamides': 'Sulfamides',
  'nitroimidazoles': 'Nitroimidazoles',
  'others': 'Autres',
  'oxazolidinones': 'Oxazolidinones',
  'lipopeptides': 'Lipopeptides',
  'lincosamides': 'Lincosamides',
  'monobactams': 'Monobactames',
  'metabolic': 'Métabolique',
  'metabolicDesc': 'Calculs métaboliques',
  'paste': 'Paste',
  'pasteDesc': 'Notes et partage sécurisé',
  'searchTool': 'Rechercher un outil...',
  'toolsCount': '{0} résultat{1} pour "{2}"',
  'noFavorites': 'Aucun favori',
  'addFavoritesHint': 'Appuyez sur ⭐ pour ajouter des favoris',
  'noToolFound': 'Aucun outil trouvé',

  // Tool category chips
  'favoritesCategory': '⭐ Favoris',
  'calculatorsCategory': 'Calculateurs',
  'emergencyCategory': 'Urgences',
  'icuCategory': 'Réanimation',
  'toolsCategory': 'Outils',

  // Calculators
  'calculatorCategories': 'Catégories',
  'selectCalculator': 'Sélectionner un calculateur',
  'result': 'Résultat',
  'interpretation': 'Interprétation',
  'source': 'Source',
  'references': 'Références',
  'trauma': 'Trauma',
  'sepsis': 'Sepsis / Infection',
  'peDvt': 'EP / TVP',
  'cardiovascular': 'Cardiovasculaire',
  'neurology': 'Neurologie',
  'gi': 'Gastro-intestinal',
  'toxicology': 'Toxicologie',
  'msk': 'MSK / Orthopédie',
  'pediatric': 'Pédiatrie',
  'laboratory': 'Laboratoire',

  // Blood Gas
  'bloodGasTitle': 'Analyseur de Gazométrie',
  'arterial': 'Artériel',
  'venous': 'Veineux',
  'pH': 'pH',
  'pCO2': 'pCO2',
  'pO2': 'pO2',
  'hCO3': 'HCO3-',
  'baseExcess': 'Excès de Base',
  'lactate': 'Lactate',
  'sodium': 'Sodium',
  'potassium': 'Potassium',
  'chloride': 'Chlore',
  'glucose': 'Glucose',
  'hemoglobin': 'Hémoglobine',
  'saturation': 'Saturation',
  'fio2': 'FiO2',
  'temperature': 'Température',
  'primaryDisorder': 'Trouble Primaire',
  'compensation': 'Compensation',
  'anionGap': 'Trou Anionique',
  'correctedAnionGap': 'TA Corrigé',
  'deltaRatio': 'Ratio Delta',
  'oxygenation': 'Oxygénation',
  'paoFio2Ratio': 'Rapport PaO2/FiO2',
  'aaGradient': 'Gradient A-a',
  'normalValues': 'Valeurs Normales',
  'metabolicAcidosis': 'Acidose Métabolique',
  'metabolicAlkalosis': 'Alcalose Métabolique',
  'respiratoryAcidosis': 'Acidose Respiratoire',
  'respiratoryAlkalosis': 'Alcalose Respiratoire',
  'mixed': 'Trouble Mixte',
  'compensated': 'Compensé',
  'uncompensated': 'Non Compensé',
  'partiallyCompensated': 'Partiellement Compensé',

  // Vasoactive Drugs
  'vasoactiveTitle': 'Drogues Vasoactives',
  'drugSelection': 'Sélection du Médicament',
  'patientWeight': 'Poids du Patient',
  'targetDose': 'Dose Cible',
  'concentration': 'Concentration',
  'infusionRate': 'Débit de Perfusion',
  'dilution': 'Dilution',
  'syringe': 'Seringue',
  'pump': 'Pompe',
  'norepinephrine': 'Noradrénaline',
  'epinephrine': 'Adrénaline',
  'dopamine': 'Dopamine',
  'dobutamine': 'Dobutamine',
  'milrinone': 'Milrinone',
  'vasopressin': 'Vasopressine',
  'phenylephrine': 'Phényléphrine',

  // Sedation
  'sedationTitle': 'Calculateur de Sédation',
  'sedationAnalgesia': 'Sédation & Analgésie',
  'sedationScore': 'Score de Sédation',
  'targetRASS': 'RASS Cible',
  'currentRASS': 'RASS Actuel',
  'bolus': 'Bolus',
  'maintenance': 'Entretien',
  'propofol': 'Propofol',
  'midazolam': 'Midazolam',
  'ketamine': 'Kétamine',
  'fentanyl': 'Fentanyl',
  'morphine': 'Morphine',
  'dexmedetomidine': 'Dexmédétomidine',
  'rsiTab': 'ISR',
  'proceduralTab': 'Procédurale',
  'allDrugsTab': 'Tous',
  'premedication': 'Prémédication / Adjuvants',
  'induction': 'Induction',
  'paralysis': 'Paralysie',
  'proceduralOptions': 'Options pour sédation procédurale',
  'doseCalculation': 'Calcul de dose',
  'concentrations': 'Concentrations',
  'mechanism': 'Mécanisme d\'action',
  'indications': 'Indications',
  'contraindications': 'Contre-indications',
  'sideEffects': 'Effets secondaires',
  'precautions': 'Précautions',
  'onset': 'Début d\'action',
  'duration': 'Durée',
  'maxReached': 'Dose max atteinte',
  'infant': 'Nourrisson',
  'child': 'Enfant',
  'adult': 'Adulte',
  'elderly': 'Personne âgée',
  'ageGroup': 'Groupe d\'âge',
  'patientParameters': 'Paramètres du Patient',
  'drugClass': 'Classe',
  'totalDose': 'Dose Totale',
  'perKg': 'par kg',
  'seconds': 'secondes',
  'minutes': 'minutes',
  'tapForDetails': 'Appuyez pour plus de détails',
  'allSedationDrugs': 'Tous les Médicaments',
  'searchDrugs': 'Rechercher un médicament...',
  'noDrugsFound': 'Aucun médicament trouvé',
  'rapidSequence': 'Intubation à Séquence Rapide',
  'proceduralSedation': 'Sédation Procédurale',

  // Medical Report
  'medicalReportTitle': 'Évaluation ABCDE',
  'patientInfo': 'Informations Patient',
  'chiefComplaint': 'Motif de Consultation',
  'historyOfPresentIllness': 'Histoire de la Maladie',
  'pastMedicalHistory': 'Antécédents Médicaux',
  'medications': 'Médicaments',
  'allergies': 'Allergies',
  'familyHistory': 'Antécédents Familiaux',
  'socialHistory': 'Mode de Vie',
  'physicalExam': 'Examen Physique',
  'vitalSigns': 'Signes Vitaux',
  'assessment': 'Évaluation',
  'plan': 'Plan',
  'diagnosis': 'Diagnostic',
  'differentialDiagnosis': 'Diagnostic Différentiel',
  'investigations': 'Examens Complémentaires',
  'treatment': 'Traitement',
  'followUp': 'Suivi',
  'notes': 'Notes',
  'generateReport': 'Générer le Rapport',
  'copyReport': 'Copier le Rapport',
  'shareReport': 'Partager le Rapport',

  // Settings
  'settingsTitle': 'Paramètres',
  'appearance': 'Apparence',
  'theme': 'Thème',
  'lightTheme': 'Clair',
  'darkTheme': 'Sombre',
  'systemTheme': 'Système',
  'language': 'Langue',
  'french': 'Français',
  'english': 'English',
  'arabic': 'العربية',
  'notifications': 'Notifications',
  'about': 'À Propos',
  'version': 'Version',
  'termsOfService': 'Conditions d\'Utilisation',
  'privacyPolicy': 'Politique de Confidentialité',
  'licenses': 'Licences',
  'contactUs': 'Nous Contacter',
  'rateApp': 'Noter l\'Application',
  'darkMode': 'Mode sombre',

  // Auth
  'email': 'Adresse Email',
  'password': 'Mot de Passe',
  'confirmPassword': 'Confirmer le Mot de Passe',
  'fullName': 'Nom Complet',
  'username': 'Nom d\'Utilisateur',
  'forgotPassword': 'Mot de Passe Oublié ?',
  'resetPassword': 'Réinitialiser le Mot de Passe',
  'noAccount': 'Pas encore de compte ?',
  'haveAccount': 'Déjà un compte ?',
  'createAccount': 'Créer un Compte',
  'signIn': 'Se Connecter',
  'signOut': 'Se Déconnecter',
  'signUp': 'S\'inscrire',

  // Admin
  'adminTitle': 'Administration',
  'users': 'Utilisateurs',
  'userManagement': 'Gestion des Utilisateurs',
  'statistics': 'Statistiques',
  'analytics': 'Analytiques',
  'systemSettings': 'Paramètres Système',
  'logs': 'Journaux',
  'active': 'Actif',
  'inactive': 'Inactif',
  'banned': 'Banni',
  'role': 'Rôle',
  'adminRole': 'Administrateur',
  'userRole': 'Utilisateur',
  'moderatorRole': 'Modérateur',

  // Errors
  'errorGeneric': 'Une erreur s\'est produite. Veuillez réessayer.',
  'errorNetwork': 'Erreur de connexion. Vérifiez votre connexion internet.',
  'errorServer': 'Erreur serveur. Veuillez réessayer plus tard.',
  'errorAuth': 'Erreur d\'authentification. Veuillez vous reconnecter.',
  'errorNotFound': 'Ressource non trouvée.',
  'errorValidation': 'Veuillez vérifier les informations saisies.',
  'errorRequired': 'Ce champ est requis',
  'errorInvalidEmail': 'Adresse email invalide',
  'errorPasswordLength': 'Le mot de passe doit contenir au moins 8 caractères',
  'errorPasswordMatch': 'Les mots de passe ne correspondent pas',

  // Success Messages
  'successSaved': 'Enregistré avec succès',
  'successDeleted': 'Supprimé avec succès',
  'successCopied': 'Copié dans le presse-papiers',
  'successUpdated': 'Mis à jour avec succès',
  'successLogout': 'Déconnexion réussie',
  'successLogin': 'Connexion réussie',

  // Units
  'kg': 'kg',
  'lbs': 'lbs',
  'cm': 'cm',
  'm': 'm',
  'mmHg': 'mmHg',
  'kPa': 'kPa',
  'mgDl': 'mg/dL',
  'mmolL': 'mmol/L',
  'gDl': 'g/dL',
  'percent': '%',
  'bpm': 'bpm',
  'perMin': '/min',
  'mcgKgMin': 'µg/kg/min',
  'mgKgH': 'mg/kg/h',
  'mlH': 'mL/h',
  'celsius': '°C',
  'fahrenheit': '°F',

  // App shell
  'addPatientMeds': 'Ajoutez les médicaments du patient',
  'noInteractionsDetected': 'Aucune interaction détectée',
  'searchProtocols': 'Rechercher un protocole...',
  'noProtocolsFound': 'Aucun protocole trouvé',
  'noEventsRecorded': 'Aucun événement enregistré',
  'pediatricsOnly': 'Pédiatrie uniquement',
  'protocolsPlural': 'protocoles',
  'protocolCount': '{0} protocole{1}',
  'favoritesCount': '{0} favori{1}',
  'totalLabel': 'Total: {0}',
  'patientWeightLabel': 'Poids du patient',

  'dashboardTab': 'Tableau de bord',
  'toolsTab': 'Outils',
  'settingsTab': 'Paramètres',

  // Medical Report UI labels
  'formTab': 'Formulaire',
  'previewTab': 'Aperçu',
  'patientName': 'Nom du Patient',
  'traumaContext': 'Contexte Traumatique',
  'traumaSubtitle': 'Activer pour ajouter les détails du trauma',
  'mechanismOfInjury': 'Mécanisme lésionnel',
  'airwayStatus': 'État des voies aériennes',
  'deviceAction': 'Dispositif / Action',
  'breathing': 'Respiration',
  'respiratoryRate': 'FR (/min)',
  'spo2Label': 'SpO2 (%)',
  'workOfBreathing': 'Signes de lutte',
  'wobSuprasternal': 'Tirage sus-sternal',
  'wobSubcostal': 'Tirage sous-costal',
  'wobIntercostal': 'Tirage intercostal',
  'wobParadoxical': 'Balancement',
  'wobGasping': 'Gasping',
  'chestExpansion': 'Ampliation thoracique',
  'ribCrepitus': 'Crépitations costales',
  'ribCrepitusHint': 'Localisation (ex: K5-K7 gauche)',
  'subcuEmphysema': 'Emphysème sous-cutané',
  'subcuEmphysemaSub': 'Crépitation neigeuse à la palpation',
  'lungAuscultation': 'Auscultation pulmonaire',
  'lungAuscultationHint': 'Ex: MV symétrique, crépitants bases bilat., sibilants diffus...',
  'oxygenDevice': 'Dispositif O2',
  'flowRate': 'Débit (L/min)',
  'breathingAction': 'Conduite tenue (B)',
  'breathingActionHint': 'Ex: IOT, drainage thoracique...',
  'circulation': 'Circulation',
  'extremities': 'Extrémités',
  'shockSigns': 'Signes de choc périphérique',
  'mottling': 'Marbrures',
  'crtProlonged': 'TRC > 3s',
  'weakPulse': 'Pouls faible',
  'pulseAsymmetry': 'Asymétrie pouls',
  'heartFailureSigns': 'Signes de cœur droit',
  'jugularDistension': 'Turgescence jugulaire',
  'peripheralEdema': 'OMI',
  'bpRight': 'TA Droite',
  'bpLeft': 'TA Gauche',
  'heartRate': 'FC (bpm)',
  'rhythm': 'Rythme',
  'ventricularRate': 'FC ventriculaire',
  'pWave': 'Onde P',
  'prInterval': 'PR',
  'tWave': 'Onde T',
  'qrs': 'QRS',
  'blockType': 'Type de bloc',
  'sgarbossaCriteria': 'Critères de Sgarbossa',
  'sgarbossaSubtitle': 'Discordance ST > 5mm ou concordance',
  'stSegment': 'Segment ST',
  'stSegmentHint': 'Ex: isoélectrique, sus-décalage V1-V4, sous-décalage latéral...',
  'pupils': 'Pupilles',
  'pupilDetails': 'Détails pupilles',
  'neuroDeficit': 'Déficit neurologique',
  'neuroDeficitHint': 'Ex: pas de déficit, hémiparésie D, paraplégie...',
  'associatedAphasia': 'Aphasie associée',
  'capGlucose': 'Glycémie capillaire (g/L)',
  'warningSigns': 'Signes d\'alerte',
  'meningealSyndrome': 'Syndrome méningé',
  'purpura': 'Purpura',
  'gcsScore': 'Score de Glasgow (GCS)',
  'gcsEyes': 'Yeux (E)',
  'gcsVerbal': 'Verbal (V)',
  'gcsMotor': 'Moteur (M)',
  'exposure': 'Exposition',
  'hpiLabel': 'Histoire de la maladie (HDM)',
  'pastHistory': 'Antécédents',
  'smoking': 'Tabac',
  'alcohol': 'Alcool',
  'restOfExam': 'Reste de l\'examen physique',
  'reAbdomen': 'Abdomen souple dépressible indolore',
  'reCalves': 'Mollets souples',
  'reDehydration': 'Pas de signes de déshydratation',
  'reDefense': 'Pas de défense ni contracture',
  'reBHA': 'Bruits hydro-aériques présents',
  'reMass': 'Pas de masse palpable',
  'reEdema': 'Pas d\'œdèmes des membres inférieurs',
  'reSkinFold': 'Pas de pli cutané',
  'reLymphNodes': 'Aires ganglionnaires libres',
  'reKidneys': 'Fosses lombaires libres',
  'otherFindings': 'Autres constatations...',
  'catSection': 'Conduite à Tenir',
  'catHospitalize': 'Hospitalisation',
  'catMonitor': 'Surveillance scopée',
  'catConditioning': 'Conditionnement',
  'catIVLine': 'Voie veineuse périphérique',
  'catLabs': 'Bilan biologique',
  'catCTBrain': 'TDM cérébrale',
  'catCTBody': 'TDM thoraco-abdomino-pelvien',
  'catChestXray': 'Radiographie thoracique',
  'catECG18': 'ECG 18 dérivations',
  'catUltrasound': 'Échographie',
  'catConsult': 'Avis spécialisé',
  'catFluids': 'Remplissage vasculaire',
  'catOxygen': 'Oxygénothérapie',
  'catIntubation': 'Intubation orotrachéale',
  'catAntibiotics': 'Antibiothérapie',
  'catAnalgesics': 'Antalgiques',
  'catObserve': 'Surveillance simple',
  'catDischarge': 'Sortie avec ordonnance',
  'catDetails': 'Détails de la conduite à tenir...',
  'reportPreview': 'Aperçu du Rapport',
  'reportWillAppear': 'Le rapport apparaîtra ici',
  'airwayLabel': 'Voies Aériennes',
  'abcdeSubtitle': 'Évaluation ABCDE structurée',
  // Context section
  'contextSection': 'Contexte',
  // Airway dropdown
  'airwayClear': 'Libres',
  'airwayObstructed': 'Obstruées',
  'airwayThreatened': 'À risque',
  // Chest expansion
  'chestSymmetric': 'Symétrique',
  'chestAsymmetric': 'Asymétrique',
  // Oxygen device
  'oxygenNone': 'Aucun',
  'oxygenNasal': 'Lunettes nasales',
  'oxygenSimpleMask': 'Masque simple',
  'oxygenNRB': 'Masque haute concentration',
  'oxygenNIV': 'VNI',
  // Extremities
  'extremitiesWarm': 'Chaudes, bien perfusées',
  'extremitiesCold': 'Froides',
  'extremitiesCyanotic': 'Cyanosées',
  // Heart failure signs
  'hjrLabel': 'RHJ',
  // ECG rhythm
  'ecgSinus': 'Sinusal',
  'ecgIrregular': 'Irrégulier',
  'ecgAFib': 'FA',
  'ecgFlutter': 'Flutter',
  // ECG components
  'ecgNormal': 'Normale',
  'ecgTall': 'Ample',
  'ecgBiphasic': 'Biphasique',
  'ecgProlonged': 'Allongé',
  'ecgShort': 'Court',
  'ecgFlat': 'Aplatie',
  'ecgInverted': 'Inversée',
  // QRS
  'qrsNarrow': 'Fins (< 120ms)',
  'qrsWide': 'Larges (≥ 120ms)',
  // Pupils
  'pupilsPERRL': 'PERRL (réactives)',
  'pupilsAnisocoria': 'Anisocorie',
  'pupilsFixed': 'Fixes',

  // Antibiotic Detail
  'infoTab': 'Infos',
  'renalDoseTab': 'Dose Rénale',
  'interactionsTab': 'Interactions',
  'standardDosage': 'Posologie Standard',
  'additionalInformation': 'Informations Complémentaires',
  'pregnancyCategoryLabel': 'Catégorie Grossesse',
  'gfrCalculator': 'Calculateur DFG',
  'gfrLabel': 'DFG:',
  'recommendedDose': 'Dose Recommandée',
  'referenceTable': 'Table de Référence',
  'mlPerMin': 'mL/min',

  // Blood Gas UI
  'completeAnalysis': 'Analyse complète avec ventilation',
  'calculatedParameters': 'Paramètres calculés',
  'vtPerKgPBW': 'Vt/kg PBW',
  'drivingPressureMetric': 'Driving Pressure',
  'caO2': 'CaO₂',
  'bloodGasSection': 'Gazométrie',
  'biochemistrySection': 'Biochemistry',
  'albumin': 'Albumine',
  'ventilatorSection': 'Ventilator',
  'vt': 'Vt',
  'respiratoryRateLabel': 'FR',
  'peep': 'PEEP',
  'pplat': 'Pplat',
  'ppeak': 'Ppeak',
  'referencesFormulas': 'Références & Formules',
  'winterFormula': 'Formule de Winter',
  'aaGradientRef': 'Gradient A-a',
  'pfRatioBerlin': 'Rapport P/F (Berlin 2012)',
  'arterialO2Content': 'Contenu artériel en O2',
  'adrogueMadiasFormula': "Formule d'Adrogue-Madias",
  'pbwFormula': 'PBW (Poids Idéal)',
  'disclaimerTool': '⚠️ Cet outil est fourni à titre informatif uniquement. La décision clinique finale doit toujours être basée sur le jugement médical.',

  // RCP Timer
  'unknownRhythm': 'Inconnu',
  'vfPulselessVt': 'FV/TV sans pouls',
  'asystoleRhythm': 'Asystolie',
  'peaRhythm': 'AESP',
  'roscRhythm': 'ROSC',
  'cprStarted': 'RCP démarrée',
  'cprPaused': 'RCP en pause',
  'adrenalineAdministered': 'Adrénaline administrée ({0}mg total)',
  'shockDelivered': 'Choc électrique n°{0}',
  'amiodaroneAdministered': 'Amiodarone administrée',
  'rhythmRecorded': 'Rythme: {0}',
  'cycleCompleteMsg': 'Cycle {0} terminé - Vérifier le rythme!',
  'adrenalineNow': 'Adrénaline 1mg IV/IO maintenant!',
  'cprSettings': 'Paramètres RCP',
  'adrenalineInterval': 'Intervalle Adrénaline',
  'recommendationRhythm': 'Recommandation: 3–5 min selon le rythme',
  'metronomeSizeLabel': 'Taille du Métronome',
  'vibrationLabel': 'Vibration',
  'hapticFeedbackDesc': 'Retour haptique pour les alertes',
  'soundLabel': 'Son',
  'soundAlertsDesc': 'Alertes sonores (à venir)',
  'cprTimerTitle': 'Chronomètre RCP',
  'historyLabel': 'Historique',
  'cprInProgress': 'RCP EN COURS',
  'totalTime': 'Temps Total',
  'cycleLabel': 'Cycle',
  'secondsRemaining': '{0}s restantes',
  'adrenalineLabel': 'Adrénaline',
  'nowExcl': 'MAINTENANT!',
  'totalMg': 'Total: {0} mg',
  'metronomeCompressions': 'Métronome Compressions',
  'targetRate': 'Objectif: 100–120/min',
  'compressionsCount': 'Compressions: {0}',
  'cardiacRhythm': 'Rythme cardiaque',
  'shockableRhythmMsg': 'Rythme choquable — Défibrillation indiquée',
  'done': 'FAIT',
  'roscPostArrest': 'ROSC — Soins post-arrêt cardiaque',
  'quickActions': 'Actions rapides',
  'shocksCount': '{0} chocs',
  'shockAction': 'Choc ({0})',
  'amiodaroneLabel': 'Amiodarone',
  'pauseLabel': 'PAUSE',
  'startLabel': 'DÉMARRER',
  'eventHistory': 'Historique des événements',

  // Protocol Detail
  'protocolNotFound': 'Protocole non trouvé',
  'pediatricsBadge': 'Pédiatrie',
  'expandAll': 'Tout déplier',
  'collapseAll': 'Tout replier',
  'viewSource': 'Voir la source',
  'keyPointsSection': 'Points clés',
  'sourceLabel': 'Source',
  'protocolSteps': 'Étapes du protocole',
  'lastUpdated': 'Dernière mise à jour: {0}',
  'stepsCountLabel': '{0} étapes',

  // Settings
  'appDisclaimer': '⚠️ Cette application est un outil d\'aide à la décision et ne remplace pas le jugement clinique.',

  // Vasoactive
  'vasopressors': 'Vasopresseurs',
  'inotropes': 'Inotropes',
  'vasodilators': 'Vasodilatateurs',
  'mixedCategory': 'Mixtes',
  'pumpRate': 'Débit PSE',
  'pumpCalculator': 'Calculateur PSE',
  'concentrationPreparation': 'Concentration / Préparation',
  'doseLabel': 'Dose',
  'typicalDose': 'Typique: {0}',
  'uiPerMin': 'UI/min',
  'syringeVolume': 'Volume seringue',
  'receptorEffects': 'Effets récepteurs',

  // Metabolic
  'metabolicDisorders': 'Troubles Métaboliques',
  'metabolicSubtitle': 'Sodium • Potassium • Calcium',
  'sodiumTab': 'Sodium',
  'potassiumTab': 'Potassium',
  'calciumTab': 'Calcium',
  'sodiumParameters': 'Paramètres Sodiques',
  'hyponatremia': 'Hyponatrémie',
  'hypernatremia': 'Hypernatrémie',
  'currentNa': 'Na Actuel (mEq/L)',
  'targetNa': 'Na Cible (mEq/L)',
  'correctionMode': 'Mode de Correction',
  'chronic': 'Chronique (>48h)',
  'acute': 'Aigu (<48h)',
  'soluteSelection': 'Sélection des Solutés',
  'soluteA': 'Soluté A',
  'soluteB': 'Soluté B',
  'infusionRates': 'Débits de Perfusion',
  'totalFlowRate': 'Débit Total',
  'predictedVariation': 'Variation Prédite',
  'detailLabel': 'Détails',
  'totalBodyWater': 'Eau Corporelle Totale',
  'freeWaterDeficit': 'Déficit en Eau Libre',
  'sodiumDeficitLabel': 'Déficit en Sodium',
  'kaliemia': 'Kaliémie',
  'potassiumLevel': 'Potassium (mEq/L)',
  'ecgFindings': 'Signes ECG',
  'typicallySeenK': 'Typiquement vu si K > {0}',
  'recommendedTreatments': 'Traitements Recommandés',
  'calcemia': 'Calcémie',
  'calciumTotal': 'Calcium Total (mg/dL)',
  'albuminLabel': 'Albumine (g/dL)',
  'correctedCalcium': 'Calcium Corrigé',
  'formulaLabel': 'Formule',
  'calciumFormula': 'Ca corrigé = Ca total + 0.8 × (4 - Albumine)',
  'normalValuesRange': 'Valeurs normales: 8.5 - 10.5 mg/dL',
  'criticalStatus': 'Critique',
  'elevatedStatus': 'Élevé',
  'lowStatus': 'Bas',
  'normalStatus': 'Normal',
  'hypocalcemiaSevere': 'Hypocalcémie sévère',
  'hypocalcemia': 'Hypocalcémie',
  'hypercalcemiaSevere': 'Hypercalcémie sévère',
  'hypercalcemia': 'Hypercalcémie',
  'urgencyImmediate': 'Immédiat',
  'urgencyUrgent': 'Urgent',
  'urgencyAdjunct': 'Adjuvant',
  'urgencyDefinitive': 'Définitif',
  'naRateRecoHypoAcute': '1-2 mEq/L/h (max 8-10 mEq/L/24h)',
  'naRateRecoHypoChronic': '≤0.5 mEq/L/h (max 8 mEq/L/24h)',
  'naRateRecoHyperAcute': '1-2 mEq/L/h (max 12 mEq/L/24h)',
  'naRateRecoHyperChronic': '≤0.5 mEq/L/h (max 10-12 mEq/L/24h)',
  'naRateWarningHypoAcute': 'Correction rapide acceptable si installation <48h',
  'naRateWarningHypoChronic': '⚠️ Risque de myélinolyse centro-pontine si correction trop rapide',
  'naRateWarningHyperAcute': 'Correction rapide possible si installation <24h',
  'naRateWarningHyperChronic': '⚠️ Risque d\'œdème cérébral si correction trop rapide',
  'naSafeMarginHypoAcute': '✓ Sûr: ≤10 mEq/L en 24h, ≤18 mEq/L en 48h',
  'naSafeMarginHypoChronic': '✓ Sûr: ≤8 mEq/L en 24h (10-12 si Na<120 + symptômes)',
  'naSafeMarginHyperAcute': '✓ Sûr: ≤12 mEq/L en 24h (si aigu)',
  'naSafeMarginHyperChronic': '✓ Sûr: ≤10 mEq/L en 24h (chronique)',
  'naDangerMarginHypoAcute': '⚠️ Danger ODS: >10-12 mEq/L en 24h',
  'naDangerMarginHypoChronic': '⚠️ Danger ODS: >8 mEq/L en 24h si chronique',
  'naDangerMarginHyperAcute': '⚠️ Danger: Œdème cérébral si >12 mEq/L/24h',
  'naDangerMarginHyperChronic': '⚠️ Danger: Œdème cérébral si >12 mEq/L/24h',
  'soluteATotalLabel': 'Soluté A ({0})',
  'soluteBTotalLabel': 'Soluté B ({0})',
  'correctionRateTitle': 'Vitesse Recommandée ({0})',

  // Sedation
  'newborn': 'Nouveau-né',
};

final locProvider = Provider<Map<String, String>>((ref) {
  final lang = ref.watch(languageProvider);
  final map = lang == AppLanguage.english ? _en : _fr;
  AppStrings._currentStrings = map;
  return map;
});

/// Convenience extension for getting localized strings from BuildContext
extension Loc on BuildContext {
  String t(String key) {
    return AppStrings._currentStrings[key] ?? _fr[key] ?? key;
  }
}

/// Compatibility shim — allows existing AppStrings.x syntax to work.
/// Uses a static map directly updated by the provider.
// ignore: non_constant_identifier_names
class AppStrings {
  static Map<String, String> _currentStrings = _fr;

  static String _t(String key) => _currentStrings[key] ?? _fr[key] ?? key;

  static void setAmbientContext(BuildContext? ctx) {}
  static void refreshContext() {}

  static String get appName => _t('appName');
  static String get settings => _t('settings');
  static String get admin => _t('admin');
  static String get logout => _t('logout');
  static String get login => _t('login');
  static String get register => _t('register');
  static String get save => _t('save');
  static String get cancel => _t('cancel');
  static String get delete => _t('delete');
  static String get edit => _t('edit');
  static String get add => _t('add');
  static String get search => _t('search');
  static String get filter => _t('filter');
  static String get reset => _t('reset');
  static String get calculate => _t('calculate');
  static String get copy => _t('copy');
  static String get share => _t('share');
  static String get generate => _t('generate');
  static String get clear => _t('clear');
  static String get confirm => _t('confirm');
  static String get close => _t('close');
  static String get back => _t('back');
  static String get next => _t('next');
  static String get previous => _t('previous');
  static String get yes => _t('yes');
  static String get no => _t('no');
  static String get ok => _t('ok');
  static String get loading => _t('loading');
  static String get error => _t('error');
  static String get success => _t('success');
  static String get warning => _t('warning');
  static String get info => _t('info');
  static String get weight => _t('weight');
  static String get age => _t('age');
  static String get years => _t('years');
  static String get months => _t('months');
  static String get height => _t('height');
  static String get sex => _t('sex');
  static String get male => _t('male');
  static String get female => _t('female');
  static String get justNow => _t('justNow');
  static String get minutesAgo => _t('minutesAgo');
  static String get hoursAgo => _t('hoursAgo');
  static String get daysAgo => _t('daysAgo');
  static String get welcome => _t('welcome');
  static String get welcomeBack => _t('welcomeBack');
  static String get welcomeMessage => _t('welcomeMessage');
  static String get quickAccess => _t('quickAccess');
  static String get recentTools => _t('recentTools');
  static String get recentActivity => _t('recentActivity');
  static String get allTools => _t('allTools');
  static String get viewAllTools => _t('viewAllTools');
  static String get favorites => _t('favorites');
  static String get searchTools => _t('searchTools');
  static String get toolsAvailable => _t('toolsAvailable');
  static String get calculatorUsed => _t('calculatorUsed');
  static String get bloodGasAnalyzed => _t('bloodGasAnalyzed');
  static String get arterialBlood => _t('arterialBlood');
  static String get reportGenerated => _t('reportGenerated');
  static String get icuAdmission => _t('icuAdmission');
  static String get toolsTitle => _t('toolsTitle');
  static String get toolsSubtitle => _t('toolsSubtitle');
  static String get calculators => _t('calculators');
  static String get calculatorsDesc => _t('calculatorsDesc');
  static String get bloodGas => _t('bloodGas');
  static String get bloodGasDesc => _t('bloodGasDesc');
  static String get vasoactive => _t('vasoactive');
  static String get vasoactiveDesc => _t('vasoactiveDesc');
  static String get sedation => _t('sedation');
  static String get sedationDesc => _t('sedationDesc');
  static String get medicalReport => _t('medicalReport');
  static String get medicalReportDesc => _t('medicalReportDesc');
  static String get antibiotics => _t('antibiotics');
  static String get antibioticsDesc => _t('antibioticsDesc');
  static String get antibioticsGuide => _t('antibioticsGuide');
  static String get antibioticsSubtitle => _t('antibioticsSubtitle');
  static String get protocols => _t('protocols');
  static String get protocolsDesc => _t('protocolsDesc');
  static String get rcpTimer => _t('rcpTimer');
  static String get rcpTimerDesc => _t('rcpTimerDesc');
  static String get searchAntibiotic => _t('searchAntibiotic');
  static String get noAntibioticFound => _t('noAntibioticFound');
  static String get tryAnotherSearch => _t('tryAnotherSearch');
  static String get all => _t('all');
  static String get penicillins => _t('penicillins');
  static String get cephalosporins => _t('cephalosporins');
  static String get carbapenems => _t('carbapenems');
  static String get aminoglycosides => _t('aminoglycosides');
  static String get fluoroquinolones => _t('fluoroquinolones');
  static String get macrolides => _t('macrolides');
  static String get glycopeptides => _t('glycopeptides');
  static String get tetracyclines => _t('tetracyclines');
  static String get sulfonamides => _t('sulfonamides');
  static String get nitroimidazoles => _t('nitroimidazoles');
  static String get others => _t('others');
  static String get metabolic => _t('metabolic');
  static String get metabolicDesc => _t('metabolicDesc');
  static String get paste => _t('paste');
  static String get pasteDesc => _t('pasteDesc');
  static String get calculatorCategories => _t('calculatorCategories');
  static String get selectCalculator => _t('selectCalculator');
  static String get result => _t('result');
  static String get interpretation => _t('interpretation');
  static String get source => _t('source');
  static String get references => _t('references');
  static String get trauma => _t('trauma');
  static String get sepsis => _t('sepsis');
  static String get peDvt => _t('peDvt');
  static String get cardiovascular => _t('cardiovascular');
  static String get neurology => _t('neurology');
  static String get gi => _t('gi');
  static String get toxicology => _t('toxicology');
  static String get msk => _t('msk');
  static String get pediatric => _t('pediatric');
  static String get laboratory => _t('laboratory');
  static String get bloodGasTitle => _t('bloodGasTitle');
  static String get arterial => _t('arterial');
  static String get venous => _t('venous');
  static String get pH => _t('pH');
  static String get pCO2 => _t('pCO2');
  static String get pO2 => _t('pO2');
  static String get hCO3 => _t('hCO3');
  static String get baseExcess => _t('baseExcess');
  static String get lactate => _t('lactate');
  static String get sodium => _t('sodium');
  static String get potassium => _t('potassium');
  static String get chloride => _t('chloride');
  static String get glucose => _t('glucose');
  static String get hemoglobin => _t('hemoglobin');
  static String get saturation => _t('saturation');
  static String get fio2 => _t('fio2');
  static String get temperature => _t('temperature');
  static String get primaryDisorder => _t('primaryDisorder');
  static String get compensation => _t('compensation');
  static String get anionGap => _t('anionGap');
  static String get correctedAnionGap => _t('correctedAnionGap');
  static String get deltaRatio => _t('deltaRatio');
  static String get oxygenation => _t('oxygenation');
  static String get paoFio2Ratio => _t('paoFio2Ratio');
  static String get aaGradient => _t('aaGradient');
  static String get normalValues => _t('normalValues');
  static String get metabolicAcidosis => _t('metabolicAcidosis');
  static String get metabolicAlkalosis => _t('metabolicAlkalosis');
  static String get respiratoryAcidosis => _t('respiratoryAcidosis');
  static String get respiratoryAlkalosis => _t('respiratoryAlkalosis');
  static String get mixed => _t('mixed');
  static String get compensated => _t('compensated');
  static String get uncompensated => _t('uncompensated');
  static String get partiallyCompensated => _t('partiallyCompensated');
  static String get vasoactiveTitle => _t('vasoactiveTitle');
  static String get drugSelection => _t('drugSelection');
  static String get patientWeight => _t('patientWeight');
  static String get targetDose => _t('targetDose');
  static String get concentration => _t('concentration');
  static String get infusionRate => _t('infusionRate');
  static String get dilution => _t('dilution');
  static String get syringe => _t('syringe');
  static String get pump => _t('pump');
  static String get norepinephrine => _t('norepinephrine');
  static String get epinephrine => _t('epinephrine');
  static String get dopamine => _t('dopamine');
  static String get dobutamine => _t('dobutamine');
  static String get milrinone => _t('milrinone');
  static String get vasopressin => _t('vasopressin');
  static String get phenylephrine => _t('phenylephrine');
  static String get sedationTitle => _t('sedationTitle');
  static String get sedationAnalgesia => _t('sedationAnalgesia');
  static String get sedationScore => _t('sedationScore');
  static String get targetRASS => _t('targetRASS');
  static String get currentRASS => _t('currentRASS');
  static String get bolus => _t('bolus');
  static String get maintenance => _t('maintenance');
  static String get propofol => _t('propofol');
  static String get midazolam => _t('midazolam');
  static String get ketamine => _t('ketamine');
  static String get fentanyl => _t('fentanyl');
  static String get morphine => _t('morphine');
  static String get dexmedetomidine => _t('dexmedetomidine');
  static String get rsiTab => _t('rsiTab');
  static String get proceduralTab => _t('proceduralTab');
  static String get allDrugsTab => _t('allDrugsTab');
  static String get premedication => _t('premedication');
  static String get induction => _t('induction');
  static String get paralysis => _t('paralysis');
  static String get proceduralOptions => _t('proceduralOptions');
  static String get doseCalculation => _t('doseCalculation');
  static String get concentrations => _t('concentrations');
  static String get mechanism => _t('mechanism');
  static String get indications => _t('indications');
  static String get contraindications => _t('contraindications');
  static String get sideEffects => _t('sideEffects');
  static String get precautions => _t('precautions');
  static String get onset => _t('onset');
  static String get duration => _t('duration');
  static String get maxReached => _t('maxReached');
  static String get infant => _t('infant');
  static String get child => _t('child');
  static String get adult => _t('adult');
  static String get elderly => _t('elderly');
  static String get ageGroup => _t('ageGroup');
  static String get patientParameters => _t('patientParameters');
  static String get drugClass => _t('drugClass');
  static String get totalDose => _t('totalDose');
  static String get perKg => _t('perKg');
  static String get seconds => _t('seconds');
  static String get minutes => _t('minutes');
  static String get tapForDetails => _t('tapForDetails');
  static String get allSedationDrugs => _t('allSedationDrugs');
  static String get searchDrugs => _t('searchDrugs');
  static String get noDrugsFound => _t('noDrugsFound');
  static String get rapidSequence => _t('rapidSequence');
  static String get proceduralSedation => _t('proceduralSedation');
  static String get medicalReportTitle => _t('medicalReportTitle');
  static String get patientInfo => _t('patientInfo');
  static String get chiefComplaint => _t('chiefComplaint');
  static String get historyOfPresentIllness => _t('historyOfPresentIllness');
  static String get pastMedicalHistory => _t('pastMedicalHistory');
  static String get medications => _t('medications');
  static String get allergies => _t('allergies');
  static String get familyHistory => _t('familyHistory');
  static String get socialHistory => _t('socialHistory');
  static String get physicalExam => _t('physicalExam');
  static String get vitalSigns => _t('vitalSigns');
  static String get assessment => _t('assessment');
  static String get plan => _t('plan');
  static String get diagnosis => _t('diagnosis');
  static String get differentialDiagnosis => _t('differentialDiagnosis');
  static String get investigations => _t('investigations');
  static String get treatment => _t('treatment');
  static String get followUp => _t('followUp');
  static String get notes => _t('notes');
  static String get generateReport => _t('generateReport');
  static String get copyReport => _t('copyReport');
  static String get shareReport => _t('shareReport');
  static String get settingsTitle => _t('settingsTitle');
  static String get appearance => _t('appearance');
  static String get theme => _t('theme');
  static String get lightTheme => _t('lightTheme');
  static String get darkTheme => _t('darkTheme');
  static String get systemTheme => _t('systemTheme');
  static String get language => _t('language');
  static String get french => _t('french');
  static String get english => _t('english');
  static String get arabic => _t('arabic');
  static String get notifications => _t('notifications');
  static String get about => _t('about');
  static String get version => _t('version');
  static String get termsOfService => _t('termsOfService');
  static String get privacyPolicy => _t('privacyPolicy');
  static String get licenses => _t('licenses');
  static String get contactUs => _t('contactUs');
  static String get rateApp => _t('rateApp');
  static String get email => _t('email');
  static String get password => _t('password');
  static String get confirmPassword => _t('confirmPassword');
  static String get fullName => _t('fullName');
  static String get username => _t('username');
  static String get forgotPassword => _t('forgotPassword');
  static String get resetPassword => _t('resetPassword');
  static String get noAccount => _t('noAccount');
  static String get haveAccount => _t('haveAccount');
  static String get createAccount => _t('createAccount');
  static String get signIn => _t('signIn');
  static String get signOut => _t('signOut');
  static String get signUp => _t('signUp');
  static String get adminTitle => _t('adminTitle');
  static String get users => _t('users');
  static String get userManagement => _t('userManagement');
  static String get statistics => _t('statistics');
  static String get analytics => _t('analytics');
  static String get systemSettings => _t('systemSettings');
  static String get logs => _t('logs');
  static String get active => _t('active');
  static String get inactive => _t('inactive');
  static String get banned => _t('banned');
  static String get role => _t('role');
  static String get adminRole => _t('adminRole');
  static String get userRole => _t('userRole');
  static String get moderatorRole => _t('moderatorRole');
  static String get errorGeneric => _t('errorGeneric');
  static String get errorNetwork => _t('errorNetwork');
  static String get errorServer => _t('errorServer');
  static String get errorAuth => _t('errorAuth');
  static String get errorNotFound => _t('errorNotFound');
  static String get errorValidation => _t('errorValidation');
  static String get errorRequired => _t('errorRequired');
  static String get errorInvalidEmail => _t('errorInvalidEmail');
  static String get errorPasswordLength => _t('errorPasswordLength');
  static String get errorPasswordMatch => _t('errorPasswordMatch');
  static String get successSaved => _t('successSaved');
  static String get successDeleted => _t('successDeleted');
  static String get successCopied => _t('successCopied');
  static String get successUpdated => _t('successUpdated');
  static String get successLogout => _t('successLogout');
  static String get successLogin => _t('successLogin');
  static String get kg => _t('kg');
  static String get lbs => _t('lbs');
  static String get cm => _t('cm');
  static String get m => _t('m');
  static String get mmHg => _t('mmHg');
  static String get kPa => _t('kPa');
  static String get mgDl => _t('mgDl');
  static String get mmolL => _t('mmolL');
  static String get gDl => _t('gDl');
  static String get percent => _t('percent');
  static String get bpm => _t('bpm');
  static String get perMin => _t('perMin');
  static String get mcgKgMin => _t('mcgKgMin');
  static String get mgKgH => _t('mgKgH');
  static String get mlH => _t('mlH');
  static String get celsius => _t('celsius');
  static String get fahrenheit => _t('fahrenheit');
  static String get dashboardTab => _t('dashboardTab');
  static String get toolsTab => _t('toolsTab');
  static String get settingsTab => _t('settingsTab');

  static String get favoritesCategory => _t('favoritesCategory');
  static String get calculatorsCategory => _t('calculatorsCategory');
  static String get emergencyCategory => _t('emergencyCategory');
  static String get icuCategory => _t('icuCategory');
  static String get toolsCategory => _t('toolsCategory');
  static String get searchTool => _t('searchTool');
  static String get toolsCount => _t('toolsCount');
  static String get noFavorites => _t('noFavorites');
  static String get addFavoritesHint => _t('addFavoritesHint');
  static String get noToolFound => _t('noToolFound');
  static String get darkMode => _t('darkMode');
  static String get formTab => _t('formTab');
  static String get previewTab => _t('previewTab');
  static String get patientName => _t('patientName');
  static String get traumaContext => _t('traumaContext');
  static String get traumaSubtitle => _t('traumaSubtitle');
  static String get mechanismOfInjury => _t('mechanismOfInjury');
  static String get airwayStatus => _t('airwayStatus');
  static String get deviceAction => _t('deviceAction');
  static String get breathing => _t('breathing');
  static String get respiratoryRate => _t('respiratoryRate');
  static String get spo2Label => _t('spo2Label');
  static String get workOfBreathing => _t('workOfBreathing');
  static String get wobSuprasternal => _t('wobSuprasternal');
  static String get wobSubcostal => _t('wobSubcostal');
  static String get wobIntercostal => _t('wobIntercostal');
  static String get wobParadoxical => _t('wobParadoxical');
  static String get wobGasping => _t('wobGasping');
  static String get chestExpansion => _t('chestExpansion');
  static String get ribCrepitus => _t('ribCrepitus');
  static String get ribCrepitusHint => _t('ribCrepitusHint');
  static String get subcuEmphysema => _t('subcuEmphysema');
  static String get subcuEmphysemaSub => _t('subcuEmphysemaSub');
  static String get lungAuscultation => _t('lungAuscultation');
  static String get lungAuscultationHint => _t('lungAuscultationHint');
  static String get oxygenDevice => _t('oxygenDevice');
  static String get flowRate => _t('flowRate');
  static String get breathingAction => _t('breathingAction');
  static String get breathingActionHint => _t('breathingActionHint');
  static String get circulation => _t('circulation');
  static String get extremities => _t('extremities');
  static String get shockSigns => _t('shockSigns');
  static String get mottling => _t('mottling');
  static String get crtProlonged => _t('crtProlonged');
  static String get weakPulse => _t('weakPulse');
  static String get pulseAsymmetry => _t('pulseAsymmetry');
  static String get heartFailureSigns => _t('heartFailureSigns');
  static String get jugularDistension => _t('jugularDistension');
  static String get peripheralEdema => _t('peripheralEdema');
  static String get bpRight => _t('bpRight');
  static String get bpLeft => _t('bpLeft');
  static String get heartRate => _t('heartRate');
  static String get rhythm => _t('rhythm');
  static String get ventricularRate => _t('ventricularRate');
  static String get pWave => _t('pWave');
  static String get prInterval => _t('prInterval');
  static String get tWave => _t('tWave');
  static String get qrs => _t('qrs');
  static String get blockType => _t('blockType');
  static String get sgarbossaCriteria => _t('sgarbossaCriteria');
  static String get sgarbossaSubtitle => _t('sgarbossaSubtitle');
  static String get stSegment => _t('stSegment');
  static String get stSegmentHint => _t('stSegmentHint');
  static String get pupils => _t('pupils');
  static String get pupilDetails => _t('pupilDetails');
  static String get neuroDeficit => _t('neuroDeficit');
  static String get neuroDeficitHint => _t('neuroDeficitHint');
  static String get associatedAphasia => _t('associatedAphasia');
  static String get capGlucose => _t('capGlucose');
  static String get warningSigns => _t('warningSigns');
  static String get meningealSyndrome => _t('meningealSyndrome');
  static String get gcsScore => _t('gcsScore');
  static String get gcsEyes => _t('gcsEyes');
  static String get gcsVerbal => _t('gcsVerbal');
  static String get gcsMotor => _t('gcsMotor');
  static String get exposure => _t('exposure');
  static String get hpiLabel => _t('hpiLabel');
  static String get smoking => _t('smoking');
  static String get alcohol => _t('alcohol');
  static String get restOfExam => _t('restOfExam');
  static String get reAbdomen => _t('reAbdomen');
  static String get reCalves => _t('reCalves');
  static String get reDehydration => _t('reDehydration');
  static String get reDefense => _t('reDefense');
  static String get reBHA => _t('reBHA');
  static String get reMass => _t('reMass');
  static String get reEdema => _t('reEdema');
  static String get reSkinFold => _t('reSkinFold');
  static String get reLymphNodes => _t('reLymphNodes');
  static String get reKidneys => _t('reKidneys');
  static String get otherFindings => _t('otherFindings');
  static String get catSection => _t('catSection');
  static String get catHospitalize => _t('catHospitalize');
  static String get catMonitor => _t('catMonitor');
  static String get catConditioning => _t('catConditioning');
  static String get catIVLine => _t('catIVLine');
  static String get catLabs => _t('catLabs');
  static String get catCTBrain => _t('catCTBrain');
  static String get catCTBody => _t('catCTBody');
  static String get catChestXray => _t('catChestXray');
  static String get catECG18 => _t('catECG18');
  static String get catUltrasound => _t('catUltrasound');
  static String get catConsult => _t('catConsult');
  static String get catFluids => _t('catFluids');
  static String get catOxygen => _t('catOxygen');
  static String get catIntubation => _t('catIntubation');
  static String get catAntibiotics => _t('catAntibiotics');
  static String get catAnalgesics => _t('catAnalgesics');
  static String get catObserve => _t('catObserve');
  static String get catDischarge => _t('catDischarge');
  static String get catDetails => _t('catDetails');
  static String get reportPreview => _t('reportPreview');
  static String get reportWillAppear => _t('reportWillAppear');
  static String get airway => _t('airwayLabel');
  static String get abcdeSubtitle => _t('abcdeSubtitle');
  static String get addPatientMeds => _t('addPatientMeds');
  static String get noInteractionsDetected => _t('noInteractionsDetected');
  static String get searchProtocols => _t('searchProtocols');
  static String get noProtocolsFound => _t('noProtocolsFound');
  static String get noEventsRecorded => _t('noEventsRecorded');
  static String get pediatricsOnly => _t('pediatricsOnly');
  static String get protocolCount => _t('protocolCount');
  static String get favoritesCount => _t('favoritesCount');
  static String get totalLabel => _t('totalLabel');
  static String get patientWeightLabel => _t('patientWeightLabel');
  static String get infoTab => _t('infoTab');
  static String get renalDoseTab => _t('renalDoseTab');
  static String get interactionsTab => _t('interactionsTab');
  static String get standardDosage => _t('standardDosage');
  static String get additionalInformation => _t('additionalInformation');
  static String get pregnancyCategoryLabel => _t('pregnancyCategoryLabel');
  static String get gfrCalculator => _t('gfrCalculator');
  static String get gfrLabel => _t('gfrLabel');
  static String get recommendedDose => _t('recommendedDose');
  static String get referenceTable => _t('referenceTable');
  static String get mlPerMin => _t('mlPerMin');
  static String get oxazolidinones => _t('oxazolidinones');
  static String get lipopeptides => _t('lipopeptides');
  static String get lincosamides => _t('lincosamides');
  static String get monobactams => _t('monobactams');
  static String get completeAnalysis => _t('completeAnalysis');
  static String get calculatedParameters => _t('calculatedParameters');
  static String get vtPerKgPBW => _t('vtPerKgPBW');
  static String get drivingPressureMetric => _t('drivingPressureMetric');
  static String get caO2 => _t('caO2');
  static String get bloodGasSection => _t('bloodGasSection');
  static String get biochemistrySection => _t('biochemistrySection');
  static String get albumin => _t('albumin');
  static String get ventilatorSection => _t('ventilatorSection');
  static String get vt => _t('vt');
  static String get respiratoryRateLabel => _t('respiratoryRateLabel');
  static String get peep => _t('peep');
  static String get pplat => _t('pplat');
  static String get ppeak => _t('ppeak');
  static String get referencesFormulas => _t('referencesFormulas');
  static String get winterFormula => _t('winterFormula');
  static String get aaGradientRef => _t('aaGradientRef');
  static String get pfRatioBerlin => _t('pfRatioBerlin');
  static String get arterialO2Content => _t('arterialO2Content');
  static String get adrogueMadiasFormula => _t('adrogueMadiasFormula');
  static String get pbwFormula => _t('pbwFormula');
  static String get disclaimerTool => _t('disclaimerTool');
  static String get unknownRhythm => _t('unknownRhythm');
  static String get vfPulselessVt => _t('vfPulselessVt');
  static String get asystoleRhythm => _t('asystoleRhythm');
  static String get peaRhythm => _t('peaRhythm');
  static String get roscRhythm => _t('roscRhythm');
  static String get cprStarted => _t('cprStarted');
  static String get cprPaused => _t('cprPaused');
  static String get adrenalineAdministered => _t('adrenalineAdministered');
  static String get shockDelivered => _t('shockDelivered');
  static String get amiodaroneAdministered => _t('amiodaroneAdministered');
  static String get rhythmRecorded => _t('rhythmRecorded');
  static String get cycleCompleteMsg => _t('cycleCompleteMsg');
  static String get adrenalineNow => _t('adrenalineNow');
  static String get cprSettings => _t('cprSettings');
  static String get adrenalineInterval => _t('adrenalineInterval');
  static String get recommendationRhythm => _t('recommendationRhythm');
  static String get metronomeSizeLabel => _t('metronomeSizeLabel');
  static String get vibrationLabel => _t('vibrationLabel');
  static String get hapticFeedbackDesc => _t('hapticFeedbackDesc');
  static String get soundLabel => _t('soundLabel');
  static String get soundAlertsDesc => _t('soundAlertsDesc');
  static String get cprTimerTitle => _t('cprTimerTitle');
  static String get historyLabel => _t('historyLabel');
  static String get cprInProgress => _t('cprInProgress');
  static String get totalTime => _t('totalTime');
  static String get cycleLabel => _t('cycleLabel');
  static String get secondsRemaining => _t('secondsRemaining');
  static String get adrenalineLabel => _t('adrenalineLabel');
  static String get nowExcl => _t('nowExcl');
  static String get totalMg => _t('totalMg');
  static String get metronomeCompressions => _t('metronomeCompressions');
  static String get targetRate => _t('targetRate');
  static String get compressionsCount => _t('compressionsCount');
  static String get cardiacRhythm => _t('cardiacRhythm');
  static String get shockableRhythmMsg => _t('shockableRhythmMsg');
  static String get done => _t('done');
  static String get roscPostArrest => _t('roscPostArrest');
  static String get quickActions => _t('quickActions');
  static String get shocksCount => _t('shocksCount');
  static String get shockAction => _t('shockAction');
  static String get amiodaroneLabel => _t('amiodaroneLabel');
  static String get pauseLabel => _t('pauseLabel');
  static String get startLabel => _t('startLabel');
  static String get eventHistory => _t('eventHistory');
  static String get protocolNotFound => _t('protocolNotFound');
  static String get pediatricsBadge => _t('pediatricsBadge');
  static String get expandAll => _t('expandAll');
  static String get collapseAll => _t('collapseAll');
  static String get viewSource => _t('viewSource');
  static String get keyPointsSection => _t('keyPointsSection');
  static String get sourceLabel => _t('sourceLabel');
  static String get protocolSteps => _t('protocolSteps');
  static String get lastUpdated => _t('lastUpdated');
  static String get stepsCountLabel => _t('stepsCountLabel');
  static String get appDisclaimer => _t('appDisclaimer');
  static String get vasopressors => _t('vasopressors');
  static String get inotropes => _t('inotropes');
  static String get vasodilators => _t('vasodilators');
  static String get mixedCategory => _t('mixedCategory');
  static String get pumpRate => _t('pumpRate');
  static String get pumpCalculator => _t('pumpCalculator');
  static String get concentrationPreparation => _t('concentrationPreparation');
  static String get doseLabel => _t('doseLabel');
  static String get typicalDose => _t('typicalDose');
  static String get uiPerMin => _t('uiPerMin');
  static String get syringeVolume => _t('syringeVolume');
  static String get receptorEffects => _t('receptorEffects');
  static String get metabolicDisorders => _t('metabolicDisorders');
  static String get metabolicSubtitle => _t('metabolicSubtitle');
  static String get sodiumTab => _t('sodiumTab');
  static String get potassiumTab => _t('potassiumTab');
  static String get calciumTab => _t('calciumTab');
  static String get sodiumParameters => _t('sodiumParameters');
  static String get hyponatremia => _t('hyponatremia');
  static String get hypernatremia => _t('hypernatremia');
  static String get currentNa => _t('currentNa');
  static String get targetNa => _t('targetNa');
  static String get correctionMode => _t('correctionMode');
  static String get chronic => _t('chronic');
  static String get acute => _t('acute');
  static String get soluteSelection => _t('soluteSelection');
  static String get soluteA => _t('soluteA');
  static String get soluteB => _t('soluteB');
  static String get infusionRates => _t('infusionRates');
  static String get totalFlowRate => _t('totalFlowRate');
  static String get predictedVariation => _t('predictedVariation');
  static String get detailLabel => _t('detailLabel');
  static String get totalBodyWater => _t('totalBodyWater');
  static String get freeWaterDeficit => _t('freeWaterDeficit');
  static String get sodiumDeficitLabel => _t('sodiumDeficitLabel');
  static String get kaliemia => _t('kaliemia');
  static String get potassiumLevel => _t('potassiumLevel');
  static String get ecgFindings => _t('ecgFindings');
  static String get typicallySeenK => _t('typicallySeenK');
  static String get recommendedTreatments => _t('recommendedTreatments');
  static String get calcemia => _t('calcemia');
  static String get calciumTotal => _t('calciumTotal');
  static String get albuminLabel => _t('albuminLabel');
  static String get correctedCalcium => _t('correctedCalcium');
  static String get formulaLabel => _t('formulaLabel');
  static String get calciumFormula => _t('calciumFormula');
  static String get normalValuesRange => _t('normalValuesRange');
  static String get criticalStatus => _t('criticalStatus');
  static String get elevatedStatus => _t('elevatedStatus');
  static String get lowStatus => _t('lowStatus');
  static String get normalStatus => _t('normalStatus');
  static String get hypocalcemiaSevere => _t('hypocalcemiaSevere');
  static String get hypocalcemia => _t('hypocalcemia');
  static String get hypercalcemiaSevere => _t('hypercalcemiaSevere');
  static String get hypercalcemia => _t('hypercalcemia');
  static String get urgencyImmediate => _t('urgencyImmediate');
  static String get urgencyUrgent => _t('urgencyUrgent');
  static String get urgencyAdjunct => _t('urgencyAdjunct');
  static String get urgencyDefinitive => _t('urgencyDefinitive');
  static String get naRateRecoHypoAcute => _t('naRateRecoHypoAcute');
  static String get naRateRecoHypoChronic => _t('naRateRecoHypoChronic');
  static String get naRateRecoHyperAcute => _t('naRateRecoHyperAcute');
  static String get naRateRecoHyperChronic => _t('naRateRecoHyperChronic');
  static String get naRateWarningHypoAcute => _t('naRateWarningHypoAcute');
  static String get naRateWarningHypoChronic => _t('naRateWarningHypoChronic');
  static String get naRateWarningHyperAcute => _t('naRateWarningHyperAcute');
  static String get naRateWarningHyperChronic => _t('naRateWarningHyperChronic');
  static String get naSafeMarginHypoAcute => _t('naSafeMarginHypoAcute');
  static String get naSafeMarginHypoChronic => _t('naSafeMarginHypoChronic');
  static String get naSafeMarginHyperAcute => _t('naSafeMarginHyperAcute');
  static String get naSafeMarginHyperChronic => _t('naSafeMarginHyperChronic');
  static String get naDangerMarginHypoAcute => _t('naDangerMarginHypoAcute');
  static String get naDangerMarginHypoChronic => _t('naDangerMarginHypoChronic');
  static String get naDangerMarginHyperAcute => _t('naDangerMarginHyperAcute');
  static String get naDangerMarginHyperChronic => _t('naDangerMarginHyperChronic');
  static String get soluteATotalLabel => _t('soluteATotalLabel');
  static String get soluteBTotalLabel => _t('soluteBTotalLabel');
  static String get correctionRateTitle => _t('correctionRateTitle');
  static String get newborn => _t('newborn');
}
