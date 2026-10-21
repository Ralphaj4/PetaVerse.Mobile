import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/community_entities.dart' as domain;
import '../../domain/entities/community_enums.dart' as domain_enums;
import '../models/pawhub_models.dart';
import '../providers/community_actions_providers.dart';
import '../providers/community_feed_providers.dart';
import '../providers/community_impressions_provider.dart';
import '../providers/community_providers.dart';
import '../providers/community_social_providers.dart';
import '../../../pages/presentation/pages/page_detail_page.dart';
import '../../../pages/presentation/providers/page_providers.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../widgets/adoption_injection_card.dart';
import '../widgets/pawhub_comments.dart';
import '../widgets/pawhub_common.dart';
import '../widgets/pawhub_feed_widgets.dart';
import '../widgets/pawhub_sheets.dart';
import '../widgets/post_card.dart';
import '../widgets/post_composer_page.dart';
import '../widgets/post_share.dart';
import '../widgets/upload_progress_banner.dart';
import 'pawhub_search_page.dart';
import 'pawhub_pet_profile_page.dart';

/// PawHub - the pet social feed, wired to real backend providers.
class PawHubPage extends ConsumerStatefulWidget {
  const PawHubPage({this.barsVisible = true, super.key});

  final bool barsVisible;

  @override
  ConsumerState<PawHubPage> createState() => _PawHubPageState();
}

class _PawHubPageState extends ConsumerState<PawHubPage> {
  /// The feed's scroll controller. Adopted from the ambient
  /// [PrimaryScrollController] (owned by CommunityHubPage) so re-tapping the
  /// Community bottom-nav tab scrolls the feed to the top. Not disposed here - /// the hub owns its lifecycle.
  late ScrollController _scrollController;

  FeedTab _tab = FeedTab.following;
  bool _showNewPill = false;

  /// Optimistic follow-state overrides for suggested pets. Keyed by backendId.
  /// Cleared on feed refresh so stale overrides don't persist.
  final Map<int, bool> _followingOverrides = {};

  /// Optimistic follow-state overrides for suggested pages. Keyed by page id.
  final Map<int, bool> _pageFollowingOverrides = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController = PrimaryScrollController.of(context);
  }

  // ── Pet switcher ──────────────────────────────────────────────────────────

  Future<void> _switchActingPet() async {
    final myPets = ref.read(switchablePetsProvider);
    final actingPet = ref.read(actingPetProvider);
    if (myPets.isEmpty || actingPet == null) return;

    final pawPets = myPets.map((r) => PawPet(
          id: r.id.toString(),
          backendId: r.id,
          name: r.name,
          breed: '',
          species: '',
          avatarUrl: r.imagePath,
          ownerName: 'You',
          isMine: true,
        )).toList();
    final current = pawPets.firstWhere(
      (p) => p.backendId == actingPet.id,
      orElse: () => pawPets.first,
    );

    final chosen = await showPetSwitcherSheet(
      context,
      pets: pawPets,
      current: current,
      onViewProfile: _openProfile,
    );
    if (chosen != null) {
      unawaited(HapticFeedback.selectionClick());
      // The acting pet is derived from PetsNotifier.currentPet - // selectPet changes it app-wide.
      final notifier = ref.read(petsProvider.notifier);
      notifier.selectPet(chosen.backendId);
    }
  }

  // ── Feed actions ──────────────────────────────────────────────────────────

  Future<void> _refresh() async {
    unawaited(HapticFeedback.selectionClick());
    setState(() {
      _showNewPill = false;
      _followingOverrides.clear();
      _pageFollowingOverrides.clear();
    });
    if (_tab == FeedTab.following) {
      await ref.read(followingFeedProvider.notifier).refresh();
    } else {
      await ref.read(discoverFeedProvider.notifier).refresh();
    }
  }

  Future<void> _loadMore() async {
    if (_tab == FeedTab.following) {
      await ref.read(followingFeedProvider.notifier).loadMore();
    } else {
      await ref.read(discoverFeedProvider.notifier).loadMore();
    }
  }

  void _consumeNewPill() {
    setState(() => _showNewPill = false);
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
    _refresh();
  }

  // ── Post interactions ─────────────────────────────────────────────────────

  void _openComments(PawPost post) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CommentsSheet(
        post: post,
        actingAs: _currentActingPawPet(),
        myPets: _myPawPets(),
        onActingAsChanged: (p) {
          ref.read(petsProvider.notifier).selectPet(p.backendId);
        },
      ),
    ).whenComplete(() => setState(() {}));
  }

  Future<void> _openOptions(PawPost post) async {
    final action = await showPostOptionsSheet(context, post: post);
    if (action == null || !mounted) return;
    final actions = ref.read(communityActionsProvider);
    final domainPost = _toDomainPost(post);

    switch (action) {
      case PostAction.save:
        final saved = await actions.toggleSave(domainPost);
        if (mounted) {
          setState(() => post.saved = saved);
          _snack(saved
              ? context.l10n.pawHubPostSaved
              : context.l10n.pawHubPostRemovedFromSaved);
        }
      case PostAction.copyLink:
        await copyPostLink(ref, context, domainPost);
      case PostAction.share:
        await sharePostToSheet(ref, domainPost, context: context, showLoadingSnackbar: true);
      case PostAction.report:
        final reason = await showReportSheet(context);
        if (reason != null && mounted) {
          await actions.reportPost(post.backendId, reason);
          if (mounted) _snack(context.l10n.pawHubPostReported);
        }
      case PostAction.block:
        final authorName = post.author?.name ?? post.pageAuthor?.name ?? '';
        final confirmed = await showBlockConfirmDialog(
          context,
          authorName: authorName,
        );
        if (!confirmed || !mounted) break;
        final authorId = post.author?.backendId ?? 0;
        if (authorId > 0) await actions.block(authorId);
        if (mounted) _snack(context.l10n.pawHubBlockedUser(authorName));
      case PostAction.delete:
        await actions.deletePost(post.backendId);
        if (mounted) _snack(context.l10n.pawHubPostDeleted);
    }
  }

