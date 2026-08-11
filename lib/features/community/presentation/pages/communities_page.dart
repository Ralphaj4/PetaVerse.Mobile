import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../domain/entities/community_group_entities.dart';
import '../../domain/entities/community_group_enums.dart';
import '../providers/community_group_feed_providers.dart';
import '../widgets/community_card.dart';
import '../widgets/community_common.dart';

/// Which directory tab is showing: browse all (Discover) vs the acting pet's
/// joined communities (Mine).
enum _CommunitiesTab { discover, mine }

/// The communities directory: a Discover / My-communities tab bar, search,
/// category chips (Discover only), and lists of community cards. Reached via
/// `/community/communities`.
///
/// The search field and tab bar stay mounted at all times — only the list area
/// below them swaps between loading / data / empty.
class CommunitiesPage extends ConsumerStatefulWidget {
  const CommunitiesPage({super.key});

  @override
  ConsumerState<CommunitiesPage> createState() => _CommunitiesPageState();
}

class _CommunitiesPageState extends ConsumerState<CommunitiesPage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  Timer? _debounce;
  String _query = '';
  _CommunitiesTab _tab = _CommunitiesTab.discover;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_query.isNotEmpty) return; // search results aren't paginated here
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      ref.read(communityDirectoryProvider.notifier).loadMore();
    }
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _query = value.trim());
    });
  }

  void _open(CommunityGroup c) => context.push('/community/communities/${c.id}');

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final searching = _query.isNotEmpty;
    debugPrint('[Communities] build searching=$searching');

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(l10n.communitiesTitle),
        actions: [
          IconButton(
            tooltip: l10n.communityCreateTitle,
            onPressed: () => context.push('/community/communities/create'),
            icon: const Icon(FluentIcons.add_24_regular),
          ),
        ],
      ),
      body: Column(
        children: [
          _searchBar(l10n),
          if (!searching) ...[
            _CommunitiesTabBar(
              tab: _tab,
              onChanged: (t) => setState(() => _tab = t),
            ),
            // Category chips only make sense while browsing (Discover tab).
            if (_tab == _CommunitiesTab.discover) _CategoryBar(l10n: l10n),
          ],
          Expanded(
            child: searching
                ? _searchResults()
                : _tab == _CommunitiesTab.mine
                    ? _mine()
                    : _directory(),
          ),
        ],
      ),
    );
  }

  // ── "My communities" tab ────────────────────────────────────────────────────

  Widget _mine() {
    final l10n = context.l10n;
    final state = ref.watch(myCommunitiesProvider);
    return state.when(
      loading: () => const _CenteredLoader(),
      error: (e, _) => ErrorStateWidget(
        failure: e is Failure ? e : null,
        onRetry: () => ref.invalidate(myCommunitiesProvider),
      ),
      data: (communities) {
        if (communities.isEmpty) {
          return _MineEmpty(
            l10n: l10n,
            onDiscover: () => setState(() => _tab = _CommunitiesTab.discover),
          );
        }
        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async => ref.invalidate(myCommunitiesProvider),
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.xl * 3),
            itemCount: communities.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, i) {
              final c = communities[i];
              return CommunityCard(community: c, onOpen: () => _open(c));
            },
          ),
        );
      },
    );
  }

  Widget _searchBar(AppLocalizations l10n) => Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.sm),
        child: TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: l10n.communitiesSearchHint,
            prefixIcon: const Icon(FluentIcons.search_24_regular),
            suffixIcon: _query.isNotEmpty
                ? IconButton(
                    icon: const Icon(FluentIcons.dismiss_24_regular),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _query = '');
                    },
                  )
                : null,
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: AppRadius.lgAll,
              borderSide: BorderSide.none,
            ),
          ),
        ),
      );

  // ── Directory (browse) ──────────────────────────────────────────────────────

  /// Only the list area reacts to loading/error — the controls above stay put.
  Widget _directory() {
    final state = ref.watch(communityDirectoryProvider);
    debugPrint('[Communities] _directory state='
        '${state.isLoading ? "loading" : state.hasError ? "error(${state.error})" : "data(${state.value?.communities.length})"}');
    return state.when(
      loading: () => const _CenteredLoader(),
      error: (e, _) => ErrorStateWidget(
        failure: e is Failure ? e : null,
        onRetry: () => ref.read(communityDirectoryProvider.notifier).refresh(),
      ),
      data: (paged) {
        if (paged.communities.isEmpty) {
          return _EmptyDirectory(l10n: context.l10n);
        }
        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () =>
              ref.read(communityDirectoryProvider.notifier).refresh(),
          child: ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.xl * 3),
            itemCount: paged.communities.length + (paged.hasMore ? 1 : 0),
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, i) {
              if (i >= paged.communities.length) {
                return const Padding(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final c = paged.communities[i];
              return CommunityCard(community: c, onOpen: () => _open(c));
            },
          ),
        );
      },
    );
  }

  // ── Search results ──────────────────────────────────────────────────────────

  Widget _searchResults() {
    final l10n = context.l10n;
    final state = ref.watch(communitySearchProvider(_query));
    return state.when(
      loading: () => const _CenteredLoader(),
      error: (e, _) => ErrorStateWidget(failure: e is Failure ? e : null),
      data: (paged) {
        if (paged.communities.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Text(
                l10n.communitiesSearchEmpty(_query),
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.xl),
          itemCount: paged.communities.length,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, i) {
            final c = paged.communities[i];
            return CommunityCard(community: c, onOpen: () => _open(c));
          },
        );
      },
    );
  }
}

