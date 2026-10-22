import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../network/dtos/media_dtos.dart';
import 'media_constraints.dart';

/// Downscales and re-encodes picked images before upload.
///
/// This is what makes the size caps rarely bite legitimate photos: an ~8 MB
/// camera shot drops well under 1 MB after downscale to the category's longest
/// edge. It also transcodes HEIC/HEIF (the iPhone default) to JPEG so the
/// backend and every display surface only ever see web-friendly formats, and
/// strips EXIF so location metadata doesn't leak with the photo.
class ImageCompressor {
  const ImageCompressor();

  /// Compress [file] for [category]. Returns a new temp-file JPEG, or the
  /// original file if compression fails for any reason (so a pick never dead-ends
  /// - the upload-service guard still enforces the hard cap afterwards).
  static Future<File> compress(File file, MediaCategory category) async {
    try {
      final maxEdge = MediaConstraints.maxDimensionFor(category);
      final target = await _targetPath();

      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        target,
        quality: MediaConstraints.jpegQuality,
        minWidth: maxEdge,
        minHeight: maxEdge,
        keepExif: false,
        format: CompressFormat.jpeg,
      );

      if (result == null) return file;
      return File(result.path);
    } catch (_) {
      // Any native failure (unsupported codec, OOM) → fall back to the original.
      return file;
    }
  }

  /// A unique temp path for the compressed output. A monotonic per-process
  /// counter avoids collisions when compressing several images in a row without
  /// needing Date.now()/Random.
  static Future<String> _targetPath() async {
    final dir = await getTemporaryDirectory();
    final name = 'cmp_${_counter++}.jpg';
    return p.join(dir.path, name);
  }

  static int _counter = 0;
}
