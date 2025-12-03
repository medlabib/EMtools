// Metabolic Disorders Correction Protocol - Types
// Based on evidence-based guidelines from:
// - UpToDate 2024
// - NEJM Clinical Practice
// - Critical Care Medicine Guidelines
// - Endocrine Society Guidelines

export type DisorderType = 'dysnatremia' | 'dyskalemia' | 'dyscalcemia';
export type SodiumDirection = 'hyper' | 'hypo';
export type PotassiumDirection = 'hyper' | 'hypo';
export type CalciumDirection = 'hyper' | 'hypo';
export type CorrectionMode = 'acute' | 'chronic';
export type AgeGroup = 'child' | 'adult' | 'elderly';
export type Sex = 'male' | 'female';

// Fluid definitions for IV therapy
export interface IVFluid {
  id: string;
  name: string;
  nameFr: string;
  sodiumMeq: number; // mEq/L
  potassiumMeq: number; // mEq/L
  type: 'hypotonic' | 'isotonic' | 'hypertonic';
  osmolality: number; // mOsm/kg
}

// Patient parameters
export interface PatientParams {
  weight: number; // kg
  sex: Sex;
  ageGroup: AgeGroup;
  age?: number;
}

// Dysnatremia specific
export interface DysnatremiaParams extends PatientParams {
  baselineNa: number; // mEq/L
  targetNa: number; // mEq/L at 24h
  direction: SodiumDirection;
  mode: CorrectionMode;
  urineOutput: number; // mL/24h
  insensibleLoss: number; // mL/24h
  fluidA: IVFluid;
  fluidB: IVFluid;
}

export interface DysnatremiaResult {
  tbw: number; // Total Body Water in L
  freeWaterDeficit: number; // L (for hypernatremia)
  sodiumDeficit: number; // mEq (for hyponatremia)
  deltaNA: number; // mEq/L change
  ratePerHour: number; // mEq/L/h
  isUnsafe: boolean;
  safetyWarning: string;
  fluidARate: number; // mL/h
  fluidBRate: number; // mL/h
  totalRate: number; // mL/h
  totalVolume24h: number; // L
}

// Dyskalemia specific
export interface DyskalemiaParams extends PatientParams {
  potassium: number; // mEq/L
  direction: PotassiumDirection;
  hasECGChanges: boolean;
  ecgFindings: string[];
  renalFunction: 'normal' | 'impaired' | 'dialysis';
  hasMuscleWeakness: boolean;
  isOnDigoxin: boolean;
  magnesium?: number; // mEq/L
}

export interface PotassiumTreatment {
  id: string;
  name: string;
  nameFr: string;
  dose: string;
  route: 'IV' | 'PO' | 'Nebulized' | 'Rectal';
  onset: string;
  duration: string;
  mechanism: 'shift' | 'elimination' | 'cardioprotection' | 'replacement';
  notes: string;
  notesFr: string;
  contraindications: string[];
  urgency: 'immediate' | 'urgent' | 'routine';
}

export interface DyskalemiaResult {
  severity: 'normal' | 'mild' | 'moderate' | 'severe' | 'critical';
  treatments: PotassiumTreatment[];
  monitoringInterval: string;
  targetRange: [number, number];
  warnings: string[];
}

// Dyscalcemia specific
export interface DyscalcemiaParams extends PatientParams {
  totalCalcium: number; // mg/dL or mmol/L
  albumin: number; // g/dL
  ionizedCalcium?: number; // mmol/L (if available)
  direction: CalciumDirection;
  hasSymptoms: boolean;
  symptoms: string[];
  phosphorus?: number;
  pth?: number;
  vitaminD?: number;
  renalFunction: 'normal' | 'impaired' | 'dialysis';
}

export interface CalciumTreatment {
  id: string;
  name: string;
  nameFr: string;
  dose: string;
  route: 'IV' | 'PO';
  indication: string;
  notes: string;
  notesFr: string;
  contraindications: string[];
  urgency: 'immediate' | 'urgent' | 'routine';
}

export interface DyscalcemiaResult {
  correctedCalcium: number; // mg/dL
  severity: 'mild' | 'moderate' | 'severe';
  treatments: CalciumTreatment[];
  warnings: string[];
  targetRange: [number, number];
}

// Safety limits based on evidence
export interface SafetyLimits {
  dysnatremia: {
    chronic: {
      maxDropPerHour: number; // mEq/L/h for hypernatremia
      maxRisePerDay: number; // mEq/L/24h for hyponatremia (ODS risk)
      maxRisePerHour: number;
    };
    acute: {
      maxDropPerHour: number;
      maxRisePerHour: number;
    };
  };
  dyskalemia: {
    maxIVRateCentral: number; // mEq/h via central line
    maxIVRatePeripheral: number; // mEq/h via peripheral
    maxConcentrationPeripheral: number; // mEq/L
    targetRange: [number, number];
  };
  dyscalcemia: {
    maxIVCalciumRate: number; // mg elemental Ca/min
    targetCorrectedCa: [number, number]; // mg/dL
  };
}

// References for evidence-based practice
export interface Reference {
  id: string;
  title: string;
  source: string;
  year: number;
  url?: string;
}
