import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/location/location_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/widgets/map/map_camera_controller.dart';
import '../../domain/entities/provider_category.dart';
import '../../domain/entities/provider_search.dart';
import '../../domain/entities/service_provider.dart';
import '../providers/service_providers_providers.dart';
import '../widgets/bottom_sheet_header.dart';
import '../widgets/map_controls.dart';
import '../widgets/provider_card.dart';
import '../widgets/provider_empty_state.dart';
import '../widgets/provider_filter_bar.dart';
import '../widgets/provider_list_skeleton.dart';
import '../widgets/provider_pet_selector.dart';
import '../widgets/provider_search_bar.dart';
import '../widgets/provider_sort_sheet.dart';
import '../widgets/service_provider_map.dart';

/// Service Providers discovery screen (PawCare tab): a full-bleed map of nearby
/// pet businesses with a draggable results sheet, category filters, search, and
/// sort - Google-Maps / Uber-Eats style browsing.
///
/// The map queries the backend for the branches inside the current viewport
/// (bbox), refetching when the camera settles. All data flows through Riverpod
/// providers; every visual piece is a reusable widget in `../widgets`.
class ServiceProvidersPage extends ConsumerStatefulWidget {
  const ServiceProvidersPage({super.key});

  @override
  ConsumerState<ServiceProvidersPage> createState() =>
      _ServiceProvidersPageState();
}

