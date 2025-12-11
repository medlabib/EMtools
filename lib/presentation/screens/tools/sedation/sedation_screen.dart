import 'package:flutter/material.dart';
import '../../../../domain/entities/sedation.dart';
import '../../../../data/datasources/sedation_data.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/l10n/app_strings.dart';

class SedationScreen extends StatefulWidget {
  const SedationScreen({super.key});

  @override
  State<SedationScreen> createState() => _SedationScreenState();
}

class _SedationScreenState extends State<SedationScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  final TextEditingController _weightController = TextEditingController(text: '70');
  final TextEditingController _ageController = TextEditingController(text: '40');
  final TextEditingController _searchController = TextEditingController();

  double _weight = 70;
  double _age = 40;
  AgeGroup _ageGroup = AgeGroup.adult;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
    _updateAgeGroup();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _updateAgeGroup() {
    setState(() {
      if (_age < 1) {
        _ageGroup = AgeGroup.infant;
      } else if (_age < 18) {
        _ageGroup = AgeGroup.child;
      } else if (_age >= 65) {
        _ageGroup = AgeGroup.elderly;
      } else {
        _ageGroup = AgeGroup.adult;
      }
    });
  }

  String _getAgeGroupLabel(AgeGroup group) {
    switch (group) {
      case AgeGroup.neonate:
        return 'Nouveau-né';
      case AgeGroup.infant:
        return AppStrings.infant;
      case AgeGroup.child:
        return AppStrings.child;
      case AgeGroup.adult:
        return AppStrings.adult;
      case AgeGroup.elderly:
        return AppStrings.elderly;
    }
  }

  void _onWeightChanged(String value) {
    final w = double.tryParse(value);
    if (w != null) {
      setState(() {
        _weight = w;
      });
    }
  }

  void _onAgeChanged(String value) {
    final a = double.tryParse(value);
    if (a != null) {
      setState(() {
        _age = a;
        _updateAgeGroup();
      });
    }
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
            _buildPatientInputs(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildRSIView(),
                  _buildProceduralView(),
                  _buildAllDrugsView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 140,
      pinned: true,
      backgroundColor: AppColors.primary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.primaryDark],
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
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.medical_services_rounded,
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
                              AppStrings.sedationAnalgesia,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              AppStrings.sedationDesc,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
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

  Widget _buildPatientInputs() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, -0.2),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      )),
      child: FadeTransition(
        opacity: _animationController,
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? AppColors.cardDark : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person_outline, 
                    color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    AppStrings.patientParameters,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      controller: _weightController,
                      label: AppStrings.weight,
                      suffix: 'kg',
                      icon: Icons.monitor_weight_outlined,
                      onChanged: _onWeightChanged,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInputField(
                      controller: _ageController,
                      label: AppStrings.age,
                      suffix: AppStrings.years,
                      icon: Icons.cake_outlined,
                      onChanged: _onAgeChanged,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.category_outlined, 
                      size: 18, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(
                      '${AppStrings.ageGroup}: ',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      _getAgeGroupLabel(_ageGroup),
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String suffix,
    required IconData icon,
    required ValueChanged<String> onChanged,
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
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: isDark ? Colors.grey[400] : AppColors.textSecondary,
            fontSize: 14,
          ),
          suffixText: suffix,
          suffixStyle: TextStyle(
            color: isDark ? Colors.grey[400] : AppColors.textSecondary,
            fontSize: 14,
          ),
          prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
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
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(4),
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.flash_on, size: 18),
                const SizedBox(width: 6),
                Text(AppStrings.rsiTab),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.healing, size: 18),
                const SizedBox(width: 6),
                Text(AppStrings.proceduralTab),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.list_alt, size: 18),
                const SizedBox(width: 6),
                Text(AppStrings.allDrugsTab),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRSIView() {
    final pretreatment = ['fentanyl', 'lidocaine', 'atropine'];
    final induction = ['etomidate', 'ketamine', 'propofol', 'midazolam'];
    final paralytic = ['succinylcholine', 'rocuronium'];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildInfoCard(
          icon: Icons.flash_on,
          title: AppStrings.rapidSequence,
          color: AppColors.warning,
        ),
        const SizedBox(height: 16),
        _buildSectionHeader(AppStrings.premedication, Icons.medication_outlined, AppColors.info),
        ...pretreatment.asMap().entries.map((e) => 
          _buildAnimatedDrugCard(e.value, e.key)),
        const SizedBox(height: 20),
        _buildSectionHeader(AppStrings.induction, Icons.airline_seat_flat, AppColors.success),
        ...induction.asMap().entries.map((e) => 
          _buildAnimatedDrugCard(e.value, e.key + pretreatment.length)),
        const SizedBox(height: 20),
        _buildSectionHeader(AppStrings.paralysis, Icons.accessibility_new, AppColors.error),
        ...paralytic.asMap().entries.map((e) => 
          _buildAnimatedDrugCard(e.value, e.key + pretreatment.length + induction.length)),
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildProceduralView() {
    final proceduralDrugs = ['ketamine', 'propofol', 'etomidate', 'fentanyl', 'midazolam', 'morphine'];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildInfoCard(
          icon: Icons.healing,
          title: AppStrings.proceduralSedation,
          subtitle: AppStrings.proceduralOptions,
          color: AppColors.accentTeal,
        ),
        const SizedBox(height: 16),
        ...proceduralDrugs.asMap().entries.map((e) => 
          _buildAnimatedDrugCard(e.value, e.key)),
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildAllDrugsView() {
    final filteredDrugs = SedationData.allDrugs.where((drug) {
      if (_searchQuery.isEmpty) return true;
      return drug.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             drug.genericName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             drug.drugClass.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: AppStrings.searchDrugs,
                hintStyle: TextStyle(color: AppColors.textHint),
                prefixIcon: Icon(Icons.search, color: AppColors.primary),
                suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, color: AppColors.textSecondary),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      },
                    )
                  : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
            ),
          ),
        ),
        Expanded(
          child: filteredDrugs.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 64, color: AppColors.textHint),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.noDrugsFound,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                itemCount: filteredDrugs.length,
                itemBuilder: (context, index) {
                  final drug = filteredDrugs[index];
                  return _buildAnimatedDrugCard(drug.id, index);
                },
              ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    String? subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.05)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: color.withValues(alpha: 0.8),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedDrugCard(String drugId, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 300 + (index * 50)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: _buildDrugCard(drugId),
          ),
        );
      },
    );
  }

  Widget _buildDrugCard(String drugId) {
    final drug = SedationData.allDrugs.firstWhere(
      (d) => d.id == drugId,
      orElse: () => SedationData.allDrugs.first,
    );

    final doseInfo = _calculateDose(drug);
    final cardColor = _getDrugColor(drug.drugClass);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showDrugDetails(drug, doseInfo),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [cardColor, cardColor.withValues(alpha: 0.7)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          drug.name.substring(0, 2).toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            drug.name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            drug.genericName,
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: cardColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        drug.drugClass,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: cardColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.totalDose,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                doseInfo.totalDose.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.success,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  drug.doseUnit.split('/')[0],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.success,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${doseInfo.dosePerKg} ${drug.doseUnit}',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildTimeChip(
                            '${AppStrings.onset}: ${drug.onsetSeconds}s',
                            Icons.timer_outlined,
                            AppColors.info,
                          ),
                          const SizedBox(height: 6),
                          _buildTimeChip(
                            '${AppStrings.duration}: ${drug.durationMinutes}min',
                            Icons.schedule,
                            AppColors.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (doseInfo.notes.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, 
                          size: 16, color: AppColors.warning),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            doseInfo.notes,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.warning,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      AppStrings.tapForDetails,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textHint,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_forward_ios, 
                      size: 12, color: AppColors.textHint),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeChip(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getDrugColor(String drugClass) {
    switch (drugClass.toLowerCase()) {
      case 'sédatif':
      case 'sedative':
        return AppColors.primary;
      case 'analgésique':
      case 'analgesic':
        return AppColors.accentTeal;
      case 'paralytique':
      case 'paralytic':
        return AppColors.error;
      case 'dissociatif':
      case 'dissociative':
        return AppColors.accentPurple;
      case 'adjuvant':
        return AppColors.warning;
      default:
        return AppColors.info;
    }
  }

  _DoseResult _calculateDose(SedationDrug drug) {
    double dosePerKg = drug.standardDose;
    String notes = '';

    try {
      final ageSpecific = drug.dosesByAge.firstWhere((d) => d.ageGroup == _ageGroup);
      dosePerKg = ageSpecific.dose;
      if (ageSpecific.notes != null) {
        notes = ageSpecific.notes!;
      }
    } catch (_) {
      // No specific dose for this age group, use standard
    }

    double total = dosePerKg * _weight;

    if (drug.maxSingleDose != null && total > drug.maxSingleDose!) {
      total = drug.maxSingleDose!;
      notes = notes.isEmpty
          ? '${AppStrings.maxReached}: ${drug.maxSingleDose} ${drug.maxSingleDoseUnit}'
          : '$notes | ${AppStrings.maxReached}';
    }

    return _DoseResult(dosePerKg, total, notes);
  }

  void _showDrugDetails(SedationDrug drug, _DoseResult doseInfo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _DrugDetailsSheet(
        drug: drug,
        doseInfo: doseInfo,
        weight: _weight,
        age: _age,
        ageGroup: _ageGroup,
        ageGroupLabel: _getAgeGroupLabel(_ageGroup),
      ),
    );
  }
}

