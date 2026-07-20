import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/widgets/animated_widgets.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  String _getGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 5) return context.t('goodNight');
    if (hour < 12) return context.t('goodMorning');
    if (hour < 18) return context.t('goodAfternoon');
    return context.t('goodEvening');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(isDark),
      body: CustomScrollView(
        slivers: [
          _buildHeaderSliver(isDark),
          _buildStatsSliver(isDark),
          _buildSectionTitle(context.t('favorites')),
          _buildQuickActionsGrid(isTablet),
          _buildSectionTitle(context.t('allTools')),
          _buildAllToolsGrid(isTablet),
        ],
      ),
    );
  }

  Widget _buildHeaderSliver(bool isDark) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.getCardColor(isDark),
          border: Border(
            bottom: BorderSide(color: AppColors.getBorderColor(isDark)),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getGreeting(context),
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.getTextSecondary(isDark),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        context.t('appName'),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: AppColors.getTextPrimary(isDark),
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        context.t('appSubtitle'),
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.getTextSecondary(isDark),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => context.go('/settings'),
                  icon: Icon(
                    Icons.settings_outlined,
                    color: AppColors.getTextSecondary(isDark),
                  ),
                  tooltip: context.t('settings'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSliver(bool isDark) {
    final stats = [
      _StatItem(icon: Icons.calculate_rounded, value: '40+', label: context.t('statScores')),
      _StatItem(icon: Icons.description_rounded, value: '50+', label: context.t('statProtocols')),
      _StatItem(icon: Icons.medication_rounded, value: '9', label: context.t('statTools')),
    ];

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: List.generate(stats.length, (i) {
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: i < 2 ? 12 : 0),
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                decoration: BoxDecoration(
                  color: AppColors.getCardColor(isDark),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.getBorderColor(isDark)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(stats[i].icon, color: AppColors.primary, size: 22),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      stats[i].value,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.getTextPrimary(isDark),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      stats[i].label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.getTextSecondary(isDark),
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            Container(
              width: 4,
              height: 22,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.getTextPrimary(isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsGrid(bool isTablet) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isTablet ? 3 : 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildListDelegate([
          AnimatedToolCard(
            title: context.t('medicalReport'),
            subtitle: context.t('medicalReportDesc'),
            icon: Icons.assignment_outlined,
            onTap: () => context.go('/tools/medical-report'),
          ),
          AnimatedToolCard(
            title: context.t('calculators'),
            subtitle: context.t('calculatorsDesc'),
            icon: Icons.calculate_outlined,
            onTap: () => context.go('/tools/calculators'),
          ),
          AnimatedToolCard(
            title: context.t('bloodGas'),
            subtitle: context.t('bloodGasDesc'),
            icon: Icons.air,
            onTap: () => context.go('/tools/blood-gas'),
          ),
          AnimatedToolCard(
            title: context.t('vasoactive'),
            subtitle: context.t('vasoactiveDesc'),
            icon: Icons.favorite_outline,
            onTap: () => context.go('/tools/vasoactive'),
          ),
          AnimatedToolCard(
            title: context.t('sedation'),
            subtitle: context.t('sedationDesc'),
            icon: Icons.bed_outlined,
            onTap: () => context.go('/tools/sedation'),
          ),
          AnimatedToolCard(
            title: context.t('allTools'),
            subtitle: context.t('viewAllTools'),
            icon: Icons.grid_view_rounded,
            onTap: () => context.go('/tools'),
          ),
        ]),
      ),
    );
  }

  Widget _buildAllToolsGrid(bool isTablet) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isTablet ? 3 : 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        delegate: SliverChildListDelegate([
          AnimatedToolCard(
            title: context.t('antibiotics'),
            subtitle: context.t('antibioticsDesc'),
            icon: Icons.medication_outlined,
            onTap: () => context.go('/tools/antibiotics'),
          ),
          AnimatedToolCard(
            title: context.t('metabolic'),
            subtitle: context.t('metabolicDesc'),
            icon: Icons.science_outlined,
            onTap: () => context.go('/tools/metabolic'),
          ),
        ]),
      ),
    );
  }
}

class _StatItem {
  final IconData icon;
  final String value, label;
  _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });
}
