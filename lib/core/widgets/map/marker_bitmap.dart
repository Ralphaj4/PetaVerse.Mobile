import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Renders Flutter-drawn marker art into [BitmapDescriptor]s for Google Maps.
///
/// Google Maps markers are native images, not live Flutter widgets, so the
/// app's custom-painted pins (teardrops, colored dots, cluster bubbles) are
/// rasterized once via a [CustomPainter] and cached by a caller-supplied key.
/// This keeps the pin *designs* in Flutter while satisfying the native map.
class MarkerBitmap {
  MarkerBitmap._();

  static final Map<String, BitmapDescriptor> _cache = {};

  /// Returns a cached bitmap for [cacheKey], painting it with [painter] at
  /// logical [size] (scaled by [devicePixelRatio]) on first request.
  ///
  /// [cacheKey] must fully capture the visual inputs (color, selected state,
  /// count, dpr) so distinct-looking pins don't collide.
  ///
  /// [glowPadding] adds transparent space around the canvas so blur/glow
  /// effects don't get hard-clipped at the image boundary (which makes Google
  /// Maps show a colored square around the pin). The painter receives the same
  /// [size] but the rasterised image is inflated by [glowPadding] on all sides;
  /// the content is translated inward so it stays centred within the larger
  /// canvas. The marker anchor remains correct because `imagePixelRatio` is used
  /// (not explicit width/height), so the SDK derives physical size from DPR.
  static Future<BitmapDescriptor> fromPainter({
    required String cacheKey,
    required CustomPainter painter,
    required Size size,
    required double devicePixelRatio,
    double glowPadding = 0,
  }) async {
    final cached = _cache[cacheKey];
    if (cached != null) return cached;

    final padded = Size(
      size.width + glowPadding * 2,
      size.height + glowPadding * 2,
    );

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.scale(devicePixelRatio);
    // Translate so the painter's coordinate origin is inset by [glowPadding],
    // giving the blur room to bleed into the transparent padding zone.
    if (glowPadding > 0) canvas.translate(glowPadding, glowPadding);
    painter.paint(canvas, size);

    final image = await recorder.endRecording().toImage(
          (padded.width * devicePixelRatio).ceil(),
          (padded.height * devicePixelRatio).ceil(),
        );
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    if (bytes == null) return BitmapDescriptor.defaultMarker;

    final descriptor = BitmapDescriptor.bytes(
      bytes.buffer.asUint8List(),
      imagePixelRatio: devicePixelRatio,
    );
    _cache[cacheKey] = descriptor;
    return descriptor;
  }

  /// Clears the bitmap cache. Call if the theme changes at runtime so pins are
  /// re-rendered with new colors.
  static void clearCache() => _cache.clear();
}
