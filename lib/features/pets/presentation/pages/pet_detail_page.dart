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
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
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

class _PetDetailPageState extends ConsumerState<PetDetailPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
      body: Column(
        children: [
          // Header (scrolls away — wrapped in a scrollable via the overview tab
          // owning its own SingleChildScrollView).
          _PetHeroHeader(
            petId: widget.petId,
            pet: displayed,
            isActive: isActive,
            isDeleting: isDeleting,
            onEdit: () => context.push(AppRoutes.editPetPath(widget.petId)),
            onDelete: displayed != null
                ? () => _confirmDelete(context, displayed)
                : null,
          ),

          // Pinned tab bar.
          _PetTabBar(controller: _tabController),

          // Tab content.
          Expanded(
            child: Stack(
              children: [
                TabBarView(
                  controller: _tabController,
                  children: [
                    _OverviewTab(
                      petId: widget.petId,
                      displayed: displayed,
                      detailAsync: detailAsync,
                    ),
                    const _ComingSoonTab(
                        icon: FluentIcons.heart_pulse_24_regular),
                    const _ComingSoonTab(
                        icon: FluentIcons.clipboard_24_regular),
                    const _ComingSoonTab(
                        icon: FluentIcons.history_24_regular),
                  ],
                ),

                // ── Set as Active sticky button ─────────────────────────
                if (!isActive && displayed != null)
                  Positioned(
                    left: AppSpacing.lg,
                    right: AppSpacing.lg,
                    bottom: MediaQuery.paddingOf(context).bottom +
                        AppSpacing.lg,
                    child: AppButton(
                      label: context.l10n.petDetailSetActive,
                      icon: FluentIcons.checkmark_circle_24_regular,
                      variant: AppButtonVariant.primary,
                      onPressed: () => ref
                          .read(petsProvider.notifier)
                          .selectPet(widget.petId),
                    ),
                  ),
              ],
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
    required this.onDelete,
  });

  final int petId;
  final Pet? pet;
  final bool isActive;
  final bool isDeleting;
  final VoidCallback onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final topPadding = MediaQuery.paddingOf(context).top;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return SizedBox(
      height: 280 + topPadding,
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

          // Pet image — right half.
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: screenWidth * 0.58,
            child: Hero(
              tag: 'pet-image-$petId',
              child: AppCachedImage(
                imageUrl: null,
                height: double.infinity,
                width: double.infinity,
                borderRadius: BorderRadius.zero,
                semanticLabel: pet?.name,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Left-side info.
          Positioned(
            left: AppSpacing.lg,
            right: screenWidth * 0.42,
            bottom: AppSpacing.xl,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Active pill.
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
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.success,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],

                // Name + verified icon.
                if (pet != null) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          pet!.name,
                          style: AppTextStyles.headlineLarge.copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isActive) ...[
                        const SizedBox(width: AppSpacing.xs),
                        const Icon(
                          FluentIcons.checkmark_circle_24_filled,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ],
                    ],
                  ),
                  if (pet!.breedOrSpecies.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      pet!.breedOrSpecies,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ] else
                  const _ShimmerText(width: 100, height: 26),

                const SizedBox(height: AppSpacing.md),

                // Action buttons.
                Row(
                  children: [
                    _ActionButton(
                      icon: FluentIcons.edit_24_regular,
                      label: l10n.petDetailActionEdit,
                      onTap: onEdit,
                      isPrimary: true,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _ActionButton(
                      icon: FluentIcons.calendar_add_24_regular,
                      label: l10n.petDetailActionBook,
                      onTap: () {},
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _ActionButton(
                      icon: FluentIcons.eye_24_regular,
                      label: l10n.petDetailActionShare,
                      onTap: () => context.push(AppRoutes.petVision),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _ActionButton(
                      icon: FluentIcons.more_horizontal_24_regular,
                      label: l10n.petDetailActionMore,
                      onTap: () => _showMoreSheet(context),
                    ),
                  ],
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
              if (onDelete != null)
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

// ── Tab bar ───────────────────────────────────────────────────────────────────

class _PetTabBar extends StatelessWidget {
  const _PetTabBar({required this.controller});

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ColoredBox(
      color: AppColors.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            controller: controller,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            indicatorWeight: 2,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle:
                AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w700),
            unselectedLabelStyle: AppTextStyles.labelMedium,
            tabs: [
              Tab(
                icon: const Icon(FluentIcons.animal_paw_print_24_regular,
                    size: 20),
                text: l10n.petDetailTabOverview,
              ),
              Tab(
                icon: const Icon(FluentIcons.heart_pulse_24_regular, size: 20),
                text: l10n.petDetailTabHealth,
              ),
              Tab(
                icon: const Icon(FluentIcons.clipboard_24_regular, size: 20),
                text: l10n.petDetailTabRecords,
              ),
              Tab(
                icon: const Icon(FluentIcons.history_24_regular, size: 20),
                text: l10n.petDetailTabTimeline,
              ),
            ],
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.divider),
        ],
      ),
    );
  }
}

// ── Overview tab ─────────────────────────────────────────────────────────────

class _OverviewTab extends ConsumerWidget {
  const _OverviewTab({
    required this.petId,
    required this.displayed,
    required this.detailAsync,
  });

  final int petId;
  final Pet? displayed;
  final AsyncValue<Pet?> detailAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        // Extra bottom padding so content isn't hidden under the sticky button.
        MediaQuery.paddingOf(context).bottom + 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (detailAsync.isLoading && displayed == null)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.xxl),
                child: CircularProgressIndicator(),
              ),
            )
          else if (displayed != null) ...[
            _InfoSection(pet: displayed!),
            const SizedBox(height: AppSpacing.md),

            if (detailAsync.isLoading)
              const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),

            if (detailAsync.hasError && detailAsync.value == null)
              _DetailError(
                error: detailAsync.error!,
                onRetry: () => ref.invalidate(petDetailProvider(petId)),
              ),

            const SizedBox(height: AppSpacing.md),

            // "All set" profile completeness card.
            _ProfileCompleteCard(pet: displayed!),
          ],
        ],
      ),
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
                l10n.petDetailAge(pet.ageInYears),
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
          if (pet.pelage != null)
            _InfoRow(
              icon: FluentIcons.color_24_regular,
              label: l10n.petDetailPelage,
              value: pet.pelage!,
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
              value: pet.sterilizationStatus!,
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

// ── Profile complete card ────────────────────────────────────────────────────

class _ProfileCompleteCard extends StatelessWidget {
  const _ProfileCompleteCard({required this.pet});

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.secondarySoft,
        borderRadius: AppRadius.lgAll,
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: const Icon(
              FluentIcons.shield_checkmark_24_filled,
              color: AppColors.onSecondary,
              size: 26,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.petDetailProfileCompleteTitle(pet.name),
                  style: AppTextStyles.titleSmall,
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.petDetailProfileCompleteSubtitle,
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

// ── Coming soon tab ───────────────────────────────────────────────────────────

class _ComingSoonTab extends StatelessWidget {
  const _ComingSoonTab({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: AppColors.divider),
          const SizedBox(height: AppSpacing.md),
          Text(
            context.l10n.comingSoon,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
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
    final fg = isPrimary ? AppColors.onPrimary : AppColors.textSecondary;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: bg,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.textPrimary.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, size: 22, color: fg),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 0,
            ),
          ),
        ],
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
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.divider,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
    );
  }
}
