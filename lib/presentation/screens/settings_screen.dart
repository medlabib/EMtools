import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final currentLang = ref.watch(languageProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final isDarkMode = themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            MediaQuery.platformBrightnessOf(context) == Brightness.dark);

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(isDark),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 4),
              child: Text(
                AppStrings.settings,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                  color: AppColors.getTextPrimary(isDark),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _SectionLabel(context.t('preferences'), isDark: isDark),
          const SizedBox(height: 10),
          _SettingsCard(
            isDark: isDark,
            children: [
              _SettingsTile(
                isDark: isDark,
                icon: Icons.language_rounded,
                title: AppStrings.language,
                subtitle: currentLang == AppLanguage.english
                    ? AppStrings.english
                    : AppStrings.french,
                trailing: _PillButton(
                  label: currentLang == AppLanguage.english
                      ? AppStrings.french
                      : AppStrings.english,
                  isDark: isDark,
                  onTap: () =>
                      ref.read(languageProvider.notifier).toggleLanguage(),
                ),
              ),
              _Hairline(isDark: isDark),
              _SettingsTile(
                isDark: isDark,
                icon: Icons.dark_mode_rounded,
                title: context.t('darkMode'),
                subtitle: isDarkMode ? context.t('on') : context.t('off'),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (_) =>
                      ref.read(themeProvider.notifier).toggleTheme(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SectionLabel(context.t('about'), isDark: isDark),
          const SizedBox(height: 10),
          _SettingsCard(
            isDark: isDark,
            children: [
              _SettingsTile(
                isDark: isDark,
                icon: Icons.info_outline_rounded,
                title: AppStrings.about,
                subtitle: context.t('appVersion').replaceAll('{0}', '0.2.0'),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.getTextHint(isDark),
                ),
                onTap: () => _showAbout(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              AppStrings.disclaimerText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                fontStyle: FontStyle.italic,
                color: AppColors.getTextHint(isDark),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'EMtools',
      applicationVersion: '0.1.2',
      applicationLegalese: '\u00a9 2025 EMTools',
      children: [
        const SizedBox(height: 16),
        Text(context.t('appSubtitle')),
        const SizedBox(height: 8),
        Text(
          AppStrings.disclaimerText,
          style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  final bool isDark;
  const _SectionLabel(this.text, {required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
        color: AppColors.getTextSecondary(isDark),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  final bool isDark;
  const _SettingsCard({required this.children, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.getCardColor(isDark),
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(color: AppColors.getBorderColor(isDark)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }
}

class _Hairline extends StatelessWidget {
  final bool isDark;
  const _Hairline({required this.isDark});

  @override
  Widget build(BuildContext context) => Divider(
        height: 1,
        thickness: 1,
        indent: 56,
        color: AppColors.getBorderColor(isDark),
      );
}

class _SettingsTile extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.isDark,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.getPrimary(isDark).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusControl),
                ),
                child: Icon(icon, size: 20, color: AppColors.getPrimary(isDark)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.getTextPrimary(isDark),
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.getTextSecondary(isDark),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 12),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  final String label;
  final bool isDark;
  final VoidCallback onTap;

  const _PillButton({
    required this.label,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.getPrimary(isDark);
    return Material(
      color: accent.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: accent,
            ),
          ),
        ),
      ),
    );
  }
}
