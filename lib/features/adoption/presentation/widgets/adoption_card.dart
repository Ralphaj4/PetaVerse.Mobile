import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../../domain/entities/adoption_listing.dart';
import 'adoption_format.dart';
import 'adoption_status_badge.dart';

/// Hero tag shared between a card's photo and the detail page's photo, so the
/// image animates between the board and the details screen.
String adoptionHeroTag(int listingId) => 'adoption-photo-$listingId';

/// Board card for a single adoption listing — photo, status badge, name/breed,
/// a meta line (species · sex · age), trait chips, location, and a
/// state-adaptive action (Apply / Applied / Manage / Closed).
class AdoptionCard extends StatelessWidget {
  const AdoptionCard({
    required this.listing,
    required this.now,
    this.onTap,
    this.onApply,
    this.onManage,
    super.key,
  });

  final AdoptionListing listing;

  /// Injected clock so "posted N ago" / age are deterministic and testable.
  final DateTime now;

  final VoidCallback? onTap;
  final VoidCallback? onApply;
  final VoidCallback? onManage;

  @override
  Widget build(BuildContext context) {
    final closed = !listing.isAvailable;

    return Semantics(
      button: true,
      label: listing.pet.name,
      child: Opacity(
        // De-emphasise pending/adopted/withdrawn listings without hiding them.
        opacity: closed ? 0.7 : 1,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.lgAll,
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Photo(listing: listing, now: now),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _NameRow(pet: listing.pet),
                        const SizedBox(height: AppSpacing.xs),
                        _MetaLine(listing: listing, now: now),
                        if (listing.locationLabel != null &&
                            listing.locationLabel!.isNotEmpty) ...[
                          const SizedBox(height: AppSpacing.sm),
                          Row(
                            children: [
                              const Icon(
                                FluentIcons.location_24_regular,
                                size: 14,
                                color: AppColors.textTertiary,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  listing.locationLabel!,
                                  style: AppTextStyles.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (listing.vaccinated ||
                            listing.neutered ||
                            listing.goodWithKids) ...[
                          const SizedBox(height: AppSpacing.sm),
                          _TraitChips(listing: listing),
                        ],
                        const SizedBox(height: AppSpacing.md),
                        _ActionRow(
                          listing: listing,
                          onApply: onApply,
                          onManage: onManage,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({required this.listing, required this.now});

  final AdoptionListing listing;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Stack(
      children: [
        Hero(
          tag: adoptionHeroTag(listing.id),
          child: AppCachedImage(
            imageUrl: listing.pet.avatarUrl,
            height: 180,
            width: double.infinity,
            borderRadius: BorderRadius.zero,
            semanticLabel: listing.pet.name,
          ),
        ),
        PositionedDirectional(
          top: AppSpacing.md,
          start: AppSpacing.md,
          child: AdoptionStatusBadge(status: listing.status),
        ),
        PositionedDirectional(
          top: AppSpacing.md,
          end: AppSpacing.md,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: AppColors.textPrimary.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(AppSpacing.xs),
            ),
            child: Text(
              AdoptionFormat.postedAgo(l10n, listing.createdAt, now: now),
              style: AppTextStyles.labelSmall.copyWith(color: AppColors.surface),
            ),
          ),
        ),
        if (listing.isShelter)
          PositionedDirectional(
            bottom: AppSpacing.md,
            start: AppSpacing.md,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(FluentIcons.home_24_filled,
                      size: 13, color: AppColors.onSecondary),
                  const SizedBox(width: 4),
                  Text(
                    l10n.adoptionShelterBadge,
                    style: AppTextStyles.labelSmall
                        .copyWith(color: AppColors.onSecondary),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _NameRow extends StatelessWidget {
  const _NameRow({required this.pet});

  final AdoptionPet pet;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            pet.name,
            style: AppTextStyles.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (pet.breedLabel.isNotEmpty) ...[
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              pet.breedLabel,
              style: AppTextStyles.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ],
    );
  }
}

/// Species · sex · age, separated by dots. Skips parts that are unknown.
class _MetaLine extends StatelessWidget {
  const _MetaLine({required this.listing, required this.now});

  final AdoptionListing listing;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pet = listing.pet;
    final parts = <String>[
      ?pet.speciesName,
      ?AdoptionFormat.sex(l10n, pet.gender),
      ?AdoptionFormat.age(l10n, pet.dateOfBirth, now: now),
    ];
    if (parts.isEmpty) return const SizedBox.shrink();

    return Text(
      parts.join('  ·  '),
      style: AppTextStyles.labelMedium.copyWith(
        color: AppColors.secondaryDark,
        letterSpacing: 0,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _TraitChips extends StatelessWidget {
  const _TraitChips({required this.listing});

  final AdoptionListing listing;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.xs,
      children: [
        if (listing.vaccinated)
          _Chip(
            icon: FluentIcons.shield_checkmark_24_filled,
            label: l10n.adoptionTraitVaccinated,
          ),
        if (listing.neutered)
          _Chip(
            icon: FluentIcons.heart_24_filled,
            label: l10n.adoptionTraitNeutered,
          ),
        if (listing.goodWithKids)
          _Chip(
            icon: FluentIcons.people_24_filled,
            label: l10n.adoptionTraitGoodWithKids,
          ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.secondarySoft,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.secondaryDark),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.secondaryDark,
            ),
          ),
        ],
      ),
    );
  }
}

/// State-adaptive action: the lister sees "Manage (N)", an applicant who's
/// already applied sees a disabled "Applied" pill, a closed listing shows a
/// muted status, and everyone else sees the "Apply to adopt" CTA.
class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.listing,
    required this.onApply,
    required this.onManage,
  });

  final AdoptionListing listing;
  final VoidCallback? onApply;
  final VoidCallback? onManage;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (listing.isOwnListing) {
      return _FilledAction(
        icon: FluentIcons.people_settings_24_regular,
        label: l10n.adoptionManageCount(listing.applicantCount),
        onPressed: onManage,
        background: AppColors.primary,
        foreground: AppColors.onPrimary,
      );
    }

    if (!listing.isAvailable) {
      return _FilledAction(
        icon: FluentIcons.info_24_regular,
        label: listing.status == AdoptionListingStatus.adopted
            ? l10n.adoptionStatusAdopted
            : l10n.adoptionStatusUnavailable,
        onPressed: null,
        background: AppColors.background,
        foreground: AppColors.textTertiary,
      );
    }

    if (listing.hasApplied) {
      return _FilledAction(
        icon: FluentIcons.checkmark_circle_24_filled,
        label: l10n.adoptionApplied,
        onPressed: null,
        background: AppColors.secondarySoft,
        foreground: AppColors.secondaryDark,
      );
    }

    return _FilledAction(
      icon: FluentIcons.heart_24_regular,
      label: l10n.adoptionApply,
      onPressed: onApply,
      background: AppColors.secondary,
      foreground: AppColors.onSecondary,
    );
  }
}

class _FilledAction extends StatelessWidget {
  const _FilledAction({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.background,
    required this.foreground,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: FilledButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          disabledBackgroundColor: background,
          disabledForegroundColor: foreground,
          textStyle: AppTextStyles.titleSmall,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.smAll),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        ),
      ),
    );
  }
}
