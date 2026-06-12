import 'package:flutter/material.dart';

/// Color design tokens, extracted from the PetaVerse design language.
abstract final class AppColors {
  // Brand
  static const Color primary = Color(0xFFFBAB4C); // RGB(251,171,76)
  static const Color secondary = Color(0xFF01B4C2); // RGB(1,180,194)

  // Brand tints (soft pastel surfaces used by hero cards and chips)
  static const Color primarySoft = Color(0xFFFEEFDB);
  static const Color secondarySoft = Color(0xFFE0F7F9);

  // Darker shades for pressed states and emphasis
  static const Color primaryDark = Color(0xFFE08F2B);
  static const Color secondaryDark = Color(0xFF018E99);

  // Neutrals
  static const Color textPrimary = Color(0xFF1F2430);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color background = Color(0xFFF7F8FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE5E7EB);

  // Semantic
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // On-color contrasts
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
}
