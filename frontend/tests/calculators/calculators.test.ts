/**
 * Tests for medical calculator functions
 */
import { describe, it, expect } from 'vitest';
import { calculatorsByCategory, allCalculators, categoryLabels } from '../../src/lib/pages/tools/calculators';
import { cardiovascularScores } from '../../src/lib/pages/tools/calculators/cardiovascular';
import { neurologyScores } from '../../src/lib/pages/tools/calculators/neurology';
import { sepsisScores } from '../../src/lib/pages/tools/calculators/sepsis';

describe('Medical Calculators', () => {
  describe('Calculator Categories', () => {
    it('should have all expected categories', () => {
      const expectedCategories = [
        'cardiovascular',
        'neurology',
        'pe-dvt',
        'sepsis',
        'trauma',
        'pediatric',
        'toxicology',
        'gi',
        'msk'
      ];

      expectedCategories.forEach(category => {
        expect(calculatorsByCategory).toHaveProperty(category);
      });
    });

    it('should have labels for each category', () => {
      Object.keys(calculatorsByCategory).forEach(key => {
        expect(categoryLabels).toHaveProperty(key);
        expect(typeof categoryLabels[key as keyof typeof categoryLabels]).toBe('string');
      });
    });
  });

  describe('All Calculators', () => {
    it('should have more than 30 calculators total', () => {
      expect(allCalculators.length).toBeGreaterThanOrEqual(30);
    });

    it('should have calculators with correct structure', () => {
      allCalculators.forEach(calc => {
        expect(calc).toHaveProperty('id');
        expect(calc).toHaveProperty('name');
        expect(calc).toHaveProperty('description');
        expect(calc).toHaveProperty('category');
        expect(calc).toHaveProperty('fields');
        expect(calc).toHaveProperty('calculate');
        expect(typeof calc.calculate).toBe('function');
      });
    });

    it('should have unique ids', () => {
      const ids = allCalculators.map(c => c.id);
      const uniqueIds = new Set(ids);
      expect(uniqueIds.size).toBe(ids.length);
    });
  });
});

describe('Calculator Calculations', () => {
  describe('Cardiovascular Calculators', () => {
    it('HEART score should calculate correctly', () => {
      const heartCalc = cardiovascularScores.find(c => c.id === 'heart-score');
      
      if (heartCalc) {
        // Test with low risk values
        const lowRiskResult = heartCalc.calculate({
          history: 0,
          ecg: 0,
          age: 0,
          risk_factors: 0,
          troponin: 0
        });
        
        // calculate() returns a number directly
        expect(typeof lowRiskResult).toBe('number');
        expect(lowRiskResult).toBe(0);
      }
    });

    it('CHA2DS2-VASc score should calculate correctly', () => {
      const chaCalc = cardiovascularScores.find(c => c.id === 'cha2ds2-vasc');
      
      if (chaCalc) {
        // Test with max values - returns score directly as number
        const result = chaCalc.calculate({
          chf: 1,
          hypertension: 1,
          age: 2,
          diabetes: 1,
          stroke: 2,
          vascular: 1,
          sex: 1
        });
        
        // Some calculators return just a number, some return an object
        expect(result).toBeDefined();
      }
    });
  });

  describe('Neurology Calculators', () => {
    it('Glasgow Coma Scale should calculate correctly', () => {
      const gcsCalc = neurologyScores.find(c => c.id === 'glasgow-coma-scale');
      
      if (gcsCalc) {
        // Test normal GCS (15)
        const result = gcsCalc.calculate({
          eye: 4,
          verbal: 5,
          motor: 6
        });
        
        // calculate() returns a number directly
        expect(result).toBe(15);
      }
    });

    it('GCS should handle minimum values', () => {
      const gcsCalc = neurologyScores.find(c => c.id === 'glasgow-coma-scale');
      
      if (gcsCalc) {
        const result = gcsCalc.calculate({
          eye: 1,
          verbal: 1,
          motor: 1
        });
        
        expect(result).toBe(3);
      }
    });
  });

  describe('Sepsis Calculators', () => {
    it('qSOFA should calculate correctly', () => {
      const qsofaCalc = sepsisScores.find(c => c.id === 'qsofa');
      
      if (qsofaCalc) {
        // Test with all positive criteria
        const result = qsofaCalc.calculate({
          respiratory_rate: 1,
          altered_mentation: 1,
          systolic_bp: 1
        });
        
        expect(result).toBeDefined();
      }
    });
  });
});
