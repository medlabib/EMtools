import 'package:flutter_test/flutter_test.dart';
import 'package:emtools/domain/entities/sedation.dart';
import 'package:emtools/data/datasources/sedation_data.dart';

void main() {
  group('SedationData', () {
    group('Drug List Completeness', () {
      test('contains all required induction agents', () {
        final drugIds = SedationData.allDrugs.map((d) => d.id).toList();
        expect(drugIds, contains('propofol'));
        expect(drugIds, contains('etomidate'));
        expect(drugIds, contains('ketamine'));
        expect(drugIds, contains('midazolam'));
      });

      test('contains paralytic agents', () {
        final drugIds = SedationData.allDrugs.map((d) => d.id).toList();
        expect(drugIds, contains('succinylcholine'));
        expect(drugIds, contains('rocuronium'));
      });

      test('contains opioid analgesics', () {
        final drugIds = SedationData.allDrugs.map((d) => d.id).toList();
        expect(drugIds, contains('fentanyl'));
        expect(drugIds, contains('morphine'));
      });

      test('contains adjuncts', () {
        final drugIds = SedationData.allDrugs.map((d) => d.id).toList();
        expect(drugIds, contains('atropine'));
        expect(drugIds, contains('lidocaine'));
      });
    });

    group('Propofol Data', () {
      late SedationDrug propofol;

      setUpAll(() {
        propofol = SedationData.allDrugs.firstWhere((d) => d.id == 'propofol');
      });

      test('has correct standard dose', () {
        expect(propofol.standardDose, 1.5);
        expect(propofol.doseUnit, 'mg/kg');
      });

      test('supports RSI and procedural sedation', () {
        expect(propofol.sedationTypes, contains(SedationType.rsi));
        expect(propofol.sedationTypes, contains(SedationType.procedural));
      });

      test('has induction role', () {
        expect(propofol.role, contains(DrugRole.induction));
      });

      test('has age-specific dosing', () {
        expect(propofol.dosesByAge, isNotEmpty);
        
        final adultDose = propofol.dosesByAge.firstWhere(
          (d) => d.ageGroup == AgeGroup.adult,
        );
        expect(adultDose.dose, 1.5);
        
        final elderlyDose = propofol.dosesByAge.firstWhere(
          (d) => d.ageGroup == AgeGroup.elderly,
        );
        expect(elderlyDose.dose, lessThan(adultDose.dose));
      });

      test('has rapid onset', () {
        expect(propofol.onsetSeconds, lessThanOrEqualTo(60));
      });
    });

    group('Etomidate Data', () {
      late SedationDrug etomidate;

      setUpAll(() {
        etomidate = SedationData.allDrugs.firstWhere((d) => d.id == 'etomidate');
      });

      test('has correct standard dose', () {
        expect(etomidate.standardDose, 0.3);
        expect(etomidate.doseUnit, 'mg/kg');
      });

      test('supports RSI and procedural sedation', () {
        expect(etomidate.sedationTypes, contains(SedationType.rsi));
        expect(etomidate.sedationTypes, contains(SedationType.procedural));
      });

      test('lists hemodynamic stability as advantage', () {
        expect(
          etomidate.advantages.any((a) => a.toLowerCase().contains('hémodynamique') || 
                                          a.toLowerCase().contains('stabilit')),
          true,
        );
      });

      test('mentions adrenal suppression in side effects', () {
        expect(
          etomidate.sideEffects.any((s) => s.toLowerCase().contains('surrénalienne') ||
                                           s.toLowerCase().contains('surrénal')),
          true,
        );
      });
    });

    group('Ketamine Data', () {
      late SedationDrug ketamine;

      setUpAll(() {
        ketamine = SedationData.allDrugs.firstWhere((d) => d.id == 'ketamine');
      });

      test('has correct standard dose for IV', () {
        expect(ketamine.standardDose, 1.5);
        expect(ketamine.doseUnit, 'mg/kg');
      });

      test('supports multiple routes', () {
        expect(ketamine.route, contains('IV'));
        expect(ketamine.route, contains('IM'));
      });

      test('has analgesic role', () {
        expect(ketamine.role, contains(DrugRole.analgesic));
      });

      test('lists bronchodilation as advantage', () {
        expect(
          ketamine.advantages.any((a) => a.toLowerCase().contains('bronchodilat')),
          true,
        );
      });
    });

    group('Succinylcholine Data', () {
      late SedationDrug succinylcholine;

      setUpAll(() {
        succinylcholine = SedationData.allDrugs.firstWhere((d) => d.id == 'succinylcholine');
      });

      test('has correct dose', () {
        expect(succinylcholine.standardDose, 1.5);
      });

      test('is paralytic role only', () {
        expect(succinylcholine.role, [DrugRole.paralytic]);
      });

      test('has very short onset', () {
        expect(succinylcholine.onsetSeconds, lessThanOrEqualTo(60));
      });

      test('lists hyperthermia maligne in contraindications', () {
        expect(
          succinylcholine.contraindications.any(
            (c) => c.toLowerCase().contains('hyperthermie') ||
                   c.toLowerCase().contains('maligne'),
          ),
          true,
        );
      });

      test('lists hyperkalemia in contraindications', () {
        expect(
          succinylcholine.contraindications.any(
            (c) => c.toLowerCase().contains('hyperkali'),
          ),
          true,
        );
      });
    });

    group('Rocuronium Data', () {
      late SedationDrug rocuronium;

      setUpAll(() {
        rocuronium = SedationData.allDrugs.firstWhere((d) => d.id == 'rocuronium');
      });

      test('has RSI dose of 1.2 mg/kg', () {
        expect(rocuronium.standardDose, 1.2);
      });

      test('is paralytic role', () {
        expect(rocuronium.role, contains(DrugRole.paralytic));
      });

      test('mentions sugammadex for reversal', () {
        expect(
          rocuronium.notes.any((n) => n.toLowerCase().contains('sugammadex')),
          true,
        );
      });

      test('has longer duration than succinylcholine', () {
        final succ = SedationData.allDrugs.firstWhere((d) => d.id == 'succinylcholine');
        expect(rocuronium.durationMinutes, greaterThan(succ.durationMinutes));
      });
    });

    group('Fentanyl Data', () {
      late SedationDrug fentanyl;

      setUpAll(() {
        fentanyl = SedationData.allDrugs.firstWhere((d) => d.id == 'fentanyl');
      });

      test('has mcg/kg dosing', () {
        expect(fentanyl.doseUnit, 'mcg/kg');
      });

      test('is analgesic role', () {
        expect(fentanyl.role, contains(DrugRole.analgesic));
      });

      test('has max single dose', () {
        expect(fentanyl.maxSingleDose, isNotNull);
        expect(fentanyl.maxSingleDoseUnit, 'mcg');
      });

      test('mentions chest wall rigidity', () {
        expect(
          fentanyl.sideEffects.any((s) => s.toLowerCase().contains('rigidité')),
          true,
        );
      });
    });

    group('Dose Calculations', () {
      test('propofol dose for 70kg adult', () {
        final propofol = SedationData.allDrugs.firstWhere((d) => d.id == 'propofol');
        const weight = 70.0;
        final dose = propofol.standardDose * weight;
        // 1.5 mg/kg * 70 kg = 105 mg
        expect(dose, 105.0);
      });

      test('ketamine dose for 20kg child', () {
        final ketamine = SedationData.allDrugs.firstWhere((d) => d.id == 'ketamine');
        const weight = 20.0;
        final dose = ketamine.standardDose * weight;
        // 1.5 mg/kg * 20 kg = 30 mg
        expect(dose, 30.0);
      });

      test('rocuronium RSI dose for 70kg adult', () {
        final rocuronium = SedationData.allDrugs.firstWhere((d) => d.id == 'rocuronium');
        const weight = 70.0;
        final dose = rocuronium.standardDose * weight;
        // 1.2 mg/kg * 70 kg = 84 mg
        expect(dose, 84.0);
      });

      test('fentanyl dose respects max', () {
        final fentanyl = SedationData.allDrugs.firstWhere((d) => d.id == 'fentanyl');
        const weight = 100.0;
        var dose = fentanyl.standardDose * weight; // 2 mcg/kg * 100 = 200 mcg
        
        // Apply max single dose
        if (fentanyl.maxSingleDose != null && dose > fentanyl.maxSingleDose!) {
          dose = fentanyl.maxSingleDose!;
        }
        expect(dose, lessThanOrEqualTo(fentanyl.maxSingleDose!));
      });
    });

    group('Data Integrity', () {
      test('all drugs have required fields', () {
        for (final drug in SedationData.allDrugs) {
          expect(drug.id, isNotEmpty, reason: 'Drug missing id');
          expect(drug.name, isNotEmpty, reason: '${drug.id} missing name');
          expect(drug.drugClass, isNotEmpty, reason: '${drug.id} missing drugClass');
          expect(drug.role, isNotEmpty, reason: '${drug.id} missing role');
          expect(drug.sedationTypes, isNotEmpty, reason: '${drug.id} missing sedationTypes');
          expect(drug.standardDose, greaterThan(0), reason: '${drug.id} invalid dose');
          expect(drug.doseUnit, isNotEmpty, reason: '${drug.id} missing doseUnit');
          expect(drug.route, isNotEmpty, reason: '${drug.id} missing route');
          expect(drug.onsetSeconds, greaterThan(0), reason: '${drug.id} invalid onset');
          expect(drug.durationMinutes, greaterThan(0), reason: '${drug.id} invalid duration');
          expect(drug.concentrations, isNotEmpty, reason: '${drug.id} missing concentrations');
        }
      });

      test('all drugs have clinical information', () {
        for (final drug in SedationData.allDrugs) {
          expect(drug.mechanism, isNotEmpty, reason: '${drug.id} missing mechanism');
          expect(drug.indications, isNotEmpty, reason: '${drug.id} missing indications');
          expect(drug.sideEffects, isNotEmpty, reason: '${drug.id} missing sideEffects');
        }
      });
    });
  });
}
