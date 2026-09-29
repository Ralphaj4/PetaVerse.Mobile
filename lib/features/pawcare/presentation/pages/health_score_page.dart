import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../domain/entities/pet_health_score.dart';
import '../providers/pawcare_providers.dart';
import '../widgets/health_score_bits.dart';
import '../widgets/health_score_gauge.dart';
import '../widgets/health_score_style.dart';

/// The full health-score breakdown: a large gauge, the per-signal component
/// bars, the "why this score" reasons, any managed-conditions context, and the
/// disclaimer. Read-only. Reached by tapping the gauge card on the pet profile.
class HealthScorePage extends ConsumerWidget {
  const HealthScorePage({required this.petId, super.key});

  final int petId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final async = ref.watch(petHealthScoreProvider(petId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(l10n.healthScoreTitle),
        leading: IconButton(
          icon: Icon(
            context.isRtl
                ? FluentIcons.arrow_right_24_regular
                : FluentIcons.arrow_left_24_regular,
          ),
          onPressed: () => context.popOrHome(),
        ),
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorStateWidget(
          failure: e is Failure ? e : const UnknownFailure(),
          onRetry: () => ref.invalidate(petHealthScoreProvider(petId)),
        ),
        data: (score) => RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            ref.invalidate(petHealthScoreProvider(petId));
            await ref.read(petHealthScoreProvider(petId).future);
          },
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              _GaugeHeader(score: score),
              const SizedBox(height: AppSpacing.lg),
              if (score.hasData) ...[
                _BreakdownCard(components: score.components),
                const SizedBox(height: AppSpacing.lg),
                _ReasonsCard(reasons: score.reasons),
                if (!score.conditions.isEmpty) ...[
                  const SizedBox(height: AppSpacing.lg),
                  HealthConditionsChip(conditions: score.conditions),
                ],
              ] else
                _EmptyBody(),
              const SizedBox(height: AppSpacing.lg),
              const _Disclaimer(),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

/// The big gauge + band chip + confidence, in a white card.
class _GaugeHeader extends StatelessWidget {
  const _GaugeHeader({required this.score});

  final PetHealthScore score;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = HealthScoreStyle.bandColor(score.band);

    return _Card(
      child: Column(
        children: [
          HealthScoreGauge(
            value: score.value,
            color: color,
            size: 172,
            strokeWidth: 16,
            caption: l10n.healthScoreOutOf,
          ),
          const SizedBox(height: AppSpacing.lg),
          HealthBandChip(band: score.band),
          if (score.hasData) ...[
            const SizedBox(height: AppSpacing.lg),
            HealthConfidenceBar(
              confidence: score.confidence,
              applicableCount: score.applicableCount,
            ),
          ],
        ],
      ),
    );
  }
}

/// Per-signal breakdown: applicable rows show a filled bar + earned/weight;
/// N/A rows are greyed with the reason + a "weight redistributed" note.
class _BreakdownCard extends StatelessWidget {
  const _BreakdownCard({required this.components});

  final List<HealthComponent> components;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(context.l10n.healthScoreBreakdownTitle),
          const SizedBox(height: AppSpacing.md),
          for (var i = 0; i < components.length; i++) ...[
            if (i > 0) const SizedBox(height: AppSpacing.lg),
            _ComponentRow(component: components[i]),
          ],
        ],
      ),
    );
  }
}

class _ComponentRow extends StatelessWidget {
  const _ComponentRow({required this.component});

  final HealthComponent component;

  /// A stable accent per signal, matching the visualizer's palette.
  Color get _accent => switch (component.key) {
        'vaccinations' => AppColors.secondary,
        'medications' => AppColors.accentPurple,
        'weight' => AppColors.primary,
        'activity' => const Color(0xFF2FB87A),
        _ => AppColors.secondary,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final numFmt = NumberFormat.decimalPattern(locale)
      ..minimumFractionDigits = 0
      ..maximumFractionDigits = 1;

    if (!component.applicable) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const _Dot(color: AppColors.divider),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  component.label,
                  style: AppTextStyles.titleSmall
                      .copyWith(color: AppColors.textSecondary),
                ),
              ),
              _NaTag(),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            component.naReason != null && component.naReason!.isNotEmpty
                ? l10n.healthScoreRedistributedWith(component.naReason!)
                : l10n.healthScoreRedistributed,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textTertiary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _Dot(color: _accent),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(component.label, style: AppTextStyles.titleSmall),
            ),
            Text(
              '${numFmt.format(component.earned)} / ${component.weight}',
              style: AppTextStyles.labelMedium.copyWith(color: _accent),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: component.ratio.clamp(0, 1).toDouble(),
            minHeight: 8,
            backgroundColor: AppColors.divider.withValues(alpha: 0.6),
            valueColor: AlwaysStoppedAnimation<Color>(_accent),
          ),
        ),
      ],
    );
  }
}

/// The "why this score" reasons, rendered top-to-bottom in the server's order.
class _ReasonsCard extends StatelessWidget {
  const _ReasonsCard({required this.reasons});

  final List<HealthReason> reasons;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(l10n.healthScoreWhyTitle),
          const SizedBox(height: AppSpacing.sm),
          if (reasons.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Text(
                l10n.healthScoreNoReasons,
                style: AppTextStyles.bodySmall,
              ),
            )
          else
            for (var i = 0; i < reasons.length; i++)
              _ReasonRow(reason: reasons[i], isLast: i == reasons.length - 1),
        ],
      ),
    );
  }
}

class _ReasonRow extends StatelessWidget {
  const _ReasonRow({required this.reason, required this.isLast});

  final HealthReason reason;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final color = HealthScoreStyle.severityColor(reason.severity);
    final icon = switch (reason.severity) {
      HealthReasonSeverity.good => FluentIcons.checkmark_16_filled,
      HealthReasonSeverity.warn => FluentIcons.warning_16_filled,
      HealthReasonSeverity.bad => FluentIcons.dismiss_16_filled,
    };
    final deltaFmt = NumberFormat.decimalPattern(locale)
      ..minimumFractionDigits = 1
      ..maximumFractionDigits = 1;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: AppColors.divider),
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Icon(icon, size: 13, color: AppColors.onPrimary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(reason.text, style: AppTextStyles.bodyMedium),
          ),
          if (reason.showDelta) ...[
            const SizedBox(width: AppSpacing.sm),
            Text(
              context.l10n.healthScoreDeltaPoints(
                deltaFmt.format(reason.deltaPoints),
              ),
              style: AppTextStyles.labelMedium
                  .copyWith(color: color, letterSpacing: 0),
            ),
          ],
        ],
      ),
    );
  }
}

class _EmptyBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _Card(
      child: Column(
        children: [
          const Icon(
            FluentIcons.heart_pulse_24_regular,
            size: 44,
            color: AppColors.divider,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.healthScoreEmptyGeneric,
            style:
                AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// The §1 disclaimer, in a soft teal info panel.
class _Disclaimer extends StatelessWidget {
  const _Disclaimer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.secondarySoft,
        borderRadius: AppRadius.mdAll,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            FluentIcons.info_24_regular,
            size: 18,
            color: AppColors.secondary,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              context.l10n.healthScoreDisclaimer,
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Small shared bits ────────────────────────────────────────────────────────

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
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
      child: child,
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text.toUpperCase(),
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.textTertiary,
          letterSpacing: 0.8,
        ),
      );
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
        ),
      );
}

class _NaTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          context.l10n.healthScoreNotApplicable,
          style: AppTextStyles.labelSmall.copyWith(color: AppColors.textTertiary),
        ),
      );
}
