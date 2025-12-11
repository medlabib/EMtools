import 'package:flutter_test/flutter_test.dart';
import 'package:emtools/domain/entities/blood_gas.dart';

void main() {
  group('BloodGasCalculator', () {
    group('Predicted Body Weight (PBW)', () {
      test('calculates PBW correctly for male', () {
        final data = BloodGasPatientData(
          height: 175,
          gender: 'male',
        );
        final result = BloodGasCalculator.calculate(data);
        // PBW = 50 + 0.91 * (175 - 152.4) = 50 + 20.57 = 70.57
        expect(result.pbw, closeTo(70.57, 0.1));
      });

      test('calculates PBW correctly for female', () {
        final data = BloodGasPatientData(
          height: 165,
          gender: 'female',
        );
        final result = BloodGasCalculator.calculate(data);
        // PBW = 45.5 + 0.91 * (165 - 152.4) = 45.5 + 11.47 = 56.97
        expect(result.pbw, closeTo(56.97, 0.1));
      });

      test('handles height below reference', () {
        final data = BloodGasPatientData(
          height: 150, // Below 152.4
          gender: 'male',
        );
        final result = BloodGasCalculator.calculate(data);
        // PBW = 50 + 0.91 * max(0, 150 - 152.4) = 50
        expect(result.pbw, 50.0);
      });
    });

    group('Anion Gap Calculation', () {
      test('calculates uncorrected anion gap', () {
        final data = BloodGasPatientData(
          na: 140,
          cl: 100,
          hco3: 24,
        );
        final result = BloodGasCalculator.calculate(data);
        // AG = Na - (Cl + HCO3) = 140 - (100 + 24) = 16
        expect(result.agUncorrected, 16.0);
      });

      test('calculates albumin-corrected anion gap', () {
        final data = BloodGasPatientData(
          na: 140,
          cl: 100,
          hco3: 24,
          alb: 2.0, // Low albumin
        );
        final result = BloodGasCalculator.calculate(data);
        // AG = 16, Corrected AG = 16 + 2.5 * (4.0 - 2.0) = 16 + 5 = 21
        expect(result.agCorrected, 21.0);
      });

      test('corrected AG equals uncorrected when albumin is normal', () {
        final data = BloodGasPatientData(
          na: 140,
          cl: 100,
          hco3: 24,
          alb: 4.0, // Normal albumin
        );
        final result = BloodGasCalculator.calculate(data);
        expect(result.agCorrected, result.agUncorrected);
      });
    });

    group('Acid-Base Status Detection', () {
      test('detects normal pH', () {
        final data = BloodGasPatientData(
          ph: 7.40,
          paco2: 40,
          hco3: 24,
        );
        final result = BloodGasCalculator.calculate(data);
        expect(result.status, 'Normal');
      });

      test('detects metabolic acidosis', () {
        final data = BloodGasPatientData(
          ph: 7.25,
          paco2: 30, // Compensatory hyperventilation
          hco3: 14,
        );
        final result = BloodGasCalculator.calculate(data);
        expect(result.status, 'Acidose');
        expect(result.primary, 'Métabolique');
      });

      test('detects respiratory acidosis', () {
        final data = BloodGasPatientData(
          ph: 7.28,
          paco2: 60,
          hco3: 26,
        );
        final result = BloodGasCalculator.calculate(data);
        expect(result.status, 'Acidose');
        expect(result.primary, 'Respiratoire');
      });

      test('detects metabolic alkalosis', () {
        final data = BloodGasPatientData(
          ph: 7.52,
          paco2: 45,
          hco3: 34,
        );
        final result = BloodGasCalculator.calculate(data);
        expect(result.status, 'Alcalose');
        expect(result.primary, 'Métabolique');
      });

      test('detects respiratory alkalosis', () {
        final data = BloodGasPatientData(
          ph: 7.50,
          paco2: 28,
          hco3: 22,
        );
        final result = BloodGasCalculator.calculate(data);
        expect(result.status, 'Alcalose');
        expect(result.primary, 'Respiratoire');
      });
    });

    group('Winter\'s Formula Compensation', () {
      test('detects compensated metabolic acidosis', () {
        // Winter's: Expected PaCO2 = 1.5 * HCO3 + 8 = 1.5 * 14 + 8 = 29
        final data = BloodGasPatientData(
          ph: 7.25,
          paco2: 29,
          hco3: 14,
        );
        final result = BloodGasCalculator.calculate(data);
        expect(result.winterMsg, contains('Compensée'));
      });

      test('detects metabolic acidosis with respiratory acidosis', () {
        // Expected PaCO2 = 29, but actual is 45 (too high)
        final data = BloodGasPatientData(
          ph: 7.18,
          paco2: 45,
          hco3: 14,
        );
        final result = BloodGasCalculator.calculate(data);
        expect(result.winterMsg, contains('Acidose Resp'));
      });

      test('detects metabolic acidosis with respiratory alkalosis', () {
        // Expected PaCO2 = 29, but actual is 20 (too low)
        final data = BloodGasPatientData(
          ph: 7.32,
          paco2: 20,
          hco3: 14,
        );
        final result = BloodGasCalculator.calculate(data);
        expect(result.winterMsg, contains('Alcalose Resp'));
      });
    });

    group('Delta Ratio', () {
      test('calculates delta ratio correctly', () {
        final data = BloodGasPatientData(
          na: 140,
          cl: 100,
          hco3: 14, // Low
          alb: 4.0,
        );
        final result = BloodGasCalculator.calculate(data);
        // AG = 26, Corrected AG = 26
        // Delta Gap = 26 - 12 = 14
        // Delta Bicarb = 24 - 14 = 10
        // Delta Ratio = 14 / 10 = 1.4
        expect(result.deltaRatio, closeTo(1.4, 0.1));
      });
    });

    group('Oxygenation Assessment', () {
      test('calculates P/F ratio correctly', () {
        final data = BloodGasPatientData(
          pao2: 80,
          fio2: 0.4,
        );
        final result = BloodGasCalculator.calculate(data);
        // P/F = 80 / 0.4 = 200
        expect(result.pfRatio, 200.0);
      });

      test('classifies mild ARDS', () {
        final data = BloodGasPatientData(
          pao2: 250,
          fio2: 1.0,
        );
        final result = BloodGasCalculator.calculate(data);
        expect(result.ardsGrade, 'SDRA Léger');
      });

      test('classifies moderate ARDS', () {
        final data = BloodGasPatientData(
          pao2: 150,
          fio2: 1.0,
        );
        final result = BloodGasCalculator.calculate(data);
        expect(result.ardsGrade, 'SDRA Modéré');
      });

      test('classifies severe ARDS', () {
        final data = BloodGasPatientData(
          pao2: 80,
          fio2: 1.0,
        );
        final result = BloodGasCalculator.calculate(data);
        expect(result.ardsGrade, 'SDRA Sévère');
      });

      test('calculates A-a gradient', () {
        final data = BloodGasPatientData(
          pao2: 90,
          paco2: 40,
          fio2: 0.21,
          age: 40,
        );
        final result = BloodGasCalculator.calculate(data);
        // PAO2 = (760 - 47) * 0.21 - 40/0.8 = 149.73 - 50 = 99.73
        // A-a = 99.73 - 90 = 9.73
        expect(result.aaGradient, closeTo(9.73, 1.0));
      });

      test('calculates expected A-a gradient for age', () {
        final data = BloodGasPatientData(age: 40);
        final result = BloodGasCalculator.calculate(data);
        // Expected A-a = age/4 + 4 = 40/4 + 4 = 14
        expect(result.expectedAa, 14.0);
      });
    });

    group('Lactate Status', () {
      test('normal lactate', () {
        final data = BloodGasPatientData(lactate: 1.5);
        final result = BloodGasCalculator.calculate(data);
        expect(result.lactateStatus, 'Normal');
      });

      test('hyperlactatemia', () {
        final data = BloodGasPatientData(lactate: 3.0);
        final result = BloodGasCalculator.calculate(data);
        expect(result.lactateStatus, 'Hyperlactatémie');
      });

      test('shock/hypoperfusion', () {
        final data = BloodGasPatientData(lactate: 5.0);
        final result = BloodGasCalculator.calculate(data);
        expect(result.lactateStatus, 'Choc / Hypoperfusion');
      });
    });

    group('Ventilator Mechanics', () {
      test('calculates tidal volume per kg', () {
        final data = BloodGasPatientData(
          vt: 500,
          height: 175,
          gender: 'male',
        );
        final result = BloodGasCalculator.calculate(data);
        // PBW ≈ 70.57, Vt/kg = 500/70.57 ≈ 7.09
        expect(result.vtPerKg, closeTo(7.09, 0.1));
      });

      test('calculates driving pressure', () {
        final data = BloodGasPatientData(
          pplat: 25,
          peep: 8,
        );
        final result = BloodGasCalculator.calculate(data);
        // DP = Pplat - PEEP = 25 - 8 = 17
        expect(result.drivingPressure, 17.0);
      });

      test('calculates compliance', () {
        final data = BloodGasPatientData(
          vt: 500,
          pplat: 25,
          peep: 10,
        );
        final result = BloodGasCalculator.calculate(data);
        // Compliance = Vt / (Pplat - PEEP) = 500 / 15 ≈ 33.3
        expect(result.compliance, closeTo(33.3, 0.1));
      });

      test('calculates RSBI', () {
        final data = BloodGasPatientData(
          rr: 30,
          vt: 300,
        );
        final result = BloodGasCalculator.calculate(data);
        // RSBI = RR / (Vt in L) = 30 / 0.3 = 100
        expect(result.rsbi, 100.0);
      });

      test('calculates resistive gradient', () {
        final data = BloodGasPatientData(
          ppeak: 35,
          pplat: 25,
        );
        final result = BloodGasCalculator.calculate(data);
        // Resistive gradient = Ppeak - Pplat = 35 - 25 = 10
        expect(result.resistiveGradient, 10.0);
      });
    });

    group('Oxygen Content (CaO2)', () {
      test('calculates arterial oxygen content', () {
        final data = BloodGasPatientData(
          hb: 15,
          sao2: 98,
          pao2: 100,
        );
        final result = BloodGasCalculator.calculate(data);
        // CaO2 = (1.34 * Hb * SaO2/100) + (0.003 * PaO2)
        // CaO2 = (1.34 * 15 * 0.98) + (0.003 * 100) = 19.7 + 0.3 = 20.0
        expect(result.cao2, closeTo(20.0, 0.1));
      });
    });
  });
}
