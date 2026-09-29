import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../../../../shared/widgets/shimmer.dart';
import '../models/pawhub_models.dart';
import 'pawhub_common.dart';

/// Following / Discover segmented control for the feed top bar.
enum FeedTab { following, discover }

/// The Following / Discover tab selector: two large rounded pill buttons.
/// The active tab is orange-outlined (orange icon + label); the inactive one is
/// grey-outlined. Following shows an orange unread dot when fresh posts have
/// arrived. Designed to sit in a Row and share the available width evenly.
class FeedTabToggle extends StatelessWidget {
  const FeedTabToggle({
    required this.tab,
    required this.onChanged,
    this.followingHasUpdates = false,
    super.key,
  });

  final FeedTab tab;
  final ValueChanged<FeedTab> onChanged;

  /// Shows an orange dot on the Following pill when new posts are available.
  final bool followingHasUpdates;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _pill(
            label: context.l10n.pawHubFeedTabFollowing,
            icon: FluentIcons.bookmark_24_regular,
            value: FeedTab.following,
            showDot: followingHasUpdates,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _pill(
            label: context.l10n.pawHubFeedTabDiscover,
            icon: FluentIcons.compass_northwest_24_regular,
            value: FeedTab.discover,
            showDot: false,
          ),
        ),
      ],
    );
  }

  Widget _pill({
    required String label,
    required IconData icon,
    required FeedTab value,
    required bool showDot,
  }) {
    final selected = tab == value;
    final fg = selected ? AppColors.primaryDark : AppColors.textSecondary;
    return Material(
      color: selected ? AppColors.primarySoft : AppColors.surface,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: () => onChanged(value),
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.divider,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: fg),
              const SizedBox(width: AppSpacing.xs),
              Text(
                label,
                style: AppTextStyles.labelLarge.copyWith(
                  color: fg,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
              if (showDot) ...[
                const SizedBox(width: AppSpacing.xs),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// The "↑ new paw-sts" floating pill shown when fresh content arrives above.
class NewPostsPill extends StatelessWidget {
  const NewPostsPill({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(50),
        elevation: 4,
        shadowColor: AppColors.primary.withValues(alpha: 0.4),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(FluentIcons.arrow_up_24_filled,
                    size: 16, color: AppColors.onPrimary),
                const SizedBox(width: AppSpacing.xs),
                Text(context.l10n.pawHubNewPosts,
                    style: const TextStyle(
                        color: AppColors.onPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 13)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A Lost & Found alert injected into the feed — distinct accent styling.
class AlertCard extends StatelessWidget {
  const AlertCard({required this.alert, required this.onView, super.key});

  final PawAlert alert;
  final VoidCallback onView;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.error.withValues(alpha: 0.4)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: AppColors.error.withValues(alpha: 0.1),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                const Icon(FluentIcons.alert_urgent_24_filled,
                    size: 16, color: AppColors.error),
                const SizedBox(width: AppSpacing.xs),
                Text(context.l10n.pawHubLostPetNearby,
                    style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.error, fontWeight: FontWeight.w800)),
                const Spacer(),
                Text(alert.timeAgo,
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.error)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: AppRadius.mdAll,
                  child: AppCachedImage(
                    imageUrl: alert.imageUrl,
                    width: 64,
                    height: 64,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${alert.petName} · ${alert.breed}',
                          style: AppTextStyles.titleSmall),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(FluentIcons.location_24_filled,
                              size: 13, color: AppColors.textSecondary),
                          const SizedBox(width: 3),
                          Text(alert.distanceLabel,
                              style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textSecondary)),
                          if (alert.reward != null) ...[
                            const SizedBox(width: AppSpacing.sm),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 1),
                              decoration: BoxDecoration(
                                color: AppColors.success.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                  context.l10n
                                      .pawhubAlertReward(alert.reward!),
                                  style: AppTextStyles.labelSmall.copyWith(
                                      color: AppColors.success)),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.md, 0, AppSpacing.md, AppSpacing.md),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onView,
                icon: const Icon(FluentIcons.map_24_regular, size: 18),
                label: Text(context.l10n.pawHubViewOnMap),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side: BorderSide(
                      color: AppColors.error.withValues(alpha: 0.4)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Horizontal "Suggested pets to follow" carousel, injected into the feed.
class SuggestedPetsRail extends StatelessWidget {
  const SuggestedPetsRail({
    required this.pets,
    required this.onToggleFollow,
    required this.onOpenProfile,
    super.key,
  });

  final List<PawPet> pets;
  final void Function(PawPet pet) onToggleFollow;
  final void Function(PawPet pet) onOpenProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              children: [
                const Icon(FluentIcons.sparkle_24_filled,
                    size: 18, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Text(context.l10n.pawHubSuggestedPets,
                    style: AppTextStyles.titleSmall),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 176,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              itemCount: pets.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(width: AppSpacing.sm),
              itemBuilder: (_, i) => _SuggestedCard(
                pet: pets[i],
                onToggleFollow: () => onToggleFollow(pets[i]),
                onOpenProfile: () => onOpenProfile(pets[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuggestedCard extends StatelessWidget {
  const _SuggestedCard({
    required this.pet,
    required this.onToggleFollow,
    required this.onOpenProfile,
  });

  final PawPet pet;
  final VoidCallback onToggleFollow;
  final VoidCallback onOpenProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 136,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.mdAll,
      ),
      child: Column(
        children: [
          Semantics(
            button: true,
            label: context.l10n.pawhubViewProfile,
            child: GestureDetector(
              onTap: onOpenProfile,
              child: AppAvatar(name: pet.name, imageUrl: pet.avatarUrl, radius: 30),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(pet.name,
                    style: AppTextStyles.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
              if (pet.isVerified) ...[
                const SizedBox(width: 3),
                const VerifiedBadge(size: 12),
              ],
            ],
          ),
          Text(pet.breedOrSpecies,
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textSecondary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            width: double.infinity,
            height: 30,
            child: _FollowButton(
              following: pet.isFollowing,
              onTap: onToggleFollow,
            ),
          ),
        ],
      ),
    );
  }
}

/// A compact follow / following toggle button.
class _FollowButton extends StatelessWidget {
  const _FollowButton({required this.following, required this.onTap});

  final bool following;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: following ? AppColors.background : AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: following
            ? const BorderSide(color: AppColors.divider)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Center(
          child: Text(
            following ? context.l10n.pawHubFollowing : context.l10n.pawHubFollow,
            style: AppTextStyles.labelMedium.copyWith(
              color: following ? AppColors.textSecondary : AppColors.onPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

/// Public follow button reused on the pet profile.
class FollowButton extends StatelessWidget {
  const FollowButton({
    required this.following,
    required this.onTap,
    this.expanded = false,
    super.key,
  });

  final bool following;
  final VoidCallback onTap;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final btn = _FollowButton(following: following, onTap: onTap);
    return SizedBox(height: 36, width: expanded ? double.infinity : 120, child: btn);
  }
}

/// A single shimmering post-card skeleton.
class PostCardSkeleton extends StatelessWidget {
  const PostCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Shimmer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.lg)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  SkeletonBox(width: 40, height: 40, shape: BoxShape.circle),
                  SizedBox(width: AppSpacing.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SkeletonLine(width: 120, height: 13),
                      SizedBox(height: 6),
                      SkeletonLine(width: 80, height: 11),
                    ],
                  ),
                ],
              ),
            ),
            AspectRatio(
              aspectRatio: 4 / 5,
              child: SkeletonBox(borderRadius: BorderRadius.zero),
            ),
            Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonLine(width: 140, height: 12),
                  SizedBox(height: 8),
                  SkeletonLine(width: 220, height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Empty state for the Following feed (no follows yet).
class FeedEmptyState extends StatelessWidget {
  const FeedEmptyState({
    this.onDiscover,
    this.title,
    this.message,
    super.key,
  });

  /// Optional "Discover pets" CTA. Null hides the button (e.g. on the Discover
  /// tab itself, where the CTA would be redundant).
  final VoidCallback? onDiscover;

  /// Copy overrides — default to the Following-feed wording.
  final String? title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: const BoxDecoration(
                color: AppColors.primarySoft,
                shape: BoxShape.circle,
              ),
              child: const Icon(FluentIcons.animal_paw_print_24_filled,
                  size: 44, color: AppColors.primary),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(title ?? context.l10n.pawHubFeedEmptyTitle,
                style: AppTextStyles.titleMedium, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.xs),
            Text(
              message ?? context.l10n.pawHubFeedEmptyDescription,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            if (onDiscover != null) ...[
              const SizedBox(height: AppSpacing.lg),
              FilledButton.icon(
                onPressed: onDiscover,
                icon: const Icon(FluentIcons.compass_northwest_24_regular,
                    size: 18),
                label: Text(context.l10n.pawHubDiscoverPets),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
