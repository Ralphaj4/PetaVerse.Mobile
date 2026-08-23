import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../domain/entities/adoption_listing.dart';
import '../providers/adoption_providers.dart';
import '../widgets/adoption_card.dart';
import '../widgets/adoption_format.dart';
import '../widgets/adoption_status_badge.dart';

/// Full details for a single adoption listing, fetched by id and seeded
/// instantly from the tapped [initialListing] (so the screen is never blank and
/// the photo animates via [Hero]).
///
/// The primary action is state-adaptive: the lister sees "Manage applicants",
/// an already-applied user sees a disabled "Applied", a closed listing shows a
/// muted status, and everyone else sees "Apply to adopt" (the first half of the
/// two-sided confirm handshake).
class AdoptionListingDetailPage extends ConsumerStatefulWidget {
  const AdoptionListingDetailPage({
    required this.listingId,
    this.initialListing,
    super.key,
  });

  final int listingId;
  final AdoptionListing? initialListing;

  @override
  ConsumerState<AdoptionListingDetailPage> createState() =>
      _AdoptionListingDetailPageState();
}

class _AdoptionListingDetailPageState
    extends ConsumerState<AdoptionListingDetailPage> {
  bool _applying = false;
  bool _deleting = false;

  /// Optimistic "applied" flag set after a successful apply, so the CTA flips
  /// immediately without waiting for a board refetch.
  bool _appliedOverride = false;

  Future<void> _apply(AdoptionListing listing) async {
    final l10n = context.l10n;
    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.heart_24_regular,
      title: l10n.adoptionApplyConfirmTitle(listing.pet.name),
      message: l10n.adoptionApplyConfirmMessage,
      confirmLabel: l10n.adoptionApply,
      cancelLabel: l10n.cancel,
    );
    if (!confirmed || !mounted) return;

    setState(() => _applying = true);
    final result =
        await ref.read(adoptionRepositoryProvider).apply(listing.id);
    if (!mounted) return;
    setState(() => _applying = false);

    result.when(
      success: (_) {
        setState(() => _appliedOverride = true);
        // Refresh the board + my-requests so both reflect the new application.
        ref.read(adoptionListingsProvider.notifier).refresh();
        ref.invalidate(myAdoptionRequestsProvider);
        context.showSuccessSnackBar(l10n.adoptionApplySuccess);
      },
      failure: (f) => context.showErrorSnackBar(
        f.localizedMessage(l10n),
      ),
    );
  }

  void _manage(AdoptionListing listing) {
    context.push(
      AppRoutes.adoptionManagePath(listing.id),
      extra: listing,
    );
  }

  /// Hard-delete this listing (and all its applicant requests). Irreversible;
  /// confirm first, surfacing the applicant count so the owner sees the impact.
  Future<void> _delete(AdoptionListing listing) async {
    final l10n = context.l10n;
    final count = listing.applicantCount;
    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.delete_24_regular,
      title: l10n.adoptionDeleteConfirmTitle,
      message: count > 0
          ? l10n.adoptionDeleteConfirmMessageWithApplicants(
              listing.pet.name,
              count,
            )
          : l10n.adoptionDeleteConfirmMessage(listing.pet.name),
      confirmLabel: l10n.adoptionDelete,
      cancelLabel: l10n.cancel,
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;

    setState(() => _deleting = true);
    final result =
        await ref.read(adoptionRepositoryProvider).deleteListing(listing.id);
    if (!mounted) return;
    setState(() => _deleting = false);

    result.when(
      success: (_) {
        // Drop it from "my listings" optimistically and refresh the board, then
        // leave this now-defunct detail screen.
        ref.read(myAdoptionListingsProvider.notifier).remove(listing.id);
        ref.read(adoptionListingsProvider.notifier).refresh();
        context.showSuccessSnackBar(l10n.adoptionDeleteSuccess);
        context.pop();
      },
      failure: (f) => context.showErrorSnackBar(
        f.localizedMessage(l10n),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(adoptionListingProvider(widget.listingId));
    // Prefer the freshly-loaded listing; fall back to the tapped one so the
    // header renders instantly and on error.
    final listing = async.value ?? widget.initialListing;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: listing == null
            ? _LoadingOrError(
                isError: async.hasError,
                onRetry: () =>
                    ref.invalidate(adoptionListingProvider(widget.listingId)),
              )
            : _Content(
                listing: listing,
                applied: listing.hasApplied || _appliedOverride,
                applying: _applying,
                deleting: _deleting,
                onApply: () => _apply(listing),
                onManage: () => _manage(listing),
                onDelete: () => _delete(listing),
              ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.listing,
    required this.applied,
    required this.applying,
    required this.deleting,
    required this.onApply,
    required this.onManage,
    required this.onDelete,
  });

  final AdoptionListing listing;
  final bool applied;
  final bool applying;
  final bool deleting;
  final VoidCallback onApply;
  final VoidCallback onManage;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: adoptionHeroTag(listing.id),
                child: AppCachedImage(
                  imageUrl: listing.pet.avatarUrl,
                  height: 300,
                  width: double.infinity,
                  borderRadius: BorderRadius.zero,
                  semanticLabel: listing.pet.name,
                ),
              ),
              _Body(
                listing: listing,
                applied: applied,
                applying: applying,
                deleting: deleting,
                onApply: onApply,
                onManage: onManage,
                onDelete: onDelete,
              ),
            ],
          ),
        ),
        // Floating back button over the photo.
        PositionedDirectional(
          top: 0,
          start: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: _CircleIconButton(
                icon: context.isRtl
                    ? FluentIcons.arrow_right_24_regular
                    : FluentIcons.arrow_left_24_regular,
                tooltip: context.l10n.close,
                onTap: () => context.pop(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.listing,
    required this.applied,
    required this.applying,
    required this.deleting,
    required this.onApply,
    required this.onManage,
    required this.onDelete,
  });

  final AdoptionListing listing;
  final bool applied;
  final bool applying;
  final bool deleting;
  final VoidCallback onApply;
  final VoidCallback onManage;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final now = DateTime.now();
    final pet = listing.pet;

    return Container(
      transform: Matrix4.translationValues(0, -(AppRadius.lg + 4), 0),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppRadius.lg + 4)),
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AdoptionStatusBadge(status: listing.status),
              const Spacer(),
              Text(
                AdoptionFormat.postedAgo(l10n, listing.createdAt, now: now),
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  pet.name,
                  style: AppTextStyles.displayLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (pet.breedLabel.isNotEmpty) ...[
                const SizedBox(width: AppSpacing.md),
                _BreedPill(label: pet.breedLabel),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Facts grid: species, age, sex ────────────────────────────────
          _FactsGrid(listing: listing, now: now),
          const SizedBox(height: AppSpacing.lg),

          // ── Trait chips ──────────────────────────────────────────────────
          if (listing.vaccinated ||
              listing.neutered ||
              listing.goodWithKids) ...[
            _TraitWrap(listing: listing),
            const SizedBox(height: AppSpacing.lg),
          ],

          // ── About ────────────────────────────────────────────────────────
          if (listing.description != null &&
              listing.description!.isNotEmpty) ...[
            Text(l10n.adoptionAboutTitle, style: AppTextStyles.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(
              listing.description!,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary, height: 1.5),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],

          // ── Location ─────────────────────────────────────────────────────
          if (listing.locationLabel != null &&
              listing.locationLabel!.isNotEmpty) ...[
            Row(
              children: [
                const Icon(FluentIcons.location_24_regular,
                    size: 18, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(listing.locationLabel!,
                      style: AppTextStyles.bodyMedium),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
          ],

          // ── Lister card ──────────────────────────────────────────────────
          _ListerCard(lister: listing.lister),
          const SizedBox(height: AppSpacing.xl),

          // ── Primary action ───────────────────────────────────────────────
          _PrimaryAction(
            listing: listing,
            applied: applied,
            applying: applying,
            onApply: onApply,
            onManage: onManage,
          ),
          // A note on how the transfer works (sets expectations for the
          // two-sided confirm handshake before the user commits).
          if (listing.isAvailable && !listing.isOwnListing && !applied) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.adoptionTransferNote,
              style: AppTextStyles.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],

          // ── Owner-only: delete the listing (low-emphasis, destructive) ────
          // Allowed any time before the adoption completes; once Adopted the
          // backend blocks it (409), so it's hidden then.
          if (listing.isOwnListing &&
              listing.status != AdoptionListingStatus.adopted) ...[
            const SizedBox(height: AppSpacing.sm),
            _DeleteButton(deleting: deleting, onDelete: onDelete),
          ],
        ],
      ),
    );
  }
}

