import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

/// Shows a modal bottom sheet using the app-wide chrome: surface background,
/// rounded top, a small grey drag handle, and a bottom safe-area margin. Use
/// this for every community-tab sheet so they match the rest of the app.
///
/// [builder] returns the sheet's content column; the handle and bottom spacing
/// are added automatically.
Future<T?> showCommunitySheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  bool isScrollControlled = false,
}) {
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: AppColors.surface,
    isScrollControlled: isScrollControlled,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
    ),
    builder: (ctx) => SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetHandle(),
          Flexible(child: builder(ctx)),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    ),
  );
}

/// The small grey drag handle shown at the top of every app bottom sheet
/// (40×4, brand divider colour). Matches PawHub's existing sheet handle.
class SheetHandle extends StatelessWidget {
  const SheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.divider,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
