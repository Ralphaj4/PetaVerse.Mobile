import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/analytics/analytics_events.dart';
import '../../../../core/analytics/analytics_service.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../../../../shared/widgets/shimmer.dart';
import '../../../community/domain/entities/community_enums.dart';
import '../../../community/presentation/models/pawhub_models.dart';
import '../../../community/presentation/pages/pawhub_pet_profile_page.dart';
import '../../../community/presentation/providers/community_providers.dart';
import '../../../community/presentation/widgets/pawhub_comments.dart';
import '../../../community/presentation/widgets/pawhub_common.dart';
import '../../../community/presentation/widgets/pawhub_sheets.dart';
import '../../../community/presentation/widgets/post_card.dart';
import '../../../community/presentation/widgets/post_share.dart';
import '../../../pets/domain/entities/pet_ref.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../providers/page_providers.dart';

void openPageDetail(BuildContext context, int pageId) {
  if (pageId <= 0) return;
  Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => PageDetailPage(pageId: pageId)),
  );
}

class PageDetailPage extends ConsumerStatefulWidget {
  const PageDetailPage({required this.pageId, super.key});

  final int pageId;

  @override
  ConsumerState<PageDetailPage> createState() => _PageDetailPageState();
}

class _PageDetailPageState extends ConsumerState<PageDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(pageProfileProvider(widget.pageId));
      ref.invalidate(pageFeedProvider(widget.pageId));
      unawaited(ref.read(analyticsServiceProvider).logEvent(
        AnalyticsEvents.pageViewed,
        parameters: {'page_id': widget.pageId},
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(pageProfileProvider(widget.pageId));
    return Scaffold(
      backgroundColor: AppColors.background,
      body: profileAsync.when(
        loading: () => const _LoadingView(),
        error: (_, _) => _ErrorView(
          onRetry: () => ref.invalidate(pageProfileProvider(widget.pageId)),
        ),
        data: (page) => _PageDetailView(page: page, pageId: widget.pageId),
      ),
    );
  }
}

// ── Loading / error shells ────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  static const double _avatarRadius = 52.0;
  static const double _heroHeight = 260.0;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final heroHeight = _heroHeight + topPadding;
    final avatarTop = heroHeight - _avatarRadius - AppRadius.lg;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              // Hero banner — gradient placeholder, not shimmer
              Container(
                height: heroHeight,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.secondarySoft, AppColors.primarySoft],
                  ),
                ),
              ),
              // White content sheet — Shimmer only wraps this part
              Transform.translate(
                offset: const Offset(0, -AppRadius.lg),
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(AppRadius.lg),
                      topEnd: Radius.circular(AppRadius.lg),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.xxl),
                  child: Shimmer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatar overhang zone — follow button area
                        SizedBox(
                          height: _avatarRadius,
                          child: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: SkeletonBox(
                              width: 90,
                              height: 32,
                              borderRadius: AppRadius.smAll,
                            ),
                          ),
                        ),

                        // Name
                        const SizedBox(height: AppSpacing.md),
                        const SkeletonLine(width: 180, height: 24),

                        // Handle + category badge
                        const SizedBox(height: AppSpacing.sm),
                        Row(children: [
                          const SkeletonLine(width: 100, height: 13),
                          const SizedBox(width: AppSpacing.sm),
                          SkeletonBox(
                            width: 60,
                            height: 20,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ]),

                        // Bio
                        const SizedBox(height: AppSpacing.md),
                        const SkeletonLine(width: double.infinity, height: 13),
                        const SizedBox(height: AppSpacing.xs),
                        const SkeletonLine(width: 200, height: 13),

                        // Stats row (icon + number + label × 2)
                        const SizedBox(height: AppSpacing.xl),
                        const Row(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                SkeletonBox(width: 18, height: 18,
                                    shape: BoxShape.circle),
                                SizedBox(width: AppSpacing.xs),
                                SkeletonLine(width: 40, height: 18),
                              ]),
                              SizedBox(height: 4),
                              SkeletonLine(width: 64, height: 12),
                            ],
                          ),
                          SizedBox(width: AppSpacing.xl),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                SkeletonBox(width: 18, height: 18,
                                    shape: BoxShape.circle),
                                SizedBox(width: AppSpacing.xs),
                                SkeletonLine(width: 32, height: 18),
                              ]),
                              SizedBox(height: 4),
                              SkeletonLine(width: 48, height: 12),
                            ],
                          ),
                        ]),

                        // Divider
                        const SizedBox(height: AppSpacing.xl),
                        const SkeletonBox(width: double.infinity, height: 1),

                        // Post cards
                        const SizedBox(height: AppSpacing.lg),
                        const _SkeletonPostCard(),
                        const SizedBox(height: AppSpacing.lg),
                        const _SkeletonPostCard(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Floating avatar circle
          PositionedDirectional(
            start: AppSpacing.xl,
            top: avatarTop,
            child: Container(
              width: _avatarRadius * 2,
              height: _avatarRadius * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE9ECEF),
                border: Border.all(color: AppColors.surface, width: 4),
              ),
            ),
          ),

          // Back button — always usable
          PositionedDirectional(
            start: AppSpacing.lg,
            top: topPadding + AppSpacing.sm,
            child: _CircleBackButton(),
          ),
        ],
      ),
    );
  }
}

