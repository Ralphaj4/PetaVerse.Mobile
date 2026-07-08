// One-off generator: builds padded, square icon/splash source images from
// assets/logo.png so the launcher icon and native splash don't touch the
// canvas edges (and survive Android adaptive-icon masking).
//
// Run from the project root:  dart run tool/gen_icon_sources.dart
//
// Outputs:
//   assets/logo_icon.png      1024² — logo ~65% wide, centered on white
//                             (standard launcher icon + iOS)
//   assets/logo_adaptive.png  1024² — logo ~65% wide, centered on transparent
//                             (Android adaptive foreground; bg supplies white)
//   assets/logo_splash.png    1024² — logo ~55% wide, centered on transparent
//                             (native splash; a touch smaller than the icon)
import 'dart:io';

import 'package:image/image.dart' as img;

/// Fraction of the square canvas the logo's longest side should span.
const double _iconScale = 0.65;
const double _splashScale = 0.55;
const int _canvas = 1024;

img.Image _composite(img.Image logo, double scale, {required bool white}) {
  // Scale the logo so its longest side is [scale] of the canvas, preserving
  // aspect ratio.
  final longest = logo.width >= logo.height ? logo.width : logo.height;
  final target = (_canvas * scale).round();
  final factor = target / longest;
  final resized = img.copyResize(
    logo,
    width: (logo.width * factor).round(),
    height: (logo.height * factor).round(),
    interpolation: img.Interpolation.cubic,
  );

  final canvas = img.Image(
    width: _canvas,
    height: _canvas,
    numChannels: 4,
  );
  if (white) {
    img.fill(canvas, color: img.ColorRgba8(255, 255, 255, 255));
  } else {
    // Transparent.
    img.fill(canvas, color: img.ColorRgba8(0, 0, 0, 0));
  }

  final dx = ((_canvas - resized.width) / 2).round();
  final dy = ((_canvas - resized.height) / 2).round();
  img.compositeImage(canvas, resized, dstX: dx, dstY: dy);
  return canvas;
}

void main() {
  final logo = img.decodePng(File('assets/logo.png').readAsBytesSync())!;

  File('assets/logo_icon.png').writeAsBytesSync(
    img.encodePng(_composite(logo, _iconScale, white: true)),
  );
  File('assets/logo_adaptive.png').writeAsBytesSync(
    img.encodePng(_composite(logo, _iconScale, white: false)),
  );
  File('assets/logo_splash.png').writeAsBytesSync(
    img.encodePng(_composite(logo, _splashScale, white: false)),
  );

  stdout.writeln('Wrote assets/logo_icon.png, logo_adaptive.png, '
      'logo_splash.png (${_canvas}x$_canvas).');
}
