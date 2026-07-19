import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Lightweight line chart of weight values over time, drawn with [CustomPaint]
/// so the app pulls in no chart dependency. Renders a smooth stroke, a soft
/// gradient fill beneath it, and a dot on the most recent point.
class WeightSparkline extends StatelessWidget {
  const WeightSparkline({
    required this.values,
    this.color = AppColors.secondary,
    this.height = 64,
    super.key,
  });

  /// Weight values in chronological order (oldest first). Needs 2+ points to
  /// draw a line; a single point renders as a flat mid-line with an end dot.
  final List<double> values;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _SparklinePainter(values: values, color: color),
        // Semantics: the numeric latest value is shown next to this widget, so
        // the chart itself is decorative for screen readers.
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({required this.values, required this.color});

  final List<double> values;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    const pad = 4.0;
    final w = size.width - pad * 2;
    final h = size.height - pad * 2;

    final minV = values.reduce((a, b) => a < b ? a : b);
    final maxV = values.reduce((a, b) => a > b ? a : b);
    final range = (maxV - minV).abs() < 0.0001 ? 1.0 : maxV - minV;

    double dx(int i) =>
        values.length == 1 ? pad + w / 2 : pad + (w * i) / (values.length - 1);
    // Invert Y so larger weights sit higher on the canvas.
    double dy(double v) => pad + h - ((v - minV) / range) * h;

    final points = [
      for (var i = 0; i < values.length; i++) Offset(dx(i), dy(values[i])),
    ];

    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      linePath.lineTo(points[i].dx, points[i].dy);
    }

    // Gradient fill under the line.
    final fillPath = Path.from(linePath)
      ..lineTo(points.last.dx, size.height)
      ..lineTo(points.first.dx, size.height)
      ..close();
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withValues(alpha: 0.22), color.withValues(alpha: 0)],
      ).createShader(Offset.zero & size);
    canvas.drawPath(fillPath, fillPaint);

    // The stroked line.
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(linePath, strokePaint);

    // Dot on the latest point.
    canvas.drawCircle(points.last, 4, Paint()..color = color);
    canvas.drawCircle(
      points.last,
      4,
      Paint()
        ..color = AppColors.surface
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(_SparklinePainter old) =>
      old.values != values || old.color != color;
}
