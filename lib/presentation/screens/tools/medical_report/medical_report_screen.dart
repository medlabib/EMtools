import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/l10n/app_strings.dart';

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
  List<String> _workOfBreathing =
      []; // suprasternal, subcostal, intercostal, paradoxical, gasping
  String _chestExpansion = 'symmetric';
  final _traumaRibsController = TextEditingController();
  bool _traumaEmphysema = false;
  final _auscultationController =
      TextEditingController(); // Text input for auscultation
  final _spo2Controller = TextEditingController();
  String _oxygenDevice = '';
  final _oxygenFlowController = TextEditingController();
  final _breathingActionController = TextEditingController();

  // C - Circulation
  String _extremities = 'warm';
  List<String> _shockSigns = []; // mottling, crt, weakPulse, asymmetric
  List<String> _heartFailureSigns = []; // jvd, hjr, peripheralEdema
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
  final _ecgSTController =
      TextEditingController(); // Text input for ST segment details
  String _ecgT = 'normal';

  // D - Disability
  int _gcsE = 4;
  int _gcsV = 5;
  int _gcsM = 6;
  String _pupils = 'perrl';
  final _pupilsDetailsController = TextEditingController();
  final _neuroDeficitController =
      TextEditingController(); // Text input for neuro deficit
  bool _aphasia = false;
  final _glucoseController = TextEditingController();
  bool _meningealSigns = false;
  bool _purpura = false;

  // E - Exposure
  bool _tabac = false;
  bool _alcool = false;
  final _hdmController = TextEditingController();
  final _antecedentsController = TextEditingController();

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
    super.dispose();
  }

  int get _gcsTotal => _gcsE + _gcsV + _gcsM;

  void _generateReport() {
    final sb = StringBuffer();
    final isFemale = _gender == 'female';
    final genderSuffix = isFemale ? 'e' : '';
    final patientWord = isFemale ? 'd\'une patiente' : 'd\'un patient';
    final patientName = _patientNameController.text.isNotEmpty
        ? ' ${_patientNameController.text}'
        : '';
    final age = _ageController.text.isNotEmpty ? _ageController.text : '...';

    // INTRO - "Il s'agit du patient X âgé de Y ans qui consulte pour Z"
    sb.writeln(
      'Il s\'agit $patientWord$patientName âgé$genderSuffix de $age ans qui consulte pour ${_motifController.text.isNotEmpty ? _motifController.text : '...'}.',
    );
    sb.writeln();

    // CONTEXTE TRAUMATIQUE
    if (_isTrauma && _mecanismeController.text.isNotEmpty) {
      sb.writeln('Mécanisme de l\'accident : ${_mecanismeController.text}');
      sb.writeln();
    }

    // EVALUATION DE LA GRAVITE
    sb.writeln('Évaluation de la gravité :');
    sb.writeln();

    // A - VOIES AÉRIENNES
    sb.write(
      'A : Voies aériennes supérieures : ${_getAirwayLabelNarrative(_airwayStatus)}',
    );
    if (_airwayStatus == 'secured' && _airwayDeviceController.text.isNotEmpty) {
      sb.write(' par ${_airwayDeviceController.text}');
    }
    sb.writeln();
    if (_airwayActionController.text.isNotEmpty) {
      sb.writeln('=> Conduite : ${_airwayActionController.text}');
    }
    sb.writeln();

    // B - RESPIRATION
    sb.writeln('B :');
    // Fréquence respiratoire avec interprétation automatique
    sb.writeln('  Fréquence respiratoire : ${_getRRInterpretation()}');
    // Signes de lutte
    if (_workOfBreathing.isEmpty) {
      sb.writeln('  Pas de signes de lutte.');
    } else {
      sb.writeln(
        '  Signes de lutte : ${_workOfBreathing.map(_getWOBLabel).join(', ')}.',
      );
    }
    // Ampliation thoracique
    sb.write(
      '  Ampliation thoracique ${_chestExpansion == 'symmetric' ? 'symétrique' : 'asymétrique'}',
    );
    // Trauma: côtes et emphysème
    if (_isTrauma) {
      if (_traumaRibsController.text.isNotEmpty) {
        sb.write(
          ', présence de craquement des côtes (${_traumaRibsController.text})',
        );
      } else {
        sb.write(', pas de craquement des côtes');
      }
      sb.write(
        ', ${_traumaEmphysema ? 'présence' : 'absence'} d\'emphysème sous cutané',
      );
    }
    sb.writeln('.');
    // Auscultation pulmonaire
    if (_auscultationController.text.isEmpty) {
      sb.writeln('  AP : libre.');
    } else {
      sb.writeln('  AP : ${_auscultationController.text}.');
    }
    // SpO2
    sb.writeln(
      '  SpO2 = ${_spo2Controller.text.isNotEmpty ? _spo2Controller.text : '...'} %',
    );
    // Conduite B
    final bActions = <String>[];
    if (_oxygenDevice.isNotEmpty && _oxygenFlowController.text.isNotEmpty) {
      bActions.add(
        'mise sous oxygénothérapie au ${_getOxygenDeviceLabel(_oxygenDevice)} à ${_oxygenFlowController.text} L/min',
      );
    }
    if (_breathingActionController.text.isNotEmpty) {
      bActions.add(_breathingActionController.text);
    }
    if (bActions.isNotEmpty) {
      sb.writeln('=> Conduite : ${bActions.join(', ')}');
    }
    sb.writeln();

    // C - CIRCULATION
    sb.writeln('C :');
    // Extrémités et signes de choc
    sb.write('  Extrémités ${_getExtremitiesLabel(_extremities)}');
    if (_shockSigns.isEmpty) {
      sb.writeln('. Pas de signes périphériques de choc.');
    } else {
      sb.writeln('. ${_shockSigns.map(_getShockSignLabel).join(', ')}.');
    }
    // Signes droits (insuffisance cardiaque) - with "pas de..." for unselected
    if (_heartFailureSigns.isEmpty) {
      sb.writeln('  Pas de signes droits (pas de TVJ, RHJ ni OMI).');
    } else {
      final selected = _heartFailureSigns.map(_getHeartFailureLabel).toList();
      final unselected = <String>[];
      if (!_heartFailureSigns.contains('jvd')) unselected.add('TVJ');
      if (!_heartFailureSigns.contains('hjr')) unselected.add('RHJ');
      if (!_heartFailureSigns.contains('peripheralEdema'))
        unselected.add('OMI');

      if (unselected.isEmpty) {
        sb.writeln('  Signes droits : ${selected.join(', ')}.');
      } else {
        sb.writeln(
          '  Signes droits : ${selected.join(', ')}, pas de ${unselected.join(' ni de ')}.',
        );
      }
    }
    // PA bilatérale
    sb.writeln(
      '  PA : à droite ${_bpRightController.text.isNotEmpty ? _bpRightController.text : '.../...'} et à gauche ${_bpLeftController.text.isNotEmpty ? _bpLeftController.text : '.../...'}',
    );
    // Pouls
    sb.writeln(
      '  Pouls : ${_pulseController.text.isNotEmpty ? _pulseController.text : '...'} bpm',
    );
    // ECG avec interprétation automatique
    sb.writeln('  ECG : ${_getECGNarrativeText()}.');
    sb.writeln();

    // D - NEUROLOGIQUE
    sb.writeln('D : GCS = $_gcsTotal (E$_gcsE V$_gcsV M$_gcsM)');
    // Pupilles
    if (_pupils == 'perrl') {
      sb.writeln('  Pupilles = PERRL (isocores réactives).');
    } else {
      sb.writeln(
        '  Pupilles = ${_pupilsDetailsController.text.isNotEmpty ? _pupilsDetailsController.text : _getPupilsLabel(_pupils)}.',
      );
    }
    // Déficit
    if (_neuroDeficitController.text.isEmpty) {
      sb.write('  Pas de déficit sensitivo-moteur');
    } else {
      sb.write('  ${_neuroDeficitController.text}');
    }
    if (_aphasia) {
      sb.write(', avec aphasie');
    }
    sb.writeln('.');
    // GAD
    if (_glucoseController.text.isNotEmpty) {
      sb.writeln('  GAD = ${_glucoseController.text} g/L');
    }
    // Signes méningés et purpura
    if (_meningealSigns) {
      sb.writeln(
        '  Présence de signes méningés (Kernig, Brudzinski, raideur méningée).',
      );
    }
    if (_purpura) {
      sb.writeln('  Présence de taches purpuriques.');
    }
    sb.writeln();

    // TOTAL DES GRAVITÉS
    sb.writeln(
      'Total des gravités : Il s\'agit $patientWord âgé$genderSuffix de $age ans ${_getSeverityDescription()}',
    );
    sb.writeln();

    // E - EXPOSITION
    sb.writeln('E :');
    // Terrain
    if (_antecedentsController.text.isEmpty) {
      sb.writeln('  Terrain : pas d\'antécédents médicaux notables.');
    } else {
      sb.writeln('  Terrain :');
      for (final line in _antecedentsController.text.split('\n')) {
        if (line.trim().isNotEmpty) {
          sb.writeln('    - $line');
        }
      }
    }
    // Habitudes
    final habits = <String>[];
    if (_tabac) {
      habits.add('tabagique');
    } else {
      habits.add('non tabagique');
    }
    if (_alcool) {
      habits.add('alcoolique');
    } else {
      habits.add('non alcoolique');
    }
    sb.writeln('  Habitudes : ${habits.join(', ')}.');
    // HDM
    if (_hdmController.text.isNotEmpty) {
      sb.writeln('  Histoire de la maladie : ${_hdmController.text}');
    }
    sb.writeln();

    // AU TOTAL
    sb.writeln('Au total :');
    final terrainSummary = _antecedentsController.text.isEmpty
        ? 'sans antécédents médicaux notables'
        : 'aux antécédents de ${_antecedentsController.text.replaceAll('\n', ', ')}';
    sb.writeln(
      'Il s\'agit $patientWord$patientName âgé$genderSuffix de $age ans qui consulte pour ${_motifController.text.isNotEmpty ? _motifController.text : '...'}, $terrainSummary, ${_getSeverityDescription()}',
    );

    setState(() {
      _generatedReport = sb.toString();
      _tabController.animateTo(1);
    });
  }

  // === HELPER METHODS FOR NARRATIVE TEXT ===

  String _getRRInterpretation() {
    final rate = int.tryParse(_respiratoryRateController.text);
    if (rate == null) return '... cpm';
    if (rate < 12) return 'bradypnéique à $rate cpm';
    if (rate > 20) return 'polypnéique à $rate cpm';
    return 'eupnéique à $rate cpm';
  }

  String _getWOBLabel(String value) {
    switch (value) {
      case 'suprasternal':
        return 'tirage sus-sternal';
      case 'subcostal':
        return 'tirage sous-costal';
      case 'intercostal':
        return 'tirage intercostal';
      case 'paradoxical':
        return 'balancement thoraco-abdominal';
      case 'gasping':
        return 'gasps';
      default:
        return value;
    }
  }

  String _getAirwayLabelNarrative(String value) {
    switch (value) {
      case 'clear':
        return 'libres';
      case 'threatened':
        return 'à risque';
      case 'obstructed':
        return 'obstruées';
      case 'secured':
        return 'sécurisées';
      default:
        return value;
    }
  }

  String _getECGNarrativeText() {
    final parts = <String>[];

    // Rythme régulier/irrégulier + type
    final isIrregular = _ecgRhythm == 'afib' || _ecgRhythm == 'aflutter';
    parts.add(
      'rythme ${isIrregular ? 'irrégulier' : 'régulier'} ${_getEcgRhythmLabel(_ecgRhythm)}',
    );

    // Fréquence si disponible
    if (_ecgRateController.text.isNotEmpty) {
      parts.add('${_ecgRateController.text} bpm');
    }

    // Onde P
    parts.add('onde P ${_getEcgPLabel(_ecgP)}');

    // Espace PR
    parts.add('espace PR ${_getEcgPRLabel(_ecgPR)}');

    // QRS
    parts.add('QRS ${_getEcgQRSLabel(_ecgQRS)}');
    if (_ecgQRS == 'wide' && _ecgQRSDetailsController.text.isNotEmpty) {
      parts.add(_ecgQRSDetailsController.text);
    }
    if (_ecgSgarbossa) {
      parts.add('critères de Sgarbossa présents');
    }

    // Segment ST
    if (_ecgSTController.text.isEmpty) {
      parts.add('pas de trouble de la repolarisation');
    } else {
      parts.add(_ecgSTController.text);
    }

    // Onde T
    parts.add('onde T ${_getEcgTLabel(_ecgT)}');

    return parts.join(', ');
  }

  String _getSeverityDescription() {
    // Détection automatique des détresses
    final spo2 = int.tryParse(_spo2Controller.text) ?? 100;
    final rr = int.tryParse(_respiratoryRateController.text) ?? 15;
    final systolic =
        int.tryParse(_bpRightController.text.split('/').first) ?? 120;
    final glucose = double.tryParse(_glucoseController.text) ?? 1.0;

    final isRespDistress =
        spo2 < 90 || rr > 30 || rr < 10 || _workOfBreathing.isNotEmpty;
    final isHemoDistress = systolic < 90 || _shockSigns.isNotEmpty;
    final isNeuroDistress =
        _gcsTotal < 13 || _neuroDeficitController.text.isNotEmpty;
    // Detect STEMI from text (looking for "sus" keyword)
    final stLower = _ecgSTController.text.toLowerCase();
    final isSTEMI =
        stLower.contains('sus') ||
        stLower.contains('élévation') ||
        stLower.contains('stemi');
    final isHypoglycemia = glucose < 0.7;

    // Cas STEMI
    if (isSTEMI) {
      final distresses = <String>[];
      if (isRespDistress) distresses.add('respiratoire');
      if (isHemoDistress) distresses.add('hémodynamique');
      if (isNeuroDistress) distresses.add('neurologique');

      if (distresses.isEmpty) {
        return 'qui présente un STEMI sans détresse vitale.';
      } else {
        return 'qui présente un STEMI avec détresse ${distresses.join(' et ')}.';
      }
    }

    // Pas de détresse
    if (!isRespDistress && !isHemoDistress && !isNeuroDistress) {
      return 'qui ne présente aucune détresse vitale.';
    }

    // Détresse(s) présente(s)
    final distressParts = <String>[];

    if (isRespDistress) {
      final apText = _auscultationController.text.isEmpty
          ? 'MV bilatéral'
          : _auscultationController.text;
      distressParts.add('une détresse respiratoire avec à l\'AP : $apText');
    }

    if (isHemoDistress) {
      distressParts.add(
        'une détresse hémodynamique avec à l\'ECG : ${_getECGNarrativeText()}',
      );
    }

    if (isNeuroDistress) {
      final hypoText = isHypoglycemia ? 'AVEC' : 'sans';
      distressParts.add('une détresse neurologique $hypoText hypoglycémie');
    }

    return 'qui présente ${distressParts.join(' + ')}.';
  }

  // Helper methods for labels
  String _getShockSignLabel(String value) {
    switch (value) {
      case 'mottling':
        return 'marbrures';
      case 'crt':
        return 'TRC allongé';
      case 'weakPulse':
        return 'pouls faibles';
      case 'asymmetric':
        return 'pouls asymétriques';
      default:
        return value;
    }
  }

  String _getHeartFailureLabel(String value) {
    switch (value) {
      case 'jvd':
        return 'TVJ';
      case 'hjr':
        return 'RHJ';
      case 'peripheralEdema':
        return 'OMI';
      default:
        return value;
    }
  }

  String _getEcgRhythmLabel(String value) {
    switch (value) {
      case 'sinus':
        return 'sinusal';
      case 'afib':
        return 'FA';
      case 'aflutter':
        return 'flutter';
      case 'svt':
        return 'TSV';
      case 'vt':
        return 'TV';
      case 'vfib':
        return 'FV';
      case 'asystole':
        return 'asystolie';
      case 'paced':
        return 'stimulé';
      default:
        return value;
    }
  }

  String _getEcgPLabel(String value) {
    switch (value) {
      case 'normal':
        return 'normale';
      case 'ample':
        return 'ample';
      case 'biphasic':
        return 'biphasique';
      case 'absent':
        return 'absente';
      default:
        return value;
    }
  }

  String _getEcgPRLabel(String value) {
    switch (value) {
      case 'normal':
        return 'normal';
      case 'short':
        return 'court';
      case 'prolonged':
        return 'allongé';
      case 'variable':
        return 'variable';
      default:
        return value;
    }
  }

  String _getEcgQRSLabel(String value) {
    switch (value) {
      case 'narrow':
        return 'fins';
      case 'wide':
        return 'larges';
      default:
        return value;
    }
  }

  String _getEcgTLabel(String value) {
    switch (value) {
      case 'normal':
        return 'normale';
      case 'ample':
        return 'ample';
      case 'flat':
        return 'aplatie';
      case 'inverted':
        return 'inversée';
      default:
        return value;
    }
  }

  String _getOxygenDeviceLabel(String value) {
    switch (value) {
      case 'nasal':
        return 'Lunettes nasales';
      case 'simpleMask':
        return 'Masque simple';
      case 'nrb':
        return 'Masque haute concentration';
      case 'niv':
        return 'VNI';
      default:
        return value;
    }
  }

  String _getExtremitiesLabel(String value) {
    switch (value) {
      case 'warm':
        return 'Chaudes, bien perfusées';
      case 'cold':
        return 'Froides';
      case 'cyanotic':
        return 'Cyanosées';
      default:
        return value;
    }
  }

  String _getPupilsLabel(String value) {
    switch (value) {
      case 'perrl':
        return 'PERRL (isocores réactives)';
      case 'anisocoria':
        return 'Anisocorie';
      case 'fixed':
        return 'Fixes';
      default:
        return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 900;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          _buildSliverAppBar(),
        ],
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
                    SnackBar(
                      content: Text(AppStrings.successCopied),
                      backgroundColor: AppColors.success,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.accentTeal, AppColors.accentEmerald],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.description_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.medicalReportTitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Évaluation ABCDE structurée',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWideLayout() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Expanded(flex: 3, child: _buildFormSection()),
        Container(width: 1, color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
        Expanded(flex: 2, child: _buildPreviewSection()),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return Column(
      children: [
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [_buildFormSection(), _buildPreviewSection()],
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.white,
        unselectedLabelColor: isDark ? Colors.grey[400] : AppColors.textSecondary,
        indicator: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.accentTeal, AppColors.accentEmerald],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(4),
        tabs: const [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit_note, size: 20),
                SizedBox(width: 8),
                Text('Formulaire'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.preview, size: 20),
                SizedBox(width: 8),
                Text('Aperçu'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildStepperCard(),
            const SizedBox(height: 24),
            _buildGenerateButton(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildStepperCard() {
    final steps = [
      _StepData('Identité', Icons.person, _buildIdentityContent()),
      _StepData('Contexte', Icons.warning_amber, _buildContextContent()),
      _StepData('A - Voies Aériennes', Icons.air, _buildAirwayContent()),
      _StepData(
        'B - Respiration',
        Icons.monitor_heart,
        _buildBreathingContent(),
      ),
      _StepData('C - Circulation', Icons.favorite, _buildCirculationContent()),
      _StepData('D - Neurologie', Icons.psychology, _buildDisabilityContent()),
      _StepData('E - Exposition', Icons.visibility, _buildExposureContent()),
    ];

    return Column(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        return _buildAnimatedStepCard(step, index);
      }).toList(),
    );
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
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  initiallyExpanded: index == 0,
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _getStepColor(index),
                          _getStepColor(index).withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(step.icon, color: Colors.white, size: 20),
                  ),
                  title: Text(
                    step.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isDark ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: step.content,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getStepColor(int index) {
    final colors = [
      AppColors.primary,
      AppColors.warning,
      AppColors.info,
      AppColors.accentTeal,
      AppColors.error,
      AppColors.accentPurple,
      AppColors.accentEmerald,
    ];
    return colors[index % colors.length];
  }

  Widget _buildIdentityContent() {
    return Column(
      children: [
        _buildTextField(
          controller: _patientNameController,
          label: 'Nom du Patient',
          icon: Icons.person_outline,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildDropdownField(
                value: _gender,
                label: AppStrings.sex,
                icon: Icons.wc,
                items: const [
                  DropdownMenuItem(value: 'male', child: Text('Homme')),
                  DropdownMenuItem(value: 'female', child: Text('Femme')),
                ],
                onChanged: (v) => setState(() => _gender = v!),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _ageController,
                label: AppStrings.age,
                icon: Icons.cake_outlined,
                suffix: AppStrings.years,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _motifController,
          label: 'Motif de consultation',
          icon: Icons.local_hospital_outlined,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildContextContent() {
    return Column(
      children: [
        _buildSwitchTile(
          title: 'Contexte Traumatique',
          subtitle: 'Activer pour ajouter les détails du trauma',
          value: _isTrauma,
          icon: Icons.warning_amber_rounded,
          color: AppColors.warning,
          onChanged: (v) => setState(() => _isTrauma = v),
        ),
        if (_isTrauma) ...[
          const SizedBox(height: 16),
          _buildTextField(
            controller: _mecanismeController,
            label: 'Mécanisme lésionnel',
            icon: Icons.car_crash_outlined,
            maxLines: 2,
          ),
        ],
      ],
    );
  }

  Widget _buildAirwayContent() {
    return Column(
      children: [
        _buildDropdownField(
          value: _airwayStatus,
          label: 'État des voies aériennes',
          icon: Icons.air,
          items: const [
            DropdownMenuItem(value: 'clear', child: Text('Libres')),
            DropdownMenuItem(value: 'obstructed', child: Text('Obstruées')),
            DropdownMenuItem(value: 'threatened', child: Text('Menacées')),
          ],
          onChanged: (v) => setState(() => _airwayStatus = v!),
        ),
        if (_airwayStatus != 'clear') ...[
          const SizedBox(height: 16),
          _buildTextField(
            controller: _airwayDeviceController,
            label: 'Dispositif / Action',
            icon: Icons.medical_services_outlined,
          ),
        ],
      ],
    );
  }

  Widget _buildBreathingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // FR & SpO2
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _respiratoryRateController,
                label: 'FR (/min)',
                icon: Icons.speed,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _spo2Controller,
                label: 'SpO2 (%)',
                icon: Icons.air,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),

        // Work of Breathing
        const SizedBox(height: 16),
        Text(
          'Signes de lutte',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildChip(
              'Tirage sus-sternal',
              'suprasternal',
              _workOfBreathing,
              (v) => setState(() {
                if (_workOfBreathing.contains(v))
                  _workOfBreathing.remove(v);
                else
                  _workOfBreathing.add(v);
              }),
            ),
            _buildChip(
              'Tirage sous-costal',
              'subcostal',
              _workOfBreathing,
              (v) => setState(() {
                if (_workOfBreathing.contains(v))
                  _workOfBreathing.remove(v);
                else
                  _workOfBreathing.add(v);
              }),
            ),
            _buildChip(
              'Tirage intercostal',
              'intercostal',
              _workOfBreathing,
              (v) => setState(() {
                if (_workOfBreathing.contains(v))
                  _workOfBreathing.remove(v);
                else
                  _workOfBreathing.add(v);
              }),
            ),
            _buildChip(
              'Balancement',
              'paradoxical',
              _workOfBreathing,
              (v) => setState(() {
                if (_workOfBreathing.contains(v))
                  _workOfBreathing.remove(v);
                else
                  _workOfBreathing.add(v);
              }),
            ),
            _buildChip(
              'Gasping',
              'gasping',
              _workOfBreathing,
              (v) => setState(() {
                if (_workOfBreathing.contains(v))
                  _workOfBreathing.remove(v);
                else
                  _workOfBreathing.add(v);
              }),
            ),
          ],
        ),

        // Chest expansion
        const SizedBox(height: 16),
        _buildDropdownField(
          value: _chestExpansion,
          label: 'Ampliation thoracique',
          icon: Icons.open_with,
          items: const [
            DropdownMenuItem(value: 'symmetric', child: Text('Symétrique')),
            DropdownMenuItem(value: 'asymmetric', child: Text('Asymétrique')),
          ],
          onChanged: (v) => setState(() => _chestExpansion = v!),
        ),

        // Trauma specific fields
        if (_isTrauma) ...[
          const SizedBox(height: 16),
          _buildTextField(
            controller: _traumaRibsController,
            label: 'Crépitations costales',
            icon: Icons.broken_image_outlined,
            hint: 'Localisation (ex: K5-K7 gauche)',
          ),
          const SizedBox(height: 12),
          _buildSwitchTile(
            title: 'Emphysème sous-cutané',
            subtitle: 'Crépitation neigeuse à la palpation',
            value: _traumaEmphysema,
            icon: Icons.bubble_chart,
            color: AppColors.warning,
            onChanged: (v) => setState(() => _traumaEmphysema = v),
          ),
        ],

        // Auscultation
        const SizedBox(height: 16),
        _buildTextField(
          controller: _auscultationController,
          label: 'Auscultation pulmonaire',
          icon: Icons.hearing,
          hint:
              'Ex: MV symétrique, crépitants bases bilat., sibilants diffus...',
          maxLines: 2,
        ),

        // Oxygen therapy
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildDropdownField(
                value: _oxygenDevice,
                label: 'Dispositif O2',
                icon: Icons.masks_outlined,
                items: const [
                  DropdownMenuItem(value: '', child: Text('Aucun')),
                  DropdownMenuItem(
                    value: 'nasal',
                    child: Text('Lunettes nasales'),
                  ),
                  DropdownMenuItem(
                    value: 'simpleMask',
                    child: Text('Masque simple'),
                  ),
                  DropdownMenuItem(value: 'nrb', child: Text('Masque HC')),
                  DropdownMenuItem(value: 'niv', child: Text('VNI')),
                ],
                onChanged: (v) => setState(() => _oxygenDevice = v!),
              ),
            ),
            if (_oxygenDevice.isNotEmpty) ...[
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  controller: _oxygenFlowController,
                  label: 'Débit (L/min)',
                  icon: Icons.speed,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ],
        ),

        // Action field
        const SizedBox(height: 16),
        _buildTextField(
          controller: _breathingActionController,
          label: 'Conduite tenue (B)',
          icon: Icons.medical_services,
          hint: 'Ex: IOT, drainage thoracique...',
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildChip(
    String label,
    String value,
    List<String> selected,
    Function(String) onTap,
  ) {
    final isSelected = selected.contains(value);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => onTap(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accentTeal.withOpacity(isDark ? 0.25 : 0.15)
              : (isDark ? AppColors.cardDark : AppColors.backgroundLight),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.accentTeal : (isDark ? Colors.grey.shade700 : Colors.grey.shade300),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? AppColors.accentTeal : (isDark ? Colors.grey[400] : AppColors.textSecondary),
          ),
        ),
      ),
    );
  }

  Widget _buildCirculationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Extremities
        _buildDropdownField(
          value: _extremities,
          label: 'Extrémités',
          icon: Icons.back_hand_outlined,
          items: const [
            DropdownMenuItem(
              value: 'warm',
              child: Text('Chaudes, bien perfusées'),
            ),
            DropdownMenuItem(value: 'cold', child: Text('Froides')),
            DropdownMenuItem(value: 'cyanotic', child: Text('Cyanosées')),
          ],
          onChanged: (v) => setState(() => _extremities = v!),
        ),

        // Shock signs
        const SizedBox(height: 16),
        Text(
          'Signes de choc périphérique',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildChip(
              'Marbrures',
              'mottling',
              _shockSigns,
              (v) => setState(() {
                if (_shockSigns.contains(v))
                  _shockSigns.remove(v);
                else
                  _shockSigns.add(v);
              }),
            ),
            _buildChip(
              'TRC > 3s',
              'crt',
              _shockSigns,
              (v) => setState(() {
                if (_shockSigns.contains(v))
                  _shockSigns.remove(v);
                else
                  _shockSigns.add(v);
              }),
            ),
            _buildChip(
              'Pouls faible',
              'weakPulse',
              _shockSigns,
              (v) => setState(() {
                if (_shockSigns.contains(v))
                  _shockSigns.remove(v);
                else
                  _shockSigns.add(v);
              }),
            ),
            _buildChip(
              'Asymétrie pouls',
              'asymmetric',
              _shockSigns,
              (v) => setState(() {
                if (_shockSigns.contains(v))
                  _shockSigns.remove(v);
                else
                  _shockSigns.add(v);
              }),
            ),
          ],
        ),

        // Heart failure signs
        const SizedBox(height: 16),
        Text(
          'Signes de cœur droit',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildChip(
              'Turgescence jugulaire',
              'jvd',
              _heartFailureSigns,
              (v) => setState(() {
                if (_heartFailureSigns.contains(v))
                  _heartFailureSigns.remove(v);
                else
                  _heartFailureSigns.add(v);
              }),
            ),
            _buildChip(
              'RHJ',
              'hjr',
              _heartFailureSigns,
              (v) => setState(() {
                if (_heartFailureSigns.contains(v))
                  _heartFailureSigns.remove(v);
                else
                  _heartFailureSigns.add(v);
              }),
            ),
            _buildChip(
              'OMI',
              'peripheralEdema',
              _heartFailureSigns,
              (v) => setState(() {
                if (_heartFailureSigns.contains(v))
                  _heartFailureSigns.remove(v);
                else
                  _heartFailureSigns.add(v);
              }),
            ),
          ],
        ),

        // Blood pressure
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _bpRightController,
                label: 'TA Droite',
                icon: Icons.favorite_border,
                hint: '120/80',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _bpLeftController,
                label: 'TA Gauche',
                icon: Icons.favorite_border,
                hint: '120/80',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _pulseController,
          label: 'FC (bpm)',
          icon: Icons.monitor_heart_outlined,
          keyboardType: TextInputType.number,
        ),

        // ECG Section
        const SizedBox(height: 20),
        _buildECGSection(),
      ],
    );
  }

  Widget _buildECGSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.error.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.monitor_heart, color: AppColors.error, size: 20),
              const SizedBox(width: 8),
              const Text(
                'ECG',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Rhythm
          Row(
            children: [
              Expanded(
                child: _buildDropdownField(
                  value: _ecgRhythm,
                  label: 'Rythme',
                  icon: Icons.timeline,
                  items: const [
                    DropdownMenuItem(value: 'sinus', child: Text('Sinusal')),
                    DropdownMenuItem(
                      value: 'irregular',
                      child: Text('Irrégulier'),
                    ),
                    DropdownMenuItem(value: 'af', child: Text('FA')),
                    DropdownMenuItem(value: 'flutter', child: Text('Flutter')),
                  ],
                  onChanged: (v) => setState(() => _ecgRhythm = v!),
                ),
              ),
              if (_ecgRhythm == 'af' || _ecgRhythm == 'flutter') ...[
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _ecgRateController,
                    label: 'FC ventriculaire',
                    icon: Icons.speed,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ],
          ),

          // P wave, PR, T wave
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildMiniDropdown(
                  'Onde P',
                  _ecgP,
                  ['normal', 'ample', 'biphasic'],
                  ['Normale', 'Ample', 'Biphasique'],
                  (v) => setState(() => _ecgP = v),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildMiniDropdown(
                  'PR',
                  _ecgPR,
                  ['normal', 'prolonged', 'short'],
                  ['Normal', 'Allongé', 'Court'],
                  (v) => setState(() => _ecgPR = v),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildMiniDropdown(
                  'Onde T',
                  _ecgT,
                  ['normal', 'ample', 'flat', 'inverted'],
                  ['Normale', 'Ample', 'Plate', 'Inversée'],
                  (v) => setState(() => _ecgT = v),
                ),
              ),
            ],
          ),

          // QRS
          const SizedBox(height: 12),
          _buildDropdownField(
            value: _ecgQRS,
            label: 'QRS',
            icon: Icons.show_chart,
            items: const [
              DropdownMenuItem(value: 'narrow', child: Text('Fins (< 120ms)')),
              DropdownMenuItem(value: 'wide', child: Text('Larges (≥ 120ms)')),
            ],
            onChanged: (v) => setState(() => _ecgQRS = v!),
          ),
          if (_ecgQRS == 'wide') ...[
            const SizedBox(height: 12),
            _buildTextField(
              controller: _ecgQRSDetailsController,
              label: 'Type de bloc',
              icon: Icons.notes,
              hint: 'BBD, BBG, HBAG...',
            ),
            const SizedBox(height: 8),
            _buildSwitchTile(
              title: 'Critères de Sgarbossa',
              subtitle: 'Discordance ST > 5mm ou concordance',
              value: _ecgSgarbossa,
              icon: Icons.warning_amber,
              color: AppColors.error,
              onChanged: (v) => setState(() => _ecgSgarbossa = v),
            ),
          ],

          // ST segment
          const SizedBox(height: 12),
          _buildTextField(
            controller: _ecgSTController,
            label: 'Segment ST',
            icon: Icons.trending_up,
            hint:
                'Ex: isoélectrique, sus-décalage V1-V4, sous-décalage latéral...',
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildMiniDropdown(
    String label,
    String value,
    List<String> values,
    List<String> labels,
    Function(String) onChanged,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: isDark ? Colors.grey[400] : AppColors.textSecondary),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: isDark ? AppColors.cardDark : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              isDense: true,
              dropdownColor: isDark ? AppColors.cardDark : Colors.white,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white : AppColors.textPrimary,
              ),
              items: List.generate(
                values.length,
                (i) =>
                    DropdownMenuItem(value: values[i], child: Text(labels[i])),
              ),
              onChanged: (v) => onChanged(v!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDisabilityContent() {
    return Column(
      children: [
        _buildGCSSection(),
        const SizedBox(height: 16),

        // Pupils dropdown
        _buildDropdownField(
          value: _pupils,
          label: 'Pupilles',
          icon: Icons.visibility,
          items: const [
            DropdownMenuItem(
              value: 'perrl',
              child: Text('PERRL (isocores réactives)'),
            ),
            DropdownMenuItem(value: 'anisocoria', child: Text('Anisocorie')),
            DropdownMenuItem(value: 'fixed', child: Text('Fixes')),
          ],
          onChanged: (v) => setState(() => _pupils = v!),
        ),

        // Pupils details - shown when abnormal
        if (_pupils != 'perrl') ...[
          const SizedBox(height: 12),
          _buildTextField(
            controller: _pupilsDetailsController,
            label: 'Détails pupilles',
            icon: Icons.remove_red_eye,
          ),
        ],

        const SizedBox(height: 16),

        // Neuro deficit text field
        _buildTextField(
          controller: _neuroDeficitController,
          label: 'Déficit neurologique',
          icon: Icons.accessibility_new,
          hint: 'Ex: pas de déficit, hémiparésie D, paraplégie...',
          maxLines: 2,
        ),

        // Aphasia checkbox
        const SizedBox(height: 12),
        _buildAphasiaCheckbox(),

        const SizedBox(height: 16),

        // Blood glucose field
        _buildTextField(
          controller: _glucoseController,
          label: 'Glycémie capillaire (g/L)',
          icon: Icons.bloodtype,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),

        const SizedBox(height: 16),

        // Warning signs section (meningitis/purpura fulminans)
        _buildWarningSigns(),
      ],
    );
  }

  Widget _buildAphasiaCheckbox() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _aphasia
            ? AppColors.accentPurple.withOpacity(isDark ? 0.2 : 0.1)
            : (isDark ? AppColors.cardDark : AppColors.backgroundLight),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _aphasia
              ? AppColors.accentPurple.withOpacity(0.3)
              : (isDark ? Colors.grey.shade700 : Colors.grey.shade200),
        ),
      ),
      child: InkWell(
        onTap: () => setState(() => _aphasia = !_aphasia),
        child: Row(
          children: [
            Icon(
              Icons.speaker_notes_off,
              color: _aphasia
                  ? AppColors.accentPurple
                  : (isDark ? Colors.grey[400] : AppColors.textSecondary),
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Aphasie associée',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: _aphasia
                    ? AppColors.accentPurple
                    : (isDark ? Colors.white : AppColors.textPrimary),
              ),
            ),
            const Spacer(),
            Checkbox(
              value: _aphasia,
              onChanged: (v) => setState(() => _aphasia = v ?? false),
              activeColor: AppColors.accentPurple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningSigns() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.warning.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber, color: AppColors.warning, size: 20),
              const SizedBox(width: 8),
              Text(
                'Signes d\'alerte',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Meningeal signs
          InkWell(
            onTap: () => setState(() => _meningealSigns = !_meningealSigns),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Checkbox(
                    value: _meningealSigns,
                    onChanged: (v) =>
                        setState(() => _meningealSigns = v ?? false),
                    activeColor: AppColors.warning,
                  ),
                  Icon(
                    Icons.healing,
                    size: 20,
                    color: _meningealSigns
                        ? AppColors.warning
                        : AppColors.textSecondary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Syndrome méningé',
                    style: TextStyle(
                      color: _meningealSigns
                          ? AppColors.warning
                          : AppColors.textPrimary,
                      fontWeight: _meningealSigns
                          ? FontWeight.w500
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Purpura
          InkWell(
            onTap: () => setState(() => _purpura = !_purpura),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Checkbox(
                    value: _purpura,
                    onChanged: (v) => setState(() => _purpura = v ?? false),
                    activeColor: Colors.red,
                  ),
                  Icon(
                    Icons.bubble_chart,
                    size: 20,
                    color: _purpura ? Colors.red : AppColors.textSecondary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Purpura',
                    style: TextStyle(
                      color: _purpura ? Colors.red : AppColors.textPrimary,
                      fontWeight: _purpura
                          ? FontWeight.w500
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGCSSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accentPurple.withOpacity(isDark ? 0.15 : 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accentPurple.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.psychology,
                    color: AppColors.accentPurple,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Score de Glasgow (GCS)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isDark ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.accentPurple, AppColors.primary],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$_gcsTotal/15',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildGCSDropdown(
                  'Yeux (E)',
                  _gcsE,
                  4,
                  (v) => setState(() => _gcsE = v!),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildGCSDropdown(
                  'Verbal (V)',
                  _gcsV,
                  5,
                  (v) => setState(() => _gcsV = v!),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildGCSDropdown(
                  'Moteur (M)',
                  _gcsM,
                  6,
                  (v) => setState(() => _gcsM = v!),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGCSDropdown(
    String label,
    int value,
    int max,
    ValueChanged<int?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: value,
              isExpanded: true,
              items: List.generate(
                max,
                (i) => DropdownMenuItem(
                  value: i + 1,
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExposureContent() {
    return Column(
      children: [
        _buildTextField(
          controller: _hdmController,
          label: 'Histoire de la maladie (HDM)',
          icon: Icons.history_edu,
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _antecedentsController,
          label: 'Antécédents',
          icon: Icons.medical_information_outlined,
          maxLines: 2,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildCheckboxTile(
                title: 'Tabac',
                value: _tabac,
                icon: Icons.smoking_rooms,
                onChanged: (v) => setState(() => _tabac = v!),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildCheckboxTile(
                title: 'Alcool',
                value: _alcool,
                icon: Icons.local_bar,
                onChanged: (v) => setState(() => _alcool = v!),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? suffix,
    String? hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade200),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 15, color: isDark ? Colors.white : AppColors.textPrimary),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(color: isDark ? Colors.grey[400] : AppColors.textSecondary, fontSize: 14),
          hintStyle: TextStyle(color: isDark ? Colors.grey[600] : AppColors.textHint),
          suffixText: suffix,
          prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField<T>({
    required T value,
    required String label,
    required IconData icon,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade200),
      ),
      child: DropdownButtonFormField<T>(
        value: value,
        isExpanded: true,
        items: items,
        onChanged: onChanged,
        dropdownColor: isDark ? AppColors.cardDark : Colors.white,
        style: TextStyle(color: isDark ? Colors.white : AppColors.textPrimary),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: isDark ? Colors.grey[400] : AppColors.textSecondary, fontSize: 14),
          prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required IconData icon,
    required Color color,
    required ValueChanged<bool> onChanged,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: value ? color.withOpacity(isDark ? 0.2 : 0.1) : (isDark ? AppColors.cardDark : AppColors.backgroundLight),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value ? color.withOpacity(0.3) : (isDark ? Colors.grey.shade700 : Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: value ? color.withOpacity(0.2) : (isDark ? Colors.grey.shade800 : Colors.grey.shade100),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: value ? color : (isDark ? Colors.grey[400] : AppColors.textSecondary),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: value ? color : (isDark ? Colors.white : AppColors.textPrimary),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey[400] : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged, activeColor: color),
        ],
      ),
    );
  }

  Widget _buildCheckboxTile({
    required String title,
    required bool value,
    required IconData icon,
    required ValueChanged<bool?> onChanged,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: value
            ? AppColors.warning.withOpacity(isDark ? 0.2 : 0.1)
            : (isDark ? AppColors.cardDark : AppColors.backgroundLight),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value
              ? AppColors.warning.withOpacity(0.3)
              : (isDark ? Colors.grey.shade700 : Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: value ? AppColors.warning : AppColors.textSecondary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: value ? AppColors.warning : AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.warning,
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.accentTeal, AppColors.accentEmerald],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentTeal.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: _generateReport,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.description_rounded, color: Colors.white),
                const SizedBox(width: 12),
                Text(
                  AppStrings.generateReport,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewSection() {
    return Container(
      color: AppColors.backgroundLight,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.preview, color: AppColors.accentTeal),
              const SizedBox(width: 8),
              Text(
                'Aperçu du Rapport',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              if (_generatedReport.isNotEmpty)
                IconButton(
                  icon: Icon(Icons.copy, color: AppColors.primary),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: _generatedReport));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppStrings.successCopied),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: _generatedReport.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.description_outlined,
                            size: 64,
                            color: AppColors.textHint,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Le rapport apparaîtra ici',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Remplissez le formulaire et cliquez sur "Générer"',
                            style: TextStyle(
                              color: AppColors.textHint,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: SelectableText(
                        _generatedReport,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 13,
                          height: 1.5,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepData {
  final String title;
  final IconData icon;
  final Widget content;

  _StepData(this.title, this.icon, this.content);
}
