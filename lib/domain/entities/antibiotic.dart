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
  final String adult;
  final String frequency;
  final String? duration;
  final String? maxDose;

  const DoseInfo({
    required this.adult,
    required this.frequency,
    this.duration,
    this.maxDose,
  });
}

class RenalAdjustment {
  final String gfr; // e.g., "30-59", "<15"
  final String dose;
  final String? notes;

  const RenalAdjustment({
    required this.gfr,
    required this.dose,
    this.notes,
  });
}

class DrugInteraction {
  final String drug;
  final InteractionSeverity severity;
  final String effect;
  final String? recommendation;

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
  final String genericName;
  final AntibioticClass antibioticClass;
  final SpectrumType spectrum;
  final List<String> route; // PO, IV, IM
  
  final DoseInfo standardDose;
  final List<RenalAdjustment> renalAdjustment;
  final String? hepaticAdjustment;
  final String? pediatricDose;
  
  final List<String> indications;
  final List<String> contraindications;
  final List<String> sideEffects;
  final List<DrugInteraction> interactions;
  final List<String>? monitoring;
  final String pregnancyCategory;
  
  final bool availableInTunisia;
  final String? tunisiaPrice;
  final bool requiresPrescription;
  
  final String? notes;

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
    required this.availableInTunisia,
    this.tunisiaPrice,
    required this.requiresPrescription,
    this.notes,
  });
}
