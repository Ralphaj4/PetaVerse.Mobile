import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/walk_session_provider.dart';


/// Expandable walk tracker card shown on the home page.
/// Idle → single "Start a walk" button.
/// Active → animated stats panel with stop button.
class WalkBanner extends ConsumerStatefulWidget {
  const WalkBanner({required this.petId, required this.petName, super.key});

  final int petId;
  final String petName;

  @override
  ConsumerState<WalkBanner> createState() => _WalkBannerState();
}

class _WalkBannerState extends ConsumerState<WalkBanner> {
  bool _starting = false;
  bool _stopping = false;

  Future<void> _start() async {
    setState(() => _starting = true);
    await ref
        .read(walkSessionProvider.notifier)
        .startWalk(widget.petId, widget.petName);
    if (mounted) setState(() => _starting = false);
  }

  Future<void> _stop() async {
    setState(() => _stopping = true);
    await ref.read(walkSessionProvider.notifier).stopWalk();
    if (mounted) setState(() => _stopping = false);
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(walkSessionProvider);
    final l10n = context.l10n;

    return AnimatedSize(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: session == null
          ? _IdleCard(
              petName: widget.petName,
              loading: _starting,
              onStart: _starting ? null : _start,
              onHistory: () =>
                  context.push(AppRoutes.walkHistoryPath(widget.petId)),
            )
          : _ActiveCard(
              petName: widget.petName,
              elapsed: session.formattedElapsed,
              distance: session.formattedDistance,
              speed: session.formattedSpeed,
              hasLocation: session.hasLocation,
              stopping: _stopping,
              onStop: _stopping ? null : _stop,
              l10n: l10n,
            ),
    );
  }
}

// ── Idle state ────────────────────────────────────────────────────────────────

class _IdleCard extends StatelessWidget {
  const _IdleCard({
    required this.petName,
    required this.loading,
    required this.onStart,
    required this.onHistory,
  });

  final String petName;
  final bool loading;
  final VoidCallback? onStart;
  final VoidCallback onHistory;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A7F8B), Color(0xFF01B4C2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: const Icon(
              FluentIcons.animal_paw_print_24_regular,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.walkStartTitle,
                  style: AppTextStyles.titleSmall
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.walkStartSubtitle(petName),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          IconButton(
            onPressed: onHistory,
            tooltip: l10n.walkHistoryTitle,
            visualDensity: VisualDensity.compact,
            icon: Icon(
              FluentIcons.history_24_regular,
              color: Colors.white.withValues(alpha: 0.9),
              size: 22,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          FilledButton(
            onPressed: onStart,
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.secondary,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
            child: loading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.secondary,
                    ),
                  )
                : Text(l10n.walkStartButton),
          ),
        ],
      ),
    );
  }
}

// ── Active state ──────────────────────────────────────────────────────────────

class _ActiveCard extends StatelessWidget {
  const _ActiveCard({
    required this.petName,
    required this.elapsed,
    required this.distance,
    required this.speed,
    required this.hasLocation,
    required this.stopping,
    required this.onStop,
    required this.l10n,
  });

  final String petName;
  final String elapsed;
  final String distance;
  final String speed;
  final bool hasLocation;
  final bool stopping;
  final VoidCallback? onStop;
  final dynamic l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A7F8B), Color(0xFF01B4C2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              _PulseDot(),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  context.l10n.walkActiveTitle(petName),
                  style:
                      AppTextStyles.titleSmall.copyWith(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          // Stats row
          Row(
            children: [
              _StatChip(
                icon: FluentIcons.timer_24_regular,
                value: elapsed,
                label: context.l10n.walkStatDuration,
              ),
              const SizedBox(width: AppSpacing.sm),
              _StatChip(
                icon: FluentIcons.road_24_regular,
                value: distance,
                label: context.l10n.walkStatDistance,
                dimmed: !hasLocation,
              ),
              const SizedBox(width: AppSpacing.sm),
              _StatChip(
                icon: FluentIcons.gauge_24_regular,
                value: speed,
                label: context.l10n.walkStatSpeed,
                dimmed: !hasLocation,
              ),
            ],
          ),
          if (!hasLocation) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Icon(
                  FluentIcons.location_off_24_regular,
                  size: 14,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
                const SizedBox(width: 4),
                Text(
                  context.l10n.walkNoLocation,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: _StopButton(stopping: stopping, onStop: onStop),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.value,
    required this.label,
    this.dimmed = false,
  });

  final IconData icon;
  final String value;
  final String label;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    final alpha = dimmed ? 0.5 : 1.0;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Column(
          children: [
            Icon(icon,
                size: 18,
                color: Colors.white.withValues(alpha: alpha)),
            const SizedBox(height: 4),
            Text(
              value,
              style: AppTextStyles.titleSmall.copyWith(
                color: Colors.white.withValues(alpha: alpha),
                fontSize: 15,
              ),
            ),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: Colors.white.withValues(alpha: dimmed ? 0.4 : 0.75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StopButton extends StatelessWidget {
  const _StopButton({required this.stopping, required this.onStop});

  final bool stopping;
  final VoidCallback? onStop;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onStop,
      style: FilledButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.secondary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
      icon: stopping
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: AppColors.secondary),
            )
          : const Icon(FluentIcons.stop_24_filled, size: 16),
      label: Text(context.l10n.walkStopButton),
    );
  }
}

/// Animated green pulsing dot indicating live recording.
class _PulseDot extends StatefulWidget {
  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _scale = Tween(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Container(
        width: 10,
        height: 10,
        decoration: const BoxDecoration(
          color: Color(0xFF4ADE80),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
