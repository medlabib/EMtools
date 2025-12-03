// Dysnatremia Protocol - Evidence-Based Calculations
// References:
// 1. Adrogué HJ, Madias NE. NEJM 2000;342:1581-1589 - Hyponatremia
// 2. Adrogué HJ, Madias NE. NEJM 2000;342:1493-1499 - Hypernatremia
// 3. Sterns RH. UpToDate 2024 - Treatment of hyponatremia
// 4. Verbalis JG et al. Am J Med 2013;126:S1-S42 - Expert Panel Recommendations

import type { 
  IVFluid, 
  DysnatremiaParams, 
  DysnatremiaResult,
  SafetyLimits,
  Reference,
  SodiumDirection,
  CorrectionMode
} from './types';

// IV Fluids Database
export const IV_FLUIDS: IVFluid[] = [
  {
    id: 'd5w',
    name: 'D5W (0 mEq/L)',
    nameFr: 'G5% (0 mEq/L)',
    sodiumMeq: 0,
    potassiumMeq: 0,
    type: 'hypotonic',
    osmolality: 252
  },
  {
    id: 'nacl02',
    name: '0.2% NaCl (34 mEq/L)',
    nameFr: 'NaCl 0.2% (34 mEq/L)',
    sodiumMeq: 34,
    potassiumMeq: 0,
    type: 'hypotonic',
    osmolality: 68
  },
  {
    id: 'nacl045',
    name: '0.45% NaCl (77 mEq/L)',
    nameFr: 'NaCl 0.45% (77 mEq/L)',
    sodiumMeq: 77,
    potassiumMeq: 0,
    type: 'hypotonic',
    osmolality: 154
  },
  {
    id: 'lr',
    name: 'Lactated Ringer (130 mEq/L)',
    nameFr: 'Ringer Lactate (130 mEq/L)',
    sodiumMeq: 130,
    potassiumMeq: 4,
    type: 'isotonic',
    osmolality: 273
  },
  {
    id: 'ns',
    name: '0.9% NaCl (154 mEq/L)',
    nameFr: 'NaCl 0.9% (154 mEq/L)',
    sodiumMeq: 154,
    potassiumMeq: 0,
    type: 'isotonic',
    osmolality: 308
  },
  {
    id: 'nacl3',
    name: '3% NaCl (513 mEq/L)',
    nameFr: 'NaCl 3% (513 mEq/L)',
    sodiumMeq: 513,
    potassiumMeq: 0,
    type: 'hypertonic',
    osmolality: 1026
  }
];

// Safety Limits based on guidelines
export const SAFETY_LIMITS: SafetyLimits = {
  dysnatremia: {
    chronic: {
      maxDropPerHour: 0.5, // mEq/L/h for hypernatremia (cerebral edema risk)
      maxRisePerDay: 8, // mEq/L/24h for hyponatremia (ODS risk) - Sterns et al.
      maxRisePerHour: 0.33 // ~8/24h
    },
    acute: {
      maxDropPerHour: 1.0, // Can be faster in acute symptomatic hypernatremia
      maxRisePerHour: 1.5 // First 3-4 hours in acute symptomatic hyponatremia
    }
  },
  dyskalemia: {
    maxIVRateCentral: 20, // mEq/h via central line with monitoring
    maxIVRatePeripheral: 10, // mEq/h via peripheral
    maxConcentrationPeripheral: 40, // mEq/L peripheral concentration
    targetRange: [3.5, 5.0]
  },
  dyscalcemia: {
    maxIVCalciumRate: 100, // mg elemental calcium per minute (for gluconate)
    targetCorrectedCa: [8.5, 10.5] // mg/dL
  }
};

