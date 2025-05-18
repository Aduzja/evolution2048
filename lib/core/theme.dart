import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // App colors
  static const Color primaryColor = Color(0xFF20E3B2);
  static const Color accentColor = Color(0xFF8B5CF6);
  static const Color backgroundColor = Color(0xFF101935);
  static const Color darkBackground = Color(0xFF050715);

  // Get the app theme
  static ThemeData get theme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: primaryColor,
        secondary: accentColor,
        surface: backgroundColor,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.exo2(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.black,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: GoogleFonts.exo2(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  // Custom text styles
  static TextStyle get titleStyle => GoogleFonts.exo2(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white);

  static TextStyle get subtitleStyle => GoogleFonts.poppins(fontSize: 16, color: Colors.white70);

  static TextStyle get buttonTextStyle =>
      GoogleFonts.exo2(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: 1.2);
}
