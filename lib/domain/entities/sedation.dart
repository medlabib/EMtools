import '../../core/l10n/localized.dart';

enum SedationType { rsi, procedural, maintenance }
enum DrugRole { induction, paralytic, analgesic, sedative, adjunct }
enum AgeGroup { neonate, infant, child, adult, elderly }

class DoseByAge {
  final AgeGroup ageGroup;
  final String ageRange;
  final double dose;
  final double? maxDose;
  final LString? notes;

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
  final LString drugClass;
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
  final LString mechanism;
  final List<LString> indications;
  final List<LString> advantages;
  final List<LString> sideEffects;
  final List<LString> contraindications;
  final List<LString> precautions;
  
  // Preparation
  final List<LString> concentrations;
  final LString? dilution;
  
  // Special considerations
  final LString? renalAdjustment;
  final LString? hepaticAdjustment;
  final List<LString> notes;

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
