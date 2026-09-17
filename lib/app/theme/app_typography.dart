import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Noble Forest - Premium Quranic UI Typography System
abstract final class AppTypography {
  /// IBM Plex Sans for Latin interface elements
  static TextStyle get displayLarge => GoogleFonts.ibmPlexSans(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
      );

  static TextStyle get displayMedium => GoogleFonts.ibmPlexSans(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.15,
      );

  static TextStyle get displaySmall => GoogleFonts.ibmPlexSans(
        fontSize: 36,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get headlineLarge => GoogleFonts.ibmPlexSans(
        fontSize: 32,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get headlineMedium => GoogleFonts.ibmPlexSans(
        fontSize: 28,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get headlineSmall => GoogleFonts.ibmPlexSans(
        fontSize: 24,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get titleLarge => GoogleFonts.ibmPlexSans(
        fontSize: 22,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get titleMedium => GoogleFonts.ibmPlexSans(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get titleSmall => GoogleFonts.ibmPlexSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get bodyLarge => GoogleFonts.ibmPlexSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get bodyMedium => GoogleFonts.ibmPlexSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get bodySmall => GoogleFonts.ibmPlexSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get labelLarge => GoogleFonts.ibmPlexSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      );

  static TextStyle get labelMedium => GoogleFonts.ibmPlexSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      );

  static TextStyle get labelSmall => GoogleFonts.ibmPlexSans(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      );

  /// IBM Plex Sans Arabic for Arabic UI elements
  static TextStyle get arabicLarge => GoogleFonts.ibmPlexSansArabic(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        height: 2.0,
      );

  static TextStyle get arabicMedium => GoogleFonts.ibmPlexSansArabic(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 2.0,
      );

  static TextStyle get arabicSmall => GoogleFonts.ibmPlexSansArabic(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 2.0,
      );

  /// Separate Quran text typography - to be replaced with actual Quran font later
  static TextStyle get quranLarge => GoogleFonts.ibmPlexSansArabic(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        height: 2.2,
      );

  static TextStyle get quranMedium => GoogleFonts.ibmPlexSansArabic(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        height: 2.2,
      );

  static TextStyle get quranSmall => GoogleFonts.ibmPlexSansArabic(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 2.2,
      );
}