class _SkeletonPostCard extends StatelessWidget {
  const _SkeletonPostCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: const Color(0xFFE9ECEF)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            SkeletonBox(width: 36, height: 36, shape: BoxShape.circle),
            SizedBox(width: AppSpacing.sm),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SkeletonLine(width: 120, height: 13),
              SizedBox(height: 4),
              SkeletonLine(width: 72, height: 11),
            ]),
          ]),
          SizedBox(height: AppSpacing.md),
          SkeletonLine(width: double.infinity, height: 12),
          SizedBox(height: AppSpacing.xs),
          SkeletonLine(width: 200, height: 12),
          SizedBox(height: AppSpacing.md),
          SkeletonBox(width: double.infinity, height: 160),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    return Stack(
      children: [
        Column(
          children: [
            Container(height: 260 + topPadding, color: AppColors.secondarySoft),
            Expanded(
              child: Container(
                color: AppColors.surface,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(FluentIcons.error_circle_24_regular,
                            size: 44, color: AppColors.error),
                        const SizedBox(height: AppSpacing.md),
                        Text(context.l10n.errorTitle,
                            style: AppTextStyles.titleMedium),
                        const SizedBox(height: AppSpacing.lg),
                        FilledButton(
                          onPressed: onRetry,
                          child: Text(context.l10n.retry),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        PositionedDirectional(
          start: AppSpacing.lg,
          top: topPadding + AppSpacing.sm,
          child: _CircleBackButton(),
        ),
      ],
    );
  }
}

// ── Main detail view ──────────────────────────────────────────────────────────

class _PageDetailView extends ConsumerStatefulWidget {
  const _PageDetailView({required this.page, required this.pageId});

  final PageProfile page;
  final int pageId;

  @override
  ConsumerState<_PageDetailView> createState() => _PageDetailViewState();
}

class _PageDetailViewState extends ConsumerState<_PageDetailView> {
  late PageProfile _page = widget.page;
  bool _followBusy = false;

  static const double _avatarRadius = 52.0;
  static const double _avatarBorder = 4.0;
  static const double _heroHeight = 260.0;

  Future<void> _toggleFollow() async {
    if (_followBusy) return;

    if (_page.isFollowing == true) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(ctx.l10n.pageUnfollowTitle(_page.name)),
          content: Text(ctx.l10n.pageUnfollowMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(ctx.l10n.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              style: TextButton.styleFrom(foregroundColor: AppColors.error),
              child: Text(ctx.l10n.pageUnfollow),
            ),
          ],
        ),
      );
      if (confirmed != true) return;
    }

    setState(() => _followBusy = true);
    unawaited(HapticFeedback.selectionClick());
    final updated =
        await ref.read(pageFollowActionsProvider).toggleFollow(_page);
    if (mounted) {
      setState(() {
        _followBusy = false;
        if (updated != null) _page = updated;
      });
    }
  }

  PawPet _toPawPet(PetRef r) => PawPet(
        id: r.id.toString(),
        backendId: r.id,
        name: r.name,
        breed: '',
        species: '',
        avatarUrl: r.imagePath,
        ownerName: 'You',
        isMine: true,
      );

  void _openComments(PawPost post) {
    final actingRef = ref.read(actingPetProvider);
    if (actingRef == null) return;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CommentsSheet(
        post: post,
        actingAs: _toPawPet(actingRef),
        myPets: ref.read(switchablePetsProvider).map(_toPawPet).toList(),
        onActingAsChanged: (p) =>
            ref.read(petsProvider.notifier).selectPet(p.backendId),
      ),
    ).whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final heroHeight = _heroHeight + topPadding;
    final avatarTop = heroHeight - _avatarRadius - AppRadius.lg;
    const avatarDiameter = _avatarRadius * 2;

    final feedAsync = ref.watch(pageFeedProvider(_page.id));

    return SingleChildScrollView(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              _PageHeroHeader(
                page: _page,
                heroHeight: heroHeight,
                topPadding: topPadding,
              ),
              Transform.translate(
                offset: const Offset(0, -AppRadius.lg),
                child: _PageContentSheet(
                  page: _page,
                  avatarRadius: _avatarRadius,
                  followBusy: _followBusy,
                  onFollow: _toggleFollow,
                  feedAsync: feedAsync,
                  onOpenComments: _openComments,
                  pageId: widget.pageId,
                  ref: ref,
                ),
              ),
            ],
          ),
          // Floating avatar — painted last so it sits above the seam.
          PositionedDirectional(
            start: AppSpacing.xl,
            top: avatarTop,
            child: Container(
              width: avatarDiameter,
              height: avatarDiameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surface, width: _avatarBorder),
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: AppCachedImage(
                  imageUrl: _page.avatarUrl,
                  width: avatarDiameter,
                  height: avatarDiameter,
                  borderRadius: BorderRadius.zero,
                  semanticLabel: _page.name,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Hero header ───────────────────────────────────────────────────────────────

class _PageHeroHeader extends StatelessWidget {
  const _PageHeroHeader({
    required this.page,
    required this.heroHeight,
    required this.topPadding,
  });

  final PageProfile page;
  final double heroHeight;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heroHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (page.bannerUrl != null)
            AppCachedImage(
              imageUrl: page.bannerUrl,
              width: double.infinity,
              height: double.infinity,
              borderRadius: BorderRadius.zero,
              semanticLabel: page.name,
              fit: BoxFit.cover,
            )
          else
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.secondarySoft, AppColors.primarySoft],
                  ),
                ),
              ),
            ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.4, 1.0],
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.4),
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            start: AppSpacing.lg,
            top: topPadding + AppSpacing.sm,
            child: _CircleBackButton(),
          ),
        ],
      ),
    );
  }
}

