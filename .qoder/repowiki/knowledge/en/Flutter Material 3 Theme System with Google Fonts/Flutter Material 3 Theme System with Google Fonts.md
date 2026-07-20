---
kind: frontend_style
name: Flutter Material 3 Theme System with Google Fonts
category: frontend_style
scope:
    - '**'
source_files:
    - lib/core/theme/app_theme.dart
    - lib/presentation/providers/theme_provider.dart
    - lib/main.dart
    - pubspec.yaml
---

EMtools uses a centralized Flutter theme system built on Material 3 with Google Fonts, organized under Clean Architecture's `core/theme` layer. The styling approach combines design tokens, component-level theming, and runtime theme switching via Riverpod state management.

**System Overview**
The frontend style is implemented entirely in Dart/Flutter — there are no CSS, SCSS, or Tailwind files. The styling stack consists of:
- **Material 3**: Enabled globally via `useMaterial3: true` in both light and dark themes
- **Google Fonts**: Poppins for headings/display text, Inter for body/label text, loaded at the theme level
- **Design Tokens**: Centralized color constants in `AppColors` class covering primary palette (blue/indigo), accents (teal/cyan/emerald/purple), status colors (success/warning/error/info), and adaptive surface/text colors per brightness
- **Riverpod State**: `themeProvider` manages `ThemeMode` (light/dark/system) persisted to `SharedPreferences`
- **Responsive Strategy**: Uses Flutter's built-in responsive patterns (`MediaQuery`, platform-aware transitions) rather than custom breakpoints

**Architecture & Conventions**
- All visual tokens live in `lib/core/theme/app_theme.dart` — screens never define hardcoded colors or fonts
- Two complete `ThemeData` instances (`lightTheme`, `darkTheme`) mirror every component style (buttons, cards, inputs, chips, navigation bars)
- Screens consume theme via `ref.watch(themeProvider)` and use semantic tokens from `AppColors` instead of raw hex values
- Component styles are defined once in `ThemeData` sub-themes (`ElevatedButtonThemeData`, `OutlinedButtonThemeData`, `CardThemeData`, `InputDecorationTheme`, etc.) and inherited app-wide
- Dark mode toggling persists user preference and defaults to system brightness when unset

**Key Design Decisions**
- Primary brand color is `#2563EB` (blue) with indigo/purple variants for gradients
- Card surfaces use flat design (elevation: 0) with rounded corners (16px radius)
- Input fields use filled style with subtle borders and consistent 12px border radius
- Page transitions use Cupertino-style animations across all platforms for consistency
- No custom CSS framework — pure Flutter widget composition with theme-driven styling

**Rules for Developers**
- Always reference colors via `AppColors.*` constants, never hardcode hex values in widgets
- Use `GoogleFonts.poppins` for headings and `GoogleFonts.inter` for body text as defined in theme
- When adding new UI components, extend the corresponding `*ThemeData` in both light and dark themes
- For dynamic color selection based on theme, use `AppColors.getTextPrimary(isDark)` helper methods
- Theme changes should go through `themeProvider.notifier.toggleTheme()` or `setTheme()`, not direct widget rebuilds