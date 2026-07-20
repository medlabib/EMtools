import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../providers/language_provider.dart';

class MedicalReportScreen extends ConsumerStatefulWidget {
  const MedicalReportScreen({super.key});

  @override
  ConsumerState<MedicalReportScreen> createState() =>
      _MedicalReportScreenState();
}

class _MedicalReportScreenState extends ConsumerState<MedicalReportScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late TabController _tabController;

  // Form State - Identity
  final _patientNameController = TextEditingController();
  String _gender = 'male';
  final _ageController = TextEditingController();
  final _motifController = TextEditingController();

  // Context
  bool _isTrauma = false;
  final _mecanismeController = TextEditingController();

  // A - Airway
  String _airwayStatus = 'clear';
  final _airwayDeviceController = TextEditingController();
  final _airwayActionController = TextEditingController();

  // B - Breathing
  final _respiratoryRateController = TextEditingController();
  final List<String> _workOfBreathing = [];
  String _chestExpansion = 'symmetric';
  final _traumaRibsController = TextEditingController();
  bool _traumaEmphysema = false;
  final _auscultationController = TextEditingController();
  final _spo2Controller = TextEditingController();
  String _oxygenDevice = '';
  final _oxygenFlowController = TextEditingController();
  final _breathingActionController = TextEditingController();

  // C - Circulation
  String _extremities = 'warm';
  final List<String> _shockSigns = [];
  final List<String> _heartFailureSigns = [];
  final _bpRightController = TextEditingController();
  final _bpLeftController = TextEditingController();
  final _pulseController = TextEditingController();
  // ECG
  String _ecgRhythm = 'sinus';
  final _ecgRateController = TextEditingController();
  String _ecgP = 'normal';
  String _ecgPR = 'normal';
  String _ecgQRS = 'narrow';
  final _ecgQRSDetailsController = TextEditingController();
  bool _ecgSgarbossa = false;
  final _ecgSTController = TextEditingController();
  String _ecgT = 'normal';

  // D - Disability
  int _gcsE = 4;
  int _gcsV = 5;
  int _gcsM = 6;
  String _pupils = 'perrl';
  final _pupilsDetailsController = TextEditingController();
  final _neuroDeficitController = TextEditingController();
  bool _aphasia = false;
  final _glucoseController = TextEditingController();
  bool _meningealSigns = false;
  bool _purpura = false;

  // E - Exposure
  bool _tabac = false;
  bool _alcool = false;
  final _hdmController = TextEditingController();
  final _antecedentsController = TextEditingController();
  final _resteExamenController = TextEditingController();
  final List<String> _resteExamenFindings = [];

  // CAT - Conduite à Tenir
  final _catController = TextEditingController();
  final List<String> _catActions = [];

  String _generatedReport = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _tabController.dispose();
    _patientNameController.dispose();
    _ageController.dispose();
    _motifController.dispose();
    _mecanismeController.dispose();
    _airwayDeviceController.dispose();
    _airwayActionController.dispose();
    _respiratoryRateController.dispose();
    _traumaRibsController.dispose();
    _auscultationController.dispose();
    _spo2Controller.dispose();
    _oxygenFlowController.dispose();
    _breathingActionController.dispose();
    _bpRightController.dispose();
    _bpLeftController.dispose();
    _pulseController.dispose();
    _ecgRateController.dispose();
    _ecgQRSDetailsController.dispose();
    _ecgSTController.dispose();
    _pupilsDetailsController.dispose();
    _neuroDeficitController.dispose();
    _glucoseController.dispose();
    _hdmController.dispose();
    _antecedentsController.dispose();
    _resteExamenController.dispose();
    _catController.dispose();
    super.dispose();
  }

  int get _gcsTotal => _gcsE + _gcsV + _gcsM;

  bool get _isEnglish => ref.read(languageProvider) == AppLanguage.english;

  void _generateReport() {
    final sb = StringBuffer();
    final en = _isEnglish;
    final isFemale = _gender == 'female';
    final patientName = _patientNameController.text.isNotEmpty
        ? ' ${_patientNameController.text}'
        : '';
    final age = _ageController.text.isNotEmpty ? _ageController.text : '...';
    final complaint = _motifController.text.isNotEmpty ? _motifController.text : '...';

    // INTRO
    if (en) {
      sb.writeln('This is a ${isFemale ? 'female' : 'male'} patient$patientName, $age years old, presenting for $complaint.');
    } else {
      final genderSuffix = isFemale ? 'e' : '';
      final patientWord = isFemale ? 'd\'une patiente' : 'd\'un patient';
      sb.writeln('Il s\'agit $patientWord$patientName âgé$genderSuffix de $age ans qui consulte pour $complaint.');
    }
    sb.writeln();

    // TRAUMA CONTEXT
    if (_isTrauma && _mecanismeController.text.isNotEmpty) {
      sb.writeln(en ? 'Mechanism of injury: ${_mecanismeController.text}' : 'Mécanisme de l\'accident : ${_mecanismeController.text}');
      sb.writeln();
    }

    // SEVERITY ASSESSMENT
    sb.writeln(en ? 'Severity Assessment:' : 'Évaluation de la gravité :');
    sb.writeln();

    // A - AIRWAY
    sb.write(en ? 'A: Upper airway: ${_getAirwayNarrative(_airwayStatus, en)}' : 'A : Voies aériennes supérieures : ${_getAirwayNarrative(_airwayStatus, en)}');
    if (_airwayStatus == 'secured' && _airwayDeviceController.text.isNotEmpty) {
      sb.write(en ? ' via ${_airwayDeviceController.text}' : ' par ${_airwayDeviceController.text}');
    }
    sb.writeln();
    if (_airwayActionController.text.isNotEmpty) {
      sb.writeln(en ? '=> Action: ${_airwayActionController.text}' : '=> Conduite : ${_airwayActionController.text}');
    }
    sb.writeln();

    // B - BREATHING
    sb.writeln(en ? 'B:' : 'B :');
    sb.writeln(en ? '  Respiratory rate: ${_getRRInterpretation(en)}' : '  Fréquence respiratoire : ${_getRRInterpretation(en)}');
    if (_workOfBreathing.isEmpty) {
      sb.writeln(en ? '  No signs of respiratory distress.' : '  Pas de signes de lutte.');
    } else {
      sb.writeln(en ? '  Signs of distress: ${_workOfBreathing.map((v) => _getWOBLabel(v, en)).join(', ')}.' : '  Signes de lutte : ${_workOfBreathing.map((v) => _getWOBLabel(v, en)).join(', ')}.');
    }
    sb.write(en ? '  Chest expansion: ${_chestExpansion == 'symmetric' ? 'symmetric' : 'asymmetric'}' : '  Ampliation thoracique ${_chestExpansion == 'symmetric' ? 'symétrique' : 'asymétrique'}');
    if (_isTrauma) {
      if (_traumaRibsController.text.isNotEmpty) {
        sb.write(en ? ', rib crepitus present (${_traumaRibsController.text})' : ', présence de craquement des côtes (${_traumaRibsController.text})');
      } else {
        sb.write(en ? ', no rib crepitus' : ', pas de craquement des côtes');
      }
      sb.write(en ? ', ${_traumaEmphysema ? 'subcutaneous emphysema present' : 'no subcutaneous emphysema'}' : ', ${_traumaEmphysema ? 'présence' : 'absence'} d\'emphysème sous cutané');
    }
    sb.writeln('.');
    if (_auscultationController.text.isEmpty) {
      sb.writeln(en ? '  Lung auscultation: clear.' : '  AP : libre.');
    } else {
      sb.writeln(en ? '  Lung auscultation: ${_auscultationController.text}.' : '  AP : ${_auscultationController.text}.');
    }
    sb.writeln('  SpO2 = ${_spo2Controller.text.isNotEmpty ? _spo2Controller.text : '...'} %');
    final bActions = <String>[];
    if (_oxygenDevice.isNotEmpty && _oxygenFlowController.text.isNotEmpty) {
      bActions.add(en ? 'oxygen therapy via ${_getOxygenDeviceLabel(_oxygenDevice, en)} at ${_oxygenFlowController.text} L/min' : 'mise sous oxygénothérapie au ${_getOxygenDeviceLabel(_oxygenDevice, en)} à ${_oxygenFlowController.text} L/min');
    }
    if (_breathingActionController.text.isNotEmpty) {
      bActions.add(_breathingActionController.text);
    }
    if (bActions.isNotEmpty) {
      sb.writeln(en ? '=> Action: ${bActions.join(', ')}' : '=> Conduite : ${bActions.join(', ')}');
    }
    sb.writeln();

    // C - CIRCULATION
    sb.writeln(en ? 'C:' : 'C :');
    sb.write(en ? '  Extremities: ${_getExtremitiesLabel(_extremities, en)}' : '  Extrémités ${_getExtremitiesLabel(_extremities, en)}');
    if (_shockSigns.isEmpty) {
      sb.writeln(en ? '. No peripheral signs of shock.' : '. Pas de signes périphériques de choc.');
    } else {
      sb.writeln(en ? '. ${_shockSigns.map((v) => _getShockSignLabel(v, en)).join(', ')}.' : '. ${_shockSigns.map((v) => _getShockSignLabel(v, en)).join(', ')}.');
    }
    if (_heartFailureSigns.isEmpty) {
      sb.writeln(en ? '  No right heart failure signs (no JVD, HJR, or peripheral edema).' : '  Pas de signes droits (pas de TVJ, RHJ ni OMI).');
    } else {
      final selected = _heartFailureSigns.map((v) => _getHeartFailureLabel(v, en)).toList();
      final unselected = <String>[];
      final jvdLabel = en ? 'JVD' : 'TVJ';
      final hjrLabel = en ? 'HJR' : 'RHJ';
      final edemaLabel = en ? 'peripheral edema' : 'OMI';
      if (!_heartFailureSigns.contains('jvd')) unselected.add(jvdLabel);
      if (!_heartFailureSigns.contains('hjr')) unselected.add(hjrLabel);
      if (!_heartFailureSigns.contains('peripheralEdema')) unselected.add(edemaLabel);
      if (unselected.isEmpty) {
        sb.writeln(en ? '  Right heart signs: ${selected.join(', ')}.' : '  Signes droits : ${selected.join(', ')}.');
      } else {
        sb.writeln(en ? '  Right heart signs: ${selected.join(', ')}, no ${unselected.join(' or ')}.' : '  Signes droits : ${selected.join(', ')}, pas de ${unselected.join(' ni de ')}.');
      }
    }
    sb.writeln(en ? '  BP: right ${_bpRightController.text.isNotEmpty ? _bpRightController.text : '.../...'} and left ${_bpLeftController.text.isNotEmpty ? _bpLeftController.text : '.../...'}' : '  PA : à droite ${_bpRightController.text.isNotEmpty ? _bpRightController.text : '.../...'} et à gauche ${_bpLeftController.text.isNotEmpty ? _bpLeftController.text : '.../...'}');
    sb.writeln(en ? '  Heart rate: ${_pulseController.text.isNotEmpty ? _pulseController.text : '...'} bpm' : '  Pouls : ${_pulseController.text.isNotEmpty ? _pulseController.text : '...'} bpm');
    sb.writeln(en ? '  ECG: ${_getECGNarrativeText(en)}.' : '  ECG : ${_getECGNarrativeText(en)}.');
    sb.writeln();

    // D - DISABILITY
    sb.writeln(en ? 'D: GCS = $_gcsTotal (E$_gcsE V$_gcsV M$_gcsM)' : 'D : GCS = $_gcsTotal (E$_gcsE V$_gcsV M$_gcsM)');
    if (_pupils == 'perrl') {
      sb.writeln(en ? '  Pupils = PERRL (isocoric and reactive).' : '  Pupilles = PERRL (isocores réactives).');
    } else {
      sb.writeln(en ? '  Pupils = ${_pupilsDetailsController.text.isNotEmpty ? _pupilsDetailsController.text : _getPupilsLabel(_pupils, en)}.' : '  Pupilles = ${_pupilsDetailsController.text.isNotEmpty ? _pupilsDetailsController.text : _getPupilsLabel(_pupils, en)}.');
    }
    if (_neuroDeficitController.text.isEmpty) {
      sb.write(en ? '  No sensorimotor deficit' : '  Pas de déficit sensitivo-moteur');
    } else {
      sb.write('  ${_neuroDeficitController.text}');
    }
    if (_aphasia) sb.write(en ? ', with aphasia' : ', avec aphasie');
    sb.writeln('.');
    if (_glucoseController.text.isNotEmpty) {
      sb.writeln(en ? '  Capillary glucose = ${_glucoseController.text} g/L' : '  GAD = ${_glucoseController.text} g/L');
    }
    if (_meningealSigns) {
      sb.writeln(en ? '  Meningeal signs present (Kernig, Brudzinski, nuchal rigidity).' : '  Présence de signes méningés (Kernig, Brudzinski, raideur méningée).');
    }
    if (_purpura) {
      sb.writeln(en ? '  Purpuric lesions present.' : '  Présence de taches purpuriques.');
    }
    sb.writeln();

    // SEVERITY SUMMARY
    if (en) {
      final desc = _getSeverityDescription(en);
      sb.writeln('Severity summary: This is a ${isFemale ? 'female' : 'male'} patient, $age years old, $desc');
    } else {
      final genderSuffix = isFemale ? 'e' : '';
      final patientWord = isFemale ? 'd\'une patiente' : 'd\'un patient';
      sb.writeln('Total des gravités : Il s\'agit $patientWord âgé$genderSuffix de $age ans ${_getSeverityDescription(en)}');
    }
    sb.writeln();

    // CAT - PLAN
    if (_catController.text.isNotEmpty || _catActions.isNotEmpty) {
      sb.writeln(en ? 'Plan:' : 'Conduite à tenir :');
      if (_catActions.isNotEmpty) {
        for (final action in _catActions) {
          sb.writeln('  - $action');
        }
      }
      if (_catController.text.isNotEmpty && _catActions.isEmpty) {
        sb.writeln('  ${_catController.text}');
      }
      sb.writeln();
    }

    // E - EXPOSURE
    sb.writeln(en ? 'E:' : 'E :');
    if (_antecedentsController.text.isEmpty) {
      sb.writeln(en ? '  Past medical history: none notable.' : '  Terrain : pas d\'antécédents médicaux notables.');
    } else {
      sb.writeln(en ? '  Past medical history:' : '  Terrain :');
      for (final line in _antecedentsController.text.split('\n')) {
        if (line.trim().isNotEmpty) sb.writeln('    - $line');
      }
    }
    final habits = <String>[];
    if (_tabac) { habits.add(en ? 'smoker' : 'tabagique'); } else { habits.add(en ? 'non-smoker' : 'non tabagique'); }
    if (_alcool) { habits.add(en ? 'alcohol use' : 'alcoolique'); } else { habits.add(en ? 'no alcohol use' : 'non alcoolique'); }
    sb.writeln(en ? '  Habits: ${habits.join(', ')}.' : '  Habitudes : ${habits.join(', ')}.');
    if (_hdmController.text.isNotEmpty) {
      sb.writeln(en ? '  History of present illness: ${_hdmController.text}' : '  Histoire de la maladie : ${_hdmController.text}');
    }
    if (_resteExamenController.text.isNotEmpty) {
      sb.writeln(en ? '  Rest of physical exam: ${_resteExamenController.text}' : '  Reste de l\'examen : ${_resteExamenController.text}');
    }
    sb.writeln();

    // CONCLUSION
    sb.writeln(en ? 'In summary:' : 'Au total :');
    final terrainSummary = _antecedentsController.text.isEmpty
        ? (en ? 'no significant past medical history' : 'sans antécédents médicaux notables')
        : (en ? 'with history of ${_antecedentsController.text.replaceAll('\n', ', ')}' : 'aux antécédents de ${_antecedentsController.text.replaceAll('\n', ', ')}');
    if (en) {
      sb.writeln('This is a ${isFemale ? 'female' : 'male'} patient$patientName, $age years old, presenting for $complaint, $terrainSummary, ${_getSeverityDescription(en)}');
    } else {
      final genderSuffix = isFemale ? 'e' : '';
      final patientWord = isFemale ? 'd\'une patiente' : 'd\'un patient';
      sb.writeln('Il s\'agit $patientWord$patientName âgé$genderSuffix de $age ans qui consulte pour $complaint, $terrainSummary, ${_getSeverityDescription(en)}');
    }

    setState(() {
      _generatedReport = sb.toString();
      _tabController.animateTo(1);
    });
  }

  // === LABEL HELPERS (UI labels only, report generation remains French clinical) ===

  String _getWOBLabel(String value, bool en) {
    switch (value) {
      case 'suprasternal': return en ? 'suprasternal retraction' : 'tirage sus-sternal';
      case 'subcostal': return en ? 'subcostal retraction' : 'tirage sous-costal';
      case 'intercostal': return en ? 'intercostal retraction' : 'tirage intercostal';
      case 'paradoxical': return en ? 'paradoxical breathing' : 'balancement thoraco-abdominal';
      case 'gasping': return en ? 'gasping' : 'gasps';
      default: return value;
    }
  }

  String _getRRInterpretation(bool en) {
    final rate = int.tryParse(_respiratoryRateController.text);
    if (rate == null) return '... ${en ? 'bpm' : 'cpm'}';
    if (rate < 12) return en ? 'bradypneic at $rate bpm' : 'bradypnéique à $rate cpm';
    if (rate > 20) return en ? 'tachypneic at $rate bpm' : 'polypnéique à $rate cpm';
    return en ? 'eupneic at $rate bpm' : 'eupnéique à $rate cpm';
  }

  String _getAirwayNarrative(String value, bool en) {
    switch (value) {
      case 'clear': return en ? 'clear' : 'libres';
      case 'threatened': return en ? 'at risk' : 'à risque';
      case 'obstructed': return en ? 'obstructed' : 'obstruées';
      case 'secured': return en ? 'secured' : 'sécurisées';
      default: return value;
    }
  }

  String _getECGNarrativeText(bool en) {
    final parts = <String>[];
    final isIrregular = _ecgRhythm == 'afib' || _ecgRhythm == 'aflutter';
    parts.add(en 
      ? 'rhythm: ${isIrregular ? 'irregular' : 'regular'} ${_getEcgRhythmLabel(_ecgRhythm, en)}'
      : 'rythme ${isIrregular ? 'irrégulier' : 'régulier'} ${_getEcgRhythmLabel(_ecgRhythm, en)}');
    if (_ecgRateController.text.isNotEmpty) parts.add('${_ecgRateController.text} bpm');
    parts.add(en ? 'P wave: ${_getEcgPLabel(_ecgP, en)}' : 'onde P ${_getEcgPLabel(_ecgP, en)}');
    parts.add(en ? 'PR interval: ${_getEcgPRLabel(_ecgPR, en)}' : 'espace PR ${_getEcgPRLabel(_ecgPR, en)}');
    parts.add(en ? 'QRS: ${_getEcgQRSLabel(_ecgQRS, en)}' : 'QRS ${_getEcgQRSLabel(_ecgQRS, en)}');
    if (_ecgQRS == 'wide' && _ecgQRSDetailsController.text.isNotEmpty) parts.add(_ecgQRSDetailsController.text);
    if (_ecgSgarbossa) parts.add(en ? 'Sgarbossa criteria present' : 'critères de Sgarbossa présents');
    if (_ecgSTController.text.isEmpty) {
      parts.add(en ? 'no repolarization abnormalities' : 'pas de trouble de la repolarisation');
    } else {
      parts.add(_ecgSTController.text);
    }
    parts.add(en ? 'T wave: ${_getEcgTLabel(_ecgT, en)}' : 'onde T ${_getEcgTLabel(_ecgT, en)}');
    return parts.join(', ');
  }

  String _getSeverityDescription(bool en) {
    final spo2 = int.tryParse(_spo2Controller.text) ?? 100;
    final rr = int.tryParse(_respiratoryRateController.text) ?? 15;
    final systolic = int.tryParse(_bpRightController.text.split('/').first) ?? 120;
    final glucose = double.tryParse(_glucoseController.text) ?? 1.0;
    final isRespDistress = spo2 < 90 || rr > 30 || rr < 10 || _workOfBreathing.isNotEmpty;
    final isHemoDistress = systolic < 90 || _shockSigns.isNotEmpty;
    final isNeuroDistress = _gcsTotal < 13 || _neuroDeficitController.text.isNotEmpty;
    final stLower = _ecgSTController.text.toLowerCase();
    final isSTEMI = stLower.contains('sus') || stLower.contains('élévation') || stLower.contains('elevation') || stLower.contains('stemi');
    final isHypoglycemia = glucose < 0.7;

    if (isSTEMI) {
      final distresses = <String>[];
      if (isRespDistress) distresses.add(en ? 'respiratory' : 'respiratoire');
      if (isHemoDistress) distresses.add(en ? 'hemodynamic' : 'hémodynamique');
      if (isNeuroDistress) distresses.add(en ? 'neurologic' : 'neurologique');
      if (distresses.isEmpty) return en ? 'who presents with STEMI without vital distress.' : 'qui présente un STEMI sans détresse vitale.';
      return en ? 'who presents with STEMI with ${distresses.join(' and ')} distress.' : 'qui présente un STEMI avec détresse ${distresses.join(' et ')}.';
    }
    if (!isRespDistress && !isHemoDistress && !isNeuroDistress) {
      return en ? 'who presents without vital distress.' : 'qui ne présente aucune détresse vitale.';
    }
    final distressParts = <String>[];
    if (isRespDistress) {
      final apText = _auscultationController.text.isEmpty ? 'bilateral breath sounds' : _auscultationController.text;
      distressParts.add(en ? 'respiratory distress with lung auscultation: $apText' : 'une détresse respiratoire avec à l\'AP : $apText');
    }
    if (isHemoDistress) {
      distressParts.add(en ? 'hemodynamic distress with ECG: ${_getECGNarrativeText(en)}' : 'une détresse hémodynamique avec à l\'ECG : ${_getECGNarrativeText(en)}');
    }
    if (isNeuroDistress) {
      final hypoText = isHypoglycemia ? 'WITH' : 'without';
      distressParts.add(en ? 'neurologic distress $hypoText hypoglycemia' : 'une détresse neurologique ${isHypoglycemia ? 'AVEC' : 'sans'} hypoglycémie');
    }
    return en ? 'who presents with ${distressParts.join(' + ')}.' : 'qui présente ${distressParts.join(' + ')}.';
  }

  String _getShockSignLabel(String value, bool en) {
    switch (value) {
      case 'mottling': return en ? 'mottling' : 'marbrures';
      case 'crt': return en ? 'prolonged CRT' : 'TRC allongé';
      case 'weakPulse': return en ? 'weak pulse' : 'pouls faibles';
      case 'asymmetric': return en ? 'asymmetric pulses' : 'pouls asymétriques';
      default: return value;
    }
  }

  String _getHeartFailureLabel(String value, bool en) {
    switch (value) {
      case 'jvd': return en ? 'JVD' : 'TVJ';
      case 'hjr': return en ? 'HJR' : 'RHJ';
      case 'peripheralEdema': return en ? 'peripheral edema' : 'OMI';
      default: return value;
    }
  }

  String _getEcgRhythmLabel(String value, bool en) {
    switch (value) {
      case 'sinus': return en ? 'sinus' : 'sinusal';
      case 'afib': return 'FA';
      case 'aflutter': return en ? 'flutter' : 'flutter';
      case 'svt': return 'TSV';
      case 'vt': return 'TV';
      case 'vfib': return 'FV';
      case 'asystole': return en ? 'asystole' : 'asystolie';
      case 'paced': return en ? 'paced' : 'stimulé';
      default: return value;
    }
  }

  String _getEcgPLabel(String value, bool en) {
    switch (value) {
      case 'normal': return en ? 'normal' : 'normale';
      case 'ample': return en ? 'tall' : 'ample';
      case 'biphasic': return en ? 'biphasic' : 'biphasique';
      case 'absent': return en ? 'absent' : 'absente';
      default: return value;
    }
  }

  String _getEcgPRLabel(String value, bool en) {
    switch (value) {
      case 'normal': return 'normal';
      case 'short': return en ? 'short' : 'court';
      case 'prolonged': return en ? 'prolonged' : 'allongé';
      case 'variable': return en ? 'variable' : 'variable';
      default: return value;
    }
  }

  String _getEcgQRSLabel(String value, bool en) {
    switch (value) {
      case 'narrow': return en ? 'narrow' : 'fins';
      case 'wide': return en ? 'wide' : 'larges';
      default: return value;
    }
  }

  String _getEcgTLabel(String value, bool en) {
    switch (value) {
      case 'normal': return en ? 'normal' : 'normale';
      case 'ample': return en ? 'tall' : 'ample';
      case 'flat': return en ? 'flat' : 'aplatie';
      case 'inverted': return en ? 'inverted' : 'inversée';
      default: return value;
    }
  }

  String _getOxygenDeviceLabel(String value, bool en) {
    switch (value) {
      case 'nasal': return en ? 'nasal cannula' : 'Lunettes nasales';
      case 'simpleMask': return en ? 'simple mask' : 'Masque simple';
      case 'nrb': return en ? 'non-rebreather mask' : 'Masque haute concentration';
      case 'niv': return en ? 'NIV' : 'VNI';
      default: return value;
    }
  }

  String _getExtremitiesLabel(String value, bool en) {
    switch (value) {
      case 'warm': return en ? 'warm, well perfused' : 'Chaudes, bien perfusées';
      case 'cold': return en ? 'cold' : 'Froides';
      case 'cyanotic': return en ? 'cyanotic' : 'Cyanosées';
      default: return value;
    }
  }

  String _getPupilsLabel(String value, bool en) {
    switch (value) {
      case 'perrl': return en ? 'PERRL (isocoric, reactive)' : 'PERRL (isocores réactives)';
      case 'anisocoria': return en ? 'anisocoria' : 'Anisocorie';
      case 'fixed': return en ? 'fixed' : 'Fixes';
      default: return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(languageProvider);
    final isWideScreen = MediaQuery.of(context).size.width > 900;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [_buildSliverAppBar()],
        body: isWideScreen ? _buildWideLayout() : _buildNarrowLayout(),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 140,
      pinned: true,
      backgroundColor: AppColors.accentTeal,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.copy_rounded, color: Colors.white),
          onPressed: _generatedReport.isEmpty
              ? null
              : () {
                  Clipboard.setData(ClipboardData(text: _generatedReport));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppStrings.successCopied), backgroundColor: AppColors.success, behavior: SnackBarBehavior.floating),
                  );
                },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.accentTeal, AppColors.accentEmerald]),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
                Row(children: [
                  Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.description_rounded, color: Colors.white, size: 28)),
                  const SizedBox(width: 16),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(AppStrings.medicalReportTitle, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(context.t('abcdeSubtitle'), style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14)),
                  ])),
                ]),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWideLayout() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(children: [
      Expanded(flex: 3, child: _buildFormSection()),
      Container(width: 1, color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
      Expanded(flex: 2, child: _buildPreviewSection()),
    ]);
  }

  Widget _buildNarrowLayout() {
    return Column(children: [
      _buildTabBar(),
      Expanded(child: TabBarView(controller: _tabController, children: [_buildFormSection(), _buildPreviewSection()])),
    ]);
  }

  Widget _buildTabBar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: isDark ? AppColors.cardDark : Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03), blurRadius: 10, offset: const Offset(0, 2))]),
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.white,
        unselectedLabelColor: isDark ? Colors.grey[400] : AppColors.textSecondary,
        indicator: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.accentTeal, AppColors.accentEmerald]), borderRadius: BorderRadius.circular(12)),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(4),
        tabs: [
          Tab(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.edit_note, size: 20), const SizedBox(width: 8), Text(context.t('formTab'))])),
          Tab(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.preview, size: 20), const SizedBox(width: 8), Text(context.t('previewTab'))])),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(key: _formKey, child: Column(children: [
        _buildStepperCard(),
        const SizedBox(height: 24),
        _buildGenerateButton(),
        const SizedBox(height: 100),
      ])),
    );
  }

  Widget _buildStepperCard() {
    final steps = [
      _StepData(AppStrings.patientInfo, Icons.person, _buildIdentityContent()),
      _StepData('Contexte', Icons.warning_amber, _buildContextContent()),
      _StepData('A - ${context.t('airwayLabel')}', Icons.air, _buildAirwayContent()),
      _StepData('B - ${context.t('breathing')}', Icons.monitor_heart, _buildBreathingContent()),
      _StepData('C - ${context.t('circulation')}', Icons.favorite, _buildCirculationContent()),
      _StepData('D - ${context.t('neurology')}', Icons.psychology, _buildDisabilityContent()),
      _StepData(context.t('catSection'), Icons.medical_services, _buildCATContent()),
      _StepData('E - ${context.t('exposure')}', Icons.visibility, _buildExposureContent()),
    ];
    return Column(children: steps.asMap().entries.map((entry) => _buildAnimatedStepCard(entry.value, entry.key)).toList());
  }

  Widget _buildAnimatedStepCard(_StepData step, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 300 + (index * 80)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(color: isDark ? AppColors.cardDark : Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04), blurRadius: 10, offset: const Offset(0, 2))]),
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  initiallyExpanded: index == 0,
                  leading: Container(width: 40, height: 40, decoration: BoxDecoration(gradient: LinearGradient(colors: [_getStepColor(index), _getStepColor(index).withValues(alpha: 0.7)]), borderRadius: BorderRadius.circular(12)), child: Icon(step.icon, color: Colors.white, size: 20)),
                  title: Text(step.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : AppColors.textPrimary)),
                  children: [Padding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 16), child: step.content)],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getStepColor(int index) {
    final colors = [AppColors.primary, AppColors.warning, AppColors.info, AppColors.accentTeal, AppColors.error, AppColors.accentPurple, AppColors.accentEmerald];
    return colors[index % colors.length];
  }

  Widget _buildIdentityContent() {
    return Column(children: [
      _buildTextField(controller: _patientNameController, label: context.t('patientName'), icon: Icons.person_outline),
      const SizedBox(height: 16),
      Row(children: [
        Expanded(child: _buildDropdownField(value: _gender, label: AppStrings.sex, icon: Icons.wc, items: [DropdownMenuItem(value: 'male', child: Text(AppStrings.male)), DropdownMenuItem(value: 'female', child: Text(AppStrings.female))], onChanged: (v) => setState(() => _gender = v!))),
        const SizedBox(width: 16),
        Expanded(child: _buildTextField(controller: _ageController, label: AppStrings.age, icon: Icons.cake_outlined, suffix: AppStrings.years, keyboardType: TextInputType.number)),
      ]),
      const SizedBox(height: 16),
      _buildTextField(controller: _motifController, label: AppStrings.chiefComplaint, icon: Icons.local_hospital_outlined, maxLines: 2),
    ]);
  }

  Widget _buildContextContent() {
    return Column(children: [
      _buildSwitchTile(title: context.t('traumaContext'), subtitle: context.t('traumaSubtitle'), value: _isTrauma, icon: Icons.warning_amber_rounded, color: AppColors.warning, onChanged: (v) => setState(() => _isTrauma = v)),
      if (_isTrauma) ...[const SizedBox(height: 16), _buildTextField(controller: _mecanismeController, label: context.t('mechanismOfInjury'), icon: Icons.car_crash_outlined, maxLines: 2)],
    ]);
  }

  Widget _buildAirwayContent() {
    return Column(children: [
      _buildDropdownField(value: _airwayStatus, label: context.t('airwayStatus'), icon: Icons.air, items: const [DropdownMenuItem(value: 'clear', child: Text('Clear')), DropdownMenuItem(value: 'obstructed', child: Text('Obstructed')), DropdownMenuItem(value: 'threatened', child: Text('Threatened'))], onChanged: (v) => setState(() => _airwayStatus = v!)),
      if (_airwayStatus != 'clear') ...[const SizedBox(height: 16), _buildTextField(controller: _airwayDeviceController, label: context.t('deviceAction'), icon: Icons.medical_services_outlined)],
    ]);
  }

  Widget _buildBreathingContent() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(child: _buildTextField(controller: _respiratoryRateController, label: context.t('respiratoryRate'), icon: Icons.speed, keyboardType: TextInputType.number)),
        const SizedBox(width: 16),
        Expanded(child: _buildTextField(controller: _spo2Controller, label: context.t('spo2Label'), icon: Icons.air, keyboardType: TextInputType.number)),
      ]),
      const SizedBox(height: 16),
      Text(context.t('workOfBreathing'), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.getTextSecondary(isDark))),
      const SizedBox(height: 8),
      Wrap(spacing: 8, runSpacing: 8, children: [
        _buildChip(context.t('wobSuprasternal'), 'suprasternal', _workOfBreathing, (v) => setState(() { if (_workOfBreathing.contains(v)) { _workOfBreathing.remove(v); } else { _workOfBreathing.add(v); } })),
        _buildChip(context.t('wobSubcostal'), 'subcostal', _workOfBreathing, (v) => setState(() { if (_workOfBreathing.contains(v)) { _workOfBreathing.remove(v); } else { _workOfBreathing.add(v); } })),
        _buildChip(context.t('wobIntercostal'), 'intercostal', _workOfBreathing, (v) => setState(() { if (_workOfBreathing.contains(v)) { _workOfBreathing.remove(v); } else { _workOfBreathing.add(v); } })),
        _buildChip(context.t('wobParadoxical'), 'paradoxical', _workOfBreathing, (v) => setState(() { if (_workOfBreathing.contains(v)) { _workOfBreathing.remove(v); } else { _workOfBreathing.add(v); } })),
        _buildChip(context.t('wobGasping'), 'gasping', _workOfBreathing, (v) => setState(() { if (_workOfBreathing.contains(v)) { _workOfBreathing.remove(v); } else { _workOfBreathing.add(v); } })),
      ]),
      const SizedBox(height: 16),
      _buildDropdownField(value: _chestExpansion, label: context.t('chestExpansion'), icon: Icons.open_with, items: const [DropdownMenuItem(value: 'symmetric', child: Text('Symmetric')), DropdownMenuItem(value: 'asymmetric', child: Text('Asymmetric'))], onChanged: (v) => setState(() => _chestExpansion = v!)),
      if (_isTrauma) ...[
        const SizedBox(height: 16),
        _buildTextField(controller: _traumaRibsController, label: context.t('ribCrepitus'), icon: Icons.broken_image_outlined, hint: context.t('ribCrepitusHint')),
        const SizedBox(height: 12),
        _buildSwitchTile(title: context.t('subcuEmphysema'), subtitle: context.t('subcuEmphysemaSub'), value: _traumaEmphysema, icon: Icons.bubble_chart, color: AppColors.warning, onChanged: (v) => setState(() => _traumaEmphysema = v)),
      ],
      const SizedBox(height: 16),
      _buildTextField(controller: _auscultationController, label: context.t('lungAuscultation'), icon: Icons.hearing, hint: context.t('lungAuscultationHint'), maxLines: 2),
      const SizedBox(height: 16),
      Row(children: [
        Expanded(child: _buildDropdownField(value: _oxygenDevice, label: context.t('oxygenDevice'), icon: Icons.masks_outlined, items: const [DropdownMenuItem(value: '', child: Text('None')), DropdownMenuItem(value: 'nasal', child: Text('Nasal cannula')), DropdownMenuItem(value: 'simpleMask', child: Text('Simple mask')), DropdownMenuItem(value: 'nrb', child: Text('Non-rebreather')), DropdownMenuItem(value: 'niv', child: Text('NIV'))], onChanged: (v) => setState(() => _oxygenDevice = v!))),
        if (_oxygenDevice.isNotEmpty) ...[const SizedBox(width: 16), Expanded(child: _buildTextField(controller: _oxygenFlowController, label: context.t('flowRate'), icon: Icons.speed, keyboardType: TextInputType.number))],
      ]),
      const SizedBox(height: 16),
      _buildTextField(controller: _breathingActionController, label: context.t('breathingAction'), icon: Icons.medical_services, hint: context.t('breathingActionHint'), maxLines: 2),
    ]);
  }

  Widget _buildChip(String label, String value, List<String> selected, Function(String) onTap) {
    final isSelected = selected.contains(value);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => onTap(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(color: isSelected ? AppColors.accentTeal.withValues(alpha: isDark ? 0.25 : 0.15) : (isDark ? AppColors.cardDark : AppColors.backgroundLight), borderRadius: BorderRadius.circular(20), border: Border.all(color: isSelected ? AppColors.accentTeal : (isDark ? Colors.grey.shade700 : Colors.grey.shade300), width: isSelected ? 2 : 1)),
        child: Text(label, style: TextStyle(fontSize: 13, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal, color: isSelected ? AppColors.accentTeal : (isDark ? Colors.grey[400] : AppColors.textSecondary))),
      ),
    );
  }

  Widget _buildCirculationContent() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildDropdownField(value: _extremities, label: context.t('extremities'), icon: Icons.back_hand_outlined, items: const [DropdownMenuItem(value: 'warm', child: Text('Warm, well perfused')), DropdownMenuItem(value: 'cold', child: Text('Cold')), DropdownMenuItem(value: 'cyanotic', child: Text('Cyanotic'))], onChanged: (v) => setState(() => _extremities = v!)),
      const SizedBox(height: 16),
      Text(context.t('shockSigns'), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.getTextSecondary(isDark))),
      const SizedBox(height: 8),
      Wrap(spacing: 8, runSpacing: 8, children: [
        _buildChip(context.t('mottling'), 'mottling', _shockSigns, (v) => setState(() { if (_shockSigns.contains(v)) { _shockSigns.remove(v); } else { _shockSigns.add(v); } })),
        _buildChip(context.t('crtProlonged'), 'crt', _shockSigns, (v) => setState(() { if (_shockSigns.contains(v)) { _shockSigns.remove(v); } else { _shockSigns.add(v); } })),
        _buildChip(context.t('weakPulse'), 'weakPulse', _shockSigns, (v) => setState(() { if (_shockSigns.contains(v)) { _shockSigns.remove(v); } else { _shockSigns.add(v); } })),
        _buildChip(context.t('pulseAsymmetry'), 'asymmetric', _shockSigns, (v) => setState(() { if (_shockSigns.contains(v)) { _shockSigns.remove(v); } else { _shockSigns.add(v); } })),
      ]),
      const SizedBox(height: 16),
      Text(context.t('heartFailureSigns'), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.getTextSecondary(isDark))),
      const SizedBox(height: 8),
      Wrap(spacing: 8, runSpacing: 8, children: [
        _buildChip(context.t('jugularDistension'), 'jvd', _heartFailureSigns, (v) => setState(() { if (_heartFailureSigns.contains(v)) { _heartFailureSigns.remove(v); } else { _heartFailureSigns.add(v); } })),
        _buildChip('RHJ', 'hjr', _heartFailureSigns, (v) => setState(() { if (_heartFailureSigns.contains(v)) { _heartFailureSigns.remove(v); } else { _heartFailureSigns.add(v); } })),
        _buildChip(context.t('peripheralEdema'), 'peripheralEdema', _heartFailureSigns, (v) => setState(() { if (_heartFailureSigns.contains(v)) { _heartFailureSigns.remove(v); } else { _heartFailureSigns.add(v); } })),
      ]),
      const SizedBox(height: 16),
      Row(children: [
        Expanded(child: _buildTextField(controller: _bpRightController, label: context.t('bpRight'), icon: Icons.favorite_border, hint: '120/80')),
        const SizedBox(width: 16),
        Expanded(child: _buildTextField(controller: _bpLeftController, label: context.t('bpLeft'), icon: Icons.favorite_border, hint: '120/80')),
      ]),
      const SizedBox(height: 16),
      _buildTextField(controller: _pulseController, label: context.t('heartRate'), icon: Icons.monitor_heart_outlined, keyboardType: TextInputType.number),
      const SizedBox(height: 20),
      _buildECGSection(isDark),
    ]);
  }

  Widget _buildECGSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.error.withValues(alpha: isDark ? 0.15 : 0.05), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.error.withValues(alpha: 0.2))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Icon(Icons.monitor_heart, color: AppColors.error, size: 20), const SizedBox(width: 8), Text('ECG', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.getTextPrimary(isDark)))]),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: _buildDropdownField(value: _ecgRhythm, label: context.t('rhythm'), icon: Icons.timeline, items: const [DropdownMenuItem(value: 'sinus', child: Text('Sinus')), DropdownMenuItem(value: 'irregular', child: Text('Irregular')), DropdownMenuItem(value: 'af', child: Text('AFib')), DropdownMenuItem(value: 'flutter', child: Text('Flutter'))], onChanged: (v) => setState(() => _ecgRhythm = v!))),
          if (_ecgRhythm == 'af' || _ecgRhythm == 'flutter') ...[const SizedBox(width: 16), Expanded(child: _buildTextField(controller: _ecgRateController, label: context.t('ventricularRate'), icon: Icons.speed, keyboardType: TextInputType.number))],
        ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: _buildMiniDropdown(context.t('pWave'), _ecgP, ['normal', 'ample', 'biphasic'], ['Normal', 'Tall', 'Biphasic'], (v) => setState(() => _ecgP = v))),
          const SizedBox(width: 8),
          Expanded(child: _buildMiniDropdown(context.t('prInterval'), _ecgPR, ['normal', 'prolonged', 'short'], ['Normal', 'Prolonged', 'Short'], (v) => setState(() => _ecgPR = v))),
          const SizedBox(width: 8),
          Expanded(child: _buildMiniDropdown(context.t('tWave'), _ecgT, ['normal', 'ample', 'flat', 'inverted'], ['Normal', 'Tall', 'Flat', 'Inverted'], (v) => setState(() => _ecgT = v))),
        ]),
        const SizedBox(height: 12),
        _buildDropdownField(value: _ecgQRS, label: context.t('qrs'), icon: Icons.show_chart, items: const [DropdownMenuItem(value: 'narrow', child: Text('Narrow (< 120ms)')), DropdownMenuItem(value: 'wide', child: Text('Wide (≥ 120ms)'))], onChanged: (v) => setState(() => _ecgQRS = v!)),
        if (_ecgQRS == 'wide') ...[
          const SizedBox(height: 12),
          _buildTextField(controller: _ecgQRSDetailsController, label: context.t('blockType'), icon: Icons.notes, hint: 'RBBB, LBBB, LAFB...'),
          const SizedBox(height: 8),
          _buildSwitchTile(title: context.t('sgarbossaCriteria'), subtitle: context.t('sgarbossaSubtitle'), value: _ecgSgarbossa, icon: Icons.warning_amber, color: AppColors.error, onChanged: (v) => setState(() => _ecgSgarbossa = v)),
        ],
        const SizedBox(height: 12),
        _buildTextField(controller: _ecgSTController, label: context.t('stSegment'), icon: Icons.trending_up, hint: context.t('stSegmentHint'), maxLines: 2),
      ]),
    );
  }

  Widget _buildMiniDropdown(String label, String value, List<String> values, List<String> labels, Function(String) onChanged) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: TextStyle(fontSize: 11, color: isDark ? Colors.grey[400] : AppColors.textSecondary)),
      const SizedBox(height: 4),
      Container(padding: const EdgeInsets.symmetric(horizontal: 8), decoration: BoxDecoration(color: isDark ? AppColors.cardDark : Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300)), child: DropdownButtonHideUnderline(child: DropdownButton<String>(value: value, isExpanded: true, isDense: true, dropdownColor: isDark ? AppColors.cardDark : Colors.white, style: TextStyle(fontSize: 12, color: isDark ? Colors.white : AppColors.textPrimary), items: List.generate(values.length, (i) => DropdownMenuItem(value: values[i], child: Text(labels[i]))), onChanged: (v) => onChanged(v!)))),
    ]);
  }

  Widget _buildDisabilityContent() {
    return Column(children: [
      _buildGCSSection(),
      const SizedBox(height: 16),
      _buildDropdownField(value: _pupils, label: context.t('pupils'), icon: Icons.visibility, items: const [DropdownMenuItem(value: 'perrl', child: Text('PERRL (reactive)')), DropdownMenuItem(value: 'anisocoria', child: Text('Anisocoria')), DropdownMenuItem(value: 'fixed', child: Text('Fixed'))], onChanged: (v) => setState(() => _pupils = v!)),
      if (_pupils != 'perrl') ...[const SizedBox(height: 12), _buildTextField(controller: _pupilsDetailsController, label: context.t('pupilDetails'), icon: Icons.remove_red_eye)],
      const SizedBox(height: 16),
      _buildTextField(controller: _neuroDeficitController, label: context.t('neuroDeficit'), icon: Icons.accessibility_new, hint: context.t('neuroDeficitHint'), maxLines: 2),
      const SizedBox(height: 12),
      _buildAphasiaCheckbox(),
      const SizedBox(height: 16),
      _buildTextField(controller: _glucoseController, label: context.t('capGlucose'), icon: Icons.bloodtype, keyboardType: TextInputType.numberWithOptions(decimal: true)),
      const SizedBox(height: 16),
      _buildWarningSigns(),
    ]);
  }

  Widget _buildAphasiaCheckbox() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: _aphasia ? AppColors.accentPurple.withValues(alpha: isDark ? 0.2 : 0.1) : (isDark ? AppColors.cardDark : AppColors.backgroundLight), borderRadius: BorderRadius.circular(12), border: Border.all(color: _aphasia ? AppColors.accentPurple.withValues(alpha: 0.3) : (isDark ? Colors.grey.shade700 : Colors.grey.shade200))),
      child: InkWell(
        onTap: () => setState(() => _aphasia = !_aphasia),
        child: Row(children: [
          Icon(Icons.speaker_notes_off, color: _aphasia ? AppColors.accentPurple : (isDark ? Colors.grey[400] : AppColors.textSecondary), size: 20),
          const SizedBox(width: 8),
          Text(context.t('associatedAphasia'), style: TextStyle(fontWeight: FontWeight.w500, color: _aphasia ? AppColors.accentPurple : (isDark ? Colors.white : AppColors.textPrimary))),
          const Spacer(),
          Checkbox(value: _aphasia, onChanged: (v) => setState(() => _aphasia = v ?? false), activeColor: AppColors.accentPurple),
        ]),
      ),
    );
  }

  Widget _buildWarningSigns() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.warning.withValues(alpha: isDark ? 0.2 : 0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.warning.withValues(alpha: 0.3))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Icon(Icons.warning_amber, color: AppColors.warning, size: 20), const SizedBox(width: 8), Text(context.t('warningSigns'), style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.warning))]),
        const SizedBox(height: 12),
        InkWell(onTap: () => setState(() => _meningealSigns = !_meningealSigns), child: Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(children: [Checkbox(value: _meningealSigns, onChanged: (v) => setState(() => _meningealSigns = v ?? false), activeColor: AppColors.warning), Icon(Icons.healing, size: 20, color: _meningealSigns ? AppColors.warning : AppColors.getTextSecondary(isDark)), const SizedBox(width: 8), Text(context.t('meningealSyndrome'), style: TextStyle(color: _meningealSigns ? AppColors.warning : AppColors.getTextPrimary(isDark), fontWeight: _meningealSigns ? FontWeight.w500 : FontWeight.normal))]))),
        InkWell(onTap: () => setState(() => _purpura = !_purpura), child: Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(children: [Checkbox(value: _purpura, onChanged: (v) => setState(() => _purpura = v ?? false), activeColor: Colors.red), Icon(Icons.bubble_chart, size: 20, color: _purpura ? Colors.red : AppColors.getTextSecondary(isDark)), const SizedBox(width: 8), Text(context.t('purpura'), style: TextStyle(color: _purpura ? Colors.red : AppColors.getTextPrimary(isDark), fontWeight: _purpura ? FontWeight.w500 : FontWeight.normal))]))),
      ]),
    );
  }

  Widget _buildGCSSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.accentPurple.withValues(alpha: isDark ? 0.15 : 0.08), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.accentPurple.withValues(alpha: 0.2))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [Icon(Icons.psychology, color: AppColors.accentPurple, size: 20), const SizedBox(width: 8), Text(context.t('gcsScore'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : AppColors.textPrimary))]),
          Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.accentPurple, AppColors.primary]), borderRadius: BorderRadius.circular(20)), child: Text('$_gcsTotal/15', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
        ]),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: _buildGCSDropdown(context.t('gcsEyes'), _gcsE, 4, (v) => setState(() => _gcsE = v!))),
          const SizedBox(width: 8),
          Expanded(child: _buildGCSDropdown(context.t('gcsVerbal'), _gcsV, 5, (v) => setState(() => _gcsV = v!))),
          const SizedBox(width: 8),
          Expanded(child: _buildGCSDropdown(context.t('gcsMotor'), _gcsM, 6, (v) => setState(() => _gcsM = v!))),
        ]),
      ]),
    );
  }

  Widget _buildGCSDropdown(String label, int value, int max, ValueChanged<int?> onChanged) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: TextStyle(fontSize: 12, color: AppColors.getTextSecondary(isDark))),
      const SizedBox(height: 4),
      Container(padding: const EdgeInsets.symmetric(horizontal: 12), decoration: BoxDecoration(color: isDark ? AppColors.cardDark : Colors.white, borderRadius: BorderRadius.circular(10)), child: DropdownButtonHideUnderline(child: DropdownButton<int>(value: value, isExpanded: true, dropdownColor: isDark ? AppColors.cardDark : Colors.white, items: List.generate(max, (i) => DropdownMenuItem(value: i + 1, child: Text('${i + 1}', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.getTextPrimary(isDark))))), onChanged: onChanged))),
    ]);
  }

  Widget _buildExposureContent() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final resteExamenOptions = [
      context.t('reAbdomen'), context.t('reCalves'), context.t('reDehydration'), context.t('reDefense'),
      context.t('reBHA'), context.t('reMass'), context.t('reEdema'), context.t('reSkinFold'),
      context.t('reLymphNodes'), context.t('reKidneys'),
    ];
    return Column(children: [
      _buildTextField(controller: _hdmController, label: context.t('hpiLabel'), icon: Icons.history_edu, maxLines: 3),
      const SizedBox(height: 16),
      _buildTextField(controller: _antecedentsController, label: context.t('pastHistory'), icon: Icons.medical_information_outlined, maxLines: 2),
      const SizedBox(height: 16),
      Row(children: [
        Expanded(child: _buildCheckboxTile(title: context.t('smoking'), value: _tabac, icon: Icons.smoking_rooms, onChanged: (v) => setState(() => _tabac = v!))),
        const SizedBox(width: 12),
        Expanded(child: _buildCheckboxTile(title: context.t('alcohol'), value: _alcool, icon: Icons.local_bar, onChanged: (v) => setState(() => _alcool = v!))),
      ]),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: isDark ? AppColors.cardDark : AppColors.backgroundLight, borderRadius: BorderRadius.circular(12), border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade200)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Icon(Icons.accessibility_new, color: AppColors.primary, size: 20), const SizedBox(width: 8), Text(context.t('restOfExam'), style: TextStyle(fontWeight: FontWeight.w600, color: isDark ? Colors.white : AppColors.textPrimary))]),
          const SizedBox(height: 12),
          Wrap(spacing: 8, runSpacing: 8, children: resteExamenOptions.map((option) {
            final isSelected = _resteExamenFindings.contains(option);
            return GestureDetector(
              onTap: () { setState(() { if (isSelected) { _resteExamenFindings.remove(option); } else { _resteExamenFindings.add(option); } _resteExamenController.text = _resteExamenFindings.join('. ') + (_resteExamenFindings.isNotEmpty ? '.' : ''); }); },
              child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: isSelected ? AppColors.success.withValues(alpha: 0.2) : (isDark ? Colors.grey.shade800 : Colors.grey.shade100), borderRadius: BorderRadius.circular(20), border: Border.all(color: isSelected ? AppColors.success : (isDark ? Colors.grey.shade600 : Colors.grey.shade300))), child: Text(option, style: TextStyle(fontSize: 12, color: isSelected ? AppColors.success : (isDark ? Colors.grey[300] : Colors.grey[700]), fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal))),
            );
          }).toList()),
          const SizedBox(height: 12),
          TextField(controller: _resteExamenController, maxLines: 2, style: TextStyle(fontSize: 14, color: isDark ? Colors.white : AppColors.textPrimary), decoration: InputDecoration(hintText: context.t('otherFindings'), hintStyle: TextStyle(color: isDark ? Colors.grey[600] : AppColors.textHint), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: isDark ? Colors.grey.shade600 : Colors.grey.shade300)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: isDark ? Colors.grey.shade600 : Colors.grey.shade300)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.primary)), contentPadding: const EdgeInsets.all(12))),
        ]),
      ),
    ]);
  }

  Widget _buildCATContent() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final catOptions = [context.t('catHospitalize'), context.t('catMonitor'), context.t('catConditioning'), context.t('catIVLine'), context.t('catLabs'), context.t('catCTBrain'), context.t('catCTBody'), context.t('catChestXray'), context.t('catECG18'), context.t('catUltrasound'), context.t('catConsult'), context.t('catFluids'), context.t('catOxygen'), context.t('catIntubation'), context.t('catAntibiotics'), context.t('catAnalgesics'), context.t('catObserve'), context.t('catDischarge')];
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: isDark ? AppColors.cardDark : AppColors.backgroundLight, borderRadius: BorderRadius.circular(12), border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade200)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Icon(Icons.assignment_turned_in, color: AppColors.warning, size: 20), const SizedBox(width: 8), Text(context.t('catSection'), style: TextStyle(fontWeight: FontWeight.w600, color: isDark ? Colors.white : AppColors.textPrimary))]),
          const SizedBox(height: 12),
          Wrap(spacing: 8, runSpacing: 8, children: catOptions.map((option) {
            final isSelected = _catActions.contains(option);
            return GestureDetector(
              onTap: () { setState(() { if (isSelected) { _catActions.remove(option); } else { _catActions.add(option); } _catController.text = _catActions.join(', '); }); },
              child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: isSelected ? AppColors.warning.withValues(alpha: 0.2) : (isDark ? Colors.grey.shade800 : Colors.grey.shade100), borderRadius: BorderRadius.circular(20), border: Border.all(color: isSelected ? AppColors.warning : (isDark ? Colors.grey.shade600 : Colors.grey.shade300))), child: Text(option, style: TextStyle(fontSize: 12, color: isSelected ? AppColors.warning : (isDark ? Colors.grey[300] : Colors.grey[700]), fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal))),
            );
          }).toList()),
          const SizedBox(height: 12),
          TextField(controller: _catController, maxLines: 3, style: TextStyle(fontSize: 14, color: isDark ? Colors.white : AppColors.textPrimary), decoration: InputDecoration(hintText: context.t('catDetails'), hintStyle: TextStyle(color: isDark ? Colors.grey[600] : AppColors.textHint), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: isDark ? Colors.grey.shade600 : Colors.grey.shade300)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: isDark ? Colors.grey.shade600 : Colors.grey.shade300)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.primary)), contentPadding: const EdgeInsets.all(12))),
        ]),
      ),
    ]);
  }

  Widget _buildTextField({required TextEditingController controller, required String label, required IconData icon, String? suffix, String? hint, int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(color: isDark ? AppColors.cardDark : AppColors.backgroundLight, borderRadius: BorderRadius.circular(12), border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade200)),
      child: TextField(controller: controller, maxLines: maxLines, keyboardType: keyboardType, style: TextStyle(fontSize: 15, color: isDark ? Colors.white : AppColors.textPrimary), decoration: InputDecoration(labelText: label, hintText: hint, labelStyle: TextStyle(color: isDark ? Colors.grey[400] : AppColors.textSecondary, fontSize: 14), hintStyle: TextStyle(color: isDark ? Colors.grey[600] : AppColors.textHint), suffixText: suffix, prefixIcon: Icon(icon, color: AppColors.primary, size: 20), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14))),
    );
  }

  Widget _buildDropdownField<T>({required T value, required String label, required IconData icon, required List<DropdownMenuItem<T>> items, required ValueChanged<T?> onChanged}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(color: isDark ? AppColors.cardDark : AppColors.backgroundLight, borderRadius: BorderRadius.circular(12), border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade200)),
      child: DropdownButtonFormField<T>(initialValue: value, isExpanded: true, items: items, onChanged: onChanged, dropdownColor: isDark ? AppColors.cardDark : Colors.white, style: TextStyle(color: isDark ? Colors.white : AppColors.textPrimary), decoration: InputDecoration(labelText: label, labelStyle: TextStyle(color: isDark ? Colors.grey[400] : AppColors.textSecondary, fontSize: 14), prefixIcon: Icon(icon, color: AppColors.primary, size: 20), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8))),
    );
  }

  Widget _buildSwitchTile({required String title, required String subtitle, required bool value, required IconData icon, required Color color, required ValueChanged<bool> onChanged}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: value ? color.withValues(alpha: isDark ? 0.2 : 0.1) : (isDark ? AppColors.cardDark : AppColors.backgroundLight), borderRadius: BorderRadius.circular(12), border: Border.all(color: value ? color.withValues(alpha: 0.3) : (isDark ? Colors.grey.shade700 : Colors.grey.shade200))),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: value ? color.withValues(alpha: 0.2) : (isDark ? Colors.grey.shade800 : Colors.grey.shade100), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: value ? color : (isDark ? Colors.grey[400] : AppColors.textSecondary), size: 20)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: value ? color : (isDark ? Colors.white : AppColors.textPrimary))), Text(subtitle, style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[400] : AppColors.textSecondary))])),
        Switch(value: value, onChanged: onChanged, activeThumbColor: color),
      ]),
    );
  }

  Widget _buildCheckboxTile({required String title, required bool value, required IconData icon, required ValueChanged<bool?> onChanged}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: value ? AppColors.warning.withValues(alpha: isDark ? 0.2 : 0.1) : (isDark ? AppColors.cardDark : AppColors.backgroundLight), borderRadius: BorderRadius.circular(12), border: Border.all(color: value ? AppColors.warning.withValues(alpha: 0.3) : (isDark ? Colors.grey.shade700 : Colors.grey.shade200))),
      child: Row(children: [Icon(icon, color: value ? AppColors.warning : AppColors.getTextSecondary(isDark), size: 20), const SizedBox(width: 8), Text(title, style: TextStyle(fontWeight: FontWeight.w500, color: value ? AppColors.warning : AppColors.getTextPrimary(isDark))), const Spacer(), Checkbox(value: value, onChanged: onChanged, activeColor: AppColors.warning)]),
    );
  }

  Widget _buildGenerateButton() {
    return Container(
      width: double.infinity, height: 56,
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.accentTeal, AppColors.accentEmerald]), borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: AppColors.accentTeal.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))]),
      child: Material(color: Colors.transparent, child: InkWell(borderRadius: BorderRadius.circular(16), onTap: _generateReport, child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.description_rounded, color: Colors.white), const SizedBox(width: 12), Text(AppStrings.generateReport, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))])))),
    );
  }

  Widget _buildPreviewSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.backgroundLight,
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Icon(Icons.preview, color: AppColors.accentTeal), const SizedBox(width: 8),
          Text(context.t('reportPreview'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.getTextPrimary(isDark))),
          const Spacer(),
          if (_generatedReport.isNotEmpty) IconButton(icon: Icon(Icons.copy, color: AppColors.primary), onPressed: () { Clipboard.setData(ClipboardData(text: _generatedReport)); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppStrings.successCopied), backgroundColor: AppColors.success)); }),
        ]),
        const SizedBox(height: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: isDark ? AppColors.cardDark : Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade200)),
            child: _generatedReport.isEmpty
                ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.description_outlined, size: 64, color: AppColors.getTextHint(isDark)), const SizedBox(height: 16), Text(context.t('reportWillAppear'), style: TextStyle(color: AppColors.getTextSecondary(isDark), fontSize: 16)), const SizedBox(height: 8), Text(AppStrings.welcomeMessage, style: TextStyle(color: AppColors.getTextHint(isDark), fontSize: 14))]))
                : SingleChildScrollView(child: SelectableText(_generatedReport, style: TextStyle(fontFamily: 'monospace', fontSize: 13, height: 1.5, color: AppColors.getTextPrimary(isDark)))),
          ),
        ),
      ]),
    );
  }
}

class _StepData {
  final String title;
  final IconData icon;
  final Widget content;
  _StepData(this.title, this.icon, this.content);
}
