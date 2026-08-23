import 'dart:async';
import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/network/dtos/media_dtos.dart';
import '../../../../core/network/providers/media_datasource_provider.dart';
import '../../../../core/services/media_upload_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../../../../shared/widgets/shimmer.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../domain/entities/community_entities.dart' as domain;
import '../../domain/entities/community_group_entities.dart';
import '../../domain/entities/poll_event_entities.dart';
import '../models/pawhub_models.dart';
import '../providers/community_actions_providers.dart';
import '../providers/community_group_actions_providers.dart';
import '../providers/community_group_feed_providers.dart';
import '../providers/community_providers.dart';
import '../providers/poll_event_providers.dart';
import '../widgets/community_card.dart';
import '../widgets/community_common.dart';
import '../widgets/community_sheet.dart';
import '../widgets/create_choice_sheet.dart';
import '../widgets/event_card.dart';
import '../widgets/pawhub_sheets.dart';
import '../widgets/poll_card.dart';
import '../widgets/post_card.dart';
import '../widgets/post_composer_page.dart';
import 'create_event_page.dart';
import 'create_poll_page.dart';
import 'event_detail_page.dart';
import 'pawhub_pet_profile_page.dart';

/// Which image the lead is replacing in [_editImages].
enum _ImageTarget { avatar, banner }

/// A single community's profile: banner + identity + Join/Leave (or Manage for
/// the lead) + its post feed. Reached via `/community/communities/:id`.
class CommunityDetailPage extends ConsumerStatefulWidget {
  const CommunityDetailPage({required this.communityId, super.key});

  final int communityId;

  @override
  ConsumerState<CommunityDetailPage> createState() =>
      _CommunityDetailPageState();
}

class _CommunityDetailPageState extends ConsumerState<CommunityDetailPage> {
  int get _id => widget.communityId;

  Future<void> _refresh() async {
    await Future.wait([
      ref.read(communityDetailProvider(_id).notifier).refresh(),
      ref.read(communityFeedProvider(_id).notifier).refresh(),
      ref.read(communityPollsProvider(_id).notifier).refresh(),
      ref.read(communityEventsProvider(_id).notifier).refresh(),
    ]);
  }

  /// The community FAB: pick Post / Poll / Event, then route accordingly.
  Future<void> _onCreate(CommunityGroup community) async {
    final choice = await showCreateChoiceSheet(context);
    if (choice == null || !mounted) return;
    switch (choice) {
      case CreateChoice.post:
        await _openComposer(community);
      case CreateChoice.poll:
        await _openCreatePoll(community);
      case CreateChoice.event:
        await _openCreateEvent(community);
    }
  }

