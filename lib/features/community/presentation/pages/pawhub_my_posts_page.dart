import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
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

class PawHubMyPostsPage extends ConsumerStatefulWidget {
  const PawHubMyPostsPage({super.key});

  @override
  ConsumerState<PawHubMyPostsPage> createState() => _PawHubMyPostsPageState();
}

class _PawHubMyPostsPageState extends ConsumerState<PawHubMyPostsPage> {
  @override
  Widget build(BuildContext context) {
    final myPostsAsync = ref.watch(myPostsProvider);
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
        title: Text(context.l10n.pawhubMyPostsTitle,
            style: AppTextStyles.titleLarge),
      ),
      body: myPostsAsync.when(
        loading: () => _loadingState(),
        error: (e, _) => _errorState(
          () => ref.invalidate(myPostsProvider),
        ),
        data: (feed) {
          if (feed.posts.isEmpty) return _emptyState();
          return _feedList(feed, actingPet);
        },
      ),
    );
  }

  Widget _loadingState() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (_, _) => Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Container(
          height: 300,
          color: AppColors.divider,
        ),
      ),
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
            Text(context.l10n.pawhubMyPostsFailed,
                style: AppTextStyles.titleSmall),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(
                onPressed: onRetry, child: Text(context.l10n.retry)),
          ],
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: const BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(FluentIcons.image_24_regular,
                size: 32, color: AppColors.primaryDark),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(context.l10n.pawhubMyPostsEmptyTitle,
              style: AppTextStyles.titleSmall),
          const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Text(context.l10n.pawhubMyPostsEmptyMessage,
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  Widget _feedList(PagedFeed feed, PawPet actingPet) {
    return RefreshIndicator(
      onRefresh: () => ref.read(myPostsProvider.notifier).refresh(),
      child: ListView.separated(
        itemCount: feed.posts.length + (feed.loadingMore ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (_, i) {
          if (i >= feed.posts.length) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          final post = PawPost.fromEntity(feed.posts[i]);
          return PostCard(
            post: post,
            onOpenComments: () => _showComments(post, actingPet),
            onOpenOptions: () =>
                _showOptions(post, feed.posts[i], actingPet),
            onOpenProfile: (pet) => openPawHubPetProfile(context, pet),
            onShare: () => _share(feed.posts[i]),
          );
        },
      ),
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
    final action =
        await showPostOptionsSheet(context, post: post, forceMine: true);
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
        ref.invalidate(myPostsProvider);
      case PostAction.report:
        final reason = await showReportSheet(context);
        if (reason != null) {
          await actions.reportPost(post.backendId, reason);
        }
      case PostAction.block:
        await actions.block(post.author.backendId);
      case PostAction.delete:
        final confirmed = await showDialog<bool>(
          context: context,
          barrierDismissible: true,
          builder: (dialogContext) => Dialog(
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(FluentIcons.delete_24_regular,
                          size: 28, color: AppColors.error),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(context.l10n.pawhubDeletePostTitle,
                      style: AppTextStyles.titleMedium),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    context.l10n.pawhubDeletePostMessage,
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.error,
                      ),
                      onPressed: () => Navigator.pop(dialogContext, true),
                      child: Text(context.l10n.delete),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext, false),
                    child: Text(context.l10n.cancel),
                  ),
                ],
              ),
            ),
          ),
        ) ?? false;
        if (confirmed) {
          await actions.deletePost(post.backendId);
        }
    }
  }

  Future<void> _share(domain.Post post) async {
    final actions = ref.read(communityActionsProvider);
    await actions.share(post);
  }
}
