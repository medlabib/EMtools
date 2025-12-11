import 'package:flutter_test/flutter_test.dart';
import 'package:emtools/domain/entities/metabolic.dart';

void main() {
  group('MetabolicCalculator', () {
    group('Total Body Water (TBW)', () {
      test('calculates TBW for adult male', () {
        final tbw = MetabolicCalculator.calculateTBW(70, Sex.male, AgeGroup.adult);
        // TBW = 70 * 0.6 = 42
        expect(tbw, 42.0);
      });

      test('calculates TBW for adult female', () {
        final tbw = MetabolicCalculator.calculateTBW(60, Sex.female, AgeGroup.adult);
        // TBW = 60 * 0.5 = 30
        expect(tbw, 30.0);
      });

      test('calculates TBW for elderly male', () {
        final tbw = MetabolicCalculator.calculateTBW(70, Sex.male, AgeGroup.elderly);
        // TBW = 70 * 0.5 = 35
        expect(tbw, 35.0);
      });

      test('calculates TBW for elderly female', () {
        final tbw = MetabolicCalculator.calculateTBW(60, Sex.female, AgeGroup.elderly);
        // TBW = 60 * 0.45 = 27
        expect(tbw, 27.0);
      });

      test('calculates TBW for child', () {
        final tbw = MetabolicCalculator.calculateTBW(30, Sex.male, AgeGroup.child);
        // TBW = 30 * 0.6 = 18
        expect(tbw, 18.0);
      });
    });

    group('Free Water Deficit', () {
      test('calculates free water deficit for hypernatremia', () {
        // TBW = 42, Current Na = 160, Target Na = 140
        // FWD = 42 * ((160/140) - 1) = 42 * 0.143 = 6.0
        final fwd = MetabolicCalculator.calculateFreeWaterDeficit(42, 160, 140);
        expect(fwd, closeTo(6.0, 0.1));
      });

      test('returns negative for hyponatremia', () {
        final fwd = MetabolicCalculator.calculateFreeWaterDeficit(42, 120, 140);
        expect(fwd, lessThan(0));
      });
    });

    group('Sodium Deficit', () {
      test('calculates sodium deficit for hyponatremia', () {
        // TBW = 42, Current Na = 120, Target Na = 130
        // Na deficit = 42 * (130 - 120) = 420 mEq
        final deficit = MetabolicCalculator.calculateSodiumDeficit(42, 120, 130);
        expect(deficit, 420.0);
      });

      test('returns negative for hypernatremia', () {
        final deficit = MetabolicCalculator.calculateSodiumDeficit(42, 150, 140);
        expect(deficit, lessThan(0));
      });
    });

    group('Corrected Calcium', () {
      test('calculates corrected calcium for low albumin', () {
        // Corrected Ca = 8.0 + 0.8 * (4.0 - 2.0) = 8.0 + 1.6 = 9.6
        final corrected = MetabolicCalculator.calculateCorrectedCalcium(8.0, 2.0);
        expect(corrected, 9.6);
      });

      test('returns same value when albumin is normal', () {
        final corrected = MetabolicCalculator.calculateCorrectedCalcium(9.0, 4.0);
        expect(corrected, 9.0);
      });

      test('returns same value when albumin is high', () {
        final corrected = MetabolicCalculator.calculateCorrectedCalcium(9.0, 5.0);
        expect(corrected, 9.0);
      });
    });

    group('Dysnatremia Correction', () {
      test('detects unsafe correction rate for chronic hyponatremia', () {
        final params = DysnatremiaParams(
          weight: 70,
          sex: Sex.male,
          ageGroup: AgeGroup.adult,
          baselineNa: 115,
          targetNa: 135, // 20 mEq change in 24h - too fast!
          direction: SodiumDirection.hypo,
          mode: CorrectionMode.chronic,
          urineOutput: 1000,
          insensibleLoss: 800,
          fluidA: MetabolicCalculator.ivFluids[0], // D5W
          fluidB: MetabolicCalculator.ivFluids[4], // NS
        );
        
        final result = MetabolicCalculator.calculateDysnatremiaCorrection(params);
        expect(result.isUnsafe, true);
        expect(result.safetyWarning, contains('ODS'));
      });

      test('allows faster correction for acute hyponatremia', () {
        final params = DysnatremiaParams(
          weight: 70,
          sex: Sex.male,
          ageGroup: AgeGroup.adult,
          baselineNa: 120,
          targetNa: 128, // 8 mEq change
          direction: SodiumDirection.hypo,
          mode: CorrectionMode.acute,
          urineOutput: 1000,
          insensibleLoss: 800,
          fluidA: MetabolicCalculator.ivFluids[0],
          fluidB: MetabolicCalculator.ivFluids[4],
        );
        
        final result = MetabolicCalculator.calculateDysnatremiaCorrection(params);
        // 8/24 = 0.33 mEq/L/h, acute limit is 1.5, so should be safe
        expect(result.isUnsafe, false);
      });

      test('calculates fluid rates for hypernatremia', () {
        final params = DysnatremiaParams(
          weight: 70,
          sex: Sex.male,
          ageGroup: AgeGroup.adult,
          baselineNa: 160,
          targetNa: 150,
          direction: SodiumDirection.hyper,
          mode: CorrectionMode.chronic,
          urineOutput: 1000,
          insensibleLoss: 800,
          fluidA: MetabolicCalculator.ivFluids[0], // D5W (0 mEq/L)
          fluidB: MetabolicCalculator.ivFluids[4], // NS (154 mEq/L)
        );
        
        final result = MetabolicCalculator.calculateDysnatremiaCorrection(params);
        expect(result.fluidARate, greaterThan(0));
        expect(result.totalRate, greaterThan(0));
        expect(result.freeWaterDeficit, greaterThan(0));
      });

      test('returns correct TBW in results', () {
        final params = DysnatremiaParams(
          weight: 70,
          sex: Sex.male,
          ageGroup: AgeGroup.adult,
          baselineNa: 140,
          targetNa: 140,
          direction: SodiumDirection.hypo,
          mode: CorrectionMode.chronic,
          urineOutput: 1000,
          insensibleLoss: 800,
          fluidA: MetabolicCalculator.ivFluids[0],
          fluidB: MetabolicCalculator.ivFluids[4],
        );
        
        final result = MetabolicCalculator.calculateDysnatremiaCorrection(params);
        expect(result.tbw, 42.0); // 70 * 0.6
      });
    });

    group('IV Fluids Data', () {
      test('has correct D5W properties', () {
        final d5w = MetabolicCalculator.ivFluids.firstWhere((f) => f.id == 'd5w');
        expect(d5w.sodiumMeq, 0);
        expect(d5w.type, 'hypotonique');
      });

      test('has correct NS properties', () {
        final ns = MetabolicCalculator.ivFluids.firstWhere((f) => f.id == 'ns');
        expect(ns.sodiumMeq, 154);
        expect(ns.type, 'isotonique');
      });

      test('has correct 3% NaCl properties', () {
        final hypertonic = MetabolicCalculator.ivFluids.firstWhere((f) => f.id == 'nacl3');
        expect(hypertonic.sodiumMeq, 513);
        expect(hypertonic.type, 'hypertonique');
      });
    });

    group('Hyperkalemia ECG Findings', () {
      test('has peaked T waves at correct threshold', () {
        final peakedT = MetabolicCalculator.hyperkalemiaECG
            .firstWhere((f) => f.id == 'peaked_t');
        expect(peakedT.threshold, 5.5);
      });

      test('has sine wave at highest threshold', () {
        final sineWave = MetabolicCalculator.hyperkalemiaECG
            .firstWhere((f) => f.id == 'sine_wave');
        expect(sineWave.threshold, 8.0);
      });
    });

    group('Hyperkalemia Treatments', () {
      test('has calcium gluconate as first treatment', () {
        final calcium = MetabolicCalculator.hyperkalemiaTreatments
            .firstWhere((t) => t.id == 'calcium_gluconate');
        expect(calcium.mechanism, 'Cardioprotection');
        expect(calcium.urgency, 'immediate');
      });

      test('has insulin/glucose as shift therapy', () {
        final insulinGlucose = MetabolicCalculator.hyperkalemiaTreatments
            .firstWhere((t) => t.id == 'insulin_glucose');
        expect(insulinGlucose.mechanism, 'Transfert intracellulaire');
      });
    });
  });
}
