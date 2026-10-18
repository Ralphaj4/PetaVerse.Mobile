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
import '../providers/community_group_feed_providers.dart';
import '../widgets/community_card.dart';

/// The communities directory: search and a list of community cards. Reached via
/// `/community/communities`.
///
/// The search field stays mounted at all times - only the list area below it
/// swaps between loading / data / empty.
class CommunitiesPage extends ConsumerStatefulWidget {
  /// When [embedded] (inside the PetaHub) it renders without its own AppBar -
  /// the hub supplies the shared header. Standalone (`/community/communities`)
  /// keeps its own AppBar with the create-community action.
  const CommunitiesPage({this.embedded = false, super.key});

  final bool embedded;

  @override
  ConsumerState<CommunitiesPage> createState() => _CommunitiesPageState();
}

class _CommunitiesPageState extends ConsumerState<CommunitiesPage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  Timer? _debounce;
  String _query = '';

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
    if (_query.isNotEmpty) return;
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

    final body = Column(
      children: [
        _searchBar(l10n),
        Expanded(
          child: searching ? _searchResults() : _directory(),
        ),
      ],
    );

    if (widget.embedded) return body;

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
      body: body,
    );
  }

  Widget _searchBar(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.md),
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
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: l10n.communitiesSearchHint,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            if (_query.isNotEmpty)
              IconButton(
                constraints: const BoxConstraints(minHeight: 0, minWidth: 0),
                padding: EdgeInsets.zero,
                icon: const Icon(FluentIcons.dismiss_24_regular),
                onPressed: () {
                  _searchController.clear();
                  setState(() => _query = '');
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _directory() {
    final state = ref.watch(communityDirectoryProvider);
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
