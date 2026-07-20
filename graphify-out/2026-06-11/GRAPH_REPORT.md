# Graph Report - .  (2026-06-11)

## Corpus Check
- 38 files · ~69,387 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1368 nodes · 1590 edges · 37 communities (35 shown, 2 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Localization Strings (FR)|Localization Strings (FR)]]
- [[_COMMUNITY_Medical Report Form|Medical Report Form]]
- [[_COMMUNITY_CPR Timer|CPR Timer]]
- [[_COMMUNITY_Metabolic Calculations|Metabolic Calculations]]
- [[_COMMUNITY_Sedation Screen|Sedation Screen]]
- [[_COMMUNITY_Drug Datasources|Drug Datasources]]
- [[_COMMUNITY_Metabolic Screen|Metabolic Screen]]
- [[_COMMUNITY_Blood Gas Engine|Blood Gas Engine]]
- [[_COMMUNITY_Theme Provider|Theme Provider]]
- [[_COMMUNITY_Antibiotic Entity|Antibiotic Entity]]
- [[_COMMUNITY_Paste Entity|Paste Entity]]
- [[_COMMUNITY_App Theme Palette|App Theme Palette]]
- [[_COMMUNITY_Sedation Entity|Sedation Entity]]
- [[_COMMUNITY_Blood Gas Screen|Blood Gas Screen]]
- [[_COMMUNITY_Animated Widgets|Animated Widgets]]
- [[_COMMUNITY_Vasoactive Entity|Vasoactive Entity]]
- [[_COMMUNITY_Calculator Entity|Calculator Entity]]
- [[_COMMUNITY_Antibiotic Detail Screen|Antibiotic Detail Screen]]
- [[_COMMUNITY_Calculators List Screen|Calculators List Screen]]
- [[_COMMUNITY_Calculator Detail Screen|Calculator Detail Screen]]
- [[_COMMUNITY_Protocols List Screen|Protocols List Screen]]
- [[_COMMUNITY_App Router|App Router]]
- [[_COMMUNITY_Protocol Detail Screen|Protocol Detail Screen]]
- [[_COMMUNITY_Antibiotics Screen|Antibiotics Screen]]
- [[_COMMUNITY_Screen State Classes|Screen State Classes]]
- [[_COMMUNITY_Shared UI Widgets|Shared UI Widgets]]
- [[_COMMUNITY_App Entry Point|App Entry Point]]
- [[_COMMUNITY_Protocols Datasource|Protocols Datasource]]
- [[_COMMUNITY_Deferred Loading Util|Deferred Loading Util]]
- [[_COMMUNITY_Route Definitions|Route Definitions]]
- [[_COMMUNITY_User Entity|User Entity]]
- [[_COMMUNITY_Dashboard Screen|Dashboard Screen]]
- [[_COMMUNITY_Stateful Screen Bases|Stateful Screen Bases]]
- [[_COMMUNITY_Calculators Datasource|Calculators Datasource]]
- [[_COMMUNITY_Antibiotics Datasource|Antibiotics Datasource]]
- [[_COMMUNITY_Antibiotic Detail State|Antibiotic Detail State]]
- [[_COMMUNITY_CPR Timer State|CPR Timer State]]

## God Nodes (most connected - your core abstractions)
1. `build` - 9 edges
2. `themeProvider` - 5 edges
3. `_AnimatedToolCardState` - 4 edges
4. `_AnimatedListItemState` - 4 edges
5. `_ShimmerLoadingState` - 4 edges
6. `_PulsingDotState` - 4 edges
7. `_animation` - 4 edges
8. `EMToolsApp` - 4 edges
9. `_DashboardScreenState` - 4 edges
10. `_AntibioticDetailScreenState` - 4 edges

## Surprising Connections (you probably didn't know these)
- `build` --references--> `themeProvider`  [EXTRACTED]
  lib/presentation/screens/settings_screen.dart → lib/presentation/providers/theme_provider.dart
- `build` --references--> `routerProvider`  [EXTRACTED]
  lib/main.dart → lib/core/config/app_router.dart
- `EMToolsApp` --references--> `routerProvider`  [EXTRACTED]
  lib/main.dart → lib/core/config/app_router.dart
- `UserModel` --inherits--> `User`  [EXTRACTED]
  lib/data/models/user_model.dart → lib/domain/entities/user.dart
- `EMToolsApp` --references--> `themeProvider`  [EXTRACTED]
  lib/main.dart → lib/presentation/providers/theme_provider.dart

## Import Cycles
- None detected.

## Communities (37 total, 2 thin omitted)

### Community 0 - "Localization Strings (FR)"
Cohesion: 0.01
Nodes (317): aaGradient, about, active, add, admin, adminRole, adminTitle, adult (+309 more)

### Community 1 - "Medical Report Form"
Cohesion: 0.02
Nodes (110): FormState, _ageController, _airwayActionController, _airwayDeviceController, _airwayStatus, _alcool, _animationController, _antecedentsController (+102 more)

