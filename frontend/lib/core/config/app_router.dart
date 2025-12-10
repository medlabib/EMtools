import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/dashboard_screen.dart';
import '../../presentation/screens/tools/medical_report/medical_report_screen.dart';
import '../../presentation/screens/tools/calculators/calculators_screen.dart';
import '../../presentation/screens/tools/calculators/calculator_detail_screen.dart';
import '../../presentation/screens/tools/antibiotics/antibiotics_screen.dart';
import '../../presentation/screens/tools/antibiotics/antibiotic_detail_screen.dart';
import '../../presentation/screens/tools/blood_gas/blood_gas_screen.dart';
import '../../presentation/screens/tools/metabolic/metabolic_screen.dart';
import '../../presentation/screens/tools/sedation/sedation_screen.dart';
import '../../presentation/screens/tools/vasoactive/vasoactive_screen.dart';
import '../../presentation/screens/tools_screen.dart';
import '../../presentation/screens/settings_screen.dart';
import '../../presentation/widgets/app_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/dashboard',
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return AppShell(location: state.uri.path, child: child);
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
                builder: (context, state) => const MedicalReportScreen(),
              ),
              GoRoute(
                path: 'calculators',
                builder: (context, state) => const CalculatorsScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) => CalculatorDetailScreen(
                      calculatorId: state.pathParameters['id']!,
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: 'antibiotics',
                builder: (context, state) => const AntibioticsScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) => AntibioticDetailScreen(
                      antibioticId: state.pathParameters['id']!,
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: 'blood-gas',
                builder: (context, state) => const BloodGasScreen(),
              ),
              GoRoute(
                path: 'metabolic',
                builder: (context, state) => const MetabolicScreen(),
              ),
              GoRoute(
                path: 'sedation',
                builder: (context, state) => const SedationScreen(),
              ),
              GoRoute(
                path: 'vasoactive',
                builder: (context, state) => const VasoactiveScreen(),
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
