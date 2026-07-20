import 'dart:math';

import '../../core/l10n/localized.dart';

/// Language-neutral acid–base classification codes.
///
/// Clinical results are computed as enums (below) and localized in the UI via
/// [BloodGasResultLocalizer]. This keeps the engine language-agnostic and
/// testable without asserting on French text.
enum AcidBaseStatus { normal, acidosis, alkalosis, compensated }

enum PrimaryDisorder { none, respiratory, metabolic, mixed, indeterminate }

/// Compensation / superimposed-disorder interpretation.
enum CompensationStatus {
  none,
  // Metabolic acidosis (Winter's formula).
  metabolicCompensatedPure,
  addedRespiratoryAcidosis,
  addedRespiratoryAlkalosis,
  // Respiratory acidosis (acute/chronic renal compensation).
  respiratoryChronicCompensated,
  respiratoryAcuteCompensated,
  addedMetabolicAcidosis,
  addedMetabolicAlkalosis,
  excessMetabolicCompensationAlkalosis,
  excessMetabolicCompensationAcidosis,
  // Metabolic alkalosis.
  metabolicAlkalosisCompensated,
  // Mixed disorders.
  doubleAcidosis,
  doubleAlkalosis,
  // Normal pH with hidden abnormalities.
  normalWithAbnormalities,
}

/// Delta-ratio interpretation for high-anion-gap metabolic acidosis.
enum DeltaRatioInterpretation {
  none,
  mixedHighAndNormalAg,
  highAgWithMetabolicAlkalosis,
  pureHighAg,
}

/// ARDS severity by P/F ratio (Berlin 2012 thresholds).
enum ArdsGrade { none, mild, moderate, severe }

enum LactateStatus { normal, hyperlactatemia, shock }

class BloodGasPatientData {
  final double ph;
  final double paco2;
  final double pao2;
  final double hco3;
  final double sao2;
  final double lactate;
  final double hb;
  final double na;
  final double cl;
  final double alb;
  final double temp;
  final double fio2;
  final String mode;
  final double vt;
  final double rr;
  final double peep;
  final double pplat;
  final double ppeak;
  final double height;
  final String gender; // 'male' | 'female'
  final double age;

  const BloodGasPatientData({
    this.ph = 7.25,
    this.paco2 = 30,
    this.pao2 = 75,
    this.hco3 = 14,
    this.sao2 = 92,
    this.lactate = 4.5,
    this.hb = 9.5,
    this.na = 140,
    this.cl = 100,
    this.alb = 2.5,
    this.temp = 38.5,
    this.fio2 = 0.5,
    this.mode = 'VAC',
    this.vt = 450,
    this.rr = 22,
    this.peep = 8,
    this.pplat = 26,
    this.ppeak = 35,
    this.height = 175,
    this.gender = 'male',
    this.age = 65,
  });

  BloodGasPatientData copyWith({
    double? ph,
    double? paco2,
    double? pao2,
    double? hco3,
    double? sao2,
    double? lactate,
    double? hb,
    double? na,
    double? cl,
    double? alb,
    double? temp,
    double? fio2,
    String? mode,
    double? vt,
    double? rr,
    double? peep,
    double? pplat,
    double? ppeak,
    double? height,
    String? gender,
    double? age,
  }) {
    return BloodGasPatientData(
      ph: ph ?? this.ph,
      paco2: paco2 ?? this.paco2,
      pao2: pao2 ?? this.pao2,
      hco3: hco3 ?? this.hco3,
      sao2: sao2 ?? this.sao2,
      lactate: lactate ?? this.lactate,
      hb: hb ?? this.hb,
      na: na ?? this.na,
      cl: cl ?? this.cl,
      alb: alb ?? this.alb,
      temp: temp ?? this.temp,
      fio2: fio2 ?? this.fio2,
      mode: mode ?? this.mode,
      vt: vt ?? this.vt,
      rr: rr ?? this.rr,
      peep: peep ?? this.peep,
      pplat: pplat ?? this.pplat,
      ppeak: ppeak ?? this.ppeak,
      height: height ?? this.height,
      gender: gender ?? this.gender,
      age: age ?? this.age,
    );
  }
}

