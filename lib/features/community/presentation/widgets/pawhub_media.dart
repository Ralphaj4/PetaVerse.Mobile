import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../models/pawhub_models.dart';
import 'pawhub_common.dart';

/// A swipeable media carousel with page dots, a video affordance, a tap-to-zoom
/// hook, and a double-tap paw-burst like animation.
class PostMediaCarousel extends StatefulWidget {
  const PostMediaCarousel({
    required this.media,
    required this.liked,
    required this.onDoubleTapLike,
    required this.onOpenViewer,
    super.key,
  });

  final List<PawMedia> media;

  /// Current like state — a double-tap only *adds* a like (never unlikes),
  /// mirroring Instagram semantics; the burst always plays.
  final bool liked;
  final VoidCallback onDoubleTapLike;
  final void Function(int initialIndex) onOpenViewer;

  @override
  State<PostMediaCarousel> createState() => _PostMediaCarouselState();
}

class _PostMediaCarouselState extends State<PostMediaCarousel>
    with SingleTickerProviderStateMixin {
  final _controller = PageController();
  int _index = 0;

  late final AnimationController _burst = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  );

  @override
  void dispose() {
    _controller.dispose();
    _burst.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    widget.onDoubleTapLike();
    if (!(MediaQuery.maybeOf(context)?.disableAnimations ?? false)) {
      _burst.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.lgAll,
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onDoubleTap: _handleDoubleTap,
              onTap: () => widget.onOpenViewer(_index),
              child: PageView.builder(
                controller: _controller,
                itemCount: widget.media.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (_, i) {
                  final m = widget.media[i];
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Semantics(
                        image: true,
                        label: m.altText.isEmpty ? null : m.altText,
                        child: AppCachedImage(
                          imageUrl: m.url,
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      if (m.isVideo) const _VideoOverlay(),
                      if (m.isVideo && m.durationLabel != null)
                        PositionedDirectional(
                          bottom: AppSpacing.sm,
                          end: AppSpacing.sm,
                          child: _DurationBadge(label: m.durationLabel!),
                        ),
                    ],
                  );
                },
              ),
            ),

            // Double-tap paw burst.
            Center(
              child: AnimatedBuilder(
                animation: _burst,
                builder: (_, _) {
                  if (_burst.isDismissed) return const SizedBox.shrink();
                  final t = _burst.value;
                  final scale = 0.4 + Curves.easeOutBack.transform(t) * 0.8;
                  final opacity = t < 0.6 ? 1.0 : (1 - (t - 0.6) / 0.4);
                  return Opacity(
                    opacity: opacity.clamp(0, 1),
                    child: Transform.scale(
                      scale: scale,
                      child: const PawGlyph(
                        filled: true,
                        size: 96,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Media count pill (top-end) when multiple.
            if (widget.media.length > 1)
              PositionedDirectional(
                top: AppSpacing.sm,
                end: AppSpacing.sm,
                child: _CountPill(index: _index, total: widget.media.length),
              ),

            // Page dots.
            if (widget.media.length > 1)
              Positioned(
                bottom: AppSpacing.sm,
                left: 0,
                right: 0,
                child: _Dots(count: widget.media.length, index: _index),
              ),
          ],
        ),
      ),
    );
  }
}

class _VideoOverlay extends StatelessWidget {
  const _VideoOverlay();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.45),
          shape: BoxShape.circle,
        ),
        child: const Icon(FluentIcons.play_24_filled,
            color: Colors.white, size: 28),
      ),
    );
  }
}

class _DurationBadge extends StatelessWidget {
  const _DurationBadge({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(FluentIcons.video_24_filled, size: 12, color: Colors.white),
          const SizedBox(width: 4),
          Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _CountPill extends StatelessWidget {
  const _CountPill({required this.index, required this.total});
  final int index;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text('${index + 1}/$total',
          style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700)),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.index});
  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: i == index ? 18 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: i == index
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
      ],
    );
  }
}

/// Full-screen, pinch-to-zoom media viewer opened from a post.
class MediaZoomViewer extends StatefulWidget {
  const MediaZoomViewer({
    required this.media,
    required this.initialIndex,
    super.key,
  });

  final List<PawMedia> media;
  final int initialIndex;

  @override
  State<MediaZoomViewer> createState() => _MediaZoomViewerState();
}

class _MediaZoomViewerState extends State<MediaZoomViewer> {
  late final PageController _controller =
      PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.media.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (_, i) => InteractiveViewer(
              minScale: 1,
              maxScale: 4,
              child: Center(
                child: AppCachedImage(
                  imageUrl: widget.media[i].url,
                  borderRadius: BorderRadius.zero,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CircleBtn(
                    icon: FluentIcons.dismiss_24_regular,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  if (widget.media.length > 1)
                    _CountPill(index: _index, total: widget.media.length),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleBtn extends StatelessWidget {
  const _CircleBtn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.5),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
