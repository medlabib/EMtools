import 'package:flutter/material.dart';
import '../../../../data/datasources/antibiotics_data.dart';
import '../../../../domain/entities/antibiotic.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/l10n/app_strings.dart';

class AntibioticDetailScreen extends StatefulWidget {
  final String antibioticId;

  const AntibioticDetailScreen({super.key, required this.antibioticId});

  @override
  State<AntibioticDetailScreen> createState() => _AntibioticDetailScreenState();
}

class _AntibioticDetailScreenState extends State<AntibioticDetailScreen> 
    with TickerProviderStateMixin {
  late Antibiotic _antibiotic;
  late TabController _tabController;
  late AnimationController _animationController;
  
  // Renal Calc State
  double _gfr = 60;
  
  // Interaction State
  final List<String> _patientMedications = [];
  final TextEditingController _medicationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();
    try {
      _antibiotic = allAntibiotics.firstWhere((a) => a.id == widget.antibioticId);
    } catch (e) {
      // Handle not found
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _medicationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Color _getClassColor(AntibioticClass cls) {
    switch (cls) {
      case AntibioticClass.penicillin:
        return AppColors.primary;
      case AntibioticClass.cephalosporin:
        return AppColors.accentTeal;
      case AntibioticClass.carbapenem:
        return AppColors.error;
      case AntibioticClass.aminoglycoside:
        return AppColors.warning;
      case AntibioticClass.fluoroquinolone:
        return AppColors.accentPurple;
      case AntibioticClass.macrolide:
        return AppColors.success;
      case AntibioticClass.glycopeptide:
        return AppColors.primaryDark;
      case AntibioticClass.tetracycline:
        return AppColors.accentCyan;
      case AntibioticClass.sulfonamide:
        return AppColors.info;
      case AntibioticClass.nitroimidazole:
        return AppColors.accentEmerald;
      case AntibioticClass.other:
        return AppColors.textSecondary;
    }
  }

  String _getClassLabel(AntibioticClass cls) {
    switch (cls) {
      case AntibioticClass.penicillin:
        return AppStrings.penicillins;
      case AntibioticClass.cephalosporin:
        return AppStrings.cephalosporins;
      case AntibioticClass.carbapenem:
        return AppStrings.carbapenems;
      case AntibioticClass.aminoglycoside:
        return AppStrings.aminoglycosides;
      case AntibioticClass.fluoroquinolone:
        return AppStrings.fluoroquinolones;
      case AntibioticClass.macrolide:
        return AppStrings.macrolides;
      case AntibioticClass.glycopeptide:
        return AppStrings.glycopeptides;
      case AntibioticClass.tetracycline:
        return AppStrings.tetracyclines;
      case AntibioticClass.sulfonamide:
        return AppStrings.sulfonamides;
      case AntibioticClass.nitroimidazole:
        return AppStrings.nitroimidazoles;
      case AntibioticClass.other:
        return AppStrings.others;
    }
  }

  String _getRenalDose(double gfr) {
    for (var adj in _antibiotic.renalAdjustment) {
      if (adj.gfr.contains('-')) {
        final parts = adj.gfr.split('-');
        final min = double.parse(parts[0]);
        final max = double.parse(parts[1]);
        if (gfr >= min && gfr <= max) return '${adj.dose} ${adj.notes ?? ''}';
      } else if (adj.gfr.startsWith('<')) {
        final val = double.parse(adj.gfr.substring(1));
        if (gfr < val) return '${adj.dose} ${adj.notes ?? ''}';
      } else if (adj.gfr.startsWith('>')) {
        final val = double.parse(adj.gfr.substring(1));
        if (gfr > val) return '${adj.dose} ${adj.notes ?? ''}';
      }
    }
    return '${_antibiotic.standardDose.adult} ${_antibiotic.standardDose.frequency}';
  }

  List<DrugInteraction> _checkInteractions() {
    final results = <DrugInteraction>[];
    for (var med in _patientMedications) {
      final medLower = med.toLowerCase();
      final matches = _antibiotic.interactions.where((i) => 
        i.drug.toLowerCase().contains(medLower) || medLower.contains(i.drug.toLowerCase())
      );
      results.addAll(matches);
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    final color = _getClassColor(_antibiotic.antibioticClass);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          _buildSliverAppBar(color),
        ],
        body: Column(
          children: [
            _buildTabBar(color),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildInfoTab(color),
                  _buildRenalTab(color),
                  _buildInteractionsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(Color color) {
    return SliverAppBar(
      expandedHeight: 180,
      pinned: true,
      backgroundColor: color,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color, color.withValues(alpha: 0.7)],
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
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            _antibiotic.name.substring(0, 2).toUpperCase(),
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
                              _antibiotic.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _antibiotic.genericName,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _getClassLabel(_antibiotic.antibioticClass),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
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

  Widget _buildTabBar(Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? AppColors.surfaceDark : Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: color,
        unselectedLabelColor: AppColors.getTextSecondary(isDark),
        indicatorColor: color,
        indicatorWeight: 3,
        tabs: const [
          Tab(icon: Icon(Icons.info_outline), text: 'Infos'),
          Tab(icon: Icon(Icons.science_outlined), text: 'Dose Rénale'),
          Tab(icon: Icon(Icons.warning_amber_outlined), text: 'Interactions'),
        ],
      ),
    );
  }

  Widget _buildInfoTab(Color color) {
    return FadeTransition(
      opacity: _animationController,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildInfoCard(
            title: 'Posologie Standard',
            icon: Icons.medical_services_outlined,
            color: color,
            children: [
              _buildInfoRow('Adulte', '${_antibiotic.standardDose.adult} ${_antibiotic.standardDose.frequency}'),
              if (_antibiotic.standardDose.duration != null)
                _buildInfoRow('Durée', _antibiotic.standardDose.duration!),
            ],
          ),
          const SizedBox(height: 16),
          if (_antibiotic.indications.isNotEmpty)
            _buildInfoCard(
              title: AppStrings.indications,
              icon: Icons.check_circle_outline,
              color: AppColors.success,
              children: _antibiotic.indications.map((item) => 
                _buildBulletItem(item, AppColors.success)
              ).toList(),
            ),
          const SizedBox(height: 16),
          if (_antibiotic.contraindications.isNotEmpty)
            _buildInfoCard(
              title: AppStrings.contraindications,
              icon: Icons.cancel_outlined,
              color: AppColors.error,
              children: _antibiotic.contraindications.map((item) => 
                _buildBulletItem(item, AppColors.error)
              ).toList(),
            ),
          const SizedBox(height: 16),
          if (_antibiotic.sideEffects.isNotEmpty)
            _buildInfoCard(
              title: AppStrings.sideEffects,
              icon: Icons.warning_amber_outlined,
              color: AppColors.warning,
              children: _antibiotic.sideEffects.map((item) => 
                _buildBulletItem(item, AppColors.warning)
              ).toList(),
            ),
          const SizedBox(height: 16),
          _buildInfoCard(
            title: 'Informations Complémentaires',
            icon: Icons.article_outlined,
            color: AppColors.info,
            children: [
              _buildInfoRow('Catégorie Grossesse', _antibiotic.pregnancyCategory),
              _buildInfoRow('Prix (Tunisie)', _antibiotic.tunisiaPrice ?? 'N/A'),
            ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 24),
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
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.getTextSecondary(isDark),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.getTextPrimary(isDark),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletItem(String text, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 10),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: AppColors.getTextPrimary(isDark),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRenalTab(Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentDose = _getRenalDose(_gfr);
    
    return FadeTransition(
      opacity: _animationController,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // GFR Slider Card
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.tune, color: color),
                      const SizedBox(width: 12),
                      Text(
                        'Calculateur DFG',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: color,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'DFG:',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.getTextSecondary(isDark),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${_gfr.round()}',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'mL/min',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.getTextSecondary(isDark),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: color,
                          inactiveTrackColor: color.withValues(alpha: 0.2),
                          thumbColor: color,
                          overlayColor: color.withValues(alpha: 0.2),
                        ),
                        child: Slider(
                          value: _gfr,
                          min: 0,
                          max: 120,
                          divisions: 120,
                          onChanged: (v) => setState(() => _gfr = v),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('0', style: TextStyle(color: AppColors.textHint)),
                          Text('120', style: TextStyle(color: AppColors.textHint)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Result Card
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withValues(alpha: 0.8)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(
                  Icons.medical_information,
                  color: Colors.white,
                  size: 36,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Dose Recommandée',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  currentDose,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Reference Table
          Text(
            'Table de Référence',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.getTextPrimary(isDark),
            ),
          ),
          const SizedBox(height: 12),
          ..._antibiotic.renalAdjustment.asMap().entries.map((entry) {
            final index = entry.key;
            final adj = entry.value;
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: Duration(milliseconds: 300 + (index * 100)),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(20 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'DFG ${adj.gfr}',
                              style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '${adj.dose} ${adj.notes ?? ''}',
                              style: TextStyle(
                                color: isDark ? Colors.white : AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildInteractionsTab() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final interactions = _checkInteractions();

    return FadeTransition(
      opacity: _animationController,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Input
            Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _medicationController,
                      decoration: InputDecoration(
                        hintText: 'Ajouter un médicament du patient...',
                        hintStyle: TextStyle(color: AppColors.textHint),
                        prefixIcon: Icon(Icons.medication_outlined, color: AppColors.primary),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16,
                        ),
                      ),
                      onSubmitted: (value) => _addMedication(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      onPressed: _addMedication,
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Patient Medications Chips
            if (_patientMedications.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _patientMedications.map((med) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        med,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => setState(() => _patientMedications.remove(med)),
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            const SizedBox(height: 16),
            // Results
            Expanded(
              child: interactions.isEmpty 
                ? _buildNoInteractionsState()
                : ListView.builder(
                    itemCount: interactions.length,
                    itemBuilder: (context, index) {
                      final interaction = interactions[index];
                      final isMajor = interaction.severity == InteractionSeverity.major;
                      final cardColor = isMajor ? AppColors.error : AppColors.warning;
                      
                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: Duration(milliseconds: 300 + (index * 100)),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: Opacity(
                              opacity: value,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: cardColor.withValues(alpha: 0.3),
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: cardColor.withValues(alpha: 0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: cardColor.withValues(alpha: 0.1),
                                        borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(14),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            isMajor ? Icons.error : Icons.warning,
                                            color: cardColor,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Interaction avec ${interaction.drug}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: cardColor,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: cardColor,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              isMajor ? 'Majeure' : 'Modérée',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Effet:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.getTextSecondary(isDark),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            interaction.effect,
                                            style: TextStyle(
                                              color: isDark ? Colors.white : AppColors.textPrimary,
                                            ),
                                          ),
                                          if (interaction.recommendation != null) ...[
                                            const SizedBox(height: 12),
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: AppColors.info.withValues(alpha: 0.1),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.lightbulb_outline,
                                                    size: 18,
                                                    color: AppColors.info,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      interaction.recommendation!,
                                                      style: TextStyle(
                                                        color: AppColors.info,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _addMedication() {
    if (_medicationController.text.isNotEmpty) {
      setState(() {
        _patientMedications.add(_medicationController.text);
        _medicationController.clear();
      });
    }
  }

  Widget _buildNoInteractionsState() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _patientMedications.isEmpty 
              ? Icons.medication_outlined 
              : Icons.check_circle_outline,
            size: 64,
            color: _patientMedications.isEmpty 
              ? AppColors.getTextHint(isDark) 
              : AppColors.success,
          ),
          const SizedBox(height: 16),
          Text(
            _patientMedications.isEmpty
              ? 'Ajoutez les médicaments du patient'
              : 'Aucune interaction détectée',
            style: TextStyle(
              fontSize: 16,
              color: _patientMedications.isEmpty 
                ? AppColors.getTextSecondary(isDark) 
                : AppColors.success,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _patientMedications.isEmpty
              ? 'pour vérifier les interactions'
              : 'avec les médicaments listés',
            style: TextStyle(
              color: AppColors.getTextHint(isDark),
            ),
          ),
        ],
      ),
    );
  }
}
