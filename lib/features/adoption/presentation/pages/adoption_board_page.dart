import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/debounced_search_field.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../../../shared/widgets/shimmer.dart';
import '../../../pets/domain/entities/species.dart';
import '../../../pets/presentation/providers/species_provider.dart';
import '../../domain/entities/adoption_listing.dart';
import '../providers/adoption_providers.dart';
import '../widgets/adoption_card.dart';
import '../widgets/adoption_species_filter_row.dart';

/// The adoption board: a browsable list of pets up for adoption, with species
/// filters and search. The server filters (speciesId + q), so changing a filter
/// re-runs the board query. Layout + state wiring only.
///
/// When [embedded] (inside the Community hub) it renders without its own AppBar
/// — the hub supplies the shared header — and surfaces the count + "List a pet"
/// action as an inline header row instead.
class AdoptionBoardPage extends ConsumerWidget {
  const AdoptionBoardPage({this.embedded = false, super.key});

  final bool embedded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final listingsAsync = ref.watch(adoptionListingsProvider);
    final speciesAsync = ref.watch(speciesListProvider);
    final selectedSpeciesId = ref.watch(adoptionSpeciesFilterProvider);
    final query = ref.watch(adoptionSearchQueryProvider);

    final content = Column(
          children: [
            if (embedded)
              _EmbeddedHeader(
                subtitle: l10n.adoptionSubtitle(listingsAsync.value?.length ?? 0),
              ),
            // ── "My adoptions" entry: a full-width tappable row (not AppBar
            // chrome) so it's discoverable without crowding the header. ──
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.lg,
                embedded ? AppSpacing.sm : AppSpacing.md,
                AppSpacing.lg,
                0,
              ),
              child: const _MyAdoptionsRow(),
            ),
            // ── Search + species filters (pinned above the scrolling list) ──
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: DebouncedSearchField(
                hint: l10n.adoptionSearchHint,
                onChanged: (q) =>
                    ref.read(adoptionSearchQueryProvider.notifier).set(q),
              ),
            ),
            AdoptionSpeciesFilterRow(
              species: speciesAsync.value ?? const <Species>[],
              selectedId: selectedSpeciesId,
              allLabel: l10n.adoptionFilterAll,
              onSelected: (id) =>
                  ref.read(adoptionSpeciesFilterProvider.notifier).select(id),
            ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: _Body(
                listingsAsync: listingsAsync,
                hasQueryOrFilter:
                    selectedSpeciesId != null || query.trim().isNotEmpty,
                onRetry: () =>
                    ref.read(adoptionListingsProvider.notifier).refresh(),
                onClearFilters: () {
                  ref.read(adoptionSpeciesFilterProvider.notifier).select(null);
                  ref.read(adoptionSearchQueryProvider.notifier).set('');
                },
              ),
            ),
          ],
        );

    // Embedded in the Community hub: the hub owns the Scaffold + header, so
    // return the bare content (its own header row is added above).
    if (embedded) return content;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          toolbarHeight: 64,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.adoptionTitle, style: AppTextStyles.titleMedium),
              Text(
                l10n.adoptionSubtitle(listingsAsync.value?.length ?? 0),
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        ),
        body: content,
      ),
    );
  }
}

/// Inline count subtitle shown in embedded (hub) mode, standing in for the
/// standalone AppBar's subtitle line. The "My adoptions" entry and the create
/// action live below (a body row + a search-adjacent button).
class _EmbeddedHeader extends StatelessWidget {
  const _EmbeddedHeader({required this.subtitle});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        0,
      ),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          subtitle,
          style: AppTextStyles.bodySmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

/// The single, discoverable entry into the user's personal adoption space
/// (their listings + applications). A full-width tappable row — leading tile,
/// label + hint, a live count badge, and a chevron — so the destination is
/// obvious without crowding the header.
class _MyAdoptionsRow extends ConsumerWidget {
  const _MyAdoptionsRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final listings = ref.watch(myAdoptionListingsProvider).value?.length ?? 0;
    final applications =
        ref.watch(myAdoptionRequestsProvider).value?.length ?? 0;
    final total = listings + applications;

