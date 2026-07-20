import 'dart:math';
import '../../core/l10n/localized.dart';

enum Sex { male, female }
enum AgeGroup { child, adult, elderly }
enum SodiumDirection { hypo, hyper }
enum CorrectionMode { acute, chronic }

class IVFluid {
  final String id;
  final LString name;
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
  final LString safetyWarning;
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
  final LString name;
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
  final LString name;
  final LString dose;
  final LString route;
  final LString onset;
  final LString duration;
  final LString mechanism;
  final LString notes;
  final List<LString> contraindications;
  final String urgency;

  const Treatment({
    required this.id,
    required this.name,
    required this.dose,
    required this.route,
    this.onset = LString.empty,
    this.duration = LString.empty,
    this.mechanism = LString.empty,
    required this.notes,
    required this.contraindications,
    required this.urgency,
  });
}

class MetabolicCalculator {
  static const List<IVFluid> ivFluids = [
    IVFluid(id: 'd5w', name: LString('D5W (0 mEq/L)', 'D5W (0 mEq/L)'), sodiumMeq: 0, potassiumMeq: 0, type: 'hypotonique', osmolality: 252),
    IVFluid(id: 'nacl02', name: LString('NaCl 0.2% (34 mEq/L)', 'NaCl 0.2% (34 mEq/L)'), sodiumMeq: 34, potassiumMeq: 0, type: 'hypotonique', osmolality: 68),
    IVFluid(id: 'nacl045', name: LString('NaCl 0.45% (77 mEq/L)', 'NaCl 0.45% (77 mEq/L)'), sodiumMeq: 77, potassiumMeq: 0, type: 'hypotonique', osmolality: 154),
    IVFluid(id: 'lr', name: LString('Ringer Lactate (130 mEq/L)', 'Lactated Ringer (130 mEq/L)'), sodiumMeq: 130, potassiumMeq: 4, type: 'isotonique', osmolality: 273),
    IVFluid(id: 'ns', name: LString('NaCl 0.9% (154 mEq/L)', 'NaCl 0.9% (154 mEq/L)'), sodiumMeq: 154, potassiumMeq: 0, type: 'isotonique', osmolality: 308),
    IVFluid(id: 'nacl3', name: LString('NaCl 3% (513 mEq/L)', 'NaCl 3% (513 mEq/L)'), sodiumMeq: 513, potassiumMeq: 0, type: 'hypertonique', osmolality: 1026),
  ];

  static const List<ClinicalFinding> hyperkalemiaECG = [
    ClinicalFinding(id: 'peaked_t', name: LString('Ondes T pointues', 'Peaked T waves'), threshold: 5.5),
    ClinicalFinding(id: 'flat_p', name: LString('Ondes P aplaties', 'Flattened P waves'), threshold: 6.5),
    ClinicalFinding(id: 'prolonged_pr', name: LString('PR allongé', 'Prolonged PR interval'), threshold: 6.5),
    ClinicalFinding(id: 'wide_qrs', name: LString('QRS élargi', 'Widened QRS'), threshold: 7.0),
    ClinicalFinding(id: 'sine_wave', name: LString('Onde sinusoïdale', 'Sine wave pattern'), threshold: 8.0),
    ClinicalFinding(id: 'vfib', name: LString('FV/Arrêt cardiaque', 'VF/Cardiac arrest'), threshold: 8.5),
  ];

