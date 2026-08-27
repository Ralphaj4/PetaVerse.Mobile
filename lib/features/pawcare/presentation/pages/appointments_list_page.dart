import 'dart:async';

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
import '../../domain/entities/appointment.dart';
import '../providers/pawcare_providers.dart';

/// Full list of a pet's appointments, upcoming first. A "+" opens the add
/// form; each record can be deleted via swipe or the trailing button.
class AppointmentsListPage extends ConsumerWidget {
  const AppointmentsListPage({required this.petId, super.key});

  final int petId;

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    Appointment appt,
  ) async {
    final l10n = context.l10n;
    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.delete_24_regular,
      title: l10n.appointmentsDeleteTitle,
      message: l10n.appointmentsDeleteMessage(appt.title),
      confirmLabel: l10n.delete,
      cancelLabel: l10n.cancel,
      isDestructive: true,
    );
    if (!confirmed || !context.mounted) return;

    final result = await ref
        .read(pawCareRepositoryProvider)
        .deleteAppointment(petId, appt.id);
    if (!context.mounted) return;

    result.when(
      success: (_) {
        ref.invalidate(petAppointmentsProvider(petId));
        context.showSuccessSnackBar(l10n.appointmentsDeleteSuccess);
      },
      failure: (f) => context.showErrorSnackBar(f.localizedMessage(l10n)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final async = ref.watch(petAppointmentsProvider(petId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(l10n.appointmentsTitle),
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
            tooltip: l10n.appointmentsAdd,
            icon: const Icon(FluentIcons.add_24_regular),
            onPressed: () =>
                context.push(AppRoutes.addAppointmentPath(petId)),
          ),
        ],
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorStateWidget(
          failure: e is Failure ? e : const UnknownFailure(),
          onRetry: () => ref.invalidate(petAppointmentsProvider(petId)),
        ),
        data: (appointments) {
          if (appointments.isEmpty) {
            return _Empty(
              onAdd: () =>
                  context.push(AppRoutes.addAppointmentPath(petId)),
            );
          }
          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              ref.invalidate(petAppointmentsProvider(petId));
              await ref.read(petAppointmentsProvider(petId).future);
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: appointments.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, i) {
                final appt = appointments[i];
                return Dismissible(
                  key: ValueKey('appt-${appt.id}'),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (_) async {
                    unawaited(_delete(context, ref, appt));
                    return false;
                  },
                  background: const _DeleteBackground(),
                  child: _AppointmentTile(
                    appt: appt,
                    onEdit: () => context.push(
                      AppRoutes.editAppointmentPath(petId, appt.id),
                      extra: appt,
                    ),
                    onDelete: () => _delete(context, ref, appt),
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

class _AppointmentTile extends StatelessWidget {
  const _AppointmentTile({
    required this.appt,
    required this.onEdit,
    required this.onDelete,
  });

  final Appointment appt;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final past = appt.isPast;
    final days = appt.daysUntil;

    final String status;
    final Color statusColor;
    if (past) {
      status = l10n.reminderOverdue;
      statusColor = AppColors.error;
    } else if (days == 0) {
      status = l10n.reminderDueToday;
      statusColor = AppColors.warning;
    } else {
      status = l10n.appointmentInDays(days);
      statusColor = AppColors.textSecondary;
    }

    return Container(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.md,
        top: AppSpacing.md,
        bottom: AppSpacing.md,
        end: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: past
                  ? AppColors.error.withValues(alpha: 0.10)
                  : AppColors.secondarySoft,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(
              FluentIcons.calendar_ltr_24_regular,
              size: 20,
              color: past ? AppColors.error : AppColors.secondary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appt.title, style: AppTextStyles.titleSmall),
                const SizedBox(height: 2),
                Text(
                  DateFormat.yMMMd(locale)
                      .add_jm()
                      .format(appt.scheduledAt),
                  style: AppTextStyles.bodySmall,
                ),
                if (appt.location != null) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        FluentIcons.location_24_regular,
                        size: 12,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          appt.location!,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textTertiary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Text(
              status,
              style: AppTextStyles.labelMedium
                  .copyWith(color: statusColor, letterSpacing: 0),
            ),
          ),
          IconButton(
            onPressed: onEdit,
            tooltip: l10n.appointmentsEdit,
            visualDensity: VisualDensity.compact,
            icon: const Icon(
              FluentIcons.edit_24_regular,
              size: 20,
              color: AppColors.textTertiary,
            ),
          ),
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
            const Icon(FluentIcons.calendar_ltr_24_regular,
                size: 56, color: AppColors.divider),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.appointmentsEmpty,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            TextButton(
              onPressed: onAdd,
              child: Text(l10n.appointmentsAdd),
            ),
          ],
        ),
      ),
    );
  }
}
