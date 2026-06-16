import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Ambient decorations used behind full-screen flows (onboarding, auth):
/// warm gradient blobs in opposite corners, faded paw prints, and
/// sparkle accents.
class AmbientDecorations extends StatelessWidget {
  const AmbientDecorations({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── corner gradient blobs ───────────────────────────────────────
          const Positioned(
            top: -120,
            left: -120,
            child: _GradientBlob(size: 320, color: AppColors.primarySoft),
          ),
          const Positioned(
            bottom: -100,
            right: -100,
            child: _GradientBlob(size: 280, color: AppColors.primarySoft),
          ),

          // ── faded paw prints ────────────────────────────────────────────
          const Positioned(
            top: 96,
            left: 28,
            child: _FadedPaw(size: 52, angle: -0.5),
          ),
          const Positioned(
            top: 420,
            right: 24,
            child: _FadedPaw(size: 60, angle: 0.4),
          ),

          // ── sparkles ────────────────────────────────────────────────────
          Positioned(
            top: 150,
            right: 56,
            child: Icon(
              FluentIcons.sparkle_24_filled,
              size: 22,
              color: AppColors.primary.withValues(alpha: 0.85),
            ),
          ),
          Positioned(
            top: 460,
            left: 40,
            child: Icon(
              FluentIcons.sparkle_20_filled,
              size: 16,
              color: AppColors.primary.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientBlob extends StatelessWidget {
  const _GradientBlob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0)],
        ),
      ),
    );
  }
}

class _FadedPaw extends StatelessWidget {
  const _FadedPaw({required this.size, required this.angle});

  final double size;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Icon(
        FluentIcons.animal_paw_print_24_filled,
        size: size,
        color: AppColors.primary.withValues(alpha: 0.12),
      ),
    );
  }
}