/// The state-adaptive bottom action button.
class _PrimaryAction extends StatelessWidget {
  const _PrimaryAction({
    required this.listing,
    required this.applied,
    required this.applying,
    required this.onApply,
    required this.onManage,
  });

  final AdoptionListing listing;
  final bool applied;
  final bool applying;
  final VoidCallback onApply;
  final VoidCallback onManage;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (listing.isOwnListing) {
      return AppButton(
        label: l10n.adoptionManageCount(listing.applicantCount),
        icon: FluentIcons.people_settings_24_regular,
        variant: AppButtonVariant.primary,
        onPressed: onManage,
      );
    }

    if (!listing.isAvailable) {
      return AppButton(
        label: listing.status == AdoptionListingStatus.adopted
            ? l10n.adoptionStatusAdopted
            : l10n.adoptionStatusUnavailable,
        icon: FluentIcons.info_24_regular,
        variant: AppButtonVariant.outlined,
        onPressed: null,
      );
    }

    if (applied) {
      return const _AppliedConfirmation();
    }

    return AppButton(
      label: l10n.adoptionApply,
      icon: FluentIcons.heart_24_regular,
      variant: AppButtonVariant.secondary,
      isLoading: applying,
      onPressed: onApply,
    );
  }
}

/// Success confirmation shown once the user has applied. A soft-green banner
/// with a filled check and a review-pending subtitle — a positive "done" state
/// rather than a greyed-out disabled button.
class _AppliedConfirmation extends StatelessWidget {
  const _AppliedConfirmation();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      // A little breathing room above so the banner isn't clipped by the
      // content spacing that sat above the shorter button it replaced.
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Semantics(
        label: l10n.adoptionApplied,
        container: true,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.12),
          borderRadius: AppRadius.mdAll,
          border: Border.all(
            color: AppColors.success.withValues(alpha: 0.35),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              FluentIcons.checkmark_circle_24_filled,
              color: AppColors.success,
              size: 24,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.adoptionApplied,
                    style: AppTextStyles.titleSmall
                        .copyWith(color: AppColors.success),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.adoptionAppliedSubtitle,
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}

/// Low-emphasis destructive action to permanently delete the owner's listing.
/// A full-width text button so it's reachable but visually subordinate to the
/// primary "Manage applicants" action above it.
class _DeleteButton extends StatelessWidget {
  const _DeleteButton({required this.deleting, required this.onDelete});

