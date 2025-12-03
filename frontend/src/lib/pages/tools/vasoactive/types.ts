// Types for Vasoactive Drug Calculator

export interface DrugConcentration {
  label: string;
  mgPerMl: number; // mg per mL
  commonPrep: string; // Common preparation description
}

export interface VasoactiveDrug {
  id: string;
  name: string;
  genericName: string;
  category: 'vasopressor' | 'inotrope' | 'vasodilator' | 'mixed';
  description: string;
  concentrations: DrugConcentration[];
  defaultConcentrationIndex: number;
  doseUnit: 'mcg/kg/min' | 'mcg/min' | 'mg/h' | 'UI/min';
  doseRange: {
    min: number;
    max: number;
    typical: number;
    step: number;
  };
  indications: string[];
  effects: {
    alpha: 'none' | 'low' | 'moderate' | 'high';
    beta1: 'none' | 'low' | 'moderate' | 'high';
    beta2: 'none' | 'low' | 'moderate' | 'high';
    dopaminergic: 'none' | 'low' | 'moderate' | 'high';
    vasopressin: 'none' | 'low' | 'moderate' | 'high';
  };
  sideEffects: string[];
  contraindications: string[];
  notes: string[];
}

export interface PSECalculation {
  drug: VasoactiveDrug;
  patientWeight: number;
  dose: number;
  concentration: DrugConcentration;
  flowRateMlH: number;
  syringeVolume: number;
  drugAmountMg: number;
  diluentVolumeMl: number;
  durationHours: number;
}
