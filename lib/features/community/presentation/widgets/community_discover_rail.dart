import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../../domain/entities/community_group_entities.dart';
import 'community_card.dart';

/// A "Communities to join" rail for the Discover tab: a titled header (glyph +
/// title + count + chevron) — tapping anywhere on the header opens the full
/// communities directory — over a horizontally-scrolling row of community
/// tiles. No collapse; the carousel is always shown.
class CommunityDiscoverRail extends StatelessWidget {
  const CommunityDiscoverRail({
    required this.communities,
    required this.onOpen,
    required this.onSeeAll,
    super.key,
  });

  final List<CommunityGroup> communities;
  final void Function(CommunityGroup) onOpen;

  /// Opens the full communities directory. Fired by tapping the header.
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    if (communities.isEmpty) return const SizedBox.shrink();
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The whole header is one tap target → opens the directory.
        InkWell(
          onTap: onSeeAll,
          borderRadius: AppRadius.mdAll,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.sm),
            child: Row(
              children: [
                // Community glyph in a soft brand badge.
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: AppColors.secondarySoft,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(FluentIcons.people_community_24_filled,
                      size: 16, color: AppColors.secondaryDark),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(l10n.communitiesDiscoverRailTitle,
                    style: AppTextStyles.titleSmall),
                const SizedBox(width: AppSpacing.xs),
                // Count pill.
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm, vertical: 1),
                  decoration: BoxDecoration(
                    color: AppColors.secondarySoft,
                    borderRadius: AppRadius.lgAll,
                  ),
                  child: Text('${communities.length}',
                      style: AppTextStyles.labelSmall
                          .copyWith(color: AppColors.secondaryDark)),
                ),
                const Spacer(),
                // Chevron affordance signalling the header navigates.
                const Icon(FluentIcons.chevron_right_24_regular,
                    size: 20, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
        // The always-visible carousel.
        Padding(
          padding: const EdgeInsets.only(top: AppSpacing.sm),
          child: SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              itemCount: communities.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
              itemBuilder: (context, i) => _CommunityTile(
                community: communities[i],
                onOpen: () => onOpen(communities[i]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CommunityTile extends StatelessWidget {
  const _CommunityTile({required this.community, required this.onOpen});

  final CommunityGroup community;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Semantics(
      button: true,
      label: community.name,
      child: InkWell(
        onTap: onOpen,
        borderRadius: AppRadius.lgAll,
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.lgAll,
            border: Border.all(color: AppColors.divider),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Cover photo with a teal-ringed avatar badge overlapping its
              // lower-left corner.
              SizedBox(
                height: 72,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: AppCachedImage(
                        imageUrl: community.bannerUrl ?? community.avatarUrl,
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    PositionedDirectional(
                      start: AppSpacing.md,
                      bottom: -16,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: AppColors.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: AppColors.surface, width: 2),
                          ),
                          child: AppAvatar(
                            name: community.name,
                            imageUrl: community.avatarUrl,
                            radius: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      community.name,
                      style: AppTextStyles.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.communityMembersCount(community.memberCount),
                      style: AppTextStyles.labelSmall
                          .copyWith(color: AppColors.secondary),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      (community.description ?? '').isNotEmpty
                          ? community.description!
                          : ' ',
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        _MemberPile(community: community),
                        const Spacer(),
                        CommunityJoinButton(community: community),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
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

/// A small stacked avatar pile: the lead pet's avatar plus a "+N" bubble for
/// the remaining members. (The API sends only memberCount + the lead, so the
/// extra faces are represented by the count bubble.)
class _MemberPile extends StatelessWidget {
  const _MemberPile({required this.community});

  final CommunityGroup community;

  @override
  Widget build(BuildContext context) {
    final others = community.memberCount - 1;
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.surface, width: 2),
          ),
          child: AppAvatar(
            name: community.lead.name,
            imageUrl: community.lead.avatarUrl,
            radius: 12,
          ),
        ),
        if (others > 0)
          Transform.translate(
            offset: const Offset(-8, 0),
            child: Container(
              width: 26,
              height: 26,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surface, width: 2),
              ),
              child: Text(
                '+$others',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.onSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
