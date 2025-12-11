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

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late Animation<double> _headerAnimation;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _headerAnimation = CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOutCubic,
    );
    _headerController.forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          // App Title Header
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _headerAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -50 * (1 - _headerAnimation.value)),
                  child: Opacity(
                    opacity: _headerAnimation.value,
                    child: child,
                  ),
                );
              },
              child: _buildSimpleHeader(context, isDark),
            ),
          ),

          // Favoris Title
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            sliver: SliverToBoxAdapter(
              child: AnimatedListItem(
                index: 0,
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 24,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      AppStrings.favorites,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Quick Actions Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isTablet ? 3 : 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              delegate: SliverChildListDelegate([
                AnimatedToolCard(
                  title: AppStrings.medicalReport,
                  subtitle: AppStrings.medicalReportDesc,
                  icon: Icons.assignment_outlined,
                  gradient: AppColors.medicalGradient,
                  onTap: () => context.go('/tools/medical-report'),
                  animationDelay: 100,
                ),
                AnimatedToolCard(
                  title: AppStrings.calculators,
                  subtitle: AppStrings.calculatorsDesc,
                  icon: Icons.calculate_outlined,
                  iconColor: AppColors.success,
                  onTap: () => context.go('/tools/calculators'),
                  animationDelay: 150,
                ),
                AnimatedToolCard(
                  title: AppStrings.bloodGas,
                  subtitle: AppStrings.bloodGasDesc,
                  icon: Icons.air,
                  iconColor: AppColors.error,
                  onTap: () => context.go('/tools/blood-gas'),
                  animationDelay: 200,
                ),
                AnimatedToolCard(
                  title: AppStrings.vasoactive,
                  subtitle: AppStrings.vasoactiveDesc,
                  icon: Icons.favorite_outline,
                  iconColor: AppColors.warning,
                  onTap: () => context.go('/tools/vasoactive'),
                  animationDelay: 250,
                ),
                AnimatedToolCard(
                  title: AppStrings.sedation,
                  subtitle: AppStrings.sedationDesc,
                  icon: Icons.bed_outlined,
                  iconColor: AppColors.accentTeal,
                  onTap: () => context.go('/tools/sedation'),
                  animationDelay: 300,
                ),
                AnimatedToolCard(
                  title: AppStrings.allTools,
                  subtitle: AppStrings.viewAllTools,
                  icon: Icons.grid_view_rounded,
                  gradient: AppColors.accentGradient,
                  onTap: () => context.go('/tools'),
                  animationDelay: 350,
                ),
              ]),
            ),
          ),

          // Recent Activity Section - now showing tips
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
            sliver: SliverToBoxAdapter(
              child: AnimatedListItem(
                index: 2,
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 24,
                      decoration: BoxDecoration(
                        gradient: AppColors.accentGradient,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      AppStrings.allTools,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // All Tools Grid
          SliverPadding(
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
                  title: AppStrings.antibiotics,
                  subtitle: AppStrings.antibioticsDesc,
                  icon: Icons.medication_outlined,
                  iconColor: AppColors.accentPurple,
                  onTap: () => context.go('/tools/antibiotics'),
                  animationDelay: 400,
                ),
                AnimatedToolCard(
                  title: AppStrings.metabolic,
                  subtitle: AppStrings.metabolicDesc,
                  icon: Icons.science_outlined,
                  iconColor: AppColors.accentEmerald,
                  onTap: () => context.go('/tools/metabolic'),
                  animationDelay: 450,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleHeader(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 20,
        20,
        20,
      ),
      decoration: BoxDecoration(
        gradient: AppColors.medicalGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative elements
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          // Content
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.appName,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.appSubtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
              // Settings button
              GestureDetector(
                onTap: () => context.go('/settings'),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  child: const Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
