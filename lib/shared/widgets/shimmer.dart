import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';

/// A shimmering placeholder region. Wrap a subtree of [SkeletonBox]es in a
/// single [Shimmer] so they share one animated sweep (cheaper + coherent).
///
/// Respects the platform "reduce motion" setting: when animations are
/// disabled it renders a static tint instead of sweeping.
class Shimmer extends StatefulWidget {
  const Shimmer({required this.child, super.key});

  final Widget child;

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  );

  @override
  void initState() {
    super.initState();
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Accessibility: honor reduced-motion — no sweep, just the base tint.
    if (MediaQuery.of(context).disableAnimations) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            // A bright band that sweeps left→right across the masked area.
            final dx = bounds.width * (2 * _controller.value - 1);
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [
                _shimmerBase,
                _shimmerHighlight,
                _shimmerBase,
              ],
              stops: const [0.35, 0.5, 0.65],
              transform: _SlideGradient(dx),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

const Color _shimmerBase = Color(0xFFE9ECEF);
const Color _shimmerHighlight = Color(0xFFF6F7F9);

/// Translates a gradient horizontally by [dx] logical pixels.
class _SlideGradient extends GradientTransform {
  const _SlideGradient(this.dx);
  final double dx;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) =>
      Matrix4.translationValues(dx, 0, 0);
}

/// A single grey placeholder block. Must be a descendant of a [Shimmer] to
/// animate; on its own it renders as a static grey box.
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    this.width,
    this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    super.key,
  });

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: _shimmerBase,
        shape: shape,
        borderRadius: shape == BoxShape.circle
            ? null
            : (borderRadius ?? AppRadius.smAll),
      ),
    );
  }
}

/// A skeleton line of text at [width], sized to a text style's line height.
class SkeletonLine extends StatelessWidget {
  const SkeletonLine({
    required this.width,
    this.height = 12,
    super.key,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SkeletonBox(
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(6),
    );
  }
}

/// A surface card wrapper matching the app's card language (white, rounded,
/// soft shadow) — used to frame grouped skeleton rows.
class SkeletonCard extends StatelessWidget {
  const SkeletonCard({required this.child, this.padding, super.key});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}
