import 'dart:math';

enum Sex { male, female }
enum AgeGroup { child, adult, elderly }
enum SodiumDirection { hypo, hyper }
enum CorrectionMode { acute, chronic }

class IVFluid {
  final String id;
  final String name;
  final double sodiumMeq;
  final double potassiumMeq;
  final String type; // hypotonic, isotonic, hypertonic
  final double osmolality;

  const IVFluid({
    required this.id,
    required this.name,
    required this.sodiumMeq,
    required this.potassiumMeq,
    required this.type,
    required this.osmolality,
  });
}

class DysnatremiaParams {
  final double weight;
  final Sex sex;
  final AgeGroup ageGroup;
  final double baselineNa;
  final double targetNa;
  final SodiumDirection direction;
  final CorrectionMode mode;
  final double urineOutput; // mL/24h
  final double insensibleLoss; // mL/24h
  final IVFluid fluidA;
  final IVFluid fluidB;

  const DysnatremiaParams({
    required this.weight,
    required this.sex,
    required this.ageGroup,
    required this.baselineNa,
    required this.targetNa,
    required this.direction,
    required this.mode,
    required this.urineOutput,
    required this.insensibleLoss,
    required this.fluidA,
    required this.fluidB,
  });
}

class DysnatremiaResult {
  final double tbw;
  final double freeWaterDeficit;
  final double sodiumDeficit;
  final double deltaNa;
  final double ratePerHour;
  final bool isUnsafe;
  final String safetyWarning;
  final int fluidARate; // mL/h
  final int fluidBRate; // mL/h
  final int totalRate; // mL/h
  final double totalVolume24h; // L

  const DysnatremiaResult({
    required this.tbw,
    required this.freeWaterDeficit,
    required this.sodiumDeficit,
    required this.deltaNa,
    required this.ratePerHour,
    required this.isUnsafe,
    required this.safetyWarning,
    required this.fluidARate,
    required this.fluidBRate,
    required this.totalRate,
    required this.totalVolume24h,
  });
}

class ClinicalFinding {
  final String id;
  final String name;
  final double? threshold;
  final String severity;

  const ClinicalFinding({
    required this.id,
    required this.name,
    this.threshold,
    this.severity = 'moderate',
  });
}

class Treatment {
  final String id;
  final String name;
  final String dose;
  final String route;
  final String onset;
  final String duration;
  final String mechanism;
  final String notes;
  final List<String> contraindications;
  final String urgency;

  const Treatment({
    required this.id,
    required this.name,
    required this.dose,
    required this.route,
    this.onset = '',
    this.duration = '',
    this.mechanism = '',
    required this.notes,
    required this.contraindications,
    required this.urgency,
  });
}

class MetabolicCalculator {
  static const List<IVFluid> ivFluids = [
    IVFluid(id: 'd5w', name: 'D5W (0 mEq/L)', sodiumMeq: 0, potassiumMeq: 0, type: 'hypotonique', osmolality: 252),
    IVFluid(id: 'nacl02', name: 'NaCl 0.2% (34 mEq/L)', sodiumMeq: 34, potassiumMeq: 0, type: 'hypotonique', osmolality: 68),
    IVFluid(id: 'nacl045', name: 'NaCl 0.45% (77 mEq/L)', sodiumMeq: 77, potassiumMeq: 0, type: 'hypotonique', osmolality: 154),
    IVFluid(id: 'lr', name: 'Ringer Lactate (130 mEq/L)', sodiumMeq: 130, potassiumMeq: 4, type: 'isotonique', osmolality: 273),
    IVFluid(id: 'ns', name: 'NaCl 0.9% (154 mEq/L)', sodiumMeq: 154, potassiumMeq: 0, type: 'isotonique', osmolality: 308),
    IVFluid(id: 'nacl3', name: 'NaCl 3% (513 mEq/L)', sodiumMeq: 513, potassiumMeq: 0, type: 'hypertonique', osmolality: 1026),
  ];

  static const List<ClinicalFinding> hyperkalemiaECG = [
    ClinicalFinding(id: 'peaked_t', name: 'Ondes T pointues', threshold: 5.5),
    ClinicalFinding(id: 'flat_p', name: 'Ondes P aplaties', threshold: 6.5),
    ClinicalFinding(id: 'prolonged_pr', name: 'PR allongé', threshold: 6.5),
    ClinicalFinding(id: 'wide_qrs', name: 'QRS élargi', threshold: 7.0),
    ClinicalFinding(id: 'sine_wave', name: 'Onde sinusoïdale', threshold: 8.0),
    ClinicalFinding(id: 'vfib', name: 'FV/Arrêt cardiaque', threshold: 8.5),
  ];

