import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/providers/language_provider.dart';
import '../../presentation/screens/dashboard_screen.dart';
import '../../presentation/screens/tools/medical_report/medical_report_screen.dart' deferred as medical_report;
import '../../presentation/screens/tools/calculators/calculators_screen.dart' deferred as calculators;
import '../../presentation/screens/tools/calculators/calculator_detail_screen.dart' deferred as calculator_detail;
import '../../presentation/screens/tools/antibiotics/antibiotics_screen.dart' deferred as antibiotics;
import '../../presentation/screens/tools/antibiotics/antibiotic_detail_screen.dart' deferred as antibiotic_detail;
import '../../presentation/screens/tools/blood_gas/blood_gas_screen.dart' deferred as blood_gas;
import '../../presentation/screens/tools/metabolic/metabolic_screen.dart' deferred as metabolic;
import '../../presentation/screens/tools/sedation/sedation_screen.dart' deferred as sedation;
import '../../presentation/screens/tools/vasoactive/vasoactive_screen.dart' deferred as vasoactive;
import '../../presentation/screens/tools/protocols/protocols_screen.dart' deferred as protocols;
import '../../presentation/screens/tools/protocols/protocol_detail_screen.dart' deferred as protocol_detail;
import '../../presentation/screens/tools/rcp_timer/rcp_timer_screen.dart' deferred as rcp_timer;
import '../../presentation/screens/tools_screen.dart';
import '../../presentation/screens/settings_screen.dart';
import '../../presentation/widgets/app_shell.dart';
import '../utils/deferred_widget.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/dashboard',
    refreshListenable: languageChangeNotifier,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return LanguageRebuildShell(location: state.uri.path, child: child);
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/tools',
            builder: (context, state) => const ToolsScreen(),
            routes: [
              GoRoute(
                path: 'medical-report',
                builder: (context, state) => DeferredWidget(
                  libraryLoader: medical_report.loadLibrary,
                  builder: () => medical_report.MedicalReportScreen(),
                ),
              ),
              GoRoute(
                path: 'calculators',
                builder: (context, state) => DeferredWidget(
                  libraryLoader: calculators.loadLibrary,
                  builder: () => calculators.CalculatorsScreen(),
                ),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) => DeferredWidget(
                      libraryLoader: calculator_detail.loadLibrary,
                      builder: () => calculator_detail.CalculatorDetailScreen(
                        calculatorId: state.pathParameters['id']!,
                      ),
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: 'antibiotics',
                builder: (context, state) => DeferredWidget(
                  libraryLoader: antibiotics.loadLibrary,
                  builder: () => antibiotics.AntibioticsScreen(),
                ),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) => DeferredWidget(
                      libraryLoader: antibiotic_detail.loadLibrary,
                      builder: () => antibiotic_detail.AntibioticDetailScreen(
                        antibioticId: state.pathParameters['id']!,
                      ),
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: 'blood-gas',
                builder: (context, state) => DeferredWidget(
                  libraryLoader: blood_gas.loadLibrary,
                  builder: () => blood_gas.BloodGasScreen(),
                ),
              ),
              GoRoute(
                path: 'metabolic',
                builder: (context, state) => DeferredWidget(
                  libraryLoader: metabolic.loadLibrary,
                  builder: () => metabolic.MetabolicScreen(),
                ),
              ),
              GoRoute(
                path: 'sedation',
                builder: (context, state) => DeferredWidget(
                  libraryLoader: sedation.loadLibrary,
                  builder: () => sedation.SedationScreen(),
                ),
              ),
              GoRoute(
                path: 'vasoactive',
                builder: (context, state) => DeferredWidget(
                  libraryLoader: vasoactive.loadLibrary,
                  builder: () => vasoactive.VasoactiveScreen(),
                ),
              ),
              GoRoute(
                path: 'protocols',
                builder: (context, state) => DeferredWidget(
                  libraryLoader: protocols.loadLibrary,
                  builder: () => protocols.ProtocolsScreen(),
                ),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) => DeferredWidget(
                      libraryLoader: protocol_detail.loadLibrary,
                      builder: () => protocol_detail.ProtocolDetailScreen(
                        protocolId: state.pathParameters['id']!,
                      ),
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: 'rcp-timer',
                builder: (context, state) => DeferredWidget(
                  libraryLoader: rcp_timer.loadLibrary,
                  builder: () => rcp_timer.RcpTimerScreen(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
});
