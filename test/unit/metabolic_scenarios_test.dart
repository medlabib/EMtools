import 'package:flutter_test/flutter_test.dart';
import 'package:emtools/domain/entities/metabolic.dart';

/// Clinical scenario-based tests for metabolic calculations
/// These tests simulate real patient cases to validate the formulas
/// References: SRLF, Adrogue-Madias, UpToDate

void main() {
  group('Clinical Scenarios - Metabolic Calculations', () {
    
    group('Total Body Water (TBW) Calculations', () {
      // Watson formula validation
      
      test('Adult male TBW (60%)', () {
        final tbw = MetabolicCalculator.calculateTBW(70, Sex.male, AgeGroup.adult);
        // TBW = 70 * 0.6 = 42 L
        expect(tbw, 42.0);
      });

      test('Adult female TBW (50%)', () {
        final tbw = MetabolicCalculator.calculateTBW(60, Sex.female, AgeGroup.adult);
        // TBW = 60 * 0.5 = 30 L
        expect(tbw, 30.0);
      });

      test('Elderly male TBW (50%)', () {
        final tbw = MetabolicCalculator.calculateTBW(70, Sex.male, AgeGroup.elderly);
        // TBW = 70 * 0.5 = 35 L
        expect(tbw, 35.0);
      });

      test('Elderly female TBW (45%)', () {
        final tbw = MetabolicCalculator.calculateTBW(60, Sex.female, AgeGroup.elderly);
        // TBW = 60 * 0.45 = 27 L
        expect(tbw, 27.0);
      });

      test('Child TBW (60%)', () {
        final tbw = MetabolicCalculator.calculateTBW(30, Sex.male, AgeGroup.child);
        // TBW = 30 * 0.6 = 18 L
        expect(tbw, 18.0);
      });
    });

    group('Corrected Calcium Calculations', () {
      // Formula: Corrected Ca = Ca + 0.8 * (4.0 - Albumin)
      
      test('Normal albumin - no correction needed', () {
        final correctedCa = MetabolicCalculator.calculateCorrectedCalcium(8.5, 4.0);
        expect(correctedCa, 8.5);
      });

      test('Low albumin (hypoalbuminemia) - calcium appears falsely low', () {
        // Patient with nephrotic syndrome, albumin 2.0 g/dL
        final correctedCa = MetabolicCalculator.calculateCorrectedCalcium(7.5, 2.0);
        // Corrected = 7.5 + 0.8 * (4.0 - 2.0) = 7.5 + 1.6 = 9.1
        expect(correctedCa, closeTo(9.1, 0.01));
      });

      test('Severe hypoalbuminemia (cirrhosis)', () {
        // Cirrhotic patient with albumin 1.5 g/dL
        final correctedCa = MetabolicCalculator.calculateCorrectedCalcium(6.8, 1.5);
        // Corrected = 6.8 + 0.8 * (4.0 - 1.5) = 6.8 + 2.0 = 8.8
        expect(correctedCa, closeTo(8.8, 0.01));
      });

      test('Critical hypocalcemia even after correction', () {
        // Truly hypocalcemic patient
        final correctedCa = MetabolicCalculator.calculateCorrectedCalcium(5.5, 2.5);
        // Corrected = 5.5 + 0.8 * (4.0 - 2.5) = 5.5 + 1.2 = 6.7 (still low!)
        expect(correctedCa, closeTo(6.7, 0.01));
      });

      test('High albumin - correction should not increase calcium', () {
        // Dehydration causing hemoconcentration
        final correctedCa = MetabolicCalculator.calculateCorrectedCalcium(10.5, 5.0);
        // Should return same value (albumin >= 4.0)
        expect(correctedCa, 10.5);
      });
    });

    group('Free Water Deficit (Hypernatremia)', () {
      // Formula: FWD = TBW * ((Na/140) - 1) or TBW * ((Na/target) - 1)
      
      test('Severe hypernatremia in elderly dehydrated patient', () {
        // 70 kg elderly male, Na 160 mEq/L
        final tbw = MetabolicCalculator.calculateTBW(70, Sex.male, AgeGroup.elderly);
        final fwd = MetabolicCalculator.calculateFreeWaterDeficit(tbw, 160, 140);
        // TBW = 35 L
        // FWD = 35 * (160/140 - 1) = 35 * 0.143 = 5.0 L
        expect(tbw, 35.0);
        expect(fwd, closeTo(5.0, 0.1));
      });

      test('Moderate hypernatremia in adult female', () {
        // 60 kg adult female, Na 155 mEq/L
        final tbw = MetabolicCalculator.calculateTBW(60, Sex.female, AgeGroup.adult);
        final fwd = MetabolicCalculator.calculateFreeWaterDeficit(tbw, 155, 140);
        // TBW = 30 L
        // FWD = 30 * (155/140 - 1) = 30 * 0.107 = 3.2 L
        expect(tbw, 30.0);
        expect(fwd, closeTo(3.2, 0.1));
      });

      test('Diabetes insipidus - severe hypernatremia', () {
        // 80 kg adult male with central DI, Na 170 mEq/L
        final tbw = MetabolicCalculator.calculateTBW(80, Sex.male, AgeGroup.adult);
        final fwd = MetabolicCalculator.calculateFreeWaterDeficit(tbw, 170, 140);
        // TBW = 48 L
        // FWD = 48 * (170/140 - 1) = 48 * 0.214 = 10.3 L
        expect(tbw, 48.0);
        expect(fwd, closeTo(10.3, 0.1));
      });
    });

    group('Sodium Deficit (Hyponatremia)', () {
      // Formula: Na Deficit = TBW * (Target Na - Current Na)
      
      test('Symptomatic hyponatremia requiring 3% saline', () {
        // 70 kg adult male with seizures, Na 115 mEq/L
        final tbw = MetabolicCalculator.calculateTBW(70, Sex.male, AgeGroup.adult);
        final deficit = MetabolicCalculator.calculateSodiumDeficit(tbw, 115, 120); // Target 5 mEq/L raise
        // TBW = 42 L
        // Deficit = 42 * (120 - 115) = 42 * 5 = 210 mEq
        expect(tbw, 42.0);
        expect(deficit, closeTo(210.0, 0.1));
      });

      test('Beer potomania - severe hyponatremia', () {
        // 65 kg elderly female, Na 108 mEq/L
        final tbw = MetabolicCalculator.calculateTBW(65, Sex.female, AgeGroup.elderly);
        final deficit = MetabolicCalculator.calculateSodiumDeficit(tbw, 108, 120);
        // TBW = 29.25 L
        // Deficit = 29.25 * (120 - 108) = 29.25 * 12 = 351 mEq
        expect(tbw, closeTo(29.25, 0.01));
        expect(deficit, closeTo(351, 1));
      });
    });

    group('Dysnatremia Correction Safety', () {
      
      test('Chronic hyponatremia - safe correction rate', () {
        final params = DysnatremiaParams(
          weight: 70,
          sex: Sex.male,
          ageGroup: AgeGroup.adult,
          baselineNa: 118,
          targetNa: 125, // 7 mEq/L in 24h = clearly safe (<8)
          direction: SodiumDirection.hypo,
          mode: CorrectionMode.chronic,
          urineOutput: 1500,
          insensibleLoss: 800,
          fluidA: MetabolicCalculator.ivFluids[5], // 3% NaCl
          fluidB: MetabolicCalculator.ivFluids[4], // NS
        );
        final result = MetabolicCalculator.calculateDysnatremiaCorrection(params);
        
        // Delta = 7 mEq/L, Rate = 7/24 = 0.29 mEq/L/h (safe, <0.33)
        expect(result.deltaNa, 7.0);
        expect(result.ratePerHour, closeTo(0.29, 0.01));
        expect(result.isUnsafe, false);
      });

      test('Chronic hyponatremia - UNSAFE correction rate (ODS risk)', () {
        final params = DysnatremiaParams(
          weight: 70,
          sex: Sex.male,
          ageGroup: AgeGroup.adult,
          baselineNa: 110,
          targetNa: 125, // 15 mEq/L in 24h = DANGEROUS
          direction: SodiumDirection.hypo,
          mode: CorrectionMode.chronic,
          urineOutput: 1500,
          insensibleLoss: 800,
          fluidA: MetabolicCalculator.ivFluids[5], // 3% NaCl
          fluidB: MetabolicCalculator.ivFluids[4], // NS
        );
        final result = MetabolicCalculator.calculateDysnatremiaCorrection(params);
        
        // Delta = 15 mEq/L, Rate = 15/24 = 0.625 mEq/L/h > 0.33 (8/24)
        expect(result.deltaNa, 15.0);
        expect(result.isUnsafe, true);
        expect(result.safetyWarning.fr.toLowerCase(), contains('ods'));
      });

      test('Acute symptomatic hyponatremia - higher rate allowed', () {
        final params = DysnatremiaParams(
          weight: 70,
          sex: Sex.male,
          ageGroup: AgeGroup.adult,
          baselineNa: 115,
          targetNa: 120, // Emergent 5 mEq/L raise
          direction: SodiumDirection.hypo,
          mode: CorrectionMode.acute,
          urineOutput: 1500,
          insensibleLoss: 800,
          fluidA: MetabolicCalculator.ivFluids[5], // 3% NaCl
          fluidB: MetabolicCalculator.ivFluids[4], // NS
        );
        final result = MetabolicCalculator.calculateDysnatremiaCorrection(params);
        
        // Acute allows faster correction initially
        expect(result.deltaNa, 5.0);
        // Rate = 5/24 = 0.21 mEq/L/h (well within acute limit of 1.5)
        expect(result.isUnsafe, false);
      });

      test('Chronic hypernatremia - safe correction', () {
        final params = DysnatremiaParams(
          weight: 70,
          sex: Sex.male,
          ageGroup: AgeGroup.elderly,
          baselineNa: 158,
          targetNa: 148, // 10 mEq/L drop in 24h
          direction: SodiumDirection.hyper,
          mode: CorrectionMode.chronic,
          urineOutput: 1000,
          insensibleLoss: 800,
          fluidA: MetabolicCalculator.ivFluids[0], // D5W
          fluidB: MetabolicCalculator.ivFluids[4], // NS
        );
        final result = MetabolicCalculator.calculateDysnatremiaCorrection(params);
        
        // Delta = -10 mEq/L, Rate = -10/24 = -0.42 mEq/L/h
        // Max rate for chronic hypernatremia is 0.5 mEq/L/h
        expect(result.deltaNa, -10.0);
        expect(result.ratePerHour.abs(), closeTo(0.42, 0.01));
        expect(result.isUnsafe, false);
      });

      test('Chronic hypernatremia - UNSAFE (cerebral edema risk)', () {
        final params = DysnatremiaParams(
          weight: 70,
          sex: Sex.male,
          ageGroup: AgeGroup.elderly,
          baselineNa: 170,
          targetNa: 145, // 25 mEq/L drop in 24h = TOO FAST
          direction: SodiumDirection.hyper,
          mode: CorrectionMode.chronic,
          urineOutput: 1000,
          insensibleLoss: 800,
          fluidA: MetabolicCalculator.ivFluids[0], // D5W
          fluidB: MetabolicCalculator.ivFluids[4], // NS
        );
        final result = MetabolicCalculator.calculateDysnatremiaCorrection(params);
        
        // Rate = 25/24 = 1.04 mEq/L/h > 0.5 limit
        expect(result.deltaNa, -25.0);
        expect(result.isUnsafe, true);
        expect(result.safetyWarning.fr.toLowerCase(), contains('œdème cérébral'));
      });
    });

    group('IV Fluids Properties', () {
      
      test('D5W is hypotonic with 0 sodium', () {
        final d5w = MetabolicCalculator.ivFluids.firstWhere((f) => f.id == 'd5w');
        expect(d5w.sodiumMeq, 0);
        expect(d5w.type, 'hypotonique');
      });

      test('Normal saline (NS) is isotonic with 154 mEq/L', () {
        final ns = MetabolicCalculator.ivFluids.firstWhere((f) => f.id == 'ns');
        expect(ns.sodiumMeq, 154);
        expect(ns.type, 'isotonique');
      });

      test('3% NaCl is hypertonic with 513 mEq/L', () {
        final hs = MetabolicCalculator.ivFluids.firstWhere((f) => f.id == 'nacl3');
        expect(hs.sodiumMeq, 513);
        expect(hs.type, 'hypertonique');
      });

      test('Lactated Ringer has potassium', () {
        final lr = MetabolicCalculator.ivFluids.firstWhere((f) => f.id == 'lr');
        expect(lr.sodiumMeq, 130);
        expect(lr.potassiumMeq, 4);
      });
    });

    group('Hyperkalemia Treatment Validation', () {
      
      test('Calcium gluconate is first line for ECG changes', () {
        final treatment = MetabolicCalculator.hyperkalemiaTreatments
            .firstWhere((t) => t.id == 'calcium_gluconate');
        expect(treatment.urgency, 'immediate');
        expect(treatment.mechanism.fr, 'Cardioprotection');
      });

      test('Insulin-glucose is the most effective shift therapy', () {
        final treatment = MetabolicCalculator.hyperkalemiaTreatments
            .firstWhere((t) => t.id == 'insulin_glucose');
        expect(treatment.urgency, 'urgent');
        expect(treatment.mechanism.fr, 'Transfert intracellulaire');
      });

      test('Hyperkalemia ECG changes correlate with K+ level', () {
        // Peaked T waves first appear at K+ ~5.5
        final peakedT = MetabolicCalculator.hyperkalemiaECG
            .firstWhere((f) => f.id == 'peaked_t');
        expect(peakedT.threshold, 5.5);

        // Sine wave at K+ ~8.0
        final sineWave = MetabolicCalculator.hyperkalemiaECG
            .firstWhere((f) => f.id == 'sine_wave');
        expect(sineWave.threshold, 8.0);
      });
    });

    group('Clinical Case Studies', () {
      
      test('Case: SIADH (Syndrome of Inappropriate ADH)', () {
        // 55 kg elderly female with lung cancer, Na 118
        final tbw = MetabolicCalculator.calculateTBW(55, Sex.female, AgeGroup.elderly);
        final deficit = MetabolicCalculator.calculateSodiumDeficit(tbw, 118, 125);
        
        // TBW = 55 * 0.45 = 24.75 L
        // Need to raise Na by 7 mEq/L
        // Deficit = 24.75 * 7 = 173.25 mEq
        expect(tbw, closeTo(24.75, 0.01));
        expect(deficit, closeTo(173.25, 0.1));
        
        // Treatment: Fluid restriction + possibly 3% saline
        // DO NOT exceed 8 mEq/L/24h due to ODS risk
      });

      test('Case: Heat stroke with hypernatremia', () {
        // 75 kg adult male laborer, Na 165, severe dehydration
        final tbw = MetabolicCalculator.calculateTBW(75, Sex.male, AgeGroup.adult);
        final fwd = MetabolicCalculator.calculateFreeWaterDeficit(tbw, 165, 145);
        
        // TBW = 75 * 0.6 = 45 L
        // FWD = 45 * (165/145 - 1) = 45 * 0.138 = 6.2 L
        expect(tbw, 45.0);
        expect(fwd, closeTo(6.2, 0.1));
        
        // Plus ongoing losses - need to replace deficits over 48-72h
      });

      test('Case: Post-operative hypocalcemia (thyroidectomy)', () {
        // Patient with albumin 3.0 g/dL, measured Ca 7.8
        final correctedCa = MetabolicCalculator.calculateCorrectedCalcium(7.8, 3.0);
        // Corrected = 7.8 + 0.8 * (4.0 - 3.0) = 7.8 + 0.8 = 8.6
        expect(correctedCa, closeTo(8.6, 0.01));
        
        // True corrected calcium is 8.6 - still slightly low
        // Monitor for symptoms, consider IV calcium if symptomatic
      });
    });
  });
}
