import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/shimmer.dart';
import '../../domain/entities/community_entities.dart';
import '../../domain/entities/community_enums.dart';
import '../models/pawhub_models.dart';
import '../providers/community_feed_providers.dart';
import '../providers/community_social_providers.dart';
import 'pawhub_pet_profile_page.dart';

/// Shared Hero tag for the PawHub search field (Feed-tab bar → search page).
const String kPawHubSearchHeroTag = 'pawhub-search';

/// The rounded pill that frames the search field, shared by the Feed-tab entry
/// bar and the search page so the Hero flight looks continuous. Wrapped in a
/// transparent [Material] so Hero mid-flight has an ancestor Material.
class _SearchFieldShell extends StatelessWidget {
  const _SearchFieldShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
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
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class PawHubSearchPage extends ConsumerStatefulWidget {
  const PawHubSearchPage({super.key});

  @override
  ConsumerState<PawHubSearchPage> createState() => _PawHubSearchPageState();
}

class _PawHubSearchPageState extends ConsumerState<PawHubSearchPage> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    if (value.isEmpty) {
      ref.read(searchQueryProvider.notifier).set('');
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(searchQueryProvider.notifier).set(value.trim());
    });
  }

  void _clear() {
    _controller.clear();
    _debounce?.cancel();
    ref.read(searchQueryProvider.notifier).set('');
  }

  @override
  Widget build(BuildContext context) {
    final scope = ref.watch(searchScopeProvider);
    final query = ref.watch(searchQueryProvider);
    final resultsAsync = ref.watch(communitySearchProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Search header: back button + a Hero-flighted rounded field.
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.sm, AppSpacing.md, AppSpacing.md, AppSpacing.md),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(FluentIcons.arrow_left_24_regular,
                        color: AppColors.textPrimary),
                  ),
                  Expanded(
                    child: Hero(
                      tag: kPawHubSearchHeroTag,
                      // Render a neutral pill during the flight so the editable
                      // field doesn't animate/relayout mid-transition.
                      flightShuttleBuilder: (_, _, _, _, _) =>
                          const _SearchFieldShell(child: SizedBox()),
                      child: _SearchFieldShell(
                        child: TextField(
                          controller: _controller,
                          autofocus: true,
                          onChanged: _onChanged,
                          textInputAction: TextInputAction.search,
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            hintText: context.l10n.pawHubSearchHint,
                            hintStyle: AppTextStyles.bodyMedium
                                .copyWith(color: AppColors.textTertiary),
                            // No inner border in any state — the pill shell
                            // already provides the outline (avoids the theme's
                            // orange focus border showing through).
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            filled: false,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            suffixIcon: query.isNotEmpty
                                ? GestureDetector(
                                    onTap: _clear,
                                    child: const Icon(
                                        FluentIcons.dismiss_circle_24_filled,
                                        size: 18,
                                        color: AppColors.textTertiary),
                                  )
                                : null,
                            suffixIconConstraints: const BoxConstraints(
                                minWidth: 24, minHeight: 24),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _ScopePicker(
              selected: scope,
              onSelect: (t) => ref.read(searchScopeProvider.notifier).select(t),
            ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(child: _body(query, resultsAsync)),
          ],
        ),
      ),
    );
  }

  /// Populate the field from a tapped suggestion chip and run the search.
  void _applySuggestion(String text) {
    _controller.text = text;
    _controller.selection =
        TextSelection.collapsed(offset: text.length);
    _onChanged(text);
  }

  // ── Result navigation ──────────────────────────────────────────────────────

  void _openPet(CommunityPet pet) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PawHubPetProfilePage(
          pet: PawPet.fromEntity(pet),
          siblings: const [],
        ),
      ),
    );
  }

  void _openHashtag(TrendingHashtag tag) =>
      context.push('/community/hashtag/${tag.tag}');

  void _openPost(Post post) => context.push('/community/post/${post.id}');

  Widget _body(String query, AsyncValue<PagedSearch> async) {
    if (query.isEmpty) return _IdleState(onSuggestion: _applySuggestion);
    return async.when(
      loading: () => const _ResultsSkeleton(),
      error: (e, _) => _ErrorState(
        message: e is Failure
            ? e.localizedMessage(context.l10n)
            : context.l10n.errorUnknown,
        onRetry: () => ref.invalidate(communitySearchProvider),
      ),
      data: (page) {
        if (page.results.isEmpty) return _EmptyState(query: query);
        // Load the next page when the user scrolls near the bottom. Works for
        // both the grouped and flat result lists without restructuring them.
        return NotificationListener<ScrollNotification>(
          onNotification: (n) {
            if (page.hasMore &&
                !page.loadingMore &&
                n.metrics.pixels >= n.metrics.maxScrollExtent - 400) {
              ref.read(communitySearchProvider.notifier).loadMore();
            }
            return false;
          },
          child: _ResultsList(
            results: page.results,
            loadingMore: page.loadingMore,
            onOpenPet: _openPet,
            onOpenHashtag: _openHashtag,
            onOpenPost: _openPost,
          ),
        );
      },
    );
  }
}

