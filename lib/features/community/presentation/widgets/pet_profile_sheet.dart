import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../../domain/entities/community_entities.dart';
import '../models/pawhub_models.dart';
import '../providers/community_actions_providers.dart';
import '../providers/community_feed_providers.dart';
import 'pawhub_common.dart';
import 'pawhub_feed_widgets.dart';

/// A pet profile surfaced as a modal sheet from the feed. Shows the header
/// (avatar, name, breed, bio, owner attribution), a stats row, a follow/manage
/// action, and a posts grid. Demonstrates the account → pets relationship via
/// the "siblings" strip.
class PetProfileSheet extends ConsumerStatefulWidget {
  const PetProfileSheet({
    required this.pet,
    this.siblings = const [],
    super.key,
  });

  final PawPet pet;
  final List<PawPet> siblings;

  @override
  ConsumerState<PetProfileSheet> createState() => _PetProfileSheetState();
}

class _PetProfileSheetState extends ConsumerState<PetProfileSheet> {
  late bool _following = widget.pet.isFollowing;
  late int _followers = widget.pet.followers;

  Future<void> _toggleFollow() async {
    if (_following) {
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
                  decoration: const BoxDecoration(
                    color: AppColors.primarySoft,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(FluentIcons.person_delete_24_regular,
                        size: 28, color: AppColors.primaryDark),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text('Unfollow ${widget.pet.name}?',
                    style: AppTextStyles.titleMedium),
                const SizedBox(height: AppSpacing.md),
                Text(
                  "You won't see ${widget.pet.name}'s posts in your feed",
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
                    child: const Text('Unfollow'),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext, false),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ) ?? false;
      if (!confirmed) return;
    }

    final communityPet = CommunityPet(
      id: widget.pet.backendId,
      name: widget.pet.name,
      avatarUrl: widget.pet.avatarUrl,
      isFollowing: _following,
      followers: _followers,
    );
    // Optimistic update first.
    setState(() {
      _following = !_following;
      _followers += _following ? 1 : -1;
    });
    final nowFollowing =
        await ref.read(communityActionsProvider).toggleFollow(communityPet);
    // Reconcile with server response.
    if (mounted && nowFollowing != _following) {
      setState(() {
        _following = nowFollowing;
        _followers += nowFollowing ? 1 : -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final pet = widget.pet;
    final isDraggable = Navigator.of(context).canPop() &&
        ModalRoute.of(context)?.settings.name?.contains('bottom_sheet') == true;

    final content = Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      child: CustomScrollView(
        slivers: [
          if (isDraggable) SliverToBoxAdapter(child: _handle()),
          SliverToBoxAdapter(child: _header(pet)),
          SliverToBoxAdapter(child: _stats(pet)),
          SliverToBoxAdapter(child: _action(pet)),
          if (widget.siblings.isNotEmpty)
            SliverToBoxAdapter(child: _siblings()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.sm),
              child: Row(
                children: [
                  const Icon(FluentIcons.grid_24_regular,
                      size: 18, color: AppColors.textSecondary),
                  const SizedBox(width: AppSpacing.sm),
                  Text('Posts', style: AppTextStyles.titleSmall),
                ],
              ),
            ),
          ),
          _postsGrid(widget.pet.backendId),
        ],
      ),
    );

    if (isDraggable) {
      return DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => content,
      );
    }
    return content;
  }

  Widget _handle() => Center(
        child: Container(
          width: 40,
          height: 4,
          margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.divider,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      );

  Widget _header(PawPet pet) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        children: [
          AppAvatar(
            name: pet.name,
            imageUrl: pet.avatarUrl,
            radius: 44,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(pet.name, style: AppTextStyles.headlineMedium),
              if (pet.isVerified) ...[
                const SizedBox(width: AppSpacing.xs),
                const VerifiedBadge(size: 18),
              ],
            ],
          ),
          Text(pet.breedOrSpecies,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary)),
          if (pet.bio.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(pet.bio,
                style: AppTextStyles.bodyMedium, textAlign: TextAlign.center),
          ],
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(FluentIcons.person_24_regular,
                  size: 14, color: AppColors.textTertiary),
              const SizedBox(width: 4),
              Text('cared for by ${pet.ownerName}',
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.textTertiary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stats(PawPet pet) {
    return Consumer(
      builder: (_, ref, _) {
        final postsAsync = ref.watch(petPostsProvider(pet.backendId));
        final postCount = postsAsync.when(
          loading: () => '...',
          error: (_, _) => '0',
          data: (feed) => _compact(feed.postCount ?? feed.posts.length),
        );
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg, vertical: AppSpacing.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _stat(postCount, 'Posts'),
              _stat(_compact(_followers), 'Followers'),
              _stat(_compact((_followers * 0.4).round()), 'Following'),
            ],
          ),
        );
      },
    );
  }

  Widget _stat(String value, String label) => Column(
        children: [
          Text(value, style: AppTextStyles.titleMedium),
          Text(label,
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textSecondary)),
        ],
      );

  Widget _action(PawPet pet) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: pet.isMine
          ? SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(FluentIcons.settings_24_regular, size: 18),
                label: const Text('Manage pet'),
              ),
            )
          : FollowButton(
              following: _following,
              onTap: () => _toggleFollow(),
              expanded: true,
            ),
    );
  }

  Widget _siblings() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${widget.pet.name}'s siblings",
              style: AppTextStyles.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 64,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.siblings.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
              itemBuilder: (_, i) => Column(
                children: [
                  AppAvatar(
                    name: widget.siblings[i].name,
                    imageUrl: widget.siblings[i].avatarUrl,
                    radius: 20,
                  ),
                  const SizedBox(height: 4),
                  Text(widget.siblings[i].name,
                      style: AppTextStyles.labelSmall),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _compact(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return '$n';
  }

  Widget _postsGrid(int petId) {
    return Consumer(
      builder: (_, ref, _) {
        final postsAsync = ref.watch(petPostsProvider(petId));
        return postsAsync.when(
          loading: () => SliverPadding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.xl),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, i) => Container(
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                childCount: 6,
              ),
            ),
          ),
          error: (_, _) => const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Text('Failed to load posts'),
            ),
          ),
          data: (feed) {
            if (feed.posts.isEmpty) {
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Text('No posts yet'),
                ),
              );
            }
            return SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.xl),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                ),
                delegate: SliverChildBuilderDelegate(
                  (_, i) {
                    final post = feed.posts[i];
                    final mediaUrl = post.media.isNotEmpty
                        ? post.media[0].url
                        : null;
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => _PostCarousel(
                              posts: feed.posts,
                              initialIndex: i,
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: mediaUrl != null
                            ? AppCachedImage(
                                imageUrl: mediaUrl,
                              )
                            : Container(
                                color: AppColors.divider,
                                child: const Icon(
                                  FluentIcons.document_24_regular,
                                  color: AppColors.textTertiary,
                                ),
                              ),
                      ),
                    );
                  },
                  childCount: feed.posts.length,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _PostCarousel extends StatefulWidget {
  const _PostCarousel({
    required this.posts,
    required this.initialIndex,
  });

  final List<Post> posts;
  final int initialIndex;

  @override
  State<_PostCarousel> createState() => _PostCarouselState();
}

