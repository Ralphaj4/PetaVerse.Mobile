import 'dart:io';

import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;

import '../localization/generated/app_localizations.dart';
import '../network/dtos/media_dtos.dart';
import 'media_constraints.dart';

/// Outcome of validating a single picked media file. A sealed result so callers
/// handle each case exhaustively; map to a user string via [MediaValidationL10n].
sealed class MediaValidation {
  const MediaValidation();

  bool get isValid => this is MediaValid;
}

/// The file passed all checks. [contentType] is the real detected MIME type to
/// send to `/upload-url` and the R2 PUT (never a hardcoded guess).
final class MediaValid extends MediaValidation {
  const MediaValid(this.contentType);

  final String contentType;
}

/// The file exceeds the category's byte cap. [limitBytes] is the cap that was
/// exceeded (for the localized "max NN MB" message).
final class MediaTooLarge extends MediaValidation {
  const MediaTooLarge(this.limitBytes);

  final int limitBytes;
}

/// The extension/MIME is not in the allow-list for its media class.
final class MediaUnsupportedFormat extends MediaValidation {
  const MediaUnsupportedFormat();
}

/// A video longer than the allowed duration. [limitSeconds] is the cap.
final class MediaVideoTooLong extends MediaValidation {
  const MediaVideoTooLong(this.limitSeconds);

  final int limitSeconds;
}

/// Validates picked media against [MediaConstraints] before any upload is
/// attempted. Pure (no Flutter imports) so it can be unit-tested and reused
/// from both pick sites and the upload service guard.
class MediaValidator {
  const MediaValidator();

  /// Validate an image for [category]. Returns [MediaValid] with the detected
  /// content type, or a failure variant. HEIC/HEIF are treated as valid here;
  /// they are transcoded to JPEG before upload.
  static MediaValidation validateImage(File file, MediaCategory category) {
    final ext = _ext(file.path);
    final mime = detectImageMime(file);

    final extOk = MediaConstraints.allowedImageExtensions.contains(ext);
    final mimeOk =
        mime != null && MediaConstraints.allowedImageMimeTypes.contains(mime);
    // Accept when either signal matches the allow-list - MIME sniffing can miss
    // (HEIC on some platforms) and extensions can lie, so neither alone is
    // authoritative, but one positive is enough to proceed to compression.
    if (!extOk && !mimeOk) return const MediaUnsupportedFormat();

    final limit = MediaConstraints.imageMaxBytesFor(category);
    final length = _safeLength(file);
    if (length > limit) return MediaTooLarge(limit);

    // After compression most images become JPEG; callers overwrite this with
    // the compressed file's type. Fall back to jpeg when sniffing failed.
    return MediaValid(mime ?? 'image/jpeg');
  }

  /// Validate a video for [category]. [durationSeconds] comes from the caller
  /// (the composer already reads it via VideoPlayerController).
  static MediaValidation validateVideo(
    File file,
    MediaCategory category, {
    int? durationSeconds,
  }) {
    final ext = _ext(file.path);
    final mime = detectVideoMime(file);

    final extOk = MediaConstraints.allowedVideoExtensions.contains(ext);
    final mimeOk =
        mime != null && MediaConstraints.allowedVideoMimeTypes.contains(mime);
    if (!extOk && !mimeOk) return const MediaUnsupportedFormat();

    final length = _safeLength(file);
    if (length > MediaConstraints.videoMaxBytes) {
      return const MediaTooLarge(MediaConstraints.videoMaxBytes);
    }

    if (durationSeconds != null &&
        durationSeconds > MediaConstraints.videoMaxDurationSeconds) {
      return const MediaVideoTooLong(MediaConstraints.videoMaxDurationSeconds);
    }

    return MediaValid(mime ?? 'video/mp4');
  }

  /// Best-effort image MIME detection: file-extension map first (reliable for
  /// the formats we accept), then header-byte sniffing as a fallback.
  static String? detectImageMime(File file) {
    final byName = lookupMimeType(file.path);
    if (byName != null && byName.startsWith('image/')) return byName;
    final sniffed = lookupMimeType(file.path, headerBytes: _header(file));
    if (sniffed != null && sniffed.startsWith('image/')) return sniffed;
    // `mime` doesn't map .heic/.heif - infer from extension so iPhone shots
    // aren't rejected before we get a chance to transcode them.
    final ext = _ext(file.path);
    if (ext == 'heic') return 'image/heic';
    if (ext == 'heif') return 'image/heif';
    return byName ?? sniffed;
  }

  static String? detectVideoMime(File file) {
    final byName = lookupMimeType(file.path);
    if (byName != null && byName.startsWith('video/')) return byName;
    final sniffed = lookupMimeType(file.path, headerBytes: _header(file));
    if (sniffed != null && sniffed.startsWith('video/')) return sniffed;
    return byName ?? sniffed;
  }

  static String _ext(String path) =>
      p.extension(path).replaceFirst('.', '').toLowerCase();

  static int _safeLength(File file) {
    try {
      return file.lengthSync();
    } catch (_) {
      return 0;
    }
  }

  static List<int>? _header(File file) {
    try {
      final raf = file.openSync();
      try {
        final len = file.lengthSync();
        return raf.readSync(len < 64 ? len : 64);
      } finally {
        raf.closeSync();
      }
    } catch (_) {
      return null;
    }
  }
}

/// Maps a [MediaValidation] failure to a localized, user-facing message.
extension MediaValidationL10n on MediaValidation {
  String localizedMessage(AppLocalizations l10n) => switch (this) {
        MediaValid() => '',
        MediaTooLarge(:final limitBytes) =>
          l10n.mediaTooLarge(_formatMb(limitBytes)),
        MediaUnsupportedFormat() => l10n.mediaUnsupportedFormat,
        MediaVideoTooLong(:final limitSeconds) =>
          l10n.mediaVideoTooLong(limitSeconds),
      };

  /// Whole MB when exact, else one decimal (e.g. "5", "1.5").
  static String _formatMb(int bytes) {
    final mb = bytes / (1024 * 1024);
    return mb == mb.roundToDouble()
        ? mb.toStringAsFixed(0)
        : mb.toStringAsFixed(1);
  }
}
