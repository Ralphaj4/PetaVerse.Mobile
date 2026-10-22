import '../network/dtos/media_dtos.dart';

/// Single source of truth for client-side media limits and allowed formats.
///
/// IMPORTANT: these caps are a UX guard, not a security boundary. A client with
/// a signed R2 URL can bypass the app entirely, so the backend MUST mirror
/// these limits at `/media/upload-url` (reject oversized/disallowed before
/// issuing a URL), sign the presigned PUT with a `Content-Length`/`Content-Type`
/// condition, and re-check the stored object size at `/confirm`. See
/// docs/backend-media-validation-guide.md. Keep the numbers below in lockstep
/// with the backend's configured values.
class MediaConstraints {
  const MediaConstraints._();

  static const int _mb = 1024 * 1024;

  // ── Per-category size caps (bytes) ────────────────────────────────────────
  static const int avatarMaxBytes = 5 * _mb; // user / pet / community avatars
  static const int communityBannerMaxBytes = 8 * _mb;
  static const int imageMaxBytes = 15 * _mb; // post / adoption / pet report
  static const int videoMaxBytes = 100 * _mb;

  // ── Video duration ────────────────────────────────────────────────────────
  static const int videoMaxDurationSeconds = 60;

  // ── Image compression targets ─────────────────────────────────────────────
  /// Longest-edge target for feed/report/adoption photos.
  static const int imageMaxDimension = 1920;

  /// Longest-edge target for avatars and banners (shown small).
  static const int avatarMaxDimension = 1080;

  /// JPEG quality used when re-encoding after downscale.
  static const int jpegQuality = 82;

  // ── Allowed formats ───────────────────────────────────────────────────────
  /// Image extensions accepted at pick time. HEIC/HEIF are accepted here and
  /// transcoded to JPEG before upload (see [ImageCompressor]).
  static const Set<String> allowedImageExtensions = {
    'jpg',
    'jpeg',
    'png',
    'webp',
    'heic',
    'heif',
  };

  static const Set<String> allowedImageMimeTypes = {
    'image/jpeg',
    'image/png',
    'image/webp',
    'image/heic',
    'image/heif',
  };

  /// Video extensions accepted for posts. `.mov` (quicktime) is the iPhone
  /// default so it must be allowed; non-web-playable containers are excluded.
  static const Set<String> allowedVideoExtensions = {
    'mp4',
    'mov',
    'm4v',
    'webm',
  };

  static const Set<String> allowedVideoMimeTypes = {
    'video/mp4',
    'video/quicktime',
    'video/webm',
  };

  /// Whether [category] carries video (only post media can be a video; the
  /// caller still distinguishes image vs video per-file).
  static bool isVideoCapable(MediaCategory category) =>
      category == MediaCategory.post || category == MediaCategory.story;

  /// Max bytes allowed for an image in [category].
  static int imageMaxBytesFor(MediaCategory category) {
    switch (category) {
      case MediaCategory.userAvatar:
      case MediaCategory.petAvatar:
      case MediaCategory.communityAvatar:
        return avatarMaxBytes;
      case MediaCategory.communityBanner:
        return communityBannerMaxBytes;
      case MediaCategory.post:
      case MediaCategory.story:
      case MediaCategory.petDocument:
      case MediaCategory.petReport:
      case MediaCategory.adoptionListingPhoto:
        return imageMaxBytes;
    }
  }

  /// Longest-edge downscale target for an image in [category].
  static int maxDimensionFor(MediaCategory category) {
    switch (category) {
      case MediaCategory.userAvatar:
      case MediaCategory.petAvatar:
      case MediaCategory.communityAvatar:
      case MediaCategory.communityBanner:
        return avatarMaxDimension;
      case MediaCategory.post:
      case MediaCategory.story:
      case MediaCategory.petDocument:
      case MediaCategory.petReport:
      case MediaCategory.adoptionListingPhoto:
        return imageMaxDimension;
    }
  }
}