class _PostCarouselState extends State<_PostCarousel> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(FluentIcons.dismiss_24_regular,
              color: AppColors.onPrimary),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: (_) {},
        itemCount: widget.posts.length,
        itemBuilder: (_, index) {
          final post = widget.posts[index];
          return Column(
            children: [
              Expanded(
                child: post.media.isNotEmpty
                    ? _MediaCarousel(media: post.media)
                    : Container(
                        color: AppColors.divider,
                        child: const Icon(
                          FluentIcons.document_24_regular,
                          color: AppColors.textTertiary,
                          size: 48,
                        ),
                      ),
              ),
              Container(
                color: AppColors.surface,
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        AppAvatar(
                          name: post.author.name,
                          imageUrl: post.author.avatarUrl ?? '',
                          radius: 20,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(post.author.name,
                                  style: AppTextStyles.labelLarge),
                              if (post.author.ownerName != null)
                                Text(post.author.ownerName!,
                                    style: AppTextStyles.bodySmall
                                        .copyWith(
                                            color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (post.caption != null && post.caption!.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.md),
                      Text(post.caption!,
                          style: AppTextStyles.bodyMedium,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MediaCarousel extends StatefulWidget {
  const _MediaCarousel({required this.media});
  final List<PostMedia> media;

  @override
  State<_MediaCarousel> createState() => _MediaCarouselState();
}

class _MediaCarouselState extends State<_MediaCarousel> {
  late PageController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          itemCount: widget.media.length,
          itemBuilder: (_, index) {
            final media = widget.media[index];
            return AppCachedImage(imageUrl: media.url);
          },
        ),
        if (widget.media.length > 1)
          Positioned(
            bottom: AppSpacing.lg,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.textPrimary.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Text(
                  '${_currentIndex + 1}/${widget.media.length}',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
