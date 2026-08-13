import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/community_entities.dart' as domain;
import '../../domain/entities/community_enums.dart' as domain_enums;
import '../../domain/entities/community_group_entities.dart';
import '../models/pawhub_models.dart';
import '../providers/community_actions_providers.dart';
import '../providers/community_feed_providers.dart';
import '../providers/community_notifications_providers.dart';
import '../providers/community_providers.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../widgets/community_discover_rail.dart';
import '../widgets/pawhub_comments.dart';
import '../widgets/pawhub_common.dart';
import '../widgets/pawhub_feed_widgets.dart';
import '../widgets/pawhub_notifications.dart';
import '../widgets/pawhub_sheets.dart';
import '../widgets/post_card.dart';
import '../widgets/post_composer_page.dart';
import '../widgets/upload_progress_banner.dart';
import 'pawhub_search_page.dart';
import 'pawhub_pet_profile_page.dart';

/// PawHub — the pet social feed, wired to real backend providers.
class PawHubPage extends ConsumerStatefulWidget {
  const PawHubPage({super.key});

  @override
  ConsumerState<PawHubPage> createState() => _PawHubPageState();
}

class _PawHubPageState extends ConsumerState<PawHubPage> {
  final _scrollController = ScrollController();

  FeedTab _tab = FeedTab.following;
  bool _showNewPill = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
    );
    if (chosen != null) {
      unawaited(HapticFeedback.selectionClick());
      // The acting pet is derived from PetsNotifier.currentPet —
      // selectPet changes it app-wide.
      final notifier = ref.read(petsProvider.notifier);
      notifier.selectPet(chosen.backendId);
    }
  }

  // ── Feed actions ──────────────────────────────────────────────────────────

  Future<void> _refresh() async {
    unawaited(HapticFeedback.selectionClick());
    setState(() => _showNewPill = false);
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
        unawaited(Clipboard.setData(
            ClipboardData(text: 'https://petaverse.app/p/${post.backendId}')));
        _snack(context.l10n.pawHubLinkCopied);
      case PostAction.share:
        final url = await actions.share(domainPost, shareMethod: 'copy_link');
        if (url != null && mounted) {
          unawaited(Clipboard.setData(ClipboardData(text: url)));
          _snack(context.l10n.pawHubLinkCopied);
        }
      case PostAction.hide:
        // Only following feed supports removePost; discover just refreshes.
        if (_tab == FeedTab.following) {
          ref.read(followingFeedProvider.notifier).removePost(post.backendId);
        } else {
          unawaited(ref.read(discoverFeedProvider.notifier).refresh());
        }
        _snack(context.l10n.pawHubPostHidden);
      case PostAction.report:
        final reason = await showReportSheet(context);
        if (reason != null && mounted) {
          await actions.reportPost(post.backendId, reason);
          if (mounted) _snack(context.l10n.pawHubPostReported);
        }
      case PostAction.block:
        final authorId = post.author.backendId;
        if (authorId > 0) await actions.block(authorId);
        if (mounted) _snack(context.l10n.pawHubBlockedUser(post.author.ownerName));
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
    final communityPet = domain.CommunityPet(
      id: pet.backendId,
      name: pet.name,
      avatarUrl: pet.avatarUrl,
      ownerName: pet.ownerName,
      isFollowing: pet.isFollowing,
    );
    final nowFollowing =
        await ref.read(communityActionsProvider).toggleFollow(communityPet);
    setState(() {
      pet.isFollowing = nowFollowing;
      _snack(nowFollowing
          ? context.l10n.pawHubFollowingPet(pet.name)
          : context.l10n.pawHubUnfollowedPet(pet.name));
    });
  }

  void _openNotifications() {
    // Build PawNotif view-models from the domain notifications.
    final notifState = ref.read(communityNotificationsProvider);
    final notifs = notifState.value?.notifications
            .map(_notifFromDomain)
            .toList() ??
        [];
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      builder: (_) => NotificationsSheet(items: notifs),
    ).whenComplete(() {
      setState(() {});
      // Mark all as read when the sheet closes.
      ref.read(communityNotificationsProvider.notifier).markAllRead();
    });
  }

  Future<void> _openComposer() async {
    final myPets = _myPawPets();
    final actingPet = _currentActingPawPet();
    if (myPets.isEmpty) {
      _snack(context.l10n.pawHubAddPetFirstToPost);
      return;
    }
    final post = await Navigator.of(context).push<PawPost>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => PostComposerPage(
          myPets: myPets,
          actingAs: actingPet,
          taggablePets: const [],
        ),
      ),
    );
    if (post != null && mounted) {
      // The real post comes from the provider (createPost calls refresh).
      setState(() {});
      _snack(context.l10n.pawHubPostedAs(post.author.name));
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
        author: domain.CommunityPet(
          id: p.author.backendId,
          name: p.author.name,
          avatarUrl: p.author.avatarUrl,
        ),
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

  PawNotif _notifFromDomain(domain.CommunityNotification n) {
    final actor = n.actor != null
        ? PawPet.fromEntity(n.actor!)
        : _fallbackPet();
    return PawNotif(
      id: n.id,
      type: _notifType(n.type),
      actor: actor,
      text: n.text,
      timeAgo: n.timeAgo ?? '',
      thumbnailUrl: n.thumbnailUrl,
      isRead: n.isRead,
    );
  }

  PawNotifType _notifType(domain_enums.NotificationType t) =>
      switch (t) {
        domain_enums.NotificationType.like => PawNotifType.like,
        domain_enums.NotificationType.comment => PawNotifType.comment,
        domain_enums.NotificationType.reply => PawNotifType.reply,
        domain_enums.NotificationType.follow => PawNotifType.follow,
        domain_enums.NotificationType.mention => PawNotifType.mention,
        domain_enums.NotificationType.tagged => PawNotifType.tagged,
        domain_enums.NotificationType.alert => PawNotifType.alert,
      };

  void _snack(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final actingPet = ref.watch(actingPetProvider);
    final unreadCount = ref.watch(communityUnreadCountProvider);

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
            _searchBar(unreadCount),
            _topBar(actingPawPet),
            // Background post-upload progress — shown here (below the
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

  /// The search row: a tap-to-search bar (opens the full PawHub search screen,
  /// sharing a [Hero] with the search page's field) plus the notifications bell
  /// beside it.
  Widget _searchBar(int unreadCount) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.md, AppSpacing.sm, AppSpacing.xs, AppSpacing.xs),
      child: Row(
        children: [
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
          IconButton(
            onPressed: _openNotifications,
            tooltip: context.l10n.pawHubNotificationsTitle,
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(FluentIcons.alert_24_regular,
                    color: AppColors.textPrimary),
                if (unreadCount > 0)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: CountBadge(count: unreadCount),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _topBar(PawPet actingPawPet) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.sm),
      child: Row(
        children: [
          PetSwitcherPill(pet: actingPawPet, onTap: _switchActingPet),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: FeedTabToggle(
              tab: _tab,
              onChanged: (t) => setState(() => _tab = t),
              followingHasUpdates: _showNewPill,
            ),
          ),
        ],
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
        final suggestedPets =
            discover.suggestedPets.map(PawPet.fromEntity).toList();
        final rail = _communityRail(discover.suggestedCommunities);
        // With no posts, still surface the communities rail above the empty
        // state so Discover isn't blank when only suggestions exist.
        if (posts.isEmpty) {
          return ListView(
            children: [
              rail,
              // No CTA here — already on the Discover tab — and Discover-specific
              // copy (not the "follow some pets" Following wording).
              FeedEmptyState(
                title: context.l10n.pawhubDiscoverEmptyTitle,
                message: context.l10n.pawhubDiscoverEmptyMessage,
              ),
            ],
          );
        }
        return _postList(
          posts: posts,
          hasMore: discover.cursor.hasMore,
          loadingMore: discover.loadingMore,
          suggestedPets: suggestedPets,
          header: rail,
        );
      },
    );
  }

  /// The "Communities to join" rail shown atop the Discover feed, fed by the
  /// discover response. Renders nothing when there are no suggestions.
  Widget _communityRail(List<CommunityGroup> communities) {
    if (communities.isEmpty) return const SizedBox.shrink();
    return CommunityDiscoverRail(
      communities: communities,
      onOpen: (c) => context.push('/community/communities/${c.id}'),
      onSeeAll: () => context.push('/community/communities'),
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
    Widget? header,
  }) {
    final hasHeader = header != null;
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
        // +1 for optional header, +1 slot for suggested rail, +1 for load-more.
        itemCount: posts.length +
            (hasHeader ? 1 : 0) +
            (suggestedPets.isNotEmpty ? 1 : 0) +
            (hasMore ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.lg),
        itemBuilder: (context, rawIndex) {
          // A header (e.g. the communities rail) occupies slot 0 on Discover.
          if (hasHeader && rawIndex == 0) return header;
          final index = hasHeader ? rawIndex - 1 : rawIndex;
          // Insert suggested-pets rail after the 3rd post.
          if (index == 3 && suggestedPets.isNotEmpty) {
            return SuggestedPetsRail(
              pets: suggestedPets,
              onToggleFollow: _toggleFollow,
              onOpenProfile: _openProfile,
            );
          }
          final postIndex =
              suggestedPets.isNotEmpty && index > 3 ? index - 1 : index;

          if (postIndex >= posts.length) {
            WidgetsBinding.instance.addPostFrameCallback((_) => _loadMore());
            return loadingMore
                ? const Padding(
                    padding: EdgeInsets.all(AppSpacing.lg),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox.shrink();
          }

          final post = posts[postIndex];
          return PostCard(
            post: post,
            onOpenComments: () => _openComments(post),
            onOpenOptions: () => _openOptions(post),
            onOpenProfile: _openProfile,
            onShare: () => _openOptions(post),
          );
        },
      ),
    );
  }
}
