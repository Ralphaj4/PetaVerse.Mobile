import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../domain/entities/walk_activity.dart';
import '../providers/walk_session_provider.dart';

class WalkHistoryPage extends ConsumerWidget {
  const WalkHistoryPage({required this.petId, super.key});

  final int petId;

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    WalkActivity activity,
  ) async {
    final l10n = context.l10n;

    // Guard: walks past the deletion window can't be removed.
    if (!activity.canDelete) {
      context.showErrorSnackBar(l10n.walkDeleteTooOld);
      return;
    }

    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.delete_24_regular,
      title: l10n.walkDeleteTitle,
      message: l10n.walkDeleteMessage,
      confirmLabel: l10n.delete,
      cancelLabel: l10n.cancel,
      isDestructive: true,
    );
    if (!confirmed || !context.mounted) return;

    final result = await ref
        .read(activityRepositoryProvider)
        .deleteActivity(petId, activity.id);
    if (!context.mounted) return;

    result.when(
      success: (_) {
        ref.invalidate(walkHistoryProvider(petId));
        context.showSuccessSnackBar(l10n.walkDeleteSuccess);
      },
      failure: (f) => context.showErrorSnackBar(
        f.localizedMessage(l10n),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final async = ref.watch(walkHistoryProvider(petId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        title: Text(l10n.walkHistoryTitle),
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
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.secondary),
        ),
        error: (e, _) => ErrorStateWidget(
          failure: e is Failure ? e : const UnknownFailure(),
          onRetry: () => ref.invalidate(walkHistoryProvider(petId)),
        ),
        data: (activities) {
          if (activities.isEmpty) return const _Empty();
          // Flatten into rows: a day header precedes each new calendar day, so
          // the list reads as dated groups. Activities arrive newest-first.
          final rows = _buildRows(activities);
          return RefreshIndicator(
            color: AppColors.secondary,
            onRefresh: () async {
              ref.invalidate(walkHistoryProvider(petId));
              await ref.read(walkHistoryProvider(petId).future);
            },
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.xxl,
              ),
              itemCount: rows.length,
              itemBuilder: (context, i) {
                final row = rows[i];
                if (row is _HeaderRow) {
                  return _DayHeader(
                    day: row.day,
                    // No top gap for the very first header.
                    topGap: i == 0 ? 0 : AppSpacing.lg,
                  );
                }
                final activity = (row as _ActivityRow).activity;
                final tile = Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: _ActivityCard(
                    activity: activity,
                    onDelete: activity.canDelete
                        ? () => _delete(context, ref, activity)
                        : null,
                  ),
                );
                // Older walks can't be deleted — skip the swipe affordance.
                if (!activity.canDelete) return tile;
                return Dismissible(
                  key: ValueKey('walk-${activity.id}'),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (_) async {
                    unawaited(_delete(context, ref, activity));
                    return false;
                  },
                  background: const Padding(
                    padding: EdgeInsets.only(bottom: AppSpacing.md),
                    child: _DeleteBackground(),
                  ),
                  child: tile,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ── Day grouping ──────────────────────────────────────────────────────────────

/// A row in the flattened list: either a day header or an activity.
sealed class _Row {
  const _Row();
}

class _HeaderRow extends _Row {
  const _HeaderRow(this.day);

  /// Midnight of the group's calendar day (local).
  final DateTime day;
}

class _ActivityRow extends _Row {
  const _ActivityRow(this.activity);
  final WalkActivity activity;
}

/// Flattens [activities] (assumed newest-first) into header + activity rows,
/// inserting a header whenever the calendar day changes.
List<_Row> _buildRows(List<WalkActivity> activities) {
  final rows = <_Row>[];
  DateTime? currentDay;
  for (final a in activities) {
    final local = a.startedAt.toLocal();
    final day = DateTime(local.year, local.month, local.day);
    if (currentDay == null || day != currentDay) {
      currentDay = day;
      rows.add(_HeaderRow(day));
    }
    rows.add(_ActivityRow(a));
  }
  return rows;
}

class _DayHeader extends StatelessWidget {
  const _DayHeader({required this.day, required this.topGap});

  final DateTime day;
  final double topGap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final diffDays = today.difference(day).inDays;

    final String label;
    if (diffDays == 0) {
      label = l10n.dateToday;
    } else if (diffDays == 1) {
      label = l10n.dateYesterday;
    } else {
      label = DateFormat.yMMMMEEEEd(locale).format(day);
    }

    return Padding(
      padding: EdgeInsets.only(top: topGap, bottom: AppSpacing.sm),
      child: Text(
        label,
        style: AppTextStyles.labelLarge.copyWith(
          color: AppColors.textSecondary,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

// ── Card ────────────────────────────────────────────────────────────────────

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({required this.activity, required this.onDelete});

  final WalkActivity activity;

  /// Null when the walk is too old to delete — hides the trash button.
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final started = activity.startedAt.toLocal();
    final timeLabel = DateFormat.jm(locale).format(started);
    final hasGps = activity.distanceMeters != null;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: icon + date/time + optional delete.
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: const Icon(
                    FluentIcons.animal_paw_print_24_filled,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${activity.intensity} activity at $timeLabel',
                        style: AppTextStyles.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (onDelete != null)
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
            const SizedBox(height: AppSpacing.md),
            // Stats row.
            Row(
              children: [
                _Stat(
                  icon: FluentIcons.timer_24_regular,
                  value: activity.formattedDuration,
                  label: l10n.walkStatDuration,
                  color: AppColors.secondary,
                ),
                const _StatDivider(),
                _Stat(
                  icon: FluentIcons.road_24_regular,
                  value: hasGps ? activity.formattedDistance : '--',
                  label: l10n.walkStatDistance,
                  color: AppColors.primary,
                  dimmed: !hasGps,
                ),
                const _StatDivider(),
                _Stat(
                  icon: FluentIcons.top_speed_24_regular,
                  value: hasGps ? activity.formattedSpeed : '--',
                  label: l10n.walkStatSpeed,
                  color: AppColors.accentPurple,
                  dimmed: !hasGps,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    this.dimmed = false,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            size: 18,
            color: dimmed ? AppColors.textTertiary : color,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: AppTextStyles.titleSmall.copyWith(
              color: dimmed ? AppColors.textTertiary : AppColors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTextStyles.labelSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 34,
      color: AppColors.divider,
    );
  }
}

class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(end: AppSpacing.xl),
      alignment: AlignmentDirectional.centerEnd,
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: AppRadius.lgAll,
      ),
      child: const Icon(
        FluentIcons.delete_24_filled,
        color: AppColors.onPrimary,
        size: 24,
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.secondarySoft,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.xl),
                child: Icon(
                  FluentIcons.animal_paw_print_24_filled,
                  size: 48,
                  color: AppColors.secondary,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.walkHistoryEmpty,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