void _openProfile(PawPet pet) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PawHubPetProfilePage(
          pet: pet,
          siblings: pet.isMine
              ? _myPawPets().where((p) => p.id != pet.id).toList()
              : const [],
        ),
      ),
    );
  }

  Future<void> _toggleFollow(PawPet pet) async {
    final currentlyFollowing =
        _followingOverrides[pet.backendId] ?? pet.isFollowing;
    // Optimistic update first so the button flips instantly.
    setState(() => _followingOverrides[pet.backendId] = !currentlyFollowing);

    final communityPet = domain.CommunityPet(
      id: pet.backendId,
      name: pet.name,
      avatarUrl: pet.avatarUrl,
      ownerName: pet.ownerName,
      isFollowing: currentlyFollowing,
    );
    final nowFollowing =
        await ref.read(communityActionsProvider).toggleFollow(communityPet);
    if (!mounted) return;
    setState(() {
      _followingOverrides[pet.backendId] = nowFollowing;
      _snack(nowFollowing
          ? context.l10n.pawHubFollowingPet(pet.name)
          : context.l10n.pawHubUnfollowedPet(pet.name));
    });
  }

  Future<void> _togglePageFollow(PawSuggestedPage page) async {
    final currentlyFollowing =
        _pageFollowingOverrides[page.id] ?? page.isFollowing;
    setState(() => _pageFollowingOverrides[page.id] = !currentlyFollowing);
    await ref.read(pageFollowActionsProvider).toggleFollowById(
          page.id,
          currentlyFollowing: currentlyFollowing,
        );
    if (mounted) setState(() {});
  }

  Future<void> _openComposer() async {
    final myPets = _myPawPets();
    final actingPet = _currentActingPawPet();
    if (myPets.isEmpty) {
      _snack(context.l10n.pawHubAddPetFirstToPost);
      return;
    }
    // Merge followers + following + user's own other pets as tagging candidates.
    // Deduped by backendId so mutual-follows don't appear twice.
    final actingId = actingPet.backendId;
    final followingPets = ref.read(followingProvider(actingId)).value?.pets ?? [];
    final followerPets = ref.read(followersProvider(actingId)).value?.pets ?? [];
    final seen = <int>{actingId};
    final taggable = <PawPet>[
      // Own pets first (most obvious candidates).
      for (final p in myPets)
        if (p.backendId != actingId && seen.add(p.backendId)) p,
      // Then following.
      for (final e in followingPets)
        if (seen.add(e.id)) PawPet.fromEntity(e),
      // Then followers (mutual or one-way).
      for (final e in followerPets)
        if (seen.add(e.id)) PawPet.fromEntity(e),
    ];
    final post = await Navigator.of(context).push<PawPost>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => PostComposerPage(
          myPets: myPets,
          actingAs: actingPet,
          taggablePets: taggable,
        ),
      ),
    );
    if (post != null && mounted) {
      // The real post comes from the provider (createPost calls refresh).
      setState(() {});
      _snack(context.l10n.pawHubPostedAs(post.author?.name ?? ''));
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  PawPet _currentActingPawPet() {
    final pet = ref.read(actingPetProvider);
    if (pet == null) return _fallbackPet();
    return PawPet(
      id: pet.id.toString(),
      backendId: pet.id,
      name: pet.name,
      breed: '',
      species: '',
      avatarUrl: pet.imagePath,
      ownerName: 'You',
      isMine: true,
    );
  }

  List<PawPet> _myPawPets() => ref
      .read(switchablePetsProvider)
      .map((r) => PawPet(
            id: r.id.toString(),
            backendId: r.id,
            name: r.name,
            breed: '',
            species: '',
            avatarUrl: r.imagePath,
            ownerName: 'You',
            isMine: true,
          ))
      .toList();

  PawPet _fallbackPet() => PawPet(
        id: '0',
        name: 'Me',
        breed: '',
        species: '',
        avatarUrl: null,
        ownerName: 'You',
        isMine: true,
      );

  /// Reconstruct a minimal domain Post for actions that need it.
  domain.Post _toDomainPost(PawPost p) => domain.Post(
        id: p.backendId,
        author: p.author != null
            ? domain.CommunityPet(
                id: p.author!.backendId,
                name: p.author!.name,
                avatarUrl: p.author!.avatarUrl,
              )
            : null,
        media: const [],
        hashtags: p.hashtags,
        taggedPets: const [],
        likes: p.likes,
        comments: p.totalCommentCount,
        likedByMe: p.likedByMe,
        saved: p.saved,
        isEdited: p.isEdited,
        createdAt: DateTime.now(),
      );

  void _snack(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final actingPet = ref.watch(actingPetProvider);

    final actingPawPet = actingPet != null
        ? PawPet(
            id: actingPet.id.toString(),
            backendId: actingPet.id,
            name: actingPet.name,
            breed: '',
            species: '',
            avatarUrl: actingPet.imagePath,
            ownerName: 'You',
            isMine: true,
          )
        : _fallbackPet();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _searchBar(),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: widget.barsVisible
                  ? _topBar(actingPawPet)
                  : const SizedBox.shrink(),
            ),
            // Background post-upload progress - shown here (below the
            // Following/Discover bar, above the feed) rather than app-wide.
            const UploadProgressBanner(),
            Expanded(
              child: Stack(
                children: [
                  _body(),
                  if (_showNewPill)
                    Positioned(
                      top: AppSpacing.md,
                      left: 0,
                      right: 0,
                      child: NewPostsPill(onTap: _consumeNewPill),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.xl),
        child: FloatingActionButton(
          heroTag: 'pawhub_compose_fab',
          onPressed: _openComposer,
          backgroundColor: AppColors.primary,
          child: const Icon(FluentIcons.add_24_filled, color: AppColors.onPrimary),
        ),
      ),
    );
  }

  /// The search row: pet avatar/switcher on the left, tap-to-search bar in the
  /// middle, saved-posts shortcut on the right.
  Widget _searchBar() {
    final myPets = ref.watch(switchablePetsProvider);
    final actingPet = ref.watch(actingPetProvider);
    final actingPawPet = actingPet != null
        ? PawPet(
            id: actingPet.id.toString(),
            backendId: actingPet.id,
            name: actingPet.name,
            breed: '',
            species: '',
            avatarUrl: actingPet.imagePath,
            ownerName: 'You',
            isMine: true,
          )
        : _fallbackPet();

    final petWidget = myPets.length <= 1
        // Single pet: plain avatar circle → tap opens profile.
        ? GestureDetector(
            onTap: () => _openProfile(actingPawPet),
            child: AppAvatar(
              name: actingPawPet.name,
              imageUrl: actingPawPet.avatarUrl,
              radius: 18,
            ),
          )
        // Multiple pets: switcher pill → tap opens sheet.
        : PetSwitcherPill(pet: actingPawPet, onTap: _switchActingPet);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.md, AppSpacing.sm, AppSpacing.xs, AppSpacing.md),
      child: Row(
        children: [
          petWidget,
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Hero(
              tag: kPawHubSearchHeroTag,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => context.push('/community/search'),
                  borderRadius: AppRadius.lgAll,
                  child: Container(
                    height: 44,
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppRadius.lgAll,
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Row(
                      children: [
                        const Icon(FluentIcons.search_24_regular,
                            size: 20, color: AppColors.textSecondary),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            context.l10n.pawHubSearchHint,
                            style: AppTextStyles.bodyMedium
                                .copyWith(color: AppColors.textTertiary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => context.push('/community/saved'),
            icon: const Icon(FluentIcons.bookmark_24_regular,
                color: AppColors.textPrimary),
            tooltip: context.l10n.pawhubSavedPostsTooltip,
          ),
        ],
      ),
    );
  }

  Widget _topBar(PawPet actingPawPet) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.md, 0, AppSpacing.md, AppSpacing.sm),
      child: FeedTabToggle(
        tab: _tab,
        onChanged: (t) => setState(() => _tab = t),
        followingHasUpdates: _showNewPill,
      ),
    );
  }

  Widget _body() {
    if (_tab == FeedTab.following) {
      return _followingBody();
    } else {
      return _discoverBody();
    }
  }

  Widget _followingBody() {
    final feedState = ref.watch(followingFeedProvider);
    return feedState.when(
      loading: () => _skeletonList(),
      error: (e, _) => _errorView(),
      data: (feed) {
        final posts = feed.posts.map(PawPost.fromEntity).toList();
        if (posts.isEmpty) {
          return FeedEmptyState(
            onDiscover: () => setState(() => _tab = FeedTab.discover),
          );
        }
        return _postList(
          posts: posts,
          hasMore: feed.hasMore,
          loadingMore: feed.loadingMore,
          suggestedPets: const [],
        );
      },
    );
  }

  Widget _discoverBody() {
    final feedState = ref.watch(discoverFeedProvider);
    return feedState.when(
      loading: () => _skeletonList(),
      error: (e, _) => _errorView(),
      data: (discover) {
        final posts = discover.posts.map(PawPost.fromEntity).toList();
        final suggestedPets = discover.suggestedPets.map((e) {
          final pet = PawPet.fromEntity(e);
          if (_followingOverrides.containsKey(pet.backendId)) {
            pet.isFollowing = _followingOverrides[pet.backendId]!;
          }
          return pet;
        }).toList();
        final suggestedPages = discover.suggestedPages.map((e) {
          final p = PawSuggestedPage.fromEntity(e);
          if (_pageFollowingOverrides.containsKey(p.id)) {
            p.isFollowing = _pageFollowingOverrides[p.id]!;
          }
          return p;
        }).toList();
        // Community suggestions now live in the dedicated Communities tab, so
        // Discover is pure post discovery - no communities rail here.
        if (posts.isEmpty) {
          return FeedEmptyState(
            title: context.l10n.pawhubDiscoverEmptyTitle,
            message: context.l10n.pawhubDiscoverEmptyMessage,
          );
        }
        return _postList(
          posts: posts,
          hasMore: discover.cursor.hasMore,
          loadingMore: discover.loadingMore,
          suggestedPets: suggestedPets,
          suggestedPages: suggestedPages,
          adoptionInjections: discover.adoptionInjections,
          reportImpressions: true,
        );
      },
    );
  }

  Widget _skeletonList() => ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: 3,
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.lg),
        itemBuilder: (_, _) => const PostCardSkeleton(),
      );

  Widget _errorView() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(FluentIcons.warning_24_regular,
                size: 48, color: AppColors.textTertiary),
            const SizedBox(height: AppSpacing.md),
            Text(context.l10n.pawHubCouldNotLoadFeed,
                style: AppTextStyles.bodyMedium),
            const SizedBox(height: AppSpacing.sm),
            FilledButton(
                onPressed: _refresh, child: Text(context.l10n.retry)),
          ],
        ),
      );

  Widget _postList({
    required List<PawPost> posts,
    required bool hasMore,
    required bool loadingMore,
    required List<PawPet> suggestedPets,
    List<PawSuggestedPage> suggestedPages = const [],
    List<domain.AdoptionInjection> adoptionInjections = const [],
    bool reportImpressions = false,
    Widget? header,
  }) {
    // Build an explicit list of renderable slots up front, so index math stays
    // in one place regardless of how many rails / injections are interleaved.
    final slots = _buildFeedSlots(
      posts: posts,
      suggestedPets: suggestedPets,
      suggestedPages: suggestedPages,
      adoptionInjections: adoptionInjections,
      reportImpressions: reportImpressions,
      header: header,
    );

    return RefreshIndicator(
      onRefresh: _refresh,
      color: AppColors.primary,
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.xl * 2,
        ),
        itemCount: slots.length + (hasMore ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.lg),
        itemBuilder: (context, index) {
          if (index >= slots.length) {
            WidgetsBinding.instance.addPostFrameCallback((_) => _loadMore());
            return loadingMore
                ? const Padding(
                    padding: EdgeInsets.all(AppSpacing.lg),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox.shrink();
          }
          return slots[index].build(context);
        },
      ),
    );
  }

  /// Flattens posts, suggested rails and adoption injections into an ordered
  /// slot list. Rails keep their legacy positions (pets after post 3, pages
  /// after post 6/7); adoption cards are placed after the post index named by
  /// their `afterPosition` (-1 → before the first post).
  List<_FeedSlot> _buildFeedSlots({
    required List<PawPost> posts,
    required List<PawPet> suggestedPets,
    required List<PawSuggestedPage> suggestedPages,
    required List<domain.AdoptionInjection> adoptionInjections,
    bool reportImpressions = false,
    Widget? header,
  }) {
    final hasPetsRail = suggestedPets.isNotEmpty;
    final hasPagesRail = suggestedPages.isNotEmpty;
    final pagesSlot = hasPetsRail ? 7 : 6;

    // Group injections by the post index they anchor to (clamped into range).
    final injectionsByAnchor = <int, List<domain.AdoptionInjection>>{};
    for (final inj in adoptionInjections) {
      injectionsByAnchor.putIfAbsent(inj.afterPosition, () => []).add(inj);
    }

    _FeedSlot injectionSlot(domain.AdoptionInjection inj) => _FeedSlot(
          (context) => AdoptionInjectionCardWidget(
            card: inj.card,
            onTap: () =>
                context.push(AppRoutes.adoptionDetailPath(inj.card.id)),
          ),
        );

    final slots = <_FeedSlot>[];

    if (header != null) slots.add(_FeedSlot((_) => header));

    // Injections anchored before the first post (afterPosition == -1).
    for (final inj in injectionsByAnchor[-1] ?? const []) {
      slots.add(injectionSlot(inj));
    }

    for (var i = 0; i < posts.length; i++) {
      final post = posts[i];
      slots.add(_FeedSlot(
        (context) {
          final card = PostCard(
            post: post,
            onOpenComments: () => _openComments(post),
            onOpenOptions: () => _openOptions(post),
            onOpenProfile: _openProfile,
            onOpenPage: (id) => context.push('/community/page/$id'),
            onShare: () =>
                sharePostToSheet(ref, _toDomainPost(post), context: context),
          );
          if (!reportImpressions || post.backendId == 0) return card;
          // Report the impression once the card is meaningfully on-screen. The
          // tracker de-dupes, so the repeated callbacks while scrolling are
          // cheap and only the first crossing counts.
          return VisibilityDetector(
            key: Key('impression-${post.backendId}'),
            onVisibilityChanged: (info) {
              if (info.visibleFraction >= 0.5) {
                ref.read(impressionTrackerProvider.notifier).record(
                      postId: post.backendId,
                      petId: ref.read(actingPetIdProvider),
                      surface: domain_enums.ImpressionSurface.discover,
                    );
              }
            },
            child: card,
          );
        },
      ));

      // Legacy rails anchored to post indices.
      if (i == 3 && hasPetsRail) {
        slots.add(_FeedSlot(
          (_) => SuggestedPetsRail(
            pets: suggestedPets,
            onToggleFollow: _toggleFollow,
            onOpenProfile: _openProfile,
          ),
        ));
      }
      if (i == pagesSlot && hasPagesRail) {
        slots.add(_FeedSlot(
          (context) => SuggestedPagesRail(
            pages: suggestedPages,
            onToggleFollow: _togglePageFollow,
            onOpenPage: (id) => openPageDetail(context, id),
          ),
        ));
      }

      // Adoption injections anchored after this post.
      for (final inj in injectionsByAnchor[i] ?? const []) {
        slots.add(injectionSlot(inj));
      }
    }

    // Any injection anchored past the loaded posts falls to the end rather than
    // being dropped (guards against afterPosition >= posts.length).
    for (final entry in injectionsByAnchor.entries) {
      if (entry.key >= posts.length) {
        for (final inj in entry.value) {
          slots.add(injectionSlot(inj));
        }
      }
    }

    return slots;
  }
}

/// A single renderable row in the feed list (post, rail or injection), wrapping
/// a lazy builder so the ListView only materialises visible rows.
class _FeedSlot {
  const _FeedSlot(this.build);

  final Widget Function(BuildContext context) build;
}
