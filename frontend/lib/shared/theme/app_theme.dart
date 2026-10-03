import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // ── Brand colours ─────────────────────────────────────────────
  static const Color primaryGreen = Color(0xFF00C853);
  static const Color darkGreen = Color(0xFF00962E);
  static const Color lightGreen = Color(0xFFE8F5E9);
  static const Color accentGreen = Color(0xFF69F0AE);

  // ── Neutral palette ───────────────────────────────────────────
  static const Color textDark = Color(0xFF111827);
  static const Color textMedium = Color(0xFF6B7280);
  static const Color bgSurface = Color(0xFFF3F4F6);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE5E7EB);

  // ── Semantic colours ──────────────────────────────────────────
  static const Color errorRed = Color(0xFFEF4444);
  static const Color warningOrange = Color(0xFFF59E0B);
  static const Color infoBlue = Color(0xFF3B82F6);

  // ── Spacing constants ─────────────────────────────────────────
  static const double spacingXS = 4;
  static const double spacingSM = 8;
  static const double spacingMD = 16;
  static const double spacingLG = 24;
  static const double spacingXL = 32;

  static const double radiusSM = 8;
  static const double radiusMD = 12;
  static const double radiusLG = 16;
  static const double radiusXL = 24;

  // ── Light theme ───────────────────────────────────────────────
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        primary: primaryGreen,
        secondary: darkGreen,
      ),
      scaffoldBackgroundColor: bgSurface,

      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: bgSurface,
        foregroundColor: textDark,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textDark,
          letterSpacing: -0.3,
        ),
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        color: cardWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLG),
        ),
        margin: EdgeInsets.zero,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMD),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryGreen,
          minimumSize: const Size(double.infinity, 52),
          side: const BorderSide(color: primaryGreen, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMD),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryGreen,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardWhite,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spacingMD,
          vertical: spacingMD,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMD),
          borderSide: const BorderSide(color: divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMD),
          borderSide: const BorderSide(color: divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMD),
          borderSide: const BorderSide(color: primaryGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMD),
          borderSide: const BorderSide(color: errorRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMD),
          borderSide: const BorderSide(color: errorRed, width: 2),
        ),
        hintStyle: const TextStyle(color: textMedium, fontSize: 15),
        labelStyle: const TextStyle(color: textMedium),
        floatingLabelStyle: const TextStyle(color: primaryGreen),
      ),

      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textDark,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: textDark,
          letterSpacing: -0.3,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: textMedium, height: 1.5),
        bodyMedium: TextStyle(fontSize: 14, color: textMedium, height: 1.4),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: textMedium,
          letterSpacing: 0.2,
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cardWhite,
        indicatorColor: lightGreen,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textMedium,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryGreen, size: 22);
          }
          return const IconThemeData(color: textMedium, size: 22);
        }),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: bgSurface,
        selectedColor: lightGreen,
        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSM),
          side: const BorderSide(color: divider),
        ),
        padding: const EdgeInsets.symmetric(horizontal: spacingMD, vertical: spacingSM),
      ),
    );
  }
}
