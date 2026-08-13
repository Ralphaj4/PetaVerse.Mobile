import 'community_enums.dart';
import 'community_group_entities.dart';

/// Domain entities for PawHub (Community). Pure Dart — no Flutter, no JSON.
///
/// These mirror the API's response shapes (guide §11) but are the app's own
/// vocabulary: DTOs map onto these in the data layer, and the UI only ever
/// sees these. Ids are ints (the API uses int ids throughout).

/// A pet's public identity card (`PetSummaryResponse`). The social actor —
/// posts, comments, follows and notifications are all attributed to one of
/// these, never to a user account.
class CommunityPet {
  const CommunityPet({
    required this.id,
    required this.name,
    this.breed,
    this.species,
    this.avatarUrl,
    this.bio,
    this.ownerName,
    this.isVerified = false,
    this.followers = 0,
    this.isFollowing = false,
    this.isMine = false,
  });

  final int id;
  final String name;
  final String? breed;
  final String? species;
  final String? avatarUrl;
  final String? bio;
  final String? ownerName;
  final bool isVerified;
  final int followers;

  /// Whether the *acting* pet follows this pet.
  final bool isFollowing;

  /// Whether this pet belongs to the signed-in user (can be acted as). Not on
  /// the wire — derived client-side by comparing against the user's pets.
  final bool isMine;

  /// Breed if present, otherwise species (for the subtitle line).
  String get breedOrSpecies => (breed?.isNotEmpty ?? false) ? breed! : (species ?? '');

  CommunityPet copyWith({
    int? followers,
    bool? isFollowing,
    bool? isMine,
  }) =>
      CommunityPet(
        id: id,
        name: name,
        breed: breed,
        species: species,
        avatarUrl: avatarUrl,
        bio: bio,
        ownerName: ownerName,
        isVerified: isVerified,
        followers: followers ?? this.followers,
        isFollowing: isFollowing ?? this.isFollowing,
        isMine: isMine ?? this.isMine,
      );
}

/// One media item on a post (`PostResponse.media[]`).
class PostMedia {
  const PostMedia({
    required this.url,
    this.isVideo = false,
    this.durationSeconds,
    this.altText,
    this.thumbnailUrl,
  });

  final String url;
  final bool isVideo;
  final int? durationSeconds;
  final String? altText;

  /// Server-generated poster image for a video (null for images / until the
  /// backend provides it). Shown in the feed and behind the player.
  final String? thumbnailUrl;

  /// `0:42`-style label from [durationSeconds], or null for images.
  String? get durationLabel {
    final s = durationSeconds;
    if (s == null) return null;
    final m = s ~/ 60;
    final rem = (s % 60).toString().padLeft(2, '0');
    return '$m:$rem';
  }
}

/// A feed post (`PostResponse`).
class Post {
  const Post({
    required this.id,
    required this.author,
    required this.media,
    required this.hashtags,
    required this.taggedPets,
    required this.likes,
    required this.comments,
    required this.likedByMe,
    required this.saved,
    required this.isEdited,
    required this.createdAt,
    this.caption,
    this.locationName,
    this.visibility = PostVisibility.public,
    this.timeAgo,
    this.communityId,
    this.communityName,
  });

  final int id;
  final CommunityPet author;
  final List<PostMedia> media;
  final String? caption;
  final String? locationName;
  final PostVisibility visibility;
  final List<String> hashtags;

  /// Pets tagged in this post (full objects: id/name/avatar/breed).
  final List<CommunityPet> taggedPets;
  final int likes;
  final int comments;
  final bool likedByMe;
  final bool saved;
  final bool isEdited;
  final DateTime createdAt;

  /// The community this post belongs to, or null for a personal post.
  final int? communityId;

  /// Denormalized community name for the card badge (server-provided).
  final String? communityName;

  /// Server-rendered relative time (`"35m"`). Prefer it over computing locally.
  final String? timeAgo;

  bool get hasMedia => media.isNotEmpty;

