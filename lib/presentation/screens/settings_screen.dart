import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../../core/l10n/app_strings.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    
    final isDarkMode = themeMode == ThemeMode.dark || 
        (themeMode == ThemeMode.system && MediaQuery.platformBrightnessOf(context) == Brightness.dark);
    
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settings)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text(AppStrings.language),
            subtitle: const Text('Français'),
            onTap: () {
              // TODO: Implement language selection
            },
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Mode sombre'),
            trailing: Switch(
              value: isDarkMode, 
              onChanged: (v) {
                ref.read(themeProvider.notifier).toggleTheme();
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text(AppStrings.about),
            subtitle: const Text('EMTools v0.1.0'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'EMTools',
                applicationVersion: '0.1.0',
                applicationLegalese: '© 2025 EMTools',
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Outils d\'aide à la décision pour la médecine d\'urgence et la réanimation.',
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '⚠️ Cette application est un outil d\'aide et ne remplace pas le jugement clinique.',
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