class _CenteredLoader extends StatelessWidget {
  const _CenteredLoader();

  @override
  Widget build(BuildContext context) => const Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.xl),
          child: CircularProgressIndicator(),
        ),
      );
}

/// The Discover / My-communities segmented tab bar.
class _CommunitiesTabBar extends StatelessWidget {
  const _CommunitiesTabBar({required this.tab, required this.onChanged});

  final _CommunitiesTab tab;
  final ValueChanged<_CommunitiesTab> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.sm),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.lgAll,
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            _TabSegment(
              label: l10n.communitiesTabDiscover,
              selected: tab == _CommunitiesTab.discover,
              onTap: () => onChanged(_CommunitiesTab.discover),
            ),
            _TabSegment(
              label: l10n.communitiesTabMine,
              selected: tab == _CommunitiesTab.mine,
              onTap: () => onChanged(_CommunitiesTab.mine),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabSegment extends StatelessWidget {
  const _TabSegment({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.transparent,
            borderRadius: AppRadius.mdAll,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: selected ? AppColors.onPrimary : AppColors.textSecondary,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

/// Empty state for the "My communities" tab.
class _MineEmpty extends StatelessWidget {
  const _MineEmpty({required this.l10n, required this.onDiscover});

  final AppLocalizations l10n;
  final VoidCallback onDiscover;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(FluentIcons.people_community_24_regular,
                size: 56, color: AppColors.textTertiary),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.communitiesMineEmptyTitle,
                style: AppTextStyles.titleMedium, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.communitiesMineEmptyDescription,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(
              onPressed: onDiscover,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
              ),
              child: Text(l10n.communitiesTabDiscover),
            ),
          ],
        ),
      ),
    );
  }
}

/// Persistent category filter bar (no sort). Always visible; selecting a chip
/// updates the filter and only the list below reloads.
class _CategoryBar extends ConsumerWidget {
  const _CategoryBar({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(communityDirectoryFilterProvider);
    final notifier = ref.read(communityDirectoryFilterProvider.notifier);

    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        children: [
          _CategoryChip(
            label: l10n.communityCategoryAll,
            selected: filter.category == null,
            onTap: () => notifier.setCategory(null),
          ),
          for (final c in CommunityCategory.values) ...[
            const SizedBox(width: AppSpacing.sm),
            _CategoryChip(
              label: c.label(l10n),
              selected: filter.category == c,
              onTap: () => notifier.setCategory(c),
            ),
          ],
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        showCheckmark: false,
        selectedColor: AppColors.primary,
        backgroundColor: AppColors.surface,
        labelStyle: AppTextStyles.labelMedium.copyWith(
          color: selected ? AppColors.onPrimary : AppColors.textSecondary,
        ),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
        side:
            BorderSide(color: selected ? AppColors.primary : AppColors.divider),
      ),
    );
  }
}

class _EmptyDirectory extends StatelessWidget {
  const _EmptyDirectory({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(FluentIcons.people_community_24_regular,
                size: 56, color: AppColors.textTertiary),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.communitiesEmptyTitle,
                style: AppTextStyles.titleMedium, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.communitiesEmptyDescription,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
