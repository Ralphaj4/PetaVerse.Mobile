import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// A small chip shown on a post card when the post belongs to a community.
/// Tapping it opens that community's detail page.
class CommunityPostBadge extends StatelessWidget {
  const CommunityPostBadge({
    required this.communityId,
    required this.communityName,
    super.key,
  });

  final int communityId;
  final String communityName;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: communityName,
      child: InkWell(
        onTap: () => context.push('/community/communities/$communityId'),
        borderRadius: AppRadius.smAll,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.secondarySoft,
            borderRadius: AppRadius.smAll,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(FluentIcons.people_community_16_filled,
                  size: 13, color: AppColors.secondaryDark),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  communityName,
                  style: AppTextStyles.labelSmall
                      .copyWith(color: AppColors.secondaryDark),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
