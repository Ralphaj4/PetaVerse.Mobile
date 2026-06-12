import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_colors.dart';

const double _navBarHeight = 64;

const double _fabSize = 68;

/// How far the center paw button sinks below its centerFloat position so
/// it visually overlaps the bottom navigation bar.
const double _fabOverlap = 55;

/// centerFloat shifted down so the FAB renders on top of the bottom bar
/// (FABs always paint above the bottomNavigationBar in the Scaffold).
class _OverlappingCenterFabLocation extends FloatingActionButtonLocation {
  const _OverlappingCenterFabLocation();

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final base =
        FloatingActionButtonLocation.centerFloat.getOffset(scaffoldGeometry);
    return Offset(base.dx, base.dy + _fabOverlap);
  }
}

/// Scaffold with the design's bottom navigation: four tabs and a
/// prominent center paw button that opens the AI assistant.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
      bottomNavigationBar: BottomAppBar(
        color: AppColors.surface,
        height: _navBarHeight,
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            _NavItem(
              icon: FluentIcons.home_24_regular,
              selectedIcon: FluentIcons.home_24_filled,
              label: l10n.navHome,
              isSelected: navigationShell.currentIndex == 0,
              onTap: () => _goBranch(0),
            ),
            _NavItem(
              icon: FluentIcons.people_community_24_regular,
              selectedIcon: FluentIcons.people_community_24_filled,
              label: l10n.navCommunity,
              isSelected: navigationShell.currentIndex == 1,
              onTap: () => _goBranch(1),
            ),
            const Spacer(),
            _NavItem(
              icon: FluentIcons.stethoscope_24_regular,
              selectedIcon: FluentIcons.stethoscope_24_filled,
              label: l10n.navCare,
              isSelected: navigationShell.currentIndex == 2,
              onTap: () => _goBranch(2),
            ),
            _NavItem(
              icon: FluentIcons.person_24_regular,
              selectedIcon: FluentIcons.person_24_filled,
              label: l10n.navProfile,
              isSelected: navigationShell.currentIndex == 3,
              onTap: () => _goBranch(3),
            ),
          ],
        ),
      ),
    );
  }

  void _goBranch(int index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );
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
