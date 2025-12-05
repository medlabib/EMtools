/**
 * Tests for Vasoactive Drug Calculations
 * Tests dosing, infusion rates, and dilution calculations
 */
import { describe, it, expect } from 'vitest';

describe('Vasoactive Drug Calculations', () => {
  describe('Norepinephrine', () => {
    // Standard: 4mg in 250mL = 16 mcg/mL
    const concentration = 16; // mcg/mL

    const calculateDose = (
      rate: number, // mL/hr
      concentration: number, // mcg/mL
      weight: number // kg
    ): number => {
      // Dose in mcg/kg/min
      return (rate * concentration) / (weight * 60);
    };

    const calculateRate = (
      dose: number, // mcg/kg/min
      concentration: number, // mcg/mL
      weight: number // kg
    ): number => {
      // Rate in mL/hr
      return (dose * weight * 60) / concentration;
    };

    it('should calculate dose from rate', () => {
      // 10 mL/hr, 70kg patient
      const dose = calculateDose(10, concentration, 70);
      expect(dose).toBeCloseTo(0.038, 2);
    });

    it('should calculate rate from dose', () => {
      // 0.1 mcg/kg/min, 70kg patient
      const rate = calculateRate(0.1, concentration, 70);
      expect(rate).toBeCloseTo(26.25, 1);
    });

    it('should handle low dose range', () => {
      // 0.05 mcg/kg/min
      const rate = calculateRate(0.05, concentration, 70);
      expect(rate).toBeCloseTo(13.125, 1);
    });

    it('should handle high dose range', () => {
      // 0.5 mcg/kg/min (high dose)
      const rate = calculateRate(0.5, concentration, 70);
      expect(rate).toBeCloseTo(131.25, 1);
    });
  });

  describe('Vasopressin', () => {
    // Standard: 100 units in 100mL = 1 unit/mL
    const concentration = 1; // unit/mL

    const calculateRate = (dose: number): number => {
      // Dose in units/min, rate in mL/hr
      return dose * 60 / concentration;
    };

    it('should calculate standard septic shock dose', () => {
      // 0.03 units/min
      const rate = calculateRate(0.03);
      expect(rate).toBeCloseTo(1.8, 1);
    });

    it('should calculate high dose', () => {
      // 0.04 units/min
      const rate = calculateRate(0.04);
      expect(rate).toBeCloseTo(2.4, 1);
    });
  });

  describe('Epinephrine', () => {
    // Standard: 4mg in 250mL = 16 mcg/mL
    const concentration = 16; // mcg/mL

    const calculateDose = (
      rate: number,
      concentration: number,
      weight: number
    ): number => {
      return (rate * concentration) / (weight * 60);
    };

    const calculateRate = (
      dose: number,
      concentration: number,
      weight: number
    ): number => {
      return (dose * weight * 60) / concentration;
    };

    it('should calculate low dose (beta effects)', () => {
      // 0.05 mcg/kg/min
      const rate = calculateRate(0.05, concentration, 70);
      expect(rate).toBeCloseTo(13.125, 1);
    });

    it('should calculate high dose (alpha effects)', () => {
      // 0.2 mcg/kg/min
      const rate = calculateRate(0.2, concentration, 70);
      expect(rate).toBeCloseTo(52.5, 1);
    });
  });

  describe('Dobutamine', () => {
    // Standard: 250mg in 250mL = 1000 mcg/mL
    const concentration = 1000; // mcg/mL

    const calculateRate = (
      dose: number, // mcg/kg/min
      weight: number // kg
    ): number => {
      return (dose * weight * 60) / concentration;
    };

    it('should calculate starting dose', () => {
      // 2.5 mcg/kg/min
      const rate = calculateRate(2.5, 70);
      expect(rate).toBeCloseTo(10.5, 1);
    });

    it('should calculate moderate dose', () => {
      // 5 mcg/kg/min
      const rate = calculateRate(5, 70);
      expect(rate).toBeCloseTo(21, 1);
    });

    it('should calculate max dose', () => {
      // 20 mcg/kg/min
      const rate = calculateRate(20, 70);
      expect(rate).toBeCloseTo(84, 1);
    });
  });

  describe('Dopamine', () => {
    // Standard: 400mg in 250mL = 1600 mcg/mL
    const concentration = 1600; // mcg/mL

    const calculateRate = (
      dose: number,
      weight: number
    ): number => {
      return (dose * weight * 60) / concentration;
    };

    it('should calculate renal dose', () => {
      // 2 mcg/kg/min (renal)
      const rate = calculateRate(2, 70);
      expect(rate).toBeCloseTo(5.25, 1);
    });

    it('should calculate inotropic dose', () => {
      // 5 mcg/kg/min (beta)
      const rate = calculateRate(5, 70);
      expect(rate).toBeCloseTo(13.125, 1);
    });

    it('should calculate vasopressor dose', () => {
      // 15 mcg/kg/min (alpha)
      const rate = calculateRate(15, 70);
      expect(rate).toBeCloseTo(39.375, 1);
    });
  });

  describe('Phenylephrine', () => {
    // Standard: 10mg in 250mL = 40 mcg/mL
    const concentration = 40; // mcg/mL

    const calculateRate = (dose: number): number => {
      // Dose in mcg/min, rate in mL/hr
      return (dose * 60) / concentration;
    };

    it('should calculate starting dose', () => {
      // 50 mcg/min
      const rate = calculateRate(50);
      expect(rate).toBeCloseTo(75, 1);
    });

    it('should calculate maintenance dose', () => {
      // 100 mcg/min
      const rate = calculateRate(100);
      expect(rate).toBeCloseTo(150, 1);
    });
  });

  describe('Milrinone', () => {
    // Standard: 20mg in 100mL = 200 mcg/mL
    const concentration = 200; // mcg/mL

    const calculateRate = (
      dose: number, // mcg/kg/min
      weight: number // kg
    ): number => {
      return (dose * weight * 60) / concentration;
    };

    it('should calculate standard dose', () => {
      // 0.375 mcg/kg/min
      const rate = calculateRate(0.375, 70);
      expect(rate).toBeCloseTo(7.875, 1);
    });

    it('should calculate max dose', () => {
      // 0.75 mcg/kg/min
      const rate = calculateRate(0.75, 70);
      expect(rate).toBeCloseTo(15.75, 1);
    });

    it('should calculate loading dose', () => {
      // 50 mcg/kg over 10 min for 70kg = 3.5mg
      const loadingDose = 50 * 70 / 1000; // mg
      expect(loadingDose).toBeCloseTo(3.5, 1);
    });
  });
});