class _ServiceProvidersPageState extends ConsumerState<ServiceProvidersPage> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  /// The map's camera controller, handed up by [ServiceProviderMap] once built,
  /// so the floating "my location" button can drive a fly-to.
  MapCameraController? _mapController;

  // Sheet snap points as a fraction of screen height. [_peek] lets the sheet
  // collapse down to just its header near the bottom; [_collapsed] is the
  // default resting height; [_expanded] is full.
  static const double _peek = 0.12;
  static const double _collapsed = 0.32;
  static const double _expanded = 0.92;

  /// Translates a vertical drag on the (non-scrolling) sheet header into a sheet
  /// resize, so the sheet can be dragged by its handle/header - not only by the
  /// scrollable card list.
  void _dragSheet(double dyDelta) {
    if (!_sheetController.isAttached) return;
    final height = MediaQuery.of(context).size.height;
    // Dragging up (negative dy) grows the sheet.
    final next = (_sheetController.size - dyDelta / height)
        .clamp(_peek, _expanded);
    _sheetController.jumpTo(next);
  }

  /// On drag release, settle to the nearest snap point.
  void _settleSheet(double velocity) {
    if (!_sheetController.isAttached) return;
    final size = _sheetController.size;
    const snaps = [_peek, _collapsed, _expanded];
    // Bias toward the direction of a fast flick.
    final target = velocity.abs() > 700
        ? (velocity < 0 ? _expanded : _peek)
        : snaps.reduce((a, b) =>
            (a - size).abs() < (b - size).abs() ? a : b);
    _animateSheetTo(target);
  }

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  // ── Viewport ──────────────────────────────────────────────────────────
  void _onViewport(GeoBounds bounds) =>
      ref.read(providerViewportProvider.notifier).set(bounds);

  // ── Selection ─────────────────────────────────────────────────────────
  void _selectBranch(int branchId, {bool expandSheet = false}) {
    ref.read(selectedProviderProvider.notifier).select(branchId);
    if (expandSheet) _animateSheetTo(0.5);
  }

  void _deselect() => ref.read(selectedProviderProvider.notifier).select(null);

  void _openProvider(ServiceProvider provider) {
    context.push(AppRoutes.serviceProviderDetail(provider.id, branchId: provider.branchId));
  }

  void _animateSheetTo(double size) {
    if (!_sheetController.isAttached) return;
    _sheetController.animateTo(
      size,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  // ── Quick actions ─────────────────────────────────────────────────────
  Future<void> _openSort() async {
    final current = ref.read(providerSortOrderProvider);
    final picked = await ProviderSortSheet.show(context, current: current);
    if (picked != null) {
      ref.read(providerSortOrderProvider.notifier).select(picked);
    }
  }

  void _recenter() {
    final here = ref.read(providerUserLocationProvider);
    if (here != null && _mapController != null) {
      _mapController!.animateTo(dest: here, zoom: 15);
    } else {
      // No fix yet - retry resolving location for the dot + next recenter.
      ref.read(providerUserLocationProvider.notifier).refresh();
    }
    _deselect();
  }

  /// Zoom out to show all of Lebanon and update the viewport bounds
  Future<void> _zoomToLebanon() async {
    if (_mapController == null) return;
    // Lebanon bounds: approximately 33.05-34.66°N, 35.11-36.64°E
    // Center: 33.85°N, 35.87°E
    const lebanonCenter = LatLng(33.85, 35.87);
    const zoom = 8.5; // Zoom level that shows all of Lebanon
    await _mapController!.animateTo(dest: lebanonCenter, zoom: zoom);
    // Update the viewport after animation completes
    await Future.delayed(const Duration(milliseconds: 400));
    _onViewport(
      const GeoBounds(
        south: 33.05,
        west: 35.11,
        north: 34.66,
        east: 36.64,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchAsync = ref.watch(serviceProvidersProvider);
    final visible = ref.watch(visibleProvidersProvider);
    final selectedId = ref.watch(selectedProviderProvider);
    final category = ref.watch(providerCategoryFilterProvider);
    final sort = ref.watch(providerSortOrderProvider);
    final tailoring = ref.watch(providerPetTailoringProvider);
    final hasPet = ref.watch(providerTailoringPetIdProvider) != null || tailoring;
    // Center the map on the user's location once it lands, else the default.
    final center =
        ref.watch(providerUserLocationProvider) ?? kDefaultMapCenter;
    final result = searchAsync.value;

    final media = MediaQuery.of(context);
    final isTablet = media.size.shortestSide >= 600;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // ── Map (fills the screen) ──────────────────────────────────
            Positioned.fill(
              child: Hero(
                tag: 'care-provider-map',
                child: ServiceProviderMap(
                  providers: visible,
                  center: center,
                  selectedId: selectedId,
                  onProviderTap: (branchId) =>
                      _selectBranch(branchId, expandSheet: true),
                  onMapTap: _deselect,
                  onCameraIdle: _onViewport,
                  onFirstViewport: _onViewport,
                  controllerReady: (c) => _mapController = c,
                ),
              ),
            ),

            // ── Top overlay: back + search + pet selector + filter chips ───
            _TopOverlay(
              isTablet: isTablet,
              onBack: () => context.pop(),
              searchBar: ProviderSearchBar(
                onChanged: (q) {
                  // When user types a search query, zoom to Lebanon bounds
                  if (q.isNotEmpty) {
                    _zoomToLebanon();
                  }
                  ref.read(providerSearchQueryProvider.notifier).set(q);
                },
              ),
              petSelector: hasPet ? const ProviderPetSelector() : null,
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
              minChildSize: _peek,
              maxChildSize: _expanded,
              snap: true,
              snapSizes: const [_peek, _collapsed, _expanded],
              builder: (context, scrollController) => _ResultsSheet(
                scrollController: scrollController,
                onHeaderDrag: _dragSheet,
                onHeaderDragEnd: _settleSheet,
                searchAsync: searchAsync,
                visible: visible,
                selectedId: selectedId,
                sort: sort,
                totalInViewport: result?.totalInViewport ?? visible.length,
                hasMore: result?.hasMore ?? false,
                tooZoomedOut: result?.tooZoomedOut ?? false,
                hasQueryOrFilter: category != ProviderCategory.all ||
                    ref.watch(providerSearchQueryProvider).isNotEmpty,
                onSortTap: _openSort,
                onSelect: _selectBranch,
                onOpen: _openProvider,
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

/// Top overlay hosting the floating search bar, the optional pet selector,
/// and the horizontal filter chips.
class _TopOverlay extends StatelessWidget {
  const _TopOverlay({
    required this.searchBar,
    required this.filterBar,
    required this.isTablet,
    required this.onBack,
    this.petSelector,
  });

  final Widget searchBar;
  final Widget filterBar;
  final Widget? petSelector;
  final bool isTablet;
  final VoidCallback onBack;

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
                  child: Row(
                    children: [
                      _BackButton(onTap: onBack),
                      const SizedBox(width: 12),
                      Expanded(child: searchBar),
                      if (petSelector != null) ...[
                        const SizedBox(width: 12),
                        petSelector!,
                      ],
                    ],
                  ),
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

/// Floating back button over the map, matching the map controls' surface card
/// styling so it reads as part of the same overlay layer.
class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Tooltip(
      message: l10n.back,
      child: Material(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        elevation: 3,
        shadowColor: AppColors.textPrimary.withValues(alpha: 0.3),
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.mdAll,
          child: Semantics(
            button: true,
            label: l10n.back,
            child: const SizedBox(
              width: 48,
              height: 48,
              child: Icon(
                FluentIcons.arrow_left_24_regular,
                size: 22,
                color: AppColors.textPrimary,
              ),
            ),
          ),
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
/// scrollable body that adapts to the load/empty/error/zoomed-out/data state.
class _ResultsSheet extends StatefulWidget {
  const _ResultsSheet({
    required this.scrollController,
    required this.onHeaderDrag,
    required this.onHeaderDragEnd,
    required this.searchAsync,
    required this.visible,
    required this.selectedId,
    required this.sort,
    required this.totalInViewport,
    required this.hasMore,
    required this.tooZoomedOut,
    required this.hasQueryOrFilter,
    required this.onSortTap,
    required this.onSelect,
    required this.onOpen,
    required this.onRetry,
    required this.onClearFilters,
  });

  final ScrollController scrollController;

  /// Called with the vertical drag delta while dragging the header, and with
  /// the fling velocity when the drag ends - so the header can resize the sheet.
  final ValueChanged<double> onHeaderDrag;
  final ValueChanged<double> onHeaderDragEnd;

  final AsyncValue<ProviderSearchResult> searchAsync;
  final List<ServiceProvider> visible;
  final int? selectedId;
  final ProviderSort sort;
  final int totalInViewport;
  final bool hasMore;
  final bool tooZoomedOut;
  final bool hasQueryOrFilter;
  final VoidCallback onSortTap;
  final void Function(int branchId) onSelect;
  final ValueChanged<ServiceProvider> onOpen;
  final VoidCallback onRetry;
  final VoidCallback onClearFilters;

  @override
  State<_ResultsSheet> createState() => _ResultsSheetState();
}

class _ResultsSheetState extends State<_ResultsSheet> {
  /// Per-branch keys so the freshly selected card can be scrolled into view.
  final Map<int, GlobalKey> _itemKeys = {};

  GlobalKey _keyFor(int branchId) =>
      _itemKeys.putIfAbsent(branchId, GlobalKey.new);

  @override
  void didUpdateWidget(_ResultsSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    final id = widget.selectedId;
    if (id != null && id != oldWidget.selectedId) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelected(id));
    }
  }

  void _scrollToSelected(int branchId) {
    final ctx = _itemKeys[branchId]?.currentContext;
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
          // The header is draggable: vertical drags resize the sheet, so the
          // user can grab the handle/header (not only the card list).
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onVerticalDragUpdate: (d) => widget.onHeaderDrag(d.delta.dy),
            onVerticalDragEnd: (d) =>
                widget.onHeaderDragEnd(d.velocity.pixelsPerSecond.dy),
            child: BottomSheetHeader(
              count: widget.visible.length,
              sort: widget.sort,
              onSortTap: widget.onSortTap,
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),
          Expanded(child: _body(context)),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    final l10n = context.l10n;

    return widget.searchAsync.when(
      skipLoadingOnRefresh: true,
      loading: () => const ProviderListSkeleton(),
      error: (error, _) {
        final failure = error is Failure ? error : const UnknownFailure();
        final offline = failure is NetworkFailure;
        return SingleChildScrollView(
          controller: widget.scrollController,
          child: ProviderEmptyState.offline(
            title: offline ? l10n.providerOfflineTitle : l10n.providerErrorTitle,
            message: offline
                ? l10n.providerOfflineMessage
                : l10n.providerErrorMessage,
            actionLabel: l10n.retry,
            onAction: widget.onRetry,
          ),
        );
      },
      data: (_) {
        // Bbox too large to search - prompt to zoom in.
        if (widget.tooZoomedOut) {
          return SingleChildScrollView(
            controller: widget.scrollController,
            child: ProviderEmptyState.noResults(
              title: l10n.providerZoomInTitle,
              message: l10n.providerZoomInMessage,
            ),
          );
        }

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

        // A "showing N of M - zoom in for the rest" footer when capped.
        final showHasMore = widget.hasMore &&
            widget.totalInViewport > visible.length;

        return ListView.separated(
          controller: widget.scrollController,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          itemCount: visible.length + (showHasMore ? 1 : 0),
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            if (showHasMore && i == visible.length) {
              return _HasMoreFooter(
                shown: visible.length,
                total: widget.totalInViewport,
              );
            }
            final provider = visible[i];
            return ProviderCard(
              key: _keyFor(provider.branchId),
              provider: provider,
              selected: provider.branchId == widget.selectedId,
              onTap: () => widget.onSelect(provider.branchId),
              onViewDetails: () => widget.onOpen(provider),
            );
          },
        );
      },
    );
  }
}

/// Footer shown when results are capped, nudging the user to zoom in for more.
class _HasMoreFooter extends StatelessWidget {
  const _HasMoreFooter({required this.shown, required this.total});

  final int shown;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Text(
          context.l10n.providerShowingOf(shown, total),
          style: const TextStyle(color: AppColors.textTertiary, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