class BloodGasResults {
  final double pbw;
  final double agUncorrected;
  final double agCorrected;
  final double deltaRatio;
  final AcidBaseStatus status;
  final PrimaryDisorder primary;
  final CompensationStatus compensation;
  final DeltaRatioInterpretation deltaRatioInterpretation;
  final double pfRatio;
  final ArdsGrade ardsGrade;
  final double cao2;
  final double aaGradient;
  final double expectedAa;
  final double vtPerKg;
  final LactateStatus lactateStatus;
  final double drivingPressure;
  final double compliance;
  final double rsbi;
  final double resistiveGradient;

  const BloodGasResults({
    required this.pbw,
    required this.agUncorrected,
    required this.agCorrected,
    required this.deltaRatio,
    required this.status,
    required this.primary,
    required this.compensation,
    required this.deltaRatioInterpretation,
    required this.pfRatio,
    required this.ardsGrade,
    required this.cao2,
    required this.aaGradient,
    required this.expectedAa,
    required this.vtPerKg,
    required this.lactateStatus,
    required this.drivingPressure,
    required this.compliance,
    required this.rsbi,
    required this.resistiveGradient,
  });
}

class BloodGasCalculator {
  static const double _normalAlb = 4.0;
  static const double _patm = 760;
  static const double _ph2o = 47;

