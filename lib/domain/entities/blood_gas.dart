import 'dart:math';

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
  final String status;
  final String primary;
  final String winterMsg;
  final double pfRatio;
  final String ardsGrade;
  final double cao2;
  final double aaGradient;
  final double expectedAa;
  final double vtPerKg;
  final String lactateStatus;
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
    required this.winterMsg,
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
    // 1. PBW
    final heightDiff = max(0, data.height - 152.4);
    final pbw = data.gender == 'male'
        ? 50 + (0.91 * heightDiff)
        : 45.5 + (0.91 * heightDiff);

    // 2. Anion Gap
    final agUncorrected = data.na - (data.cl + data.hco3);
    final agCorrected = agUncorrected + (2.5 * (_normalAlb - data.alb));

    // 3. Delta Ratio
    final deltaGap = agCorrected - 12;
    final deltaBicarb = 24 - data.hco3;
    final deltaRatio = deltaBicarb == 0 ? 0.0 : deltaGap / deltaBicarb;

    // 4. Acid-Base Status - Improved algorithm
    String status = "Normal";
    String primary = "";
    String winterMsg = "";

    // Step 1: Determine primary disorder based on pH
    final bool isAcidemic = data.ph < 7.35;
    final bool isAlkalemic = data.ph > 7.45;
    
    // Step 2: Determine metabolic vs respiratory component
    final bool lowPaco2 = data.paco2 < 35;
    final bool highPaco2 = data.paco2 > 45;
    final bool lowHco3 = data.hco3 < 22;
    final bool highHco3 = data.hco3 > 26;

    if (isAcidemic) {
      status = "Acidose";
      // Primary disorder determination
      if (highPaco2 && !lowHco3) {
        primary = "Respiratoire";
        // Check for metabolic compensation
        final expectedHco3Acute = 24 + ((data.paco2 - 40) * 0.1);
        final expectedHco3Chronic = 24 + ((data.paco2 - 40) * 0.35);
        if (data.hco3 > expectedHco3Chronic + 2) {
          winterMsg = "Compensation métabolique excessive (+ Alcalose métab.)";
        } else if (data.hco3 >= expectedHco3Chronic - 2) {
          winterMsg = "Chronique (Compensée)";
        } else if (data.hco3 >= expectedHco3Acute - 2) {
          winterMsg = "Aiguë (Compensée)";
        } else {
          winterMsg = "+ Acidose Métab.";
        }
      } else if (lowHco3) {
        primary = "Métabolique";
        // Winter's formula for expected paCO2
        final expectedPaco2 = (1.5 * data.hco3) + 8;
        final paco2Range = 2.0; // ± 2 mmHg tolerance
        if (data.paco2 >= expectedPaco2 - paco2Range && data.paco2 <= expectedPaco2 + paco2Range) {
          winterMsg = "Compensée (Pure)";
        } else if (data.paco2 < expectedPaco2 - paco2Range) {
          winterMsg = "+ Alcalose Resp.";
        } else if (data.paco2 > expectedPaco2 + paco2Range) {
          winterMsg = "+ Acidose Resp.";
        }
      } else if (highPaco2 && lowHco3) {
        primary = "Mixte (Resp. + Métab.)";
        winterMsg = "Double trouble acide";
      } else {
        primary = "Indéterminée";
      }
    } else if (isAlkalemic) {
      status = "Alcalose";
      if (lowPaco2 && !highHco3) {
        primary = "Respiratoire";
        // Check for metabolic compensation
        final expectedHco3Acute = 24 - ((40 - data.paco2) * 0.2);
        final expectedHco3Chronic = 24 - ((40 - data.paco2) * 0.5);
        if (data.hco3 < expectedHco3Chronic - 2) {
          winterMsg = "Compensation métabolique excessive (+ Acidose métab.)";
        } else if (data.hco3 <= expectedHco3Chronic + 2) {
          winterMsg = "Chronique (Compensée)";
        } else if (data.hco3 <= expectedHco3Acute + 2) {
          winterMsg = "Aiguë (Compensée)";
        } else {
          winterMsg = "+ Alcalose Métab.";
        }
      } else if (highHco3) {
        primary = "Métabolique";
        // Expected paCO2 for metabolic alkalosis
        final expectedPaco2 = 40 + ((data.hco3 - 24) * 0.7);
        final paco2Range = 2.0;
        if (data.paco2 >= expectedPaco2 - paco2Range && data.paco2 <= expectedPaco2 + paco2Range) {
          winterMsg = "Compensée";
        } else if (data.paco2 > expectedPaco2 + paco2Range) {
          winterMsg = "+ Acidose Resp.";
        } else if (data.paco2 < expectedPaco2 - paco2Range) {
          winterMsg = "+ Alcalose Resp.";
        }
      } else if (lowPaco2 && highHco3) {
        primary = "Mixte (Resp. + Métab.)";
        winterMsg = "Double trouble alcalin";
      } else {
        primary = "Indéterminée";
      }
    } else {
      // Normal pH - check for hidden disorders
      if (lowPaco2 && lowHco3) {
        status = "Normal (compensé)";
        primary = "Possible trouble mixte ou compensé";
        winterMsg = "pH normal mais anomalies respiratoires et métaboliques";
      } else if (highPaco2 && highHco3) {
        status = "Normal (compensé)";
        primary = "Possible trouble mixte ou compensé";
        winterMsg = "pH normal mais anomalies respiratoires et métaboliques";
      }
    }
    
    // Additional: Add delta ratio interpretation for metabolic acidosis with elevated AG
    String deltaRatioMsg = "";
    if (agCorrected > 14) {
      if (deltaRatio < 1) {
        deltaRatioMsg = "Acidose métab. mixte (TA élevé + TA normal)";
      } else if (deltaRatio > 2) {
        deltaRatioMsg = "Acidose métab. à TA élevé + Alcalose métab.";
      } else {
        deltaRatioMsg = "Acidose métab. à TA élevé pure";
      }
    }
    
    // Combine messages
    if (deltaRatioMsg.isNotEmpty && winterMsg.isNotEmpty) {
      winterMsg = "$winterMsg • $deltaRatioMsg";
    } else if (deltaRatioMsg.isNotEmpty) {
      winterMsg = deltaRatioMsg;
    }

    // 5. Oxygenation
    final pfRatio = data.pao2 / data.fio2;
    String ardsGrade = "Normal";
    if (pfRatio < 300) ardsGrade = "SDRA Léger";
    if (pfRatio < 200) ardsGrade = "SDRA Modéré";
    if (pfRatio < 100) ardsGrade = "SDRA Sévère";

    final cao2 = (1.34 * data.hb * (data.sao2 / 100)) + (0.003 * data.pao2);
    
    final pao2Alveolar = (_patm - _ph2o) * data.fio2 - (data.paco2 / 0.8);
    final aaGradient = pao2Alveolar - data.pao2;
    final expectedAa = (data.age / 4) + 4;

    // 6. Mechanics
    final vtPerKg = data.vt / pbw;
    final drivingPressure = data.pplat - data.peep;
    final compliance = drivingPressure > 0 ? data.vt / drivingPressure : 0.0;
    final rsbi = data.vt > 0 ? data.rr / (data.vt / 1000) : 0.0;
    final resistiveGradient = data.ppeak - data.pplat;

    // 7. Lactate
    String lactateStatus = "Normal";
    if (data.lactate >= 4) {
      lactateStatus = "Choc / Hypoperfusion";
    } else if (data.lactate >= 2) {
      lactateStatus = "Hyperlactatémie";
    }

    return BloodGasResults(
      pbw: pbw,
      agUncorrected: agUncorrected,
      agCorrected: agCorrected,
      deltaRatio: deltaRatio,
      status: status,
      primary: primary,
      winterMsg: winterMsg,
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
