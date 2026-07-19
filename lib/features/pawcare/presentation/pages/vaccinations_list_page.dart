import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../domain/entities/vaccination.dart';
import '../providers/pawcare_providers.dart';

/// Full list of a pet's vaccination records, most recent first, each showing
/// the administered date and booster status. A "+" opens the add form, and each
/// record can be deleted (trailing button or swipe).
class VaccinationsListPage extends ConsumerWidget {
  const VaccinationsListPage({required this.petId, super.key});

  final int petId;

  /// Confirms and deletes a single vaccination, then refreshes the list + the
  /// dashboard snapshot.
  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    Vaccination vax,
  ) async {
    final l10n = context.l10n;
    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.delete_24_regular,
      title: l10n.healthVaccinationsDeleteTitle,
      message: l10n.healthVaccinationsDeleteMessage(vax.name),
      confirmLabel: l10n.delete,
      cancelLabel: l10n.cancel,
      isDestructive: true,
    );
    if (!confirmed || !context.mounted) return;

    final result = await ref
        .read(pawCareRepositoryProvider)
        .deleteVaccination(petId, vax.id);
    if (!context.mounted) return;

    result.when(
      success: (_) {
        ref.invalidate(petVaccinationsProvider(petId));
        ref.invalidate(petHealthSnapshotProvider(petId));
        context.showSuccessSnackBar(l10n.healthVaccinationsDeleteSuccess);
      },
      failure: (f) => context.showErrorSnackBar(
        f.message?.isNotEmpty == true ? f.message! : l10n.errorUnknown,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final async = ref.watch(petVaccinationsProvider(petId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(l10n.healthVaccinationsTitle),
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
            tooltip: l10n.healthVaccinationsAdd,
            icon: const Icon(FluentIcons.add_24_regular),
            onPressed: () => context.push(AppRoutes.addVaccinationPath(petId)),
          ),
        ],
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorStateWidget(
          failure: e is Failure ? e : const UnknownFailure(),
          onRetry: () => ref.invalidate(petVaccinationsProvider(petId)),
        ),
        data: (vaccinations) {
          if (vaccinations.isEmpty) {
            return _Empty(
              onAdd: () => context.push(AppRoutes.addVaccinationPath(petId)),
            );
          }
          final now = DateTime.now();
          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              ref.invalidate(petVaccinationsProvider(petId));
              await ref.read(petVaccinationsProvider(petId).future);
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: vaccinations.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, i) {
                final vax = vaccinations[i];
                return Dismissible(
                  key: ValueKey('vax-${vax.id}'),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (_) async {
                    unawaited(_delete(context, ref, vax));
                    return false;
                  },
                  background: const _DeleteBackground(),
                  child: _VaccinationTile(
                    vax: vax,
                    now: now,
                    onDelete: () => _delete(context, ref, vax),
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

class _VaccinationTile extends StatelessWidget {
  const _VaccinationTile({
    required this.vax,
    required this.now,
    required this.onDelete,
  });

  final Vaccination vax;
  final DateTime now;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final dateFmt = DateFormat.yMMMd(locale);
    final due = vax.isDue(now);

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
              color: due
                  ? AppColors.warning.withValues(alpha: 0.12)
                  : AppColors.secondarySoft,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(
              // A syringe reads as "vaccination" better than a generic tick;
              // an overdue booster still surfaces via the amber clock.
              due ? FluentIcons.clock_24_regular : FluentIcons.syringe_24_filled,
              size: 20,
              color: due ? AppColors.warning : AppColors.secondary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(vax.name, style: AppTextStyles.titleSmall),
                const SizedBox(height: 2),
                Text(
                  l10n.healthVaccinationsGivenOn(
                    dateFmt.format(vax.administeredAt),
                  ),
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
          if (vax.nextDueDate != null) ...[
            const SizedBox(width: AppSpacing.sm),
            _BoosterBadge(due: due, date: dateFmt.format(vax.nextDueDate!)),
          ],
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

/// Red swipe-reveal background with a trash icon, shown behind a record as it's
/// dragged toward the end edge.
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

class _BoosterBadge extends StatelessWidget {
  const _BoosterBadge({required this.due, required this.date});

  final bool due;
  final String date;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = due ? AppColors.warning : AppColors.textSecondary;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        due ? l10n.healthVaccinationsDue : l10n.healthVaccinationsNextDue(date),
        style:
            AppTextStyles.labelMedium.copyWith(color: color, letterSpacing: 0),
      ),
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
            const Icon(FluentIcons.syringe_24_regular,
                size: 56, color: AppColors.divider),
            const SizedBox(height: AppSpacing.lg),
            Text(l10n.healthVaccinationsEmpty,
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.lg),
            TextButton(
                onPressed: onAdd, child: Text(l10n.healthVaccinationsAdd)),
          ],
        ),
      ),
    );
  }
}