  Future<void> _openCreatePoll(CommunityGroup community) async {
    final poll = await Navigator.of(context).push<Poll>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => CreatePollPage(
          communityId: _id,
          communityName: community.name,
        ),
      ),
    );
    if (poll != null && mounted) {
      ref.read(communityPollsProvider(_id).notifier).prepend(poll);
      _snack(context.l10n.pollCreatedToast);
    }
  }

  Future<void> _openCreateEvent(CommunityGroup community) async {
    final event = await Navigator.of(context).push<CommunityEvent>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => CreateEventPage(
          communityId: _id,
          communityName: community.name,
        ),
      ),
    );
    if (event != null && mounted) {
      ref.read(communityEventsProvider(_id).notifier).prepend(event);
      _snack(context.l10n.eventCreatedToast);
    }
  }

  Future<void> _confirmDeletePoll(Poll poll) async {
    final l10n = context.l10n;
    final petId = ref.read(actingPetIdProvider);
    if (petId == null) return;
    final ok = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.delete_24_regular,
      title: l10n.pollDeleteTitle,
      message: l10n.pollDeleteMessage,
      confirmLabel: l10n.communityDelete,
      cancelLabel: l10n.communityCancel,
      isDestructive: true,
    );
    if (!ok) return;
    final result = await ref
        .read(pollEventRepositoryProvider)
        .deletePoll(pollId: poll.id, petId: petId);
    if (!mounted) return;
    result.when(
      success: (_) {
        ref.read(communityPollsProvider(_id).notifier).remove(poll.id);
        _snack(l10n.pollDeletedToast);
      },
      failure: (f) => _snack(f.localizedMessage(l10n)),
    );
  }

  Future<void> _confirmDeleteEvent(CommunityEvent event) async {
    final l10n = context.l10n;
    final petId = ref.read(actingPetIdProvider);
    if (petId == null) return;
    final ok = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.delete_24_regular,
      title: l10n.eventDeleteTitle,
      message: l10n.eventDeleteMessage,
      confirmLabel: l10n.communityDelete,
      cancelLabel: l10n.communityCancel,
      isDestructive: true,
    );
    if (!ok) return;
    final result = await ref
        .read(pollEventRepositoryProvider)
        .deleteEvent(eventId: event.id, actingPetId: petId);
    if (!mounted) return;
    result.when(
      success: (_) {
        ref.read(communityEventsProvider(_id).notifier).remove(event.id);
        _snack(l10n.eventDeletedToast);
      },
      failure: (f) => _snack(f.localizedMessage(l10n)),
    );
  }

  void _openEvent(CommunityEvent event, CommunityGroup community) {
    context.push(
      '/community/events/${event.id}',
      extra: EventDetailArgs(
        communityId: _id,
        canManage: event.creator.isMine || community.isLead,
        communityName: community.name,
      ),
    );
  }

  Future<void> _openComposer(CommunityGroup community) async {
    final myPets = ref.read(switchablePetsProvider);
    final acting = ref.read(actingPetProvider);
    if (myPets.isEmpty || acting == null) return;

    final pawPets = myPets
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
    final actingPaw = pawPets.firstWhere(
      (p) => p.backendId == acting.id,
      orElse: () => pawPets.first,
    );

    final post = await Navigator.of(context).push<PawPost>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => PostComposerPage(
          myPets: pawPets,
          actingAs: actingPaw,
          taggablePets: const [],
          communityId: _id,
          communityName: community.name,
        ),
      ),
    );
    if (post != null && mounted) {
      await ref.read(communityFeedProvider(_id).notifier).refresh();
    }
  }

  Future<void> _confirmLeave(CommunityGroup community) async {
    final l10n = context.l10n;
    final ok = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.sign_out_24_regular,
      title: l10n.communityLeaveConfirmTitle,
      message: l10n.communityLeaveConfirmMessage(community.name),
      confirmLabel: l10n.communityLeave,
      cancelLabel: l10n.communityCancel,
      isDestructive: true,
    );
    if (ok) {
      await ref.read(communityGroupActionsProvider).leave(community);
      if (mounted) _snack(l10n.communityLeftToast(community.name));
    }
  }

  Future<void> _confirmDelete(CommunityGroup community) async {
    final l10n = context.l10n;
    final ok = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.delete_24_regular,
      title: l10n.communityDeleteConfirmTitle,
      message: l10n.communityDeleteConfirmMessage(community.name),
      confirmLabel: l10n.communityDelete,
      cancelLabel: l10n.communityCancel,
      isDestructive: true,
    );
    if (ok) {
      final deleted =
          await ref.read(communityGroupActionsProvider).delete(community.id);
      if (deleted && mounted) {
        _snack(l10n.communityDeletedToast);
        if (context.canPop()) context.pop();
      }
    }
  }

  void _onManage(CommunityGroup community) {
    showCommunitySheet<void>(
      context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(FluentIcons.people_24_regular),
            title: Text(context.l10n.communityDetailViewMembers),
            onTap: () {
              Navigator.pop(ctx);
              context.push('/community/communities/$_id/members');
            },
          ),
          ListTile(
            leading: const Icon(FluentIcons.delete_24_regular,
                color: AppColors.error),
            title: Text(context.l10n.communityDelete,
                style: const TextStyle(color: AppColors.error)),
            onTap: () {
              Navigator.pop(ctx);
              _confirmDelete(community);
            },
          ),
        ],
      ),
    );
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  // ── Lead: edit avatar / banner ──────────────────────────────────────────────

  Future<void> _editImages(CommunityGroup community) async {
    final l10n = context.l10n;
    final choice = await showCommunitySheet<_ImageTarget>(
      context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(FluentIcons.person_circle_24_regular),
            title: Text(l10n.communityEditAvatar),
            onTap: () => Navigator.pop(ctx, _ImageTarget.avatar),
          ),
          ListTile(
            leading: const Icon(FluentIcons.image_24_regular),
            title: Text(l10n.communityEditBanner),
            onTap: () => Navigator.pop(ctx, _ImageTarget.banner),
          ),
        ],
      ),
    );
    if (choice == null || !mounted) return;

    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null || !mounted) return;

    _snack(l10n.communityImagesUpdating);
    final uploader = MediaUploadService(ref.read(mediaDatasourceProvider));
    final result = await uploader.uploadFile(
      file: File(picked.path),
      contentType: 'image/jpeg',
      category: choice == _ImageTarget.avatar
          ? MediaCategory.communityAvatar
          : MediaCategory.communityBanner,
    );
    final assetId = result.when(success: (a) => a.id, failure: (_) => null);
    if (assetId == null) {
      if (mounted) _snack(l10n.communityImagesUpdateFailed);
      return;
    }

    final updated = await ref.read(communityGroupActionsProvider).update(
          communityId: community.id,
          avatarAssetId: choice == _ImageTarget.avatar ? assetId : null,
          bannerAssetId: choice == _ImageTarget.banner ? assetId : null,
        );
    if (mounted) {
      _snack(updated != null
          ? l10n.communityImagesUpdated
          : l10n.communityImagesUpdateFailed);
    }
  }

  // ── Post interactions (mirror PawHub, targeting this community's feed) ──────

  void _openProfile(PawPet pet) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PawHubPetProfilePage(pet: pet, siblings: const []),
      ),
    );
  }

  Future<void> _openPostOptions(PawPost post) async {
    final action = await showPostOptionsSheet(context, post: post);
    if (action == null || !mounted) return;
    final actions = ref.read(communityActionsProvider);

    switch (action) {
      case PostAction.save:
        final saved = await actions.toggleSave(_toDomainPost(post));
        if (mounted) _snack(saved ? 'Saved' : 'Removed from saved');
      case PostAction.copyLink:
      case PostAction.share:
        await _sharePost(post);
      case PostAction.hide:
        ref.read(communityFeedProvider(_id).notifier).removePost(post.backendId);
        _snack('Post hidden');
      case PostAction.report:
        final reason = await showReportSheet(context);
        if (reason != null && mounted) {
          await actions.reportPost(post.backendId, reason);
          _snack('Reported. Thank you.');
        }
      case PostAction.block:
        final authorId = post.author.backendId;
        if (authorId > 0) await actions.block(authorId);
        // Blocking hides the author's posts — refresh this feed.
        await ref.read(communityFeedProvider(_id).notifier).refresh();
      case PostAction.delete:
        final ok = await actions.deletePost(post.backendId);
        if (ok) {
          ref.read(communityFeedProvider(_id).notifier).removePost(post.backendId);
          if (mounted) _snack('Post deleted');
        }
    }
  }

  Future<void> _sharePost(PawPost post) async {
    final url = await ref
        .read(communityActionsProvider)
        .share(_toDomainPost(post), shareMethod: 'copy_link');
    if (url != null && mounted) {
      await Clipboard.setData(ClipboardData(text: url));
      _snack('Link copied');
    }
  }

  /// Minimal domain Post for the cross-cutting actions that need it.
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
        communityId: _id,
      );

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(communityDetailProvider(_id));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: detail.when(
        loading: () => const _CommunityDetailSkeleton(),
        error: (e, _) {
          return _ErrorScaffold(
            failure: e is Failure ? e : null,
            onRetry: () =>
                ref.read(communityDetailProvider(_id).notifier).refresh(),
          );
        },
        data: (community) {
          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: _refresh,
            child: _content(community),
          );
        },
      ),
      floatingActionButton: detail.value?.isMember == true
          ? FloatingActionButton(
              heroTag: 'community_compose_fab',
              onPressed: () => _onCreate(detail.value!),
              backgroundColor: AppColors.primary,
              child: const Icon(FluentIcons.add_24_filled,
                  color: AppColors.onPrimary),
            )
          : null,
    );
  }

  Widget _content(CommunityGroup community) {
    final feed = ref.watch(communityFeedProvider(_id));
    final pollsAsync = ref.watch(communityPollsProvider(_id));
    final eventsAsync = ref.watch(communityEventsProvider(_id));

    final posts = feed.value?.posts ?? const [];
    final polls = pollsAsync.value?.polls ?? const <Poll>[];
    final events = eventsAsync.value?.events ?? const <CommunityEvent>[];

    // Merge posts + polls + events into one chronological stream (newest
    // first), so polls & events render inline with posts per the design.
    final items = _mergeFeed(posts, polls, events);

    // Feed is "loading" only while the *first* page of all three is still
    // pending; once any has data we show the merged list.
    final anyLoading =
        feed.isLoading || pollsAsync.isLoading || eventsAsync.isLoading;
    final feedHasMore = feed.value?.hasMore ?? false;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _Header(
            community: community,
            onEditImages:
                community.isLead ? () => _editImages(community) : null,
            action: _HeaderAction(
              community: community,
              onLeave: () => _confirmLeave(community),
              onManage: () => _onManage(community),
            ),
          ),
        ),
        SliverToBoxAdapter(child: _StatsCard(community: community)),
        SliverToBoxAdapter(child: _MembersCard(communityId: _id)),
        if (items.isEmpty && anyLoading)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.lg),
              child: Shimmer(child: _PostSkeleton()),
            ),
          )
        else if (items.isEmpty)
          SliverToBoxAdapter(
            child: _EmptyFeedCard(
              isMember: community.isMember,
              onCreate:
                  community.isMember ? () => _onCreate(community) : null,
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.xl * 2),
            sliver: SliverList.separated(
              itemCount: items.length + (feedHasMore ? 1 : 0),
              separatorBuilder: (_, _) =>
                  const SizedBox(height: AppSpacing.lg),
              itemBuilder: (context, i) {
                if (i >= items.length) {
                  WidgetsBinding.instance.addPostFrameCallback((_) => ref
                      .read(communityFeedProvider(_id).notifier)
                      .loadMore());
                  return const Padding(
                    padding: EdgeInsets.all(AppSpacing.lg),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return _buildFeedItem(items[i], community);
              },
            ),
          ),
        // Bottom clearance so the center FAB never covers content.
        const SliverToBoxAdapter(child: SizedBox(height: 96)),
      ],
    );
  }

  /// Merges the three streams into one list ordered by `createdAt` descending.
  List<_FeedItem> _mergeFeed(
    List<domain.Post> posts,
    List<Poll> polls,
    List<CommunityEvent> events,
  ) {
    final items = <_FeedItem>[
      for (final p in posts) _PostItem(p),
      for (final p in polls) _PollItem(p),
      for (final e in events) _EventItem(e),
    ];
    items.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return items;
  }

  Widget _buildFeedItem(_FeedItem item, CommunityGroup community) {
    switch (item) {
      case _PostItem(:final post):
        final paw = PawPost.fromEntity(post);
        return PostCard(
          post: paw,
          // Inside a community's own feed the community tag is redundant.
          showCommunityBadge: false,
          onOpenComments: () =>
              context.push('/community/post/${paw.backendId}'),
          onOpenOptions: () => _openPostOptions(paw),
          onOpenProfile: _openProfile,
          onShare: () => _sharePost(paw),
        );
      case _PollItem(:final poll):
        return PollCard(
          poll: poll,
          communityId: _id,
          isMember: community.isMember,
          canManage: poll.creator.isMine || community.isLead,
          onDelete: () => _confirmDeletePoll(poll),
        );
      case _EventItem(:final event):
        return EventCard(
          event: event,
          communityId: _id,
          isMember: community.isMember,
          canManage: event.creator.isMine || community.isLead,
          onTap: () => _openEvent(event, community),
          onDelete: () => _confirmDeleteEvent(event),
        );
    }
  }
}