// References
export const DYSNATREMIA_REFERENCES: Reference[] = [
  {
    id: 'adrogue2000hypo',
    title: 'Hyponatremia',
    source: 'N Engl J Med 2000;342:1581-1589',
    year: 2000,
    url: 'https://doi.org/10.1056/NEJM200005253422107'
  },
  {
    id: 'adrogue2000hyper',
    title: 'Hypernatremia',
    source: 'N Engl J Med 2000;342:1493-1499',
    year: 2000,
    url: 'https://doi.org/10.1056/NEJM200005183422006'
  },
  {
    id: 'sterns2015',
    title: 'Disorders of Plasma Sodium',
    source: 'N Engl J Med 2015;372:55-65',
    year: 2015,
    url: 'https://doi.org/10.1056/NEJMra1404489'
  },
  {
    id: 'verbalis2013',
    title: 'Diagnosis, Evaluation, and Treatment of Hyponatremia: Expert Panel Recommendations',
    source: 'Am J Med 2013;126:S1-S42',
    year: 2013
  },
  {
    id: 'uptodate2024',
    title: 'Treatment of hypernatremia in adults',
    source: 'UpToDate 2024',
    year: 2024
  }
];

/**
 * Calculate Total Body Water (TBW)
 * Based on Watson formula modifications
 * - Adult male: 0.6 × weight
 * - Adult female: 0.5 × weight
 * - Elderly male: 0.5 × weight
 * - Elderly female: 0.45 × weight
 * - Child: 0.6 × weight
 */
export function calculateTBW(weight: number, sex: 'male' | 'female', ageGroup: 'child' | 'adult' | 'elderly'): number {
  let factor = 0.6;
  
  if (ageGroup === 'child') {
    factor = 0.6;
  } else if (ageGroup === 'elderly') {
    factor = sex === 'male' ? 0.5 : 0.45;
  } else {
    factor = sex === 'male' ? 0.6 : 0.5;
  }
  
  return weight * factor;
}

/**
 * Calculate Free Water Deficit (for Hypernatremia)
 * Formula: FWD = TBW × [(Current Na / Target Na) - 1]
 * Reference: Adrogué & Madias, NEJM 2000
 */
export function calculateFreeWaterDeficit(tbw: number, currentNa: number, targetNa: number): number {
  return tbw * ((currentNa / targetNa) - 1);
}

/**
 * Calculate Sodium Deficit (for Hyponatremia - to determine concentration needed)
 * Formula: Na Deficit = TBW × (Target Na - Current Na)
 * Note: This is theoretical - actual correction accounts for ongoing losses
 */
export function calculateSodiumDeficit(tbw: number, currentNa: number, targetNa: number): number {
  return tbw * (targetNa - currentNa);
}

/**
 * Adrogué-Madias Formula
 * Predicts change in serum sodium for 1L of infusate
 * ΔNa = (Infusate Na - Serum Na) / (TBW + 1)
 * Reference: Adrogué HJ, Madias NE. NEJM 2000
 */
export function adrogueMadiasFormula(infusateNa: number, serumNa: number, tbw: number): number {
  return (infusateNa - serumNa) / (tbw + 1);
}

/**
 * Calculate required infusion parameters
 * Uses mass balance approach with Adrogué-Madias as verification
 */