    return Material(
      color: AppColors.surface,
      borderRadius: AppRadius.lgAll,
      child: InkWell(
        onTap: () => context.push(AppRoutes.adoptionMy),
        borderRadius: AppRadius.lgAll,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: AppRadius.lgAll,
            border: Border.all(color: AppColors.divider),
          ),
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: AppColors.primarySoft,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  FluentIcons.bookmark_24_filled,
                  size: 20,
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.adoptionMyTitle, style: AppTextStyles.titleSmall),
                    const SizedBox(height: 2),
                    Text(
                      l10n.adoptionMyRowHint,
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (total > 0) ...[
                const SizedBox(width: AppSpacing.sm),
                Container(
                  constraints: const BoxConstraints(minWidth: 22),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    '$total',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
              const SizedBox(width: AppSpacing.xs),
              Icon(
                context.isRtl
                    ? FluentIcons.chevron_left_24_regular
                    : FluentIcons.chevron_right_24_regular,
                size: 18,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({
    required this.listingsAsync,
    required this.hasQueryOrFilter,
    required this.onRetry,
    required this.onClearFilters,
  });

  final AsyncValue<List<AdoptionListing>> listingsAsync;
  final bool hasQueryOrFilter;
  final VoidCallback onRetry;
  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return listingsAsync.when(
      skipLoadingOnRefresh: true,
      loading: () => const _BoardSkeleton(),
      error: (error, _) => ErrorStateWidget(
        failure: error is Failure ? error : const UnknownFailure(),
        onRetry: onRetry,
      ),
      data: (listings) {
        if (listings.isEmpty) {
          return _EmptyBoard(
            title: l10n.adoptionEmptyTitle,
            message: hasQueryOrFilter
                ? l10n.adoptionEmptyFiltered
                : l10n.adoptionEmptyNearby,
            actionLabel: hasQueryOrFilter ? l10n.adoptionClearFilters : null,
            onAction: hasQueryOrFilter ? onClearFilters : null,
          );
        }

        final now = DateTime.now();
        return RefreshIndicator(
          onRefresh: () =>
              ref.read(adoptionListingsProvider.notifier).refresh(),
          color: AppColors.primary,
          child: ListView.separated(
            // Adopt the ambient PrimaryScrollController (set by
            // CommunityHubPage) so re-tapping the Community tab can scroll this
            // surface to the top.
            primary: true,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.xxl + AppSpacing.xl,
            ),
            itemCount: listings.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, i) {
              final listing = listings[i];
              return AdoptionCard(
                listing: listing,
                now: now,
                onTap: () => _openDetails(context, listing),
                onApply: () => _openDetails(context, listing),
                onManage: () => _openDetails(context, listing),
              );
            },
          ),
        );
      },
    );
  }

  void _openDetails(BuildContext context, AdoptionListing listing) {
    context.push(
      AppRoutes.adoptionDetailPath(listing.id),
      extra: listing,
    );
  }
}

/// Empty state for the board — an inviting paw prompt, with an optional
/// clear-filters action when the emptiness is due to a filter/search.
class _EmptyBoard extends StatelessWidget {
  const _EmptyBoard({
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: const BoxDecoration(
                color: AppColors.primarySoft,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                FluentIcons.animal_paw_print_24_regular,
                size: 48,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(title,
                style: AppTextStyles.titleMedium, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: AppTextStyles.bodySmall,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.lg),
              TextButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}

/// First-load skeleton: a few listing-shaped cards so nothing shifts when the
/// real data arrives.
class _BoardSkeleton extends StatelessWidget {
  const _BoardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.xxl,
        ),
        children: [
          for (var i = 0; i < 3; i++) ...[
            const _CardSkeleton(),
            const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}

class _CardSkeleton extends StatelessWidget {
  const _CardSkeleton();

  @override
  Widget build(BuildContext context) {
    return SkeletonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SkeletonBox(
            height: 160,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.lg),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonLine(width: 140, height: 16),
                const SizedBox(height: AppSpacing.sm),
                const SkeletonLine(width: 200, height: 12),
                const SizedBox(height: AppSpacing.xs),
                const SkeletonLine(width: 120, height: 12),
                const SizedBox(height: AppSpacing.md),
                SkeletonBox(height: 44, borderRadius: AppRadius.smAll),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
