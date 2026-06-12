import 'package:flutter/material.dart';

import '../../core/extensions/context_extensions.dart';

/// Section title row with an optional trailing "See all" action,
/// as used across the dashboard and lists in the design.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    this.onSeeAll,
    super.key,
  });

  final String title;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: context.textTheme.titleLarge),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            child: Text(context.l10n.seeAll),
          ),
      ],
    );
  }
}
