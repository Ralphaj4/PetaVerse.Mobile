import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/pet_health_score.dart';

/// Presentation-side color mapping for the health score bands and reason
/// severities. Kept out of the domain layer (no Flutter there); the exact
/// values come from `docs/Pet-Health-Score-Mobile-Guide.md §3.1 / §6.1`.
abstract final class HealthScoreStyle {
  static const Color _excellent = Color(0xFF2FB87A);
  static const Color _good = AppColors.secondary; // teal, rgb(1,180,194)
  static const Color _fair = Color(0xFFE8A33D);
  static const Color _needsAttention = Color(0xFFE5544B);
  static const Color _noData = Color(0xFF9AA4B1);

  /// The band's accent color — used for the gauge arc, number, and chip.
  static Color bandColor(HealthBand band) => switch (band) {
        HealthBand.excellent => _excellent,
        HealthBand.good => _good,
        HealthBand.fair => _fair,
        HealthBand.needsAttention => _needsAttention,
        HealthBand.noData => _noData,
      };

  /// A reason row's color — good/warn/bad.
  static Color severityColor(HealthReasonSeverity severity) =>
      switch (severity) {
        HealthReasonSeverity.good => _excellent,
        HealthReasonSeverity.warn => _fair,
        HealthReasonSeverity.bad => _needsAttention,
      };
}
