import 'package:flutter_test/flutter_test.dart';
import 'package:emtools/domain/entities/blood_gas.dart';

/// Clinical scenario-based tests for blood gas interpretation
/// These tests simulate real patient cases to validate the algorithm
/// References: SRLF, Narins RG (NEJM 1982), Emmett M (Medicine 1980)

void main() {
  group('Clinical Scenarios - Blood Gas Interpretation', () {
    
    group('Scenario 1: Diabetic Ketoacidosis (DKA)', () {
      // Classic DKA: Severe metabolic acidosis with high AG and respiratory compensation
      // Expected: Metabolic acidosis with appropriate compensation (Winter's formula)
      
      test('Classic DKA presentation', () {
        final data = BloodGasPatientData(
          ph: 7.15,
          paco2: 20,      // Compensatory hyperventilation
          hco3: 8,        // Severely low
          pao2: 110,
          na: 140,
          cl: 100,
          alb: 4.0,
          lactate: 2.5,
        );
        final result = BloodGasCalculator.calculate(data);
        
        // Expected: Metabolic acidosis
        expect(result.status, AcidBaseStatus.acidosis);
        expect(result.primary, PrimaryDisorder.metabolic);
        
        // Expected AG: 140 - (100 + 8) = 32 (elevated)
        expect(result.agUncorrected, 32.0);
        
        // Winter's formula: Expected PaCO2 = 1.5 * 8 + 8 = 20 ±2
        // Actual PaCO2 = 20, so appropriately compensated
        expect(result.compensation, CompensationStatus.metabolicCompensatedPure);
      });

      test('DKA with superimposed respiratory acidosis (exhausted patient)', () {
        final data = BloodGasPatientData(
          ph: 7.02,
          paco2: 35,      // Not low enough - respiratory muscle fatigue
          hco3: 8,
          pao2: 85,
          na: 140,
          cl: 100,
          alb: 4.0,
        );
        final result = BloodGasCalculator.calculate(data);
        
        expect(result.status, AcidBaseStatus.acidosis);
        // Winter's: Expected PaCO2 = 20, actual = 35 (too high)
        expect(result.compensation, CompensationStatus.addedRespiratoryAcidosis);
      });

      test('DKA with superimposed respiratory alkalosis (sepsis)', () {
        final data = BloodGasPatientData(
          ph: 7.25,
          paco2: 12,      // Too low - possible sepsis driving hyperventilation
          hco3: 8,
          pao2: 100,
          na: 140,
          cl: 100,
          alb: 4.0,
        );
        final result = BloodGasCalculator.calculate(data);
        
        expect(result.status, AcidBaseStatus.acidosis);
        // Winter's: Expected PaCO2 = 20, actual = 12 (too low)
        expect(result.compensation, CompensationStatus.addedRespiratoryAlkalosis);
      });
    });

    group('Scenario 2: COPD Exacerbation', () {
      // COPD patients have chronic respiratory acidosis with metabolic compensation
      
      test('Acute COPD exacerbation (acute on chronic respiratory acidosis)', () {
        final data = BloodGasPatientData(
          ph: 7.28,
          paco2: 70,      // Significantly elevated
          hco3: 32,       // Elevated (chronic compensation)
          pao2: 55,
          fio2: 0.28,
        );
        final result = BloodGasCalculator.calculate(data);
        
        expect(result.status, AcidBaseStatus.acidosis);
        expect(result.primary, PrimaryDisorder.respiratory);
        
        // For chronic: ΔHCO3 = 3.5 * (ΔPaCO2/10) = 3.5 * 3 = 10.5
        // Expected HCO3 = 24 + 10.5 = 34.5
        // Actual = 32, close to chronic compensation
      });

      test('Chronic stable COPD (compensated respiratory acidosis)', () {
        final data = BloodGasPatientData(
          ph: 7.38,       // Near normal pH (compensated)
          paco2: 55,      // Chronically elevated
          hco3: 32,       // Elevated (renal compensation)
          pao2: 65,
          fio2: 0.21,
        );
        final result = BloodGasCalculator.calculate(data);
        
        // pH is normal, but there are abnormalities
        // Should detect compensated state
        expect(result.status, AcidBaseStatus.compensated);
        expect(result.primary, PrimaryDisorder.mixed);
      });
    });

    group('Scenario 3: Septic Shock', () {
      // Sepsis typically causes: Lactic acidosis + Respiratory alkalosis (early)
      
      test('Early sepsis (respiratory alkalosis with developing lactic acidosis)', () {
        final data = BloodGasPatientData(
          ph: 7.45,
          paco2: 28,      // Hyperventilation
          hco3: 20,       // Slightly low
          pao2: 75,
          fio2: 0.4,
          lactate: 3.5,
          na: 140,
          cl: 105,
          alb: 3.0,
        );
        final result = BloodGasCalculator.calculate(data);
        
        // Lactate elevated
        expect(result.lactateStatus, LactateStatus.hyperlactatemia);
        
        // P/F ratio = 75/0.4 = 187.5 (moderate hypoxemia)
        expect(result.pfRatio, closeTo(187.5, 0.1));
      });

      test('Severe septic shock (mixed acidosis)', () {
        final data = BloodGasPatientData(
          ph: 7.12,
          paco2: 45,      // Normal or high (respiratory muscle failure)
          hco3: 12,       // Very low (lactic acidosis)
          pao2: 60,
          fio2: 0.8,
          lactate: 8.0,
          na: 138,
          cl: 100,
          alb: 2.5,
        );
        final result = BloodGasCalculator.calculate(data);
        
        expect(result.status, AcidBaseStatus.acidosis);
        expect(result.lactateStatus, LactateStatus.shock);
        
        // AG = 138 - (100 + 12) = 26
        expect(result.agUncorrected, 26.0);
        
        // Corrected AG = 26 + 2.5*(4-2.5) = 26 + 3.75 = 29.75
        expect(result.agCorrected, closeTo(29.75, 0.1));
        
        // ARDS assessment: P/F = 60/0.8 = 75 (severe)
        expect(result.pfRatio, 75.0);
        expect(result.ardsGrade, ArdsGrade.severe);
      });
    });

    group('Scenario 4: Vomiting / Pyloric Stenosis', () {
      // Loss of gastric acid causes metabolic alkalosis
      
      test('Severe vomiting (metabolic alkalosis)', () {
        final data = BloodGasPatientData(
          ph: 7.55,
          paco2: 48,      // Compensatory hypoventilation
          hco3: 38,       // Elevated
          pao2: 85,
          na: 138,
          cl: 88,         // Low (hypochloremic)
        );
        final result = BloodGasCalculator.calculate(data);
        
        expect(result.status, AcidBaseStatus.alkalosis);
        expect(result.primary, PrimaryDisorder.metabolic);
        
        // AG = 138 - (88 + 38) = 12 (normal)
        expect(result.agUncorrected, 12.0);
      });
    });

    group('Scenario 5: Salicylate (Aspirin) Overdose', () {
      // Classic triple disorder: Respiratory alkalosis + Metabolic acidosis (high AG)
      
      test('Salicylate toxicity (mixed disorder)', () {
        final data = BloodGasPatientData(
          ph: 7.42,       // Near normal (mixed opposing forces)
          paco2: 22,      // Very low (direct respiratory center stimulation)
          hco3: 14,       // Low (metabolic acidosis)
          pao2: 100,
          na: 140,
          cl: 100,
          alb: 4.0,
        );
        final result = BloodGasCalculator.calculate(data);
        
        // AG = 140 - (100 + 14) = 26 (elevated - salicylate itself + lactate)
        expect(result.agUncorrected, 26.0);
        
        // This is a challenging case - pH is normal but there are two disorders
        // The algorithm should detect the abnormalities
      });
    });

    group('Scenario 6: Hyperventilation Syndrome', () {
      // Acute respiratory alkalosis without metabolic compensation
      
      test('Acute anxiety hyperventilation', () {
        final data = BloodGasPatientData(
          ph: 7.55,
          paco2: 22,      // Very low
          hco3: 22,       // Normal (no time for compensation)
          pao2: 110,
          fio2: 0.21,
        );
        final result = BloodGasCalculator.calculate(data);
        
        expect(result.status, AcidBaseStatus.alkalosis);
        expect(result.primary, PrimaryDisorder.respiratory);
        // Acute - HCO3 hasn't dropped significantly
      });
    });

    group('Scenario 7: Renal Tubular Acidosis', () {
      // Metabolic acidosis with NORMAL anion gap (hyperchloremic)
      
      test('Type 1 RTA (distal)', () {
        final data = BloodGasPatientData(
          ph: 7.28,
          paco2: 25,      // Compensatory
          hco3: 12,       // Low
          pao2: 95,
          na: 140,
          cl: 116,        // High (hyperchloremic)
          alb: 4.0,
        );
        final result = BloodGasCalculator.calculate(data);
        
        expect(result.status, AcidBaseStatus.acidosis);
        expect(result.primary, PrimaryDisorder.metabolic);
        
        // AG = 140 - (116 + 12) = 12 (NORMAL - non-AG acidosis)
        expect(result.agUncorrected, 12.0);
      });
    });

    group('Scenario 8: Mechanical Ventilation', () {
      
      test('ARDS patient on lung protective ventilation', () {
        final data = BloodGasPatientData(
          ph: 7.32,
          paco2: 55,      // Permissive hypercapnia
          hco3: 28,       // Renal compensation developing
          pao2: 65,
          fio2: 0.6,
          vt: 420,
          rr: 22,
          peep: 14,
          pplat: 28,
          ppeak: 35,
          height: 175,
          gender: 'male',
        );
        final result = BloodGasCalculator.calculate(data);
        
        // P/F = 65/0.6 = 108 (moderate-severe ARDS)
        expect(result.pfRatio, closeTo(108.3, 0.1));
        expect(result.ardsGrade, ArdsGrade.moderate);
        
        // Vt/kg: PBW ≈ 70.57, Vt/kg = 420/70.57 ≈ 5.95 mL/kg (good, <8)
        expect(result.vtPerKg, closeTo(5.95, 0.1));
        
        // Driving pressure = 28 - 14 = 14 cmH2O (acceptable, <15)
        expect(result.drivingPressure, 14.0);
        
        // Compliance = 420/14 = 30 mL/cmH2O
        expect(result.compliance, 30.0);
      });

      test('Difficult weaning patient - high RSBI', () {
        final data = BloodGasPatientData(
          rr: 35,
          vt: 250,
          height: 165,
          gender: 'female',
        );
        final result = BloodGasCalculator.calculate(data);
        
        // RSBI = 35 / 0.25 = 140 (high - likely to fail weaning, >105)
        expect(result.rsbi, 140.0);
      });

      test('High airway resistance (bronchospasm)', () {
        final data = BloodGasPatientData(
          ppeak: 45,
          pplat: 22,
          peep: 5,
          vt: 500,
        );
        final result = BloodGasCalculator.calculate(data);
        
        // Resistive gradient = 45 - 22 = 23 cmH2O (high, suggests airway issue)
        expect(result.resistiveGradient, 23.0);
        
        // Compliance = 500 / (22-5) = 29.4 (normal)
        expect(result.compliance, closeTo(29.4, 0.1));
      });
    });

    group('Scenario 9: Post-Cardiac Arrest', () {
      
      test('Post-ROSC mixed acidosis', () {
        final data = BloodGasPatientData(
          ph: 7.05,
          paco2: 50,
          hco3: 12,
          pao2: 180,
          fio2: 1.0,
          lactate: 12.0,
          na: 142,
          cl: 100,
          alb: 3.5,
        );
        final result = BloodGasCalculator.calculate(data);
        
        expect(result.status, AcidBaseStatus.acidosis);
        expect(result.lactateStatus, LactateStatus.shock);
        
        // AG = 142 - (100 + 12) = 30 (high AG from lactate)
        expect(result.agUncorrected, 30.0);
        
        // P/F = 180/1.0 = 180 (moderate hypoxemia)
        expect(result.pfRatio, 180.0);
      });
    });

    group('Scenario 10: Pulmonary Embolism', () {
      
      test('Massive PE with acute respiratory alkalosis', () {
        final data = BloodGasPatientData(
          ph: 7.48,
          paco2: 28,
          hco3: 21,
          pao2: 55,
          fio2: 0.4,
          age: 55,
        );
        final result = BloodGasCalculator.calculate(data);
        
        expect(result.status, AcidBaseStatus.alkalosis);
        expect(result.primary, PrimaryDisorder.respiratory);
        
        // P/F = 55/0.4 = 137.5 (significant hypoxemia)
        expect(result.pfRatio, closeTo(137.5, 0.1));
        
        // A-a gradient would be elevated
        // Expected A-a = 55/4 + 4 = 17.75
        expect(result.expectedAa, closeTo(17.75, 0.1));
      });
    });

    group('Scenario 11: Chronic Kidney Disease', () {
      
      test('CKD with metabolic acidosis and low albumin', () {
        final data = BloodGasPatientData(
          ph: 7.30,
          paco2: 30,
          hco3: 15,
          pao2: 90,
          na: 138,
          cl: 108,
          alb: 2.5,        // Low albumin (nephrotic)
        );
        final result = BloodGasCalculator.calculate(data);
        
        expect(result.status, AcidBaseStatus.acidosis);
        expect(result.primary, PrimaryDisorder.metabolic);
        
        // AG = 138 - (108 + 15) = 15
        expect(result.agUncorrected, 15.0);
        
        // Corrected AG = 15 + 2.5*(4-2.5) = 15 + 3.75 = 18.75
        expect(result.agCorrected, closeTo(18.75, 0.1));
      });
    });

    group('Scenario 12: Delta Ratio Analysis', () {
      
      test('Pure high AG metabolic acidosis (delta ratio 1-2)', () {
        final data = BloodGasPatientData(
          ph: 7.20,
          paco2: 23,
          hco3: 10,
          na: 140,
          cl: 100,
          alb: 4.0,
        );
        final result = BloodGasCalculator.calculate(data);
        
        // AG = 140 - (100 + 10) = 30
        // Delta AG = 30 - 12 = 18
        // Delta HCO3 = 24 - 10 = 14
        // Delta Ratio = 18/14 = 1.29 (pure high AG acidosis)
        expect(result.deltaRatio, closeTo(1.29, 0.1));
      });

      test('Mixed AG and non-AG acidosis (delta ratio < 1)', () {
        final data = BloodGasPatientData(
          ph: 7.15,
          paco2: 18,
          hco3: 6,
          na: 140,
          cl: 110,        // Elevated chloride
          alb: 4.0,
        );
        final result = BloodGasCalculator.calculate(data);
        
        // AG = 140 - (110 + 6) = 24
        // Delta AG = 24 - 12 = 12
        // Delta HCO3 = 24 - 6 = 18
        // Delta Ratio = 12/18 = 0.67 (< 1 = mixed AG + non-AG)
        expect(result.deltaRatio, closeTo(0.67, 0.1));
      });

      test('High AG acidosis with metabolic alkalosis (delta ratio > 2)', () {
        final data = BloodGasPatientData(
          ph: 7.35,
          paco2: 35,
          hco3: 20,
          na: 145,
          cl: 95,
          alb: 4.0,
        );
        final result = BloodGasCalculator.calculate(data);
        
        // AG = 145 - (95 + 20) = 30
        // Delta AG = 30 - 12 = 18
        // Delta HCO3 = 24 - 20 = 4
        // Delta Ratio = 18/4 = 4.5 (> 2 = high AG acidosis + met alkalosis)
        expect(result.deltaRatio, closeTo(4.5, 0.1));
      });
    });

    group('Edge Cases and Boundary Values', () {
      
      test('Extremely low pH (severe acidemia)', () {
        final data = BloodGasPatientData(
          ph: 6.80,
          paco2: 60,
          hco3: 5,
        );
        final result = BloodGasCalculator.calculate(data);
        expect(result.status, AcidBaseStatus.acidosis);
      });

      test('Extremely high pH (severe alkalemia)', () {
        final data = BloodGasPatientData(
          ph: 7.70,
          paco2: 20,
          hco3: 40,
        );
        final result = BloodGasCalculator.calculate(data);
        expect(result.status, AcidBaseStatus.alkalosis);
      });

      test('Borderline acidosis (pH 7.35)', () {
        final data = BloodGasPatientData(
          ph: 7.35,
          paco2: 40,
          hco3: 22,
        );
        final result = BloodGasCalculator.calculate(data);
        // pH 7.35 is the lower limit of normal
        expect(result.status, anyOf(AcidBaseStatus.normal, AcidBaseStatus.acidosis));
      });

      test('Borderline alkalosis (pH 7.45)', () {
        final data = BloodGasPatientData(
          ph: 7.45,
          paco2: 40,
          hco3: 26,
        );
        final result = BloodGasCalculator.calculate(data);
        // pH 7.45 is the upper limit of normal
        expect(result.status, anyOf(AcidBaseStatus.normal, AcidBaseStatus.alkalosis));
      });
    });

    // =========================================================================
    // SECTION: LES 4 TROUS & DELTA RATIO
    // =========================================================================
    
    group('Les 4 Trous - Anion Gap Calculations', () {
      
      group('1. Trou Anionique (TA) - Anion Gap', () {
        // Formula: TA = Na - (Cl + HCO3)
        // Normal: 8-16 mEq/L (typiquement 12 ± 4)
        
        test('Normal anion gap calculation', () {
          final data = BloodGasPatientData(
            ph: 7.40,
            paco2: 40,
            hco3: 24,
            na: 140,
            cl: 104,
            alb: 4.0,
          );
          final result = BloodGasCalculator.calculate(data);
          
          // TA = 140 - (104 + 24) = 12 (normal)
          expect(result.agUncorrected, 12.0);
        });

        test('Elevated anion gap - lactic acidosis', () {
          final data = BloodGasPatientData(
            ph: 7.25,
            paco2: 25,
            hco3: 12,
            na: 140,
            cl: 100,
            alb: 4.0,
            lactate: 8.0,
          );
          final result = BloodGasCalculator.calculate(data);
          
          // TA = 140 - (100 + 12) = 28 (HAGMA)
          expect(result.agUncorrected, 28.0);
          expect(result.agUncorrected, greaterThan(16)); // Elevated
        });

        test('Normal anion gap metabolic acidosis (NAGMA/Hyperchloremic)', () {
          final data = BloodGasPatientData(
            ph: 7.28,
            paco2: 28,
            hco3: 14,
            na: 140,
            cl: 114, // Elevated chloride compensates for low bicarb
            alb: 4.0,
          );
          final result = BloodGasCalculator.calculate(data);
          
          // TA = 140 - (114 + 14) = 12 (normal despite acidosis)
          expect(result.agUncorrected, 12.0);
          expect(result.status, AcidBaseStatus.acidosis);
        });
      });

      group('2. Trou Anionique Corrigé (TAc) - Albumin Correction', () {
        // Formula: TAc = TA + 2.5 × (4.0 - Albumin)
        // Critical for hypoalbuminemic patients (ICU, malnutrition, nephrotic)
        
        test('Normal albumin - no correction needed', () {
          final data = BloodGasPatientData(
            ph: 7.35,
            paco2: 35,
            hco3: 20,
            na: 140,
            cl: 108,
            alb: 4.0, // Normal albumin
          );
          final result = BloodGasCalculator.calculate(data);
          
          // TA = 140 - (108 + 20) = 12
          // TAc = 12 + 2.5 × (4.0 - 4.0) = 12
          expect(result.agUncorrected, 12.0);
          expect(result.agCorrected, 12.0);
        });

        test('Severe hypoalbuminemia - unmasks hidden HAGMA', () {
          final data = BloodGasPatientData(
            ph: 7.30,
            paco2: 30,
            hco3: 15,
            na: 140,
            cl: 110,
            alb: 2.0, // Severe hypoalbuminemia
          );
          final result = BloodGasCalculator.calculate(data);
          
          // TA = 140 - (110 + 15) = 15 (appears normal)
          // TAc = 15 + 2.5 × (4.0 - 2.0) = 15 + 5 = 20 (ELEVATED!)
          expect(result.agUncorrected, 15.0);
          expect(result.agCorrected, 20.0);
          expect(result.agCorrected, greaterThan(16)); // Hidden HAGMA unmasked
        });

        test('ICU patient with albumin 2.5 g/dL', () {
          final data = BloodGasPatientData(
            ph: 7.32,
            paco2: 32,
            hco3: 16,
            na: 142,
            cl: 110,
            alb: 2.5, // Common ICU value
          );
          final result = BloodGasCalculator.calculate(data);
          
          // TA = 142 - (110 + 16) = 16
          // TAc = 16 + 2.5 × (4.0 - 2.5) = 16 + 3.75 = 19.75
          expect(result.agUncorrected, 16.0);
          expect(result.agCorrected, closeTo(19.75, 0.01));
        });

        test('Nephrotic syndrome patient', () {
          final data = BloodGasPatientData(
            ph: 7.38,
            paco2: 38,
            hco3: 22,
            na: 138,
            cl: 106,
            alb: 1.5, // Very low albumin
          );
          final result = BloodGasCalculator.calculate(data);
          
          // TA = 138 - (106 + 22) = 10
          // TAc = 10 + 2.5 × (4.0 - 1.5) = 10 + 6.25 = 16.25
          expect(result.agUncorrected, 10.0);
          expect(result.agCorrected, closeTo(16.25, 0.01));
        });
      });

      group('3. Delta Gap (ΔΔ) - Delta Delta Analysis', () {
        // Delta Gap = (AG - 12) vs (24 - HCO3)
        // Compares excess anions to bicarb deficit
        
        test('Pure HAGMA - delta gap equals zero', () {
          final data = BloodGasPatientData(
            ph: 7.20,
            paco2: 24,
            hco3: 10, // Δbicarb = 24 - 10 = 14
            na: 140,
            cl: 104,
            alb: 4.0,
          );
          final result = BloodGasCalculator.calculate(data);
          
          // TA = 140 - (104 + 10) = 26
          // ΔAG = 26 - 12 = 14
          // Δbicarb = 24 - 10 = 14
          // Delta-Delta = 14/14 = 1.0 (pure HAGMA)
          expect(result.agUncorrected, 26.0);
          expect(result.deltaRatio, closeTo(1.0, 0.1));
        });

        test('Mixed HAGMA + NAGMA - delta ratio < 1', () {
          // Example: DKA + diarrhea
          final data = BloodGasPatientData(
            ph: 7.15,
            paco2: 18,
            hco3: 6, // Δbicarb = 24 - 6 = 18
            na: 140,
            cl: 108,
            alb: 4.0,
          );
          final result = BloodGasCalculator.calculate(data);
          
          // TA = 140 - (108 + 6) = 26
          // ΔAG = 26 - 12 = 14
          // Δbicarb = 24 - 6 = 18
          // Delta ratio = 14/18 = 0.78 (< 1 = mixed with NAGMA)
          expect(result.agUncorrected, 26.0);
          expect(result.deltaRatio, lessThan(1.0));
          expect(result.deltaRatio, closeTo(0.78, 0.05));
        });

        test('HAGMA + metabolic alkalosis - delta ratio > 2', () {
          // Example: Vomiting + lactic acidosis
          final data = BloodGasPatientData(
            ph: 7.35,
            paco2: 35,
            hco3: 20, // Δbicarb = 24 - 20 = 4
            na: 140,
            cl: 90,
            alb: 4.0,
          );
          final result = BloodGasCalculator.calculate(data);
          
          // TA = 140 - (90 + 20) = 30
          // ΔAG = 30 - 12 = 18
          // Δbicarb = 24 - 20 = 4
          // Delta ratio = 18/4 = 4.5 (> 2 = coexisting met alkalosis)
          expect(result.agUncorrected, 30.0);
          expect(result.deltaRatio, greaterThan(2.0));
        });
      });

      group('4. Delta Ratio Interpretation', () {
        // Delta Ratio = ΔAG / ΔBicarb = (AG - 12) / (24 - HCO3)
        // < 1: Mixed HAGMA + NAGMA
        // 1-2: Pure HAGMA
        // > 2: HAGMA + metabolic alkalosis
        
        test('Delta ratio 0.5 - predominantly NAGMA', () {
          final data = BloodGasPatientData(
            ph: 7.22,
            paco2: 25,
            hco3: 10,
            na: 140,
            cl: 115, // High chloride
            alb: 4.0,
          );
          final result = BloodGasCalculator.calculate(data);
          
          // TA = 140 - (115 + 10) = 15
          // ΔAG = 15 - 12 = 3
          // Δbicarb = 24 - 10 = 14
          // Delta ratio = 3/14 ≈ 0.21
          expect(result.deltaRatio, lessThan(1.0));
        });

        test('Delta ratio 1.5 - pure HAGMA range', () {
          final data = BloodGasPatientData(
            ph: 7.25,
            paco2: 28,
            hco3: 12,
            na: 140,
            cl: 100,
            alb: 4.0,
          );
          final result = BloodGasCalculator.calculate(data);
          
          // TA = 140 - (100 + 12) = 28
          // ΔAG = 28 - 12 = 16
          // Δbicarb = 24 - 12 = 12
          // Delta ratio = 16/12 ≈ 1.33
          expect(result.deltaRatio, greaterThanOrEqualTo(1.0));
          expect(result.deltaRatio, lessThanOrEqualTo(2.0));
        });

        test('Zero bicarb change - handles division safely', () {
          final data = BloodGasPatientData(
            ph: 7.40,
            paco2: 40,
            hco3: 24, // Normal bicarb, Δbicarb = 0
            na: 140,
            cl: 104,
            alb: 4.0,
          );
          final result = BloodGasCalculator.calculate(data);
          
          // Should handle Δbicarb = 0 without crash
          expect(result.deltaRatio, isNotNaN);
          expect(result.deltaRatio, 0.0); // Safe default
        });
      });
    });

    group('Complex Mixed Disorders with Gap Analysis', () {
      
      test('Triple disorder: HAGMA + Met Alk + Resp Acidosis', () {
        // Vomiting patient with sepsis and respiratory failure
        final data = BloodGasPatientData(
          ph: 7.30,
          paco2: 50, // Elevated (resp acidosis)
          hco3: 24, // Normal-ish (met alk compensating HAGMA)
          na: 140,
          cl: 85, // Low (vomiting, met alk)
          alb: 3.0,
          lactate: 6.0,
        );
        final result = BloodGasCalculator.calculate(data);
        
        // TA = 140 - (85 + 24) = 31 (HAGMA)
        // TAc = 31 + 2.5 × (4 - 3) = 33.5
        // ΔAG = 31 - 12 = 19
        // Δbicarb = 24 - 24 = 0 → bicarb is "normal" but AG is high!
        // This suggests HAGMA + Met Alk masking the bicarb drop
        expect(result.agUncorrected, 31.0);
        expect(result.agCorrected, closeTo(33.5, 0.1));
      });

      test('Salicylate poisoning early phase', () {
        // Early: respiratory alkalosis, later: metabolic acidosis
        final data = BloodGasPatientData(
          ph: 7.50,
          paco2: 25, // Low (direct respiratory center stimulation)
          hco3: 20, // Starting to drop
          na: 140,
          cl: 102,
          alb: 4.0,
        );
        final result = BloodGasCalculator.calculate(data);
        
        // TA = 140 - (102 + 20) = 18 (starting to elevate)
        expect(result.agUncorrected, 18.0);
        expect(result.status, AcidBaseStatus.alkalosis);
      });

      test('Ethylene glycol poisoning', () {
        // Severe HAGMA with osmolar gap (oxalic acid crystals)
        final data = BloodGasPatientData(
          ph: 7.10,
          paco2: 12, // Maximal compensation
          hco3: 4, // Severely depleted
          na: 140,
          cl: 100,
          alb: 4.0,
        );
        final result = BloodGasCalculator.calculate(data);
        
        // TA = 140 - (100 + 4) = 36 (very high)
        // ΔAG = 36 - 12 = 24
        // Δbicarb = 24 - 4 = 20
        // Delta ratio = 24/20 = 1.2 (pure HAGMA)
        expect(result.agUncorrected, 36.0);
        expect(result.deltaRatio, closeTo(1.2, 0.1));
      });
    });
  });
}