  /// Optimistic copy used by like/save toggles before the server confirms.
  Post copyWith({
    int? likes,
    int? comments,
    bool? likedByMe,
    bool? saved,
    bool? isEdited,
    String? caption,
    PostVisibility? visibility,
    List<String>? hashtags,
    List<CommunityPet>? taggedPets,
  }) =>
      Post(
        id: id,
        author: author,
        media: media,
        hashtags: hashtags ?? this.hashtags,
        taggedPets: taggedPets ?? this.taggedPets,
        likes: likes ?? this.likes,
        comments: comments ?? this.comments,
        likedByMe: likedByMe ?? this.likedByMe,
        saved: saved ?? this.saved,
        isEdited: isEdited ?? this.isEdited,
        createdAt: createdAt,
        caption: caption ?? this.caption,
        locationName: locationName,
        visibility: visibility ?? this.visibility,
        timeAgo: timeAgo,
        communityId: communityId,
        communityName: communityName,
      );
}

/// A comment or reply (`CommentResponse`). Threading is one level deep —
/// [replies] is only populated on top-level comments.
class Comment {
  const Comment({
    required this.id,
    required this.postId,
    required this.author,
    required this.body,
    required this.likes,
    required this.likedByMe,
    required this.isPinned,
    required this.createdAt,
    this.parentCommentId,
    this.replies = const [],
    this.timeAgo,
  });

  final int id;
  final int postId;
  final CommunityPet author;
  final int? parentCommentId;
  final String body;
  final int likes;
  final bool likedByMe;
  final bool isPinned;
  final List<Comment> replies;
  final DateTime createdAt;
  final String? timeAgo;

  bool get isReply => parentCommentId != null;

  Comment copyWith({
    String? body,
    int? likes,
    bool? likedByMe,
    bool? isPinned,
    List<Comment>? replies,
  }) =>
      Comment(
        id: id,
        postId: postId,
        author: author,
        body: body ?? this.body,
        likes: likes ?? this.likes,
        likedByMe: likedByMe ?? this.likedByMe,
        isPinned: isPinned ?? this.isPinned,
        createdAt: createdAt,
        parentCommentId: parentCommentId,
        replies: replies ?? this.replies,
        timeAgo: timeAgo,
      );
}

/// A community notification row (`NotificationResponse`). [text] is
/// server-rendered and already localized; the client only formats time.
class CommunityNotification {
  const CommunityNotification({
    required this.id,
    required this.type,
    required this.text,
    required this.isRead,
    required this.createdAt,
    this.actor,
    this.thumbnailUrl,
    this.actionUrl,
    this.timeAgo,
  });

  final int id;
  final NotificationType type;
  final CommunityPet? actor;
  final String text;
  final String? thumbnailUrl;

  /// Where tapping should navigate (`"/posts/1"`, `"/pets/2"`).
  final String? actionUrl;
  final bool isRead;
  final DateTime createdAt;
  final String? timeAgo;

  CommunityNotification copyWith({bool? isRead}) => CommunityNotification(
        id: id,
        type: type,
        text: text,
        isRead: isRead ?? this.isRead,
        createdAt: createdAt,
        actor: actor,
        thumbnailUrl: thumbnailUrl,
        actionUrl: actionUrl,
        timeAgo: timeAgo,
      );
}

/// A lost & found alert injected into the Discover feed
/// (`LostFoundAlertResponse`).
class LostFoundAlert {
  const LostFoundAlert({
    required this.id,
    required this.petName,
    required this.breed,
    required this.imageUrl,
    required this.createdAt,
    this.distanceLabel,
    this.reward,
    this.timeAgo,
  });

  final int id;
  final String petName;
  final String breed;
  final String imageUrl;

  /// `"1.2 km away"`, or null if the viewer has no saved location.
  final String? distanceLabel;
  final int? reward;
  final DateTime createdAt;
  final String? timeAgo;
}

/// A trending hashtag (`TrendingResponse.trendingHashtags[]` and search hits).
class TrendingHashtag {
  const TrendingHashtag({required this.tag, required this.postCount});

  final String tag;
  final int postCount;
}

/// The kind of hit in a mixed search page (`SearchResultResponse.type`).
enum SearchResultKind { post, hashtag, pet }

/// One row of a mixed search response (`SearchResultResponse`). Exactly one of
/// [post] / [hashtag] / [pet] is populated per [kind].
class SearchResult {
  const SearchResult({
    required this.kind,
    this.post,
    this.hashtag,
    this.pet,
  });

  final SearchResultKind kind;
  final Post? post;
  final TrendingHashtag? hashtag;
  final CommunityPet? pet;
}

