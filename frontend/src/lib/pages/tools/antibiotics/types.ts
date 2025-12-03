// Types for Antibiotic Guide App

export interface Antibiotic {
  id: string;
  name: string;                    // Trade name
  genericName: string;             // INN name
  class: AntibioticClass;
  spectrum: SpectrumType;
  route: ('PO' | 'IV' | 'IM')[];
  
  // Dosing
  standardDose: DoseInfo;
  renalAdjustment: RenalAdjustment[];
  hepaticAdjustment?: string;
  pediatricDose?: string;
  
  // Clinical info
  indications: string[];
  contraindications: string[];
  sideEffects: string[];
  interactions: DrugInteraction[];
  monitoring?: string[];
  pregnancyCategory: 'A' | 'B' | 'C' | 'D' | 'X';
  
  // Tunisia specific
  availableInTunisia: boolean;
  tunisiaPrice?: string;           // Approximate price range
  requiresPrescription: boolean;
  
  // References
  notes?: string;
}

export interface DoseInfo {
  adult: string;
  frequency: string;
  duration?: string;
  maxDose?: string;
}

export interface RenalAdjustment {
  gfr: string;                     // e.g., "30-59", "15-29", "<15"
  dose: string;
  notes?: string;
}

export interface DrugInteraction {
  drug: string;
  severity: 'major' | 'moderate' | 'minor';
  effect: string;
  recommendation: string;
}

export type AntibioticClass = 
  | 'penicillin'
  | 'cephalosporin-1g'
  | 'cephalosporin-2g'
  | 'cephalosporin-3g'
  | 'carbapenem'
  | 'aminoglycoside'
  | 'fluoroquinolone'
  | 'macrolide'
  | 'tetracycline'
  | 'glycopeptide'
  | 'sulfonamide'
  | 'nitroimidazole'
  | 'lincosamide'
  | 'oxazolidinone'
  | 'antifungal'
  | 'antiviral'
  | 'other';

export type SpectrumType = 
  | 'gram-positive'
  | 'gram-negative'
  | 'broad-spectrum'
  | 'anaerobic'
  | 'atypical'
  | 'antifungal'
  | 'antiviral';

export const classLabels: Record<AntibioticClass, string> = {
  'penicillin': 'Pénicillines',
  'cephalosporin-1g': 'Céphalosporines 1ère gén.',
  'cephalosporin-2g': 'Céphalosporines 2ème gén.',
  'cephalosporin-3g': 'Céphalosporines 3ème gén.',
  'carbapenem': 'Carbapénèmes',
  'aminoglycoside': 'Aminosides',
  'fluoroquinolone': 'Fluoroquinolones',
  'macrolide': 'Macrolides',
  'tetracycline': 'Tétracyclines',
  'glycopeptide': 'Glycopeptides',
  'sulfonamide': 'Sulfamides',
  'nitroimidazole': 'Nitroimidazoles',
  'lincosamide': 'Lincosamides',
  'oxazolidinone': 'Oxazolidinones',
  'antifungal': 'Antifongiques',
  'antiviral': 'Antiviraux',
  'other': 'Autres'
};

export const spectrumLabels: Record<SpectrumType, string> = {
  'gram-positive': 'Gram positif',
  'gram-negative': 'Gram négatif',
  'broad-spectrum': 'Large spectre',
  'anaerobic': 'Anaérobies',
  'atypical': 'Atypiques',
  'antifungal': 'Antifongique',
  'antiviral': 'Antiviral'
};

// Common QT-prolonging drugs for interaction checking
export const qtProlongingDrugs: string[] = [
  'amiodarone',
  'sotalol',
  'haloperidol',
  'droperidol',
  'ondansetron',
  'methadone',
  'chlorpromazine',
  'thioridazine',
  'erythromycine',
  'clarithromycine',
  'azithromycine',
  'moxifloxacine',
  'levofloxacine',
  'fluconazole',
  'domperidone',
  'hydroxychloroquine'
];

// Nephrotoxic drugs
export const nephrotoxicDrugs: string[] = [
  'aminosides',
  'vancomycine',
  'amphotéricine B',
  'AINS',
  'IEC',
  'ARA2',
  'produits de contraste',
  'cisplatine',
  'méthotrexate'
];