/// A merged community-feed entry: a post, poll, or event. Sorted by [createdAt].
sealed class _FeedItem {
  const _FeedItem();
  DateTime get createdAt;
}

class _PostItem extends _FeedItem {
  const _PostItem(this.post);
  final domain.Post post;
  @override
  DateTime get createdAt => post.createdAt;
}

class _PollItem extends _FeedItem {
  const _PollItem(this.poll);
  final Poll poll;
  @override
  DateTime get createdAt => poll.createdAt;
}

class _EventItem extends _FeedItem {
  const _EventItem(this.event);
  final CommunityEvent event;
  @override
  DateTime get createdAt => event.createdAt;
}

// ── Header pieces ──────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  const _Header({
    required this.community,
    required this.action,
    this.onEditImages,
  });

  final CommunityGroup community;

  /// The Manage / Leave / Join control shown beside the name.
  final Widget action;

  /// Lead-only: opens the edit-images flow (null for non-leads).
  final VoidCallback? onEditImages;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final topInset = MediaQuery.of(context).padding.top;

    return Column(
      // Stretch so every child gets the full bounded width — otherwise the
      // Column measures intrinsic width and the name-row's Expanded/button
      // receive infinite width (white-screen layout crash).
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Banner with a bottom gradient scrim so overlaid controls read.
            // No explicit width — the stretched parent Column supplies a finite
            // full width; `double.infinity` here would feed infinity into the
            // Column's intrinsic-width pass and crash the layout.
            SizedBox(
              height: 160,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppCachedImage(imageUrl: community.bannerUrl, height: 160),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black26],
                        stops: [0.55, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Back button.
            Positioned(
              top: topInset + AppSpacing.xs,
              left: AppSpacing.xs,
              child: _CircleGlyphButton(
                icon: FluentIcons.arrow_left_24_filled,
                onTap: () => context.canPop() ? context.pop() : null,
              ),
            ),
            // Lead-only edit-banner button.
            if (onEditImages != null)
              Positioned(
                top: topInset + AppSpacing.xs,
                right: AppSpacing.xs,
                child: _CircleGlyphButton(
                  icon: FluentIcons.camera_24_filled,
                  onTap: onEditImages!,
                ),
              ),
            // Avatar overlapping the banner's lower-left, with a paw badge.
            Positioned(
              bottom: -36,
              left: AppSpacing.lg,
              child: GestureDetector(
                onTap: onEditImages,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColors.background, width: 4),
                      ),
                      child: AppAvatar(
                        name: community.name,
                        imageUrl: community.avatarUrl,
                        radius: 40,
                      ),
                    ),
                    // Orange paw badge (or camera glyph when the lead can edit).
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: onEditImages != null
                          ? const _EditGlyph()
                          : const _PawBadge(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 48),
        // Name + type pill + action. This row uses left-only padding so the
        // action button reaches the right screen edge, while the rest of the
        // header content below keeps the standard horizontal padding.
        Padding(
          padding: const EdgeInsets.only(
              left: AppSpacing.lg, right: AppSpacing.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name + type pill share the left region (Expanded absorbs all
              // free space) so the action is pushed hard to the right edge.
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(community.name,
                          style: AppTextStyles.headlineMedium),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: _MetaPill(
                        icon: FluentIcons.tag_24_regular,
                        label: community.category.label(l10n),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              action,
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if ((community.description ?? '').isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  community.description!,
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textSecondary),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              // "Led by" with the lead pet's avatar.
              Row(
                children: [
                  AppAvatar(
                    name: community.lead.name,
                    imageUrl: community.lead.avatarUrl,
                    radius: 12,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    l10n.communityLedBy(community.lead.name),
                    style: AppTextStyles.labelMedium
                        .copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A translucent circular button for overlaying on the banner (back / camera).
class _CircleGlyphButton extends StatelessWidget {
  const _CircleGlyphButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.35),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}

/// The small camera badge on the avatar in edit mode.
class _EditGlyph extends StatelessWidget {
  const _EditGlyph();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.background, width: 2),
      ),
      child: const Icon(FluentIcons.camera_24_filled,
          size: 12, color: AppColors.onPrimary),
    );
  }
}

/// A subtle icon+label pill for the header metadata row.
class _MetaPill extends StatelessWidget {
  const _MetaPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.smAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.labelSmall
                .copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

/// Orange paw badge shown on the community avatar (non-editable view).
class _PawBadge extends StatelessWidget {
  const _PawBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.background, width: 2),
      ),
      child: const Icon(FluentIcons.animal_paw_print_24_filled,
          size: 12, color: AppColors.onPrimary),
    );
  }
}

