import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../domain/entities/weight_record.dart';
import '../providers/pawcare_providers.dart';
import '../widgets/weight_chart.dart';

/// Full weight history for a pet: the trend chart over all readings plus a
/// reverse-chronological list with per-entry change. A "+" opens the add form,
/// and each reading can be swiped / tapped to delete.
class WeightHistoryPage extends ConsumerWidget {
  const WeightHistoryPage({required this.petId, super.key});

  final int petId;

  /// Confirms and deletes a single weight reading, then refreshes history +
  /// the dashboard snapshot.
  Future<void> _deleteWeight(
    BuildContext context,
    WidgetRef ref,
    WeightRecord record,
  ) async {
    final l10n = context.l10n;
    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.delete_24_regular,
      title: l10n.healthWeightDeleteTitle,
      message: l10n.healthWeightDeleteMessage,
      confirmLabel: l10n.delete,
      cancelLabel: l10n.cancel,
      isDestructive: true,
    );
    if (!confirmed || !context.mounted) return;

    final result = await ref
        .read(pawCareRepositoryProvider)
        .deleteWeight(petId, record.id);
    if (!context.mounted) return;

    result.when(
      success: (_) {
        ref.invalidate(weightHistoryProvider(petId));
        ref.invalidate(petHealthSnapshotProvider(petId));
        ref.invalidate(petHealthScoreProvider(petId));
        context.showSuccessSnackBar(l10n.healthWeightDeleteSuccess);
      },
      failure: (f) => context.showErrorSnackBar(
        f.localizedMessage(l10n),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final async = ref.watch(weightHistoryProvider(petId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(l10n.healthWeightTitle),
        leading: IconButton(
          icon: Icon(
            context.isRtl
                ? FluentIcons.arrow_right_24_regular
                : FluentIcons.arrow_left_24_regular,
          ),
          onPressed: () => context.popOrHome(),
        ),
        actions: [
          IconButton(
            tooltip: l10n.healthWeightAdd,
            icon: const Icon(FluentIcons.add_24_regular),
            onPressed: () =>
                context.push(AppRoutes.addWeightPath(petId)),
          ),
        ],
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorStateWidget(
          failure: e is Failure ? e : const UnknownFailure(),
          onRetry: () => ref.invalidate(weightHistoryProvider(petId)),
        ),
        data: (records) {
          if (records.isEmpty) {
            return _Empty(
              onAdd: () => context.push(AppRoutes.addWeightPath(petId)),
            );
          }
          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              ref.invalidate(weightHistoryProvider(petId));
              await ref.read(weightHistoryProvider(petId).future);
            },
            child: _Body(
              records: records,
              onDelete: (record) => _deleteWeight(context, ref, record),
            ),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.records, required this.onDelete});

  /// Newest-first, as the API returns it.
  final List<WeightRecord> records;
  final void Function(WeightRecord) onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final numFmt = NumberFormat.decimalPattern(locale)
      ..minimumFractionDigits = 1
      ..maximumFractionDigits = 1;
    final dateFmt = DateFormat.yMMMMd(locale);

    // Records are already newest-first for the list; latest is the head.
    final latest = records.first;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // ── Chart card ────────────────────────────────────────────────────
        Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(numFmt.format(latest.value),
                      style: AppTextStyles.displayLarge),
                  const SizedBox(width: AppSpacing.xs),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      latest.unit.suffix,
                      style: AppTextStyles.titleMedium
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              // Chart wants chronological order; records are newest-first.
              WeightChart(records: records.reversed.toList()),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        Text(l10n.healthWeightAllReadings, style: AppTextStyles.titleMedium),
        const SizedBox(height: AppSpacing.sm),

        // ── Readings list (newest first) ──────────────────────────────────
        for (var i = 0; i < records.length; i++)
          Dismissible(
            key: ValueKey('weight-${records[i].id}'),
            direction: DismissDirection.endToStart,
            // The shared confirm dialog is the source of truth; returning false
            // keeps the row (the actual delete + refresh happens in onDelete).
            confirmDismiss: (_) async {
              onDelete(records[i]);
              return false;
            },
            background: const _DeleteBackground(),
            child: _ReadingRow(
              record: records[i],
              // Delta vs. the chronologically-previous reading (next in a
              // newest-first list).
              previous: i < records.length - 1 ? records[i + 1] : null,
              numFmt: numFmt,
              dateFmt: dateFmt,
              onDelete: () => onDelete(records[i]),
            ),
          ),
      ],
    );
  }
}

/// Red swipe-reveal background with a trash icon, shown behind a reading as it's
/// dragged toward the end edge.
class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsetsDirectional.only(end: AppSpacing.lg),
      alignment: AlignmentDirectional.centerEnd,
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: AppRadius.mdAll,
      ),
      child: const Icon(FluentIcons.delete_24_regular,
          color: AppColors.onPrimary, size: 22),
    );
  }
}

class _ReadingRow extends StatelessWidget {
  const _ReadingRow({
    required this.record,
    required this.previous,
    required this.numFmt,
    required this.dateFmt,
    required this.onDelete,
  });

  final WeightRecord record;
  final WeightRecord? previous;
  final NumberFormat numFmt;
  final DateFormat dateFmt;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final delta = previous == null ? null : record.value - previous!.value;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.md,
        top: AppSpacing.md,
        bottom: AppSpacing.md,
        end: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.secondarySoft,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: const Icon(FluentIcons.scales_24_regular,
                size: 20, color: AppColors.secondary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${numFmt.format(record.value)} ${record.unit.suffix}',
                  style: AppTextStyles.titleSmall,
                ),
                const SizedBox(height: 2),
                Text(dateFmt.format(record.recordedAt),
                    style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          if (delta != null && delta.abs() >= 0.05) _DeltaChip(delta: delta),
          IconButton(
            onPressed: onDelete,
            tooltip: l10n.delete,
            visualDensity: VisualDensity.compact,
            icon: const Icon(
              FluentIcons.delete_24_regular,
              size: 20,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _DeltaChip extends StatelessWidget {
  const _DeltaChip({required this.delta});

  final double delta;

  @override
  Widget build(BuildContext context) {
    final up = delta > 0;
    final color = up ? AppColors.warning : AppColors.success;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          up
              ? FluentIcons.arrow_trending_24_filled
              : FluentIcons.arrow_trending_down_24_filled,
          size: 14,
          color: color,
        ),
        const SizedBox(width: 2),
        Text(
          '${up ? '+' : '−'}${delta.abs().toStringAsFixed(1)}',
          style: AppTextStyles.labelMedium.copyWith(color: color, letterSpacing: 0),
        ),
      ],
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(FluentIcons.scales_24_regular,
                size: 56, color: AppColors.divider),
            const SizedBox(height: AppSpacing.lg),
            Text(l10n.healthWeightEmpty,
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.lg),
            TextButton(onPressed: onAdd, child: Text(l10n.healthWeightAdd)),
          ],
        ),
      ),
    );
  }
}