// ── Content sheet ─────────────────────────────────────────────────────────────

class _PageContentSheet extends StatelessWidget {
  const _PageContentSheet({
    required this.page,
    required this.avatarRadius,
    required this.followBusy,
    required this.onFollow,
    required this.feedAsync,
    required this.onOpenComments,
    required this.pageId,
    required this.ref,
  });

  final PageProfile page;
  final double avatarRadius;
  final bool followBusy;
  final VoidCallback onFollow;
  final AsyncValue<PageFeedState> feedAsync;
  final void Function(PawPost) onOpenComments;
  final int pageId;
  final WidgetRef ref;

  bool get _hasContact =>
      page.phone != null || page.website != null || page.address != null;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(AppRadius.lg),
          topEnd: Radius.circular(AppRadius.lg),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, 0, AppSpacing.lg, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Follow button lives in the avatar overhang zone.
                // Pushed toward the bottom with a top-weighted alignment.
                SizedBox(
                  height: avatarRadius,
                  child: Align(
                    alignment: const AlignmentDirectional(1.0, 0.6),
                    child: _FollowButton(
                      following: page.isFollowing ?? false,
                      busy: followBusy,
                      onTap: onFollow,
                    ),
                  ),
                ),

                // ── Name + verified ──────────────────────────────────────
                const SizedBox(height: AppSpacing.md),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        page.name,
                        style: AppTextStyles.headlineLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (page.isVerified) ...[
                      const SizedBox(width: AppSpacing.xs),
                      const VerifiedBadge(size: 20),
                    ],
                  ],
                ),

                const SizedBox(height: AppSpacing.xs),

                // ── Handle + category ────────────────────────────────────
                Row(
                  children: [
                    Text(
                      '@${page.handle}',
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _CategoryBadge(category: page.category),
                  ],
                ),

                // ── Bio ──────────────────────────────────────────────────
                if (page.bio != null && page.bio!.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(page.bio!, style: AppTextStyles.bodyMedium),
                ],

                const SizedBox(height: AppSpacing.xl),

                // ── Stats + info button on the same row ──────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _StatsRow(
                        followerCount: page.followerCount,
                        postCount: page.postCount,
                        followersLabel: l10n.pageFollowers,
                        postsLabel: l10n.pagePosts,
                      ),
                    ),
                    if (_hasContact)
                      _InfoButton(page: page),
                  ],
                ),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),

          const Divider(height: 1),

          // ── Posts feed ───────────────────────────────────────────────────
          feedAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.xxl),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.secondary),
              ),
            ),
            error: (_, _) => Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Center(
                child: Text(
                  context.l10n.pawhubProfileFailedPosts,
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            data: (feed) {
              if (feed.posts.isEmpty) return _EmptyFeed(page: page);
              return Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  children: [
                    for (int i = 0; i < feed.posts.length; i++) ...[
                      Builder(builder: (ctx) {
                        final paw = PawPost.fromEntity(feed.posts[i]);
                        return PostCard(
                          key: ValueKey(feed.posts[i].id),
                          post: paw,
                          onOpenComments: () => onOpenComments(paw),
                          onOpenOptions: () =>
                              showPostOptionsSheet(ctx, post: paw),
                          onOpenProfile: (pet) =>
                              openPawHubPetProfile(ctx, pet),
                          onOpenPage: (id) {
                                if (id != pageId) openPageDetail(ctx, id);
                              },
                          onShare: () => sharePostToSheet(ref, feed.posts[i]),
                        );
                      }),
                      if (i < feed.posts.length - 1)
                        const SizedBox(height: AppSpacing.lg),
                    ],
                    if (feed.cursor.hasMore)
                      Builder(builder: (ctx) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ref
                              .read(pageFeedProvider(pageId).notifier)
                              .loadMore();
                        });
                        return feed.loadingMore
                            ? const Padding(
                                padding: EdgeInsets.all(AppSpacing.lg),
                                child: Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.secondary),
                                ),
                              )
                            : const SizedBox.shrink();
                      })
                    else
                      const SizedBox(height: AppSpacing.xxl * 2),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ── Stats row — icon beside number, label below ───────────────────────────────