  static const List<Treatment> hyperkalemiaTreatments = [
    Treatment(
      id: 'calcium_gluconate',
      name: LString('Gluconate de Calcium 10%', 'Calcium Gluconate 10%'),
      dose: LString('10-20 mL (1-2g) IV en 2-3 min', '10-20 mL (1-2 g) IV over 2-3 min'),
      route: LString('IV', 'IV'),
      onset: LString('1-3 min', '1-3 min'),
      duration: LString('30-60 min', '30-60 min'),
      mechanism: LString('Cardioprotection', 'Cardioprotection'),
      notes: LString('Première ligne si anomalies ECG. Stabilise la membrane cardiaque. Ne diminue PAS le K+. Peut être répété si persistance des anomalies ECG.', 'First-line if ECG changes. Stabilizes cardiac membrane. Does NOT lower K+. May repeat if ECG changes persist.'),
      contraindications: [LString('Intoxication digitalique (relatif — injecter lentement)', 'Digoxin toxicity (relative — inject slowly)')],
      urgency: 'immediate',
    ),
    Treatment(
      id: 'insulin_glucose',
      name: LString('Insuline Rapide + Glucose', 'Regular Insulin + Glucose'),
      dose: LString('10 UI Insuline Rapide IV + 25g Glucose', '10 U Regular Insulin IV + 25 g Glucose'),
      route: LString('IV', 'IV'),
      onset: LString('15-30 min', '15-30 min'),
      duration: LString('4-6 heures', '4-6 hours'),
      mechanism: LString('Transfert intracellulaire', 'Intracellular shift'),
      notes: LString('Traitement de transfert le plus efficace. Baisse attendue 0.5-1.2 mEq/L. Surveiller glycémie toutes les h pendant 4h.', 'Most effective shift therapy. Expected drop 0.5-1.2 mEq/L. Check glucose q1h × 4h.'),
      contraindications: [],
      urgency: 'urgent',
    ),
    Treatment(
      id: 'salbutamol',
      name: LString('Salbutamol Nébulisé', 'Nebulized Salbutamol'),
      dose: LString('10-20 mg nébulisé sur 10-15 min', '10-20 mg nebulized over 10-15 min'),
      route: LString('Nébulisation', 'Nebulization'),
      onset: LString('15-30 min', '15-30 min'),
      duration: LString('2-4 heures', '2-4 hours'),
      mechanism: LString('Transfert intracellulaire', 'Intracellular shift'),
      notes: LString('Effet additif avec l\'insuline. Baisse attendue 0.5-1.0 mEq/L. Doses plus élevées que pour le bronchospasme.', 'Additive with insulin. Expected drop 0.5-1.0 mEq/L. Higher doses than for bronchospasm.'),
      contraindications: [LString('Coronaropathie sévère', 'Severe CAD'), LString('Tachyarythmies', 'Tachyarrhythmias')],
      urgency: 'urgent',
    ),
    Treatment(
      id: 'sodium_bicarbonate',
      name: LString('Bicarbonate de Sodium 8.4%', 'Sodium Bicarbonate 8.4%'),
      dose: LString('50-100 mL (50-100 mEq) IV sur 5-10 min', '50-100 mL (50-100 mEq) IV over 5-10 min'),
      route: LString('IV', 'IV'),
      onset: LString('15-30 min', '15-30 min'),
      duration: LString('1-2 heures', '1-2 hours'),
      mechanism: LString('Transfert intracellulaire', 'Intracellular shift'),
      notes: LString('Surtout efficace si acidose métabolique concomitante (pH < 7.2). Effet modeste seul. Baisse attendue 0.3-0.5 mEq/L. Précipite avec le calcium — rincer la tubulure. [KDIGO 2024]', 'Most effective with concomitant metabolic acidosis (pH < 7.2). Modest effect alone. Expected drop 0.3-0.5 mEq/L. Precipitates with calcium — flush line. [KDIGO 2024]'),
      contraindications: [LString('Alcalose métabolique', 'Metabolic alkalosis'), LString('Surcharge volémique', 'Volume overload')],
      urgency: 'urgent',
    ),
    Treatment(
      id: 'furosemide',
      name: LString('Furosémide (Diurétique de l\'anse)', 'Furosemide (Loop Diuretic)'),
      dose: LString('40-80 mg IV; peut répéter ou perfusion continue', '40-80 mg IV; may repeat or continuous infusion'),
      route: LString('IV', 'IV'),
      onset: LString('30-60 min', '30-60 min'),
      duration: LString('4-6 heures', '4-6 hours'),
      mechanism: LString('Élimination rénale du K+', 'Renal K+ elimination'),
      notes: LString('Nécessite une fonction rénale résiduelle. Associer à du NaCl 0.9% si hypovolémie. Effet retardé — NON pour urgence immédiate. [KDIGO 2024]', 'Requires residual renal function. Combine with 0.9% NaCl if hypovolemic. Delayed effect — NOT for immediate emergency. [KDIGO 2024]'),
      contraindications: [LString('Anurie', 'Anuria'), LString('Hypovolémie non corrigée', 'Uncorrected hypovolemia')],
      urgency: 'adjunct',
    ),
    Treatment(
      id: 'k_binder',
      name: LString('Chélateur du K+ (SZC/Patriromer)', 'K+ Binder (SZC/Patiromer)'),
      dose: LString('SZC: 10g ×3/j PO; Patiromer: 8.4g/j PO', 'SZC: 10 g TID PO; Patiromer: 8.4 g/d PO'),
      route: LString('PO', 'PO'),
      onset: LString('1-4 heures (SZC)', '1-4 hours (SZC)'),
      duration: LString('12-24 heures', '12-24 hours'),
      mechanism: LString('Fixation intestinale du K+', 'GI K+ binding'),
      notes: LString('Délai d\'action >1h — PAS pour urgence immédiate. Utile pour contrôle à moyen terme et prévention des rebonds. SZC plus rapide que Patiromer. Éviter Kayexalate/SPS (risque de nécrose intestinale, inefficacité) sauf si aucune alternative. [KDIGO 2024, expert consensus]', 'Onset >1h — NOT for immediate emergency. Useful for medium-term control and rebound prevention. SZC faster than Patiromer. Avoid Kayexalate/SPS (risk of intestinal necrosis, inefficacy) unless no alternative. [KDIGO 2024, expert consensus]'),
      contraindications: [LString('Occlusion intestinale', 'Bowel obstruction'), LString('Post-chirurgie digestive récente', 'Recent GI surgery')],
      urgency: 'adjunct',
    ),
    Treatment(
      id: 'dialysis',
      name: LString('Hémodialyse', 'Hemodialysis'),
      dose: LString('Dialyse urgente (bain sans K+ ou K+ 1-2 mEq/L)', 'Urgent dialysis (K+-free or K+ 1-2 mEq/L bath)'),
      route: LString('Voie vasculaire (cathéter de dialyse)', 'Vascular access (dialysis catheter)'),
      onset: LString('Immédiat (dès connexion)', 'Immediate (upon connection)'),
      duration: LString('2-4 heures (séance)', '2-4 hours (session)'),
      mechanism: LString('Épuration extracorporelle', 'Extracorporeal removal'),
      notes: LString('Traitement définitif de l\'hyperK sévère réfractaire. Indication: K+ > 6.5 avec anomalies ECG persistantes malgré traitement médical, ou K+ > 7.0. Rebond possible en post-dialyse — surveiller K+ à 1h, 2h, 4h. [KDIGO 2024]', 'Definitive treatment for severe refractory hyperK. Indication: K+ > 6.5 with persistent ECG changes despite medical therapy, or K+ > 7.0. Rebound possible post-dialysis — check K+ at 1h, 2h, 4h. [KDIGO 2024]'),
      contraindications: [LString('Instabilité hémodynamique (relative)', 'Hemodynamic instability (relative)')],
      urgency: 'definitive',
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

    // Safety Check — EU 2014 / current practice thresholds
    // Hypo: ≤10 mEq/L/24h general, ≤8 mEq/L/24h in high ODS risk (baseline Na < 120)
    // Hyper: ≤10 mEq/L/24h chronic, ≤12 mEq/L/24h acute
    bool isUnsafe = false;
    LString safetyWarning = LString.empty;

    if (params.direction == SodiumDirection.hyper) {
      final maxRate = params.mode == CorrectionMode.acute ? 0.5 : 0.42; // acute: 12/24h, chronic: 10/24h
      if (absRate > maxRate) {
        isUnsafe = true;
        safetyWarning = params.mode == CorrectionMode.acute
            ? LString(
                '⚠️ Vitesse > ${maxRate.toStringAsFixed(1)} mEq/L/h (limite aiguë — max 12 mEq/L/24h)',
                '⚠️ Rate > ${maxRate.toStringAsFixed(1)} mEq/L/h (acute limit — max 12 mEq/L/24h)',
              )
            : LString(
                '⚠️ Vitesse > ${maxRate.toStringAsFixed(1)} mEq/L/h — Risque d\'œdème cérébral (max 10 mEq/L/24h). Corriger sur 48-72h.',
                '⚠️ Rate > ${maxRate.toStringAsFixed(1)} mEq/L/h — Cerebral edema risk (max 10 mEq/L/24h). Correct over 48-72h.',
              );
      }
    } else {
      final baseMaxRate = params.mode == CorrectionMode.acute ? 1.5 : 0.42; // acute: 1.5, chronic: 10/24h
      final highRiskMax = params.mode == CorrectionMode.acute ? 1.0 : 0.33; // acute high-risk: 1.0, chronic high-risk: 8/24h
      final isHighRisk = params.mode == CorrectionMode.chronic && params.baselineNa < 120;
      final effectiveMax = isHighRisk ? highRiskMax : baseMaxRate;

      if (absRate > effectiveMax) {
        isUnsafe = true;
        if (params.mode == CorrectionMode.acute) {
          safetyWarning = LString(
            '⚠️ Vitesse > ${effectiveMax.toStringAsFixed(1)} mEq/L/h (limite aiguë)',
            '⚠️ Rate > ${effectiveMax.toStringAsFixed(1)} mEq/L/h (acute limit)',
          );
        } else if (isHighRisk) {
          safetyWarning = LString(
            '🚨 RISQUE ODS: Na < 120 — correction max 8 mEq/L/24h. Vitesse > 0.33 mEq/L/h.',
            '🚨 ODS RISK: Na < 120 — max correction 8 mEq/L/24h. Rate > 0.33 mEq/L/h.',
          );
        } else {
          safetyWarning = LString(
            '🚨 RISQUE ODS: Vitesse > 10 mEq/L/24h (limite = 0.42 mEq/L/h). Envisager desmopressine si correction trop rapide.',
            '🚨 ODS RISK: Rate > 10 mEq/L/24h (limit = 0.42 mEq/L/h). Consider desmopressin if over-correcting.',
          );
        }
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