/// The primary action beside the community name: Manage (lead), Leave (member),
/// or Join (visitor). Compact so it fits on the name row.
class _HeaderAction extends StatelessWidget {
  const _HeaderAction({
    required this.community,
    required this.onLeave,
    required this.onManage,
  });

  final CommunityGroup community;
  final VoidCallback onLeave;
  final VoidCallback onManage;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (community.isLead) {
      return _OutlinePill(
        label: l10n.communityManage,
        icon: FluentIcons.settings_24_regular,
        color: AppColors.primary,
        onTap: onManage,
      );
    }
    if (community.isMember) {
      return _OutlinePill(
        label: l10n.communityLeave,
        icon: FluentIcons.sign_out_24_regular,
        color: AppColors.error,
        onTap: onLeave,
      );
    }
    return CommunityJoinButton(community: community);
  }
}

/// A compact outlined pill used as the header action. Built from Container +
/// InkWell (not a Material button) so it sizes to its content and never
/// asserts under a wide/unbounded parent constraint.
class _OutlinePill extends StatelessWidget {
  const _OutlinePill({
    required this.label,
    required this.color,
    required this.onTap,
    this.icon,
  });

  final String label;
  final Color color;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.lgAll,
        side: BorderSide(color: color),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.lgAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: color),
                const SizedBox(width: AppSpacing.xs),
              ],
              Text(label,
                  style: AppTextStyles.labelMedium.copyWith(color: color)),
            ],
          ),
        ),
      ),
    );
  }
}

