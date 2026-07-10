import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/pawhub_models.dart';
import '../widgets/pawhub_comments.dart';
import '../widgets/pawhub_common.dart';
import '../widgets/pawhub_feed_widgets.dart';
import '../widgets/pawhub_notifications.dart';
import '../widgets/pawhub_sheets.dart';
import '../widgets/pet_profile_sheet.dart';
import '../widgets/post_card.dart';
import '../widgets/post_composer_page.dart';

/// PawHub — the pet social feed. This is an interactive PROTOTYPE wired
/// entirely to in-memory dummy data (see PawHubDummy). Every widget in the
/// PawHub library is exercised here so the flows can be clicked through
/// end-to-end before the backend exists. See docs/pawhub-design.md.
class PawHubPage extends StatefulWidget {
  const PawHubPage({super.key});

  @override
  State<PawHubPage> createState() => _PawHubPageState();
}

class _PawHubPageState extends State<PawHubPage> {
  final _scrollController = ScrollController();

  // Signed-in account's pets + the active persona (the Pet Switcher spine).
  final List<PawPet> _myPets = PawHubDummy.myPets;
  late PawPet _actingAs = _myPets.first;

  FeedTab _tab = FeedTab.following;

  // Feed data (mutable for the prototype).
  final List<PawPost> _following = [];
  final List<PawPost> _discover = [];
  bool _loadingInitial = true;
  bool _loadingMore = false;
  bool _hasMore = true;
  int _page = 0;

  // "New posts" pill visibility.
  bool _showNewPill = false;

  // Notifications.
  late final List<PawNotif> _notifs = PawHubDummy.notifications();
  int get _unread => _notifs.where((n) => !n.isRead).length;

  final bool _alertDismissed = false;

