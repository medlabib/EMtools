import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// EMtools color tokens. See DESIGN.md for the rationale behind every value.
///
/// Rule of thumb for screens: never hardcode a raw color — use the adaptive
/// `getX(isDark)` helpers (or `Theme.of(context)` roles) so both light and dark
/// modes stay correct. A literal `Colors.white` background is a bug unless it is
/// guarded by `isDark`.
class AppColors {
  // ── Accent: clinical teal ────────────────────────────────────────────────
  // Light uses teal-600; dark uses a brighter teal-400 so the accent reads on
  // a near-black surface.
  static const Color primary = Color(0xFF0D9488);
  static const Color primaryHover = Color(0xFF0F766E);
  static const Color primaryDark = Color(0xFF0F766E);
  static const Color primaryBright = Color(0xFF2DD4BF); // dark-mode accent
  static const Color primaryBrightHover = Color(0xFF5EEAD4);
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onPrimaryDark = Color(0xFF04211E);

  // Legacy accent aliases — collapsed onto the single teal accent so no screen
  // renders blue/indigo/purple chrome. Retained only to avoid call-site churn.
  static const Color primaryBlue = primary;
  static const Color primaryIndigo = primaryDark;
  static const Color primaryPurple = primary;
  static const Color accentTeal = primaryHover;
  static const Color accentCyan = primaryHover;
  static const Color accentEmerald = primaryHover;
  static const Color accentPurple = primary;

  // ── Clinical status (semantic only) ──────────────────────────────────────
  // Base constant = light-mode value; `getX(isDark)` brightens for dark mode.
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFD97706);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF2563EB);
  static const Color successDark = Color(0xFF22C55E);
  static const Color warningDark = Color(0xFFF59E0B);
  static const Color errorDark = Color(0xFFEF4444);
  static const Color infoDark = Color(0xFF3B82F6);

  // ── Neutrals: light mode ─────────────────────────────────────────────────
  static const Color backgroundLight = Color(0xFFF6F8FA);
  static const Color bgSubtleLight = Color(0xFFEEF1F5);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceHoverLight = Color(0xFFF9FAFB);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFE4E8EE);
  static const Color borderStrongLight = Color(0xFFD3D9E0);

  // ── Neutrals: dark mode (near-black, cool slate) ─────────────────────────
  static const Color backgroundDark = Color(0xFF0B0D12);
  static const Color bgSubtleDark = Color(0xFF12151C);
  static const Color surfaceDark = Color(0xFF161A22);
  static const Color surfaceHoverDark = Color(0xFF1C212B);
  static const Color cardDark = Color(0xFF161A22);
  static const Color borderDark = Color(0xFF242A34);
  static const Color borderStrongDark = Color(0xFF2F3742);

  // ── Text: light mode ─────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF0F1729);
  static const Color textSecondary = Color(0xFF5B6675);
  static const Color textHint = Color(0xFF8B96A5);

  // ── Text: dark mode (soft white, never pure #FFF) ────────────────────────
  static const Color textPrimaryDark = Color(0xFFEDF0F4);
  static const Color textSecondaryDark = Color(0xFF9AA3B2);
  static const Color textHintDark = Color(0xFF6A7382);

  // ── Adaptive helpers ─────────────────────────────────────────────────────
  static Color getTextPrimary(bool isDark) => isDark ? textPrimaryDark : textPrimary;
  static Color getTextSecondary(bool isDark) => isDark ? textSecondaryDark : textSecondary;
  static Color getTextHint(bool isDark) => isDark ? textHintDark : textHint;
  static Color getCardColor(bool isDark) => isDark ? surfaceDark : surfaceLight;
  static Color getSurfaceHover(bool isDark) => isDark ? surfaceHoverDark : surfaceHoverLight;
  static Color getBackgroundColor(bool isDark) => isDark ? backgroundDark : backgroundLight;
  static Color getSurfaceSubtle(bool isDark) => isDark ? bgSubtleDark : bgSubtleLight;
  static Color getBorderColor(bool isDark) => isDark ? borderDark : borderLight;
  static Color getBorderStrong(bool isDark) => isDark ? borderStrongDark : borderStrongLight;
  static Color getPrimary(bool isDark) => isDark ? primaryBright : primary;
  static Color getPrimaryHover(bool isDark) => isDark ? primaryBrightHover : primaryHover;
  static Color getOnPrimary(bool isDark) => isDark ? onPrimaryDark : onPrimaryLight;

  static Color getSuccess(bool isDark) => isDark ? successDark : success;
  static Color getWarning(bool isDark) => isDark ? warningDark : warning;
  static Color getError(bool isDark) => isDark ? errorDark : error;
  static Color getInfo(bool isDark) => isDark ? infoDark : info;
}

/// Shared spacing / radius scale (see DESIGN.md §5).
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;

  static const double radiusCard = 14;
  static const double radiusControl = 10;
  static const double radiusChip = 8;
}

class AppTheme {
  static const double _cardRadius = AppSpacing.radiusCard;
  static const double _controlRadius = AppSpacing.radiusControl;
  static const double _chipRadius = AppSpacing.radiusChip;

  /// Tabular / monospaced figure style for clinical result readouts.
  static TextStyle readoutStyle({
    required bool isDark,
    double fontSize = 32,
    Color? color,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      color: color ?? AppColors.getTextPrimary(isDark),
      fontFeatures: const [FontFeature.tabularFigures()],
      letterSpacing: 0,
    );
  }