class _StatsRow extends StatelessWidget {
  const _StatsRow({
    required this.followerCount,
    required this.postCount,
    required this.followersLabel,
    required this.postsLabel,
  });

  final int followerCount;
  final int postCount;
  final String followersLabel;
  final String postsLabel;

  String _fmt(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatCell(
          icon: FluentIcons.people_24_regular,
          value: _fmt(followerCount),
          label: followersLabel,
          iconColor: AppColors.secondary,
        ),
        const SizedBox(width: AppSpacing.xl),
        _StatCell(
          icon: FluentIcons.image_24_regular,
          value: _fmt(postCount),
          label: postsLabel,
          iconColor: AppColors.primary,
        ),
      ],
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: AppSpacing.xs),
            Text(value, style: AppTextStyles.titleLarge),
          ],
        ),
        const SizedBox(height: 1),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

// ── Info button — opens contact details bottom sheet ──────────────────────────

class _InfoButton extends StatelessWidget {
  const _InfoButton({required this.page});

  final PageProfile page;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: context.l10n.pageInfo,
      child: InkWell(
        onTap: () => _PageInfoSheet.show(context, page),
        borderRadius: AppRadius.smAll,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.secondarySoft,
            borderRadius: AppRadius.smAll,
            border: Border.all(color: AppColors.secondary.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                FluentIcons.info_24_regular,
                size: 16,
                color: AppColors.secondary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                context.l10n.pageInfo,
                style: AppTextStyles.labelMedium
                    .copyWith(color: AppColors.secondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Page info bottom sheet ────────────────────────────────────────────────────

class _PageInfoSheet extends StatelessWidget {
  const _PageInfoSheet({required this.page});

  final PageProfile page;

  static void show(BuildContext context, PageProfile page) {
    showDialog<void>(
      context: context,
      builder: (_) => _PageInfoSheet(page: page),
    );
  }

  Future<void> _launch(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _call() => _launch(Uri(scheme: 'tel', path: page.phone!));

  void _openWebsite() {
    final raw = page.website!;
    final uri = Uri.parse(raw.startsWith('http') ? raw : 'https://$raw');
    _launch(uri);
  }

  void _openMaps() => _launch(Uri(
        scheme: 'geo',
        path: '${page.latitude},${page.longitude}',
        queryParameters: {'q': page.address!},
      ));

  String _trimUrl(String url) => url
      .replaceFirst(RegExp(r'^https?://'), '')
      .replaceFirst(RegExp(r'^www\.'), '')
      .split('/')[0];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final items = <({
      IconData icon,
      Color color,
      String label,
      String value,
      VoidCallback? onTap,
    })>[
      if (page.phone != null)
        (
          icon: FluentIcons.call_24_regular,
          color: AppColors.secondary,
          label: l10n.pageInfoPhone,
          value: page.phone!,
          onTap: _call,
        ),
      if (page.website != null)
        (
          icon: FluentIcons.globe_24_regular,
          color: AppColors.primary,
          label: l10n.pageInfoWebsite,
          value: _trimUrl(page.website!),
          onTap: _openWebsite,
        ),
      if (page.address != null)
        (
          icon: FluentIcons.location_24_regular,
          color: AppColors.accentPurple,
          label: l10n.pageInfoAddress,
          value: page.address!,
          onTap: page.hasCoordinates ? _openMaps : null,
        ),
    ];

    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.xxl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.md),
            child: Text(l10n.pageInfoTitle, style: AppTextStyles.titleMedium),
          ),

          // Contact rows
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final item in items)
                  _InfoRow(
                    icon: item.icon,
                    color: item.color,
                    label: item.label,
                    value: item.value,
                    onTap: item.onTap,
                  ),
              ],
            ),
          ),

          // Close button
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.xs, AppSpacing.lg, AppSpacing.lg),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: AppColors.onSecondary,
                  shape: RoundedRectangleBorder(borderRadius: AppRadius.smAll),
                ),
                child: Text(l10n.close),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tappable = onTap != null;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            // Icon square with soft tinted background
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.10),
                borderRadius: AppRadius.smAll,
              ),
              child: Icon(icon, size: 20, color: color),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.labelSmall
                        .copyWith(color: AppColors.textTertiary),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: tappable ? color : AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (tappable)
              const Icon(
                FluentIcons.chevron_right_24_regular,
                size: 16,
                color: AppColors.textTertiary,
              ),
          ],
        ),
      ),
    );
  }
}

