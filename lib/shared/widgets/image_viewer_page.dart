import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../core/extensions/context_extensions.dart';
import '../../core/theme/app_spacing.dart';
import 'app_cached_image.dart';

/// Full-screen, pinch-to-zoom viewer for a single image (network or local
/// path). Black backdrop, a close button, and an optional [heroTag] so the
/// source thumbnail can animate into it.
class ImageViewerPage extends StatelessWidget {
  const ImageViewerPage({
    required this.imageUrl,
    this.heroTag,
    this.semanticLabel,
    super.key,
  });

  final String imageUrl;
  final Object? heroTag;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    Widget image = AppCachedImage(
      imageUrl: imageUrl,
      borderRadius: BorderRadius.zero,
      fit: BoxFit.contain,
      semanticLabel: semanticLabel,
    );
    if (heroTag != null) {
      image = Hero(tag: heroTag!, child: image);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 4,
              child: Center(child: image),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Material(
                  color: Colors.black.withValues(alpha: 0.4),
                  shape: const CircleBorder(),
                  child: IconButton(
                    tooltip: context.l10n.close,
                    icon: const Icon(
                      FluentIcons.dismiss_24_regular,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
