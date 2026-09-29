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

/// How a pet is feeling in a post (`PostFeeling`, request & response). Integer
/// wire values 1–10 — there is no 0, since a post with no feeling sends/receives
/// null. Icon + display are mapped in the presentation layer (this layer is
/// pure Dart, no Flutter), keyed off this enum.
enum PostFeeling {
  happy,
  relaxed,
  naughty,
  excited,
  anxious,
  playful,
  tired,
  silly,
  loved,
  grumpy,
}

extension PostFeelingX on PostFeeling {
  int get wire => switch (this) {
        PostFeeling.happy => 1,
        PostFeeling.relaxed => 2,
        PostFeeling.naughty => 3,
        PostFeeling.excited => 4,
        PostFeeling.anxious => 5,
        PostFeeling.playful => 6,
        PostFeeling.tired => 7,
        PostFeeling.silly => 8,
        PostFeeling.loved => 9,
        PostFeeling.grumpy => 10,
      };
}

/// Maps a server feeling int → [PostFeeling], or null for absent/out-of-range
/// (a post with no feeling). Never throws — an unknown value is treated as no
/// feeling so a future server addition can't crash the client.
PostFeeling? postFeelingFromWire(int? value) => switch (value) {
      1 => PostFeeling.happy,
      2 => PostFeeling.relaxed,
      3 => PostFeeling.naughty,
      4 => PostFeeling.excited,
      5 => PostFeeling.anxious,
      6 => PostFeeling.playful,
      7 => PostFeeling.tired,
      8 => PostFeeling.silly,
      9 => PostFeeling.loved,
      10 => PostFeeling.grumpy,
      _ => null,
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
