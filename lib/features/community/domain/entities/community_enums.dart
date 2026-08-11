/// Wire enums for the PawHub (Community) API.
///
/// The API serializes most enums as **integers** (see the API guide §9). The
/// two report enums are the exception — they travel as camelCase **strings**.
/// Each enum here carries an explicit wire mapper so the DTO layer never
/// depends on Dart's declaration order matching the server's numbering.
library;

/// Feed ordering (`FeedSort` query param). Integer wire values.
enum FeedSort { latest, trending, oldest, mostLiked }

extension FeedSortX on FeedSort {
  int get wire => switch (this) {
        FeedSort.latest => 0,
        FeedSort.trending => 1,
        FeedSort.oldest => 2,
        FeedSort.mostLiked => 3,
      };
}

/// Who can see a post (`PostVisibility`, request & response). Integer wire.
enum PostVisibility { public, followers, private }

extension PostVisibilityX on PostVisibility {
  int get wire => switch (this) {
        PostVisibility.public => 0,
        PostVisibility.followers => 1,
        PostVisibility.private => 2,
      };
}

/// Maps a server visibility int → [PostVisibility]. Unknown values fall back
/// to [PostVisibility.public] (the safest default for display — it never
/// over-exposes because the server already filtered what we can see).
PostVisibility postVisibilityFromWire(int? value) => switch (value) {
      0 => PostVisibility.public,
      1 => PostVisibility.followers,
      2 => PostVisibility.private,
      _ => PostVisibility.public,
    };

/// Search scope (`SearchType` query param). Integer wire values.
enum SearchType { all, posts, hashtags, pets }

extension SearchTypeX on SearchType {
  int get wire => switch (this) {
        SearchType.all => 0,
        SearchType.posts => 1,
        SearchType.hashtags => 2,
        SearchType.pets => 3,
      };
}

/// Notification kind (`NotificationType`, response). Integer wire values.
///
/// `mention` (4) and `alert` (6) are reserved server-side and not currently
/// emitted, but are mapped so a future server change never crashes the client.
enum NotificationType { like, comment, reply, follow, mention, tagged, alert }

/// Maps a server notification-type int → [NotificationType]. Unknown values
/// fall back to [NotificationType.alert] (rendered generically).
NotificationType notificationTypeFromWire(int? value) => switch (value) {
      0 => NotificationType.like,
      1 => NotificationType.comment,
      2 => NotificationType.reply,
      3 => NotificationType.follow,
      4 => NotificationType.mention,
      5 => NotificationType.tagged,
      6 => NotificationType.alert,
      _ => NotificationType.alert,
    };

/// Reason a post/comment/pet is reported (`ReportReason`, request).
/// **Serialized as a camelCase STRING**, not an int.
enum ReportReason {
  inappropriate,
  spam,
  harassment,
  misinformation,
  violence,
  other,
}

extension ReportReasonX on ReportReason {
  /// The camelCase wire string the API expects.
  String get wire => switch (this) {
        ReportReason.inappropriate => 'inappropriate',
        ReportReason.spam => 'spam',
        ReportReason.harassment => 'harassment',
        ReportReason.misinformation => 'misinformation',
        ReportReason.violence => 'violence',
        ReportReason.other => 'other',
      };
}

/// Lifecycle of a report (`ReportStatus`, response).
/// **Serialized as a camelCase STRING**, not an int.
enum ReportStatus { open, underReview, actionTaken, dismissed }

/// Maps a server report-status string → [ReportStatus]. Unknown/absent values
/// fall back to [ReportStatus.open].
ReportStatus reportStatusFromWire(String? value) => switch (value) {
      'open' => ReportStatus.open,
      'underReview' => ReportStatus.underReview,
      'actionTaken' => ReportStatus.actionTaken,
      'dismissed' => ReportStatus.dismissed,
      _ => ReportStatus.open,
    };
