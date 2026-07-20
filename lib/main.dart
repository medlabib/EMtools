import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/app_router.dart';
import 'core/theme/app_theme.dart';
import 'presentation/providers/theme_provider.dart';
import 'core/l10n/localized.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(
    child: EMToolsApp(),
  ));
}

class EMToolsApp extends ConsumerStatefulWidget {
  const EMToolsApp({super.key});

  @override
  ConsumerState<EMToolsApp> createState() => _EMToolsAppState();
}

class _EMToolsAppState extends ConsumerState<EMToolsApp> {
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeProvider);
    // Keeps the LString ambient language in sync (transitively watches
    // languageProvider, so the usual language rebuild still fires).
    ref.watch(ambientLanguageProvider);

    return MaterialApp.router(
      title: 'EMtools',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
