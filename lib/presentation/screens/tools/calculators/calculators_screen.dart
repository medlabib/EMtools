import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../core/widgets/animated_widgets.dart';
import '../../../../data/datasources/calculators_data.dart';
import '../../../../domain/entities/calculator.dart';

class CalculatorsScreen extends StatefulWidget {
  const CalculatorsScreen({super.key});

  @override
  State<CalculatorsScreen> createState() => _CalculatorsScreenState();
}

class _CalculatorsScreenState extends State<CalculatorsScreen>
    with SingleTickerProviderStateMixin {
  String _searchQuery = '';
  CalculatorCategory? _selectedCategory;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getCategoryLabel(CalculatorCategory category) {
    switch (category) {
      case CalculatorCategory.trauma:
        return AppStrings.trauma;
      case CalculatorCategory.sepsis:
        return AppStrings.sepsis;
      case CalculatorCategory.peDvt:
        return AppStrings.peDvt;
      case CalculatorCategory.cardiovascular:
        return AppStrings.cardiovascular;
      case CalculatorCategory.neurology:
        return AppStrings.neurology;
      case CalculatorCategory.gi:
        return AppStrings.gi;
      case CalculatorCategory.toxicology:
        return AppStrings.toxicology;
      case CalculatorCategory.msk:
        return AppStrings.msk;
      case CalculatorCategory.pediatric:
        return AppStrings.pediatric;
      case CalculatorCategory.laboratory:
        return AppStrings.laboratory;
      case CalculatorCategory.other:
        return 'Autre';
    }
  }

  Color _getCategoryColor(CalculatorCategory category) {
    switch (category) {
      case CalculatorCategory.trauma:
        return AppColors.error;
      case CalculatorCategory.sepsis:
        return AppColors.warning;
      case CalculatorCategory.peDvt:
        return AppColors.primaryPurple;
      case CalculatorCategory.cardiovascular:
        return AppColors.error;
      case CalculatorCategory.neurology:
        return AppColors.primaryIndigo;
      case CalculatorCategory.gi:
        return AppColors.success;
      case CalculatorCategory.toxicology:
        return AppColors.warning;
      case CalculatorCategory.msk:
        return AppColors.accentTeal;
      case CalculatorCategory.pediatric:
        return AppColors.primaryBlue;
      case CalculatorCategory.laboratory:
        return AppColors.accentCyan;
      case CalculatorCategory.other:
        return AppColors.info;
    }
  }

  IconData _getCategoryIcon(CalculatorCategory category) {
    switch (category) {
      case CalculatorCategory.trauma:
        return Icons.local_hospital;
      case CalculatorCategory.sepsis:
        return Icons.coronavirus;
      case CalculatorCategory.peDvt:
        return Icons.bloodtype;
      case CalculatorCategory.cardiovascular:
        return Icons.favorite;
      case CalculatorCategory.neurology:
        return Icons.psychology;
      case CalculatorCategory.gi:
        return Icons.restaurant;
      case CalculatorCategory.toxicology:
        return Icons.science;
      case CalculatorCategory.msk:
        return Icons.accessibility;
      case CalculatorCategory.pediatric:
        return Icons.child_care;
      case CalculatorCategory.laboratory:
        return Icons.biotech;
      case CalculatorCategory.other:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final filteredCalculators = allCalculators.where((calc) {
      final matchesSearch = calc.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          calc.shortName.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == null || calc.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    // Group calculators by category
    final groupedCalculators = <CalculatorCategory, List<Calculator>>{};
    for (var calc in filteredCalculators) {
      groupedCalculators.putIfAbsent(calc.category, () => []).add(calc);
    }

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: GradientHeader(
              title: AppStrings.calculators,
              subtitle: '${allCalculators.length} ${AppStrings.calculatorsDesc}',
              icon: Icons.calculate_outlined,
              height: 160,
            ),
          ),

          // Search Bar
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            sliver: SliverToBoxAdapter(
              child: AnimatedListItem(
                index: 0,
                child: _buildSearchBar(context, isDark),
              ),
            ),
          ),

          // Category Chips
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: AnimatedListItem(
                index: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _CategoryChip(
                        label: AppStrings.all,
                        icon: Icons.apps_rounded,
                        isSelected: _selectedCategory == null,
                        color: AppColors.primaryBlue,
                        onTap: () => setState(() => _selectedCategory = null),
                      ),
                      ...CalculatorCategory.values.map((category) {
                        return _CategoryChip(
                          label: _getCategoryLabel(category),
                          icon: _getCategoryIcon(category),
                          isSelected: _selectedCategory == category,
                          color: _getCategoryColor(category),
                          onTap: () => setState(() => _selectedCategory = 
                              _selectedCategory == category ? null : category),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Results count
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                '${filteredCalculators.length} calculateur${filteredCalculators.length > 1 ? 's' : ''} trouvé${filteredCalculators.length > 1 ? 's' : ''}',
                style: TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
          ),

          // Calculator List
          if (_selectedCategory == null)
            // Grouped view
            ...groupedCalculators.entries.map((entry) {
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverToBoxAdapter(
                  child: _buildCategorySection(
                    context,
                    entry.key,
                    entry.value,
                    isDark,
                  ),
                ),
              );
            })
          else
            // Flat list for selected category
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final calc = filteredCalculators[index];
                    return AnimatedListItem(
                      index: index,
                      child: _CalculatorCard(
                        calculator: calc,
                        color: _getCategoryColor(calc.category),
                        onTap: () => context.go('/tools/calculators/${calc.id}'),
                      ),
                    );
                  },
                  childCount: filteredCalculators.length,
                ),
              ),
            ),

          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: '${AppStrings.search} a calculator...',
          hintStyle: TextStyle(
            color: isDark ? Colors.grey[500] : Colors.grey[400],
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: isDark ? Colors.grey[500] : Colors.grey[400],
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear_rounded,
                    color: isDark ? Colors.grey[500] : Colors.grey[400],
                  ),
                  onPressed: () => setState(() => _searchQuery = ''),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        onChanged: (value) => setState(() => _searchQuery = value),
      ),
    );
  }

  Widget _buildCategorySection(
    BuildContext context,
    CalculatorCategory category,
    List<Calculator> calculators,
    bool isDark,
  ) {
    final color = _getCategoryColor(category);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(_getCategoryIcon(category), color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                _getCategoryLabel(category),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              StatusBadge(
                label: '${calculators.length}',
                color: color,
              ),
            ],
          ),
        ),
        ...calculators.asMap().entries.map((entry) {
          return AnimatedListItem(
            index: entry.key,
            child: _CalculatorCard(
              calculator: entry.value,
              color: color,
              onTap: () => context.go('/tools/calculators/${entry.value.id}'),
            ),
          );
        }),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected 
                ? color 
                : (isDark ? AppColors.cardDark : AppColors.cardLight),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? color : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected
                    ? Colors.white
                    : (isDark ? Colors.grey[400] : Colors.grey[600]),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : (isDark ? Colors.grey[300] : Colors.grey[700]),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CalculatorCard extends StatefulWidget {
  final Calculator calculator;
  final Color color;
  final VoidCallback onTap;

  const _CalculatorCard({
    required this.calculator,
    required this.color,
    required this.onTap,
  });

  @override
  State<_CalculatorCard> createState() => _CalculatorCardState();
}

class _CalculatorCardState extends State<_CalculatorCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.cardDark : AppColors.cardLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.color.withValues(alpha: 0.1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.calculate_outlined,
                  color: widget.color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.calculator.shortName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.calculator.name,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: isDark ? Colors.grey[600] : Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
