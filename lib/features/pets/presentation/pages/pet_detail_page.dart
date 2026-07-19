import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../../shared/widgets/shimmer.dart';
import '../../../co_ownership/presentation/providers/co_ownership_providers.dart';
import '../../../pawcare/presentation/widgets/health_dashboard.dart';
import '../../../profile/presentation/providers/user_provider.dart';
import '../../domain/entities/pet.dart';
import '../providers/delete_pet_provider.dart';
import '../providers/pet_detail_provider.dart';
import '../providers/pet_list_provider.dart';
import '../providers/pets_provider.dart';
import '../providers/species_provider.dart';

/// Full pet detail page with a tabbed layout.
/// Receives only [petId] so the route survives router refreshes without `extra`.
class PetDetailPage extends ConsumerStatefulWidget {
  const PetDetailPage({required this.petId, super.key});

  final int petId;

  @override
  ConsumerState<PetDetailPage> createState() => _PetDetailPageState();
}

class _PetDetailPageState extends ConsumerState<PetDetailPage> {
  Future<void> _confirmDelete(BuildContext context, Pet pet) async {
    final l10n = context.l10n;
    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.delete_24_regular,
      title: l10n.deletePetTitle,
      message: l10n.deletePetMessage(pet.name),
      confirmLabel: l10n.deletePetConfirm,
      cancelLabel: l10n.cancel,
      isDestructive: true,
    );
    if (!confirmed || !context.mounted) return;

    final ok = await ref.read(deletePetProvider.notifier).delete(widget.petId);
    if (!context.mounted) return;

