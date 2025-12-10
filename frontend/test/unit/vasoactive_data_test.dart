import 'package:flutter_test/flutter_test.dart';
import 'package:emtools/data/datasources/vasoactive_data.dart';
import 'package:emtools/domain/entities/vasoactive.dart';

void main() {
  group('VasoactiveData', () {
    test('allDrugs should not be empty', () {
      expect(VasoactiveData.allDrugs, isNotEmpty);
    });

    test('allDrugs should contain expected drugs', () {
      final drugIds = VasoactiveData.allDrugs.map((d) => d.id).toList();
      expect(drugIds, contains('noradrenaline'));
      expect(drugIds, contains('adrenaline'));
      expect(drugIds, contains('dobutamine'));
    });

    test('each drug should have required fields', () {
      for (final drug in VasoactiveData.allDrugs) {
        expect(drug.id, isNotEmpty, reason: 'Drug ID should not be empty');
        expect(drug.name, isNotEmpty, reason: 'Drug name should not be empty');
        expect(drug.genericName, isNotEmpty, reason: 'Generic name should not be empty');
        expect(drug.description, isNotEmpty, reason: 'Description should not be empty');
        expect(drug.concentrations, isNotEmpty, reason: '${drug.name} should have concentrations');
        expect(drug.indications, isNotEmpty, reason: '${drug.name} should have indications');
        expect(drug.notes, isNotEmpty, reason: '${drug.name} should have notes');
      }
    });

    test('each drug should have valid dose range', () {
      for (final drug in VasoactiveData.allDrugs) {
        expect(drug.doseRange.min, greaterThanOrEqualTo(0), 
          reason: '${drug.name} min dose should be >= 0');
        expect(drug.doseRange.max, greaterThan(drug.doseRange.min), 
          reason: '${drug.name} max dose should be > min dose');
        expect(drug.doseRange.typical, greaterThanOrEqualTo(drug.doseRange.min), 
          reason: '${drug.name} typical dose should be >= min');
        expect(drug.doseRange.typical, lessThanOrEqualTo(drug.doseRange.max), 
          reason: '${drug.name} typical dose should be <= max');
        expect(drug.doseRange.step, greaterThan(0), 
          reason: '${drug.name} step should be > 0');
      }
    });

    test('each drug should have valid default concentration index', () {
      for (final drug in VasoactiveData.allDrugs) {
        expect(drug.defaultConcentrationIndex, greaterThanOrEqualTo(0),
          reason: '${drug.name} default index should be >= 0');
        expect(drug.defaultConcentrationIndex, lessThan(drug.concentrations.length),
          reason: '${drug.name} default index should be < concentrations length');
      }
    });

    test('each concentration should have positive mg/mL', () {
      for (final drug in VasoactiveData.allDrugs) {
        for (final conc in drug.concentrations) {
          expect(conc.mgPerMl, greaterThan(0),
            reason: '${drug.name} concentration ${conc.label} should have positive mg/mL');
          expect(conc.label, isNotEmpty,
            reason: '${drug.name} concentration should have label');
          expect(conc.commonPrep, isNotEmpty,
            reason: '${drug.name} concentration should have common prep');
        }
      }
    });
  });

  group('VasoactiveCategory', () {
    test('should have vasopressor drugs', () {
      final vasopressors = VasoactiveData.allDrugs
          .where((d) => d.category == VasoactiveCategory.vasopressor)
          .toList();
      expect(vasopressors, isNotEmpty);
      expect(vasopressors.map((d) => d.id), contains('noradrenaline'));
    });

    test('should have inotrope drugs', () {
      final inotropes = VasoactiveData.allDrugs
          .where((d) => d.category == VasoactiveCategory.inotrope)
          .toList();
      expect(inotropes, isNotEmpty);
      expect(inotropes.map((d) => d.id), contains('dobutamine'));
    });

    test('should have mixed drugs', () {
      final mixed = VasoactiveData.allDrugs
          .where((d) => d.category == VasoactiveCategory.mixed)
          .toList();
      expect(mixed, isNotEmpty);
      expect(mixed.map((d) => d.id), contains('adrenaline'));
    });
  });

  group('Noradrenaline', () {
    late VasoactiveDrug noradrenaline;

    setUp(() {
      noradrenaline = VasoactiveData.allDrugs.firstWhere((d) => d.id == 'noradrenaline');
    });

    test('should be categorized as vasopressor', () {
      expect(noradrenaline.category, VasoactiveCategory.vasopressor);
    });

    test('should have correct dose unit', () {
      expect(noradrenaline.doseUnit, 'mcg/kg/min');
    });

    test('should have multiple concentrations', () {
      expect(noradrenaline.concentrations.length, greaterThanOrEqualTo(3));
    });

    test('should have high alpha effect', () {
      expect(noradrenaline.effects.alpha, 'high');
    });

    test('should include septic shock in indications', () {
      expect(
        noradrenaline.indications.any((i) => i.toLowerCase().contains('septique')),
        isTrue,
      );
    });
  });

  group('Adrenaline', () {
    late VasoactiveDrug adrenaline;

    setUp(() {
      adrenaline = VasoactiveData.allDrugs.firstWhere((d) => d.id == 'adrenaline');
    });

    test('should be categorized as mixed', () {
      expect(adrenaline.category, VasoactiveCategory.mixed);
    });

    test('should have high alpha and beta1 effects', () {
      expect(adrenaline.effects.alpha, 'high');
      expect(adrenaline.effects.beta1, 'high');
    });

    test('should include anaphylactic shock in indications', () {
      expect(
        adrenaline.indications.any((i) => i.toLowerCase().contains('anaphylact')),
        isTrue,
      );
    });

    test('should include cardiac arrest in indications', () {
      expect(
        adrenaline.indications.any((i) => i.toLowerCase().contains('arrêt cardiaque')),
        isTrue,
      );
    });
  });

  group('Dobutamine', () {
    late VasoactiveDrug dobutamine;

    setUp(() {
      dobutamine = VasoactiveData.allDrugs.firstWhere((d) => d.id == 'dobutamine');
    });

    test('should be categorized as inotrope', () {
      expect(dobutamine.category, VasoactiveCategory.inotrope);
    });

    test('should have dose unit mcg/kg/min', () {
      expect(dobutamine.doseUnit, 'mcg/kg/min');
    });
  });

  group('DrugEffects', () {
    test('default constructor should set all effects to none', () {
      const effects = DrugEffects();
      expect(effects.alpha, 'none');
      expect(effects.beta1, 'none');
      expect(effects.beta2, 'none');
      expect(effects.dopaminergic, 'none');
      expect(effects.vasopressin, 'none');
    });

    test('should allow custom effect levels', () {
      const effects = DrugEffects(
        alpha: 'high',
        beta1: 'moderate',
        beta2: 'low',
      );
      expect(effects.alpha, 'high');
      expect(effects.beta1, 'moderate');
      expect(effects.beta2, 'low');
    });
  });

  group('DrugConcentration', () {
    test('should store values correctly', () {
      const conc = DrugConcentration(
        label: '0.5 mg/mL',
        mgPerMl: 0.5,
        commonPrep: '8 mg in 16 mL',
      );
      expect(conc.label, '0.5 mg/mL');
      expect(conc.mgPerMl, 0.5);
      expect(conc.commonPrep, '8 mg in 16 mL');
    });
  });

  group('DrugDoseRange', () {
    test('should store values correctly', () {
      const range = DrugDoseRange(
        min: 0.05,
        max: 3.0,
        typical: 0.2,
        step: 0.05,
      );
      expect(range.min, 0.05);
      expect(range.max, 3.0);
      expect(range.typical, 0.2);
      expect(range.step, 0.05);
    });
  });

  group('Flow Rate Calculation', () {
    // Testing the calculation logic from vasoactive_screen
    // Flow rate (mL/h) = (dose * weight * 60) / (concentration in mcg/mL * 1000)
    // For mcg/kg/min drugs

    test('noradrenaline flow rate calculation at typical dose', () {
      final noradrenaline = VasoactiveData.allDrugs.firstWhere((d) => d.id == 'noradrenaline');
      final concentration = noradrenaline.concentrations[0]; // 0.5 mg/mL
      const weight = 70.0;
      final dose = noradrenaline.doseRange.typical; // 0.2 mcg/kg/min

      // mcg/min = dose * weight = 0.2 * 70 = 14 mcg/min
      // mg/min = 14 / 1000 = 0.014 mg/min
      // mL/min = 0.014 / 0.5 = 0.028 mL/min
      // mL/h = 0.028 * 60 = 1.68 mL/h
      final mcgPerMin = dose * weight;
      final mgPerMin = mcgPerMin / 1000;
      final mlPerMin = mgPerMin / concentration.mgPerMl;
      final flowRate = mlPerMin * 60;

      expect(flowRate, closeTo(1.68, 0.01));
    });

    test('dobutamine flow rate calculation', () {
      final dobutamine = VasoactiveData.allDrugs.firstWhere((d) => d.id == 'dobutamine');
      final concentration = dobutamine.concentrations[0]; // 5 mg/mL
      const weight = 70.0;
      const dose = 5.0; // 5 mcg/kg/min (typical starting dose)

      // mcg/min = 5 * 70 = 350 mcg/min
      // mg/min = 350 / 1000 = 0.35 mg/min
      // mL/min = 0.35 / 5 = 0.07 mL/min
      // mL/h = 0.07 * 60 = 4.2 mL/h
      final mcgPerMin = dose * weight;
      final mgPerMin = mcgPerMin / 1000;
      final mlPerMin = mgPerMin / concentration.mgPerMl;
      final flowRate = mlPerMin * 60;

      expect(flowRate, closeTo(4.2, 0.01));
    });
  });
}