  @override
  void initState() {
    super.initState();
    _bootstrap();
    // Fake a fresh-content arrival so the "new posts" pill is demoable.
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) setState(() => _showNewPill = true);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _bootstrap() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() {
      _following.addAll(PawHubDummy.feed());
      _discover.addAll(PawHubDummy.suggestedPets().isEmpty
          ? []
          : PawHubDummy.morePage(0));
      _loadingInitial = false;
    });
  }

  List<PawPost> get _activeList =>
      _tab == FeedTab.following ? _following : _discover;

  Future<void> _refresh() async {
    unawaited(HapticFeedback.selectionClick());
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() {
      _showNewPill = false;
      _page = 0;
      _hasMore = true;
      _activeList
        ..clear()
        ..addAll(_tab == FeedTab.following
            ? PawHubDummy.feed()
            : PawHubDummy.morePage(0));
    });
  }

  Future<void> _loadMore() async {
    if (_loadingMore || !_hasMore) return;
    setState(() => _loadingMore = true);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() {
      _page++;
      _activeList.addAll(PawHubDummy.morePage(_page));
      _loadingMore = false;
      if (_page >= 3) _hasMore = false; // cap the demo
    });
  }

  void _consumeNewPill() {
    setState(() => _showNewPill = false);
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
    _refresh();
  }

  Future<void> _switchActingPet() async {
    final chosen = await showPetSwitcherSheet(
      context,
      pets: _myPets,
      current: _actingAs,
    );
    if (chosen != null) {
      setState(() => _actingAs = chosen);
      unawaited(HapticFeedback.selectionClick());
    }
  }

  Future<void> _openComposer() async {
    final post = await Navigator.of(context).push<PawPost>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => PostComposerPage(
          myPets: _myPets,
          actingAs: _actingAs,
          taggablePets: PawHubDummy.suggestedPets(),
        ),
      ),
    );
    if (post != null && mounted) {
      setState(() => _following.insert(0, post));
      _snack('Posted as ${post.author.name} 🐾');
    }
  }

  void _openComments(PawPost post) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CommentsSheet(
        post: post,
        actingAs: _actingAs,
        myPets: _myPets,
        onActingAsChanged: (p) => setState(() => _actingAs = p),
      ),
    ).whenComplete(() => setState(() {})); // refresh comment counts
  }

  Future<void> _openOptions(PawPost post) async {
    final action = await showPostOptionsSheet(context, post: post);
    if (action == null || !mounted) return;
    switch (action) {
      case PostAction.save:
        setState(() => post.saved = !post.saved);
        _snack(post.saved ? 'Saved' : 'Removed from saved');
      case PostAction.copyLink:
        unawaited(Clipboard.setData(
            ClipboardData(text: 'https://petaverse.app/p/${post.id}')));
        _snack('Link copied');
      case PostAction.share:
        _snack('Opening share sheet… (stub)');
      case PostAction.hide:
        setState(() => _activeList.remove(post));
        _snack('Post hidden');
      case PostAction.report:
        final reason = await showReportSheet(context);
        if (reason != null) _snack('Reported: $reason. Thank you.');
      case PostAction.block:
        setState(() =>
            _activeList.removeWhere((p) => p.author.id == post.author.id));
        _snack('Blocked ${post.author.ownerName}');
      case PostAction.edit:
        unawaited(_editCaption(post));
      case PostAction.delete:
        setState(() => _activeList.remove(post));
        _snack('Post deleted');
    }
  }

  Future<void> _editCaption(PawPost post) async {
    final controller = TextEditingController(text: post.caption);
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
            Text('Edit caption', style: AppTextStyles.titleMedium),
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
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
    if (result != null && mounted) {
      setState(() {
        post.caption = result;
        post.isEdited = true;
      });
      _snack('Caption updated');
    }
  }

  void _openProfile(PawPet pet) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PetProfileSheet(
        pet: pet,
        siblings: pet.isMine
            ? _myPets.where((p) => p.id != pet.id).toList()
            : const [],
        postThumbnails: List.generate(
          9,
          (i) => 'https://picsum.photos/seed/${pet.id}_grid_$i/300/300',
        ),
      ),
    ).whenComplete(() => setState(() {}));
  }

  void _openNotifications() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => NotificationsSheet(items: _notifs),
    ).whenComplete(() => setState(() {}));
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _topBar(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _openComposer,
        backgroundColor: AppColors.primary,
        child: const Icon(FluentIcons.add_24_filled, color: AppColors.onPrimary),
      ),
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.md, AppSpacing.sm, AppSpacing.sm, AppSpacing.sm),
      child: Row(
        children: [
          PetSwitcherPill(pet: _actingAs, onTap: _switchActingPet),
          const Spacer(),
          Center(
            child: FeedTabToggle(
              tab: _tab,
              onChanged: (t) => setState(() => _tab = t),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: _openNotifications,
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(FluentIcons.alert_24_regular,
                    color: AppColors.textPrimary),
                if (_unread > 0)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: CountBadge(count: _unread),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    if (_loadingInitial) {
      return ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: 3,
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.lg),
        itemBuilder: (_, _) => const PostCardSkeleton(),
      );
    }

    final list = _activeList;
    if (_tab == FeedTab.following && list.isEmpty) {
      return FeedEmptyState(
        onDiscover: () => setState(() => _tab = FeedTab.discover),
      );
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      color: AppColors.primary,
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.all(AppSpacing.lg),
        // +1 alert card, +1 suggested rail, +maybe a load-more footer.
        itemCount: list.length + 2 + (_hasMore ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.lg),
        itemBuilder: (context, index) {
          // Index 0: Lost & Found alert injection (safety-first).
          if (index == 0) {
            if (_alertDismissed) return const SizedBox.shrink();
            return AlertCard(
              alert: PawHubDummy.alert,
              onView: () => _snack('Opening Lost & Found map… (stub)'),
            );
          }
          // Insert a suggested-pets rail after the 3rd post.
          final adjusted = index - 1;
          if (adjusted == 3) {
            return SuggestedPetsRail(
              pets: PawHubDummy.suggestedPets(),
              onToggleFollow: (p) => setState(() {
                p.isFollowing = !p.isFollowing;
                _snack(p.isFollowing
                    ? 'Following ${p.name}'
                    : 'Unfollowed ${p.name}');
              }),
              onOpenProfile: _openProfile,
            );
          }
          final postIndex = adjusted > 3 ? adjusted - 1 : adjusted;

          if (postIndex >= list.length) {
            // Load-more footer.
            WidgetsBinding.instance.addPostFrameCallback((_) => _loadMore());
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final post = list[postIndex];
          return PostCard(
            post: post,
            onOpenComments: () => _openComments(post),
            onOpenOptions: () => _openOptions(post),
            onOpenProfile: _openProfile,
            onShare: () => _snack('Opening share sheet… (stub)'),
          );
        },
      ),
    );
  }
}
