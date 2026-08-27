import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/notifications/presentation/providers/notification_providers.dart';
import '../../features/pets/presentation/providers/pet_list_provider.dart';
import '../extensions/context_extensions.dart';
import '../theme/app_colors.dart';
import 'fcm_handler.dart';

const double _navBarHeight = 64;

const double _fabSize = 68;

/// How far the center paw button sinks below its centerFloat position so
/// it visually overlaps the bottom navigation bar.
const double _fabOverlap = 55;

/// centerFloat shifted down so the FAB renders on top of the bottom bar
/// (FABs always paint above the bottomNavigationBar in the Scaffold).
///
/// The keyboard inset ([ScaffoldPrelayoutGeometry.minInsets] bottom) is added
/// back so the button stays pinned to the bottom bar instead of riding up when
/// the keyboard opens — the center AI button must always stay put.
class _OverlappingCenterFabLocation extends FloatingActionButtonLocation {
  const _OverlappingCenterFabLocation();

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final base =
        FloatingActionButtonLocation.centerFloat.getOffset(scaffoldGeometry);
    return Offset(base.dx, base.dy + _fabOverlap + scaffoldGeometry.minInsets.bottom);
  }
}

/// Index of the profile branch in the bottom navigation.
const int _profileBranchIndex = 3;

/// Scaffold with the design's bottom navigation: four tabs and a
/// prominent center paw button that opens the AI assistant.
class AppShell extends ConsumerStatefulWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    FcmHandler.init(ref);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(notificationUnreadCountProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    void goBranch(int index) {
      // Offline-first refresh: reconcile the pet list when entering the
      // profile tab (it shows the cached list instantly, then updates).
      if (index == _profileBranchIndex &&
          index != widget.navigationShell.currentIndex) {
        ref.read(petListProvider.notifier).refresh();
      }
      widget.navigationShell.goBranch(
        index,
        initialLocation: index == widget.navigationShell.currentIndex,
      );
    }

    return Scaffold(
      body: widget.navigationShell,
      floatingActionButton: SizedBox(
        width: _fabSize,
        height: _fabSize,
        child: FloatingActionButton(
          // Explicit tag so this always-present shell FAB never collides with a
          // screen-level FAB's default Hero tag during route transitions.
          heroTag: 'app_shell_ai_fab',
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
              isSelected: widget.navigationShell.currentIndex == 0,
              onTap: () => goBranch(0),
            ),
            _NavItem(
              icon: FluentIcons.people_community_24_regular,
              selectedIcon: FluentIcons.people_community_24_filled,
              label: l10n.navCommunity,
              isSelected: widget.navigationShell.currentIndex == 1,
              onTap: () => goBranch(1),
            ),
            const Spacer(),
            _NavItem(
              icon: FluentIcons.stethoscope_24_regular,
              selectedIcon: FluentIcons.stethoscope_24_filled,
              label: l10n.navCare,
              isSelected: widget.navigationShell.currentIndex == 2,
              onTap: () => goBranch(2),
            ),
            _NavItem(
              icon: FluentIcons.person_24_regular,
              selectedIcon: FluentIcons.person_24_filled,
              label: l10n.navProfile,
              isSelected: widget.navigationShell.currentIndex == _profileBranchIndex,
              onTap: () => goBranch(_profileBranchIndex),
            ),
          ],
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
