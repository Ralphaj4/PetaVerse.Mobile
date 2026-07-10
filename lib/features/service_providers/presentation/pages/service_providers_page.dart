import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/provider_category.dart';
import '../../domain/entities/service_provider.dart';
import '../providers/service_providers_providers.dart';
import '../widgets/bottom_sheet_header.dart';
import '../widgets/map_controls.dart';
import '../widgets/provider_actions.dart';
import '../widgets/provider_card.dart';
import '../widgets/provider_empty_state.dart';
import '../widgets/provider_filter_bar.dart';
import '../widgets/provider_list_skeleton.dart';
import '../widgets/provider_search_bar.dart';
import '../widgets/provider_sort_sheet.dart';
import '../widgets/service_provider_map.dart';

/// Service Providers discovery screen (PawCare tab): a full-bleed map of nearby
/// pet businesses with a draggable results sheet, category filters, search, and
/// sort — Google-Maps / Uber-Eats style browsing.
///
/// The page is layout + state wiring only (per the engineering guidelines):
/// all data flows through Riverpod providers and every visual piece is a
/// reusable widget in `../widgets`.
class ServiceProvidersPage extends ConsumerStatefulWidget {
  const ServiceProvidersPage({super.key});

  @override
  ConsumerState<ServiceProvidersPage> createState() =>
      _ServiceProvidersPageState();
}

class _ServiceProvidersPageState extends ConsumerState<ServiceProvidersPage> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  /// The map's animated controller, handed up by [ServiceProviderMap] once
  /// built, so the floating "my location" button can drive a fly-to.
  AnimatedMapController? _mapController;

  // Sheet snap points as a fraction of screen height.
  static const double _collapsed = 0.28;
  static const double _expanded = 0.92;

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  // ── Selection ─────────────────────────────────────────────────────────
  void _selectProvider(String id, {bool expandSheet = false}) {
    ref.read(selectedProviderProvider.notifier).select(id);
    if (expandSheet) _animateSheetTo(0.5);
  }

  void _deselect() => ref.read(selectedProviderProvider.notifier).select(null);

  void _animateSheetTo(double size) {
    if (!_sheetController.isAttached) return;
    _sheetController.animateTo(
      size,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  // ── Quick actions ─────────────────────────────────────────────────────
  Future<void> _call(ServiceProvider provider) async {
    final ok = await ProviderActions.call(provider);
    if (!ok && mounted) context.showErrorSnackBar(context.l10n.providerCallFailed);
  }

  Future<void> _directions(ServiceProvider provider) async {
    final ok = await ProviderActions.directions(provider);
    if (!ok && mounted) {
      context.showErrorSnackBar(context.l10n.providerDirectionsFailed);
    }
  }

  Future<void> _openSort() async {
    final current = ref.read(providerSortOrderProvider);
    final picked = await ProviderSortSheet.show(context, current: current);
    if (picked != null) {
      ref.read(providerSortOrderProvider.notifier).select(picked);
    }
  }

  void _recenter() {
    final center = ref.read(providerQueryCenterProvider);
    if (_mapController != null) {
      _mapController!.animateTo(dest: center, zoom: 15);
    }
    _deselect();
  }

  @override
  Widget build(BuildContext context) {
    final providersAsync = ref.watch(serviceProvidersProvider);
    final visible = ref.watch(visibleProvidersProvider);
    final selectedId = ref.watch(selectedProviderProvider);
    final category = ref.watch(providerCategoryFilterProvider);
    final sort = ref.watch(providerSortOrderProvider);
    final center = ref.watch(providerQueryCenterProvider);

    final media = MediaQuery.of(context);
    final isTablet = media.size.shortestSide >= 600;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        // Let the sheet float over the map; don't resize for the keyboard.
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // ── Map (fills the screen) ──────────────────────────────────
            Positioned.fill(
              child: ServiceProviderMap(
                providers: visible,
                center: center,
                selectedId: selectedId,
                // Tapping a pin surfaces its card: highlight + raise the sheet
                // to the mid snap so the (highlighted) result is in view.
                onProviderTap: (id) => _selectProvider(id, expandSheet: true),
                onMapTap: _deselect,
                controllerReady: (c) => _mapController = c,
              ),
            ),

            // ── Top overlay: search + filter chips ──────────────────────
            _TopOverlay(
              isTablet: isTablet,
              searchBar: ProviderSearchBar(
                onChanged: (q) =>
                    ref.read(providerSearchQueryProvider.notifier).set(q),
                onSortTap: _openSort,
                sortActive: sort != ProviderSort.distance,
              ),
              filterBar: ProviderFilterBar(
                selected: category,
                onSelected: (c) {
                  ref.read(providerCategoryFilterProvider.notifier).select(c);
                  _deselect();
                },
              ),
            ),

            // ── Floating map controls, tracking the sheet's top edge ────
            _FloatingControls(
              sheetController: _sheetController,
              collapsed: _collapsed,
              screenHeight: media.size.height,
              child: MapControls(onRecenter: _recenter),
            ),

            // ── Results bottom sheet ────────────────────────────────────
            DraggableScrollableSheet(
              controller: _sheetController,
              initialChildSize: _collapsed,
              minChildSize: _collapsed,
              maxChildSize: _expanded,
              snap: true,
              snapSizes: const [_collapsed, 0.5, _expanded],
              builder: (context, scrollController) => _ResultsSheet(
                scrollController: scrollController,
                providersAsync: providersAsync,
                visible: visible,
                selectedId: selectedId,
                sort: sort,
                hasQueryOrFilter: category != ProviderCategory.all ||
                    ref.watch(providerSearchQueryProvider).isNotEmpty,
                onSortTap: _openSort,
                onSelect: (id) => _selectProvider(id),
                onCall: _call,
                onDirections: _directions,
                onRetry: () =>
                    ref.read(serviceProvidersProvider.notifier).refresh(),
                onClearFilters: () {
                  ref
                      .read(providerCategoryFilterProvider.notifier)
                      .select(ProviderCategory.all);
                  ref.read(providerSearchQueryProvider.notifier).set('');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Top overlay hosting the floating search bar and the horizontal filter chips.
/// On tablets the search bar is width-constrained so it doesn't stretch edge to
/// edge.
class _TopOverlay extends StatelessWidget {
  const _TopOverlay({
    required this.searchBar,
    required this.filterBar,
    required this.isTablet,
  });

  final Widget searchBar;
  final Widget filterBar;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 0,
      start: 0,
      end: 0,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(maxWidth: isTablet ? 520 : double.infinity),
                  child: searchBar,
                ),
              ),
            ),
            filterBar,
          ],
        ),
      ),
    );
  }
}

