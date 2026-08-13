import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/community_entities.dart' as domain;
import '../models/pawhub_models.dart';
import '../providers/community_actions_providers.dart';
import '../providers/community_feed_providers.dart';
import '../providers/community_providers.dart';
import '../widgets/pawhub_comments.dart';
import '../widgets/pawhub_sheets.dart';
import '../widgets/post_card.dart';
import 'pawhub_pet_profile_page.dart';

class PawHubPostDetailPage extends ConsumerStatefulWidget {
  const PawHubPostDetailPage({required this.postId, super.key});

  final int postId;

  @override
  ConsumerState<PawHubPostDetailPage> createState() =>
      _PawHubPostDetailPageState();
}

class _PawHubPostDetailPageState extends ConsumerState<PawHubPostDetailPage> {
  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(postDetailProvider(widget.postId));
    final actingPetRef = ref.watch(actingPetProvider);
    if (actingPetRef == null) return const Scaffold(body: SizedBox.expand());
    final actingPet = PawPet(
      id: actingPetRef.id.toString(),
      backendId: actingPetRef.id,
      name: actingPetRef.name,
      breed: '',
      species: '',
      avatarUrl: '',
      ownerName: '',
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(FluentIcons.arrow_left_24_regular,
              color: AppColors.textPrimary),
        ),
        title:
            Text(context.l10n.pawhubPostTitle, style: AppTextStyles.titleLarge),
      ),
      body: detailAsync.when(
        loading: () => _loadingState(),
        error: (e, _) => _errorState(
          () => ref.invalidate(postDetailProvider(widget.postId)),
        ),
        data: (detail) => _content(detail, actingPet),
      ),
    );
  }

  Widget _loadingState() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }

  Widget _errorState(VoidCallback onRetry) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(FluentIcons.warning_24_regular,
                size: 40, color: AppColors.error),
            const SizedBox(height: AppSpacing.md),
            Text(context.l10n.pawhubPostFailed,
                style: AppTextStyles.titleSmall),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(
                onPressed: onRetry, child: Text(context.l10n.retry)),
          ],
        ),
      ),
    );
  }

  Widget _content(domain.PostDetail detail, PawPet actingPet) {
    final post = PawPost.fromEntity(detail.post);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: PostCard(
            post: post,
            onOpenComments: () => _showComments(post, actingPet),
            onOpenOptions: () =>
                _showOptions(post, detail.post, actingPet),
            onOpenProfile: (pet) => openPawHubPetProfile(context, pet),
            onShare: () => _share(detail.post),
          ),
        ),
        if (detail.comments.isNotEmpty) ...[
          const Divider(color: AppColors.divider),
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg,
                AppSpacing.lg, AppSpacing.sm),
            child: Text(
                context.l10n.pawhubCommentsCountLabel(detail.comments.length),
                style: AppTextStyles.titleSmall),
          ),
          ...detail.comments.map((c) => _CommentRow(comment: c)),
        ],
      ],
    );
  }

  void _showComments(PawPost post, PawPet actingPet) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      builder: (_) => CommentsSheet(
        post: post,
        actingAs: actingPet,
        myPets: const [],
        onActingAsChanged: (_) {},
      ),
    );
  }

  Future<void> _showOptions(
      PawPost post, domain.Post domainPost, PawPet actingPet) async {
    final action = await showPostOptionsSheet(context, post: post);
    if (action == null || !mounted) return;
    final actions = ref.read(communityActionsProvider);
    switch (action) {
      case PostAction.save:
        await actions.toggleSave(domainPost);
      case PostAction.copyLink:
        break;
      case PostAction.share:
        await actions.share(domainPost);
      case PostAction.hide:
        if (mounted) Navigator.of(context).pop();
      case PostAction.report:
        final reason = await showReportSheet(context);
        if (reason != null) {
          await actions.reportPost(post.backendId, reason);
        }
      case PostAction.block:
        await actions.block(post.author.backendId);
      case PostAction.delete:
        await actions.deletePost(post.backendId);
        if (mounted) Navigator.of(context).pop();
    }
  }

  Future<void> _share(domain.Post post) async {
    final actions = ref.read(communityActionsProvider);
    await actions.share(post);
  }
}

class _CommentRow extends StatelessWidget {
  const _CommentRow({required this.comment});
  final domain.Comment comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, vertical: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(comment.author.name, style: AppTextStyles.labelMedium),
                const SizedBox(height: 2),
                Text(comment.body,
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