  final bool deleting;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: deleting ? null : onDelete,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.error,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        ),
        icon: deleting
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.error,
                ),
              )
            : const Icon(FluentIcons.delete_24_regular, size: 18),
        label: Text(l10n.adoptionDelete, style: AppTextStyles.labelLarge),
      ),
    );
  }
}

/// Grid of key facts (species / age / sex) — only the ones we know.
class _FactsGrid extends StatelessWidget {
  const _FactsGrid({required this.listing, required this.now});

  final AdoptionListing listing;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pet = listing.pet;
    final ageLabel = AdoptionFormat.age(l10n, pet.dateOfBirth, now: now);
    final sexLabel = AdoptionFormat.sex(l10n, pet.gender);

    final facts = <(SpeciesGlyph, String, String)>[
      if (pet.speciesName != null && pet.speciesName!.isNotEmpty)
        (
          AdoptionFormat.speciesIcon(pet.speciesName),
          l10n.adoptionFactSpecies,
          pet.speciesName!,
        ),
      if (ageLabel != null)
        (
          const SpeciesGlyph.icon(FluentIcons.calendar_24_regular),
          l10n.adoptionFactAge,
          ageLabel,
        ),
      if (sexLabel != null)
        (
          const SpeciesGlyph.icon(FluentIcons.animal_paw_print_24_regular),
          l10n.adoptionFactSex,
          sexLabel,
        ),
    ];

