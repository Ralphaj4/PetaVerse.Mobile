import '../../domain/entities/community_entities.dart' as domain;
import '../../domain/entities/community_enums.dart' as domain_enums;

/// Post visibility. Public = everyone, followers = only followers, private =
/// only the owner's account.
enum PostVisibility { public, followers, private }

extension PostVisibilityX on PostVisibility {
  String get label => switch (this) {
        PostVisibility.public => 'Public',
        PostVisibility.followers => 'Followers',
        PostVisibility.private => 'Only me',
      };

  domain_enums.PostVisibility get toDomain => switch (this) {
        PostVisibility.public => domain_enums.PostVisibility.public,
        PostVisibility.followers => domain_enums.PostVisibility.followers,
        PostVisibility.private => domain_enums.PostVisibility.private,
      };
}

/// A pet persona â€” the social identity that authors posts. Maps onto
/// [domain.CommunityPet] via [fromEntity].
class PawPet {
  PawPet({
    required this.id,
    required this.name,
    required this.breed,
    required this.species,
    required this.avatarUrl,
    required this.ownerName,
    this.bio = '',
    this.isMine = false,
    this.isFollowing = false,
    this.isVerified = false,
    this.followers = 0,
    this.backendId = 0,
  });

  /// Creates a [PawPet] from the domain entity, preserving all display fields.
  factory PawPet.fromEntity(domain.CommunityPet e) => PawPet(
        id: e.id.toString(),
        backendId: e.id,
        name: e.name,
        breed: e.breed ?? '',
        species: e.species ?? '',
        avatarUrl: e.avatarUrl,
        ownerName: e.ownerName ?? '',
        bio: e.bio ?? '',
        isMine: e.isMine,
        isFollowing: e.isFollowing,
        isVerified: e.isVerified,
        followers: e.followers,
      );

  /// Stable string id for widget keys / local maps (prototype compat).
  final String id;

  /// The real backend integer id â€” used for API calls.
  final int backendId;

  final String name;
  final String breed;
  final String species;
  final String? avatarUrl;
  final String ownerName;
  final String bio;

  /// True when this pet belongs to the signed-in account (can post as it).
  final bool isMine;
  bool isFollowing;
  final bool isVerified;
  int followers;

  String get breedOrSpecies => breed.isNotEmpty ? breed : species;
}

/// A single media item on a post. [isVideo] toggles the video affordances
/// (play glyph, duration badge) â€” playback itself is stubbed in the prototype.
class PawMedia {
  const PawMedia({
    required this.url,
    this.isVideo = false,
    this.durationLabel,
    this.durationSeconds,
    this.altText = '',
    this.thumbnailUrl,
    this.localCoverPath,
  });

  factory PawMedia.fromEntity(domain.PostMedia e) => PawMedia(
        url: e.url,
        isVideo: e.isVideo,
        durationLabel: e.durationLabel,
        durationSeconds: e.durationSeconds,
        altText: e.altText ?? '',
        thumbnailUrl: e.thumbnailUrl,
      );

  final String url;
  final bool isVideo;
  final String? durationLabel;

  /// Video length in whole seconds. Required by the backend for video media;
  /// null for images.
  final int? durationSeconds;
  final String altText;

  /// Server-generated video poster (null for images / until backend provides).
  final String? thumbnailUrl;

  /// Composer-only: local file path of a user-picked cover image for a video,
  /// uploaded as the thumbnail asset on publish. Null when none chosen.
  final String? localCoverPath;

  PawMedia copyWith({String? localCoverPath}) => PawMedia(
        url: url,
        isVideo: isVideo,
        durationLabel: durationLabel,
        durationSeconds: durationSeconds,
        altText: altText,
        thumbnailUrl: thumbnailUrl,
        localCoverPath: localCoverPath ?? this.localCoverPath,
      );
}

/// A comment or a reply (one level of nesting via [replies]).
class PawComment {
  PawComment({
    required this.id,
    required this.author,
    required this.body,
    required this.timeAgo,
    this.likes = 0,
    this.likedByMe = false,
    this.isPinned = false,
    this.backendId = 0,
    List<PawComment>? replies,
  }) : replies = replies ?? [];

