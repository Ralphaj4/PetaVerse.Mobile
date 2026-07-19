import 'dart:async';

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
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../domain/entities/medication.dart';
import '../providers/pawcare_providers.dart';
import '../widgets/medication_frequency.dart';

/// Full list of a pet's active medications, with a due badge, a "mark given"
/// action (POST mark-given → recomputed next due), and an "edit frequency"
/// action (PUT → recomputed next due). A "+" opens the add form.
class MedicationsListPage extends ConsumerStatefulWidget {
  const MedicationsListPage({required this.petId, super.key});

  final int petId;

  @override
  ConsumerState<MedicationsListPage> createState() =>
      _MedicationsListPageState();
}

class _MedicationsListPageState extends ConsumerState<MedicationsListPage> {
  /// The medication id running an action, so only its row disables/spins.
  int? _busyId;

  void _refresh() {
    ref.invalidate(petMedicationsProvider(widget.petId));
    ref.invalidate(petHealthSnapshotProvider(widget.petId));
  }

  Future<void> _markGiven(Medication med) async {
    final l10n = context.l10n;
    setState(() => _busyId = med.id);
    final result = await ref
        .read(pawCareRepositoryProvider)
        .markMedicationGiven(widget.petId, med.id);
    if (!mounted) return;
    setState(() => _busyId = null);
    result.when(
      success: (_) {
        _refresh();
        context.showSuccessSnackBar(
          l10n.healthMedicationsGivenConfirmed(med.name),
        );
      },
      failure: (f) => context.showErrorSnackBar(
        f.message?.isNotEmpty == true ? f.message! : l10n.errorUnknown,
      ),
    );
  }

  Future<void> _delete(Medication med) async {
    final l10n = context.l10n;
    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.delete_24_regular,
      title: l10n.healthMedicationsDeleteTitle,
      message: l10n.healthMedicationsDeleteMessage(med.name),
      confirmLabel: l10n.delete,
      cancelLabel: l10n.cancel,
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;

    final result = await ref
        .read(pawCareRepositoryProvider)
        .deleteMedication(widget.petId, med.id);
    if (!mounted) return;

    result.when(
      success: (_) {
        _refresh();
        context.showSuccessSnackBar(l10n.healthMedicationsDeleteSuccess);
      },
      failure: (f) => context.showErrorSnackBar(
        f.message?.isNotEmpty == true ? f.message! : l10n.errorUnknown,
      ),
    );
  }

  Future<void> _editFrequency(Medication med) async {
    final l10n = context.l10n;
    final picked =
        await showMedicationFrequencySheet(context, med.frequencyDays);
    if (picked == null || picked == med.frequencyDays || !mounted) return;

    setState(() => _busyId = med.id);
    final result = await ref.read(pawCareRepositoryProvider).updateMedication(
          widget.petId,
          med.id,
          medicationName: med.name,
          frequencyDays: picked,
        );
    if (!mounted) return;
    setState(() => _busyId = null);
    result.when(
      success: (_) {
        _refresh();
        context.showSuccessSnackBar(l10n.healthMedicationsFrequencyUpdated);
      },
      failure: (f) => context.showErrorSnackBar(
        f.message?.isNotEmpty == true ? f.message! : l10n.errorUnknown,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final async = ref.watch(petMedicationsProvider(widget.petId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(l10n.healthMedicationsTitle),
        leading: IconButton(
          icon: Icon(
            context.isRtl
                ? FluentIcons.arrow_right_24_regular
                : FluentIcons.arrow_left_24_regular,
          ),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            tooltip: l10n.healthMedicationsAdd,
            icon: const Icon(FluentIcons.add_24_regular),
            onPressed: () => context.push(AppRoutes.addMedicationPath(widget.petId)),
          ),
        ],
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorStateWidget(
          failure: e is Failure ? e : const UnknownFailure(),
          onRetry: () => ref.invalidate(petMedicationsProvider(widget.petId)),
        ),
        data: (meds) {
          if (meds.isEmpty) {
            return _Empty(
              onAdd: () =>
                  context.push(AppRoutes.addMedicationPath(widget.petId)),
            );
          }
          final now = DateTime.now();
          final sorted = [...meds]
            ..sort((a, b) => a.nextDueDate.compareTo(b.nextDueDate));
          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              ref.invalidate(petMedicationsProvider(widget.petId));
              await ref.read(petMedicationsProvider(widget.petId).future);
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: sorted.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, i) {
                final med = sorted[i];
                return Dismissible(
                  key: ValueKey('med-${med.id}'),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (_) async {
                    unawaited(_delete(med));
                    return false;
                  },
                  background: const _DeleteBackground(),
                  child: _MedicationTile(
                    med: med,
                    now: now,
                    busy: _busyId == med.id,
                    actionsEnabled: _busyId == null,
                    onMarkGiven: () => _markGiven(med),
                    onEditFrequency: () => _editFrequency(med),
                    onDelete: () => _delete(med),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _MedicationTile extends StatelessWidget {
  const _MedicationTile({
    required this.med,
    required this.now,
    required this.busy,
    required this.actionsEnabled,
    required this.onMarkGiven,
    required this.onEditFrequency,
    required this.onDelete,
  });

  final Medication med;
  final DateTime now;
  final bool busy;
  final bool actionsEnabled;
  final VoidCallback onMarkGiven;
  final VoidCallback onEditFrequency;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.accentPurpleSoft,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: const Icon(FluentIcons.pill_24_regular,
                    size: 20, color: AppColors.accentPurple),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(med.name,
                        style: AppTextStyles.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text(frequencyDaysLabel(l10n, med.frequencyDays),
                        style: AppTextStyles.bodySmall),
                  ],
                ),
              ),
              _DueBadge(days: med.daysUntilDue(now)),
              const SizedBox(width: AppSpacing.xs),
              IconButton(
                onPressed: actionsEnabled ? onDelete : null,
                tooltip: context.l10n.delete,
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
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: actionsEnabled ? onEditFrequency : null,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                  ),
                  icon: const Icon(FluentIcons.arrow_repeat_all_24_regular,
                      size: 18),
                  label: Text(l10n.healthMedicationsEditFrequency),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: actionsEnabled ? onMarkGiven : null,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.success,
                  ),
                  icon: busy
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: AppColors.success),
                        )
                      : const Icon(FluentIcons.checkmark_circle_24_regular,
                          size: 18),
                  label: Text(l10n.healthMedicationsMarkGiven),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(end: AppSpacing.lg),
      alignment: AlignmentDirectional.centerEnd,
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: AppRadius.lgAll,
      ),
      child: const Icon(FluentIcons.delete_24_regular,
          color: AppColors.onPrimary, size: 22),
    );
  }
}

class _DueBadge extends StatelessWidget {
  const _DueBadge({required this.days});

  final int days;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (Color color, String label) = switch (days) {
      < 0 => (AppColors.error, l10n.healthMedicationsOverdue),
      0 => (AppColors.warning, l10n.healthMedicationsDueToday),
      _ => (AppColors.textSecondary, l10n.healthMedicationsDueInDays(days)),
    };
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(label,
          style: AppTextStyles.labelMedium
              .copyWith(color: color, letterSpacing: 0)),
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
            const Icon(FluentIcons.pill_24_regular,
                size: 56, color: AppColors.divider),
            const SizedBox(height: AppSpacing.lg),
            Text(l10n.healthMedicationsEmpty,
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.lg),
            TextButton(onPressed: onAdd, child: Text(l10n.healthMedicationsAdd)),
          ],
        ),
      ),
    );
  }
}