  static BloodGasResults calculate(BloodGasPatientData data) {
    // 1. PBW (ARDSNet predicted body weight, Devine formula).
    final heightDiff = max(0, data.height - 152.4);
    final pbw = data.gender == 'male'
        ? 50 + (0.91 * heightDiff)
        : 45.5 + (0.91 * heightDiff);

    // 2. Anion Gap. AG = Na-(Cl+HCO3); albumin-corrected +2.5*(4-alb).
    // NB: normal AG with modern ion-selective electrodes is ~6-12 mEq/L; a
    // baseline of 12 is used here for the delta-ratio interpretation.
    final agUncorrected = data.na - (data.cl + data.hco3);
    final agCorrected = agUncorrected + (2.5 * (_normalAlb - data.alb));

    // 3. Delta Ratio (delta gap / delta bicarbonate), baseline AG 12, HCO3 24.
    final deltaGap = agCorrected - 12;
    final deltaBicarb = 24 - data.hco3;
    final deltaRatio = deltaBicarb == 0 ? 0.0 : deltaGap / deltaBicarb;

    // 4. Acid-Base Status.
    AcidBaseStatus status = AcidBaseStatus.normal;
    PrimaryDisorder primary = PrimaryDisorder.none;
    CompensationStatus compensation = CompensationStatus.none;

    // Step 1: primary disorder based on pH.
    final bool isAcidemic = data.ph < 7.35;
    final bool isAlkalemic = data.ph > 7.45;

    // Step 2: metabolic vs respiratory component.
    final bool lowPaco2 = data.paco2 < 35;
    final bool highPaco2 = data.paco2 > 45;
    final bool lowHco3 = data.hco3 < 22;
    final bool highHco3 = data.hco3 > 26;

    if (isAcidemic) {
      status = AcidBaseStatus.acidosis;
      if (highPaco2 && !lowHco3) {
        primary = PrimaryDisorder.respiratory;
        // Renal compensation (acute +0.1, chronic +0.35 HCO3 per mmHg PaCO2).
        final expectedHco3Acute = 24 + ((data.paco2 - 40) * 0.1);
        final expectedHco3Chronic = 24 + ((data.paco2 - 40) * 0.35);
        if (data.hco3 > expectedHco3Chronic + 2) {
          compensation = CompensationStatus.excessMetabolicCompensationAlkalosis;
        } else if (data.hco3 >= expectedHco3Chronic - 2) {
          compensation = CompensationStatus.respiratoryChronicCompensated;
        } else if (data.hco3 >= expectedHco3Acute - 2) {
          compensation = CompensationStatus.respiratoryAcuteCompensated;
        } else {
          compensation = CompensationStatus.addedMetabolicAcidosis;
        }
      } else if (lowHco3) {
        primary = PrimaryDisorder.metabolic;
        // Winter's formula: expected PaCO2 = 1.5*HCO3 + 8 (±2).
        final expectedPaco2 = (1.5 * data.hco3) + 8;
        const paco2Range = 2.0;
        if (data.paco2 >= expectedPaco2 - paco2Range &&
            data.paco2 <= expectedPaco2 + paco2Range) {
          compensation = CompensationStatus.metabolicCompensatedPure;
        } else if (data.paco2 < expectedPaco2 - paco2Range) {
          compensation = CompensationStatus.addedRespiratoryAlkalosis;
        } else if (data.paco2 > expectedPaco2 + paco2Range) {
          compensation = CompensationStatus.addedRespiratoryAcidosis;
        }
      } else if (highPaco2 && lowHco3) {
        primary = PrimaryDisorder.mixed;
        compensation = CompensationStatus.doubleAcidosis;
      } else {
        primary = PrimaryDisorder.indeterminate;
      }
    } else if (isAlkalemic) {
      status = AcidBaseStatus.alkalosis;
      if (lowPaco2 && !highHco3) {
        primary = PrimaryDisorder.respiratory;
        // Renal compensation (acute -0.2, chronic -0.5 HCO3 per mmHg PaCO2).
        final expectedHco3Acute = 24 - ((40 - data.paco2) * 0.2);
        final expectedHco3Chronic = 24 - ((40 - data.paco2) * 0.5);
        if (data.hco3 < expectedHco3Chronic - 2) {
          compensation = CompensationStatus.excessMetabolicCompensationAcidosis;
        } else if (data.hco3 <= expectedHco3Chronic + 2) {
          compensation = CompensationStatus.respiratoryChronicCompensated;
        } else if (data.hco3 <= expectedHco3Acute + 2) {
          compensation = CompensationStatus.respiratoryAcuteCompensated;
        } else {
          compensation = CompensationStatus.addedMetabolicAlkalosis;
        }
      } else if (highHco3) {
        primary = PrimaryDisorder.metabolic;
        // Expected PaCO2 for metabolic alkalosis = 40 + 0.7*(HCO3-24).
        final expectedPaco2 = 40 + ((data.hco3 - 24) * 0.7);
        const paco2Range = 2.0;
        if (data.paco2 >= expectedPaco2 - paco2Range &&
            data.paco2 <= expectedPaco2 + paco2Range) {
          compensation = CompensationStatus.metabolicAlkalosisCompensated;
        } else if (data.paco2 > expectedPaco2 + paco2Range) {
          compensation = CompensationStatus.addedRespiratoryAcidosis;
        } else if (data.paco2 < expectedPaco2 - paco2Range) {
          compensation = CompensationStatus.addedRespiratoryAlkalosis;
        }
      } else if (lowPaco2 && highHco3) {
        primary = PrimaryDisorder.mixed;
        compensation = CompensationStatus.doubleAlkalosis;
      } else {
        primary = PrimaryDisorder.indeterminate;
      }
    } else {
      // Normal pH - check for hidden mixed/compensated disorders.
      if ((lowPaco2 && lowHco3) || (highPaco2 && highHco3)) {
        status = AcidBaseStatus.compensated;
        primary = PrimaryDisorder.mixed;
        compensation = CompensationStatus.normalWithAbnormalities;
      }
    }

    // Delta-ratio interpretation for elevated-AG metabolic acidosis.
    DeltaRatioInterpretation deltaRatioInterpretation =
        DeltaRatioInterpretation.none;
    if (agCorrected > 14) {
      if (deltaRatio < 1) {
        deltaRatioInterpretation = DeltaRatioInterpretation.mixedHighAndNormalAg;
      } else if (deltaRatio > 2) {
        deltaRatioInterpretation =
            DeltaRatioInterpretation.highAgWithMetabolicAlkalosis;
      } else {
        deltaRatioInterpretation = DeltaRatioInterpretation.pureHighAg;
      }
    }

    // 5. Oxygenation. Berlin 2012 P/F thresholds (300/200/100) require PEEP
    // >=5 cmH2O; the 2023 Global Definition of ARDS additionally accepts
    // SpO2/FiO2 and HFNO >=30 L/min. Labelled "Berlin 2012 / Global Def 2023".
    final pfRatio = data.pao2 / data.fio2;
    ArdsGrade ardsGrade = ArdsGrade.none;
    if (pfRatio < 300) ardsGrade = ArdsGrade.mild;
    if (pfRatio < 200) ardsGrade = ArdsGrade.moderate;
    if (pfRatio < 100) ardsGrade = ArdsGrade.severe;

    final cao2 = (1.34 * data.hb * (data.sao2 / 100)) + (0.003 * data.pao2);

    final pao2Alveolar = (_patm - _ph2o) * data.fio2 - (data.paco2 / 0.8);
    final aaGradient = pao2Alveolar - data.pao2;
    final expectedAa = (data.age / 4) + 4;

    // 6. Mechanics.
    final vtPerKg = data.vt / pbw;
    final drivingPressure = data.pplat - data.peep;
    final compliance = drivingPressure > 0 ? data.vt / drivingPressure : 0.0;
    final rsbi = data.vt > 0 ? data.rr / (data.vt / 1000) : 0.0;
    final resistiveGradient = data.ppeak - data.pplat;

    // 7. Lactate.
    LactateStatus lactateStatus = LactateStatus.normal;
    if (data.lactate >= 4) {
      lactateStatus = LactateStatus.shock;
    } else if (data.lactate >= 2) {
      lactateStatus = LactateStatus.hyperlactatemia;
    }

    return BloodGasResults(
      pbw: pbw,
      agUncorrected: agUncorrected,
      agCorrected: agCorrected,
      deltaRatio: deltaRatio,
      status: status,
      primary: primary,
      compensation: compensation,
      deltaRatioInterpretation: deltaRatioInterpretation,
      pfRatio: pfRatio,
      ardsGrade: ardsGrade,
      cao2: cao2,
      aaGradient: aaGradient,
      expectedAa: expectedAa,
      vtPerKg: vtPerKg,
      lactateStatus: lactateStatus,
      drivingPressure: drivingPressure,
      compliance: compliance,
      rsbi: rsbi,
      resistiveGradient: resistiveGradient,
    );
  }
}

