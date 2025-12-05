/**
 * Tests for Medical Calculators
 * Tests various medical calculation utilities
 */
import { describe, it, expect } from 'vitest';

describe('Medical Calculators', () => {
  describe('BMI Calculator', () => {
    const calculateBMI = (weightKg: number, heightCm: number): number => {
      const heightM = heightCm / 100;
      return weightKg / (heightM * heightM);
    };

    it('should calculate normal BMI correctly', () => {
      // 70kg, 175cm = 70 / (1.75^2) = 22.86
      const bmi = calculateBMI(70, 175);
      expect(bmi).toBeCloseTo(22.86, 1);
    });

    it('should identify underweight', () => {
      const bmi = calculateBMI(50, 175);
      expect(bmi).toBeLessThan(18.5);
    });

    it('should identify overweight', () => {
      const bmi = calculateBMI(85, 175);
      expect(bmi).toBeGreaterThan(25);
    });

    it('should identify obese', () => {
      const bmi = calculateBMI(110, 175);
      expect(bmi).toBeGreaterThan(30);
    });
  });

  describe('Creatinine Clearance (Cockcroft-Gault)', () => {
    const calculateCrCl = (
      age: number,
      weight: number,
      creatinine: number,
      isFemale: boolean
    ): number => {
      let crcl = ((140 - age) * weight) / (72 * creatinine);
      if (isFemale) {
        crcl *= 0.85;
      }
      return crcl;
    };

    it('should calculate CrCl for male', () => {
      // Male, 50 years, 70kg, Cr 1.0
      const crcl = calculateCrCl(50, 70, 1.0, false);
      expect(crcl).toBeCloseTo(87.5, 1);
    });

    it('should calculate CrCl for female', () => {
      // Female, 50 years, 60kg, Cr 1.0
      const crcl = calculateCrCl(50, 60, 1.0, true);
      expect(crcl).toBeCloseTo(63.75, 1);
    });

    it('should decrease with age', () => {
      const young = calculateCrCl(30, 70, 1.0, false);
      const old = calculateCrCl(70, 70, 1.0, false);
      expect(young).toBeGreaterThan(old);
    });

    it('should decrease with higher creatinine', () => {
      const normal = calculateCrCl(50, 70, 1.0, false);
      const elevated = calculateCrCl(50, 70, 2.0, false);
      expect(normal).toBeGreaterThan(elevated);
    });
  });

  describe('Ideal Body Weight', () => {
    const calculateIBW = (heightCm: number, isMale: boolean): number => {
      const heightInches = heightCm / 2.54;
      const baseHeight = 60; // 5 feet in inches
      
      if (heightInches < baseHeight) {
        return isMale ? 50 : 45.5;
      }
      
      const extraInches = heightInches - baseHeight;
      return isMale 
        ? 50 + (2.3 * extraInches)
        : 45.5 + (2.3 * extraInches);
    };

    it('should calculate IBW for average male', () => {
      // 175cm male
      const ibw = calculateIBW(175, true);
      expect(ibw).toBeCloseTo(70.46, 1);
    });

    it('should calculate IBW for average female', () => {
      // 165cm female
      const ibw = calculateIBW(165, false);
      expect(ibw).toBeCloseTo(56.9, 1);
    });

    it('should handle short patients', () => {
      const ibw = calculateIBW(150, true);
      expect(ibw).toBe(50); // Minimum for male
    });
  });

  describe('Corrected Calcium', () => {
    const calculateCorrectedCalcium = (
      calcium: number,
      albumin: number
    ): number => {
      return calcium + 0.8 * (4.0 - albumin);
    };

    it('should correct for low albumin', () => {
      // Calcium 8.0, Albumin 2.5
      const corrected = calculateCorrectedCalcium(8.0, 2.5);
      expect(corrected).toBeCloseTo(9.2, 1);
    });

    it('should not change with normal albumin', () => {
      const corrected = calculateCorrectedCalcium(9.0, 4.0);
      expect(corrected).toBe(9.0);
    });

    it('should decrease with high albumin', () => {
      const corrected = calculateCorrectedCalcium(10.0, 5.0);
      expect(corrected).toBeCloseTo(9.2, 1);
    });
  });

  describe('Sodium Correction for Glucose', () => {
    const calculateCorrectedSodium = (
      sodium: number,
      glucose: number
    ): number => {
      // Correct for every 100 mg/dL glucose above 100
      const correction = 1.6 * ((glucose - 100) / 100);
      return sodium + correction;
    };

    it('should correct for hyperglycemia', () => {
      // Na 130, Glucose 400
      const corrected = calculateCorrectedSodium(130, 400);
      expect(corrected).toBeCloseTo(134.8, 1);
    });

    it('should not change with normal glucose', () => {
      const corrected = calculateCorrectedSodium(140, 100);
      expect(corrected).toBe(140);
    });

    it('should handle severe hyperglycemia', () => {
      // Na 125, Glucose 800
      const corrected = calculateCorrectedSodium(125, 800);
      expect(corrected).toBeCloseTo(136.2, 1);
    });
  });

  describe('Anion Gap', () => {
    const calculateAnionGap = (
      na: number,
      cl: number,
      hco3: number
    ): number => {
      return na - (cl + hco3);
    };

    it('should calculate normal anion gap', () => {
      // Na 140, Cl 104, HCO3 24
      const ag = calculateAnionGap(140, 104, 24);
      expect(ag).toBe(12);
    });

    it('should detect high anion gap acidosis', () => {
      // Na 140, Cl 100, HCO3 10 (DKA-like)
      const ag = calculateAnionGap(140, 100, 10);
      expect(ag).toBe(30);
      expect(ag).toBeGreaterThan(12);
    });

    it('should detect normal anion gap acidosis', () => {
      // Na 140, Cl 115, HCO3 15 (hyperchloremic)
      const ag = calculateAnionGap(140, 115, 15);
      expect(ag).toBe(10);
      expect(ag).toBeLessThanOrEqual(12);
    });
  });

  describe('Osmolality', () => {
    const calculateOsmolality = (
      na: number,
      glucose: number,
      bun: number
    ): number => {
      return 2 * na + glucose / 18 + bun / 2.8;
    };

    it('should calculate normal osmolality', () => {
      // Na 140, Glucose 100, BUN 14
      const osm = calculateOsmolality(140, 100, 14);
      expect(osm).toBeCloseTo(290.6, 1);
    });

    it('should detect hyperosmolality', () => {
      // Na 145, Glucose 600, BUN 50
      const osm = calculateOsmolality(145, 600, 50);
      expect(osm).toBeGreaterThan(300);
    });
  });

  describe('MELD Score', () => {
    const calculateMELD = (
      bilirubin: number,
      inr: number,
      creatinine: number,
      isDialysis: boolean = false
    ): number => {
      // Set minimum values
      const bili = Math.max(1, bilirubin);
      const cr = Math.max(1, Math.min(4, isDialysis ? 4 : creatinine));
      const inrVal = Math.max(1, inr);

      const score = 
        0.957 * Math.log(cr) +
        0.378 * Math.log(bili) +
        1.120 * Math.log(inrVal) +
        0.643;

      return Math.round(score * 10);
    };

    it('should calculate low MELD', () => {
      // Bilirubin 1, INR 1, Creatinine 1
      const meld = calculateMELD(1, 1, 1);
      expect(meld).toBeLessThan(10);
    });

    it('should calculate moderate MELD', () => {
      // Bilirubin 3, INR 1.5, Creatinine 1.5
      const meld = calculateMELD(3, 1.5, 1.5);
      expect(meld).toBeGreaterThan(10);
      expect(meld).toBeLessThan(25);
    });

    it('should cap creatinine for dialysis', () => {
      const withDialysis = calculateMELD(2, 1.5, 5, true);
      const withoutDialysis = calculateMELD(2, 1.5, 5, false);
      expect(withDialysis).toBe(withoutDialysis); // Both capped at 4
    });
  });

  describe('Wells Score for DVT', () => {
    interface WellsCriteria {
      activeCancer: boolean;
      paralysis: boolean;
      bedridden: boolean;
      tenderness: boolean;
      legSwelling: boolean;
      calfSwelling: boolean;
      pittingEdema: boolean;
      collateralVeins: boolean;
      previousDVT: boolean;
      alternativeDiagnosis: boolean;
    }

    const calculateWellsScore = (criteria: WellsCriteria): number => {
      let score = 0;
      
      if (criteria.activeCancer) score += 1;
      if (criteria.paralysis) score += 1;
      if (criteria.bedridden) score += 1;
      if (criteria.tenderness) score += 1;
      if (criteria.legSwelling) score += 1;
      if (criteria.calfSwelling) score += 1;
      if (criteria.pittingEdema) score += 1;
      if (criteria.collateralVeins) score += 1;
      if (criteria.previousDVT) score += 1;
      if (criteria.alternativeDiagnosis) score -= 2;
      
      return score;
    };

    it('should calculate low probability', () => {
      const score = calculateWellsScore({
        activeCancer: false,
        paralysis: false,
        bedridden: false,
        tenderness: true,
        legSwelling: false,
        calfSwelling: false,
        pittingEdema: false,
        collateralVeins: false,
        previousDVT: false,
        alternativeDiagnosis: true
      });
      expect(score).toBeLessThan(2);
    });

    it('should calculate high probability', () => {
      const score = calculateWellsScore({
        activeCancer: true,
        paralysis: false,
        bedridden: true,
        tenderness: true,
        legSwelling: true,
        calfSwelling: true,
        pittingEdema: true,
        collateralVeins: false,
        previousDVT: true,
        alternativeDiagnosis: false
      });
      expect(score).toBeGreaterThan(3);
    });
  });
});

