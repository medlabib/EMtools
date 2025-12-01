/**
 * Tests for vasoactive drugs calculator
 */
import { describe, it, expect } from 'vitest';
import { vasoactiveDrugs, calculateFlowRate, getDrugById } from '../../src/lib/pages/tools/vasoactive/drugs';
import type { VasoactiveDrug } from '../../src/lib/pages/tools/vasoactive/types';

describe('Vasoactive Drugs Calculator', () => {
  describe('Drug Database', () => {
    it('should have all expected drugs', () => {
      const expectedDrugs = [
        'noradrenaline',
        'adrenaline',
        'dobutamine',
        'dopamine',
        'isoproterenol',
        'milrinone'
      ];

      expectedDrugs.forEach(drugId => {
        const drug = getDrugById(drugId);
        expect(drug).toBeDefined();
      });
    });

    it('should have correct structure for each drug', () => {
      vasoactiveDrugs.forEach((drug: VasoactiveDrug) => {
        expect(drug).toHaveProperty('id');
        expect(drug).toHaveProperty('name');
        expect(drug).toHaveProperty('doseUnit');
        expect(drug).toHaveProperty('doseRange');
        expect(drug).toHaveProperty('concentrations');
        expect(drug).toHaveProperty('indications');
        expect(Array.isArray(drug.indications)).toBe(true);
      });
    });

    it('should have valid dose ranges', () => {
      vasoactiveDrugs.forEach((drug: VasoactiveDrug) => {
        expect(drug.doseRange.min).toBeLessThan(drug.doseRange.max);
        expect(drug.doseRange.min).toBeGreaterThanOrEqual(0);
      });
    });
  });

  describe('calculateFlowRate', () => {
    it('should calculate noradrenaline infusion correctly', () => {
      const norad = getDrugById('noradrenaline');
      if (norad) {
        const concentration = norad.concentrations[0].mgPerMl;
        const result = calculateFlowRate(norad, 70, 0.1, concentration);
        
        expect(result).toBeGreaterThan(0);
        expect(typeof result).toBe('number');
      }
    });

    it('should scale with patient weight', () => {
      const norad = getDrugById('noradrenaline');
      if (norad) {
        const concentration = norad.concentrations[0].mgPerMl;
        const result70kg = calculateFlowRate(norad, 70, 0.1, concentration);
        const result100kg = calculateFlowRate(norad, 100, 0.1, concentration);
        
        // Flow rate should be proportionally higher for heavier patient
        expect(result100kg).toBeGreaterThan(result70kg);
      }
    });

    it('should scale with dose', () => {
      const norad = getDrugById('noradrenaline');
      if (norad) {
        const concentration = norad.concentrations[0].mgPerMl;
        const lowDose = calculateFlowRate(norad, 70, 0.1, concentration);
        const highDose = calculateFlowRate(norad, 70, 0.5, concentration);
        
        expect(highDose).toBeGreaterThan(lowDose);
      }
    });

    it('should calculate dobutamine correctly', () => {
      const dobu = getDrugById('dobutamine');
      if (dobu) {
        const concentration = dobu.concentrations[0].mgPerMl;
        const result = calculateFlowRate(dobu, 70, 5, concentration);
        
        expect(result).toBeGreaterThan(0);
      }
    });
  });

  describe('getDrugById', () => {
    it('should return correct drug for valid id', () => {
      const norad = getDrugById('noradrenaline');
      expect(norad).toBeDefined();
      expect(norad?.name).toBe('Noradrénaline');
    });

    it('should return undefined for invalid id', () => {
      const unknown = getDrugById('unknowndrug');
      expect(unknown).toBeUndefined();
    });
  });
});