/// Positions [child] just above the sheet's top edge, animating as the sheet is
/// dragged so the controls are never hidden behind it.
class _FloatingControls extends StatelessWidget {
  const _FloatingControls({
    required this.sheetController,
    required this.collapsed,
    required this.screenHeight,
    required this.child,
  });

  final DraggableScrollableController sheetController;
  final double collapsed;
  final double screenHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: sheetController,
      builder: (context, controls) {
        final size =
            sheetController.isAttached ? sheetController.size : collapsed;
        // Keep the controls ~12px above the sheet, but don't let them ride up
        // past the filter bar when the sheet is fully expanded.
        final bottom = (size * screenHeight + 12).clamp(0.0, screenHeight * 0.6);
        return PositionedDirectional(
          end: 16,
          bottom: bottom,
          child: controls!,
        );
      },
      child: child,
    );
  }
}

/// The draggable results sheet content: a pinned header (count + sort) plus a
/// scrollable body that adapts to the load/empty/error/data state.
///
/// Stateful so it can scroll the selected card into view when the selection
/// changes from a map-pin tap (height-agnostic via [Scrollable.ensureVisible]
/// on per-item keys).
class _ResultsSheet extends StatefulWidget {
  const _ResultsSheet({
    required this.scrollController,
    required this.providersAsync,
    required this.visible,
    required this.selectedId,
    required this.sort,
    required this.hasQueryOrFilter,
    required this.onSortTap,
    required this.onSelect,
    required this.onCall,
    required this.onDirections,
    required this.onRetry,
    required this.onClearFilters,
  });

  final ScrollController scrollController;
  final AsyncValue<List<ServiceProvider>> providersAsync;
  final List<ServiceProvider> visible;
  final String? selectedId;
  final ProviderSort sort;
  final bool hasQueryOrFilter;
  final VoidCallback onSortTap;
  final ValueChanged<String> onSelect;
  final ValueChanged<ServiceProvider> onCall;
  final ValueChanged<ServiceProvider> onDirections;
  final VoidCallback onRetry;
  final VoidCallback onClearFilters;

  @override
  State<_ResultsSheet> createState() => _ResultsSheetState();
}

class _ResultsSheetState extends State<_ResultsSheet> {
  /// Per-provider keys so the freshly selected card can be scrolled into view.
  final Map<String, GlobalKey> _itemKeys = {};

  GlobalKey _keyFor(String id) => _itemKeys.putIfAbsent(id, GlobalKey.new);

  @override
  void didUpdateWidget(_ResultsSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    final id = widget.selectedId;
    if (id != null && id != oldWidget.selectedId) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelected(id));
    }
  }

  void _scrollToSelected(String id) {
    final ctx = _itemKeys[id]?.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      alignment: 0.1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          BottomSheetHeader(
            count: widget.visible.length,
            sort: widget.sort,
            onSortTap: widget.onSortTap,
          ),
          const Divider(height: 1, color: AppColors.divider),
          Expanded(child: _body(context)),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    final l10n = context.l10n;

    return widget.providersAsync.when(
      skipLoadingOnRefresh: true,
      loading: () => const ProviderListSkeleton(),
      error: (error, _) {
        final failure = error is Failure ? error : const UnknownFailure();
        final offline = failure is NetworkFailure;
        return SingleChildScrollView(
          controller: widget.scrollController,
          child: offline
              ? ProviderEmptyState.offline(
                  title: l10n.providerOfflineTitle,
                  message: l10n.providerOfflineMessage,
                  actionLabel: l10n.retry,
                  onAction: widget.onRetry,
                )
              : ProviderEmptyState.offline(
                  title: l10n.providerErrorTitle,
                  message: l10n.providerErrorMessage,
                  actionLabel: l10n.retry,
                  onAction: widget.onRetry,
                ),
        );
      },
      data: (_) {
        final visible = widget.visible;
        if (visible.isEmpty) {
          return SingleChildScrollView(
            controller: widget.scrollController,
            child: ProviderEmptyState.noResults(
              title: l10n.providerNoResultsTitle,
              message: widget.hasQueryOrFilter
                  ? l10n.providerNoResultsFiltered
                  : l10n.providerNoResultsNearby,
              actionLabel:
                  widget.hasQueryOrFilter ? l10n.providerClearFilters : null,
              onAction: widget.hasQueryOrFilter ? widget.onClearFilters : null,
            ),
          );
        }

        return ListView.separated(
          controller: widget.scrollController,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          itemCount: visible.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final provider = visible[i];
            return ProviderCard(
              key: _keyFor(provider.id),
              provider: provider,
              selected: provider.id == widget.selectedId,
              onTap: () => widget.onSelect(provider.id),
              onCall: () => widget.onCall(provider),
              onDirections: () => widget.onDirections(provider),
            );
          },
        );
      },
    );
  }
}