class _ScopePicker extends StatelessWidget {
  const _ScopePicker({required this.selected, required this.onSelect});
  final SearchType selected;
  final ValueChanged<SearchType> onSelect;

  static const _tabs = [
    (SearchType.all, FluentIcons.grid_24_regular),
    (SearchType.posts, FluentIcons.image_24_regular),
    (SearchType.hashtags, FluentIcons.number_symbol_24_regular),
    (SearchType.pets, FluentIcons.animal_paw_print_24_regular),
  ];

  String _labelFor(BuildContext context, SearchType type) => switch (type) {
        SearchType.all => context.l10n.pawhubSearchScopeAll,
        SearchType.posts => context.l10n.pawhubSearchScopePosts,
        SearchType.hashtags => context.l10n.pawhubSearchScopeHashtags,
        SearchType.pets => context.l10n.pawhubSearchScopePets,
      };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        // Flush-left with the page content margin.
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        itemCount: _tabs.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, i) {
          final t = _tabs[i];
          final active = selected == t.$1;
          final fg = active ? AppColors.onPrimary : AppColors.textSecondary;
          return GestureDetector(
            onTap: () => onSelect(t.$1),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: AppSpacing.xs),
              decoration: BoxDecoration(
                color: active ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: active ? AppColors.primary : AppColors.divider,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(t.$2, size: 15, color: fg),
                  const SizedBox(width: 5),
                  Text(_labelFor(context, t.$1),
                      style: AppTextStyles.labelMedium.copyWith(color: fg)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _IdleState extends ConsumerWidget {
  const _IdleState({required this.onSuggestion});

  final ValueChanged<String> onSuggestion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Real trending hashtags from GET /community/trending (hashtags array).
    final trending = ref.watch(trendingProvider).value?.hashtags ?? const [];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      children: [
        // Push the hero well down the screen so it isn't crammed under the bar.
        const SizedBox(height: AppSpacing.xxl * 2),
        Center(
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: const BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(FluentIcons.search_24_regular,
                size: 36, color: AppColors.primaryDark),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Center(
          child: Text(context.l10n.pawhubSearchTitle,
              style: AppTextStyles.titleMedium),
        ),
        const SizedBox(height: AppSpacing.sm),
        Center(
          child: Text(context.l10n.pawhubSearchSubtitle,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary)),
        ),
        if (trending.isNotEmpty) ...[
          // Drop Trending noticeably lower, giving the hero room to breathe.
          const SizedBox(height: AppSpacing.xxl * 2),
          Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: AppColors.primarySoft,
                  shape: BoxShape.circle,
                ),
                child: const Icon(FluentIcons.arrow_trending_24_filled,
                    size: 15, color: AppColors.primaryDark),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(context.l10n.pawhubTrendingTitle,
                  style: AppTextStyles.titleSmall),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final h in trending)
                _SuggestionChip(
                  icon: FluentIcons.number_symbol_24_regular,
                  label: '#${h.tag}',
                  onTap: () => onSuggestion('#${h.tag}'),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  const _SuggestionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: AppRadius.lgAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.lgAll,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            borderRadius: AppRadius.lgAll,
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 15, color: AppColors.secondary),
              const SizedBox(width: AppSpacing.xs),
              Text(label,
                  style: AppTextStyles.labelMedium
                      .copyWith(color: AppColors.textPrimary)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(FluentIcons.warning_24_regular,
                size: 40, color: AppColors.error),
            const SizedBox(height: AppSpacing.md),
            Text(context.l10n.errorTitle, style: AppTextStyles.titleSmall),
            const SizedBox(height: AppSpacing.xs),
            Text(message,
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(onPressed: onRetry, child: Text(context.l10n.retry)),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.query});
  final String query;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(FluentIcons.search_24_regular,
                size: 40, color: AppColors.textTertiary),
            const SizedBox(height: AppSpacing.md),
            Text(context.l10n.pawhubSearchNoResults(query),
                style: AppTextStyles.titleSmall),
            const SizedBox(height: AppSpacing.xs),
            Text(context.l10n.pawhubSearchTryDifferent,
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

/// Shimmering placeholders shaped like the result tiles, shown while a query
/// is loading.
class _ResultsSkeleton extends StatelessWidget {
  const _ResultsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        itemCount: 8,
        separatorBuilder: (_, _) =>
            const Divider(height: 1, indent: 56, color: AppColors.divider),
        itemBuilder: (_, _) => const _ResultTileSkeleton(),
      ),
    );
  }
}

class _ResultTileSkeleton extends StatelessWidget {
  const _ResultTileSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
      child: Row(
        children: [
          SkeletonBox(width: 44, height: 44, shape: BoxShape.circle),
          SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SkeletonLine(width: 140, height: 14),
              SizedBox(height: 8),
              SkeletonLine(width: 90, height: 10),
            ],
          ),
        ],
      ),
    );
  }
}

