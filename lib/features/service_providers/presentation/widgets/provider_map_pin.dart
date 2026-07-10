import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/provider_category.dart';

/// A white marker "cushion" with a downward point, carrying a category-colored
/// rounded-square icon tile. Matches the PawCare map design: white body, a soft
/// drop shadow, and a colored glyph tile inside. Grows and lifts when
/// [selected] so the tapped pin reads as the active one. The tip anchors at the
/// coordinate (the parent sets [Alignment.topCenter] on the marker).
class ProviderMapPin extends StatelessWidget {
  const ProviderMapPin({
    required this.category,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final ProviderCategory category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = category.color;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: selected ? 1.18 : 1,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutBack,
        alignment: Alignment.bottomCenter,
        child: CustomPaint(
          // White marker body + point + drop shadow, painted behind the tile.
          painter: _PinBodyPainter(
            glow: selected ? color.withValues(alpha: 0.55) : null,
          ),
          child: SizedBox(
            width: 44,
            height: 54,
            child: Align(
              // Center the tile within the round head (above the point).
              alignment: const Alignment(0, -0.3),
              child: Container(
                width: 40,
                height: 35,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.45),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Icon(
                  category.filledIcon,
                  size: 17,
                  color: AppColors.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Paints the white marker body (rounded head + tapering point) with a soft
/// drop shadow, and an optional colored glow ring when selected.
class _PinBodyPainter extends CustomPainter {
  _PinBodyPainter({this.glow});

  final Color? glow;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final headRadius = w / 2;
    final headCenter = Offset(w / 2, headRadius);
    final tip = Offset(w / 2, h);

    // One continuous teardrop: a near-full circular head whose sides sweep down
    // and meet at the tip. Built as a single path (no separate spike) so the
    // silhouette is a clean map pin, not a circle with a stray arm.
    //
    // The two flank tangent points sit slightly below the head center; the
    // sweep from those points down to the tip uses quadratics whose control
    // points hug the head, giving a smooth taper.
    const flankAngle = 0.62; // radians below horizontal where the tail leaves.
    final dx = headRadius * math.cos(flankAngle);
    final dy = headRadius * math.sin(flankAngle);
    final leftFlank = Offset(headCenter.dx - dx, headCenter.dy + dy);
    final rightFlank = Offset(headCenter.dx + dx, headCenter.dy + dy);

    final path = Path()
      ..moveTo(leftFlank.dx, leftFlank.dy)
      // Up and over the top of the head, back down to the right flank.
      ..arcToPoint(
        rightFlank,
        radius: Radius.circular(headRadius),
        clockwise: true,
        largeArc: true,
      )
      // Right side tapering to the tip.
      ..quadraticBezierTo(
        headCenter.dx + dx * 0.5,
        h * 0.86,
        tip.dx,
        tip.dy,
      )
      // Left side back up from the tip to the left flank.
      ..quadraticBezierTo(
        headCenter.dx - dx * 0.5,
        h * 0.86,
        leftFlank.dx,
        leftFlank.dy,
      )
      ..close();

    // Selection glow behind the head.
    if (glow != null) {
      canvas.drawCircle(
        headCenter,
        headRadius + 5,
        Paint()
          ..color = glow!
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7),
      );
    }

    // Contact shadow at the tip.
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w / 2, h + 1), width: w * 0.36, height: 5),
      Paint()
        ..color = AppColors.textPrimary.withValues(alpha: 0.20)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );

    // Soft drop shadow under the whole body.
    canvas.drawPath(
      path.shift(const Offset(0, 1.5)),
      Paint()
        ..color = AppColors.textPrimary.withValues(alpha: 0.16)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );

    // White body.
    canvas.drawPath(path, Paint()..color = AppColors.surface);
  }

  @override
  bool shouldRepaint(_PinBodyPainter old) => old.glow != glow;
}

/// Count bubble shown in place of overlapping pins.
class ClusterBubble extends StatelessWidget {
  const ClusterBubble({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryLight, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.surface, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.45),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Text(
        '$count',
        style: const TextStyle(
          color: AppColors.onPrimary,
          fontWeight: FontWeight.w800,
          fontSize: 14,
        ),
      ),
    );
  }
}

/// Pulsing blue dot marking the user's current location.
class MyLocationDot extends StatefulWidget {
  const MyLocationDot({super.key});

  @override
  State<MyLocationDot> createState() => _MyLocationDotState();
}

class _MyLocationDotState extends State<MyLocationDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Honor reduced-motion: skip the pulse ring.
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    return Stack(
      alignment: Alignment.center,
      children: [
        if (!reduceMotion)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final t = _controller.value;
              return Container(
                width: 26 * (0.4 + t * 0.6),
                height: 26 * (0.4 + t * 0.6),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: (1 - t) * 0.4),
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.surface, width: 2.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondary.withValues(alpha: 0.5),
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