// ── Paged wrappers ─────────────────────────────────────────────────────────

/// Common paging cursor. [nextPage] is null when there is nothing more.
class PageCursor {
  const PageCursor({required this.hasMore, this.nextPage});

  final bool hasMore;
  final int? nextPage;

  static const empty = PageCursor(hasMore: false, nextPage: null);
}

/// A page of posts (`FeedResponse`).
class FeedPage {
  const FeedPage({required this.posts, required this.cursor, this.postCount});

  final List<Post> posts;
  final PageCursor cursor;
  final int? postCount;
}

/// A page of the Discover feed (`DiscoverFeedResponse`) — posts plus the
/// suggested-pets rail, suggested-communities rail, and lost & found alerts.
class DiscoverPage {
  const DiscoverPage({
    required this.posts,
    required this.suggestedPets,
    required this.suggestedCommunities,
    required this.alerts,
    required this.cursor,
  });

  final List<Post> posts;
  final List<CommunityPet> suggestedPets;
  final List<CommunityGroup> suggestedCommunities;
  final List<LostFoundAlert> alerts;
  final PageCursor cursor;
}

/// A post with its full comment thread (`PostDetailResponse`).
class PostDetail {
  const PostDetail({required this.post, required this.comments});

  final Post post;
  final List<Comment> comments;
}

/// A page of comments (`CommentsResponse`).
class CommentPage {
  const CommentPage({required this.comments, required this.cursor});

  final List<Comment> comments;
  final PageCursor cursor;
}

/// A page of pets with a total count (`FollowersResponse` / `FollowingResponse`
/// / `BlockedPetsResponse`).
class PetPage {
  const PetPage({required this.pets, required this.count, required this.cursor});

  final List<CommunityPet> pets;
  final int count;
  final PageCursor cursor;
}

/// A page of notifications (`NotificationsResponse`). [unreadCount] is the bell
/// badge — the full unread total, unaffected by paging.
class NotificationPage {
  const NotificationPage({
    required this.notifications,
    required this.unreadCount,
    required this.cursor,
  });

  final List<CommunityNotification> notifications;
  final int unreadCount;
  final PageCursor cursor;
}

/// A hashtag feed (`HashtagFeedResponse`).
class HashtagFeed {
  const HashtagFeed({
    required this.hashtag,
    required this.postCount,
    required this.posts,
    required this.cursor,
  });

  final String hashtag;
  final int postCount;
  final List<Post> posts;
  final PageCursor cursor;
}

/// A page of mixed search results (`SearchResponse`).
class SearchResultsPage {
  const SearchResultsPage({required this.results, required this.cursor});

  final List<SearchResult> results;
  final PageCursor cursor;
}

/// Trending content (`TrendingResponse`).
class Trending {
  const Trending({required this.hashtags, required this.posts});

  final List<TrendingHashtag> hashtags;
  final List<Post> posts;
}

// ── Small action results ───────────────────────────────────────────────────

/// Result of following/unfollowing (`FollowResponse`).
class FollowResult {
  const FollowResult({
    required this.petId,
    required this.followers,
    required this.isFollowing,
  });

  final int petId;
  final int followers;
  final bool isFollowing;
}

/// Result of saving/unsaving (`SaveResponse`).
class SaveResult {
  const SaveResult({
    required this.postId,
    required this.saved,
    required this.saveCount,
  });

  final int postId;
  final bool saved;
  final int saveCount;
}

/// Result of sharing (`SharePostResponse`) — the deep link to copy.
class ShareResult {
  const ShareResult({required this.postId, required this.shareUrl});

  final int postId;
  final String shareUrl;
}

/// Result of blocking/unblocking (`BlockResponse`).
class BlockResult {
  const BlockResult({required this.petId, required this.blocked});

  final int petId;
  final bool blocked;
}

/// Result of filing a report (`ReportResponse`).
class ReportResult {
  const ReportResult({required this.reportId, required this.status});

  final int reportId;
  final ReportStatus status;
}

/// Result of marking notifications read (`MarkNotificationReadResponse` /
/// `MarkAllReadResponse`). [unreadCount] is the fresh bell badge.
class MarkReadResult {
  const MarkReadResult({required this.unreadCount, this.marked});

  /// Number marked in a mark-all-read, or null for a single mark.
  final int? marked;
  final int unreadCount;
}