  static const List<Treatment> hyperkalemiaTreatments = [
    Treatment(
      id: 'calcium_gluconate',
      name: 'Gluconate de Calcium 10%',
      dose: '10-20 mL (1-2g) IV en 2-3 min',
      route: 'IV',
      onset: '1-3 min',
      duration: '30-60 min',
      mechanism: 'Cardioprotection',
      notes: 'Première ligne si anomalies ECG. Stabilise la membrane cardiaque. Ne diminue PAS le K+. Peut être répété si persistance des anomalies ECG.',
      contraindications: ['Intoxication digitalique (relatif - injecter lentement)'],
      urgency: 'immediate',
    ),
    Treatment(
      id: 'insulin_glucose',
      name: 'Insuline Rapide + Glucose',
      dose: '10 UI Insuline Rapide IV + 25g Glucose',
      route: 'IV',
      onset: '15-30 min',
      duration: '4-6 heures',
      mechanism: 'Transfert intracellulaire',
      notes: 'Traitement de transfert le plus efficace. Baisse attendue 0.5-1.2 mEq/L. Surveiller glycémie toutes les h pendant 4h.',
      contraindications: [],
      urgency: 'urgent',
    ),
    Treatment(
      id: 'salbutamol',
      name: 'Salbutamol Nébulisé',
      dose: '10-20 mg nébulisé sur 10-15 min',
      route: 'Nébulisation',
      onset: '15-30 min',
      duration: '2-4 heures',
      mechanism: 'Transfert intracellulaire',
      notes: 'Effet additif avec l\'insuline. Baisse attendue 0.5-1.0 mEq/L. Doses plus élevées que pour le bronchospasme.',
      contraindications: ['Coronaropathie sévère', 'Tachyarythmies'],
      urgency: 'urgent',
    ),
  ];

  static double calculateCorrectedCalcium(double totalCalcium, double albumin) {
    // Formula: Corrected Ca = Measured Ca + 0.8 * (4.0 - Albumin)
    // Assuming Ca in mg/dL and Albumin in g/dL
    if (albumin >= 4.0) return totalCalcium;
    return totalCalcium + 0.8 * (4.0 - albumin);
  }

  static double calculateTBW(double weight, Sex sex, AgeGroup ageGroup) {
    double factor = 0.6;
    if (ageGroup == AgeGroup.child) {
      factor = 0.6;
    } else if (ageGroup == AgeGroup.elderly) {
      factor = sex == Sex.male ? 0.5 : 0.45;
    } else {
      factor = sex == Sex.male ? 0.6 : 0.5;
    }
    return weight * factor;
  }

  static double calculateFreeWaterDeficit(double tbw, double currentNa, double targetNa) {
    return tbw * ((currentNa / targetNa) - 1);
  }

  static double calculateSodiumDeficit(double tbw, double currentNa, double targetNa) {
    return tbw * (targetNa - currentNa);
  }

  static DysnatremiaResult calculateDysnatremiaCorrection(DysnatremiaParams params) {
    final tbw = calculateTBW(params.weight, params.sex, params.ageGroup);
    final deltaNa = params.targetNa - params.baselineNa;
    final ratePerHour = deltaNa / 24;
    final absRate = ratePerHour.abs();

    // Deficits
    final freeWaterDeficit = params.direction == SodiumDirection.hyper
        ? calculateFreeWaterDeficit(tbw, params.baselineNa, params.targetNa)
        : 0.0;
    
    final sodiumDeficit = params.direction == SodiumDirection.hypo
        ? calculateSodiumDeficit(tbw, params.baselineNa, params.targetNa)
        : 0.0;

    // Safety Check
    bool isUnsafe = false;
    String safetyWarning = '';

    if (params.direction == SodiumDirection.hyper) {
      final maxRate = params.mode == CorrectionMode.acute ? 1.0 : 0.5;
      if (absRate > maxRate) {
        isUnsafe = true;
        safetyWarning = params.mode == CorrectionMode.acute
            ? '⚠️ Vitesse > $maxRate mEq/L/h (limite aiguë)'
            : '⚠️ Vitesse > $maxRate mEq/L/h - Risque d\'œdème cérébral';
      }
    } else {
      final maxRate = params.mode == CorrectionMode.acute ? 1.5 : 0.33; // 0.33 is approx 8/24h
      if (absRate > maxRate) {
        isUnsafe = true;
        safetyWarning = params.mode == CorrectionMode.acute
            ? '⚠️ Vitesse > $maxRate mEq/L/h (limite aiguë)'
            : '🚨 RISQUE ODS: Vitesse > 8 mEq/L/jour';
      }
    }

    // Fluid Mix Calculation
    final totalLosses = (params.urineOutput + params.insensibleLoss) / 1000; // L
    
    double totalVolumeConstraint = totalLosses;
    if (params.direction == SodiumDirection.hyper) {
      totalVolumeConstraint += max(0, freeWaterDeficit);
    }

    // Required Mix Na
    final requiredMixNa = (params.targetNa * (tbw + totalVolumeConstraint - totalLosses) - (tbw * params.baselineNa)) / totalVolumeConstraint;

    double volA = 0;
    double volB = 0;
    final fluidANa = params.fluidA.sodiumMeq;
    final fluidBNa = params.fluidB.sodiumMeq;

    if ((fluidANa - fluidBNa).abs() < 1) {
      volA = totalVolumeConstraint;
    } else {
      volA = totalVolumeConstraint * (requiredMixNa - fluidBNa) / (fluidANa - fluidBNa);
      volB = totalVolumeConstraint - volA;
    }

    // Bounds correction
    if (volA < 0) { volA = 0; volB = totalVolumeConstraint; }
    if (volB < 0) { volB = 0; volA = totalVolumeConstraint; }

    final fluidARate = (volA * 1000 / 24).round();
    final fluidBRate = (volB * 1000 / 24).round();
    final totalRate = fluidARate + fluidBRate;

    return DysnatremiaResult(
      tbw: tbw,
      freeWaterDeficit: freeWaterDeficit,
      sodiumDeficit: sodiumDeficit,
      deltaNa: deltaNa,
      ratePerHour: ratePerHour,
      isUnsafe: isUnsafe,
      safetyWarning: safetyWarning,
      fluidARate: fluidARate,
      fluidBRate: fluidBRate,
      totalRate: totalRate,
      totalVolume24h: totalVolumeConstraint,
    );
  }
}