### Community 2 - "CPR Timer"
Cohesion: 0.03
Nodes (60): dart:async, package:wakelock_plus/wakelock_plus.dart, _addEvent, _adrenalineAlertShown, _adrenalineCount, _adrenalineIntervalMinutes, _adrenalineIntervalSeconds, _adrenalineTimer (+52 more)

### Community 3 - "Metabolic Calculations"
Cohesion: 0.04
Nodes (52): AgeGroup, baselineNa, calculateCorrectedCalcium, calculateDysnatremiaCorrection, calculateFreeWaterDeficit, calculateSodiumDeficit, calculateTBW, ClinicalFinding (+44 more)

### Community 4 - "Sedation Screen"
Cohesion: 0.04
Nodes (48): ../../../../data/datasources/sedation_data.dart, _age, _ageController, _ageGroup, ageGroupLabel, _animationController, build, _buildAllDrugsView (+40 more)

### Community 5 - "Drug Datasources"
Cohesion: 0.04
Nodes (46): ../../../../data/datasources/vasoactive_data.dart, allDrugs, SedationData, allDrugs, VasoactiveData, ../../../../domain/entities/sedation.dart, ../../../../domain/entities/vasoactive.dart, static final List (+38 more)

### Community 6 - "Metabolic Screen"
Cohesion: 0.04
Nodes (46): ../../../../domain/entities/metabolic.dart, CorrectionMode, IVFluid, SodiumDirection, _ageGroup, _albumin, _animationController, _baselineNa (+38 more)

### Community 7 - "Blood Gas Engine"
Cohesion: 0.04
Nodes (46): aaGradient, agCorrected, age, agUncorrected, alb, ardsGrade, BloodGasCalculator, calculate (+38 more)

### Community 8 - "Theme Provider"
Cohesion: 0.05
Nodes (41): Gradient?, Notifier, package:shared_preferences/shared_preferences.dart, build, _loadTheme, setTheme, _themeKey, ThemeNotifier (+33 more)

### Community 9 - "Antibiotic Entity"
Cohesion: 0.05
Nodes (41): broad,
  gramPositive,
  gramNegative,
  anaerobic,, DoseInfo, adult, Antibiotic, atypical, availableInTunisia, contraindications, dose (+33 more)

### Community 10 - "Paste Entity"
Cohesion: 0.05
Nodes (40): DateTime, burnAfterRead, content, expiresAt, expiresInHours, fromJson, id, images (+32 more)

### Community 11 - "App Theme Palette"
Cohesion: 0.05
Nodes (41): package:google_fonts/google_fonts.dart, static const Color, static const LinearGradient, static final, accentCyan, accentEmerald, accentGradient, accentPurple (+33 more)

### Community 12 - "Sedation Entity"
Cohesion: 0.06
Nodes (34): AgeGroup, advantages, AgeGroup, ageRange, concentrations, contraindications, dilution, dose (+26 more)

### Community 13 - "Blood Gas Screen"
Cohesion: 0.06
Nodes (31): _animationController, BloodGasScreen, _BloodGasScreenState, build, _buildBioSection, _buildDetailedResults, _buildGasSection, _buildHeader (+23 more)

### Community 14 - "Animated Widgets"
Cohesion: 0.06
Nodes (31): Duration, EdgeInsets?, ../theme/app_theme.dart, actions, animationDelay, borderRadius, build, child (+23 more)

### Community 15 - "Vasoactive Entity"
Cohesion: 0.06
Nodes (31): alpha, beta1, beta2, category, commonPrep, concentrations, contraindications, defaultConcentrationIndex (+23 more)

### Community 16 - "Calculator Entity"
Cohesion: 0.07
Nodes (29): double?, Calculator, CalculatorCategory, CalculatorField, CalculatorFieldType, CalculatorOption, category, color (+21 more)

### Community 17 - "Antibiotic Detail Screen"
Cohesion: 0.07
Nodes (27): Antibiotic, _addMedication, _animationController, _antibiotic, antibioticId, build, _buildBulletItem, _buildInfoCard (+19 more)

### Community 18 - "Calculators List Screen"
Cohesion: 0.08
Nodes (25): Calculator, build, _buildCategorySection, _buildSearchBar, calculator, _CalculatorCard, _CalculatorCardState, color (+17 more)

### Community 19 - "Calculator Detail Screen"
Cohesion: 0.08
Nodes (25): _animationController, build, _buildCalculateButton, _buildCheckboxField, _buildField, _buildHeader, _buildNumberField, _buildResultCard (+17 more)

### Community 20 - "Protocols List Screen"
Cohesion: 0.10
Nodes (21): Color?, int get, build, _buildCategoryChip, _buildProtocolCard, createState, dispose, _favorites (+13 more)