describe('Unit Conversions', () => {
  describe('Temperature', () => {
    const celsiusToFahrenheit = (c: number): number => (c * 9/5) + 32;
    const fahrenheitToCelsius = (f: number): number => (f - 32) * 5/9;

    it('should convert body temperature C to F', () => {
      expect(celsiusToFahrenheit(37)).toBeCloseTo(98.6, 1);
    });

    it('should convert fever F to C', () => {
      expect(fahrenheitToCelsius(102)).toBeCloseTo(38.9, 1);
    });
  });

  describe('Weight', () => {
    const kgToLbs = (kg: number): number => kg * 2.205;
    const lbsToKg = (lbs: number): number => lbs / 2.205;

    it('should convert kg to lbs', () => {
      expect(kgToLbs(70)).toBeCloseTo(154.35, 1);
    });

    it('should convert lbs to kg', () => {
      expect(lbsToKg(150)).toBeCloseTo(68.03, 1);
    });
  });

  describe('Height', () => {
    const cmToInches = (cm: number): number => cm / 2.54;
    const inchesToCm = (inches: number): number => inches * 2.54;

    it('should convert cm to inches', () => {
      expect(cmToInches(175)).toBeCloseTo(68.9, 1);
    });

    it('should convert inches to cm', () => {
      expect(inchesToCm(70)).toBeCloseTo(177.8, 1);
    });
  });
});