class _DrugDetailsSheet extends StatelessWidget {
  final SedationDrug drug;
  final _DoseResult doseInfo;
  final double weight;
  final double age;
  final AgeGroup ageGroup;
  final String ageGroupLabel;

  const _DrugDetailsSheet({
    required this.drug,
    required this.doseInfo,
    required this.weight,
    required this.age,
    required this.ageGroup,
    required this.ageGroupLabel,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildDoseCard(),
                    const SizedBox(height: 20),
                    _buildDetailSection(
                      AppStrings.concentrations,
                      Icons.science_outlined,
                      AppColors.primary,
                      Text(drug.concentrations.join(', ')),
                    ),
                    _buildDetailSection(
                      AppStrings.mechanism,
                      Icons.psychology_outlined,
                      AppColors.accentPurple,
                      Text(drug.mechanism),
                    ),
                    _buildDetailSection(
                      AppStrings.indications,
                      Icons.check_circle_outline,
                      AppColors.success,
                      _buildBulletList(drug.indications, AppColors.success),
                    ),
                    _buildDetailSection(
                      AppStrings.contraindications,
                      Icons.block,
                      AppColors.error,
                      _buildBulletList(drug.contraindications, AppColors.error),
                    ),
                    _buildDetailSection(
                      AppStrings.sideEffects,
                      Icons.warning_amber_outlined,
                      AppColors.warning,
                      _buildBulletList(drug.sideEffects, AppColors.warning),
                    ),
                    _buildDetailSection(
                      AppStrings.precautions,
                      Icons.info_outline,
                      AppColors.info,
                      _buildBulletList(drug.precautions, AppColors.info),
                    ),
                    if (drug.notes.isNotEmpty)
                      _buildDetailSection(
                        AppStrings.notes,
                        Icons.note_alt_outlined,
                        AppColors.textSecondary,
                        _buildBulletList(drug.notes, AppColors.textSecondary),
                      ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primaryDark],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              drug.name.substring(0, 2).toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                drug.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                drug.genericName,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  drug.drugClass,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDoseCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.success.withValues(alpha: 0.1),
            AppColors.accentEmerald.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calculate_outlined, color: AppColors.success),
              const SizedBox(width: 8),
              Text(
                AppStrings.doseCalculation,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPatientStat(AppStrings.weight, '$weight kg', Icons.monitor_weight_outlined),
                Container(width: 1, height: 40, color: Colors.grey.shade200),
                _buildPatientStat(AppStrings.age, '$age ${AppStrings.years}', Icons.cake_outlined),
                Container(width: 1, height: 40, color: Colors.grey.shade200),
                _buildPatientStat(AppStrings.ageGroup, ageGroupLabel, Icons.category_outlined),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.totalDose,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          doseInfo.totalDose.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppColors.success,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            ' ${drug.doseUnit.split('/')[0]}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: AppColors.success,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${doseInfo.dosePerKg} ${drug.doseUnit}',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildTimingBadge(
                    '${AppStrings.onset}: ${drug.onsetSeconds}s',
                    Icons.timer_outlined,
                    AppColors.info,
                  ),
                  const SizedBox(height: 8),
                  _buildTimingBadge(
                    '${AppStrings.duration}: ${drug.durationMinutes}min',
                    Icons.schedule,
                    AppColors.primary,
                  ),
                ],
              ),
            ],
          ),
          if (doseInfo.notes.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 18, color: AppColors.warning),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      doseInfo.notes,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.warning,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPatientStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildTimingBadge(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, IconData icon, Color color, Widget content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
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
                child: Icon(icon, size: 18, color: color),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildBulletList(List<String> items, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(top: 6, right: 10),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}

class _DoseResult {
  final double dosePerKg;
  final double totalDose;
  final String notes;

  _DoseResult(this.dosePerKg, this.totalDose, this.notes);
}
