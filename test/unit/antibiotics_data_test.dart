import 'package:flutter_test/flutter_test.dart';
import 'package:emtools/data/datasources/antibiotics_data.dart';
import 'package:emtools/domain/entities/antibiotic.dart';
import 'package:emtools/core/l10n/localized.dart';

void main() {
  group('Antibiotics Data', () {
    test('allAntibiotics should not be empty', () {
      expect(allAntibiotics, isNotEmpty);
    });

    test('each antibiotic should have required fields', () {
      for (final ab in allAntibiotics) {
        expect(ab.id, isNotEmpty, reason: 'Antibiotic should have id');
        expect(ab.name, isNotEmpty, reason: 'Antibiotic ${ab.id} should have name');
        expect(ab.genericName.fr, isNotEmpty, reason: 'Antibiotic ${ab.id} should have genericName');
        expect(ab.route, isNotEmpty, reason: 'Antibiotic ${ab.id} should have route');
        expect(ab.indications, isNotEmpty, reason: 'Antibiotic ${ab.id} should have indications');
        expect(ab.contraindications, isNotEmpty, reason: 'Antibiotic ${ab.id} should have contraindications');
        expect(ab.pregnancyCategory, isNotEmpty, reason: 'Antibiotic ${ab.id} should have pregnancyCategory');
      }
    });

    test('each antibiotic should have valid dose info', () {
      for (final ab in allAntibiotics) {
        expect(ab.standardDose.adult, isNotEmpty,
            reason: 'Antibiotic ${ab.id} should have adult dose');
        expect(ab.standardDose.frequency.fr, isNotEmpty,
            reason: 'Antibiotic ${ab.id} should have frequency');
      }
    });

    test('each antibiotic should have valid route', () {
      // Routes can have additional notes like "PO (C. diff)"
      final validRoutePatterns = ['PO', 'IV', 'IM', 'SC', 'Topique', 'Inhalation'];
      for (final ab in allAntibiotics) {
        for (final route in ab.route) {
          // Check if route starts with a valid route pattern
          final isValid = validRoutePatterns.any((pattern) => route.startsWith(pattern));
          expect(isValid, isTrue,
              reason: 'Antibiotic ${ab.id} has invalid route: $route');
        }
      }
    });
  });

  group('Antibiotic Classes', () {
    test('should have penicillins', () {
      final penicillins = allAntibiotics
          .where((ab) => ab.antibioticClass == AntibioticClass.penicillin);
      expect(penicillins, isNotEmpty);
    });

    test('should have cephalosporins', () {
      final cephalos = allAntibiotics
          .where((ab) => ab.antibioticClass == AntibioticClass.cephalosporin);
      expect(cephalos, isNotEmpty);
    });

    test('should have fluoroquinolones', () {
      final fluoros = allAntibiotics
          .where((ab) => ab.antibioticClass == AntibioticClass.fluoroquinolone);
      expect(fluoros, isNotEmpty);
    });

    test('should have macrolides', () {
      final macrolides = allAntibiotics
          .where((ab) => ab.antibioticClass == AntibioticClass.macrolide);
      expect(macrolides, isNotEmpty);
    });
  });

  group('Common Antibiotics', () {
    test('amoxicillin should exist', () {
      final amox = allAntibiotics.where((ab) => ab.id == 'amoxicillin');
      expect(amox, isNotEmpty);
      final drug = amox.first;
      expect(drug.genericName.fr, contains('Amoxicilline'));
      expect(drug.antibioticClass, AntibioticClass.penicillin);
    });

    test('amoxicillin-clavulanate should exist', () {
      final augmentin = allAntibiotics
          .where((ab) => ab.id == 'amoxicillin-clavulanate');
      expect(augmentin, isNotEmpty);
      final drug = augmentin.first;
      expect(drug.name, contains('Augmentin'));
    });
  });

  group('Renal Adjustments', () {
    test('antibiotics with renal adjustment should have valid GFR ranges', () {
      for (final ab in allAntibiotics) {
        for (final adj in ab.renalAdjustment) {
          expect(adj.gfr, isNotEmpty,
              reason: 'Renal adjustment for ${ab.id} should have GFR range');
          expect(adj.dose.fr, isNotEmpty,
              reason: 'Renal adjustment for ${ab.id} should have dose');
        }
      }
    });

    test('aminoglycosides should have renal adjustment', () {
      final aminoglycosides = allAntibiotics
          .where((ab) => ab.antibioticClass == AntibioticClass.aminoglycoside);
      for (final ab in aminoglycosides) {
        expect(ab.renalAdjustment, isNotEmpty,
            reason: 'Aminoglycoside ${ab.id} should have renal adjustment');
      }
    });
  });

  group('Drug Interactions', () {
    test('interactions should have valid severity', () {
      for (final ab in allAntibiotics) {
        for (final interaction in ab.interactions) {
          expect(interaction.drug, isNotEmpty,
              reason: 'Interaction for ${ab.id} should have drug name');
          expect(interaction.effect.fr, isNotEmpty,
              reason: 'Interaction for ${ab.id} should have effect');
          expect(interaction.severity, isNotNull,
              reason: 'Interaction for ${ab.id} should have severity');
        }
      }
    });
  });

  group('Pregnancy Categories', () {
    test('pregnancy categories should be valid', () {
      final validCategories = ['A', 'B', 'C', 'D', 'X'];
      for (final ab in allAntibiotics) {
        expect(validCategories, contains(ab.pregnancyCategory),
            reason: 'Antibiotic ${ab.id} has invalid pregnancy category: ${ab.pregnancyCategory}');
      }
    });
  });

  group('Spectrum Types', () {
    test('should have broad spectrum antibiotics', () {
      final broad = allAntibiotics.where((ab) => ab.spectrum == SpectrumType.broad);
      expect(broad, isNotEmpty);
    });

    test('should have narrow spectrum antibiotics', () {
      final narrow = allAntibiotics.where((ab) => ab.spectrum == SpectrumType.narrow);
      expect(narrow, isNotEmpty);
    });
  });

  group('DoseInfo', () {
    test('should store values correctly', () {
      const dose = DoseInfo(
        adult: '1g',
        frequency: LString('q8h', 'q8h'),
        duration: LString('7 jours', '7 days'),
        maxDose: LString('4g/jour', '4g/day'),
      );
      expect(dose.adult, '1g');
      expect(dose.frequency.fr, 'q8h');
      expect(dose.duration!.en, '7 days');
      expect(dose.maxDose!.en, '4g/day');
    });
  });

  group('RenalAdjustment', () {
    test('should store values correctly', () {
      const adj = RenalAdjustment(
        gfr: '10-30',
        dose: LString('500mg q12h', '500mg q12h'),
        notes: LString('Surveiller', 'Monitor closely'),
      );
      expect(adj.gfr, '10-30');
      expect(adj.dose.fr, '500mg q12h');
      expect(adj.notes!.en, 'Monitor closely');
    });
  });

  group('DrugInteraction', () {
    test('should store values correctly', () {
      const interaction = DrugInteraction(
        drug: 'Warfarin',
        severity: InteractionSeverity.major,
        effect: LString('INR augmenté', 'Increased INR'),
        recommendation: LString('Surveiller l\'INR', 'Monitor INR closely'),
      );
      expect(interaction.drug, 'Warfarin');
      expect(interaction.severity, InteractionSeverity.major);
      expect(interaction.effect.en, 'Increased INR');
      expect(interaction.recommendation!.en, 'Monitor INR closely');
    });
  });
}
