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
  static Future<BitmapDescriptor> fromPainter({
    required String cacheKey,
    required CustomPainter painter,
    required Size size,
    required double devicePixelRatio,
  }) async {
    final cached = _cache[cacheKey];
    if (cached != null) return cached;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.scale(devicePixelRatio);
    painter.paint(canvas, size);

    final image = await recorder.endRecording().toImage(
          (size.width * devicePixelRatio).ceil(),
          (size.height * devicePixelRatio).ceil(),
        );
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    if (bytes == null) return BitmapDescriptor.defaultMarker;

    final descriptor = BitmapDescriptor.bytes(
      bytes.buffer.asUint8List(),
      width: size.width,
      height: size.height,
    );
    _cache[cacheKey] = descriptor;
    return descriptor;
  }

  /// Clears the bitmap cache. Call if the theme changes at runtime so pins are
  /// re-rendered with new colors.
  static void clearCache() => _cache.clear();
}
