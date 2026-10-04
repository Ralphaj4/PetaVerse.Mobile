import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/app/tab_scroll_to_top_provider.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'communities_page.dart';
import 'pawhub_page.dart';

/// The PetaHub destination (bottom-nav tab 1). Hosts the two social
/// "other people's pets" surfaces behind a segmented control:
/// Feed (PawHub) · Communities.
///
/// Communities renders in [embedded] mode (no own AppBar) - the hub supplies
/// the shared header. PawHub keeps its own functional toolbar (pet switcher /
/// search) below the segmented control. Lost & Found and Adoption now live on
/// Home, not here.
class CommunityHubPage extends ConsumerStatefulWidget {
  const CommunityHubPage({this.initialTab = 0, super.key});

  /// Which segment to open on first build: 0 = Feed, 1 = Communities.
  final int initialTab;

  @override
  ConsumerState<CommunityHubPage> createState() => _CommunityHubPageState();
}

class _CommunityHubPageState extends ConsumerState<CommunityHubPage>
    with SingleTickerProviderStateMixin {
  late final TabController _controller = TabController(
    length: 2,
    vsync: this,
    initialIndex: widget.initialTab.clamp(0, 1),
  )..addListener(_onTabChanged);

  void _onTabChanged() {
    // Always show the tab bar when switching tabs.
    if (!_tabBarVisible) setState(() => _tabBarVisible = true);
  }

  /// One scroll controller per inner tab (Feed · Communities), handed down via
  /// [PrimaryScrollController] so re-tapping the PetaHub bottom-nav tab can
  /// scroll whichever inner tab is showing back to the top.
  final _innerScrollControllers =
      List.generate(2, (_) => ScrollController());

  bool _tabBarVisible = true;
  double _lastScrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _innerScrollControllers[0].addListener(_onFeedScroll);
  }

  void _onFeedScroll() {
    final offset = _innerScrollControllers[0].offset;
    final delta = offset - _lastScrollOffset;
    _lastScrollOffset = offset;
    if (offset <= 0) {
      if (!_tabBarVisible) setState(() => _tabBarVisible = true);
      return;
    }
    if (delta > 4 && _tabBarVisible) {
      setState(() => _tabBarVisible = false);
    } else if (delta < -4 && !_tabBarVisible) {
      setState(() => _tabBarVisible = true);
    }
  }

  /// Scroll the currently-visible inner tab to the top.
  void _scrollActiveTabToTop() {
    final c = _innerScrollControllers[_controller.index];
    if (!c.hasClients) return;
    c.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onTabChanged);
    _controller.dispose();
    _innerScrollControllers[0].removeListener(_onFeedScroll);
    for (final c in _innerScrollControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // Bottom nav bumps this when the Community tab (branch 1) is re-tapped at
    // root - scroll whichever inner tab is showing back to the top.
    ref.listen(
      tabScrollToTopProvider.select((m) => m[1]),
      (_, _) => _scrollActiveTabToTop(),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // ── Shared tab bar (icon over label, card + underline) ──────
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: _tabBarVisible
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.lg,
                          AppSpacing.md,
                          AppSpacing.lg,
                          AppSpacing.sm,
                        ),
                        child: _HubTabBar(
                          controller: _controller,
                          tabs: [
                            (icon: FluentIcons.animal_paw_print_24_filled,
                                label: l10n.communityTabFeed),
                            (icon: FluentIcons.people_community_24_filled,
                                label: l10n.communitiesTitle),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  // Each inner tab gets its own primary scroll controller so a
                  // Community-tab re-tap can scroll the active one to the top.
                  children: [
                    PrimaryScrollController(
                      controller: _innerScrollControllers[0],
                      child: PawHubPage(barsVisible: _tabBarVisible),
                    ),
                    PrimaryScrollController(
                      controller: _innerScrollControllers[1],
                      child: const CommunitiesPage(embedded: true),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The Community hub's top tab bar: a rounded white card holding icon-over-label
/// tabs separated by thin dividers, with a short underline under the selected
/// tab. Selected tab is brand-orange; the rest are muted grey.
class _HubTabBar extends StatelessWidget {
  const _HubTabBar({required this.controller, required this.tabs});

  final TabController controller;
  final List<({IconData icon, String label})> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      // Rebuild the row as the controller animates so colors/underline track
      // the selection (also mid-swipe).
      child: AnimatedBuilder(
        animation: controller.animation ?? controller,
        builder: (context, _) {
          final selected = controller.index;
          return Row(
            children: [
              for (var i = 0; i < tabs.length; i++) ...[
                if (i > 0)
                  Container(
                    width: 1,
                    height: 36,
                    color: AppColors.divider,
                  ),
                Expanded(
                  child: _HubTab(
                    icon: tabs[i].icon,
                    label: tabs[i].label,
                    isSelected: i == selected,
                    onTap: () => controller.animateTo(i),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

/// A single icon-over-label tab with an animated underline when selected.
class _HubTab extends StatelessWidget {
  const _HubTab({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : AppColors.textSecondary;
    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.lgAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 22, color: color),
              const SizedBox(height: 6),
              Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(
                  color: color,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  letterSpacing: 0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              // Short underline indicator under the selected tab.
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 3,
                width: isSelected ? 24 : 0,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
