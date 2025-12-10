enum SedationType { rsi, procedural, maintenance }
enum DrugRole { induction, paralytic, analgesic, sedative, adjunct }
enum AgeGroup { neonate, infant, child, adult, elderly }

class DoseByAge {
  final AgeGroup ageGroup;
  final String ageRange;
  final double dose;
  final double? maxDose;
  final String? notes;

  const DoseByAge({
    required this.ageGroup,
    required this.ageRange,
    required this.dose,
    this.maxDose,
    this.notes,
  });
}

class SedationDrug {
  final String id;
  final String name;
  final String genericName;
  final String drugClass;
  final List<DrugRole> role;
  final List<SedationType> sedationTypes;
  
  // Dosing
  final double standardDose;
  final String doseUnit;
  final List<String> route;
  final List<DoseByAge> dosesByAge;
  final double? maxSingleDose;
  final String? maxSingleDoseUnit;
  
  // Timing
  final int onsetSeconds;
  final int durationMinutes;
  
  // Clinical info
  final String mechanism;
  final List<String> indications;
  final List<String> advantages;
  final List<String> sideEffects;
  final List<String> contraindications;
  final List<String> precautions;
  
  // Preparation
  final List<String> concentrations;
  final String? dilution;
  
  // Special considerations
  final String? renalAdjustment;
  final String? hepaticAdjustment;
  final List<String> notes;

  const SedationDrug({
    required this.id,
    required this.name,
    required this.genericName,
    required this.drugClass,
    required this.role,
    required this.sedationTypes,
    required this.standardDose,
    required this.doseUnit,
    required this.route,
    this.dosesByAge = const [],
    this.maxSingleDose,
    this.maxSingleDoseUnit,
    required this.onsetSeconds,
    required this.durationMinutes,
    required this.mechanism,
    required this.indications,
    required this.advantages,
    required this.sideEffects,
    required this.contraindications,
    required this.precautions,
    required this.concentrations,
    this.dilution,
    this.renalAdjustment,
    this.hepaticAdjustment,
    required this.notes,
  });
}
