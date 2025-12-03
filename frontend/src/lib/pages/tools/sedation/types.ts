// Types for Sedation Calculator

export type SedationType = 'rsi' | 'procedural' | 'maintenance';
export type DrugRole = 'induction' | 'paralytic' | 'analgesic' | 'sedative' | 'adjunct';
export type AgeGroup = 'neonate' | 'infant' | 'child' | 'adult' | 'elderly';

export interface DoseByAge {
  ageGroup: AgeGroup;
  ageRange: string;
  dose: number;
  maxDose?: number;
  notes?: string;
}

export interface SedationDrug {
  id: string;
  name: string;
  genericName: string;
  drugClass: string;
  role: DrugRole[];
  sedationTypes: SedationType[];
  
  // Dosing
  standardDose: number; // mg/kg for most
  doseUnit: string;
  route: string[];
  dosesByAge?: DoseByAge[];
  maxSingleDose?: number;
  maxSingleDoseUnit?: string;
  
  // Timing
  onsetSeconds: number;
  durationMinutes: number;
  
  // Clinical info
  mechanism: string;
  indications: string[];
  advantages: string[];
  sideEffects: string[];
  contraindications: string[];
  precautions: string[];
  
  // Preparation
  concentrations: string[];
  dilution?: string;
  
  // Special considerations
  renalAdjustment?: string;
  hepaticAdjustment?: string;
  notes: string[];
}

export interface SedationProtocol {
  id: string;
  name: string;
  type: SedationType;
  description: string;
  steps: string[];
  drugs: string[]; // Drug IDs
  monitoring: string[];
  equipment: string[];
}

export interface CalculatedDose {
  drug: SedationDrug;
  dosePerKg: number;
  totalDose: number;
  unit: string;
  volume?: number;
  volumeUnit?: string;
}
