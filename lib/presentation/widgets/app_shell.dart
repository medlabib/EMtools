import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/l10n/app_strings.dart';
import '../providers/language_provider.dart';

/// Wraps AppShell to force full subtree rebuild when language changes.
/// This ensures StatefulWidget tool screens pick up the new language.
class LanguageRebuildShell extends ConsumerWidget {
  final Widget child;
  final String location;

  const LanguageRebuildShell({
    super.key,
    required this.child,
    required this.location,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(languageProvider);
    return AppShell(
      location: location,
      child: KeyedSubtree(key: ValueKey('lang_${lang.name}'), child: child),
    );
  }
}

class AppShell extends StatelessWidget {
  final Widget child;
  final String location;

  const AppShell({
    super.key,
    required this.child,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;
    final isWideDesktop = screenWidth > 1200;
    final selectedIndex = _getSelectedIndex(location);

    return Scaffold(
      body: Row(
        children: [
          if (isDesktop)
            _NavigationRail(
              selectedIndex: selectedIndex,
              isExtended: isWideDesktop,
              onDestinationSelected: (index) => _onItemTapped(index, context),
            ),
          if (isDesktop) const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _DesktopContentWrapper(
              isDesktop: isDesktop,
              child: child,
            ),
          ),
        ],
      ),
      bottomNavigationBar: isDesktop
          ? null
          : _BottomNavBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) => _onItemTapped(index, context),
            ),
    );
  }

  int _getSelectedIndex(String location) {
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/tools')) return 1;
    if (location.startsWith('/settings')) return 2;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/tools');
        break;
      case 2:
        context.go('/settings');
        break;
    }
  }
}

class _NavDestination {
  final String labelKey;
  final IconData icon;
  final IconData selectedIcon;

  const _NavDestination({
    required this.labelKey,
    required this.icon,
    required this.selectedIcon,
  });
}

const _destinations = [
  _NavDestination(
    labelKey: 'dashboardTab',
    icon: Icons.dashboard_outlined,
    selectedIcon: Icons.dashboard_rounded,
  ),
  _NavDestination(
    labelKey: 'toolsTab',
    icon: Icons.medical_services_outlined,
    selectedIcon: Icons.medical_services_rounded,
  ),
  _NavDestination(
    labelKey: 'settingsTab',
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings_rounded,
  ),
];

String _labelFor(String key) {
  switch (key) {
    case 'dashboardTab':
      return AppStrings.dashboardTab;
    case 'toolsTab':
      return AppStrings.toolsTab;
    default:
      return AppStrings.settingsTab;
  }
}

class _BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const _BottomNavBar({
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.primaryHover : AppColors.primary;
    final inactive = AppColors.getTextSecondary(isDark);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.getCardColor(isDark),
        border: Border(
          top: BorderSide(color: AppColors.getBorderColor(isDark)),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: SizedBox(
            height: 56,
            child: Row(
              children: List.generate(_destinations.length, (i) {
                final isSelected = selectedIndex == i;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      onDestinationSelected(i);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? accent.withValues(alpha: 0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isSelected
                                ? _destinations[i].selectedIcon
                                : _destinations[i].icon,
                            color: isSelected ? accent : inactive,
                            size: 22,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            _labelFor(_destinations[i].labelKey),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight:
                                  isSelected ? FontWeight.w600 : FontWeight.w500,
                              color: isSelected ? accent : inactive,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationRail extends StatelessWidget {
  final int selectedIndex;
  final bool isExtended;
  final ValueChanged<int> onDestinationSelected;

  const _NavigationRail({
    required this.selectedIndex,
    required this.isExtended,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.primaryHover : AppColors.primary;
    final inactive = AppColors.getTextSecondary(isDark);
    final width = isExtended ? 200.0 : 80.0;
    const itemHeight = 64.0;

    return Container(
      width: width,
      color: AppColors.getCardColor(isDark),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: List.generate(_destinations.length, (i) {
              final isSelected = selectedIndex == i;
              return SizedBox(
                height: itemHeight,
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onDestinationSelected(i);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? accent.withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isSelected
                              ? _destinations[i].selectedIcon
                              : _destinations[i].icon,
                          color: isSelected ? accent : inactive,
                          size: 22,
                        ),
                        if (isExtended) ...[
                          const SizedBox(height: 4),
                          Text(
                            _labelFor(_destinations[i].labelKey),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight:
                                  isSelected ? FontWeight.w600 : FontWeight.w500,
                              color: isSelected ? accent : inactive,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

/// Widget that wraps content for desktop with max width constraint
class _DesktopContentWrapper extends StatelessWidget {
  final bool isDesktop;
  final Widget child;

  const _DesktopContentWrapper({
    required this.isDesktop,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!isDesktop) return child;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: child,
      ),
    );
  }
}
