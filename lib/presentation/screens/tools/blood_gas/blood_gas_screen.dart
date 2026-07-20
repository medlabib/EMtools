import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../core/l10n/localized.dart';
import '../../../../core/widgets/animated_widgets.dart';
import '../../../../domain/entities/blood_gas.dart';

class BloodGasScreen extends StatefulWidget {
  const BloodGasScreen({super.key});

  @override
  State<BloodGasScreen> createState() => _BloodGasScreenState();
}

class _BloodGasScreenState extends State<BloodGasScreen>
    with TickerProviderStateMixin {
  BloodGasPatientData _data = const BloodGasPatientData();
  late BloodGasResults _results;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _calculate();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _calculate() {
    setState(() {
      _results = BloodGasCalculator.calculate(_data);
    });
  }

  void _update(BloodGasPatientData newData) {
    _data = newData;
    _calculate();
  }

  void _reset() {
    setState(() {
      _data = const BloodGasPatientData();
    });
    _calculate();
  }

  Color _getStatusColor(AcidBaseStatus status) {
    switch (status) {
      case AcidBaseStatus.acidosis:
        return AppColors.error;
      case AcidBaseStatus.alkalosis:
        return AppColors.warning;
      case AcidBaseStatus.normal:
        return AppColors.success;
      case AcidBaseStatus.compensated:
        return AppColors.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: _buildHeader(context),
          ),

          // Results Summary Card
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            sliver: SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: _buildResultsSummary(context, isDark),
              ),
            ),
          ),

          // Detailed Results Grid
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            sliver: SliverToBoxAdapter(
              child: AnimatedListItem(
                index: 0,
                child: _buildDetailedResults(context, isDark),
              ),
            ),
          ),

          // Input Sections
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            sliver: SliverToBoxAdapter(
              child: AnimatedListItem(
                index: 1,
                child: _buildPatientSection(context, isDark),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            sliver: SliverToBoxAdapter(
              child: AnimatedListItem(
                index: 2,
                child: _buildGasSection(context, isDark),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            sliver: SliverToBoxAdapter(
              child: AnimatedListItem(
                index: 3,
                child: _buildBioSection(context, isDark),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            sliver: SliverToBoxAdapter(
              child: AnimatedListItem(
                index: 4,
                child: _buildVentilatorSection(context, isDark),
              ),
            ),
          ),

          // References Section
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
            sliver: SliverToBoxAdapter(
              child: AnimatedListItem(
                index: 5,
                child: _buildReferencesSection(context, isDark),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 12,
        20,
        24,
      ),
      decoration: BoxDecoration(
        color: AppColors.getCardColor(isDark),
        border: Border(
          bottom: BorderSide(color: AppColors.getBorderColor(isDark)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _reset,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.refresh_rounded,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.air,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.bloodGasTitle,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.getTextPrimary(isDark),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      context.t('completeAnalysis'),
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.getTextSecondary(isDark),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultsSummary(BuildContext context, bool isDark) {
    final statusColor = _getStatusColor(_results.status);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.analytics_outlined,
                  color: statusColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.t('diagnosis'),
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      context.tr(BloodGasResultLocalizer.status(_results.status)),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark 
                  ? Colors.black.withValues(alpha: 0.2) 
                  : Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildSummaryRow(
                  context.t('primaryDisorder'),
                  context.tr(BloodGasResultLocalizer.primary(_results.primary)),
                  statusColor,
                  isDark,
                ),
                if (context.tr(BloodGasResultLocalizer.combinedMessage(_results)).isNotEmpty) ...[
                  const SizedBox(height: 8),
                  _buildSummaryRow(
                    context.t('compensation'),
                    context.tr(BloodGasResultLocalizer.combinedMessage(_results)),
                    AppColors.info,
                    isDark,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, Color color, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedResults(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                context.t('calculatedParameters'),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.6,
          children: [
            _buildMetricCard(
              context.t('correctedAnionGap'),
              _results.agCorrected.toStringAsFixed(1),
              'mEq/L',
              Icons.show_chart_rounded,
              _results.agCorrected > 12 ? AppColors.warning : AppColors.success,
              isDark,
            ),
            _buildMetricCard(
              context.t('paoFio2Ratio'),
              _results.pfRatio.toStringAsFixed(0),
              context.tr(BloodGasResultLocalizer.ardsGrade(_results.ardsGrade)),
              Icons.air,
              _results.pfRatio < 300 ? AppColors.error : AppColors.success,
              isDark,
            ),
            _buildMetricCard(
              context.t('vtPerKgPBW'),
              _results.vtPerKg.toStringAsFixed(1),
              'ml/kg',
              Icons.straighten_rounded,
              _results.vtPerKg > 8 ? AppColors.warning : AppColors.success,
              isDark,
            ),
            _buildMetricCard(
              context.t('drivingPressureMetric'),
              _results.drivingPressure.toStringAsFixed(0),
              'cmH₂O',
              Icons.speed_rounded,
              _results.drivingPressure > 15 ? AppColors.warning : AppColors.success,
              isDark,
            ),
            _buildMetricCard(
              context.t('aaGradient'),
              _results.aaGradient.toStringAsFixed(1),
              'mmHg',
              Icons.compare_arrows_rounded,
              _results.aaGradient > _results.expectedAa ? AppColors.warning : AppColors.success,
              isDark,
            ),
            _buildMetricCard(
              context.t('caO2'),
              _results.cao2.toStringAsFixed(1),
              'mL/dL',
              Icons.opacity_rounded,
              _results.cao2 < 16 ? AppColors.error : AppColors.success,
              isDark,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String label,
    String value,
    String unit,
    IconData icon,
    Color color,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.getBorderColor(isDark)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  unit,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPatientSection(BuildContext context, bool isDark) {
    return _buildSection(
      context,
      isDark,
      AppStrings.patientInfo,
      Icons.person_outline_rounded,
      AppColors.primaryBlue,
      [
        Row(
          children: [
            Expanded(
              child: _buildSelectField(
                AppStrings.sex,
                _data.gender,
                [
                  ('male', AppStrings.male),
                  ('female', AppStrings.female),
                ],
                (v) => _update(_data.copyWith(gender: v)),
                isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildNumberInput(
                AppStrings.height,
                'cm',
                _data.height,
                (v) => _update(_data.copyWith(height: v)),
                isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildNumberInput(
                AppStrings.age,
                AppStrings.years,
                _data.age,
                (v) => _update(_data.copyWith(age: v)),
                isDark,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGasSection(BuildContext context, bool isDark) {
    return _buildSection(
      context,
      isDark,
      context.t('bloodGasSection'),
      Icons.air,
      AppColors.error,
      [
        Row(
          children: [
            Expanded(
              child: _buildNumberInput(
                AppStrings.pH,
                '',
                _data.ph,
                (v) => _update(_data.copyWith(ph: v)),
                isDark,
                decimals: 2,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildNumberInput(
                AppStrings.pCO2,
                'mmHg',
                _data.paco2,
                (v) => _update(_data.copyWith(paco2: v)),
                isDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildNumberInput(
                AppStrings.pO2,
                'mmHg',
                _data.pao2,
                (v) => _update(_data.copyWith(pao2: v)),
                isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildNumberInput(
                AppStrings.hCO3,
                'mEq/L',
                _data.hco3,
                (v) => _update(_data.copyWith(hco3: v)),
                isDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildNumberInput(
                AppStrings.saturation,
                '%',
                _data.sao2,
                (v) => _update(_data.copyWith(sao2: v)),
                isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildNumberInput(
                AppStrings.lactate,
                'mmol/L',
                _data.lactate,
                (v) => _update(_data.copyWith(lactate: v)),
                isDark,
                decimals: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBioSection(BuildContext context, bool isDark) {
    return _buildSection(
      context,
      isDark,
      context.t('biochemistrySection'),
      Icons.science_outlined,
      AppColors.accentTeal,
      [
        Row(
          children: [
            Expanded(
              child: _buildNumberInput(
                AppStrings.sodium,
                'mEq/L',
                _data.na,
                (v) => _update(_data.copyWith(na: v)),
                isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildNumberInput(
                AppStrings.chloride,
                'mEq/L',
                _data.cl,
                (v) => _update(_data.copyWith(cl: v)),
                isDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildNumberInput(
                context.t('albumin'),
                'g/dL',
                _data.alb,
                (v) => _update(_data.copyWith(alb: v)),
                isDark,
                decimals: 1,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildNumberInput(
                AppStrings.hemoglobin,
                'g/dL',
                _data.hb,
                (v) => _update(_data.copyWith(hb: v)),
                isDark,
                decimals: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVentilatorSection(BuildContext context, bool isDark) {
    return _buildSection(
      context,
      isDark,
      context.t('ventilatorSection'),
      Icons.medication_outlined,
      AppColors.primaryPurple,
      [
        Row(
          children: [
            Expanded(
              child: _buildNumberInput(
                AppStrings.fio2,
                '%',
                _data.fio2 * 100,
                (v) => _update(_data.copyWith(fio2: v / 100)),
                isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildNumberInput(
                context.t('vt'),
                'mL',
                _data.vt,
                (v) => _update(_data.copyWith(vt: v)),
                isDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildNumberInput(
                context.t('respiratoryRateLabel'),
                '/min',
                _data.rr,
                (v) => _update(_data.copyWith(rr: v)),
                isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildNumberInput(
                context.t('peep'),
                'cmH₂O',
                _data.peep,
                (v) => _update(_data.copyWith(peep: v)),
                isDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildNumberInput(
                context.t('pplat'),
                'cmH₂O',
                _data.pplat,
                (v) => _update(_data.copyWith(pplat: v)),
                isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildNumberInput(
                context.t('ppeak'),
                'cmH₂O',
                _data.ppeak,
                (v) => _update(_data.copyWith(ppeak: v)),
                isDark,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context,
    bool isDark,
    String title,
    IconData icon,
    Color color,
    List<Widget> children,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.getBorderColor(isDark)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildReferencesSection(BuildContext context, bool isDark) {
    final references = [
      (
        context.t('winterFormula'),
        'Compensation respiratoire attendue pour l\'acidose métabolique',
        'Winter SD et al. Ann Intern Med. 1967;66(2):312-322',
      ),
      (
        context.t('aaGradientRef'),
        'P(A-a)O2 = PAO2 - PaO2, Normal < 2.5 + (0.21 × âge)',
        'Kanber GJ et al. Chest. 1986;89(2):241-248',
      ),
      (
        context.t('pfRatioBerlin'),
        'ARDS léger: 200-300, modéré: 100-200, sévère: <100',
        'The ARDS Definition Task Force. JAMA. 2012;307(23):2526-2533',
      ),
      (
        context.t('arterialO2Content'),
        'CaO2 = (Hb × 1.34 × SaO2/100) + (0.003 × PaO2)',
        'West JB. Respiratory Physiology. 10th ed. 2016',
      ),
      (
        context.t('adrogueMadiasFormula'),
        'Correction des dysnatrémies avec calcul du déficit/excès en eau libre',
        'Adrogue HJ, Madias NE. N Engl J Med. 2000;342(20):1493-1499',
      ),
      (
        context.t('pbwFormula'),
        'Male: 50 + 0.91(H-152.4), Female: 45.5 + 0.91(H-152.4)',
        'ARDSNet Protocol. N Engl J Med. 2000;342:1301-1308',
      ),
    ];

    return _buildSection(
      context,
      isDark,
      context.t('referencesFormulas'),
      Icons.library_books_outlined,
      AppColors.info,
      [
        ...references.map((ref) => _buildReferenceItem(
          ref.$1, 
          ref.$2, 
          ref.$3, 
          isDark,
        )),
        const SizedBox(height: 12),
        Text(
          context.t('disclaimerTool'),
          style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: isDark ? Colors.grey[500] : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildReferenceItem(
    String title, 
    String description, 
    String source, 
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.grey[400] : Colors.grey[700],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            source,
            style: TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: isDark ? Colors.grey[500] : Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberInput(
    String label,
    String unit,
    double value,
    Function(double) onChanged,
    bool isDark, {
    int decimals = 0,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            if (unit.isNotEmpty) ...[
              const SizedBox(width: 4),
              Text(
                '($unit)',
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? Colors.grey[500] : Colors.grey[500],
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: isDark 
                ? Colors.black.withValues(alpha: 0.2) 
                : Colors.grey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            initialValue: decimals > 0 
                ? value.toStringAsFixed(decimals) 
                : value.toStringAsFixed(0),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
            ],
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
            onChanged: (v) {
              final parsed = double.tryParse(v);
              if (parsed != null) onChanged(parsed);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSelectField(
    String label,
    String value,
    List<(String, String)> options,
    Function(String) onChanged,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: isDark 
                ? Colors.black.withValues(alpha: 0.2) 
                : Colors.grey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<String>(
            initialValue: value,
            isExpanded: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: options.map((option) {
              return DropdownMenuItem(
                value: option.$1,
                child: Text(
                  option.$2,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              );
            }).toList(),
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
          ),
        ),
      ],
    );
  }
}