/// A white rounded card used for the stats / about / members sections.
class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child, this.padding});

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.xs),
      child: Container(
        width: double.infinity,
        padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.lgAll,
          border: Border.all(color: AppColors.divider),
        ),
        child: child,
      ),
    );
  }
}

/// The Member / Posts stats card (2 columns; Likes omitted until backed).
class _StatsCard extends StatelessWidget {
  const _StatsCard({required this.community});

  final CommunityGroup community;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _SectionCard(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: SizedBox(
        height: 44,
        child: Row(
          children: [
            Expanded(
              child: _StatColumn(
                icon: FluentIcons.people_24_filled,
                iconColor: AppColors.secondary,
                iconBg: AppColors.secondarySoft,
                value: community.memberCount,
                label: l10n.communityDetailMembers,
              ),
            ),
            Container(width: 1, color: AppColors.divider),
            Expanded(
              child: _StatColumn(
                icon: FluentIcons.animal_paw_print_24_filled,
                iconColor: AppColors.primary,
                iconBg: AppColors.primarySoft,
                value: community.postCount,
                label: l10n.communityStatPosts,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const SizedBox(width: AppSpacing.sm),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$value', style: AppTextStyles.titleMedium),
            Text(label,
                style: AppTextStyles.labelSmall
                    .copyWith(color: AppColors.textSecondary)),
          ],
        ),
      ],
    );
  }
}

/// The members card: header row + a horizontal strip of member avatars, the
/// lead crowned and labelled "Leader".
class _MembersCard extends ConsumerWidget {
  const _MembersCard({required this.communityId});

