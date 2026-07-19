import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/weight_record.dart';

/// A descriptive weight line chart for the history page: labelled Y-axis
/// (weight) with light gridlines, X-axis date ticks, a smooth gradient-filled
/// line, and a dot on every reading. Drawn with [CustomPaint] so the app pulls
/// in no chart dependency.
///
/// [records] must be in chronological order (oldest first).
class WeightChart extends StatelessWidget {
  const WeightChart({
    required this.records,
    this.color = AppColors.secondary,
    this.height = 200,
    super.key,
  });

  final List<WeightRecord> records;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final numFmt = NumberFormat.decimalPattern(locale)
      ..maximumFractionDigits = 1;
    final dateFmt = DateFormat.MMMd(locale);

    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _WeightChartPainter(
          records: records,
          color: color,
          numFmt: numFmt,
          dateFmt: dateFmt,
          axisLabelStyle: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textTertiary,
            letterSpacing: 0,
          ),
          gridColor: AppColors.divider,
          surfaceColor: AppColors.surface,
        ),
      ),
    );
  }
}

class _WeightChartPainter extends CustomPainter {
  _WeightChartPainter({
    required this.records,
    required this.color,
    required this.numFmt,
    required this.dateFmt,
    required this.axisLabelStyle,
    required this.gridColor,
    required this.surfaceColor,
  });

  final List<WeightRecord> records;
  final Color color;
  final NumberFormat numFmt;
  final DateFormat dateFmt;
  final TextStyle axisLabelStyle;
  final Color gridColor;
  final Color surfaceColor;

  // Reserved gutters for the axis labels.
  static const double _leftGutter = 40;
  static const double _bottomGutter = 22;
  static const double _topPad = 12;
  static const double _rightPad = 8;
  static const int _yTicks = 4;

  @override
  void paint(Canvas canvas, Size size) {
    if (records.isEmpty) return;

    const plotLeft = _leftGutter;
    final plotRight = size.width - _rightPad;
    const plotTop = _topPad;
    final plotBottom = size.height - _bottomGutter;
    final plotW = plotRight - plotLeft;
    final plotH = plotBottom - plotTop;
    if (plotW <= 0 || plotH <= 0) return;

    final values = [for (final r in records) r.value];
    var minV = values.reduce((a, b) => a < b ? a : b);
    var maxV = values.reduce((a, b) => a > b ? a : b);
    // Pad the range by ~8% so points don't hug the top/bottom edges; guard the
    // flat-line case where min == max.
    if ((maxV - minV).abs() < 0.0001) {
      minV -= 1;
      maxV += 1;
    } else {
      final pad = (maxV - minV) * 0.12;
      minV -= pad;
      maxV += pad;
    }
    final range = maxV - minV;

    double xFor(int i) => records.length == 1
        ? plotLeft + plotW / 2
        : plotLeft + plotW * i / (records.length - 1);
    double yFor(double v) => plotTop + plotH - ((v - minV) / range) * plotH;

    // ── Y-axis gridlines + value labels ──────────────────────────────────
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;
    for (var t = 0; t <= _yTicks; t++) {
      final frac = t / _yTicks;
      final y = plotTop + plotH * (1 - frac);
      final v = minV + range * frac;
      canvas.drawLine(Offset(plotLeft, y), Offset(plotRight, y), gridPaint);
      _paintText(
        canvas,
        numFmt.format(v),
        Offset(plotLeft - 6, y),
        axisLabelStyle,
        alignRight: true,
        alignMiddleY: true,
      );
    }

    // ── Line + gradient fill ─────────────────────────────────────────────
    final points = [
      for (var i = 0; i < records.length; i++) Offset(xFor(i), yFor(values[i])),
    ];

    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      linePath.lineTo(points[i].dx, points[i].dy);
    }

    final fillPath = Path.from(linePath)
      ..lineTo(points.last.dx, plotBottom)
      ..lineTo(points.first.dx, plotBottom)
      ..close();
    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withValues(alpha: 0.22), color.withValues(alpha: 0)],
        ).createShader(
          Rect.fromLTWH(plotLeft, plotTop, plotW, plotH),
        ),
    );

    canvas.drawPath(
      linePath,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round,
    );

    // ── Point dots (white core + colored ring) ───────────────────────────
    for (final p in points) {
      canvas.drawCircle(p, 3.5, Paint()..color = color);
      canvas.drawCircle(
        p,
        3.5,
        Paint()
          ..color = surfaceColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }

    // ── X-axis date ticks: first, middle, last (dedup for small counts) ──
    final tickIdx = <int>{
      0,
      records.length ~/ 2,
      records.length - 1,
    }.toList()
      ..sort();
    for (final i in tickIdx) {
      final x = xFor(i);
      _paintText(
        canvas,
        dateFmt.format(records[i].recordedAt),
        Offset(x, plotBottom + 6),
        axisLabelStyle,
        alignCenterX: true,
        clampX: (plotLeft, plotRight),
      );
    }
  }

  void _paintText(
    Canvas canvas,
    String text,
    Offset anchor,
    TextStyle style, {
    bool alignRight = false,
    bool alignCenterX = false,
    bool alignMiddleY = false,
    (double, double)? clampX,
  }) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    var dx = anchor.dx;
    if (alignRight) {
      dx = anchor.dx - tp.width;
    } else if (alignCenterX) {
      dx = anchor.dx - tp.width / 2;
    }
    if (clampX != null) {
      dx = dx.clamp(clampX.$1, clampX.$2 - tp.width);
    }
    final dy = alignMiddleY ? anchor.dy - tp.height / 2 : anchor.dy;
    tp.paint(canvas, Offset(dx, dy));
  }

  @override
  bool shouldRepaint(_WeightChartPainter old) =>
      old.records != records || old.color != color;
}
