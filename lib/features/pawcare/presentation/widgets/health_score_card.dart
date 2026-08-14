import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../domain/entities/pet_health_score.dart';
import '../providers/pawcare_providers.dart';
import 'health_score_bits.dart';
import 'health_score_gauge.dart';
import 'health_score_style.dart';

/// The compact health-score entry point on the pet profile — a gauge (value +
/// band chip + confidence) that taps through to the full breakdown page.
///
/// Owns its own async wiring so the profile only has to place it. Renders the
/// "No data" cold-start as an onboarding prompt, never a red 0 gauge (§4.3).
class HealthScoreCard extends ConsumerWidget {
  const HealthScoreCard({required this.petId, this.petName, super.key});

  final int petId;

  /// Used in the cold-start onboarding copy; falls back to a generic phrasing
  /// when null.
  final String? petName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scoreAsync = ref.watch(petHealthScoreProvider(petId));

    return scoreAsync.when(
      loading: () => const _ScoreShell(child: _ScoreSkeleton()),
      error: (e, _) => _ScoreShell(
        child: ErrorStateWidget(
          failure: e is Failure ? e : null,
          onRetry: () => ref.invalidate(petHealthScoreProvider(petId)),
        ),
      ),
      data: (score) => score.hasData
          ? _ScoreSummary(petId: petId, score: score)
          : _ScoreEmpty(petName: petName),
    );
  }
}

/// White rounded card frame matching [HealthSectionCard], without the titled
/// header (the gauge is its own visual anchor).
class _ScoreShell extends StatelessWidget {
  const _ScoreShell({required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: AppRadius.lgAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.lgAll,
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.lgAll,
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withValues(alpha: 0.04),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: child,
        ),
      ),
    );
  }
}

class _ScoreSummary extends StatelessWidget {
  const _ScoreSummary({required this.petId, required this.score});

  final int petId;
  final PetHealthScore score;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = HealthScoreStyle.bandColor(score.band);

    return _ScoreShell(
      onTap: () => context.push(AppRoutes.healthScorePath(petId)),
      child: Row(
        children: [
          HealthScoreGauge(
            value: score.value,
            color: color,
            size: 108,
            strokeWidth: 11,
            caption: l10n.healthScoreOutOf,
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.healthScoreTitle,
                  style: AppTextStyles.labelSmall
                      .copyWith(color: AppColors.textTertiary),
                ),
                const SizedBox(height: AppSpacing.xs),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: HealthBandChip(band: score.band),
                ),
                const SizedBox(height: AppSpacing.md),
                HealthConfidenceBar(
                  confidence: score.confidence,
                  applicableCount: score.applicableCount,
                  showHeader: false,
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Text(
                      l10n.healthScoreViewBreakdown,
                      style: AppTextStyles.labelMedium
                          .copyWith(color: AppColors.primary),
                    ),
                    Icon(
                      Directionality.of(context) == TextDirection.rtl
                          ? FluentIcons.chevron_left_16_regular
                          : FluentIcons.chevron_right_16_regular,
                      size: 14,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Cold-start onboarding prompt (`band == "No data"`). Not a failing grade.
class _ScoreEmpty extends StatelessWidget {
  const _ScoreEmpty({this.petName});

  final String? petName;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return _ScoreShell(
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: AppRadius.smAll,
            ),
            child: const Icon(
              FluentIcons.heart_pulse_24_regular,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.healthScoreTitle, style: AppTextStyles.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  petName != null && petName!.isNotEmpty
                      ? l10n.healthScoreEmptyNamed(petName!)
                      : l10n.healthScoreEmptyGeneric,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreSkeleton extends StatelessWidget {
  const _ScoreSkeleton();

  @override
  Widget build(BuildContext context) {
    Widget bar(double w, double h) => Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            color: AppColors.divider.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(999),
          ),
        );

    return Row(
      children: [
        Container(
          width: 108,
          height: 108,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.divider.withValues(alpha: 0.6),
              width: 11,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bar(72, 12),
              const SizedBox(height: AppSpacing.md),
              bar(96, 22),
              const SizedBox(height: AppSpacing.md),
              bar(double.infinity, 7),
            ],
          ),
        ),
      ],
    );
  }
}
