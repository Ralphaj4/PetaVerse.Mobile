import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../models/pawhub_models.dart';
import 'pawhub_common.dart';

enum _CommentSort { top, newest }

/// The comments bottom sheet: threaded (one level) comments with likes, a
/// sort toggle, pinned comments, and a composer that posts as [actingAs].
class CommentsSheet extends StatefulWidget {
  const CommentsSheet({
    required this.post,
    required this.actingAs,
    required this.myPets,
    required this.onActingAsChanged,
    super.key,
  });

  final PawPost post;
  final PawPet actingAs;
  final List<PawPet> myPets;
  final ValueChanged<PawPet> onActingAsChanged;

  @override
  State<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<CommentsSheet> {
  final _controller = TextEditingController();
  final _focus = FocusNode();
  _CommentSort _sort = _CommentSort.top;
  PawComment? _replyingTo;
  late PawPet _actingAs = widget.actingAs;

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  List<PawComment> get _sorted {
    final list = [...widget.post.comments];
    if (_sort == _CommentSort.top) {
      list.sort((a, b) {
        if (a.isPinned != b.isPinned) return a.isPinned ? -1 : 1;
        return b.likes.compareTo(a.likes);
      });
    }
    // "newest" keeps insertion order reversed (newest appended last).
    if (_sort == _CommentSort.newest) {
      final pinned = list.where((c) => c.isPinned).toList();
      final rest = list.where((c) => !c.isPinned).toList().reversed.toList();
      return [...pinned, ...rest];
    }
    return list;
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      final comment = PawComment(
        id: 'new_${DateTime.now().microsecondsSinceEpoch}',
        author: _actingAs,
        body: text,
        timeAgo: 'now',
      );
      if (_replyingTo != null) {
        _replyingTo!.replies.add(comment);
      } else {
        widget.post.comments.add(comment);
      }
      _controller.clear();
      _replyingTo = null;
    });
    _focus.unfocus();
  }

  void _toggleLike(PawComment c) {
    setState(() {
      c.likedByMe = !c.likedByMe;
      c.likes += c.likedByMe ? 1 : -1;
    });
  }

  void _startReply(PawComment c) {
    setState(() => _replyingTo = c);
    _focus.requestFocus();
  }

  Future<void> _switchPet() async {
    final chosen = await showPetSwitcherSheet(
      context,
      pets: widget.myPets,
      current: _actingAs,
      title: 'Comment as',
    );
    if (chosen != null) {
      setState(() => _actingAs = chosen);
      widget.onActingAsChanged(chosen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        final comments = _sorted;
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
          ),
          child: Column(
            children: [
              _header(comments.isEmpty),
              Expanded(
                child: comments.isEmpty
                    ? const _EmptyComments()
                    : ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.lg,
                          0,
                          AppSpacing.lg,
                          AppSpacing.lg,
                        ),
                        itemCount: comments.length,
                        itemBuilder: (_, i) => _CommentTile(
                          comment: comments[i],
                          onLike: () => _toggleLike(comments[i]),
                          onReply: () => _startReply(comments[i]),
                          onLikeReply: _toggleLike,
                        ),
                      ),
              ),
              _composer(bottomInset),
            ],
          ),
        );
      },
    );
  }

  Widget _header(bool empty) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 4,
          margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.divider,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            children: [
              Text('Comments', style: AppTextStyles.titleMedium),
              const SizedBox(width: AppSpacing.sm),
              if (!empty)
                Text('${widget.post.commentCount}',
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textTertiary)),
              const Spacer(),
              if (!empty)
                _SortToggle(
                  sort: _sort,
                  onChanged: (s) => setState(() => _sort = s),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        const Divider(height: 1, color: AppColors.divider),
      ],
    );
  }

  Widget _composer(double bottomInset) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.sm + bottomInset,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_replyingTo != null)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: Row(
                  children: [
                    Text(
                      'Replying to ${_replyingTo!.author.name}',
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.secondaryDark),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => setState(() => _replyingTo = null),
                      child: const Icon(FluentIcons.dismiss_16_regular,
                          size: 16, color: AppColors.textTertiary),
                    ),
                  ],
                ),
              ),
            Row(
              children: [
                GestureDetector(
                  onTap: _switchPet,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      AppAvatar(
                        name: _actingAs.name,
                        imageUrl: _actingAs.avatarUrl,
                        radius: 16,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(FluentIcons.chevron_down_16_filled,
                            size: 10, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focus,
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 1,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Add a comment as ${_actingAs.name}…',
                      isDense: true,
                      filled: true,
                      fillColor: AppColors.background,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => _submit(),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                IconButton(
                  onPressed: _submit,
                  icon: const Icon(FluentIcons.send_24_filled,
                      color: AppColors.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SortToggle extends StatelessWidget {
  const _SortToggle({required this.sort, required this.onChanged});
  final _CommentSort sort;
  final ValueChanged<_CommentSort> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(
        sort == _CommentSort.top ? _CommentSort.newest : _CommentSort.top,
      ),
      child: Row(
        children: [
          const Icon(FluentIcons.arrow_sort_24_regular,
              size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(
            sort == _CommentSort.top ? 'Top' : 'Newest',
            style: AppTextStyles.labelMedium
                .copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({
    required this.comment,
    required this.onLike,
    required this.onReply,
    required this.onLikeReply,
  });

  final PawComment comment;
  final VoidCallback onLike;
  final VoidCallback onReply;
  final ValueChanged<PawComment> onLikeReply;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _row(comment, onLike, onReply),
          for (final reply in comment.replies)
            Padding(
              padding: const EdgeInsets.only(
                  left: 40, top: AppSpacing.md),
              child: _row(reply, () => onLikeReply(reply), null),
            ),
        ],
      ),
    );
  }

  Widget _row(PawComment c, VoidCallback onLikeTap, VoidCallback? onReplyTap) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppAvatar(name: c.author.name, imageUrl: c.author.avatarUrl, radius: 16),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(c.author.name, style: AppTextStyles.labelLarge),
                  if (c.author.isVerified) ...[
                    const SizedBox(width: 4),
                    const VerifiedBadge(size: 13),
                  ],
                  const SizedBox(width: AppSpacing.sm),
                  Text(c.timeAgo,
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textTertiary)),
                  if (c.isPinned) ...[
                    const SizedBox(width: AppSpacing.sm),
                    const Icon(FluentIcons.pin_24_filled,
                        size: 12, color: AppColors.primary),
                  ],
                ],
              ),
              const SizedBox(height: 2),
              RichCaption(text: c.body, style: AppTextStyles.bodyMedium),
              const SizedBox(height: AppSpacing.xs),
              if (onReplyTap != null)
                GestureDetector(
                  onTap: onReplyTap,
                  child: Text('Reply',
                      style: AppTextStyles.labelMedium
                          .copyWith(color: AppColors.textSecondary)),
                ),
            ],
          ),
        ),
        Column(
          children: [
            GestureDetector(
              onTap: onLikeTap,
              child: Icon(
                c.likedByMe
                    ? FluentIcons.heart_24_filled
                    : FluentIcons.heart_24_regular,
                size: 18,
                color: c.likedByMe ? AppColors.error : AppColors.textTertiary,
              ),
            ),
            if (c.likes > 0)
              Text('${c.likes}',
                  style: AppTextStyles.labelSmall
                      .copyWith(color: AppColors.textTertiary)),
          ],
        ),
      ],
    );
  }
}

class _EmptyComments extends StatelessWidget {
  const _EmptyComments();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: const BoxDecoration(
                color: AppColors.primarySoft,
                shape: BoxShape.circle,
              ),
              child: const Icon(FluentIcons.comment_24_regular,
                  size: 32, color: AppColors.primaryDark),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('No comments yet', style: AppTextStyles.titleSmall),
            const SizedBox(height: AppSpacing.xs),
            Text('Be the first to say something nice 🐾',
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