    if (ok) {
      ref.invalidate(petListProvider);
      ref.invalidate(petDetailProvider(widget.petId));
      context.pop();
      ref.read(petsProvider.notifier).removePet(widget.petId);
      context.showSuccessSnackBar(l10n.petDeletedSuccess);
    } else {
      final failure = ref.read(deletePetProvider.notifier).failure;
      if (failure != null) {
        context.showErrorSnackBar(failure.localizedMessage(l10n));
      }
    }
  }

  /// Co-owner leaves the pet (removes their own ownership link). Only reachable
  /// when the current user is a co-owner (not the primary owner).
  Future<void> _confirmLeave(BuildContext context) async {
    final l10n = context.l10n;
    final myId = ref.read(userProvider).value?.id;
    if (myId == null) return;

    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.sign_out_24_regular,
      title: l10n.coOwnerLeaveTitle,
      message: l10n.coOwnerLeaveMessage,
      confirmLabel: l10n.coOwnerLeaveConfirm,
      cancelLabel: l10n.cancel,
      isDestructive: true,
    );
    if (!confirmed || !context.mounted) return;

    final result = await ref.read(coOwnershipRepositoryProvider).removeOwner(
          petId: widget.petId,
          userId: myId,
        );
    if (!context.mounted) return;
    result.when(
      success: (_) {
        ref.invalidate(petListProvider);
        context.pop();
        ref.read(petsProvider.notifier).removePet(widget.petId);
        ref.read(petsProvider.notifier).reconcile();
        context.showSuccessSnackBar(l10n.coOwnerLeftSuccess);
      },
      failure: (f) => context.showErrorSnackBar(f.localizedMessage(l10n)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(petDetailProvider(widget.petId));
    final isActive =
        ref.watch(petsProvider.select((s) => s.currentPetId)) == widget.petId;
    final isDeleting = ref.watch(deletePetProvider).isLoading;

    final cached = ref
        .watch(petListProvider)
        .value
        ?.where((p) => p.id == widget.petId)
        .firstOrNull;
    final displayed = detailAsync.value ?? cached;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Single scrolling column: hero header → info + health dashboard.
          SingleChildScrollView(
            child: Column(
              children: [
                _PetHeroHeader(
                  petId: widget.petId,
                  pet: displayed,
                  isActive: isActive,
                  isDeleting: isDeleting,
                  onEdit: () =>
                      context.push(AppRoutes.editPetPath(widget.petId)),
                  onAddCoOwner: () => context.push(
                    AppRoutes.inviteCoOwnerPath(widget.petId),
                    extra: displayed?.name,
                  ),
                  onLeavePet: () => _confirmLeave(context),
                  onDelete: displayed != null
                      ? () => _confirmDelete(context, displayed)
                      : null,
                ),

                // The white content sheet is pulled up over the header's
                // bottom edge — same gesture the tab bar used to make.
                Transform.translate(
                  offset: const Offset(0, -AppRadius.lg),
                  child: _PetContent(
                    petId: widget.petId,
                    displayed: displayed,
                    detailAsync: detailAsync,
                    // Room for the sticky button so nothing is hidden beneath.
                    bottomInset: (isActive || displayed == null)
                        ? MediaQuery.paddingOf(context).bottom + AppSpacing.lg
                        : MediaQuery.paddingOf(context).bottom + 100,
                  ),
                ),
              ],
            ),
          ),

          // ── Set as Active sticky button ─────────────────────────────────
          if (!isActive && displayed != null)
            Positioned(
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              bottom: MediaQuery.paddingOf(context).bottom + AppSpacing.lg,
              child: AppButton(
                label: context.l10n.petDetailSetActive,
                icon: FluentIcons.checkmark_circle_24_regular,
                variant: AppButtonVariant.primary,
                onPressed: () =>
                    ref.read(petsProvider.notifier).selectPet(widget.petId),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Hero header ──────────────────────────────────────────────────────────────

class _PetHeroHeader extends StatelessWidget {
  const _PetHeroHeader({
    required this.petId,
    required this.pet,
    required this.isActive,
    required this.isDeleting,
    required this.onEdit,
    required this.onAddCoOwner,
    required this.onLeavePet,
    required this.onDelete,
  });

  final int petId;
  final Pet? pet;
  final bool isActive;
  final bool isDeleting;
  final VoidCallback onEdit;
  final VoidCallback onAddCoOwner;
  final VoidCallback onLeavePet;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final topPadding = MediaQuery.paddingOf(context).top;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return SizedBox(
      height: 300 + topPadding,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Gradient background.
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.backgroundWarm, AppColors.primarySoft],
              ),
            ),
          ),

          // Pet image — right portion, with a rounded bottom-start corner so
          // the white sheet curves in beneath it. A start-edge gradient fades
          // the photo into the warm background instead of a hard seam.
          PositionedDirectional(
            end: 0,
            top: 0,
            bottom: 0,
            width: screenWidth * 0.62,
            child: Hero(
              tag: 'pet-image-$petId',
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppCachedImage(
                    imageUrl: pet?.avatarUrl,
                    height: double.infinity,
                    width: double.infinity,
                    borderRadius: const BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(AppRadius.lg),
                    ).resolve(Directionality.of(context)),
                    semanticLabel: pet?.name,
                    fit: BoxFit.cover,
                  ),
                  // Fade the start (left) edge into the background.
                  PositionedDirectional(
                    start: 0,
                    top: 0,
                    bottom: 0,
                    width: 90,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: AlignmentDirectional.centerStart,
                          end: AlignmentDirectional.centerEnd,
                          colors: [
                            AppColors.backgroundWarm,
                            AppColors.backgroundWarm.withValues(alpha: 0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Left-side info — anchored under the back button so the pill and
          // name sit high and fill the space above the action cards.
          PositionedDirectional(
            start: AppSpacing.lg,
            end: screenWidth * 0.42,
            top: topPadding + 40 + AppSpacing.xl,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Currently-active status pill.
                if (isActive) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.textPrimary.withValues(alpha: 0.08),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          l10n.petDetailAlreadyActive,
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.success,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],

                // Name + verified badge.
                if (pet != null) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          pet!.name,
                          style: AppTextStyles.displayLarge.copyWith(
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isActive) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            FluentIcons.checkmark_24_filled,
                            color: AppColors.onPrimary,
                            size: 16,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (pet!.breedOrSpecies.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      pet!.breedOrSpecies,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ] else
                  const _ShimmerText(width: 140, height: 36),
              ],
            ),
          ),

          // Action cards — pinned to the bottom, overlapping the image's curved
          // cutout. Smaller squares with generous gaps.
          PositionedDirectional(
            start: AppSpacing.lg,
            end: AppSpacing.lg,
            bottom: AppRadius.lg + AppSpacing.md,
            child: Row(
              children: [
                _ActionButton(
                  icon: FluentIcons.edit_24_regular,
                  label: l10n.petDetailActionEdit,
                  onTap: onEdit,
                  isPrimary: true,
                ),
                const SizedBox(width: AppSpacing.lg),
                _ActionButton(
                  icon: FluentIcons.eye_24_regular,
                  label: l10n.petDetailActionShare,
                  onTap: () => context.push(AppRoutes.petVision),
                ),
                const SizedBox(width: AppSpacing.lg),
                _ActionButton(
                  icon: FluentIcons.more_horizontal_24_regular,
                  label: l10n.petDetailActionMore,
                  onTap: () => _showMoreSheet(context),
                ),
              ],
            ),
          ),

          // Back button.
          Positioned(
            top: topPadding + AppSpacing.sm,
            left: AppSpacing.md,
            child: Material(
              color: AppColors.surface,
              borderRadius: AppRadius.mdAll,
              child: InkWell(
                borderRadius: AppRadius.mdAll,
                onTap: () => context.pop(),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(
                    context.isRtl
                        ? FluentIcons.chevron_right_24_regular
                        : FluentIcons.chevron_left_24_regular,
                    color: AppColors.textPrimary,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMoreSheet(BuildContext context) {
    final l10n = context.l10n;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (_) => SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Inviting co-owners is a primary-owner-only action.
              if (pet?.isPrimaryOwner ?? false)
                ListTile(
                  leading: const Icon(FluentIcons.person_add_24_regular,
                      color: AppColors.textPrimary),
                  title: Text(
                    l10n.inviteCoOwnerTitle,
                    style: AppTextStyles.bodyMedium,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    onAddCoOwner();
                  },
                ),
              // A co-owner (non-primary) can leave the co-ownership.
              if (pet != null && !pet!.isPrimaryOwner)
                ListTile(
                  leading: const Icon(FluentIcons.sign_out_24_regular,
                      color: AppColors.error),
                  title: Text(
                    l10n.coOwnerLeavePetAction,
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.error),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    onLeavePet();
                  },
                ),
              // Deleting the pet is a primary-owner-only action.
              if ((pet?.isPrimaryOwner ?? false) && onDelete != null)
                ListTile(
                  leading: const Icon(FluentIcons.delete_24_regular,
                      color: AppColors.error),
                  title: Text(
                    l10n.deletePetTitle,
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.error),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    onDelete!();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Content sheet (below the header) ──────────────────────────────────────────

/// The white content sheet below the hero: the pet info card, the health
/// dashboard (weight / medications / vaccinations), and the profile-complete
/// card. Non-scrolling — the page owns the single scroll view.
class _PetContent extends ConsumerWidget {
  const _PetContent({
    required this.petId,
    required this.displayed,
    required this.detailAsync,
    required this.bottomInset,
  });

  final int petId;
  final Pet? displayed;
  final AsyncValue<Pet?> detailAsync;

  /// Bottom padding reserved for the sticky "Set as Active" button.
  final double bottomInset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.lg + 4),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.lg,
        bottomInset,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (detailAsync.isLoading && displayed == null)
            const _InfoSectionSkeleton()
          else if (displayed != null) ...[
            const SizedBox(height: AppSpacing.lg),
            _SectionHeader(
              icon: FluentIcons.info_24_regular,
              title: context.l10n.petDetailSectionDetails,
            ),
            const SizedBox(height: AppSpacing.md),
            _InfoSection(pet: displayed!),

            if (detailAsync.hasError && detailAsync.value == null) ...[
              const SizedBox(height: AppSpacing.md),
              _DetailError(
                error: detailAsync.error!,
                onRetry: () => ref.invalidate(petDetailProvider(petId)),
              ),
            ],

            const SizedBox(height: AppSpacing.xl),

            _SectionHeader(
              icon: FluentIcons.heart_pulse_24_regular,
              title: context.l10n.petDetailSectionHealth,
            ),
            const SizedBox(height: AppSpacing.md),

            // Health dashboard: weight, medications, vaccinations.
            HealthDashboard(petId: petId),
            const SizedBox(height: AppSpacing.xl),

          ],
        ],
      ),
    );
  }
}

/// Localizes the sterilization wire token. Legacy records may still carry the
/// old four-value vocabulary (Intact / Neutered / Spayed), so those are folded
/// into the current labels; any unrecognized value falls back to itself.
String _sterilizationLabel(AppLocalizations l10n, String status) {
  switch (status) {
    case 'Sterilized':
    case 'Neutered':
    case 'Spayed':
      return l10n.sterilizationStatusSterilized;
    case 'NotSterilized':
    case 'Intact':
      return l10n.sterilizationStatusNotSterilized;
    case 'Unknown':
      return l10n.sterilizationStatusUnknown;
    default:
      return status;
  }
}

// ── Section header ────────────────────────────────────────────────────────────

/// A titled divider between the two content sections ("Details" and "Health
/// data"): a small accent icon chip + bold title, so the sheet reads as two
/// distinct groups rather than one long stack of cards.
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(icon, size: 18, color: AppColors.primary),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          title,
          style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

// ── Info section (rows) ───────────────────────────────────────────────────────

class _InfoSection extends StatelessWidget {
  const _InfoSection({required this.pet});

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final dateFmt = DateFormat.yMMMMd(locale);

    return Container(
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
        children: [
          _InfoRow(
            icon: FluentIcons.person_24_regular,
            label: l10n.petDetailGender,
            value: pet.gender,
          ),
          _InfoRow(
            icon: FluentIcons.calendar_24_regular,
            label: l10n.petDetailDateOfBirth,
            value: dateFmt.format(pet.dateOfBirth),
            trailing: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Text(
                // Under a year old, show months instead of "0 years old".
                pet.ageInYears == 0
                    ? l10n.petDetailAgeMonths(pet.ageInMonths)
                    : l10n.petDetailAge(pet.ageInYears),
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
          if (pet.sizeName != null)
            _InfoRow(
              icon: FluentIcons.ruler_24_regular,
              label: l10n.petDetailSize,
              value: pet.sizeName!,
            ),
          if (pet.coatColorName != null)
            _InfoRow(
              icon: FluentIcons.color_24_regular,
              label: l10n.petDetailCoatColor,
              value: pet.coatColorName!,
            ),
          if (pet.microchipNumber != null)
            _InfoRow(
              icon: FluentIcons.communication_24_regular,
              label: l10n.petDetailMicrochip,
              value: pet.microchipNumber!,
              trailing: IconButton(
                icon: const Icon(
                  FluentIcons.copy_24_regular,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: pet.microchipNumber!));
                  context.showSuccessSnackBar(context.l10n.microchipCopied);
                },
              ),
            ),
          if (pet.microchipLocation != null)
            _InfoRow(
              icon: FluentIcons.location_24_regular,
              label: l10n.petDetailMicrochipLocation,
              value: pet.microchipLocation!,
            ),
          if (pet.sterilizationStatus != null)
            _InfoRow(
              icon: FluentIcons.heart_pulse_24_regular,
              label: l10n.petDetailSterilization,
              value: _sterilizationLabel(l10n, pet.sterilizationStatus!),
            ),
          if (pet.createdAt != null)
            _InfoRow(
              icon: FluentIcons.calendar_add_24_regular,
              label: l10n.petDetailDateAdded,
              value: dateFmt.format(pet.createdAt!),
              isLast: true,
            ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
    this.isLast = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final Widget? trailing;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(icon, size: 20, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(value, style: AppTextStyles.titleSmall),
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
        ),
        if (!isLast)
          const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.divider,
            indent: AppSpacing.lg + 40 + AppSpacing.md,
            endIndent: AppSpacing.lg,
          ),
      ],
    );
  }
}


// ── Action button ─────────────────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final bg = isPrimary ? AppColors.primary : AppColors.surface;
    final iconColor = isPrimary ? AppColors.onPrimary : AppColors.textSecondary;
    final labelColor = isPrimary ? AppColors.onPrimary : AppColors.textSecondary;

    return Material(
      color: bg,
      borderRadius: AppRadius.mdAll,
      elevation: 0,
      shadowColor: AppColors.textPrimary.withValues(alpha: 0.08),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.mdAll,
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: AppRadius.mdAll,
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 22, color: iconColor),
              const SizedBox(height: AppSpacing.xs),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.labelSmall.copyWith(
                  color: labelColor,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Error widget ─────────────────────────────────────────────────────────────

class _DetailError extends StatelessWidget {
  const _DetailError({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        Expanded(
          child: Text(
            asFailure(error).localizedMessage(l10n),
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
          ),
        ),
        TextButton(onPressed: onRetry, child: Text(l10n.retry)),
      ],
    );
  }
}

// ── Shimmer placeholder ───────────────────────────────────────────────────────

class _ShimmerText extends StatelessWidget {
  const _ShimmerText({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: SkeletonBox(
        width: width,
        height: height,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
    );
  }
}

/// First-load skeleton for the overview info card: a header line + several
/// icon-chip rows, mirroring [_InfoSection]'s layout.
class _InfoSectionSkeleton extends StatelessWidget {
  const _InfoSectionSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: SkeletonCard(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          children: [
            for (var i = 0; i < 6; i++) ...[
              if (i > 0)
                const Divider(height: 1, color: AppColors.divider, indent: 52),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: Row(
                  children: [
                    SkeletonBox(
                      width: 40,
                      height: 40,
                      shape: BoxShape.circle,
                    ),
                    SizedBox(width: AppSpacing.md),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonLine(width: 90, height: 11),
                        SizedBox(height: 6),
                        SkeletonLine(width: 150, height: 13),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
