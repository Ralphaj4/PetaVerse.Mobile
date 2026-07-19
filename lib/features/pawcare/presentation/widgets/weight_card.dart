import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/weight_record.dart';
import 'health_section_card.dart';
import 'health_section_empty.dart';
import 'weight_sparkline.dart';

/// Weight section: latest value + trend since the previous reading, a sparkline
/// of recent readings, and an add affordance. Empty state when no records.
class WeightCard extends StatelessWidget {
  const WeightCard({
    required this.records,
    required this.onAdd,
    this.onOpen,
    super.key,
  });

  /// Weight records newest-first (as the API returns them).
  final List<WeightRecord> records;
  final VoidCallback onAdd;
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return HealthSectionCard(
      icon: FluentIcons.scales_24_regular,
      title: l10n.healthWeightTitle,
      accent: AppColors.secondary,
      accentSoft: AppColors.secondarySoft,
      onAdd: onAdd,
      addTooltip: l10n.healthWeightAdd,
      onOpen: records.isEmpty ? null : onOpen,
      child: records.isEmpty
          ? HealthSectionEmpty(
              message: l10n.healthWeightEmpty,
              actionLabel: l10n.healthWeightAdd,
              onAction: onAdd,
            )
          : _WeightBody(records: records),
    );
  }
}

class _WeightBody extends StatelessWidget {
  const _WeightBody({required this.records});

  final List<WeightRecord> records;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    // Records are newest-first: latest is the head, previous is the next one.
    final latest = records.first;
    final numFmt = NumberFormat.decimalPattern(locale)
      ..minimumFractionDigits = 1
      ..maximumFractionDigits = 1;

    final delta = records.length >= 2 ? latest.value - records[1].value : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(numFmt.format(latest.value), style: AppTextStyles.displayLarge),
            const SizedBox(width: AppSpacing.xs),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                latest.unit.suffix,
                style: AppTextStyles.titleMedium
                    .copyWith(color: AppColors.textSecondary),
              ),
            ),
            const Spacer(),
            if (delta != null) _TrendChip(delta: delta, unit: latest.unit),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.healthWeightLastRecorded(
            DateFormat.yMMMd(locale).format(latest.recordedAt),
          ),
          style: AppTextStyles.bodySmall,
        ),
        const SizedBox(height: AppSpacing.md),
        // Sparkline wants chronological order; records are newest-first.
        WeightSparkline(
          values: [for (final r in records.reversed) r.value],
        ),
      ],
    );
  }
}

/// Small up/down/steady pill showing the change from the previous reading.
class _TrendChip extends StatelessWidget {
  const _TrendChip({required this.delta, required this.unit});

  final double delta;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final steady = delta.abs() < 0.05;
    final up = delta > 0;
    final color = steady
        ? AppColors.textSecondary
        : (up ? AppColors.warning : AppColors.success);
    final icon = steady
        ? FluentIcons.subtract_24_filled
        : (up
            ? FluentIcons.arrow_trending_24_filled
            : FluentIcons.arrow_trending_down_24_filled);
    final label = steady
        ? context.l10n.healthWeightSteady
        : '${up ? '+' : '−'}${delta.abs().toStringAsFixed(1)} ${unit.suffix}';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.labelMedium
                .copyWith(color: color, letterSpacing: 0),
          ),
        ],
      ),
    );
  }
}
