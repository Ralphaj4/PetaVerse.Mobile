import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/provider_category.dart';

/// Paints a service-provider map pin into a bitmap for Google Maps: a white
/// teardrop body with a soft drop shadow, carrying a category-colored round tile
/// with the category glyph. When [selected] the whole pin is drawn larger with a
/// colored glow, so the tapped pin reads as active. The tip anchors at the
/// coordinate (the marker uses anchor (0.5, 1.0)).
///
/// Rendered via `MarkerBitmap.fromPainter`. Because it's a static image, the old
/// `AnimatedScale` grow-on-select becomes a swap between a normal and a
/// pre-rendered larger bitmap.
class ProviderPinPainter extends CustomPainter {
  ProviderPinPainter({required this.category, required this.selected});

  final ProviderCategory category;
  final bool selected;

  @override
  void paint(Canvas canvas, Size size) {
    final color = category.color;
    final w = size.width;
    final h = size.height;
    final headRadius = w / 2 - 4;
    final headCenter = Offset(w / 2, headRadius + 4);
    final tip = Offset(w / 2, h);

    // One continuous teardrop: a near-full circular head whose sides sweep down
    // and meet at the tip (matches the previous widget silhouette).
    const flankAngle = 0.62; // radians below horizontal where the tail leaves.
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
          ..color = color.withValues(alpha: 0.55)
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

    // Colored round tile inside the head.
    final tileRadius = headRadius * 0.62;
    canvas.drawCircle(headCenter, tileRadius, Paint()..color = color);

    // Category glyph, centered on the tile.
    final icon = category.filledIcon;
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

  @override
  bool shouldRepaint(ProviderPinPainter old) =>
      old.category != category || old.selected != selected;
}
