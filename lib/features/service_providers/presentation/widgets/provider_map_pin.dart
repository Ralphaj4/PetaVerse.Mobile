import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/provider_category.dart';

/// Paints a service-provider map pin into a bitmap for Google Maps: a white
/// teardrop body with a soft drop shadow, carrying a category-colored round tile
/// with the primary category glyph.
///
/// When [categories] has more than one entry (up to 4 are shown; the rest are
/// ignored) the tile is split into equal pie wedges — one per category color —
/// with a thin white divider between them. The primary-category icon is always
/// centered over the full tile so it reads clearly regardless of how many wedges
/// are present.
///
/// When [selected] the whole pin is drawn larger with a colored glow.
/// The tip anchors at the coordinate (the marker uses anchor (0.5, 1.0)).
///
/// Rendered via `MarkerBitmap.fromPainter`.
class ProviderPinPainter extends CustomPainter {
  ProviderPinPainter({required this.categories, required this.selected})
      : assert(categories.isNotEmpty);

  final List<ProviderCategory> categories;
  final bool selected;

  static const int _maxSlices = 4;

  ProviderCategory get _primary => categories.first;

  /// The categories actually rendered — primary first, capped at [_maxSlices].
  List<ProviderCategory> get _slices => categories.length <= _maxSlices
      ? categories
      : categories.sublist(0, _maxSlices);

  @override
  void paint(Canvas canvas, Size size) {
    final primaryColor = _primary.color;
    final w = size.width;
    final h = size.height;
    final headRadius = w / 2 - 4;
    final headCenter = Offset(w / 2, headRadius + 4);
    final tip = Offset(w / 2, h);

    const flankAngle = 0.62;
    final dx = headRadius * math.cos(flankAngle);
    final dy = headRadius * math.sin(flankAngle);
    final leftFlank = Offset(headCenter.dx - dx, headCenter.dy + dy);
    final rightFlank = Offset(headCenter.dx + dx, headCenter.dy + dy);

    final path = Path()
      ..moveTo(leftFlank.dx, leftFlank.dy)
      ..arcToPoint(
        rightFlank,
        radius: Radius.circular(headRadius),
        clockwise: true,
        largeArc: true,
      )
      ..quadraticBezierTo(headCenter.dx + dx * 0.5, h * 0.88, tip.dx, tip.dy)
      ..quadraticBezierTo(
        headCenter.dx - dx * 0.5,
        h * 0.88,
        leftFlank.dx,
        leftFlank.dy,
      )
      ..close();

    // Selection glow behind the head.
    if (selected) {
      canvas.drawCircle(
        headCenter,
        headRadius + 5,
        Paint()
          ..color = primaryColor.withValues(alpha: 0.55)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7),
      );
    }

    // Soft drop shadow under the whole body.
    canvas.drawPath(
      path.shift(const Offset(0, 1.5)),
      Paint()
        ..color = AppColors.textPrimary.withValues(alpha: 0.18)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );

    // White body.
    canvas.drawPath(path, Paint()..color = AppColors.surface);

    // Tile: solid for single category, pie-split for multi.
    final tileRadius = headRadius * 0.62;
    final slices = _slices;
    if (slices.length == 1) {
      canvas.drawCircle(headCenter, tileRadius, Paint()..color = primaryColor);
    } else {
      _drawPieTile(canvas, headCenter, tileRadius, slices);
    }

    // Primary category glyph, always centered over the full tile.
    final icon = _primary.filledIcon;
    final tp = TextPainter(textDirection: TextDirection.ltr)
      ..text = TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: tileRadius * 1.05,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: AppColors.onPrimary,
        ),
      )
      ..layout();
    tp.paint(canvas, headCenter - Offset(tp.width / 2, tp.height / 2));
  }

  /// Draws the tile as equal pie wedges clipped to the tile circle, with thin
  /// white divider lines between them. Starts at the top (12 o'clock) so the
  /// primary wedge is always at the top-left for 2+ slices.
  void _drawPieTile(
    Canvas canvas,
    Offset center,
    double radius,
    List<ProviderCategory> slices,
  ) {
    final n = slices.length;
    final sweepAngle = (math.pi * 2) / n;
    // Start at top (−π/2) so wedges are symmetrically placed.
    const startAngle = -math.pi / 2;

    final tilePaint = Paint()..style = PaintingStyle.fill;
    final tileRect = Rect.fromCircle(center: center, radius: radius);

    // Clip all drawing to the tile circle.
    canvas.save();
    canvas.clipPath(Path()..addOval(tileRect));

    for (var i = 0; i < n; i++) {
      tilePaint.color = slices[i].color;
      final wedge = Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(
          tileRect,
          startAngle + i * sweepAngle,
          sweepAngle,
          false,
        )
        ..close();
      canvas.drawPath(wedge, tilePaint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(ProviderPinPainter old) =>
      old.selected != selected ||
      old.categories.length != categories.length ||
      !_listsEqual(old.categories, categories);

  static bool _listsEqual(List<ProviderCategory> a, List<ProviderCategory> b) {
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