// ── Shared sub-widgets ────────────────────────────────────────────────────────

class _CircleBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        onTap: () => context.pop(),
        customBorder: const CircleBorder(),
        child: const SizedBox(
          width: 40,
          height: 40,
          child: Icon(FluentIcons.arrow_left_24_regular,
              size: 20, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge({required this.category});
  final PageCategory category;

  @override
  Widget build(BuildContext context) {
    final (icon, label) = switch (category) {
      PageCategory.shelter => (
          FluentIcons.home_heart_24_regular,
          context.l10n.pageCategoryShelter,
        ),
      PageCategory.rescue => (
          FluentIcons.hand_right_24_regular,
          context.l10n.pageCategoryRescue,
        ),
      PageCategory.vet => (
          FluentIcons.heart_pulse_24_regular,
          context.l10n.pageCategoryVet,
        ),
      PageCategory.brand => (
          FluentIcons.tag_24_regular,
          context.l10n.pageCategoryBrand,
        ),
      PageCategory.other => (
          FluentIcons.organization_24_regular,
          context.l10n.pageCategoryOther,
        ),
    };
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.secondarySoft,
        borderRadius: AppRadius.smAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: AppColors.secondaryDark),
          const SizedBox(width: 3),
          Text(
            label,
            style: AppTextStyles.labelSmall
                .copyWith(color: AppColors.secondaryDark),
          ),
        ],
      ),
    );
  }
}

class _FollowButton extends StatelessWidget {
  const _FollowButton({
    required this.following,
    required this.busy,
    required this.onTap,
  });

  final bool following;
  final bool busy;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = following ? AppColors.textSecondary : AppColors.onSecondary;
    return Material(
      color: following ? Colors.transparent : AppColors.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.smAll,
        side: following
            ? const BorderSide(color: AppColors.divider)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: busy ? null : onTap,
        borderRadius: AppRadius.smAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
          child: busy
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2, color: fg),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (following) ...[
                      const Icon(
                        FluentIcons.checkmark_circle_24_filled,
                        size: 14,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 5),
                    ],
                    Text(
                      following
                          ? context.l10n.pageFollowing
                          : context.l10n.pageFollow,
                      style: AppTextStyles.labelMedium.copyWith(color: fg),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _EmptyFeed extends StatelessWidget {
  const _EmptyFeed({required this.page});
  final PageProfile page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: const BoxDecoration(
                color: AppColors.secondarySoft,
                shape: BoxShape.circle,
              ),
              child: const Icon(FluentIcons.image_24_regular,
                  size: 32, color: AppColors.secondaryDark),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(context.l10n.pageNoPostsYet,
                style: AppTextStyles.titleSmall),
            const SizedBox(height: AppSpacing.xs),
            Text(
              context.l10n.pageNoPostsMessage(page.name),
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
