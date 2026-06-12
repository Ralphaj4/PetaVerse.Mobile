import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'app_cached_image.dart';

/// Circular avatar for users and pets — image if available, otherwise
/// initials on a brand tint.
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    required this.name,
    this.imageUrl,
    this.radius = 24,
    super.key,
  });

  final String name;
  final String? imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return AppCachedImage(
        imageUrl: imageUrl,
        width: radius * 2,
        height: radius * 2,
        borderRadius: BorderRadius.circular(radius),
        semanticLabel: name,
      );
    }
    final initials = name.trim().isEmpty
        ? '?'
        : name
            .trim()
            .split(RegExp(r'\s+'))
            .take(2)
            .map((w) => w[0].toUpperCase())
            .join();
    return Semantics(
      label: name,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.secondarySoft,
        child: Text(
          initials,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.secondaryDark,
                fontSize: radius * 0.7,
              ),
        ),
      ),
    );
  }
}
