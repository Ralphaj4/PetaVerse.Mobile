import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Paints a solid colored circle pin with a white ring and an optional glyph -
/// the [BitmapDescriptor] equivalent of the old inline `_MapPin` widget used by
/// the shared [MapView]. Rendered to an image by [MarkerBitmap].
class CircledPinPainter extends CustomPainter {
  CircledPinPainter({required this.color, this.icon});

  final Color color;
  final IconData? icon;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    // Soft drop shadow.
    canvas.drawCircle(
      center.translate(0, 1.5),
      radius,
      Paint()
        ..color = color.withValues(alpha: 0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );
    // Colored body.
    canvas.drawCircle(center, radius, Paint()..color = color);
    // White ring.
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    final icon = this.icon;
    if (icon != null) {
      final tp = TextPainter(textDirection: TextDirection.ltr)
        ..text = TextSpan(
          text: String.fromCharCode(icon.codePoint),
          style: TextStyle(
            fontSize: 16,
            fontFamily: icon.fontFamily,
            package: icon.fontPackage,
            color: Colors.white,
          ),
        )
        ..layout();
      tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(CircledPinPainter old) =>
      old.color != color || old.icon != icon;
}

/// Paints the current-location blue dot (static; the native map can't host the
/// pulsing animation, so this is the resting frame).
class MyLocationDotPainter extends CustomPainter {
  const MyLocationDotPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    // Translucent halo.
    canvas.drawCircle(
      center,
      size.width / 2,
      Paint()..color = AppColors.secondary.withValues(alpha: 0.2),
    );
    // White ring + solid core.
    canvas.drawCircle(
      center,
      7,
      Paint()..color = Colors.white,
    );
    canvas.drawCircle(
      center,
      5.5,
      Paint()..color = AppColors.secondary,
    );
  }

  @override
  bool shouldRepaint(MyLocationDotPainter old) => false;
}

/// Paints a round count bubble shown in place of clustered pins.
class ClusterBubblePainter extends CustomPainter {
  ClusterBubblePainter({required this.count});

  final int count;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 3;

    canvas.drawCircle(
      center,
      radius + 2,
      Paint()
        ..color = AppColors.primary.withValues(alpha: 0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );
    canvas.drawCircle(center, radius, Paint()..color = AppColors.primary);
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    final tp = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: '$count',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    )..layout();
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(ClusterBubblePainter old) => old.count != count;
}