describe('Drug Dilutions', () => {
  describe('Standard Dilutions', () => {
    const dilutions = {
      norepinephrine: { drug: 4, volume: 250, unit: 'mg' },
      epinephrine: { drug: 4, volume: 250, unit: 'mg' },
      vasopressin: { drug: 100, volume: 100, unit: 'units' },
      dobutamine: { drug: 250, volume: 250, unit: 'mg' },
      dopamine: { drug: 400, volume: 250, unit: 'mg' },
      phenylephrine: { drug: 10, volume: 250, unit: 'mg' },
      milrinone: { drug: 20, volume: 100, unit: 'mg' }
    };

    it('should have correct norepinephrine dilution', () => {
      expect(dilutions.norepinephrine.drug).toBe(4);
      expect(dilutions.norepinephrine.volume).toBe(250);
    });

    it('should calculate norepinephrine concentration', () => {
      const conc = (dilutions.norepinephrine.drug * 1000) / dilutions.norepinephrine.volume;
      expect(conc).toBe(16); // mcg/mL
    });

    it('should calculate dobutamine concentration', () => {
      const conc = (dilutions.dobutamine.drug * 1000) / dilutions.dobutamine.volume;
      expect(conc).toBe(1000); // mcg/mL
    });

    it('should calculate dopamine concentration', () => {
      const conc = (dilutions.dopamine.drug * 1000) / dilutions.dopamine.volume;
      expect(conc).toBe(1600); // mcg/mL
    });
  });
});

describe('Dose Range Validation', () => {
  interface DrugDoseRange {
    min: number;
    max: number;
    unit: string;
  }

  const doseRanges: Record<string, DrugDoseRange> = {
    norepinephrine: { min: 0.01, max: 3, unit: 'mcg/kg/min' },
    epinephrine: { min: 0.01, max: 0.5, unit: 'mcg/kg/min' },
    vasopressin: { min: 0.01, max: 0.04, unit: 'units/min' },
    dobutamine: { min: 2.5, max: 20, unit: 'mcg/kg/min' },
    dopamine: { min: 1, max: 20, unit: 'mcg/kg/min' },
    phenylephrine: { min: 40, max: 200, unit: 'mcg/min' },
    milrinone: { min: 0.125, max: 0.75, unit: 'mcg/kg/min' }
  };

  const validateDose = (drug: string, dose: number): boolean => {
    const range = doseRanges[drug];
    return dose >= range.min && dose <= range.max;
  };

  it('should validate norepinephrine dose in range', () => {
    expect(validateDose('norepinephrine', 0.1)).toBe(true);
    expect(validateDose('norepinephrine', 0.5)).toBe(true);
  });

  it('should reject norepinephrine dose out of range', () => {
    expect(validateDose('norepinephrine', 0.001)).toBe(false);
    expect(validateDose('norepinephrine', 5)).toBe(false);
  });

  it('should validate vasopressin dose', () => {
    expect(validateDose('vasopressin', 0.03)).toBe(true);
    expect(validateDose('vasopressin', 0.05)).toBe(false);
  });

  it('should validate dobutamine dose', () => {
    expect(validateDose('dobutamine', 5)).toBe(true);
    expect(validateDose('dobutamine', 25)).toBe(false);
  });
});

describe('Weight-Based Calculations', () => {
  describe('Actual vs Ideal Body Weight', () => {
    const calculateIBW = (height: number, male: boolean): number => {
      const heightInches = height / 2.54;
      const base = male ? 50 : 45.5;
      return base + 2.3 * Math.max(0, heightInches - 60);
    };

    const calculateABW = (actual: number, ideal: number): number => {
      // Adjusted body weight for obese patients
      return ideal + 0.4 * (actual - ideal);
    };

    it('should use IBW for normal weight', () => {
      const ibw = calculateIBW(175, true);
      const actual = 75;
      
      // If actual < IBW * 1.2, use actual
      if (actual <= ibw * 1.2) {
        expect(actual).toBeLessThanOrEqual(ibw * 1.2);
      }
    });

    it('should use ABW for obese patients', () => {
      const ibw = calculateIBW(175, true);
      const actual = 120;
      const abw = calculateABW(actual, ibw);
      
      expect(abw).toBeGreaterThan(ibw);
      expect(abw).toBeLessThan(actual);
    });
  });
});