    if (facts.isEmpty) return const SizedBox.shrink();

    final tileWidth =
        (MediaQuery.sizeOf(context).width - AppSpacing.xl * 2 - AppSpacing.md) /
            2;

    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: [
        for (final f in facts)
          SizedBox(
            width: tileWidth,
            child: _FactTile(icon: f.$1, label: f.$2, value: f.$3),
          ),
      ],
    );
  }
}

class _FactTile extends StatelessWidget {
  const _FactTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final SpeciesGlyph icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          SpeciesGlyphIcon(glyph: icon, size: 20, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.labelSmall),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: AppTextStyles.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TraitWrap extends StatelessWidget {
  const _TraitWrap({required this.listing});

  final AdoptionListing listing;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        if (listing.vaccinated)
          _TraitPill(
            icon: FluentIcons.shield_checkmark_24_filled,
            label: l10n.adoptionTraitVaccinated,
          ),
        if (listing.neutered)
          _TraitPill(
            icon: FluentIcons.heart_24_filled,
            label: l10n.adoptionTraitNeutered,
          ),
        if (listing.goodWithKids)
          _TraitPill(
            icon: FluentIcons.people_24_filled,
            label: l10n.adoptionTraitGoodWithKids,
          ),
      ],
    );
  }
}

class _TraitPill extends StatelessWidget {
  const _TraitPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.secondarySoft,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: AppColors.secondaryDark),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.labelMedium
                .copyWith(color: AppColors.secondaryDark, letterSpacing: 0),
          ),
        ],
      ),
    );
  }
}

class _ListerCard extends StatelessWidget {
  const _ListerCard({required this.lister});

  final AdoptionUser lister;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          AppAvatar(
            imageUrl: lister.avatarUrl,
            name: lister.fullName,
            radius: 22,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.adoptionPostedBy, style: AppTextStyles.labelSmall),
                const SizedBox(height: 2),
                Text(
                  lister.fullName,
                  style: AppTextStyles.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(FluentIcons.shield_checkmark_24_filled,
              size: 18, color: AppColors.secondary),
        ],
      ),
    );
  }
}

class _BreedPill extends StatelessWidget {
  const _BreedPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(FluentIcons.animal_paw_print_20_filled,
              size: 18, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              label,
              style: AppTextStyles.titleSmall
                  .copyWith(color: AppColors.primaryDark),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(),
      elevation: 2,
      child: IconButton(
        onPressed: onTap,
        tooltip: tooltip,
        icon: Icon(icon, color: AppColors.textPrimary),
      ),
    );
  }
}

/// Shown only when there's neither a loaded listing nor a seed: a spinner while
/// loading, or a retry affordance on error.
class _LoadingOrError extends StatelessWidget {
  const _LoadingOrError({required this.isError, required this.onRetry});

  final bool isError;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (!isError) {
      return const Center(child: CircularProgressIndicator());
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.errorUnknown,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
                textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.md),
            AppButton(
              label: l10n.retry,
              icon: FluentIcons.arrow_clockwise_24_regular,
              variant: AppButtonVariant.outlined,
              expanded: false,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
