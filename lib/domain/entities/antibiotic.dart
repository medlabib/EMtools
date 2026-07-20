import '../../core/l10n/localized.dart';

enum AntibioticClass {
  penicillin,
  cephalosporin,
  carbapenem,
  fluoroquinolone,
  macrolide,
  aminoglycoside,
  tetracycline,
  glycopeptide,
  nitroimidazole,
  sulfonamide,
  oxazolidinone,
  lipopeptide,
  lincosamide,
  monobactam,
  other
}

enum SpectrumType {
  narrow,
  broad,
  gramPositive,
  gramNegative,
  anaerobic,
  atypical
}

enum InteractionSeverity {
  major,
  moderate,
  minor
}

class DoseInfo {
  /// Numeric/neutral dose expression (e.g. "1g", "15-20 mg/kg").
  final String adult;
  final LString frequency;
  final LString? duration;
  final LString? maxDose;

  const DoseInfo({
    required this.adult,
    required this.frequency,
    this.duration,
    this.maxDose,
  });
}

class RenalAdjustment {
  /// GFR band used for matching (e.g. "30-59", "<15"); kept language-neutral.
  final String gfr;
  final LString dose;
  final LString? notes;

  const RenalAdjustment({
    required this.gfr,
    required this.dose,
    this.notes,
  });
}

class DrugInteraction {
  /// Interacting drug/class name (kept as a single identifier string).
  final String drug;
  final InteractionSeverity severity;
  final LString effect;
  final LString? recommendation;

  const DrugInteraction({
    required this.drug,
    required this.severity,
    required this.effect,
    this.recommendation,
  });
}

class Antibiotic {
  final String id;
  final String name;
  final LString genericName;
  final AntibioticClass antibioticClass;
  final SpectrumType spectrum;
  final List<String> route; // PO, IV, IM

  final DoseInfo standardDose;
  final List<RenalAdjustment> renalAdjustment;
  final LString? hepaticAdjustment;
  final LString? pediatricDose;

  final List<LString> indications;
  final List<LString> contraindications;
  final List<LString> sideEffects;
  final List<DrugInteraction> interactions;
  final List<LString>? monitoring;
  final String pregnancyCategory;

  final bool requiresPrescription;

  final LString? notes;

  const Antibiotic({
    required this.id,
    required this.name,
    required this.genericName,
    required this.antibioticClass,
    required this.spectrum,
    required this.route,
    required this.standardDose,
    required this.renalAdjustment,
    this.hepaticAdjustment,
    this.pediatricDose,
    required this.indications,
    required this.contraindications,
    required this.sideEffects,
    required this.interactions,
    this.monitoring,
    required this.pregnancyCategory,
    required this.requiresPrescription,
    this.notes,
  });
}
