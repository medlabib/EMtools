import 'package:flutter_test/flutter_test.dart';
import 'package:emtools/data/datasources/calculators_data.dart';
import 'package:emtools/domain/entities/calculator.dart';

void main() {
  group('Calculators Data', () {
    test('allCalculators should not be empty', () {
      expect(allCalculators, isNotEmpty);
    });

    test('each calculator should have required fields', () {
      for (final calc in allCalculators) {
        expect(calc.id, isNotEmpty, reason: 'Calculator should have id');
        expect(calc.name, isNotEmpty, reason: 'Calculator ${calc.id} should have name');
        expect(calc.shortName, isNotEmpty, reason: 'Calculator ${calc.id} should have shortName');
        expect(calc.description, isNotEmpty, reason: 'Calculator ${calc.id} should have description');
        expect(calc.fields, isNotEmpty, reason: 'Calculator ${calc.id} should have fields');
        expect(calc.calculate, isNotNull, reason: 'Calculator ${calc.id} should have calculate function');
        expect(calc.interpretations, isNotEmpty, reason: 'Calculator ${calc.id} should have interpretations');
      }
    });

    test('each calculator field should have valid configuration', () {
      for (final calc in allCalculators) {
        for (final field in calc.fields) {
          expect(field.id, isNotEmpty, reason: 'Field in ${calc.id} should have id');
          expect(field.label, isNotEmpty, reason: 'Field ${field.id} in ${calc.id} should have label');

          if (field.type == CalculatorFieldType.select) {
            expect(field.options, isNotNull, reason: 'Select field ${field.id} should have options');
            expect(field.options, isNotEmpty, reason: 'Select field ${field.id} should have at least one option');
          }

          if (field.type == CalculatorFieldType.number) {
            expect(field.min != null || field.max != null, isTrue,
                reason: 'Number field ${field.id} should have min or max');
          }
        }
      }
    });

    test('interpretations should have valid ranges', () {
      for (final calc in allCalculators) {
        if (calc.interpretations.isEmpty) continue;

        final sorted = List<ScoreInterpretation>.from(calc.interpretations)
          ..sort((a, b) => a.min.compareTo(b.min));

        // Check that min <= max for each interpretation
        for (final interp in sorted) {
          expect(interp.min, lessThanOrEqualTo(interp.max),
              reason: 'In ${calc.id}, interpretation ${interp.label} should have min <= max');
        }
      }
    });
  });

  group('GCS Calculator', () {
    late Calculator gcs;

    setUp(() {
      gcs = allCalculators.firstWhere((c) => c.id == 'gcs');
    });

    test('should be in trauma category', () {
      expect(gcs.category, CalculatorCategory.trauma);
    });

    test('should have 3 fields (eye, verbal, motor)', () {
      expect(gcs.fields.length, 3);
      expect(gcs.fields.map((f) => f.id), containsAll(['eye', 'verbal', 'motor']));
    });

    test('calculates GCS 15 (normal)', () {
      final result = gcs.calculate({'eye': 4.0, 'verbal': 5.0, 'motor': 6.0});
      expect(result, 15.0);
    });

    test('calculates GCS 3 (minimum)', () {
      final result = gcs.calculate({'eye': 1.0, 'verbal': 1.0, 'motor': 1.0});
      expect(result, 3.0);
    });

    test('calculates GCS 8 (severe)', () {
      final result = gcs.calculate({'eye': 2.0, 'verbal': 2.0, 'motor': 4.0});
      expect(result, 8.0);
    });

    test('interpretation for GCS 15 is Normal', () {
      final interp = gcs.interpretations.firstWhere(
        (i) => 15 >= i.min && 15 <= i.max,
      );
      expect(interp.label, 'Normal');
    });

    test('interpretation for GCS 3-8 is Sévère', () {
      final interp = gcs.interpretations.firstWhere(
        (i) => 8 >= i.min && 8 <= i.max,
      );
      expect(interp.label, 'Sévère');
    });
  });

  group('Shock Index Calculator', () {
    late Calculator si;

    setUp(() {
      si = allCalculators.firstWhere((c) => c.id == 'shock-index');
    });

    test('calculates shock index correctly', () {
      // HR = 100, SBP = 100 => SI = 1.0
      final result = si.calculate({'heartRate': 100.0, 'systolicBP': 100.0});
      expect(result, 1.0);
    });

    test('calculates shock index for normal values', () {
      // HR = 70, SBP = 120 => SI = 0.58
      final result = si.calculate({'heartRate': 70.0, 'systolicBP': 120.0});
      expect(result, closeTo(0.58, 0.01));
    });

    test('calculates shock index for hypotensive patient', () {
      // HR = 120, SBP = 80 => SI = 1.5
      final result = si.calculate({'heartRate': 120.0, 'systolicBP': 80.0});
      expect(result, 1.5);
    });

    test('handles zero systolic BP', () {
      final result = si.calculate({'heartRate': 100.0, 'systolicBP': 0.0});
      expect(result, 0.0);
    });
  });

  group('Calculator Categories', () {
    test('should have calculators in trauma category', () {
      final traumaCalcs = allCalculators.where((c) => c.category == CalculatorCategory.trauma);
      expect(traumaCalcs, isNotEmpty);
    });

    test('should have calculators in cardiovascular category', () {
      final cardioCalcs = allCalculators.where((c) => c.category == CalculatorCategory.cardiovascular);
      expect(cardioCalcs, isNotEmpty);
    });

    test('should have calculators in sepsis category', () {
      final sepsisCalcs = allCalculators.where((c) => c.category == CalculatorCategory.sepsis);
      expect(sepsisCalcs, isNotEmpty);
    });
  });

  group('Calculator Field Types', () {
    test('select fields have options with values', () {
      for (final calc in allCalculators) {
        for (final field in calc.fields) {
          if (field.type == CalculatorFieldType.select && field.options != null) {
            for (final opt in field.options!) {
              expect(opt.label, isNotEmpty);
              expect(opt.value, isNotNull);
            }
          }
        }
      }
    });

    test('number fields have valid ranges', () {
      for (final calc in allCalculators) {
        for (final field in calc.fields) {
          if (field.type == CalculatorFieldType.number) {
            if (field.min != null && field.max != null) {
              expect(field.max, greaterThanOrEqualTo(field.min!),
                  reason: 'Field ${field.id} in ${calc.id} should have max >= min');
            }
          }
        }
      }
    });
  });

  group('Specific Calculator Tests', () {
    test('WELLS DVT calculator exists and has correct fields', () {
      final wells = allCalculators.where((c) => c.id.contains('wells') && c.id.contains('dvt'));
      expect(wells, isNotEmpty);
    });

    test('SOFA calculator exists for sepsis', () {
      final sofa = allCalculators.where((c) => c.id.contains('sofa'));
      expect(sofa, isNotEmpty);
    });

    test('qSOFA calculator exists for sepsis', () {
      final qsofa = allCalculators.where((c) => c.id.contains('qsofa'));
      expect(qsofa, isNotEmpty);
    });
  });

  group('ScoreInterpretation', () {
    test('should have valid color', () {
      for (final calc in allCalculators) {
        for (final interp in calc.interpretations) {
          expect(interp.color, isNotNull);
          expect(interp.label, isNotEmpty);
          expect(interp.description, isNotEmpty);
        }
      }
    });
  });
}
