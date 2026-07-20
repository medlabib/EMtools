import 'package:flutter/material.dart';
import '../../../../domain/entities/metabolic.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../core/l10n/localized.dart';

class MetabolicScreen extends StatefulWidget {
  const MetabolicScreen({super.key});

  @override
  State<MetabolicScreen> createState() => _MetabolicScreenState();
}

class _MetabolicScreenState extends State<MetabolicScreen> 
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;

  // Common State
  double _weight = 70;
  Sex _sex = Sex.male;
  AgeGroup _ageGroup = AgeGroup.adult;

  // Sodium State
  double _baselineNa = 160;
  double _targetNa = 150;
  SodiumDirection _naDirection = SodiumDirection.hyper;
  CorrectionMode _naMode = CorrectionMode.chronic;
  final double _urineOutput = 1000;
  final double _insensibleLoss = 800;
  IVFluid _fluidA = MetabolicCalculator.ivFluids[0]; // D5W
  IVFluid _fluidB = MetabolicCalculator.ivFluids[4]; // NS

  // Potassium State
  double _kLevel = 6.5;
  final Set<String> _selectedECG = {};

  // Calcium State
  double _totalCalcium = 7.5;
  double _albumin = 4.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          _buildSliverAppBar(),
        ],
        body: Column(
          children: [
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildSodiumTab(),
                  _buildPotassiumTab(),
                  _buildCalciumTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverAppBar(
      expandedHeight: 140,
      pinned: true,
      backgroundColor: AppColors.getCardColor(isDark),
      foregroundColor: AppColors.getTextPrimary(isDark),
      surfaceTintColor: AppColors.getCardColor(isDark),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: AppColors.getTextPrimary(isDark)),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: AppColors.getCardColor(isDark),
            border: Border(
              bottom: BorderSide(color: AppColors.getBorderColor(isDark)),
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
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.science_rounded,
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
                              context.t('metabolicDisorders'),
                              style: TextStyle(
                                color: AppColors.getTextPrimary(isDark),
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              context.t('metabolicSubtitle'),
                              style: TextStyle(
                                color: AppColors.getTextSecondary(isDark),
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

  Widget _buildTabBar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? AppColors.cardDark : Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: AppColors.accentPurple,
        unselectedLabelColor: isDark ? Colors.grey[400] : AppColors.textSecondary,
        indicatorColor: AppColors.accentPurple,
        indicatorWeight: 3,
        tabs: [
          Tab(icon: const Icon(Icons.water_drop_outlined), text: context.t('sodiumTab')),
          Tab(icon: const Icon(Icons.bolt_outlined), text: context.t('potassiumTab')),
          Tab(icon: const Icon(Icons.bubble_chart_outlined), text: context.t('calciumTab')),
        ],
      ),
    );
  }

  Widget _buildSodiumTab() {
    final result = MetabolicCalculator.calculateDysnatremiaCorrection(DysnatremiaParams(
      weight: _weight,
      sex: _sex,
      ageGroup: _ageGroup,
      baselineNa: _baselineNa,
      targetNa: _targetNa,
      direction: _naDirection,
      mode: _naMode,
      urineOutput: _urineOutput,
      insensibleLoss: _insensibleLoss,
      fluidA: _fluidA,
      fluidB: _fluidB,
    ));

    return FadeTransition(
      opacity: _animationController,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPatientSection(),
            const SizedBox(height: 16),
            _buildSodiumInputs(),
            const SizedBox(height: 16),
            _buildSodiumResults(result),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Icon(Icons.person_outline, color: AppColors.primary),
                const SizedBox(width: 12),
                Text(
                  context.t('patientParameters'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildDropdown<Sex>(
                      label: AppStrings.sex,
                      value: _sex,
                      items: Sex.values.map((s) => DropdownMenuItem(
                        value: s,
                        child: Text(s == Sex.male ? AppStrings.male : AppStrings.female),
                      )).toList(),
                      onChanged: (v) => setState(() => _sex = v!),
                    )),
                    const SizedBox(width: 12),
                    Expanded(child: _buildDropdown<AgeGroup>(
                      label: AppStrings.ageGroup,
                      value: _ageGroup,
                      items: AgeGroup.values.map((g) => DropdownMenuItem(
                        value: g,
                        child: Text(_getAgeGroupLabel(g)),
                      )).toList(),
                      onChanged: (v) => setState(() => _ageGroup = v!),
                    )),
                    const SizedBox(width: 12),
                    Expanded(child: _buildTextField(
                      label: '${AppStrings.weight} (kg)',
                      value: _weight.toString(),
                      onChanged: (v) => setState(() => _weight = double.tryParse(v) ?? _weight),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getAgeGroupLabel(AgeGroup group) {
    switch (group) {
      case AgeGroup.child:
        return AppStrings.child;
      case AgeGroup.adult:
        return AppStrings.adult;
      case AgeGroup.elderly:
        return AppStrings.elderly;
    }
  }

  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.getTextSecondary(isDark),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.cardDark : null,
            border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              dropdownColor: isDark ? AppColors.cardDark : null,
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
    String? suffix,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.getTextSecondary(isDark),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: value,
          keyboardType: TextInputType.number,
          style: TextStyle(color: AppColors.getTextPrimary(isDark)),
          decoration: InputDecoration(
            suffixText: suffix,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildSodiumInputs() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.getBorderColor(isDark)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Icon(Icons.water_drop, color: AppColors.warning),
                const SizedBox(width: 12),
                Text(
                  context.t('sodiumParameters'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.warning,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Direction Toggle
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildToggleButton(
                          label: context.t('hyponatremia'),
                          isSelected: _naDirection == SodiumDirection.hypo,
                          color: AppColors.info,
                          onTap: () => _switchSodiumDirection(SodiumDirection.hypo),
                        ),
                      ),
                      Expanded(
                        child: _buildToggleButton(
                          label: context.t('hypernatremia'),
                          isSelected: _naDirection == SodiumDirection.hyper,
                          color: AppColors.error,
                          onTap: () => _switchSodiumDirection(SodiumDirection.hyper),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildTextField(
                      label: context.t('currentNa'),
                      value: _baselineNa.toString(),
                      onChanged: (v) => setState(() => _baselineNa = double.tryParse(v) ?? _baselineNa),
                    )),
                    const SizedBox(width: 12),
                    Expanded(child: _buildTextField(
                      label: context.t('targetNa'),
                      value: _targetNa.toString(),
                      onChanged: (v) => setState(() => _targetNa = double.tryParse(v) ?? _targetNa),
                    )),
                  ],
                ),
                const SizedBox(height: 16),
                _buildDropdown<CorrectionMode>(
                  label: context.t('correctionMode'),
                  value: _naMode,
                  items: [
                    DropdownMenuItem(value: CorrectionMode.chronic, child: Text(context.t('chronic'))),
                    DropdownMenuItem(value: CorrectionMode.acute, child: Text(context.t('acute'))),
                  ],
                  onChanged: (v) => setState(() => _naMode = v!),
                ),
                const SizedBox(height: 16),
                Text(
                  context.t('soluteSelection'),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.getTextPrimary(isDark),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _buildDropdown<IVFluid>(
                      label: context.t('soluteA'),
                      value: _fluidA,
                      items: MetabolicCalculator.ivFluids.map((f) => DropdownMenuItem(
                        value: f,
                        child: Text(context.tr(f.name), overflow: TextOverflow.ellipsis),
                      )).toList(),
                      onChanged: (v) => setState(() => _fluidA = v!),
                    )),
                    const SizedBox(width: 12),
                    Expanded(child: _buildDropdown<IVFluid>(
                      label: context.t('soluteB'),
                      value: _fluidB,
                      items: MetabolicCalculator.ivFluids.map((f) => DropdownMenuItem(
                        value: f,
                        child: Text(context.tr(f.name), overflow: TextOverflow.ellipsis),
                      )).toList(),
                      onChanged: (v) => setState(() => _fluidB = v!),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required String label,
    required bool isSelected,
    required Color color,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.getTextSecondary(isDark),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  void _switchSodiumDirection(SodiumDirection direction) {
    setState(() {
      _naDirection = direction;
      if (_naDirection == SodiumDirection.hyper) {
        _baselineNa = 160;
        _targetNa = 150;
        _fluidA = MetabolicCalculator.ivFluids[0];
        _fluidB = MetabolicCalculator.ivFluids[4];
      } else {
        _baselineNa = 115;
        _targetNa = 121;
        _fluidA = MetabolicCalculator.ivFluids[5];
        _fluidB = MetabolicCalculator.ivFluids[4];
      }
    });
  }

  Widget _buildSodiumResults(DysnatremiaResult result) {
    final isUnsafe = result.isUnsafe;
    final color = isUnsafe ? AppColors.error : AppColors.success;
    
    // Determine correction rate recommendations based on mode and direction
    final String rateReco;
    final String rateWarning;
    final String safeMargin;
    final String dangerMargin;
    
    if (_naDirection == SodiumDirection.hypo) {
      if (_naMode == CorrectionMode.acute) {
        rateReco = context.t('naRateRecoHypoAcute');
        rateWarning = context.t('naRateWarningHypoAcute');
        safeMargin = context.t('naSafeMarginHypoAcute');
        dangerMargin = context.t('naDangerMarginHypoAcute');
      } else {
        rateReco = context.t('naRateRecoHypoChronic');
        rateWarning = context.t('naRateWarningHypoChronic');
        safeMargin = context.t('naSafeMarginHypoChronic');
        dangerMargin = context.t('naDangerMarginHypoChronic');
      }
    } else {
      if (_naMode == CorrectionMode.acute) {
        rateReco = context.t('naRateRecoHyperAcute');
        rateWarning = context.t('naRateWarningHyperAcute');
        safeMargin = context.t('naSafeMarginHyperAcute');
        dangerMargin = context.t('naDangerMarginHyperAcute');
      } else {
        rateReco = context.t('naRateRecoHyperChronic');
        rateWarning = context.t('naRateWarningHyperChronic');
        safeMargin = context.t('naSafeMarginHyperChronic');
        dangerMargin = context.t('naDangerMarginHyperChronic');
      }
    }
    
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          if (isUnsafe)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      context.tr(result.safetyWarning),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Correction Rate Recommendations
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _naMode == CorrectionMode.acute ? Icons.speed : Icons.timer,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            context.t('correctionRateTitle').replaceAll('{0}', _naMode == CorrectionMode.acute ? context.t('acute') : context.t('chronic')),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        rateReco,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        rateWarning,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(color: Colors.white30, height: 1),
                      const SizedBox(height: 10),
                      // Safe and Danger Margins
                      Text(
                        safeMargin,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dangerMargin,
                        style: TextStyle(
                          color: Colors.yellow.shade200,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  context.t('infusionRates'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildResultItem(context.t('soluteATotalLabel').replaceAll('{0}', context.tr(_fluidA.name)), '${result.fluidARate} mL/h'),
                _buildResultItem(context.t('soluteBTotalLabel').replaceAll('{0}', context.tr(_fluidB.name)), '${result.fluidBRate} mL/h'),
                const Divider(color: Colors.white30, height: 24),
                _buildResultItem(context.t('totalFlowRate'), '${result.totalRate} mL/h'),
                _buildResultItem(context.t('predictedVariation'), '${result.ratePerHour.toStringAsFixed(2)} mEq/L/h'),
                const Divider(color: Colors.white30, height: 24),
                Text(
                  context.t('detailLabel'),
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                _buildResultItem(context.t('totalBodyWater'), '${result.tbw.toStringAsFixed(1)} L'),
                if (result.freeWaterDeficit > 0)
                  _buildResultItem(context.t('freeWaterDeficit'), '${result.freeWaterDeficit.toStringAsFixed(1)} L'),
                if (result.sodiumDeficit > 0)
                  _buildResultItem(context.t('sodiumDeficitLabel'), '${result.sodiumDeficit.toStringAsFixed(0)} mEq'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPotassiumTab() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return FadeTransition(
      opacity: _animationController,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input Card
            Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.getBorderColor(isDark)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withValues(alpha: 0.1),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.bolt, color: AppColors.warning),
                        const SizedBox(width: 12),
                        Text(
                          context.t('kaliemia'),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.warning,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            label: context.t('potassiumLevel'),
                            value: _kLevel.toString(),
                            onChanged: (v) => setState(() => _kLevel = double.tryParse(v) ?? _kLevel),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _getKaliumColor().withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                _kLevel > 5.5 ? Icons.warning : Icons.check_circle,
                                color: _getKaliumColor(),
                                size: 32,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _getKaliumStatus(),
                                style: TextStyle(
                                  color: _getKaliumColor(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // ECG Findings
            Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.getBorderColor(isDark)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: isDark ? 0.2 : 0.1),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.monitor_heart_outlined, color: AppColors.error),
                        const SizedBox(width: 12),
                        Text(
                          context.t('ecgFindings'),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...MetabolicCalculator.hyperkalemiaECG.asMap().entries.map((entry) {
                    final finding = entry.value;
                    return CheckboxListTile(
                      title: Text(
                        context.tr(finding.name),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.getTextPrimary(isDark),
                        ),
                      ),
                      subtitle: finding.threshold != null 
                        ? Text(
                            context.t('typicallySeenK').replaceAll('{0}', '${finding.threshold}'),
                            style: TextStyle(color: AppColors.getTextSecondary(isDark)),
                          ) 
                        : null,
                      value: _selectedECG.contains(finding.id),
                      activeColor: AppColors.error,
                      onChanged: (v) => setState(() {
                        if (v == true) {
                          _selectedECG.add(finding.id);
                        } else {
                          _selectedECG.remove(finding.id);
                        }
                      }),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Treatments
            if (_kLevel > 5.0 || _selectedECG.isNotEmpty) ...[
              Text(
                context.t('recommendedTreatments'),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.getTextPrimary(isDark),
                ),
              ),
              const SizedBox(height: 12),
              ...MetabolicCalculator.hyperkalemiaTreatments.asMap().entries.map((entry) {
                final t = entry.value;
                final urgency = t.urgency;
                final cardColor = urgency == 'immediate' ? AppColors.error
                    : urgency == 'urgent' ? AppColors.warning
                    : urgency == 'definitive' ? AppColors.accentCyan
                    : AppColors.info;
                final urgencyLabels = <String, String>{
                  'immediate': context.t('urgencyImmediate'),
                  'urgent': context.t('urgencyUrgent'),
                  'adjunct': context.t('urgencyAdjunct'),
                  'definitive': context.t('urgencyDefinitive'),
                };
                final urgencyLabel = urgencyLabels[urgency] ?? urgency;
                
                return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: cardColor.withValues(alpha: 0.3),
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: cardColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.medical_services,
                                color: cardColor,
                              ),
                            ),
                            title: Text(
                              context.tr(t.name),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  '${AppStrings.doseLabel}: ${context.tr(t.dose)}',
                                  style: TextStyle(color: AppColors.getTextSecondary(isDark)),
                                ),
                                Text(
                                  context.tr(t.notes),
                                  style: TextStyle(
                                    color: AppColors.getTextHint(isDark),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                urgencyLabel,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
              }),
            ],
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Color _getKaliumColor() {
    if (_kLevel > 6.5) return AppColors.error;
    if (_kLevel > 5.5) return AppColors.warning;
    if (_kLevel < 3.0) return AppColors.error;
    if (_kLevel < 3.5) return AppColors.warning;
    return AppColors.success;
  }

  String _getKaliumStatus() {
    if (_kLevel > 6.5) return context.t('criticalStatus');
    if (_kLevel > 5.5) return context.t('elevatedStatus');
    if (_kLevel < 3.0) return context.t('criticalStatus');
    if (_kLevel < 3.5) return context.t('lowStatus');
    return context.t('normalStatus');
  }

  Widget _buildCalciumTab() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final correctedCa = MetabolicCalculator.calculateCorrectedCalcium(_totalCalcium, _albumin);
    final caStatus = _getCalciumStatus(correctedCa);
    final caColor = _getCalciumColor(correctedCa);

    return FadeTransition(
      opacity: _animationController,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input Card
            Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.getBorderColor(isDark)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.accentCyan.withValues(alpha: 0.1),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.bubble_chart, color: AppColors.accentCyan),
                        const SizedBox(width: 12),
                        Text(
                          context.t('calcemia'),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accentCyan,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildTextField(
                          label: context.t('calciumTotal'),
                          value: _totalCalcium.toString(),
                          onChanged: (v) => setState(() => _totalCalcium = double.tryParse(v) ?? _totalCalcium),
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          label: context.t('albuminLabel'),
                          value: _albumin.toString(),
                          onChanged: (v) => setState(() => _albumin = double.tryParse(v) ?? _albumin),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Result Card
            Container(
              decoration: BoxDecoration(
                color: caColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(
                    Icons.bubble_chart,
                    color: Colors.white,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    context.t('correctedCalcium'),
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${correctedCa.toStringAsFixed(2)} mg/dL',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      caStatus,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Formula Explanation
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderLight),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: AppColors.info),
                      const SizedBox(width: 8),
                      Text(
                        context.t('formulaLabel'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.info,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.cardDark : AppColors.backgroundLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      context.t('calciumFormula'),
                      style: TextStyle(
                        fontFamily: 'monospace',
                        color: AppColors.getTextPrimary(isDark),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    context.t('normalValuesRange'),
                    style: TextStyle(
                      color: AppColors.getTextSecondary(isDark),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Color _getCalciumColor(double ca) {
    if (ca < 7.0 || ca > 12.0) return AppColors.error;
    if (ca < 8.5 || ca > 10.5) return AppColors.warning;
    return AppColors.success;
  }

  String _getCalciumStatus(double ca) {
    if (ca < 7.0) return context.t('hypocalcemiaSevere');
    if (ca < 8.5) return context.t('hypocalcemia');
    if (ca > 12.0) return context.t('hypercalcemiaSevere');
    if (ca > 10.5) return context.t('hypercalcemia');
    return context.t('normalStatus');
  }
}
