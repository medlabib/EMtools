// Medical Calculators - Main Index

export * from './types';

// Import all calculator arrays
import { traumaScores } from './trauma';
import { cardiovascularScores } from './cardiovascular';
import { peDvtScores } from './pe-dvt';
import { neurologyScores } from './neurology';
import { sepsisScores } from './sepsis';
import { pediatricScores } from './pediatric';
import { giScores } from './gi';
import { toxicologyScores } from './toxicology';
import { mskScores } from './msk';
import { laboratoryScores } from './laboratory';

import type { Calculator, CalculatorCategory } from './types';

// Export individual calculator arrays
export { traumaScores } from './trauma';
export { cardiovascularScores } from './cardiovascular';
export { peDvtScores } from './pe-dvt';
export { neurologyScores } from './neurology';
export { sepsisScores } from './sepsis';
export { pediatricScores } from './pediatric';
export { giScores } from './gi';
export { toxicologyScores } from './toxicology';
export { mskScores } from './msk';
export { laboratoryScores } from './laboratory';

// All calculators combined
export const allCalculators: Calculator[] = [
  ...traumaScores,
  ...cardiovascularScores,
  ...peDvtScores,
  ...neurologyScores,
  ...sepsisScores,
  ...pediatricScores,
  ...giScores,
  ...toxicologyScores,
  ...mskScores,
  ...laboratoryScores
];

// Calculators grouped by category
export const calculatorsByCategory: Record<CalculatorCategory, Calculator[]> = {
  trauma: traumaScores,
  cardiovascular: cardiovascularScores,
  'pe-dvt': peDvtScores,
  neurology: neurologyScores,
  sepsis: sepsisScores,
  pediatric: pediatricScores,
  gi: giScores,
  toxicology: toxicologyScores,
  msk: mskScores,
  laboratory: laboratoryScores
};

// Category labels for UI
export const categoryLabels: Record<CalculatorCategory, string> = {
  trauma: 'Trauma',
  cardiovascular: 'Cardiovasculaire',
  'pe-dvt': 'EP / TVP',
  neurology: 'Neurologie',
  sepsis: 'Sepsis & Infections',
  pediatric: 'Pédiatrie',
  gi: 'Gastro-intestinal',
  toxicology: 'Toxicologie',
  msk: 'Orthopédie (MSK)',
  laboratory: 'Laboratoire'
};

// Get a calculator by ID
export function getCalculatorById(id: string): Calculator | undefined {
  return allCalculators.find(calc => calc.id === id);
}

// Search calculators by name
export function searchCalculators(query: string): Calculator[] {
  const lowerQuery = query.toLowerCase();
  return allCalculators.filter(calc => 
    calc.name.toLowerCase().includes(lowerQuery) ||
    calc.shortName.toLowerCase().includes(lowerQuery) ||
    calc.description.toLowerCase().includes(lowerQuery)
  );
}