/// Maps language-neutral blood-gas result enums to bilingual (FR/EN) text.
class BloodGasResultLocalizer {
  const BloodGasResultLocalizer._();

  static LString status(AcidBaseStatus s) {
    switch (s) {
      case AcidBaseStatus.normal:
        return const LString('Normal', 'Normal');
      case AcidBaseStatus.acidosis:
        return const LString('Acidose', 'Acidosis');
      case AcidBaseStatus.alkalosis:
        return const LString('Alcalose', 'Alkalosis');
      case AcidBaseStatus.compensated:
        return const LString('Normal (compensé)', 'Normal (compensated)');
    }
  }

  static LString primary(PrimaryDisorder p) {
    switch (p) {
      case PrimaryDisorder.none:
        return const LString('', '');
      case PrimaryDisorder.respiratory:
        return const LString('Respiratoire', 'Respiratory');
      case PrimaryDisorder.metabolic:
        return const LString('Métabolique', 'Metabolic');
      case PrimaryDisorder.mixed:
        return const LString('Mixte (Resp. + Métab.)', 'Mixed (resp. + metab.)');
      case PrimaryDisorder.indeterminate:
        return const LString('Indéterminée', 'Indeterminate');
    }
  }

  static LString compensation(CompensationStatus c) {
    switch (c) {
      case CompensationStatus.none:
        return const LString('', '');
      case CompensationStatus.metabolicCompensatedPure:
        return const LString('Compensée (Pure)', 'Compensated (pure)');
      case CompensationStatus.addedRespiratoryAcidosis:
        return const LString('+ Acidose Resp.', '+ Respiratory acidosis');
      case CompensationStatus.addedRespiratoryAlkalosis:
        return const LString('+ Alcalose Resp.', '+ Respiratory alkalosis');
      case CompensationStatus.respiratoryChronicCompensated:
        return const LString('Chronique (Compensée)', 'Chronic (compensated)');
      case CompensationStatus.respiratoryAcuteCompensated:
        return const LString('Aiguë (Compensée)', 'Acute (compensated)');
      case CompensationStatus.addedMetabolicAcidosis:
        return const LString('+ Acidose Métab.', '+ Metabolic acidosis');
      case CompensationStatus.addedMetabolicAlkalosis:
        return const LString('+ Alcalose Métab.', '+ Metabolic alkalosis');
      case CompensationStatus.excessMetabolicCompensationAlkalosis:
        return const LString(
          'Compensation métabolique excessive (+ Alcalose métab.)',
          'Excess metabolic compensation (+ metabolic alkalosis)',
        );
      case CompensationStatus.excessMetabolicCompensationAcidosis:
        return const LString(
          'Compensation métabolique excessive (+ Acidose métab.)',
          'Excess metabolic compensation (+ metabolic acidosis)',
        );
      case CompensationStatus.metabolicAlkalosisCompensated:
        return const LString('Compensée', 'Compensated');
      case CompensationStatus.doubleAcidosis:
        return const LString(
          'Double trouble acide',
          'Combined acidosis (resp. + metab.)',
        );
      case CompensationStatus.doubleAlkalosis:
        return const LString(
          'Double trouble alcalin',
          'Combined alkalosis (resp. + metab.)',
        );
      case CompensationStatus.normalWithAbnormalities:
        return const LString(
          'pH normal mais anomalies respiratoires et métaboliques',
          'Normal pH with respiratory and metabolic abnormalities',
        );
    }
  }

