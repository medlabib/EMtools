import 'package:flutter_test/flutter_test.dart';
import 'package:emtools/data/datasources/vasoactive_data.dart';
import 'package:emtools/domain/entities/vasoactive.dart';

/// Clinical scenario-based tests for vasoactive drug calculations
/// These tests validate flow rate calculations for common clinical scenarios
/// References: SSC 2021, SRLF, SFAR

void main() {
  group('Clinical Scenarios - Vasoactive Drug Calculations', () {
    
    /// Flow rate calculation formula (for mcg/kg/min drugs):
    /// 1. mcg/min = dose (mcg/kg/min) × weight (kg)
    /// 2. mg/min = mcg/min / 1000
    /// 3. mL/min = mg/min / concentration (mg/mL)
    /// 4. mL/h = mL/min × 60
    
    double calculateFlowRate({
      required double dose,       // mcg/kg/min
      required double weight,     // kg
      required double concentration, // mg/mL
      required String doseUnit,
    }) {
      double mcgPerMin;
      
      switch (doseUnit) {
        case 'mcg/kg/min':
          mcgPerMin = dose * weight;
          break;
        case 'mcg/min':
          mcgPerMin = dose;
          break;
        case 'mg/h':
          mcgPerMin = (dose * 1000) / 60;
          break;
        case 'UI/min':
          // For vasopressin: UI/min → mL/h directly
          return (dose / concentration) * 60;
        default:
          mcgPerMin = dose;
      }
      
      final mgPerMin = mcgPerMin / 1000;
      final mlPerMin = mgPerMin / concentration;
      return mlPerMin * 60;
    }

    group('Scenario 1: Septic Shock - Noradrenaline Titration', () {
      late VasoactiveDrug noradrenaline;

      setUp(() {
        noradrenaline = VasoactiveData.allDrugs.firstWhere((d) => d.id == 'noradrenaline');
      });

      test('Starting dose (0.05 mcg/kg/min) in 70 kg patient', () {
        final concentration = noradrenaline.concentrations[0].mgPerMl; // 0.5 mg/mL
        final flowRate = calculateFlowRate(
          dose: 0.05,
          weight: 70,
          concentration: concentration,
          doseUnit: 'mcg/kg/min',
        );
        
        // mcg/min = 0.05 × 70 = 3.5
        // mg/min = 3.5 / 1000 = 0.0035
        // mL/min = 0.0035 / 0.5 = 0.007
        // mL/h = 0.007 × 60 = 0.42
        expect(flowRate, closeTo(0.42, 0.01));
      });

      test('Typical dose (0.2 mcg/kg/min) in 70 kg patient', () {
        final concentration = noradrenaline.concentrations[0].mgPerMl; // 0.5 mg/mL
        final flowRate = calculateFlowRate(
          dose: 0.2,
          weight: 70,
          concentration: concentration,
          doseUnit: 'mcg/kg/min',
        );
        
        // mcg/min = 0.2 × 70 = 14
        // mg/min = 0.014
        // mL/min = 0.014 / 0.5 = 0.028
        // mL/h = 1.68
        expect(flowRate, closeTo(1.68, 0.01));
      });

      test('High dose (1.0 mcg/kg/min) in 80 kg patient', () {
        final concentration = noradrenaline.concentrations[1].mgPerMl; // 1.0 mg/mL (more concentrated for high dose)
        final flowRate = calculateFlowRate(
          dose: 1.0,
          weight: 80,
          concentration: concentration,
          doseUnit: 'mcg/kg/min',
        );
        
        // mcg/min = 1.0 × 80 = 80
        // mg/min = 0.08
        // mL/min = 0.08 / 1.0 = 0.08
        // mL/h = 4.8
        expect(flowRate, closeTo(4.8, 0.01));
      });

      test('Verify dose range is clinically appropriate', () {
        expect(noradrenaline.doseRange.min, 0.05);
        expect(noradrenaline.doseRange.max, 3.0);
        expect(noradrenaline.doseRange.typical, 0.2);
        // SSC 2021 recommends starting at low dose, titrating to MAP ≥65
      });
    });

    group('Scenario 2: Cardiogenic Shock - Dobutamine', () {
      late VasoactiveDrug dobutamine;

      setUp(() {
        dobutamine = VasoactiveData.allDrugs.firstWhere((d) => d.id == 'dobutamine');
      });

      test('Starting dose (5 mcg/kg/min) in 70 kg patient', () {
        final concentration = dobutamine.concentrations[0].mgPerMl; // 5.0 mg/mL
        final flowRate = calculateFlowRate(
          dose: 5.0,
          weight: 70,
          concentration: concentration,
          doseUnit: 'mcg/kg/min',
        );
        
        // mcg/min = 5.0 × 70 = 350
        // mg/min = 0.35
        // mL/min = 0.35 / 5.0 = 0.07
        // mL/h = 4.2
        expect(flowRate, closeTo(4.2, 0.01));
      });

      test('Higher dose (10 mcg/kg/min) in 60 kg patient', () {
        final concentration = dobutamine.concentrations[0].mgPerMl; // 5.0 mg/mL
        final flowRate = calculateFlowRate(
          dose: 10.0,
          weight: 60,
          concentration: concentration,
          doseUnit: 'mcg/kg/min',
        );
        
        // mcg/min = 10 × 60 = 600
        // mg/min = 0.6
        // mL/min = 0.6 / 5.0 = 0.12
        // mL/h = 7.2
        expect(flowRate, closeTo(7.2, 0.01));
      });

      test('Maximum dose (20 mcg/kg/min) in 80 kg patient', () {
        final concentration = dobutamine.concentrations[2].mgPerMl; // 10.0 mg/mL for high dose
        final flowRate = calculateFlowRate(
          dose: 20.0,
          weight: 80,
          concentration: concentration,
          doseUnit: 'mcg/kg/min',
        );
        
        // mcg/min = 20 × 80 = 1600
        // mg/min = 1.6
        // mL/min = 1.6 / 10.0 = 0.16
        // mL/h = 9.6
        expect(flowRate, closeTo(9.6, 0.01));
      });
    });

    group('Scenario 3: Anaphylactic Shock - Adrenaline', () {
      late VasoactiveDrug adrenaline;

      setUp(() {
        adrenaline = VasoactiveData.allDrugs.firstWhere((d) => d.id == 'adrenaline');
      });

      test('Low dose adrenaline (0.05 mcg/kg/min) for β-effect', () {
        final concentration = adrenaline.concentrations[1].mgPerMl; // 0.2 mg/mL
        final flowRate = calculateFlowRate(
          dose: 0.05,
          weight: 70,
          concentration: concentration,
          doseUnit: 'mcg/kg/min',
        );
        
        // mcg/min = 0.05 × 70 = 3.5
        // mg/min = 0.0035
        // mL/min = 0.0035 / 0.2 = 0.0175
        // mL/h = 1.05
        expect(flowRate, closeTo(1.05, 0.01));
      });

      test('Higher dose adrenaline (0.3 mcg/kg/min) for α-effect', () {
        final concentration = adrenaline.concentrations[2].mgPerMl; // 0.5 mg/mL
        final flowRate = calculateFlowRate(
          dose: 0.3,
          weight: 70,
          concentration: concentration,
          doseUnit: 'mcg/kg/min',
        );
        
        // mcg/min = 0.3 × 70 = 21
        // mg/min = 0.021
        // mL/min = 0.021 / 0.5 = 0.042
        // mL/h = 2.52
        expect(flowRate, closeTo(2.52, 0.01));
      });

      test('Verify dose-dependent effects described correctly', () {
        // Low dose (<0.1): β predominant (inotrope)
        // High dose (>0.1): α predominant (vasopressor)
        expect(adrenaline.notes.any((n) => n.contains('< 0.1') && n.contains('β')), isTrue);
        expect(adrenaline.notes.any((n) => n.contains('> 0.1') && n.contains('α')), isTrue);
      });
    });

    group('Scenario 4: Refractory Septic Shock - Vasopressin', () {
      late VasoactiveDrug vasopressin;

      setUp(() {
        vasopressin = VasoactiveData.allDrugs.firstWhere((d) => d.id == 'vasopressine');
      });

      test('Standard fixed dose (0.03 UI/min)', () {
        final concentration = vasopressin.concentrations[0].mgPerMl; // 0.4 UI/mL
        final flowRate = calculateFlowRate(
          dose: 0.03,
          weight: 70, // Not used for vasopressin
          concentration: concentration,
          doseUnit: 'UI/min',
        );
        
        // mL/min = 0.03 / 0.4 = 0.075
        // mL/h = 0.075 × 60 = 4.5
        expect(flowRate, closeTo(4.5, 0.01));
      });

      test('Vasopressin is NOT weight-based', () {
        expect(vasopressin.doseUnit, 'UI/min');
        expect(vasopressin.notes.any((n) => n.toLowerCase().contains('fixe')), isTrue);
      });

      test('Verify dose range per SSC guidelines', () {
        // SSC 2021: 0.03 UI/min as adjunct to norepinephrine
        expect(vasopressin.doseRange.typical, 0.03);
        expect(vasopressin.doseRange.max, 0.04);
      });
    });

    group('Scenario 5: Hypertensive Emergency - Nicardipine', () {
      late VasoactiveDrug nicardipine;

      setUp(() {
        nicardipine = VasoactiveData.allDrugs.firstWhere((d) => d.id == 'nicardipine');
      });

      test('Starting dose (5 mg/h)', () {
        final concentration = nicardipine.concentrations[0].mgPerMl; // 0.2 mg/mL
        
        // For mg/h drugs: flow rate = dose / concentration
        // 5 mg/h / 0.2 mg/mL = 25 mL/h
        final flowRate = calculateFlowRate(
          dose: 5.0,
          weight: 70, // Not used for mg/h
          concentration: concentration,
          doseUnit: 'mg/h',
        );
        
        // mcg/min from mg/h = (5 × 1000) / 60 = 83.33
        // mg/min = 0.0833
        // mL/min = 0.0833 / 0.2 = 0.417
        // mL/h = 25
        expect(flowRate, closeTo(25, 0.1));
      });

      test('Maximum dose (15 mg/h)', () {
        final concentration = nicardipine.concentrations[2].mgPerMl; // 1.0 mg/mL for high dose
        final flowRate = calculateFlowRate(
          dose: 15.0,
          weight: 70,
          concentration: concentration,
          doseUnit: 'mg/h',
        );
        
        // mcg/min = (15 × 1000) / 60 = 250
        // mg/min = 0.25
        // mL/min = 0.25 / 1.0 = 0.25
        // mL/h = 15
        expect(flowRate, closeTo(15, 0.1));
      });
    });

    group('Scenario 6: Post-Cardiac Surgery - Milrinone', () {
      late VasoactiveDrug milrinone;

      setUp(() {
        milrinone = VasoactiveData.allDrugs.firstWhere((d) => d.id == 'milrinone');
      });

      test('Typical dose (0.375 mcg/kg/min) in 75 kg patient', () {
        final concentration = milrinone.concentrations[0].mgPerMl; // 0.2 mg/mL
        final flowRate = calculateFlowRate(
          dose: 0.375,
          weight: 75,
          concentration: concentration,
          doseUnit: 'mcg/kg/min',
        );
        
        // mcg/min = 0.375 × 75 = 28.125
        // mg/min = 0.028125
        // mL/min = 0.028125 / 0.2 = 0.141
        // mL/h = 8.44
        expect(flowRate, closeTo(8.44, 0.1));
      });

      test('Verify milrinone requires renal dose adjustment', () {
        expect(milrinone.notes.any((n) => n.toLowerCase().contains('rénal')), isTrue);
      });
    });

    group('Scenario 7: Bradycardia - Isoproterenol', () {
      late VasoactiveDrug isoproterenol;

      setUp(() {
        isoproterenol = VasoactiveData.allDrugs.firstWhere((d) => d.id == 'isoproterenol');
      });

      test('Isoproterenol dose is mcg/min (not weight-based)', () {
        expect(isoproterenol.doseUnit, 'mcg/min');
      });

      test('Typical dose (5 mcg/min)', () {
        final concentration = isoproterenol.concentrations[0].mgPerMl; // 0.02 mg/mL
        final flowRate = calculateFlowRate(
          dose: 5.0,
          weight: 70, // Not used
          concentration: concentration,
          doseUnit: 'mcg/min',
        );
        
        // mcg/min = 5
        // mg/min = 0.005
        // mL/min = 0.005 / 0.02 = 0.25
        // mL/h = 15
        expect(flowRate, closeTo(15, 0.1));
      });
    });

    group('Drug Data Integrity Checks', () {
      
      test('All drugs have valid concentration data', () {
        for (final drug in VasoactiveData.allDrugs) {
          expect(drug.concentrations, isNotEmpty,
              reason: '${drug.name} should have concentrations');
          for (final conc in drug.concentrations) {
            expect(conc.mgPerMl, greaterThan(0),
                reason: '${drug.name} concentration should be positive');
          }
        }
      });

      test('All drugs have appropriate dose units', () {
        final validUnits = ['mcg/kg/min', 'mcg/min', 'mg/h', 'UI/min'];
        for (final drug in VasoactiveData.allDrugs) {
          expect(validUnits, contains(drug.doseUnit),
              reason: '${drug.name} should have valid dose unit');
        }
      });

      test('All drugs have indications listed', () {
        for (final drug in VasoactiveData.allDrugs) {
          expect(drug.indications, isNotEmpty,
              reason: '${drug.name} should have indications');
        }
      });

      test('Noradrenaline is first-line for septic shock', () {
        final norad = VasoactiveData.allDrugs.firstWhere((d) => d.id == 'noradrenaline');
        expect(norad.indications.any((i) => 
            i.toLowerCase().contains('septique') && 
            i.toLowerCase().contains('1')), isTrue);
      });
    });

    group('Weight-based Dose Scenarios', () {
      
      test('Underweight patient (50 kg) - noradrenaline', () {
        final norad = VasoactiveData.allDrugs.firstWhere((d) => d.id == 'noradrenaline');
        final concentration = norad.concentrations[0].mgPerMl;
        final flowRate = calculateFlowRate(
          dose: 0.2,
          weight: 50,
          concentration: concentration,
          doseUnit: 'mcg/kg/min',
        );
        
        // mcg/min = 0.2 × 50 = 10
        // mg/min = 0.01
        // mL/min = 0.01 / 0.5 = 0.02
        // mL/h = 1.2
        expect(flowRate, closeTo(1.2, 0.01));
      });

      test('Obese patient (120 kg) - use ideal body weight considerations', () {
        // In obese patients, some centers use IBW or adjusted body weight
        // This test verifies calculation at actual weight
        final norad = VasoactiveData.allDrugs.firstWhere((d) => d.id == 'noradrenaline');
        final concentration = norad.concentrations[0].mgPerMl;
        final flowRate = calculateFlowRate(
          dose: 0.2,
          weight: 120,
          concentration: concentration,
          doseUnit: 'mcg/kg/min',
        );
        
        // mcg/min = 0.2 × 120 = 24
        // mg/min = 0.024
        // mL/min = 0.024 / 0.5 = 0.048
        // mL/h = 2.88
        expect(flowRate, closeTo(2.88, 0.01));
        
        // Note: May consider using IBW in practice
      });
    });
  });
}
