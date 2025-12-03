// Types for Medical Calculators

export interface CalculatorOption {
  label: string;
  value: number;
  description?: string;
}

export interface CalculatorField {
  id: string;
  label: string;
  type: 'select' | 'number' | 'checkbox' | 'radio';
  options?: CalculatorOption[];
  min?: number;
  max?: number;
  unit?: string;
  required?: boolean;
}

export interface ScoreInterpretation {
  range: [number, number];
  label: string;
  description: string;
  color: 'green' | 'yellow' | 'orange' | 'red';
}

export interface Calculator {
  id: string;
  name: string;
  shortName: string;
  category: CalculatorCategory;
  description: string;
  fields: CalculatorField[];
  calculate: (values: Record<string, number | boolean>) => number;
  interpretations: ScoreInterpretation[];
  source: string;
  sourceUrl?: string;
}

export type CalculatorCategory = 
  | 'trauma'
  | 'cardiovascular'
  | 'pe-dvt'
  | 'neurology'
  | 'sepsis'
  | 'pediatric'
  | 'gi'
  | 'toxicology'
  | 'msk'
  | 'laboratory';

export const categoryLabels: Record<CalculatorCategory, string> = {
  'trauma': '🚑 Trauma',
  'cardiovascular': '❤️ Cardiovasculaire',
  'pe-dvt': '🫁 EP/TVP',
  'neurology': '🧠 Neurologie',
  'sepsis': '🦠 Sepsis/Infections',
  'pediatric': '👶 Pédiatrie',
  'gi': '🏥 Gastro-intestinal',
  'toxicology': '💊 Toxicologie',
  'msk': '🦴 MSK/Rachis',
  'laboratory': '🧪 Laboratoire'
};