  static LString deltaRatio(DeltaRatioInterpretation d) {
    switch (d) {
      case DeltaRatioInterpretation.none:
        return const LString('', '');
      case DeltaRatioInterpretation.mixedHighAndNormalAg:
        return const LString(
          'Acidose métab. mixte (TA élevé + TA normal)',
          'Mixed metabolic acidosis (high AG + normal AG)',
        );
      case DeltaRatioInterpretation.highAgWithMetabolicAlkalosis:
        return const LString(
          'Acidose métab. à TA élevé + Alcalose métab.',
          'High-AG metabolic acidosis + metabolic alkalosis',
        );
      case DeltaRatioInterpretation.pureHighAg:
        return const LString(
          'Acidose métab. à TA élevé pure',
          'Pure high-AG metabolic acidosis',
        );
    }
  }

  static LString ardsGrade(ArdsGrade g) {
    switch (g) {
      case ArdsGrade.none:
        return const LString('Normal', 'Normal');
      case ArdsGrade.mild:
        return const LString('SDRA Léger', 'Mild ARDS');
      case ArdsGrade.moderate:
        return const LString('SDRA Modéré', 'Moderate ARDS');
      case ArdsGrade.severe:
        return const LString('SDRA Sévère', 'Severe ARDS');
    }
  }

  static LString lactate(LactateStatus l) {
    switch (l) {
      case LactateStatus.normal:
        return const LString('Normal', 'Normal');
      case LactateStatus.hyperlactatemia:
        return const LString('Hyperlactatémie', 'Hyperlactatemia');
      case LactateStatus.shock:
        return const LString('Choc / Hypoperfusion', 'Shock / hypoperfusion');
    }
  }

  /// Combined compensation + delta-ratio message (joined by " • "), matching
  /// the previous `winterMsg` presentation. Returns an empty [LString] when
  /// there is nothing to show.
  static LString combinedMessage(BloodGasResults r) {
    final comp = compensation(r.compensation);
    final delta = deltaRatio(r.deltaRatioInterpretation);
    String join(String a, String b) {
      if (a.isNotEmpty && b.isNotEmpty) return '$a • $b';
      return a.isNotEmpty ? a : b;
    }

    return LString(join(comp.fr, delta.fr), join(comp.en, delta.en));
  }
}
