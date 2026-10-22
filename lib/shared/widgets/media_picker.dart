import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/extensions/context_extensions.dart';
import '../../core/media/image_compressor.dart';
import '../../core/media/media_validator.dart';
import '../../core/network/dtos/media_dtos.dart';
import 'photo_source_sheet.dart';

/// A validated, compressed image ready to upload.
class PreparedImage {
  const PreparedImage({required this.file, required this.contentType});

  /// The compressed file (JPEG) to hand to [MediaUploadService.uploadFile].
  final File file;

  /// The real content type of [file] (always a web-friendly image type).
  final String contentType;
}

/// Shared pick → validate → compress flow for every single-image picker in the
/// app (avatars, adoption, lost&found, community images). Shows the standard
/// source sheet, enforces [MediaConstraints] with a localized error toast, and
/// transcodes/downscales before returning. Returns null if the user cancels or
/// the pick is rejected (the toast has already been shown in the reject case).
///
/// Pass [category] so the right size cap and downscale target are applied.
Future<PreparedImage?> pickAndPrepareImage(
  BuildContext context, {
  required MediaCategory category,
  String? title,
  String? subtitle,
}) async {
  final source = await showPhotoSourceSheet(
    context,
    title: title,
    subtitle: subtitle,
  );
  if (source == null || !context.mounted) return null;

  final picked = await ImagePicker().pickImage(
    source: source,
    // Pick at full quality; ImageCompressor is the single quality gate
    // (downscale + 82% JPEG), so a lossy pre-pass here would just double-encode.
    imageQuality: 100,
  );
  if (picked == null || !context.mounted) return null;

  final original = File(picked.path);

  // Validate the raw pick first - rejects oversized originals and unsupported
  // formats with a localized toast before we spend time compressing.
  final validation = MediaValidator.validateImage(original, category);
  if (validation is! MediaValid) {
    context.showErrorSnackBar(validation.localizedMessage(context.l10n));
    return null;
  }

  // Compress (also transcodes HEIC → JPEG). Falls back to the original on
  // failure; the upload-service guard still enforces the hard cap.
  final compressed = await ImageCompressor.compress(original, category);

  // Re-detect the output type (compression yields JPEG) so the upload sends an
  // honest content type to the signed R2 PUT.
  final contentType =
      MediaValidator.detectImageMime(compressed) ?? 'image/jpeg';

  return PreparedImage(file: compressed, contentType: contentType);
}