  final int communityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final preview = ref.watch(communityMemberPreviewProvider(communityId)).value;
    final members = preview?.members ?? const [];
    final count = preview?.count ?? members.length;

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () =>
                context.push('/community/communities/$communityId/members'),
            child: Row(
              children: [
                Expanded(
                  child: Text(l10n.communityDetailMembers,
                      style: AppTextStyles.titleSmall),
                ),
                Text(l10n.communityMembersCount(count),
                    style: AppTextStyles.labelMedium
                        .copyWith(color: AppColors.textSecondary)),
                const Icon(FluentIcons.chevron_right_24_regular,
                    size: 18, color: AppColors.textSecondary),
              ],
            ),
          ),
          if (members.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 84,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: members.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: AppSpacing.lg),
                itemBuilder: (context, i) {
                  final m = members[i];
                  return SizedBox(
                    width: 64,
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            AppAvatar(
                              name: m.pet.name,
                              imageUrl: m.pet.avatarUrl,
                              radius: 26,
                            ),
                            if (m.isLead)
                              const Positioned(
                                top: -6,
                                right: -2,
                                child: _CrownBadge(),
                              ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(m.pet.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.labelSmall),
                        if (m.isLead)
                          Text(l10n.communityLeaderLabel,
                              style: AppTextStyles.labelSmall
                                  .copyWith(color: AppColors.secondary)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CrownBadge extends StatelessWidget {
  const _CrownBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.surface, width: 2),
      ),
      child: const Icon(FluentIcons.crown_24_filled,
          size: 10, color: AppColors.onSecondary),
    );
  }
}

/// The richer empty-feed card: illustration glyph, title, subtitle, and a
/// "Create first post" button for members.
class _EmptyFeedCard extends StatelessWidget {
  const _EmptyFeedCard({required this.isMember, this.onCreate});

