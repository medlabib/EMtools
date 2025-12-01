/**
 * Tests for metabolic disorders calculator
 */
import { describe, it, expect } from 'vitest';
import { 
  IV_FLUIDS, 
  calculateTBW
} from '../../src/lib/pages/tools/metabolic/dysnatremia';
import { 
  HYPERKALEMIA_TREATMENTS, 
  HYPOKALEMIA_TREATMENTS,
  HYPERKALEMIA_ECG_FINDINGS,
  HYPOKALEMIA_ECG_FINDINGS
} from '../../src/lib/pages/tools/metabolic/dyskalemia';
import { 
  HYPERCALCEMIA_TREATMENTS, 
  HYPOCALCEMIA_TREATMENTS 
} from '../../src/lib/pages/tools/metabolic/dyscalcemia';

describe('Metabolic Disorders Calculator', () => {
  describe('Dysnatremia - IV Fluids', () => {
    it('should have all expected IV fluids', () => {
      expect(IV_FLUIDS.length).toBeGreaterThanOrEqual(6);
      
      const fluidIds = IV_FLUIDS.map(f => f.id);
      expect(fluidIds).toContain('d5w');
      expect(fluidIds).toContain('ns');
      expect(fluidIds).toContain('nacl3');
    });

    it('should have correct sodium concentrations', () => {
      const d5w = IV_FLUIDS.find(f => f.id === 'd5w');
      expect(d5w?.sodiumMeq).toBe(0);
      
      const ns = IV_FLUIDS.find(f => f.id === 'ns');
      expect(ns?.sodiumMeq).toBe(154);
      
      const nacl3 = IV_FLUIDS.find(f => f.id === 'nacl3');
      expect(nacl3?.sodiumMeq).toBe(513);
    });

    it('should have fluid types for each', () => {
      IV_FLUIDS.forEach(fluid => {
        expect(['hypotonic', 'isotonic', 'hypertonic']).toContain(fluid.type);
      });
    });
  });

  describe('calculateTBW', () => {
    it('should calculate TBW for adult male', () => {
      const tbw = calculateTBW(70, 'male', 'adult');
      expect(tbw).toBeCloseTo(42, 0); // 70 * 0.6 = 42
    });

    it('should calculate TBW for adult female', () => {
      const tbw = calculateTBW(60, 'female', 'adult');
      expect(tbw).toBeCloseTo(30, 0); // 60 * 0.5 = 30
    });

    it('should calculate TBW for elderly', () => {
      const elderlyMale = calculateTBW(70, 'male', 'elderly');
      const adultMale = calculateTBW(70, 'male', 'adult');
      
      expect(elderlyMale).toBeLessThan(adultMale);
    });

    it('should calculate TBW for child', () => {
      const childTbw = calculateTBW(30, 'male', 'child');
      expect(childTbw).toBeGreaterThan(0);
    });
  });

  describe('Dyskalemia', () => {
    describe('Hyperkalemia Treatments', () => {
      it('should have treatment options', () => {
        expect(HYPERKALEMIA_TREATMENTS.length).toBeGreaterThan(0);
      });

      it('should have calcium gluconate', () => {
        const cg = HYPERKALEMIA_TREATMENTS.find(
          (t: { id: string }) => t.id === 'calcium_gluconate'
        );
        expect(cg).toBeDefined();
        expect(cg?.onset).toBeDefined();
      });

      it('should have treatments with correct structure', () => {
        HYPERKALEMIA_TREATMENTS.forEach((t: { id: string; name: string; dose: string; route: string }) => {
          expect(t).toHaveProperty('id');
          expect(t).toHaveProperty('name');
          expect(t).toHaveProperty('dose');
          expect(t).toHaveProperty('route');
        });
      });
    });

    describe('Hypokalemia Treatments', () => {
      it('should have treatment options', () => {
        expect(HYPOKALEMIA_TREATMENTS.length).toBeGreaterThan(0);
      });
    });

    describe('ECG Findings', () => {
      it('should have hyperkalemia ECG findings', () => {
        expect(HYPERKALEMIA_ECG_FINDINGS.length).toBeGreaterThan(0);
        
        const peakedT = HYPERKALEMIA_ECG_FINDINGS.find(f => f.id === 'peaked_t');
        expect(peakedT).toBeDefined();
      });

      it('should have hypokalemia ECG findings', () => {
        expect(HYPOKALEMIA_ECG_FINDINGS.length).toBeGreaterThan(0);
        
        const uWave = HYPOKALEMIA_ECG_FINDINGS.find(f => f.id === 'u_wave');
        expect(uWave).toBeDefined();
      });
    });
  });

  describe('Dyscalcemia', () => {
    describe('Hypercalcemia Treatments', () => {
      it('should have treatment options', () => {
        expect(HYPERCALCEMIA_TREATMENTS.length).toBeGreaterThan(0);
      });

      it('should include saline hydration', () => {
        const saline = HYPERCALCEMIA_TREATMENTS.find(
          (t: { id: string }) => t.id === 'iv_fluids'
        );
        expect(saline).toBeDefined();
      });
    });

    describe('Hypocalcemia Treatments', () => {
      it('should have treatment options', () => {
        expect(HYPOCALCEMIA_TREATMENTS.length).toBeGreaterThan(0);
      });

      it('should include calcium gluconate', () => {
        const cg = HYPOCALCEMIA_TREATMENTS.find(
          (t: { id: string }) => t.id === 'calcium_gluconate_iv'
        );
        expect(cg).toBeDefined();
      });
    });
  });
});
