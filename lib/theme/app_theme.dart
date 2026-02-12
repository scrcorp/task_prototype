import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // Priority colors
  static const Color urgentColor = Color(0xFFFF6B6B);
  static const Color normalColor = Color(0xFFFFB84D);
  static const Color lowColor = Color(0xFF51CF66);

  static final ColorScheme _colorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF5B9BD5),
    primary: const Color(0xFF5B9BD5),
    onPrimary: Colors.white,
    primaryContainer: const Color(0xFFD6E8F7),
    secondary: const Color(0xFF7EC8C8),
    secondaryContainer: const Color(0xFFD4F0F0),
    surface: const Color(0xFFF8F9FA),
    brightness: Brightness.light,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _colorScheme,
      scaffoldBackgroundColor: Colors.white,
      textTheme: GoogleFonts.notoSansKrTextTheme().copyWith(
        headlineLarge: GoogleFonts.notoSansKr(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF2D3436),
        ),
        headlineMedium: GoogleFonts.notoSansKr(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF2D3436),
        ),
        headlineSmall: GoogleFonts.notoSansKr(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF2D3436),
        ),
        titleLarge: GoogleFonts.notoSansKr(
          fontWeight: FontWeight.w600,
          color: const Color(0xFF2D3436),
        ),
        titleMedium: GoogleFonts.notoSansKr(
          fontWeight: FontWeight.w600,
          color: const Color(0xFF2D3436),
        ),
        bodyLarge: GoogleFonts.notoSansKr(
          color: const Color(0xFF636E72),
        ),
        bodyMedium: GoogleFonts.notoSansKr(
          color: const Color(0xFF636E72),
        ),
        labelLarge: GoogleFonts.notoSansKr(
          fontWeight: FontWeight.w600,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF2D3436),
        elevation: 0,
        scrolledUnderElevation: 0.5,
        titleTextStyle: GoogleFonts.notoSansKr(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF2D3436),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5B9BD5),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.notoSansKr(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDFE6E9)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDFE6E9)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF5B9BD5), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF5B9BD5),
        unselectedItemColor: Color(0xFFB2BEC3),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFDFE6E9),
        thickness: 1,
      ),
    );
  }
}
