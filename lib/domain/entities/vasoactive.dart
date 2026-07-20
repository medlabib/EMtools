import '../../core/l10n/localized.dart';

enum VasoactiveCategory { vasopressor, inotrope, vasodilator, mixed }

class DrugConcentration {
  final String label;
  final double mgPerMl;
  final LString commonPrep;

  const DrugConcentration({
    required this.label,
    required this.mgPerMl,
    required this.commonPrep,
  });
}

class DrugDoseRange {
  final double min;
  final double max;
  final double typical;
  final double step;

  const DrugDoseRange({
    required this.min,
    required this.max,
    required this.typical,
    required this.step,
  });
}

class DrugEffects {
  final String alpha;
  final String beta1;
  final String beta2;
  final String dopaminergic;
  final String vasopressin;

  const DrugEffects({
    this.alpha = 'none',
    this.beta1 = 'none',
    this.beta2 = 'none',
    this.dopaminergic = 'none',
    this.vasopressin = 'none',
  });
}

class VasoactiveDrug {
  final String id;
  final String name;
  final String genericName;
  final VasoactiveCategory category;
  final LString description;
  final List<DrugConcentration> concentrations;
  final int defaultConcentrationIndex;
  final String doseUnit; // 'mcg/kg/min', 'mcg/min', 'mg/h', 'UI/min'
  final DrugDoseRange doseRange;
  final List<LString> indications;
  final DrugEffects effects;
  final List<LString> sideEffects;
  final List<LString> contraindications;
  final List<LString> notes;

  const VasoactiveDrug({
    required this.id,
    required this.name,
    required this.genericName,
    required this.category,
    required this.description,
    required this.concentrations,
    required this.defaultConcentrationIndex,
    required this.doseUnit,
    required this.doseRange,
    required this.indications,
    required this.effects,
    required this.sideEffects,
    required this.contraindications,
    required this.notes,
  });
}
