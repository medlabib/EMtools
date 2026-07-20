import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';
import '../../core/l10n/app_strings.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final currentLang = ref.watch(languageProvider);

    final isDarkMode = themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system && MediaQuery.platformBrightnessOf(context) == Brightness.dark);

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.settings)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(AppStrings.language),
            subtitle: Text(currentLang == AppLanguage.english ? AppStrings.english : AppStrings.french),
            trailing: TextButton(
              onPressed: () => ref.read(languageProvider.notifier).toggleLanguage(),
              child: Text(currentLang == AppLanguage.english ? AppStrings.french : AppStrings.english),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: Text(context.t('darkMode')),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (_) => ref.read(themeProvider.notifier).toggleTheme(),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(AppStrings.about),
            subtitle: const Text('EMtools v0.1.2'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'EMtools',
                applicationVersion: '0.1.2',
                applicationLegalese: '\u00a9 2025 EMTools',
                children: [
                  const SizedBox(height: 16),
                  Text(
                    context.t('appSubtitle'),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '\u26a0\ufe0f This application is a decision-support tool and does not replace clinical judgment.',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