  static TextTheme _textTheme(TextTheme base, Color textColor, Color bodyColor) {
    return GoogleFonts.interTextTheme(base).copyWith(
      displayLarge: GoogleFonts.inter(fontWeight: FontWeight.w700, color: textColor, letterSpacing: -0.5),
      displayMedium: GoogleFonts.inter(fontWeight: FontWeight.w700, color: textColor, letterSpacing: -0.5),
      displaySmall: GoogleFonts.inter(fontWeight: FontWeight.w700, color: textColor, letterSpacing: -0.3),
      headlineLarge: GoogleFonts.inter(fontWeight: FontWeight.w700, color: textColor, letterSpacing: -0.3),
      headlineMedium: GoogleFonts.inter(fontWeight: FontWeight.w600, color: textColor, letterSpacing: -0.2),
      headlineSmall: GoogleFonts.inter(fontWeight: FontWeight.w600, color: textColor, letterSpacing: -0.2),
      titleLarge: GoogleFonts.inter(fontWeight: FontWeight.w600, color: textColor),
      titleMedium: GoogleFonts.inter(fontWeight: FontWeight.w600, color: textColor),
      titleSmall: GoogleFonts.inter(fontWeight: FontWeight.w500, color: textColor),
      bodyLarge: GoogleFonts.inter(fontWeight: FontWeight.w400, color: bodyColor),
      bodyMedium: GoogleFonts.inter(fontWeight: FontWeight.w400, color: bodyColor),
      bodySmall: GoogleFonts.inter(fontWeight: FontWeight.w400, color: bodyColor),
      labelLarge: GoogleFonts.inter(fontWeight: FontWeight.w500, color: textColor),
      labelMedium: GoogleFonts.inter(fontWeight: FontWeight.w500, color: textColor),
      labelSmall: GoogleFonts.inter(fontWeight: FontWeight.w500, color: bodyColor),
    );
  }

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimaryLight,
      secondary: AppColors.primaryHover,
      error: AppColors.error,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.bgSubtleLight,
      outline: AppColors.borderLight,
      outlineVariant: AppColors.borderStrongLight,
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    textTheme: _textTheme(ThemeData.light().textTheme, AppColors.textPrimary, AppColors.textSecondary),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.backgroundLight,
      foregroundColor: AppColors.textPrimary,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardRadius),
        side: const BorderSide(color: AppColors.borderLight),
      ),
      color: AppColors.surfaceLight,
      surfaceTintColor: Colors.transparent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_controlRadius),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimaryLight,
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_controlRadius),
        ),
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        foregroundColor: AppColors.primary,
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.primary),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.bgSubtleLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_controlRadius),
        borderSide: const BorderSide(color: AppColors.borderStrongLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_controlRadius),
        borderSide: const BorderSide(color: AppColors.borderStrongLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_controlRadius),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_controlRadius),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      labelStyle: GoogleFonts.inter(color: AppColors.textSecondary),
      hintStyle: GoogleFonts.inter(color: AppColors.textHint),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimaryLight,
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surfaceLight,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.primary.withValues(alpha: 0.08),
      labelStyle: GoogleFonts.inter(color: AppColors.primary),
      side: BorderSide(color: AppColors.primary.withValues(alpha: 0.2)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_chipRadius),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.borderLight,
      thickness: 1,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      primary: AppColors.primaryBright,
      onPrimary: AppColors.onPrimaryDark,
      secondary: AppColors.primaryBrightHover,
      error: AppColors.errorDark,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.textPrimaryDark,
      surfaceContainerHighest: AppColors.bgSubtleDark,
      outline: AppColors.borderDark,
      outlineVariant: AppColors.borderStrongDark,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    textTheme: _textTheme(ThemeData.dark().textTheme, AppColors.textPrimaryDark, AppColors.textSecondaryDark),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.backgroundDark,
      foregroundColor: AppColors.textPrimaryDark,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDark,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardRadius),
        side: const BorderSide(color: AppColors.borderDark),
      ),
      color: AppColors.surfaceDark,
      surfaceTintColor: Colors.transparent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_controlRadius),
        ),
        backgroundColor: AppColors.primaryBright,
        foregroundColor: AppColors.onPrimaryDark,
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_controlRadius),
        ),
        side: const BorderSide(color: AppColors.primaryBright, width: 1.5),
        foregroundColor: AppColors.primaryBright,
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.primaryBright),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.bgSubtleDark,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_controlRadius),
        borderSide: const BorderSide(color: AppColors.borderStrongDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_controlRadius),
        borderSide: const BorderSide(color: AppColors.borderStrongDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_controlRadius),
        borderSide: const BorderSide(color: AppColors.primaryBright, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_controlRadius),
        borderSide: const BorderSide(color: AppColors.errorDark),
      ),
      labelStyle: GoogleFonts.inter(color: AppColors.textSecondaryDark),
      hintStyle: GoogleFonts.inter(color: AppColors.textHintDark),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryBright,
      foregroundColor: AppColors.onPrimaryDark,
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surfaceDark,
      selectedItemColor: AppColors.primaryBright,
      unselectedItemColor: AppColors.textSecondaryDark,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.primaryBright.withValues(alpha: 0.15),
      labelStyle: GoogleFonts.inter(color: AppColors.primaryBright),
      side: BorderSide(color: AppColors.primaryBright.withValues(alpha: 0.3)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_chipRadius),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.borderDark,
      thickness: 1,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
