import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../adoption/presentation/pages/adoption_board_page.dart';
import '../../../lost_and_found/presentation/pages/lost_and_found_page.dart';
import 'pawhub_page.dart';

/// The Community destination (bottom-nav tab 1). Hosts the three
/// "other people's pets" surfaces behind a segmented control:
/// Feed (PawHub) · Lost & Found · Adoption.
///
/// Each surface is a self-contained page. To avoid stacked chrome, Lost & Found
/// and Adoption render in [embedded] mode (no own AppBar) — the hub supplies the
/// shared header. PawHub keeps its own functional toolbar (pet switcher /
/// notifications) below the segmented control.
class CommunityHubPage extends StatefulWidget {
  const CommunityHubPage({super.key});

  @override
  State<CommunityHubPage> createState() => _CommunityHubPageState();
}

class _CommunityHubPageState extends State<CommunityHubPage>
    with SingleTickerProviderStateMixin {
  late final TabController _controller =
      TabController(length: 3, vsync: this);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // ── Shared tab bar (icon over label, card + underline) ──────
              Padding(
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
                    (icon: FluentIcons.search_24_regular,
                        label: l10n.lostAndFound),
                    (icon: FluentIcons.home_24_regular,
                        label: l10n.adoptionTitle),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  children: const [
                    PawHubPage(),
                    LostAndFoundPage(embedded: true),
                    AdoptionBoardPage(embedded: true),
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
