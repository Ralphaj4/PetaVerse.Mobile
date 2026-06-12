import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/router/app_router.dart';
import '../theme/app_colors.dart';

/// Temporary home screen shown until the real Home feature is built.
/// In debug builds it exposes a button to open the sandbox.
class HomePlaceholderPage extends StatelessWidget {
  const HomePlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PetaVerse')),
      body: Center(
        child: kDebugMode
            ? FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                ),
                onPressed: () => context.push(AppRoutes.sandbox),
                child: const Text('Open Sandbox'),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
