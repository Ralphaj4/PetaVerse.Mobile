import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../domain/entities/community_group_entities.dart';
import '../providers/community_group_actions_providers.dart';
import 'community_common.dart';

/// A directory row for one [CommunityGroup]: avatar, name, category + member
/// count, and a Join / Joined pill. Tapping the body opens the community.
class CommunityCard extends ConsumerWidget {
  const CommunityCard({
    required this.community,
    required this.onOpen,
    super.key,
  });

  final CommunityGroup community;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final subtitle =
        '${community.category.label(l10n)} · ${l10n.communityMembersCount(community.memberCount)}';

    return Semantics(
      button: true,
      label: community.name,
      child: Material(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        child: InkWell(
          onTap: onOpen,
          borderRadius: AppRadius.lgAll,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                AppAvatar(
                  name: community.name,
                  imageUrl: community.avatarUrl,
                  radius: 28,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
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
                        subtitle,
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.textSecondary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                CommunityJoinButton(community: community),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The Join / Joined toggle used on cards and the discover rail. The lead can't
/// leave from here (they manage on the detail page), so it shows a static
/// "Lead" state instead of a toggle.
class CommunityJoinButton extends ConsumerStatefulWidget {
  const CommunityJoinButton({required this.community, super.key});

  final CommunityGroup community;

  @override
  ConsumerState<CommunityJoinButton> createState() =>
      _CommunityJoinButtonState();
}

class _CommunityJoinButtonState extends ConsumerState<CommunityJoinButton> {
  bool _busy = false;

  Future<void> _toggle() async {
    if (_busy) return;
    setState(() => _busy = true);
    unawaited(HapticFeedback.selectionClick());
    final actions = ref.read(communityGroupActionsProvider);
    if (widget.community.isMember) {
      await actions.leave(widget.community);
    } else {
      await actions.join(widget.community);
    }
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final community = widget.community;

    if (community.isLead) {
      return const _LeadBadge();
    }

    final joined = community.isMember;
    // Built from Material + InkWell + a mainAxisSize.min Row (not a
    // Material button) so it sizes to its content and never asserts under an
    // unbounded-width parent (e.g. a Row that measures intrinsic width).
    final fg = joined ? AppColors.textSecondary : AppColors.onPrimary;
    return Material(
      color: joined ? Colors.transparent : AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.smAll,
        side: joined
            ? const BorderSide(color: AppColors.divider)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: _busy ? null : _toggle,
        borderRadius: AppRadius.smAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_busy)
                SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(strokeWidth: 2, color: fg),
                )
              else
                Text(
                  joined ? l10n.communityJoined : l10n.communityJoin,
                  style: AppTextStyles.labelMedium.copyWith(color: fg),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LeadBadge extends StatelessWidget {
  const _LeadBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: AppRadius.smAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(FluentIcons.star_24_filled,
              size: 12, color: AppColors.primaryDark),
          const SizedBox(width: 4),
          Text(
            context.l10n.communityLeadBadge,
            style: AppTextStyles.labelSmall
                .copyWith(color: AppColors.primaryDark),
          ),
        ],
      ),
    );
  }
}
