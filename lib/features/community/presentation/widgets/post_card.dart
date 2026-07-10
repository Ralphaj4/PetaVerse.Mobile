import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/pawhub_models.dart';
import 'pawhub_common.dart';
import 'pawhub_media.dart';

/// The main feed post card. Fully self-contained interactivity: like (tap +
/// double-tap paw burst), save, comment, share, options, caption expand,
/// media carousel + zoom. All callbacks bubble up so the page can react
/// (open comments sheet, open options sheet, open viewer, open profile).
class PostCard extends StatefulWidget {
  const PostCard({
    required this.post,
    required this.onOpenComments,
    required this.onOpenOptions,
    required this.onOpenProfile,
    required this.onShare,
    super.key,
  });

  final PawPost post;
  final VoidCallback onOpenComments;
  final VoidCallback onOpenOptions;
  final void Function(PawPet pet) onOpenProfile;
  final VoidCallback onShare;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard>
    with SingleTickerProviderStateMixin {
  bool _captionExpanded = false;

  late final AnimationController _likePop = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 280),
    lowerBound: 0.85,
    upperBound: 1.0,
    value: 1,
  );

  @override
  void dispose() {
    _likePop.dispose();
    super.dispose();
  }

  PawPost get post => widget.post;

  void _toggleLike() {
    setState(() {
      post.likedByMe = !post.likedByMe;
      post.likes += post.likedByMe ? 1 : -1;
    });
    if (post.likedByMe) {
      _likePop.forward(from: 0.85);
      HapticFeedback.lightImpact();
    }
  }

  void _doubleTapLike() {
    if (!post.likedByMe) {
      setState(() {
        post.likedByMe = true;
        post.likes += 1;
      });
      _likePop.forward(from: 0.85);
      HapticFeedback.lightImpact();
    }
  }

  void _toggleSave() {
    setState(() => post.saved = !post.saved);
    HapticFeedback.selectionClick();
  }

  void _openViewer(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) =>
            MediaZoomViewer(media: post.media, initialIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: PostMediaCarousel(
              media: post.media,
              liked: post.likedByMe,
              onDoubleTapLike: _doubleTapLike,
              onOpenViewer: _openViewer,
            ),
          ),
          _actionRow(),
          _likeCount(),
          _caption(),
          _commentPreview(),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }

  Widget _header() {
    final subtitleParts = <String>[
      post.author.breedOrSpecies,
      if (post.locationName != null) post.locationName!,
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: PetIdentity(
              pet: post.author,
              subtitle: subtitleParts.join(' · '),
              onTap: () => widget.onOpenProfile(post.author),
            ),
          ),
          _VisibilityChip(visibility: post.visibility),
          IconButton(
            onPressed: widget.onOpenOptions,
            icon: const Icon(FluentIcons.more_horizontal_24_regular,
                color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _actionRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        0,
      ),
      child: Row(
        children: [
          ScaleTransition(
            scale: _likePop,
            child: _ActionIcon(
              onTap: _toggleLike,
              tooltip: 'Like',
              child: PawGlyph(filled: post.likedByMe),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          _ActionIcon(
            onTap: widget.onOpenComments,
            tooltip: 'Comment',
            child: const Icon(FluentIcons.comment_24_regular,
                color: AppColors.textSecondary),
          ),
          const SizedBox(width: AppSpacing.xs),
          _ActionIcon(
            onTap: widget.onShare,
            tooltip: 'Share',
            child: const Icon(FluentIcons.share_24_regular,
                color: AppColors.textSecondary),
          ),
          const Spacer(),
          _ActionIcon(
            onTap: _toggleSave,
            tooltip: 'Save',
            child: Icon(
              post.saved
                  ? FluentIcons.bookmark_24_filled
                  : FluentIcons.bookmark_24_regular,
              color: post.saved ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _likeCount() {
    if (post.likes <= 0) return const SizedBox(height: AppSpacing.xs);
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.xs,
          AppSpacing.md, 0),
      child: Text(
        '${post.likes} ${post.likes == 1 ? 'paw' : 'paws'}',
        style: AppTextStyles.labelLarge,
      ),
    );
  }

  Widget _caption() {
    final tags = post.taggedPets;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.xs,
        AppSpacing.md,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() => _captionExpanded = !_captionExpanded),
            child: RichCaption(
              text: post.hashtags.isEmpty
                  ? post.caption
                  : '${post.caption} ${post.hashtags.map((h) => '#$h').join(' ')}',
              style: AppTextStyles.bodyMedium,
              maxLines: _captionExpanded ? null : 2,
            ),
          ),
          if (tags.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                const Icon(FluentIcons.tag_24_regular,
                    size: 14, color: AppColors.textTertiary),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    'with ${tags.map((p) => p.name).join(', ')}',
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Text(post.timeAgo,
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.textTertiary)),
              if (post.isEdited) ...[
                Text(' · Edited',
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.textTertiary)),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _commentPreview() {
    if (post.commentCount == 0) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.xs,
        AppSpacing.md,
        0,
      ),
      child: GestureDetector(
        onTap: widget.onOpenComments,
        child: Text(
          'View all ${post.commentCount} comments',
          style:
              AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({
    required this.onTap,
    required this.tooltip,
    required this.child,
  });

  final VoidCallback onTap;
  final String tooltip;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: tooltip,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(padding: const EdgeInsets.all(AppSpacing.xs), child: child),
      ),
    );
  }
}

class _VisibilityChip extends StatelessWidget {
  const _VisibilityChip({required this.visibility});
  final PostVisibility visibility;

  @override
  Widget build(BuildContext context) {
    if (visibility == PostVisibility.public) return const SizedBox.shrink();
    final icon = visibility == PostVisibility.followers
        ? FluentIcons.people_24_regular
        : FluentIcons.lock_closed_24_regular;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(visibility.label,
              style: AppTextStyles.labelSmall
                  .copyWith(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
