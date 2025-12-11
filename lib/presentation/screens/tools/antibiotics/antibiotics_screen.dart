import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/datasources/antibiotics_data.dart';
import '../../../../domain/entities/antibiotic.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/l10n/app_strings.dart';

class AntibioticsScreen extends StatefulWidget {
  const AntibioticsScreen({super.key});

  @override
  State<AntibioticsScreen> createState() => _AntibioticsScreenState();
}

class _AntibioticsScreenState extends State<AntibioticsScreen> 
    with SingleTickerProviderStateMixin {
  String _searchQuery = '';
  AntibioticClass? _selectedClass;
  late AnimationController _animationController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final filteredAntibiotics = allAntibiotics.where((abx) {
      final matchesSearch = abx.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          abx.genericName.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesClass = _selectedClass == null || abx.antibioticClass == _selectedClass;
      return matchesSearch && matchesClass;
    }).toList();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          _buildSliverAppBar(),
        ],
        body: Column(
          children: [
            _buildSearchAndFilters(),
            Expanded(
              child: filteredAntibiotics.isEmpty
                ? _buildEmptyState()
                : _buildAntibioticsList(filteredAntibiotics),
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
      backgroundColor: AppColors.success,
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
              colors: [AppColors.success, AppColors.accentEmerald],
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
                          Icons.medication_rounded,
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
                              AppStrings.antibioticsGuide,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              AppStrings.antibioticsSubtitle,
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

  Widget _buildSearchAndFilters() {
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Search bar
              Container(
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
                    hintText: AppStrings.searchAntibiotic,
                    hintStyle: TextStyle(color: AppColors.textHint),
                    prefixIcon: Icon(Icons.search, color: AppColors.success),
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
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Filter chips
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildFilterChip(
                      label: AppStrings.all,
                      isSelected: _selectedClass == null,
                      color: AppColors.textSecondary,
                      onSelected: () => setState(() => _selectedClass = null),
                    ),
                    const SizedBox(width: 8),
                    ...AntibioticClass.values.map((cls) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _buildFilterChip(
                          label: _getClassLabel(cls),
                          isSelected: _selectedClass == cls,
                          color: _getClassColor(cls),
                          onSelected: () => setState(() {
                            _selectedClass = _selectedClass == cls ? null : cls;
                          }),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required Color color,
    required VoidCallback onSelected,
  }) {
    return Material(
      color: isSelected ? color : Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onSelected,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? color : Colors.grey.shade300,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: AppColors.textHint,
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.noAntibioticFound,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.tryAnotherSearch,
            style: TextStyle(
              color: AppColors.textHint,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAntibioticsList(List<Antibiotic> antibiotics) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
      itemCount: antibiotics.length,
      itemBuilder: (context, index) {
        final abx = antibiotics[index];
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: Duration(milliseconds: 300 + (index * 50)),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: _buildAntibioticCard(abx),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAntibioticCard(Antibiotic abx) {
    final color = _getClassColor(abx.antibioticClass);
    
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
          onTap: () => context.go('/tools/antibiotics/${abx.id}'),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withValues(alpha: 0.7)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      abx.name.substring(0, 2).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
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
                        abx.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        abx.genericName,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _getClassLabel(abx.antibioticClass),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.textHint,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
