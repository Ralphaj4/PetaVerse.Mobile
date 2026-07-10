import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';

/// Vertical stack of floating map controls (Material-3 styled): recenter on the
/// user's location and an optional map/list toggle. Sits above the bottom
/// sheet, animating up as the sheet grows so it's never covered.
class MapControls extends StatelessWidget {
  const MapControls({
    required this.onRecenter,
    this.onToggleView,
    this.isListView = false,
    super.key,
  });

  final VoidCallback onRecenter;

  /// Optional map/list toggle. When null the button is hidden.
  final VoidCallback? onToggleView;
  final bool isListView;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (onToggleView != null) ...[
          _ControlButton(
            icon: isListView
                ? FluentIcons.map_24_regular
                : FluentIcons.list_24_regular,
            tooltip: isListView ? l10n.providerShowMap : l10n.providerShowList,
            onTap: onToggleView!,
          ),
          const SizedBox(height: 10),
        ],
        _ControlButton(
          icon: FluentIcons.my_location_24_regular,
          tooltip: l10n.providerMyLocation,
          onTap: onRecenter,
          accent: AppColors.secondary,
        ),
      ],
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.accent,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
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
            label: tooltip,
            child: SizedBox(
              width: 48,
              height: 48,
              child: Icon(
                icon,
                size: 22,
                color: accent ?? AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
