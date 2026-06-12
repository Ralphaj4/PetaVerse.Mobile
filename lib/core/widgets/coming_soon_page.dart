import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Temporary stand-in for tabs whose feature module is not built yet.
///
/// [isModal] is for screens presented with the slide-up transition
/// (e.g. the AI assistant): they close with an X instead of a back arrow.
class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({
    required this.title,
    this.isModal = false,
    super.key,
  });

  final String title;
  final bool isModal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: isModal
            ? IconButton(
                icon: const Icon(FluentIcons.dismiss_24_regular),
                tooltip: context.l10n.close,
                onPressed: () => context.pop(),
              )
            : null,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              FluentIcons.animal_paw_print_24_regular,
              size: 64,
              color: AppColors.primary,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(context.l10n.comingSoon, style: context.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
