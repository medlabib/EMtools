import { describe, it, expect } from 'vitest';
import {
  NORMALS,
  defaultPatientData,
  calculatePBW,
  calculateAnionGap,
  calculateDeltaRatio,
  determineAcidBaseStatus,
  calculateOxygenation,
  calculateCaO2,
  calculateAaGradient,
  calculateMechanics,
  getLactateStatus,
  calculateAll
} from '../../src/lib/pages/tools/bloodgas/bloodgas';

describe('Blood Gas & Ventilation Calculator', () => {
  describe('NORMALS constants', () => {
    it('should have correct normal values', () => {
      expect(NORMALS.ph).toBe(7.40);
      expect(NORMALS.paco2).toBe(40);
      expect(NORMALS.hco3).toBe(24);
      expect(NORMALS.ag).toBe(12);
      expect(NORMALS.alb).toBe(4.0);
      expect(NORMALS.patm).toBe(760);
      expect(NORMALS.ph2o).toBe(47);
    });
  });

  describe('defaultPatientData', () => {
    it('should have all required fields', () => {
      expect(defaultPatientData).toHaveProperty('ph');
      expect(defaultPatientData).toHaveProperty('paco2');
      expect(defaultPatientData).toHaveProperty('pao2');
      expect(defaultPatientData).toHaveProperty('hco3');
      expect(defaultPatientData).toHaveProperty('sao2');
      expect(defaultPatientData).toHaveProperty('lactate');
      expect(defaultPatientData).toHaveProperty('hb');
      expect(defaultPatientData).toHaveProperty('na');
      expect(defaultPatientData).toHaveProperty('cl');
      expect(defaultPatientData).toHaveProperty('alb');
      expect(defaultPatientData).toHaveProperty('temp');
      expect(defaultPatientData).toHaveProperty('fio2');
      expect(defaultPatientData).toHaveProperty('vt');
      expect(defaultPatientData).toHaveProperty('rr');
      expect(defaultPatientData).toHaveProperty('peep');
      expect(defaultPatientData).toHaveProperty('pplat');
      expect(defaultPatientData).toHaveProperty('ppeak');
      expect(defaultPatientData).toHaveProperty('height');
      expect(defaultPatientData).toHaveProperty('gender');
      expect(defaultPatientData).toHaveProperty('age');
    });
  });

  describe('calculatePBW', () => {
    it('should calculate PBW for male correctly', () => {
      // 175 cm male: 50 + 0.91 * (175 - 152.4) = 50 + 20.57 = 70.57
      const pbw = calculatePBW(175, 'male');
      expect(pbw).toBeCloseTo(70.57, 1);
    });

    it('should calculate PBW for female correctly', () => {
      // 165 cm female: 45.5 + 0.91 * (165 - 152.4) = 45.5 + 11.47 = 56.97
      const pbw = calculatePBW(165, 'female');
      expect(pbw).toBeCloseTo(56.97, 1);
    });

    it('should handle short height (below 152.4 cm)', () => {
      const pbw = calculatePBW(150, 'male');
      expect(pbw).toBe(50); // No negative contribution
    });

    it('should handle very tall patients', () => {
      const pbw = calculatePBW(200, 'male');
      // 50 + 0.91 * (200 - 152.4) = 50 + 43.32 = 93.32
      expect(pbw).toBeCloseTo(93.32, 1);
    });
  });

  describe('calculateAnionGap', () => {
    it('should calculate uncorrected anion gap correctly', () => {
      // AG = Na - (Cl + HCO3) = 140 - (100 + 24) = 16
      const { uncorrected } = calculateAnionGap(140, 100, 24, 4.0);
      expect(uncorrected).toBe(16);
    });

    it('should calculate corrected anion gap for hypoalbuminemia', () => {
      // Correction: AG + 2.5 * (4 - alb)
      // With alb = 2.5: 16 + 2.5 * (4 - 2.5) = 16 + 3.75 = 19.75
      const { corrected } = calculateAnionGap(140, 100, 24, 2.5);
      expect(corrected).toBeCloseTo(19.75, 1);
    });

    it('should not change correction for normal albumin', () => {
      const { uncorrected, corrected } = calculateAnionGap(140, 100, 24, 4.0);
      expect(uncorrected).toBe(corrected);
    });

    it('should handle high anion gap acidosis', () => {
      // Severe metabolic acidosis: low HCO3
      const { uncorrected } = calculateAnionGap(140, 100, 10, 4.0);
      // AG = 140 - (100 + 10) = 30
      expect(uncorrected).toBe(30);
    });
  });

  describe('calculateDeltaRatio', () => {
    it('should calculate delta ratio for pure high AG acidosis', () => {
      // Delta ratio ~1-2 for pure HAGMA
      // AG corrected = 24, HCO3 = 14
      // Delta gap = 24 - 12 = 12
      // Delta bicarb = 24 - 14 = 10
      // Delta ratio = 12/10 = 1.2
      const ratio = calculateDeltaRatio(24, 14);
      expect(ratio).toBeCloseTo(1.2, 1);
    });

    it('should return 0 when delta bicarb is 0', () => {
      const ratio = calculateDeltaRatio(12, 24);
      expect(ratio).toBe(0);
    });

    it('should detect mixed acidosis (ratio < 1)', () => {
      // Mixed HAGMA + NAGMA: ratio < 1
      const ratio = calculateDeltaRatio(18, 10);
      // Delta gap = 18 - 12 = 6
      // Delta bicarb = 24 - 10 = 14
      // Ratio = 6/14 = 0.43
      expect(ratio).toBeLessThan(1);
    });

    it('should detect concurrent metabolic alkalosis (ratio > 2)', () => {
      // HAGMA + metabolic alkalosis: ratio > 2
      const ratio = calculateDeltaRatio(30, 20);
      // Delta gap = 30 - 12 = 18
      // Delta bicarb = 24 - 20 = 4
      // Ratio = 18/4 = 4.5
      expect(ratio).toBeGreaterThan(2);
    });
  });

  describe('determineAcidBaseStatus', () => {
    it('should detect normal pH', () => {
      const { status } = determineAcidBaseStatus(7.40, 40, 24);
      expect(status).toBe('Normal');
    });

    it('should detect metabolic acidosis', () => {
      const { status, primary } = determineAcidBaseStatus(7.30, 30, 14);
      expect(status).toBe('Acidose');
      expect(primary).toBe('Métabolique');
    });

    it('should detect respiratory acidosis', () => {
      const { status, primary } = determineAcidBaseStatus(7.30, 55, 26);
      expect(status).toBe('Acidose');
      expect(primary).toBe('Respiratoire');
    });

    it('should detect metabolic alkalosis', () => {
      const { status, primary } = determineAcidBaseStatus(7.50, 42, 32);
      expect(status).toBe('Alcalose');
      expect(primary).toBe('Métabolique');
    });

    it('should detect respiratory alkalosis', () => {
      const { status, primary } = determineAcidBaseStatus(7.50, 28, 22);
      expect(status).toBe('Alcalose');
      expect(primary).toBe('Respiratoire');
    });

    it('should calculate Winter formula for metabolic acidosis', () => {
      // HCO3 = 14: Expected PaCO2 = 1.5 * 14 + 8 = 29
      // If actual PaCO2 = 30 (within ±2), it's compensated
      const { winter_msg } = determineAcidBaseStatus(7.25, 30, 14);
      expect(winter_msg).toBe('Compensée (Pure)');
    });

    it('should detect superimposed respiratory alkalosis', () => {
      // HCO3 = 14: Expected PaCO2 = 29
      // If actual PaCO2 = 20 (< 27), there's additional resp alkalosis
      const { winter_msg } = determineAcidBaseStatus(7.30, 20, 14);
      expect(winter_msg).toBe('+ Alcalose Resp.');
    });

    it('should detect superimposed respiratory acidosis', () => {
      // HCO3 = 14: Expected PaCO2 = 29
      // If actual PaCO2 = 40 (> 31), there's additional resp acidosis
      const { winter_msg } = determineAcidBaseStatus(7.20, 40, 14);
      expect(winter_msg).toBe('+ Acidose Resp.');
    });
  });

  describe('calculateOxygenation', () => {
    it('should calculate P/F ratio correctly', () => {
      // PaO2 = 100, FiO2 = 0.21 -> P/F = 476
      const { pf_ratio } = calculateOxygenation(100, 0.21);
      expect(pf_ratio).toBeCloseTo(476, 0);
    });

    it('should grade normal oxygenation', () => {
      const { ards_grade } = calculateOxygenation(100, 0.21);
      expect(ards_grade).toBe('Normal');
    });

    it('should grade mild ARDS (P/F 200-300)', () => {
      // P/F = 250: PaO2 = 125, FiO2 = 0.5
      const { ards_grade } = calculateOxygenation(125, 0.5);
      expect(ards_grade).toBe('SDRA Léger');
    });

    it('should grade moderate ARDS (P/F 100-200)', () => {
      // P/F = 150: PaO2 = 75, FiO2 = 0.5
      const { ards_grade } = calculateOxygenation(75, 0.5);
      expect(ards_grade).toBe('SDRA Modéré');
    });

    it('should grade severe ARDS (P/F < 100)', () => {
      // P/F = 80: PaO2 = 80, FiO2 = 1.0
      const { ards_grade } = calculateOxygenation(80, 1.0);
      expect(ards_grade).toBe('SDRA Sévère');
    });
  });

  describe('calculateCaO2', () => {
    it('should calculate arterial oxygen content correctly', () => {
      // CaO2 = (1.34 × Hb × SaO2/100) + (0.003 × PaO2)
      // Hb=14, SaO2=98, PaO2=90
      // CaO2 = (1.34 × 14 × 0.98) + (0.003 × 90) = 18.38 + 0.27 = 18.65
      const cao2 = calculateCaO2(14, 98, 90);
      expect(cao2).toBeCloseTo(18.65, 1);
    });

    it('should show low CaO2 with severe anemia', () => {
      // Hb=5, SaO2=100, PaO2=100
      // CaO2 = (1.34 × 5 × 1.0) + (0.003 × 100) = 6.7 + 0.3 = 7.0
      const cao2 = calculateCaO2(5, 100, 100);
      expect(cao2).toBeLessThan(12); // Critical threshold
    });

    it('should calculate normal CaO2', () => {
      // Normal: Hb=15, SaO2=97, PaO2=95
      const cao2 = calculateCaO2(15, 97, 95);
      expect(cao2).toBeGreaterThan(16); // Normal is 16-22
    });
  });

  describe('calculateAaGradient', () => {
    it('should calculate A-a gradient correctly', () => {
      // PAO2 = (Patm - PH2O) × FiO2 - PaCO2/0.8
      // = (760 - 47) × 0.21 - 40/0.8 = 149.73 - 50 = 99.73
      // A-a gradient = PAO2 - PaO2 = 99.73 - 90 = 9.73
      const { aa_gradient } = calculateAaGradient(0.21, 40, 90, 40);
      expect(aa_gradient).toBeCloseTo(9.73, 0);
    });

    it('should calculate expected A-a gradient by age', () => {
      // Expected = Age/4 + 4
      // Age 40: 10 + 4 = 14
      const { expected_aa } = calculateAaGradient(0.21, 40, 90, 40);
      expect(expected_aa).toBe(14);
    });

    it('should detect increased A-a gradient', () => {
      // On high FiO2, A-a gradient increases
      const { aa_gradient, expected_aa } = calculateAaGradient(0.6, 40, 80, 60);
      expect(aa_gradient).toBeGreaterThan(expected_aa);
    });
  });

  describe('calculateMechanics', () => {
    it('should calculate Vt/kg correctly', () => {
      // Vt=420ml, PBW=70kg -> 6 ml/kg (protective)
      const { vt_per_kg } = calculateMechanics(420, 70, 25, 10, 30, 16);
      expect(vt_per_kg).toBe(6);
    });

    it('should calculate driving pressure correctly', () => {
      // Driving pressure = Pplat - PEEP = 25 - 10 = 15
      const { driving_pressure } = calculateMechanics(420, 70, 25, 10, 30, 16);
      expect(driving_pressure).toBe(15);
    });

    it('should calculate compliance correctly', () => {
      // Compliance = Vt / (Pplat - PEEP) = 420 / 15 = 28
      const { compliance } = calculateMechanics(420, 70, 25, 10, 30, 16);
      expect(compliance).toBe(28);
    });

    it('should calculate RSBI correctly', () => {
      // RSBI = RR / (Vt in L) = 16 / 0.42 = 38
      const { rsbi } = calculateMechanics(420, 70, 25, 10, 30, 16);
      expect(rsbi).toBeCloseTo(38.1, 0);
    });

    it('should calculate resistive gradient correctly', () => {
      // Resistive gradient = Ppeak - Pplat = 30 - 25 = 5
      const { resistive_gradient } = calculateMechanics(420, 70, 25, 10, 30, 16);
      expect(resistive_gradient).toBe(5);
    });

    it('should handle zero driving pressure', () => {
      // When Pplat = PEEP, compliance would be division by zero
      const { compliance } = calculateMechanics(420, 70, 10, 10, 30, 16);
      expect(compliance).toBe(0);
    });

    it('should detect high Vt/kg (non-protective)', () => {
      // Vt=560ml, PBW=70kg -> 8 ml/kg (too high)
      const { vt_per_kg } = calculateMechanics(560, 70, 25, 10, 30, 16);
      expect(vt_per_kg).toBe(8);
      expect(vt_per_kg).toBeGreaterThan(6);
    });

    it('should detect high driving pressure', () => {
      // Pplat=35, PEEP=5 -> Driving pressure = 30 (dangerous)
      const { driving_pressure } = calculateMechanics(420, 70, 35, 5, 40, 16);
      expect(driving_pressure).toBe(30);
      expect(driving_pressure).toBeGreaterThan(15);
    });
  });

  describe('getLactateStatus', () => {
    it('should return Normal for lactate < 2', () => {
      expect(getLactateStatus(1.5)).toBe('Normal');
      expect(getLactateStatus(0.5)).toBe('Normal');
    });

    it('should return Hyperlactatémie for lactate 2-4', () => {
      expect(getLactateStatus(2.0)).toBe('Hyperlactatémie');
      expect(getLactateStatus(3.5)).toBe('Hyperlactatémie');
    });

    it('should return Choc / Hypoperfusion for lactate >= 4', () => {
      expect(getLactateStatus(4.0)).toBe('Choc / Hypoperfusion');
      expect(getLactateStatus(10.0)).toBe('Choc / Hypoperfusion');
    });
  });

  describe('calculateAll', () => {
    it('should calculate all results from default patient data', () => {
      const results = calculateAll(defaultPatientData);
      
      expect(results).toHaveProperty('pbw');
      expect(results).toHaveProperty('ag_uncorrected');
      expect(results).toHaveProperty('ag_corrected');
      expect(results).toHaveProperty('delta_ratio');
      expect(results).toHaveProperty('status');
      expect(results).toHaveProperty('primary');
      expect(results).toHaveProperty('winter_msg');
      expect(results).toHaveProperty('pf_ratio');
      expect(results).toHaveProperty('ards_grade');
      expect(results).toHaveProperty('cao2');
      expect(results).toHaveProperty('aa_gradient');
      expect(results).toHaveProperty('expected_aa');
      expect(results).toHaveProperty('vt_per_kg');
      expect(results).toHaveProperty('lactate_status');
      expect(results).toHaveProperty('driving_pressure');
      expect(results).toHaveProperty('compliance');
      expect(results).toHaveProperty('rsbi');
      expect(results).toHaveProperty('resistive_gradient');
    });

    it('should identify metabolic acidosis with shock in default patient', () => {
      const results = calculateAll(defaultPatientData);
      
      // Default patient has pH 7.25, HCO3 14 -> metabolic acidosis
      expect(results.status).toBe('Acidose');
      expect(results.primary).toBe('Métabolique');
      
      // Lactate 4.5 -> shock
      expect(results.lactate_status).toBe('Choc / Hypoperfusion');
    });

    it('should calculate correct PBW for default male patient', () => {
      const results = calculateAll(defaultPatientData);
      // Male, 175cm: 50 + 0.91 * (175 - 152.4) = 70.57
      expect(results.pbw).toBeCloseTo(70.57, 1);
    });

    it('should calculate P/F ratio for default patient', () => {
      const results = calculateAll(defaultPatientData);
      // PaO2 75, FiO2 0.5 -> P/F = 150
      expect(results.pf_ratio).toBe(150);
      expect(results.ards_grade).toBe('SDRA Modéré');
    });

    it('should detect high driving pressure in default patient', () => {
      const results = calculateAll(defaultPatientData);
      // Pplat 26, PEEP 8 -> Driving pressure = 18
      expect(results.driving_pressure).toBe(18);
      expect(results.driving_pressure).toBeGreaterThan(15);
    });

    it('should detect elevated resistive gradient in default patient', () => {
      const results = calculateAll(defaultPatientData);
      // Ppeak 35, Pplat 26 -> Resistive gradient = 9
      expect(results.resistive_gradient).toBe(9);
      expect(results.resistive_gradient).toBeGreaterThan(5);
    });
  });

  describe('Clinical scenarios', () => {
    it('should correctly analyze severe septic shock patient', () => {
      const septicPatient = {
        ...defaultPatientData,
        ph: 7.15,
        paco2: 25,
        pao2: 60,
        hco3: 10,
        sao2: 88,
        lactate: 8.0,
        hb: 7.0,
        fio2: 0.8
      };
      
      const results = calculateAll(septicPatient);
      
      expect(results.status).toBe('Acidose');
      expect(results.primary).toBe('Métabolique');
      expect(results.lactate_status).toBe('Choc / Hypoperfusion');
      expect(results.pf_ratio).toBe(75); // Severe ARDS
      expect(results.ards_grade).toBe('SDRA Sévère');
      expect(results.cao2).toBeLessThan(10); // Critical anemia + hypoxia
    });

    it('should correctly analyze COPD exacerbation patient', () => {
      const copdPatient = {
        ...defaultPatientData,
        ph: 7.28,
        paco2: 70,
        pao2: 55,
        hco3: 32,
        sao2: 86,
        lactate: 1.2,
        hb: 16.0,
        fio2: 0.28,
        ppeak: 45,
        pplat: 28
      };
      
      const results = calculateAll(copdPatient);
      
      expect(results.status).toBe('Acidose');
      expect(results.primary).toBe('Respiratoire');
      expect(results.lactate_status).toBe('Normal');
      expect(results.resistive_gradient).toBe(17); // High resistance (COPD)
      expect(results.resistive_gradient).toBeGreaterThan(5);
    });

    it('should correctly analyze DKA patient', () => {
      const dkaPatient = {
        ...defaultPatientData,
        ph: 7.10,
        paco2: 15,
        pao2: 110,
        hco3: 5,
        sao2: 98,
        lactate: 2.5,
        na: 132,
        cl: 95,
        alb: 4.0,
        fio2: 0.21
      };
      
      const results = calculateAll(dkaPatient);
      
      expect(results.status).toBe('Acidose');
      expect(results.primary).toBe('Métabolique');
      expect(results.ag_uncorrected).toBe(32); // Very high AG (ketones)
      expect(results.pf_ratio).toBeGreaterThan(400); // Normal oxygenation
    });

    it('should correctly analyze post-cardiac arrest patient', () => {
      const postArrestPatient = {
        ...defaultPatientData,
        ph: 6.95,
        paco2: 60,
        pao2: 300,
        hco3: 8,
        sao2: 100,
        lactate: 15.0,
        hb: 12.0,
        fio2: 1.0,
        vt: 500,
        peep: 10,
        pplat: 28,
        ppeak: 32
      };
      
      const results = calculateAll(postArrestPatient);
      
      expect(results.status).toBe('Acidose');
      expect(results.lactate_status).toBe('Choc / Hypoperfusion');
      expect(results.pf_ratio).toBe(300); // Good despite high FiO2
      expect(results.cao2).toBeGreaterThan(14); // Good O2 content with high FiO2
    });
  });
});
