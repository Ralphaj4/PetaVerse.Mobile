import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/pets/presentation/providers/pet_list_provider.dart';
import '../extensions/context_extensions.dart';
import '../theme/app_colors.dart';

const double _navBarHeight = 64;

/// Inset of the floating nav bar from the screen edges.
const double _navBarMargin = 16;

/// Vertical space the floating nav bar occupies above the system safe area
/// (its height + bottom margin). Shell pages with `extendBody: true` content
/// should add this — plus the safe-area bottom inset — to their bottom padding
/// so nothing scrolls underneath the bar. See [floatingNavBarClearance].
const double kFloatingNavBarExtent = _navBarHeight + _navBarMargin;

/// Total bottom padding a shell page needs so its content clears the floating
/// nav bar: the bar's extent plus the device's safe-area bottom inset.
double floatingNavBarClearance(BuildContext context) =>
    kFloatingNavBarExtent + MediaQuery.paddingOf(context).bottom;

/// Corner radius of the floating nav bar.
const double _navBarRadius = 28;

const double _fabSize = 68;

/// Centers the paw FAB horizontally and parks it straddling the TOP edge of the
/// floating nav bar, so it overlaps the bar regardless of the safe-area inset.
class _OverlappingCenterFabLocation extends FloatingActionButtonLocation {
  const _OverlappingCenterFabLocation();

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final dx = (scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width) /
        2;
    // Top edge of the floating bar, measured from the top of the scaffold.
    final barTop = scaffoldGeometry.scaffoldSize.height -
        scaffoldGeometry.minViewPadding.bottom -
        _navBarMargin -
        _navBarHeight;
    // Center the FAB on that edge.
    final dy =
        barTop - scaffoldGeometry.floatingActionButtonSize.height / 2;
    return Offset(dx, dy);
  }
}

/// Index of the profile branch in the bottom navigation.
const int _profileBranchIndex = 3;

/// Scaffold with the design's bottom navigation: four tabs and a
/// prominent center paw button that opens the AI assistant.
class AppShell extends ConsumerWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    void goBranch(int index) {
      // Offline-first refresh: reconcile the pet list when entering the
      // profile tab (it shows the cached list instantly, then updates).
      if (index == _profileBranchIndex &&
          index != navigationShell.currentIndex) {
        ref.read(petListProvider.notifier).refresh();
      }
      navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );
    }

    return Scaffold(
      body: navigationShell,
      floatingActionButton: SizedBox(
        width: _fabSize,
        height: _fabSize,
        child: FloatingActionButton(
          onPressed: () => context.push('/assistant'),
          tooltip: l10n.aiAssistant,
          child: const Icon(FluentIcons.animal_paw_print_24_filled, size: 32),
        ),
      ),
      floatingActionButtonLocation: const _OverlappingCenterFabLocation(),
      // Transparent host so the visible bar can float with margins; the rounded
      // white surface lives inside.
      extendBody: true,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            _navBarMargin,
            0,
            _navBarMargin,
            _navBarMargin,
          ),
          child: Container(
            height: _navBarHeight,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(_navBarRadius),
              boxShadow: [
                BoxShadow(
                  color: AppColors.textPrimary.withValues(alpha: 0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                _NavItem(
                  icon: FluentIcons.home_24_regular,
                  selectedIcon: FluentIcons.home_24_filled,
                  label: l10n.navHome,
                  isSelected: navigationShell.currentIndex == 0,
                  onTap: () => goBranch(0),
                ),
                _NavItem(
                  icon: FluentIcons.people_community_24_regular,
                  selectedIcon: FluentIcons.people_community_24_filled,
                  label: l10n.navCommunity,
                  isSelected: navigationShell.currentIndex == 1,
                  onTap: () => goBranch(1),
                ),
                const Spacer(),
                _NavItem(
                  icon: FluentIcons.stethoscope_24_regular,
                  selectedIcon: FluentIcons.stethoscope_24_filled,
                  label: l10n.navCare,
                  isSelected: navigationShell.currentIndex == 2,
                  onTap: () => goBranch(2),
                ),
                _NavItem(
                  icon: FluentIcons.person_24_regular,
                  selectedIcon: FluentIcons.person_24_filled,
                  label: l10n.navProfile,
                  isSelected:
                      navigationShell.currentIndex == _profileBranchIndex,
                  onTap: () => goBranch(_profileBranchIndex),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color =
        isSelected ? AppColors.primary : AppColors.textTertiary;
    return Expanded(
      child: Semantics(
        button: true,
        selected: isSelected,
        label: label,
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(isSelected ? selectedIcon : icon, color: color),
              const SizedBox(height: 2),
              Text(
                label,
                style: context.textTheme.labelSmall?.copyWith(color: color),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
