import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/pet_health_score.dart';
import 'health_score_style.dart';

/// A pill showing the band label in the band color. `band` is a stable
/// identifier — the display string comes from l10n, never the wire token.
class HealthBandChip extends StatelessWidget {
  const HealthBandChip({required this.band, super.key});

  final HealthBand band;

  @override
  Widget build(BuildContext context) {
    final color = HealthScoreStyle.bandColor(band);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        _label(context, band),
        style: AppTextStyles.labelLarge.copyWith(
          color: AppColors.onPrimary,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  static String _label(BuildContext context, HealthBand band) {
    final l10n = context.l10n;
    return switch (band) {
      HealthBand.excellent => l10n.healthScoreBandExcellent,
      HealthBand.good => l10n.healthScoreBandGood,
      HealthBand.fair => l10n.healthScoreBandFair,
      HealthBand.needsAttention => l10n.healthScoreBandNeedsAttention,
      HealthBand.noData => l10n.healthScoreBandNoData,
    };
  }
}

/// The confidence bar: a teal-filled track plus a "Based on N of 4 signals"
/// caption. Pairs a thin-data score with an honest signal count.
class HealthConfidenceBar extends StatelessWidget {
  const HealthConfidenceBar({
    required this.confidence,
    required this.applicableCount,
    this.showHeader = true,
    super.key,
  });

  final double confidence;
  final int applicableCount;
  final bool showHeader;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pct = (confidence.clamp(0, 1) * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHeader) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.healthScoreConfidence,
                style: AppTextStyles.labelMedium,
              ),
              Text(
                '$pct%',
                style: AppTextStyles.labelMedium
                    .copyWith(color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 6),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: confidence.clamp(0, 1).toDouble(),
            minHeight: 7,
            backgroundColor: AppColors.divider.withValues(alpha: 0.6),
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.secondary),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.healthScoreBasedOnSignals(applicableCount),
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }
}

/// Neutral info chip listing managed chronic conditions. Shown only when
/// `count > 0`; never styled as a warning (good care isn't a penalty).
class HealthConditionsChip extends StatelessWidget {
  const HealthConditionsChip({required this.conditions, super.key});

  final ConditionsContext conditions;

  @override
  Widget build(BuildContext context) {
    if (conditions.isEmpty) return const SizedBox.shrink();
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.smAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(
        conditions.labels.isEmpty
            ? l10n.healthScoreManagedConditions(conditions.count)
            : '${l10n.healthScoreManagedConditions(conditions.count)} · '
                '${conditions.labels.join(', ')}',
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}
