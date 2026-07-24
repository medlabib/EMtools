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
  final double deltaNa; // desired change (target - baseline), kept for compat
  final double desiredDelta; // = deltaNa, explicit alias
  final double plannedDelta24h; // safe change applied per 24h (signed, capped)
  final double deltaPerLiterInfusate; // Adrogué-Madias ΔNa per 1 L of corrective fluid
  final double recommendedInfusateVolumeL; // Rose (Formula 6) volume for plannedDelta24h
  final double correctionDays; // days over which the full desired change is spread
  final double ratePerHour; // = plannedDelta24h / 24
  final bool isUnsafe;
  final LString safetyWarning;
  final LString bolusRecommendation; // symptomatic 3% NaCl bolus (hyponatremia)
  final LString overcorrectionNote; // relowering / ongoing-loss guardrail
  final int fluidARate; // mL/h
  final int fluidBRate; // mL/h
  final int totalRate; // mL/h
  final double totalVolume24h; // L

  const DysnatremiaResult({
    required this.tbw,
    required this.freeWaterDeficit,
    required this.sodiumDeficit,
    required this.deltaNa,
    required this.desiredDelta,
    required this.plannedDelta24h,
    required this.deltaPerLiterInfusate,
    required this.recommendedInfusateVolumeL,
    required this.correctionDays,
    required this.ratePerHour,
    required this.isUnsafe,
    required this.safetyWarning,
    required this.bolusRecommendation,
    required this.overcorrectionNote,
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

  static double calculateFreeWaterDeficit(double tbw, double currentNa, [double normalNa = 140]) {
    return tbw * ((currentNa / normalNa) - 1);
  }

  static double calculateSodiumDeficit(double tbw, double currentNa, double targetNa) {
    return tbw * (targetNa - currentNa);
  }

  /// Adrogué-Madias formula (Wagner et al. Kidney360 2023, Formula 3):
  /// expected change in serum Na after infusing 1 L of the given infusate,
  /// in a closed system. Potassium in the infusate is added to the numerator.
  static double adrogueMadiasDeltaPerLiter({
    required double tbw,
    required double infusateNa,
    required double infusateK,
    required double serumNa,
  }) {
    return (infusateNa + infusateK - serumNa) / (tbw + 1);
  }

  /// Rose-derived infusate volume (Wagner et al. Kidney360 2023, Formula 6):
  /// litres of infusate required to move serum Na from [serumNa] to [targetNa].
  /// Avoids the curvilinear error of the naive Adrogué-Madias volume (Formula 4).
  /// Potassium in the infusate is added to the denominator.
  static double roseInfusateVolume({
    required double tbw,
    required double targetNa,
    required double serumNa,
    required double infusateNa,
    required double infusateK,
  }) {
    final denom = (infusateNa + infusateK) - targetNa;
    if (denom.abs() < 1e-6) return double.infinity;
    return tbw * (targetNa - serumNa) / denom;
  }

  static DysnatremiaResult calculateDysnatremiaCorrection(DysnatremiaParams params) {
    final tbw = calculateTBW(params.weight, params.sex, params.ageGroup);
    final desiredDelta = params.targetNa - params.baselineNa;
    final isHypo = params.direction == SodiumDirection.hypo;

    // Reference deficits. Free-water deficit now uses the normal Na of 140
    // (not the target), per standard practice.
    final freeWaterDeficit = params.direction == SodiumDirection.hyper
        ? calculateFreeWaterDeficit(tbw, params.baselineNa)
        : 0.0;
    final sodiumDeficit = isHypo
        ? calculateSodiumDeficit(tbw, params.baselineNa, params.targetNa)
        : 0.0;

    // --- Modern strict safety limits, evaluated on the 24h TOTAL ---
    // Hyponatremia: ≤8 mmol/L/24h; ≤6 if high ODS risk; ≤18/48h.
    //   High ODS risk is proxied by baselineNa < 115 (the only available risk
    //   input; true risk also includes hypokalemia, alcoholism, malnutrition,
    //   advanced liver disease). 115 (not 120) keeps a 7 mmol/L rise from a
    //   baseline of 118 within the standard ≤8 cap.
    // Hypernatremia: ≤10 mmol/L/24h chronic; acute may reach 12 but still warns.
    final bool isHighOdsRisk = isHypo && params.baselineNa < 115;
    final double dailyCap;
    if (isHypo) {
      dailyCap = isHighOdsRisk ? 6.0 : 8.0;
    } else {
      dailyCap = params.mode == CorrectionMode.acute ? 12.0 : 10.0;
    }

    final absDesired = desiredDelta.abs();
    final isUnsafe = absDesired > dailyCap;

    // Safe change applied per 24h block (magnitude capped at dailyCap).
    final plannedMagnitude = min(absDesired, dailyCap);
    final sign = desiredDelta.isNegative ? -1.0 : 1.0;
    final plannedDelta24h = sign * plannedMagnitude;
    final correctionDays = plannedMagnitude > 0 ? absDesired / plannedMagnitude : 1.0;
    final ratePerHour = plannedDelta24h / 24;

    // Safety warning (retains ODS / 'œdème cérébral' phrasing used by tests).
    LString safetyWarning = LString.empty;
    if (isUnsafe) {
      final days = correctionDays.ceil();
      if (isHypo) {
        safetyWarning = isHighOdsRisk
            ? LString(
                '🚨 RISQUE ODS: Na < 115 — correction max 6 mmol/L/24h. Cible demandée = ${absDesired.toStringAsFixed(0)} mmol/L. Étaler sur $days j (max 18 mmol/L/48h).',
                '🚨 ODS RISK: Na < 115 — max correction 6 mmol/L/24h. Requested change = ${absDesired.toStringAsFixed(0)} mmol/L. Spread over $days d (max 18 mmol/L/48h).',
              )
            : LString(
                '🚨 RISQUE ODS: correction > 8 mmol/L/24h (cible demandée = ${absDesired.toStringAsFixed(0)} mmol/L). Étaler sur $days j (max 18 mmol/L/48h).',
                '🚨 ODS RISK: correction > 8 mmol/L/24h (requested change = ${absDesired.toStringAsFixed(0)} mmol/L). Spread over $days d (max 18 mmol/L/48h).',
              );
      } else {
        safetyWarning = LString(
          '⚠️ Risque d\'œdème cérébral: baisse > ${dailyCap.toStringAsFixed(0)} mmol/L/24h (cible demandée = ${absDesired.toStringAsFixed(0)} mmol/L). Étaler sur $days j.',
          '⚠️ Cerebral edema risk: drop > ${dailyCap.toStringAsFixed(0)} mmol/L/24h (requested change = ${absDesired.toStringAsFixed(0)} mmol/L). Spread over $days d.',
        );
      }
    }

    // --- Corrective vs maintenance fluid selection ---
    // Hypo: corrective = higher-Na fluid (raises Na). Hyper: corrective = lower-Na.
    final bool correctiveIsA = isHypo
        ? params.fluidA.sodiumMeq >= params.fluidB.sodiumMeq
        : params.fluidA.sodiumMeq <= params.fluidB.sodiumMeq;
    final IVFluid corrective = correctiveIsA ? params.fluidA : params.fluidB;

    // Per-litre expected ΔNa for the corrective fluid (Adrogué-Madias, Formula 3).
    final deltaPerLiterInfusate = adrogueMadiasDeltaPerLiter(
      tbw: tbw,
      infusateNa: corrective.sodiumMeq,
      infusateK: corrective.potassiumMeq,
      serumNa: params.baselineNa,
    );

    // Volume of corrective infusate to achieve the safe planned 24h change
    // (Rose, Formula 6 — avoids the curvilinear error of Formula 4).
    final safeTargetNa = params.baselineNa + plannedDelta24h;
    double correctiveVolumeL = roseInfusateVolume(
      tbw: tbw,
      targetNa: safeTargetNa,
      serumNa: params.baselineNa,
      infusateNa: corrective.sodiumMeq,
      infusateK: corrective.potassiumMeq,
    );
    if (!correctiveVolumeL.isFinite || correctiveVolumeL < 0) correctiveVolumeL = 0;

    final correctiveRate = (correctiveVolumeL * 1000 / 24).round();

    // Maintenance / ongoing-loss replacement (hypernatremia only).
    final ongoingLossRatePerH = (params.urineOutput + params.insensibleLoss) / 24;
    final int maintenanceRate = params.direction == SodiumDirection.hyper
        ? ongoingLossRatePerH.round()
        : 0;
    final maintenanceVolumeL = maintenanceRate * 24 / 1000;

    final int fluidARate = correctiveIsA ? correctiveRate : maintenanceRate;
    final int fluidBRate = correctiveIsA ? maintenanceRate : correctiveRate;
    final totalRate = fluidARate + fluidBRate;
    final totalVolume24h = correctiveVolumeL + maintenanceVolumeL;

    // Symptomatic bolus + overcorrection guardrail.
    final LString bolusRecommendation = isHypo
        ? const LString(
            '💉 Si symptômes sévères (convulsions, coma): NaCl 3% 100–150 mL IV en 10 min, répéter ×3 max jusqu\'à +4–6 mmol/L ou résolution des symptômes.',
            '💉 If severe symptoms (seizures, coma): 3% NaCl 100–150 mL IV over 10 min, repeat up to ×3 until +4–6 mmol/L or symptom resolution.',
          )
        : LString.empty;

    final LString overcorrectionNote = isHypo
        ? const LString(
            '🛡️ Surveiller la diurèse aqueuse (risque de surcorrection). En cas de surcorrection: relais G5% ± desmopressine. Contrôler Na q2–4h. [NEJM 2023]',
            '🛡️ Watch for water diuresis (overcorrection risk). If over-corrected: D5W ± desmopressin. Recheck Na q2–4h. [NEJM 2023]',
          )
        : const LString(
            '🛡️ Remplacer les pertes hydriques en cours en plus du déficit. Contrôler Na q4–6h. [NEJM 2023]',
            '🛡️ Replace ongoing water losses in addition to the deficit. Recheck Na q4–6h. [NEJM 2023]',
          );

    return DysnatremiaResult(
      tbw: tbw,
      freeWaterDeficit: freeWaterDeficit,
      sodiumDeficit: sodiumDeficit,
      deltaNa: desiredDelta,
      desiredDelta: desiredDelta,
      plannedDelta24h: plannedDelta24h,
      deltaPerLiterInfusate: deltaPerLiterInfusate,
      recommendedInfusateVolumeL: correctiveVolumeL,
      correctionDays: correctionDays,
      ratePerHour: ratePerHour,
      isUnsafe: isUnsafe,
      safetyWarning: safetyWarning,
      bolusRecommendation: bolusRecommendation,
      overcorrectionNote: overcorrectionNote,
      fluidARate: fluidARate,
      fluidBRate: fluidBRate,
      totalRate: totalRate,
      totalVolume24h: totalVolume24h,
    );
  }
}
