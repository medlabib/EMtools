# AGENTS.md

This file provides guidance to Qoder (qoder.com) when working with code in this repository.

## Project Overview

EMtools is a Flutter medical toolkit for emergency physicians and intensivists. It provides clinical calculators (40+), blood gas interpretation, vasoactive drug dosing, sedation protocols, antibiotic guides, metabolic correction, CPR timer, and ABCDE assessment report generation. The UI is bilingual (French default, English optional).

## Commands

```bash
# Install dependencies
flutter pub get

# Run in development
flutter run

# Run all tests
flutter test

# Run a single test file
flutter test test/unit/blood_gas_calculator_test.dart

# Run tests matching a name
flutter test --name "calculates PBW correctly"

# Static analysis / lint
flutter analyze

# Build web (production, deployed to GitHub Pages at /EMtools/)
flutter build web --release --base-href "/EMtools/"

# Build Android APK
flutter build apk --release

# Build Windows (requires Visual Studio)
flutter build windows --release

# Code generation (json_serializable)
dart run build_runner build
```

## Architecture

The app follows a simplified clean architecture with three layers under `lib/`:

```
lib/
├── core/           # Cross-cutting: router, theme, l10n, shared widgets
├── data/           # Static data sources (no network, no database)
│   └── datasources/  # Hardcoded medical data as Dart lists/maps
├── domain/         # Entities with embedded business logic
│   └── entities/     # Pure Dart classes; calculators embed their own calculate functions
└── presentation/   # UI layer
    ├── providers/    # Riverpod Notifier providers (theme, language)
    ├── screens/      # One folder per tool under screens/tools/
    └── widgets/      # App shell, navigation
```

### Key architectural decisions

- **No repository/use-case layer.** Data sources are static in-memory lists (e.g., `allCalculators` in `calculators_data.dart`). Screens import data sources directly.
- **Domain entities contain logic.** `BloodGasCalculator.calculate()`, `MetabolicCalculator`, and each `Calculator.calculate` function live inside domain entities, not in separate services.
- **Deferred imports for code splitting.** All tool screens are loaded via `deferred as` imports in `app_router.dart` and wrapped in `DeferredWidget` for web performance.
- **State management is minimal.** Only theme and language use Riverpod providers. Tool screens are mostly local `StatefulWidget` state.

### Routing

GoRouter with a `ShellRoute` providing the app shell (bottom nav). Routes are defined in `lib/core/config/app_router.dart`. Tool routes are nested under `/tools/<tool-name>`. Detail routes use path parameters (e.g., `/tools/calculators/:id`).

### Localization (custom, not flutter_gen)

Bilingual strings live in `lib/core/l10n/app_strings.dart` as two `Map<String, String>` constants (`_fr`, `_en`). Access via:
- `AppStrings.someKey` static getters (most common in widgets)
- `context.t('key')` extension method
- `locProvider` Riverpod provider that syncs the static map

Language switching triggers a full subtree rebuild via `LanguageRebuildShell` + `KeyedSubtree` with a language-keyed `ValueKey`.

### Data-driven calculators

Each calculator in `calculators_data.dart` is a `Calculator` object with:
- Typed `fields` (select/number/checkbox/radio)
- An inline `calculate` function `(Map<String, dynamic> values) => double`
- `interpretations` list mapping score ranges to labels/colors

To add a new calculator: append to `allCalculators` list following the existing pattern.

## Testing

Tests are in `test/unit/` and focus on validating data integrity and calculation correctness. They import domain entities and data sources directly (no widget tests for tools). Pattern: instantiate entity/data → call calculate → assert with `closeTo` or `expect`.

## UI Style

Keep visual polish clean and restrained. Avoid excessive fancy effects (animated shifting gradients, frosted glass blur, sparkle particles, ShaderMask text gradients, floating particles, wave animations).

## CI/CD

GitHub Actions (`.github/workflows/deploy.yml`) runs `flutter test` then builds and deploys the web app to GitHub Pages on push to `master`.