export function calculateDysnatremiaCorrection(params: DysnatremiaParams): DysnatremiaResult {
  const tbw = calculateTBW(params.weight, params.sex, params.ageGroup);
  const deltaNA = params.targetNa - params.baselineNa;
  const ratePerHour = deltaNA / 24;
  const absRate = Math.abs(ratePerHour);
  
  // Calculate deficits
  const freeWaterDeficit = params.direction === 'hyper' 
    ? calculateFreeWaterDeficit(tbw, params.baselineNa, params.targetNa)
    : 0;
  
  const sodiumDeficit = params.direction === 'hypo'
    ? calculateSodiumDeficit(tbw, params.baselineNa, params.targetNa)
    : 0;
  
  // Safety check
  const limits = SAFETY_LIMITS.dysnatremia;
  let isUnsafe = false;
  let safetyWarning = '';
  
  if (params.direction === 'hyper') {
    // Hypernatremia: checking drop rate
    const maxRate = params.mode === 'acute' ? limits.acute.maxDropPerHour : limits.chronic.maxDropPerHour;
    if (absRate > maxRate) {
      isUnsafe = true;
      safetyWarning = params.mode === 'acute' 
        ? `⚠️ Vitesse > ${maxRate} mEq/L/h (limite aiguë)`
        : `⚠️ Vitesse > ${maxRate} mEq/L/h - Risque d'œdème cérébral`;
    }
  } else {
    // Hyponatremia: checking rise rate (ODS risk)
    const maxRate = params.mode === 'acute' ? limits.acute.maxRisePerHour : limits.chronic.maxRisePerHour;
    if (absRate > maxRate) {
      isUnsafe = true;
      safetyWarning = params.mode === 'acute'
        ? `⚠️ Vitesse > ${maxRate} mEq/L/h (limite aiguë)`
        : `🚨 RISQUE ODS: Vitesse > ${limits.chronic.maxRisePerDay} mEq/L/jour`;
    }
  }
  
  // Calculate fluid mix volumes
  const totalLosses = (params.urineOutput + params.insensibleLoss) / 1000; // Convert to L
  
  // Volume constraint calculation
  let totalVolumeConstraint = totalLosses;
  if (params.direction === 'hyper') {
    totalVolumeConstraint += Math.max(0, freeWaterDeficit);
  }
  
  // Calculate required mixed Na concentration
  const requiredMixNa = (params.targetNa * (tbw + totalVolumeConstraint - totalLosses) - (tbw * params.baselineNa)) / totalVolumeConstraint;
  
  // Calculate fluid volumes to achieve mix
  let volA = 0;
  let volB = 0;
  const fluidANa = params.fluidA.sodiumMeq;
  const fluidBNa = params.fluidB.sodiumMeq;
  
  if (Math.abs(fluidANa - fluidBNa) < 1) {
    volA = totalVolumeConstraint;
  } else {
    volA = totalVolumeConstraint * (requiredMixNa - fluidBNa) / (fluidANa - fluidBNa);
    volB = totalVolumeConstraint - volA;
  }
  
  // Bounds correction
  if (volA < 0) { volA = 0; volB = totalVolumeConstraint; }
  if (volB < 0) { volB = 0; volA = totalVolumeConstraint; }
  
  // Convert to rates (mL/h)
  const fluidARate = Math.round((volA * 1000) / 24);
  const fluidBRate = Math.round((volB * 1000) / 24);
  const totalRate = fluidARate + fluidBRate;
  
  return {
    tbw,
    freeWaterDeficit,
    sodiumDeficit,
    deltaNA,
    ratePerHour,
    isUnsafe,
    safetyWarning,
    fluidARate,
    fluidBRate,
    totalRate,
    totalVolume24h: totalVolumeConstraint
  };
}

/**
 * Get recommended fluids based on direction
 */
export function getRecommendedFluids(direction: SodiumDirection): { primary: IVFluid; secondary: IVFluid } {
  if (direction === 'hyper') {
    // For hypernatremia: use hypotonic fluids
    return {
      primary: IV_FLUIDS.find(f => f.id === 'd5w')!,
      secondary: IV_FLUIDS.find(f => f.id === 'ns')!
    };
  } else {
    // For hyponatremia: use hypertonic or isotonic
    return {
      primary: IV_FLUIDS.find(f => f.id === 'nacl3')!,
      secondary: IV_FLUIDS.find(f => f.id === 'ns')!
    };
  }
}

/**
 * Get default sodium values based on direction
 */
export function getDefaultSodiumValues(direction: SodiumDirection): { baseline: number; target: number } {
  if (direction === 'hyper') {
    return { baseline: 160, target: 150 };
  } else {
    return { baseline: 115, target: 121 };
  }
}

/**
 * Get safety limit display text
 */
export function getSafetyLimitText(direction: SodiumDirection, mode: CorrectionMode): string {
  const limits = SAFETY_LIMITS.dysnatremia;
  
  if (direction === 'hyper') {
    const rate = mode === 'acute' ? limits.acute.maxDropPerHour : limits.chronic.maxDropPerHour;
    return `Max: ${rate} mEq/L/h`;
  } else {
    if (mode === 'acute') {
      return `Max: ${limits.acute.maxRisePerHour} mEq/L/h (3-4h)`;
    } else {
      return `Max: ${limits.chronic.maxRisePerDay} mEq/L/24h (~0.33/h)`;
    }
  }
}
