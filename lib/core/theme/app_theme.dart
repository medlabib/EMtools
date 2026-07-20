import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary accent - single clinical teal
  static const Color primary = Color(0xFF0D9488);
  static const Color primaryHover = Color(0xFF14B8A6);
  static const Color primaryDark = Color(0xFF0F766E);

  // Legacy accent names — collapsed to the single teal accent so no screen
  // renders blue/indigo/purple chrome. Retained only as aliases to avoid churn.
  static const Color primaryBlue = primary;
  static const Color primaryIndigo = primaryDark;
  static const Color primaryPurple = primary;
  static const Color accentTeal = primaryHover;
  static const Color accentCyan = primaryHover;
  static const Color accentEmerald = primaryHover;
  static const Color accentPurple = primary;

  // Status colors - reserved for clinical severity / results only
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Background colors
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color backgroundDark = Color(0xFF0F172A);

  // Surface colors
  static const Color surfaceLight = Color(0xFFF8FAFC);
  static const Color surfaceDark = Color(0xFF0F172A);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E293B);

  // Border / hairline colors
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF334155);

  // Text colors - Light theme
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textHint = Color(0xFF94A3B8);

  // Text colors - Dark theme
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFCBD5E1);
  static const Color textHintDark = Color(0xFF94A3B8);

  // Adaptive helpers
  static Color getTextPrimary(bool isDark) => isDark ? textPrimaryDark : textPrimary;
  static Color getTextSecondary(bool isDark) => isDark ? textSecondaryDark : textSecondary;
  static Color getTextHint(bool isDark) => isDark ? textHintDark : textHint;
  static Color getCardColor(bool isDark) => isDark ? cardDark : cardLight;
  static Color getBackgroundColor(bool isDark) => isDark ? backgroundDark : backgroundLight;
  static Color getBorderColor(bool isDark) => isDark ? borderDark : borderLight;
}

class AppTheme {
  static const double _cardRadius = 12;
  static const double _controlRadius = 10;
  static const double _chipRadius = 8;

  static TextTheme _textTheme(TextTheme base, Color textColor, Color bodyColor) {
    return GoogleFonts.interTextTheme(base).copyWith(
      displayLarge: GoogleFonts.inter(fontWeight: FontWeight.w700, color: textColor),
      displayMedium: GoogleFonts.inter(fontWeight: FontWeight.w700, color: textColor),
      displaySmall: GoogleFonts.inter(fontWeight: FontWeight.w600, color: textColor),
      headlineLarge: GoogleFonts.inter(fontWeight: FontWeight.w600, color: textColor),
      headlineMedium: GoogleFonts.inter(fontWeight: FontWeight.w600, color: textColor),
      headlineSmall: GoogleFonts.inter(fontWeight: FontWeight.w600, color: textColor),
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
      secondary: AppColors.primaryHover,
      error: AppColors.error,
      surface: AppColors.cardLight,
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
      color: AppColors.cardLight,
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
        foregroundColor: Colors.white,
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
      fillColor: AppColors.cardLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_controlRadius),
        borderSide: const BorderSide(color: AppColors.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_controlRadius),
        borderSide: const BorderSide(color: AppColors.borderLight),
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
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.cardLight,
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
      primary: AppColors.primaryHover,
      secondary: AppColors.primary,
      error: AppColors.error,
      surface: AppColors.cardDark,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    textTheme: _textTheme(ThemeData.dark().textTheme, Colors.white, AppColors.textSecondaryDark),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.backgroundDark,
      foregroundColor: Colors.white,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardRadius),
        side: const BorderSide(color: AppColors.borderDark),
      ),
      color: AppColors.cardDark,
      surfaceTintColor: Colors.transparent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_controlRadius),
        ),
        backgroundColor: AppColors.primaryHover,
        foregroundColor: const Color(0xFF042F2E),
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_controlRadius),
        ),
        side: const BorderSide(color: AppColors.primaryHover, width: 1.5),
        foregroundColor: AppColors.primaryHover,
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.primaryHover),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardDark,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_controlRadius),
        borderSide: const BorderSide(color: AppColors.borderDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_controlRadius),
        borderSide: const BorderSide(color: AppColors.borderDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_controlRadius),
        borderSide: const BorderSide(color: AppColors.primaryHover, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_controlRadius),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      labelStyle: GoogleFonts.inter(color: AppColors.textSecondaryDark),
      hintStyle: GoogleFonts.inter(color: AppColors.textHintDark),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryHover,
      foregroundColor: Color(0xFF042F2E),
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.cardDark,
      selectedItemColor: AppColors.primaryHover,
      unselectedItemColor: AppColors.textSecondaryDark,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.primaryHover.withValues(alpha: 0.15),
      labelStyle: GoogleFonts.inter(color: AppColors.primaryHover),
      side: BorderSide(color: AppColors.primaryHover.withValues(alpha: 0.3)),
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
