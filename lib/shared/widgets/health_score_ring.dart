import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Circular health score indicator (0–100) from the dashboard design.
class HealthScoreRing extends StatelessWidget {
  const HealthScoreRing({
    required this.score,
    this.size = 72,
    this.color = AppColors.primary,
    this.backgroundColor = AppColors.surface,
    super.key,
  });

  final int score;
  final double size;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final clamped = score.clamp(0, 100);
    return Semantics(
      value: '$clamped / 100',
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                value: clamped / 100,
                strokeWidth: size / 12,
                strokeCap: StrokeCap.round,
                color: color,
                backgroundColor: backgroundColor.withValues(alpha: 0.4),
              ),
            ),
            Text(
              '$clamped',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: size / 3,
                    color: color,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
