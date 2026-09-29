import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/services/video_cache.dart';
import '../../../../core/theme/app_colors.dart';
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
                      // Videos show the server-generated poster (tiny, cached);
                      // the clip itself is fetched only when the full-screen
                      // viewer opens. Images render normally.
                      if (m.isVideo)
                        (m.thumbnailUrl != null)
                            ? AppCachedImage(
                                imageUrl: m.thumbnailUrl,
                                borderRadius: BorderRadius.zero,
                              )
                            : const ColoredBox(color: Colors.black)
                      else
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
            itemBuilder: (_, i) {
              final m = widget.media[i];
              if (m.isVideo) {
                return _VideoPlayerView(
                    url: m.url, thumbnailUrl: m.thumbnailUrl);
              }
              return InteractiveViewer(
                minScale: 1,
                maxScale: 4,
                child: Center(
                  child: AppCachedImage(
                    imageUrl: m.url,
                    borderRadius: BorderRadius.zero,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
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

/// Formats a [Duration] as `m:ss` (or `h:mm:ss` past an hour).
String _fmtDuration(Duration d) {
  final h = d.inHours;
  final m = d.inMinutes.remainder(60);
  final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
  if (h > 0) return '$h:${m.toString().padLeft(2, '0')}:$s';
  return '$m:$s';
}

/// A polished network video player for the full-screen viewer:
/// - cached poster behind the video until the first frame is ready
/// - tap toggles auto-hiding controls; big center play/pause
/// - seekable scrub bar with elapsed / total time
/// - buffering spinner, mute toggle, loops
class _VideoPlayerView extends ConsumerStatefulWidget {
  const _VideoPlayerView({required this.url, this.thumbnailUrl});

  final String url;
  final String? thumbnailUrl;

  @override
  ConsumerState<_VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends ConsumerState<_VideoPlayerView> {
  VideoPlayerController? _controller;
  bool _initialized = false;
  bool _failed = false;
  bool _controlsVisible = true;
  bool _muted = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      // Download-once into the on-disk cache, then play from the local file so
      // replays never re-fetch over the network.
      final file = await ref.read(videoCacheProvider).fileFor(widget.url);
      if (!mounted) return;
      final controller = VideoPlayerController.file(file);
      _controller = controller;
      controller.addListener(_onTick);
      await controller.initialize();
      await controller.setLooping(true);
      if (!mounted) return;
      setState(() => _initialized = true);
      await controller.play();
      _scheduleHideControls();
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  void _onTick() {
    if (mounted) setState(() {}); // drive scrub bar + time labels
  }

  @override
  void dispose() {
    _controller?.removeListener(_onTick);
    _controller?.dispose();
    super.dispose();
  }

  void _scheduleHideControls() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      final c = _controller;
      if (c != null && c.value.isPlaying) {
        setState(() => _controlsVisible = false);
      }
    });
  }

  void _toggleControls() {
    setState(() => _controlsVisible = !_controlsVisible);
    if (_controlsVisible) _scheduleHideControls();
  }

  void _togglePlay() {
    final c = _controller;
    if (c == null || !_initialized) return;
    setState(() {
      if (c.value.isPlaying) {
        c.pause();
        _controlsVisible = true;
      } else {
        c.play();
        _scheduleHideControls();
      }
    });
  }

  void _toggleMute() {
    final c = _controller;
    if (c == null) return;
    setState(() {
      _muted = !_muted;
      c.setVolume(_muted ? 0 : 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_failed) {
      return const Center(
        child: Icon(FluentIcons.video_off_24_regular,
            color: Colors.white54, size: 48),
      );
    }
    final c = _controller;
    final value = c?.value;
    final ready = _initialized && c != null && value != null;
    final buffering = ready && value.isBuffering;

    return GestureDetector(
      onTap: _toggleControls,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Server poster stays behind until the first video frame is ready.
          Positioned.fill(
            child: widget.thumbnailUrl != null
                ? AppCachedImage(
                    imageUrl: widget.thumbnailUrl,
                    fit: BoxFit.contain,
                    borderRadius: BorderRadius.zero,
                  )
                : const ColoredBox(color: Colors.black),
          ),
          if (ready)
            Center(
              child: AspectRatio(
                aspectRatio: value.aspectRatio == 0 ? 16 / 9 : value.aspectRatio,
                child: VideoPlayer(c),
              ),
            ),

          // Buffering / initial-load spinner.
          if (!ready || buffering)
            const CircularProgressIndicator(color: Colors.white),

          // Controls scrim + center play/pause (auto-hide while playing).
          if (ready)
            AnimatedOpacity(
              opacity: _controlsVisible ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: IgnorePointer(
                ignoring: !_controlsVisible,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Center play/pause.
                    _GlyphButton(
                      icon: value.isPlaying
                          ? FluentIcons.pause_24_filled
                          : FluentIcons.play_24_filled,
                      onTap: _togglePlay,
                    ),
                    // Bottom bar: time + scrub + mute.
                    Positioned(
                      left: AppSpacing.md,
                      right: AppSpacing.md,
                      bottom: AppSpacing.md,
                      child: _VideoControlBar(
                        controller: c,
                        muted: _muted,
                        onToggleMute: _toggleMute,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Bottom control bar: elapsed time, seekable progress, total time, mute.
class _VideoControlBar extends StatelessWidget {
  const _VideoControlBar({
    required this.controller,
    required this.muted,
    required this.onToggleMute,
  });

  final VideoPlayerController controller;
  final bool muted;
  final VoidCallback onToggleMute;

  @override
  Widget build(BuildContext context) {
    final value = controller.value;
    return Row(
      children: [
        Text(_fmtDuration(value.position),
            style: const TextStyle(color: Colors.white, fontSize: 12)),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: VideoProgressIndicator(
            controller,
            allowScrubbing: true,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            colors: const VideoProgressColors(
              playedColor: AppColors.primary,
              bufferedColor: Colors.white38,
              backgroundColor: Colors.white24,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(_fmtDuration(value.duration),
            style: const TextStyle(color: Colors.white, fontSize: 12)),
        const SizedBox(width: AppSpacing.xs),
        GestureDetector(
          onTap: onToggleMute,
          child: Icon(
            muted
                ? FluentIcons.speaker_mute_24_filled
                : FluentIcons.speaker_2_24_filled,
            color: Colors.white,
            size: 20,
          ),
        ),
      ],
    );
  }
}

/// The translucent circular play/pause glyph in the video center.
class _GlyphButton extends StatelessWidget {
  const _GlyphButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 34),
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
