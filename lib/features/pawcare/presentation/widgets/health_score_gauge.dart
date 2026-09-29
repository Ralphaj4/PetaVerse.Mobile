import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Circular 0–100 gauge: a track ring with a colored arc filled to
/// `value / 100`, the number centered inside. No chart dependency — a plain
/// [CustomPaint], matching the `WeightSparkline` approach. Starts at the top
/// (12 o'clock) and sweeps clockwise, like the visualizer prototype.
class HealthScoreGauge extends StatelessWidget {
  const HealthScoreGauge({
    required this.value,
    required this.color,
    this.size = 148,
    this.strokeWidth = 14,
    this.caption,
    super.key,
  });

  /// The score, 0–100.
  final int value;

  /// Arc + number color (the band color).
  final Color color;

  final double size;
  final double strokeWidth;

  /// Small text under the number, e.g. "out of 100".
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final clamped = value.clamp(0, 100);
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _GaugePainter(
          progress: clamped / 100,
          color: color,
          strokeWidth: strokeWidth,
          trackColor: AppColors.divider.withValues(alpha: 0.5),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$clamped',
                style: AppTextStyles.displayLarge.copyWith(
                  color: color,
                  fontSize: size * 0.3,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),
              if (caption != null)
                Text(
                  caption!,
                  style: AppTextStyles.labelMedium
                      .copyWith(color: AppColors.textTertiary),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  const _GaugePainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
    required this.trackColor,
  });

  final double progress;
  final Color color;
  final double strokeWidth;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    const startAngle = -math.pi / 2; // 12 o'clock
    const fullSweep = 2 * math.pi;

    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = trackColor;
    canvas.drawCircle(center, radius, track);

    if (progress <= 0) return;

    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = color;
    canvas.drawArc(rect, startAngle, fullSweep * progress, false, arc);
  }

  @override
  bool shouldRepaint(_GaugePainter old) =>
      old.progress != progress ||
      old.color != color ||
      old.strokeWidth != strokeWidth ||
      old.trackColor != trackColor;
}