class _ResultsList extends StatelessWidget {
  const _ResultsList({
    required this.results,
    required this.onOpenPet,
    required this.onOpenHashtag,
    required this.onOpenPost,
    this.loadingMore = false,
  });

  final List<SearchResult> results;

  /// Shows a footer spinner while the next page is loading.
  final bool loadingMore;
  final void Function(CommunityPet) onOpenPet;
  final void Function(TrendingHashtag) onOpenHashtag;
  final void Function(Post) onOpenPost;

  Widget _tileFor(SearchResult r) => switch (r.kind) {
        SearchResultKind.pet => _PetTile(pet: r.pet!, onTap: onOpenPet),
        SearchResultKind.hashtag =>
          _HashtagTile(tag: r.hashtag!, onTap: onOpenHashtag),
        SearchResultKind.post => _PostTile(post: r.post!, onTap: onOpenPost),
      };

  @override
  Widget build(BuildContext context) {
    final pets = results.where((r) => r.kind == SearchResultKind.pet).toList();
    final tags =
        results.where((r) => r.kind == SearchResultKind.hashtag).toList();
    final posts =
        results.where((r) => r.kind == SearchResultKind.post).toList();

    // Grouped ("All"): more than one type present → labeled sections. Otherwise
    // a single-type filter → flat list.
    final grouped =
        [pets.isNotEmpty, tags.isNotEmpty, posts.isNotEmpty]
            .where((e) => e)
            .length >
        1;

    if (!grouped) {
      return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        // One extra row for the footer loader when a page is in flight.
        itemCount: results.length + (loadingMore ? 1 : 0),
        separatorBuilder: (_, _) =>
            const Divider(height: 1, indent: 56, color: AppColors.divider),
        itemBuilder: (_, i) =>
            i >= results.length ? const _LoadMoreFooter() : _tileFor(results[i]),
      );
    }

    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      children: [
        if (pets.isNotEmpty)
          _ResultSection(
            icon: FluentIcons.animal_paw_print_24_regular,
            label: context.l10n.pawhubSearchSectionPets,
            children: [for (final r in pets) _tileFor(r)],
          ),
        if (tags.isNotEmpty)
          _ResultSection(
            icon: FluentIcons.number_symbol_24_regular,
            label: context.l10n.pawhubSearchSectionHashtags,
            children: [for (final r in tags) _tileFor(r)],
          ),
        if (posts.isNotEmpty)
          _ResultSection(
            icon: FluentIcons.image_24_regular,
            label: context.l10n.pawhubSearchSectionPosts,
            children: [for (final r in posts) _tileFor(r)],
          ),
        if (loadingMore) const _LoadMoreFooter(),
      ],
    );
  }
}

