import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../domain/entities/community_entities.dart' as domain;
import '../models/pawhub_models.dart';
import '../providers/community_actions_providers.dart';
import '../providers/community_feed_providers.dart';
import '../providers/community_providers.dart';
import '../widgets/pawhub_comments.dart';
import '../widgets/pawhub_sheets.dart';
import '../widgets/post_card.dart';
import 'pawhub_pet_profile_page.dart';

class PawHubTrendingPage extends ConsumerStatefulWidget {
  const PawHubTrendingPage({super.key});

  @override
  ConsumerState<PawHubTrendingPage> createState() => _PawHubTrendingPageState();
}

class _PawHubTrendingPageState extends ConsumerState<PawHubTrendingPage> {
  @override
  Widget build(BuildContext context) {
    final trendingAsync = ref.watch(trendingProvider);
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
        title: Text(context.l10n.pawhubTrendingTitle,
            style: AppTextStyles.titleLarge),
      ),
      body: trendingAsync.when(
        loading: () => _loadingState(),
        error: (e, _) => _errorState(
          () => ref.invalidate(trendingProvider),
        ),
        data: (trending) => _content(trending, actingPet),
      ),
    );
  }

  Widget _loadingState() {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, i) => Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
            ),
            childCount: 5,
          ),
        ),
      ],
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
            Text(context.l10n.pawhubTrendingFailed,
                style: AppTextStyles.titleSmall),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(
                onPressed: onRetry, child: Text(context.l10n.retry)),
          ],
        ),
      ),
    );
  }

  Widget _content(domain.Trending trending, PawPet actingPet) {
    // Nothing trending yet — surface an empty state instead of a blank scroll.
    if (trending.hashtags.isEmpty && trending.posts.isEmpty) {
      return EmptyStateWidget(
        icon: FluentIcons.fire_24_regular,
        title: context.l10n.pawhubTrendingEmptyTitle,
        message: context.l10n.pawhubTrendingEmptyMessage,
      );
    }
    return CustomScrollView(
      slivers: [
        if (trending.hashtags.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg,
                  AppSpacing.lg, AppSpacing.sm),
              child: Row(
                children: [
                  const Icon(FluentIcons.number_symbol_24_regular,
                      size: 18, color: AppColors.textSecondary),
                  const SizedBox(width: AppSpacing.sm),
                  Text(context.l10n.pawhubTrendingHashtags,
                      style: AppTextStyles.titleSmall),
                ],
              ),
            ),
          ),
        if (trending.hashtags.isNotEmpty)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) {
                final tag = trending.hashtags[i];
                return _HashtagTile(tag: tag);
              },
              childCount: trending.hashtags.length,
            ),
          ),
        if (trending.posts.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg,
                  AppSpacing.lg, AppSpacing.sm),
              child: Row(
                children: [
                  const Icon(FluentIcons.fire_24_regular,
                      size: 18, color: AppColors.textSecondary),
                  const SizedBox(width: AppSpacing.sm),
                  Text(context.l10n.pawhubTopPosts,
                      style: AppTextStyles.titleSmall),
                ],
              ),
            ),
          ),
        if (trending.posts.isNotEmpty)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) {
                final post = PawPost.fromEntity(trending.posts[i]);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: PostCard(
                    post: post,
                    onOpenComments: () => _showComments(post, actingPet),
                    onOpenOptions: () =>
                        _showOptions(post, trending.posts[i], actingPet),
                    onOpenProfile: (pet) => openPawHubPetProfile(context, pet),
                    onShare: () => _share(trending.posts[i]),
                  ),
                );
              },
              childCount: trending.posts.length,
            ),
          ),
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
        ref.invalidate(trendingProvider);
      case PostAction.report:
        final reason = await showReportSheet(context);
        if (reason != null) {
          await actions.reportPost(post.backendId, reason);
        }
      case PostAction.block:
        await actions.block(post.author.backendId);
      case PostAction.delete:
        await actions.deletePost(post.backendId);
    }
  }

  Future<void> _share(domain.Post post) async {
    final actions = ref.read(communityActionsProvider);
    await actions.share(post);
  }
}

class _HashtagTile extends StatelessWidget {
  const _HashtagTile({required this.tag});
  final domain.TrendingHashtag tag;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.secondarySoft,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: const Center(
          child: Icon(FluentIcons.number_symbol_24_regular,
              size: 18, color: AppColors.secondaryDark),
        ),
      ),
      title: Text('#${tag.tag}', style: AppTextStyles.labelLarge),
      subtitle: Text(context.l10n.pawhubHashtagPostsCount(tag.postCount),
          style:
              AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
      onTap: () => context.push('/community/hashtag/${tag.tag}'),
    );
  }
}
