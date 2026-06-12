import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Standard loading state — no screen may ever be blank while loading.
class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }
}