/// A small centered footer spinner shown while the next result page loads.
class _LoadMoreFooter extends StatelessWidget {
  const _LoadMoreFooter();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

/// A labeled group of results (icon + title header, then its tiles).
class _ResultSection extends StatelessWidget {
  const _ResultSection({
    required this.icon,
    required this.label,
    required this.children,
  });

  final IconData icon;
  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.xs),
          child: Row(
            children: [
              Icon(icon, size: 15, color: AppColors.textSecondary),
              const SizedBox(width: AppSpacing.xs),
              Text(label,
                  style: AppTextStyles.labelMedium
                      .copyWith(color: AppColors.textSecondary)),
            ],
          ),
        ),
        ...children,
      ],
    );
  }
}

class _PetTile extends StatelessWidget {
  const _PetTile({required this.pet, required this.onTap});
  final CommunityPet pet;
  final void Function(CommunityPet) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AppAvatar(name: pet.name, imageUrl: pet.avatarUrl, radius: 22),
      title: Text(pet.name, style: AppTextStyles.labelLarge),
      subtitle: Text(pet.breedOrSpecies,
          style: AppTextStyles.bodySmall
              .copyWith(color: AppColors.textSecondary)),
      trailing: const Icon(FluentIcons.chevron_right_24_regular,
          size: 18, color: AppColors.textTertiary),
      onTap: () => onTap(pet),
    );
  }
}

class _HashtagTile extends StatelessWidget {
  const _HashtagTile({required this.tag, required this.onTap});
  final TrendingHashtag tag;
  final void Function(TrendingHashtag) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.secondarySoft,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: const Center(
          child: Icon(FluentIcons.number_symbol_24_regular,
              color: AppColors.secondaryDark),
        ),
      ),
      title: Text('#${tag.tag}', style: AppTextStyles.labelLarge),
      subtitle: Text(context.l10n.pawhubHashtagPostsCount(tag.postCount),
          style: AppTextStyles.bodySmall
              .copyWith(color: AppColors.textSecondary)),
      trailing: const Icon(FluentIcons.chevron_right_24_regular,
          size: 18, color: AppColors.textTertiary),
      onTap: () => onTap(tag),
    );
  }
}

class _PostTile extends StatelessWidget {
  const _PostTile({required this.post, required this.onTap});
  final Post post;
  final void Function(Post) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.primarySoft,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: const Center(
          child:
              Icon(FluentIcons.image_24_regular, color: AppColors.primaryDark),
        ),
      ),
      title: Text(
        post.caption?.isNotEmpty == true ? post.caption! : post.author.name,
        style: AppTextStyles.labelLarge,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(context.l10n.pawhubSearchPostBy(post.author.name),
          style: AppTextStyles.bodySmall
              .copyWith(color: AppColors.textSecondary)),
      trailing: const Icon(FluentIcons.chevron_right_24_regular,
          size: 18, color: AppColors.textTertiary),
      onTap: () => onTap(post),
    );
  }
}