  final bool isMember;
  final VoidCallback? onCreate;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _SectionCard(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, vertical: AppSpacing.xl),
      child: Column(
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: const BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(FluentIcons.image_24_regular,
                size: 40, color: AppColors.primary),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.communityDetailFeedEmptyTitle,
              style: AppTextStyles.titleMedium, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isMember
                ? l10n.communityDetailFeedEmpty
                : l10n.communityDetailJoinToPost,
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          if (onCreate != null) ...[
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: onCreate,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg, vertical: AppSpacing.md),
              ),
              icon: const Icon(FluentIcons.compose_24_regular, size: 18),
              label: Text(l10n.communityCreateFirstPost),
            ),
          ],
        ],
      ),
    );
  }
}

/// Shimmer skeleton mirroring the loaded detail layout: banner + avatar,
/// name/pill, stats card, members card, and a post placeholder.
class _CommunityDetailSkeleton extends StatelessWidget {
  const _CommunityDetailSkeleton();

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    return Shimmer(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: topInset),
        children: [
          // Banner + overlapping avatar.
          const Stack(
            clipBehavior: Clip.none,
            children: [
              SkeletonBox(
                height: 160,
                borderRadius: BorderRadius.zero,
              ),
              Positioned(
                bottom: -36,
                left: AppSpacing.lg,
                child: SkeletonBox(
                  width: 80,
                  height: 80,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          // Name + pill.
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                SkeletonLine(width: 160, height: 22),
                SizedBox(width: AppSpacing.sm),
                SkeletonBox(width: 64, height: 22),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: SkeletonLine(width: 220),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Stats card.
          _card(const SizedBox(height: 44)),
          // Members card.
          _card(const SizedBox(height: 84)),
          // A post placeholder.
          const Padding(
            padding: EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
            child: _PostSkeleton(),
          ),
        ],
      ),
    );
  }

  Widget _card(Widget child) => Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.xs),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.lgAll,
            border: Border.all(color: AppColors.divider),
          ),
          child: child,
        ),
      );
}

/// A single post-card shimmer placeholder (author row + media block + caption).
class _PostSkeleton extends StatelessWidget {
  const _PostSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            SkeletonBox(width: 40, height: 40, shape: BoxShape.circle),
            SizedBox(width: AppSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLine(width: 120, height: 14),
                SizedBox(height: 6),
                SkeletonLine(width: 80, height: 10),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        SkeletonBox(
          width: double.infinity,
          height: 200,
          borderRadius: AppRadius.lgAll,
        ),
        const SizedBox(height: AppSpacing.md),
        const SkeletonLine(width: double.infinity),
        const SizedBox(height: 6),
        const SkeletonLine(width: 200),
      ],
    );
  }
}

class _ErrorScaffold extends StatelessWidget {
  const _ErrorScaffold({this.failure, this.onRetry});

  final Failure? failure;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: IconButton(
              icon: const Icon(FluentIcons.arrow_left_24_regular),
              onPressed: () => context.canPop() ? context.pop() : null,
            ),
          ),
          Expanded(
            child: ErrorStateWidget(failure: failure, onRetry: onRetry),
          ),
        ],
      ),
    );
  }
}