### Community 21 - "App Router"
Cohesion: 0.09
Nodes (21): _rootNavigatorKey, _shellNavigatorKey, GoRouter, NavigatorState, ../../presentation/screens/dashboard_screen.dart, ../../presentation/screens/settings_screen.dart, ../../presentation/screens/tools/antibiotics/antibiotic_detail_screen.dart, ../../presentation/screens/tools/antibiotics/antibiotics_screen.dart (+13 more)

### Community 22 - "Protocol Detail Screen"
Cohesion: 0.10
Nodes (21): ../../../../data/datasources/protocols_data.dart, package:url_launcher/url_launcher.dart, Protocol, build, _buildInfoCard, _buildKeyPointsCard, _buildSourceCard, _buildStepCard (+13 more)

### Community 23 - "Antibiotics Screen"
Cohesion: 0.10
Nodes (20): _animationController, build, _buildAntibioticCard, _buildAntibioticsList, _buildEmptyState, _buildFilterChip, _buildSearchAndFilters, _buildSliverAppBar (+12 more)

### Community 24 - "Screen State Classes"
Cohesion: 0.17
Nodes (21): AntibioticsScreen, _AntibioticsScreenState, CalculatorDetailScreen, _CalculatorDetailScreenState, CalculatorsScreen, _CalculatorsScreenState, ToolsScreen, _ToolsScreenState (+13 more)

### Community 25 - "Shared UI Widgets"
Cohesion: 0.12
Nodes (17): _CategoryChip, package:go_router/go_router.dart, ProtocolDetailScreen, _CategoryChip, _DrugDetailsSheet, StatelessWidget, Widget, GlassContainer (+9 more)

### Community 26 - "App Entry Point"
Cohesion: 0.17
Nodes (14): routerProvider, ConsumerWidget, core/config/app_router.dart, ../../core/l10n/app_strings.dart, ../../core/theme/app_theme.dart, build, EMToolsApp, main (+6 more)

### Community 27 - "Protocols Datasource"
Cohesion: 0.14
Nodes (13): allProtocols, analgesiaProtocols, cardiologyProtocols, metabolicProtocols, neurologyProtocols, obstetricProtocols, pediatricProtocols, respiratoryProtocols (+5 more)

### Community 28 - "Deferred Loading Util"
Cohesion: 0.17
Nodes (12): Future, typedef, build, builder, createState, DeferredWidget, DeferredWidgetBuilder, _DeferredWidgetState (+4 more)

### Community 29 - "Route Definitions"
Cohesion: 0.15
Nodes (13): Route /dashboard, Route /settings, Route /tools, Route /tools/antibiotics, Route /tools/blood-gas, Route /tools/calculators, Route /tools/medical-report, Route /tools/metabolic (+5 more)

### Community 30 - "User Entity"
Cohesion: 0.17
Nodes (10): ../../domain/entities/user.dart, email, fullName, id, isActive, isSuperuser, User, fromJson (+2 more)

### Community 31 - "Dashboard Screen"
Cohesion: 0.22
Nodes (8): AnimationController, ../../core/widgets/animated_widgets.dart, createState, dispose, _headerAnimation, _headerController, initState, _animation

### Community 32 - "Stateful Screen Bases"
Cohesion: 0.38
Nodes (7): ConsumerState, ConsumerStatefulWidget, MedicalReportScreen, _MedicalReportScreenState, DashboardScreen, _DashboardScreenState, TickerProviderStateMixin

### Community 33 - "Calculators Datasource"
Cohesion: 0.40
Nodes (4): dart:math, allCalculators, ../../../../domain/entities/calculator.dart, package:flutter/material.dart

### Community 34 - "Antibiotics Datasource"
Cohesion: 0.50
Nodes (3): allAntibiotics, ../../../../domain/entities/antibiotic.dart, List

## Knowledge Gaps
- **1141 isolated node(s):** `_rootNavigatorKey`, `_shellNavigatorKey`, `AppStrings`, `appName`, `appSubtitle` (+1136 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **2 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `BloodGasPatientData` connect `Blood Gas Screen` to `Blood Gas Engine`?**
  _High betweenness centrality (0.027) - this node is a cross-community bridge._
- **Why does `BloodGasResults` connect `Blood Gas Screen` to `Blood Gas Engine`?**
  _High betweenness centrality (0.027) - this node is a cross-community bridge._
- **Why does `build` connect `Route Definitions` to `Dashboard Screen`?**
  _High betweenness centrality (0.015) - this node is a cross-community bridge._
- **What connects `_rootNavigatorKey`, `_shellNavigatorKey`, `AppStrings` to the rest of the system?**
  _1141 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Localization Strings (FR)` be split into smaller, more focused modules?**
  _Cohesion score 0.006289308176100629 - nodes in this community are weakly interconnected._
- **Should `Medical Report Form` be split into smaller, more focused modules?**
  _Cohesion score 0.018018018018018018 - nodes in this community are weakly interconnected._
- **Should `CPR Timer` be split into smaller, more focused modules?**
  _Cohesion score 0.03278688524590164 - nodes in this community are weakly interconnected._