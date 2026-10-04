import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../domain/entities/community_entities.dart';
import '../models/pawhub_models.dart';
import '../providers/community_actions_providers.dart';
import '../providers/community_comments_providers.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import 'pawhub_common.dart';
import 'pawhub_sheets.dart';
import 'pet_profile_sheet.dart';

enum _CommentSort { top, newest }

/// The comments bottom sheet: threaded (one level) comments with likes, a
/// sort toggle, pinned comments, and a composer that posts as the acting pet.
/// Wired to [PostComments] provider — all mutations go through the backend.
class CommentsSheet extends ConsumerStatefulWidget {
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
  ConsumerState<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends ConsumerState<CommentsSheet> {
  final _controller = TextEditingController();
  final _focus = FocusNode();
  _CommentSort _sort = _CommentSort.top;
  Comment? _replyingTo;
  late PawPet _actingAs = widget.actingAs;

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  int get _postId => widget.post.backendId;

  List<Comment> _sorted(List<Comment> raw) {
    final list = [...raw];
    if (_sort == _CommentSort.top) {
      list.sort((a, b) {
        if (a.isPinned != b.isPinned) return a.isPinned ? -1 : 1;
        return b.likes.compareTo(a.likes);
      });
      return list;
    }
    // newest: pinned first, then reverse insertion order
    final pinned = list.where((c) => c.isPinned).toList();
    final rest = list.where((c) => !c.isPinned).toList().reversed.toList();
    return [...pinned, ...rest];
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    _focus.unfocus();
    final replyTo = _replyingTo;
    setState(() => _replyingTo = null);
    await ref.read(postCommentsProvider(_postId).notifier).add(
          text,
          parentCommentId: replyTo?.id,
        );
  }

  Future<void> _toggleLike(Comment c) async {
    await ref.read(postCommentsProvider(_postId).notifier).toggleLike(c);
  }

  Future<void> _showCommentMenu(Comment c) async {
    final action = await showCommentOptionsSheet(context, comment: PawComment.fromEntity(c));
    if (action == null || !mounted) return;
    final actions = ref.read(communityActionsProvider);

    switch (action) {
      case CommentAction.edit:
        await _editComment(c);
      case CommentAction.delete:
        await actions.deleteComment(c.id);
        if (mounted) {
          ref.invalidate(postCommentsProvider(widget.post.backendId));
        }
      case CommentAction.report:
        final reason = await showReportSheet(context);
        if (reason != null) {
          await actions.reportComment(c.id, reason);
        }
    }
  }

  Future<void> _editComment(Comment c) async {
    final controller = TextEditingController(text: c.body);
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.lg,
          bottom: MediaQuery.viewInsetsOf(ctx).bottom + AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.l10n.pawhubEditComment,
                style: AppTextStyles.titleMedium),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: controller,
              minLines: 2,
              maxLines: 5,
              autofocus: true,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(ctx, controller.text.trim()),
                child: Text(context.l10n.save),
              ),
            ),
          ],
        ),
      ),
    );
    if (result != null && mounted) {
      await ref.read(communityActionsProvider).editComment(
            commentId: c.id,
            body: result,
          );
      if (mounted) {
        ref.invalidate(postCommentsProvider(widget.post.backendId));
      }
    }
  }

  void _startReply(Comment c) {
    setState(() => _replyingTo = c);
    _focus.requestFocus();
  }

  Future<void> _switchPet() async {
    final chosen = await showPetSwitcherSheet(
      context,
      pets: widget.myPets,
      current: _actingAs,
      title: context.l10n.pawHubCommentAs,
    );
    if (chosen != null) {
      setState(() => _actingAs = chosen);
      widget.onActingAsChanged(chosen);
      ref.read(petsProvider.notifier).selectPet(chosen.backendId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final commentsAsync = ref.watch(postCommentsProvider(_postId));
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return SafeArea(
            top: false,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.surface,
              ),
              child: Column(
                children: [
                  commentsAsync.when(
                    loading: () => _headerStatic(null),
                    error: (e, st) => _headerStatic(null),
                    data: (page) => _header(page.comments),
                  ),
                  Expanded(
                    child: commentsAsync.when(
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, st) => Center(
                        child: Text(context.l10n.pawhubCouldNotLoadComments),
                      ),
                      data: (page) {
                        final comments = _sorted(page.comments);
                        if (comments.isEmpty) return const _EmptyComments();
                        return ListView.builder(
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
                          onShowMenu: _showCommentMenu,
                        ),
                      );
                    },
                  ),
                ),
                  _composer(bottomInset),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _headerStatic(List<Comment>? comments) {
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
              Text(context.l10n.pawHubCommentsTitle,
                  style: AppTextStyles.titleMedium),
              if (comments != null && comments.isNotEmpty) ...[
                const SizedBox(width: AppSpacing.sm),
                Text('${comments.length}',
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textTertiary)),
              ],
              const Spacer(),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        const Divider(height: 1, color: AppColors.divider),
      ],
    );
  }

  Widget _header(List<Comment> comments) {
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
              Text(context.l10n.pawHubCommentsTitle,
                  style: AppTextStyles.titleMedium),
              if (comments.isNotEmpty) ...[
                const SizedBox(width: AppSpacing.sm),
                Text('${comments.length}',
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textTertiary)),
              ],
              const Spacer(),
              if (comments.isNotEmpty)
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
                      context.l10n
                          .pawHubReplyingTo(_replyingTo!.author.name),
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.secondaryDark),
                    ),
                    const Spacer(),
                    Semantics(
                      button: true,
                      label: context.l10n.close,
                      child: GestureDetector(
                        onTap: () => setState(() => _replyingTo = null),
                        child: const Icon(FluentIcons.dismiss_16_regular,
                            size: 16, color: AppColors.textTertiary),
                      ),
                    ),
                  ],
                ),
              ),
            Row(
              children: [
                Semantics(
                  button: true,
                  label: context.l10n.pawHubCommentAs,
                  child: GestureDetector(
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
                      hintText: context.l10n.pawHubCommentHint(_actingAs.name),
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
                  tooltip: context.l10n.pawHubPostComment,
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
            sort == _CommentSort.top
                ? context.l10n.pawHubSortTop
                : context.l10n.pawHubSortNewest,
            style: AppTextStyles.labelMedium
                .copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _CommentTile extends ConsumerStatefulWidget {
  const _CommentTile({
    required this.comment,
    required this.onLike,
    required this.onReply,
    required this.onLikeReply,
    required this.onShowMenu,
  });

  final Comment comment;
  final VoidCallback onLike;
  final VoidCallback onReply;
  final ValueChanged<Comment> onLikeReply;
  final ValueChanged<Comment> onShowMenu;

  @override
  ConsumerState<_CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends ConsumerState<_CommentTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _row(widget.comment, widget.onLike, widget.onReply),
          for (final reply in widget.comment.replies)
            Padding(
              padding: const EdgeInsets.only(left: 40, top: AppSpacing.md),
              child: _row(reply, () => widget.onLikeReply(reply), null),
            ),
        ],
      ),
    );
  }

  Widget _row(Comment c, VoidCallback onLikeTap, VoidCallback? onReplyTap) {
    final authorPet = PawPet.fromEntity(c.author);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          button: true,
          label: context.l10n.pawhubViewProfile,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: AppColors.surface,
                builder: (_) => PetProfileSheet(pet: authorPet),
              );
            },
            child: AppAvatar(name: authorPet.name, imageUrl: authorPet.avatarUrl, radius: 16),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: AppColors.surface,
                        builder: (_) => PetProfileSheet(pet: authorPet),
                      );
                    },
                    child: Text(authorPet.name, style: AppTextStyles.labelLarge),
                  ),
                  if (authorPet.isVerified) ...[
                    const SizedBox(width: 4),
                    const VerifiedBadge(size: 13),
                  ],
                  const SizedBox(width: AppSpacing.sm),
                  Text(c.timeAgo ?? '',
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
                  child: Text(context.l10n.pawHubCommentReply,
                      style: AppTextStyles.labelMedium
                          .copyWith(color: AppColors.textSecondary)),
                ),
            ],
          ),
        ),
        Column(
          children: [
            Semantics(
              button: true,
              label: context.l10n.pawhubLike,
              child: GestureDetector(
                onTap: onLikeTap,
                child: Icon(
                  c.likedByMe
                      ? FluentIcons.heart_24_filled
                      : FluentIcons.heart_24_regular,
                  size: 18,
                  color: c.likedByMe ? AppColors.error : AppColors.textTertiary,
                ),
              ),
            ),
            if (c.likes > 0)
              Text('${c.likes}',
                  style: AppTextStyles.labelSmall
                      .copyWith(color: AppColors.textTertiary)),
          ],
        ),
        IconButton(
          onPressed: () => widget.onShowMenu(c),
          tooltip: context.l10n.pawhubMoreOptions,
          icon: const Icon(FluentIcons.more_horizontal_24_regular,
              size: 18, color: AppColors.textSecondary),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
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
            Text(context.l10n.pawHubNoCommentsYet,
                style: AppTextStyles.titleSmall),
            const SizedBox(height: AppSpacing.xs),
            Text(context.l10n.pawHubFirstCommentEncouragement,
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