  factory PawComment.fromEntity(domain.Comment e) => PawComment(
        id: e.id.toString(),
        backendId: e.id,
        author: PawPet.fromEntity(e.author),
        body: e.body,
        timeAgo: e.timeAgo ?? '',
        likes: e.likes,
        likedByMe: e.likedByMe,
        isPinned: e.isPinned,
        replies: e.replies.map(PawComment.fromEntity).toList(),
      );

  final String id;

  /// Real backend integer id for API calls (like/pin/delete).
  final int backendId;

  final PawPet author;
  String body;
  final String timeAgo;
  int likes;
  bool likedByMe;
  bool isPinned;
  final List<PawComment> replies;
}

/// A feed post authored by a pet.
class PawPost {
  PawPost({
    required this.id,
    required this.author,
    required this.media,
    required this.caption,
    required this.timeAgo,
    required this.hashtags,
    required this.taggedPets,
    this.locationName,
    this.visibility = PostVisibility.public,
    this.likes = 0,
    this.likedByMe = false,
    this.saved = false,
    this.isEdited = false,
    this.backendId = 0,
    this.commentCount = 0,
    this.communityId,
    this.communityName,
    List<PawComment>? comments,
  }) : comments = comments ?? [];

  /// Maps a domain [domain.Post] to a [PawPost] view-model. Comment bodies are
  /// not loaded here (they come from the comments sheet); only the count is set.
  factory PawPost.fromEntity(domain.Post e) => PawPost(
        id: e.id.toString(),
        backendId: e.id,
        author: PawPet.fromEntity(e.author),
        media: e.media.map(PawMedia.fromEntity).toList(),
        caption: e.caption ?? '',
        timeAgo: e.timeAgo ?? '',
        hashtags: e.hashtags,
        taggedPets: e.taggedPets.map(PawPet.fromEntity).toList(),
        locationName: e.locationName,
        visibility: _domainVisibility(e.visibility),
        likes: e.likes,
        likedByMe: e.likedByMe,
        saved: e.saved,
        isEdited: e.isEdited,
        commentCount: e.comments,
        communityId: e.communityId,
        communityName: e.communityName,
      );

  static PostVisibility _domainVisibility(domain_enums.PostVisibility v) =>
      switch (v) {
        domain_enums.PostVisibility.public => PostVisibility.public,
        domain_enums.PostVisibility.followers => PostVisibility.followers,
        domain_enums.PostVisibility.private => PostVisibility.private,
      };

  final String id;

  /// Real backend integer id for API calls (like/save/share/delete/edit).
  final int backendId;

  final PawPet author;
  final List<PawMedia> media;
  String caption;
  final String timeAgo;
  final List<String> hashtags;
  final List<PawPet> taggedPets;
  final String? locationName;
  PostVisibility visibility;
  int likes;
  bool likedByMe;
  bool saved;
  bool isEdited;
  final List<PawComment> comments;

  /// Server-provided comment count (use this for the badge; [comments] is only
  /// populated when the sheet is open).
  final int commentCount;

  /// Community this post belongs to, or null for a personal post.
  final int? communityId;
  final String? communityName;

  int get totalCommentCount => commentCount > 0
      ? commentCount
      : comments.length + comments.fold(0, (n, c) => n + c.replies.length);
}

/// A Lost & Found alert surfaced as a feed injection (safety-first ranking).
class PawAlert {
  const PawAlert({
    required this.petName,
    required this.breed,
    required this.distanceLabel,
    required this.timeAgo,
    required this.imageUrl,
    this.reward,
  });

  final String petName;
  final String breed;
  final String distanceLabel;
  final String timeAgo;
  final String imageUrl;
  final int? reward;
}

/// A grouped notification row.
enum PawNotifType { like, comment, reply, follow, mention, tagged, alert }

class PawNotif {
  PawNotif({
    required this.id,
    required this.type,
    required this.actor,
    required this.text,
    required this.timeAgo,
    this.thumbnailUrl,
    this.isRead = false,
  });

  final int id;
  final PawNotifType type;
  final PawPet actor;
  final String text;
  final String timeAgo;
  final String? thumbnailUrl;
  bool isRead;
}
