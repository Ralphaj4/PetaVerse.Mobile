import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/community_entities.dart';
import '../../domain/entities/community_enums.dart';
import 'community_group_dtos.dart';

part 'community_dtos.freezed.dart';
part 'community_dtos.g.dart';

/// Wire shapes for the PawHub (Community) API (guide §11). Every DTO exposes a
/// `toEntity()` that maps onto the pure-Dart domain entities. Enums arrive as
/// ints (or camelCase strings for reports) and are converted via the domain
/// mappers, so declaration order here never has to match the server.

/// `PetSummaryResponse`.
@freezed
abstract class PetSummaryDto with _$PetSummaryDto {
  const factory PetSummaryDto({
    required int id,
    @Default('') String name,
    String? breed,
    String? species,
    String? avatarUrl,
    String? bio,
    String? ownerName,
    @Default(false) bool isVerified,
    @Default(0) int followers,
    @Default(false) bool isFollowing,
  }) = _PetSummaryDto;

  const PetSummaryDto._();

  factory PetSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$PetSummaryDtoFromJson(json);

  /// [mine] is derived client-side (the wire has no `isMine`).
  CommunityPet toEntity({bool mine = false}) => CommunityPet(
        id: id,
        name: name,
        breed: breed,
        species: species,
        avatarUrl: avatarUrl,
        bio: bio,
        ownerName: ownerName,
        isVerified: isVerified,
        followers: followers,
        isFollowing: isFollowing,
        isMine: mine,
      );
}

/// One media item in `PostResponse.media[]`.
@freezed
abstract class PostMediaDto with _$PostMediaDto {
  const factory PostMediaDto({
    @Default('') String url,
    @Default(false) bool isVideo,
    int? durationSeconds,
    String? altText,
    String? thumbnailUrl,
  }) = _PostMediaDto;

  const PostMediaDto._();

  factory PostMediaDto.fromJson(Map<String, dynamic> json) =>
      _$PostMediaDtoFromJson(json);

  PostMedia toEntity() => PostMedia(
        url: url,
        isVideo: isVideo,
        durationSeconds: durationSeconds,
        altText: altText,
        thumbnailUrl: thumbnailUrl,
      );
}

/// `PostFeeling` as it appears nested in `PostResponse.feeling` - `{ value,
/// name }`. Also the row shape of the feelings-list endpoint. `name` is the
/// server's human label; the client keys its icon off [value] via
/// [postFeelingFromWire].
@freezed
abstract class PostFeelingDto with _$PostFeelingDto {
  const factory PostFeelingDto({
    @Default(0) int value,
    @Default('') String name,
  }) = _PostFeelingDto;

  const PostFeelingDto._();

  factory PostFeelingDto.fromJson(Map<String, dynamic> json) =>
      _$PostFeelingDtoFromJson(json);

  /// The domain enum, or null if [value] isn't a known feeling.
  PostFeeling? toEntity() => postFeelingFromWire(value);
}

/// `PageAuthorResponse` — a page (shelter/rescue/vet/brand) that authored a
/// post. Exactly one of [PostDto.author] / [PostDto.pageAuthor] is non-null.
@freezed
abstract class PageAuthorDto with _$PageAuthorDto {
  const factory PageAuthorDto({
    required int id,
    @Default('') String name,
    @Default('') String handle,
    String? avatarUrl,
    String? category,
    @Default(false) bool isVerified,
    @Default(0) int followerCount,
    @Default(false) bool isFollowing,
  }) = _PageAuthorDto;

  const PageAuthorDto._();

  factory PageAuthorDto.fromJson(Map<String, dynamic> json) =>
      _$PageAuthorDtoFromJson(json);

  PageAuthor toEntity() => PageAuthor(
        id: id,
        name: name,
        handle: handle,
        avatarUrl: avatarUrl,
        category: pageCategoryFromWire(category),
        isVerified: isVerified,
        followerCount: followerCount,
        isFollowing: isFollowing,
      );
}

/// Adoption listing stub embedded in a page post (`PostResponse.adoptionListing`).
/// Null on all regular posts; only set on page posts linked to a listing.
@freezed
abstract class PostAdoptionListingDto with _$PostAdoptionListingDto {
  const factory PostAdoptionListingDto({
    required int id,
    @Default(0) int statusId,
    @Default('') String petName,
    @Default('') String speciesName,
    String? photoUrl,
    String? locationLabel,
    @Default(false) bool vaccinated,
    @Default(false) bool neutered,
    @Default(false) bool goodWithKids,
  }) = _PostAdoptionListingDto;

  const PostAdoptionListingDto._();

  factory PostAdoptionListingDto.fromJson(Map<String, dynamic> json) =>
      _$PostAdoptionListingDtoFromJson(json);

  PostAdoptionListing toEntity() => PostAdoptionListing(
        id: id,
        statusId: statusId,
        petName: petName,
        speciesName: speciesName,
        photoUrl: photoUrl,
        locationLabel: locationLabel,
        vaccinated: vaccinated,
        neutered: neutered,
        goodWithKids: goodWithKids,
      );
}

/// `PostResponse`.
@freezed
abstract class PostDto with _$PostDto {
  const factory PostDto({
    required int id,
    // Exactly one of author / pageAuthor is non-null per the API contract.
    PetSummaryDto? author,
    PageAuthorDto? pageAuthor,
    @Default(<PostMediaDto>[]) List<PostMediaDto> media,
    String? caption,
    String? locationName,
    String? visibility,
    @Default(<String>[]) List<String> hashtags,
    // Tagged pets now arrive as full pet objects (id/name/avatarUrl/breed),
    // not bare ids.
    @Default(<PetSummaryDto>[]) List<PetSummaryDto> taggedPets,
    @Default(0) int likes,
    @Default(0) int comments,
    @Default(0) int shares,
    @Default(false) bool likedByMe,
    @Default(false) bool saved,
    @Default(false) bool isEdited,
    PostFeelingDto? feeling,
    @Default(<int>[]) List<int> followedByMyPetIds,
    DateTime? createdAt,
    String? timeAgo,
    int? communityId,
    String? communityName,
    PostAdoptionListingDto? adoptionListing,
  }) = _PostDto;

  const PostDto._();

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);

  Post toEntity({Set<int> myPetIds = const {}}) => Post(
        id: id,
        author: author?.toEntity(mine: myPetIds.contains(author!.id)),
        pageAuthor: pageAuthor?.toEntity(),
        media: media.map((m) => m.toEntity()).toList(growable: false),
        hashtags: hashtags,
        taggedPets: taggedPets
            .map((p) => p.toEntity(mine: myPetIds.contains(p.id)))
            .toList(growable: false),
        likes: likes,
        comments: comments,
        shares: shares,
        likedByMe: likedByMe,
        saved: saved,
        isEdited: isEdited,
        createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
        caption: caption,
        locationName: locationName,
        visibility: postVisibilityFromWire(visibility),
        feeling: feeling?.toEntity(),
        followedByMyPetIds: followedByMyPetIds,
        timeAgo: timeAgo,
        communityId: communityId,
        communityName: communityName,
        adoptionListing: adoptionListing?.toEntity(),
      );
}

/// `CommentResponse`.
@freezed
abstract class CommentDto with _$CommentDto {
  const factory CommentDto({
    required int id,
    @Default(0) int postId,
    required PetSummaryDto author,
    int? parentCommentId,
    @Default('') String body,
    @Default(0) int likes,
    @Default(false) bool likedByMe,
    @Default(false) bool isPinned,
    @Default(<CommentDto>[]) List<CommentDto> replies,
    DateTime? createdAt,
    String? timeAgo,
  }) = _CommentDto;

  const CommentDto._();

  factory CommentDto.fromJson(Map<String, dynamic> json) =>
      _$CommentDtoFromJson(json);

  Comment toEntity({Set<int> myPetIds = const {}}) => Comment(
        id: id,
        postId: postId,
        author: author.toEntity(mine: myPetIds.contains(author.id)),
        body: body,
        likes: likes,
        likedByMe: likedByMe,
        isPinned: isPinned,
        createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
        parentCommentId: parentCommentId,
        replies:
            replies.map((r) => r.toEntity(myPetIds: myPetIds)).toList(growable: false),
        timeAgo: timeAgo,
      );
}

/// `PostDetailResponse`.
@freezed
abstract class PostDetailDto with _$PostDetailDto {
  const factory PostDetailDto({
    required PostDto post,
    @Default(<CommentDto>[]) List<CommentDto> comments,
  }) = _PostDetailDto;

  const PostDetailDto._();

  factory PostDetailDto.fromJson(Map<String, dynamic> json) =>
      _$PostDetailDtoFromJson(json);

  PostDetail toEntity({Set<int> myPetIds = const {}}) => PostDetail(
        post: post.toEntity(myPetIds: myPetIds),
        comments: comments
            .map((c) => c.toEntity(myPetIds: myPetIds))
            .toList(growable: false),
      );
}

/// `LostFoundAlertResponse` (Discover feed).
@freezed
abstract class LostFoundAlertDto with _$LostFoundAlertDto {
  const factory LostFoundAlertDto({
    required int id,
    @Default('') String petName,
    @Default('') String breed,
    String? distanceLabel,
    @Default('') String imageUrl,
    int? reward,
    DateTime? createdAt,
    String? timeAgo,
  }) = _LostFoundAlertDto;

  const LostFoundAlertDto._();

  factory LostFoundAlertDto.fromJson(Map<String, dynamic> json) =>
      _$LostFoundAlertDtoFromJson(json);

  LostFoundAlert toEntity() => LostFoundAlert(
        id: id,
        petName: petName,
        breed: breed,
        imageUrl: imageUrl,
        createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
        distanceLabel: distanceLabel,
        reward: reward,
        timeAgo: timeAgo,
      );
}

/// `NotificationResponse`.
@freezed
abstract class NotificationDto with _$NotificationDto {
  const factory NotificationDto({
    required int id,
    @Default(0) int type,
    PetSummaryDto? actor,
    @Default('') String text,
    String? thumbnailUrl,
    String? actionUrl,
    @Default(false) bool isRead,
    DateTime? createdAt,
    String? timeAgo,
  }) = _NotificationDto;

  const NotificationDto._();

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);

  CommunityNotification toEntity() => CommunityNotification(
        id: id,
        type: notificationTypeFromWire(type),
        text: text,
        isRead: isRead,
        createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
        actor: actor?.toEntity(),
        thumbnailUrl: thumbnailUrl,
        actionUrl: actionUrl,
        timeAgo: timeAgo,
      );
}

/// `SearchResultResponse` - one row of a mixed search page.
@freezed
abstract class SearchResultDto with _$SearchResultDto {
  const factory SearchResultDto({
    @Default('post') String type,
    PostDto? post,
    String? hashtag,
    int? postCount,
    PetSummaryDto? pet,
    PageAuthorDto? page,
  }) = _SearchResultDto;

  const SearchResultDto._();

  factory SearchResultDto.fromJson(Map<String, dynamic> json) =>
      _$SearchResultDtoFromJson(json);

  SearchResult toEntity({Set<int> myPetIds = const {}}) {
    final kind = switch (type) {
      'hashtag' => SearchResultKind.hashtag,
      'pet' => SearchResultKind.pet,
      'page' => SearchResultKind.page,
      _ => SearchResultKind.post,
    };
    return SearchResult(
      kind: kind,
      post: post?.toEntity(myPetIds: myPetIds),
      hashtag: hashtag == null
          ? null
          : TrendingHashtag(tag: hashtag!, postCount: postCount ?? 0),
      pet: pet?.toEntity(mine: pet == null ? false : myPetIds.contains(pet!.id)),
      page: page?.toEntity(),
    );
  }
}

/// `TrendingResponse.trendingHashtags[]`.
@freezed
abstract class TrendingHashtagDto with _$TrendingHashtagDto {
  const factory TrendingHashtagDto({
    @Default('') String tag,
    @Default(0) int postCount,
  }) = _TrendingHashtagDto;

  const TrendingHashtagDto._();

  factory TrendingHashtagDto.fromJson(Map<String, dynamic> json) =>
      _$TrendingHashtagDtoFromJson(json);

  TrendingHashtag toEntity() => TrendingHashtag(tag: tag, postCount: postCount);
}

// ── Paged wrappers ─────────────────────────────────────────────────────────

/// `FeedResponse`.
@freezed
abstract class FeedResponseDto with _$FeedResponseDto {
  const factory FeedResponseDto({
    @Default(<PostDto>[]) List<PostDto> posts,
    @Default(false) bool hasMore,
    String? nextCursor,
  }) = _FeedResponseDto;

  const FeedResponseDto._();

  factory FeedResponseDto.fromJson(Map<String, dynamic> json) =>
      _$FeedResponseDtoFromJson(json);

  FeedPage toEntity({Set<int> myPetIds = const {}}) => FeedPage(
        posts:
            posts.map((p) => p.toEntity(myPetIds: myPetIds)).toList(growable: false),
        cursor: PageCursor(hasMore: hasMore, nextCursor: nextCursor),
      );
}

/// One entry in `DiscoverFeedResponse.suggestedPages`.
@freezed
abstract class SuggestedPageDto with _$SuggestedPageDto {
  const factory SuggestedPageDto({
    required int id,
    @Default('') String name,
    @Default('') String handle,
    String? avatarUrl,
    String? category,
    @Default(false) bool isVerified,
    @Default(0) int followerCount,
    @Default(false) bool isFollowing,
  }) = _SuggestedPageDto;

  const SuggestedPageDto._();

  factory SuggestedPageDto.fromJson(Map<String, dynamic> json) =>
      _$SuggestedPageDtoFromJson(json);

  SuggestedPage toEntity() => SuggestedPage(
        id: id,
        name: name,
        handle: handle,
        avatarUrl: avatarUrl,
        category: discoverPageCategoryFromWire(category),
        isVerified: isVerified,
        followerCount: followerCount,
        isFollowing: isFollowing,
      );
}

/// Lightweight adoption card embedded in a Discover `adoptionInjections[]`
/// entry. This is a thin promo shape (not the full `AdoptionListingDto`) - just
/// enough to render the interleaved card; tapping it opens the full listing by
/// [id].
@freezed
abstract class AdoptionInjectionCardDto with _$AdoptionInjectionCardDto {
  const factory AdoptionInjectionCardDto({
    required int id,
    int? statusId,
    @Default('') String petName,
    String? speciesName,
    String? photoUrl,
    String? locationLabel,
    @Default(false) bool vaccinated,
    @Default(false) bool neutered,
    @Default(false) bool goodWithKids,
  }) = _AdoptionInjectionCardDto;

  const AdoptionInjectionCardDto._();

  factory AdoptionInjectionCardDto.fromJson(Map<String, dynamic> json) =>
      _$AdoptionInjectionCardDtoFromJson(json);

  AdoptionInjectionCard toEntity() => AdoptionInjectionCard(
        id: id,
        statusId: statusId,
        petName: petName,
        speciesName: speciesName,
        photoUrl: photoUrl,
        locationLabel: locationLabel,
        vaccinated: vaccinated,
        neutered: neutered,
        goodWithKids: goodWithKids,
      );
}

/// One `adoptionInjections[]` entry: a card plus the 0-based post position it
/// should be rendered *after* (`-1` → before the first post).
@freezed
abstract class AdoptionInjectionDto with _$AdoptionInjectionDto {
  const factory AdoptionInjectionDto({
    @Default(-1) int afterPosition,
    required AdoptionInjectionCardDto card,
  }) = _AdoptionInjectionDto;

  const AdoptionInjectionDto._();

  factory AdoptionInjectionDto.fromJson(Map<String, dynamic> json) =>
      _$AdoptionInjectionDtoFromJson(json);

  AdoptionInjection toEntity() => AdoptionInjection(
        afterPosition: afterPosition,
        card: card.toEntity(),
      );
}

/// `DiscoverFeedResponse`.
@freezed
abstract class DiscoverResponseDto with _$DiscoverResponseDto {
  const factory DiscoverResponseDto({
    @Default(<PostDto>[]) List<PostDto> posts,
    @Default(<PetSummaryDto>[]) List<PetSummaryDto> suggestedPets,
    @Default(<CommunityDto>[]) List<CommunityDto> suggestedCommunities,
    @Default(<SuggestedPageDto>[]) List<SuggestedPageDto> suggestedPages,
    @Default(<LostFoundAlertDto>[]) List<LostFoundAlertDto> alerts,
    @Default(<AdoptionInjectionDto>[]) List<AdoptionInjectionDto> adoptionInjections,
    @Default(false) bool hasMore,
    String? nextCursor,
  }) = _DiscoverResponseDto;

  const DiscoverResponseDto._();

  factory DiscoverResponseDto.fromJson(Map<String, dynamic> json) =>
      _$DiscoverResponseDtoFromJson(json);

  DiscoverPage toEntity({Set<int> myPetIds = const {}}) => DiscoverPage(
        posts:
            posts.map((p) => p.toEntity(myPetIds: myPetIds)).toList(growable: false),
        suggestedPets: suggestedPets
            .map((p) => p.toEntity(mine: myPetIds.contains(p.id)))
            .toList(growable: false),
        suggestedCommunities: suggestedCommunities
            .map((c) => c.toEntity(leadIsMine: c.lead != null && myPetIds.contains(c.lead!.id)))
            .toList(growable: false),
        suggestedPages: suggestedPages
            .map((p) => p.toEntity())
            .toList(growable: false),
        alerts: alerts.map((a) => a.toEntity()).toList(growable: false),
        adoptionInjections:
            adoptionInjections.map((a) => a.toEntity()).toList(growable: false),
        cursor: PageCursor(hasMore: hasMore, nextCursor: nextCursor),
      );
}

/// `CommentsResponse`.
@freezed
abstract class CommentsResponseDto with _$CommentsResponseDto {
  const factory CommentsResponseDto({
    @Default(<CommentDto>[]) List<CommentDto> comments,
    @Default(false) bool hasMore,
    String? nextCursor,
  }) = _CommentsResponseDto;

  const CommentsResponseDto._();

  factory CommentsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CommentsResponseDtoFromJson(json);

  CommentPage toEntity({Set<int> myPetIds = const {}}) => CommentPage(
        comments: comments
            .map((c) => c.toEntity(myPetIds: myPetIds))
            .toList(growable: false),
        cursor: PageCursor(hasMore: hasMore, nextCursor: nextCursor),
      );
}

/// `FollowersResponse` / `FollowingResponse` / `BlockedPetsResponse` - the same
/// paged-pets-with-count shape, with the list under different keys. We read all
/// three possible keys so one DTO serves every case.
@freezed
abstract class PetPageDto with _$PetPageDto {
  const factory PetPageDto({
    @Default(<PetSummaryDto>[]) List<PetSummaryDto> followers,
    @Default(<PetSummaryDto>[]) List<PetSummaryDto> following,
    @Default(<PetSummaryDto>[]) List<PetSummaryDto> blockedPets,
    @Default(0) int count,
    @Default(false) bool hasMore,
    String? nextCursor,
  }) = _PetPageDto;

  const PetPageDto._();

  factory PetPageDto.fromJson(Map<String, dynamic> json) =>
      _$PetPageDtoFromJson(json);

  PetPage toEntity({Set<int> myPetIds = const {}}) {
    final list = [
      ...followers,
      ...following,
      ...blockedPets,
    ];
    return PetPage(
      pets: list
          .map((p) => p.toEntity(mine: myPetIds.contains(p.id)))
          .toList(growable: false),
      count: count,
      cursor: PageCursor(hasMore: hasMore, nextCursor: nextCursor),
    );
  }
}

/// `SuggestedPetsResponse`.
@freezed
abstract class SuggestedPetsResponseDto with _$SuggestedPetsResponseDto {
  const factory SuggestedPetsResponseDto({
    @Default(<PetSummaryDto>[]) List<PetSummaryDto> suggestedPets,
  }) = _SuggestedPetsResponseDto;

  const SuggestedPetsResponseDto._();

  factory SuggestedPetsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SuggestedPetsResponseDtoFromJson(json);

  List<CommunityPet> toEntities({Set<int> myPetIds = const {}}) => suggestedPets
      .map((p) => p.toEntity(mine: myPetIds.contains(p.id)))
      .toList(growable: false);
}

/// `NotificationsResponse`.
@freezed
abstract class NotificationsResponseDto with _$NotificationsResponseDto {
  const factory NotificationsResponseDto({
    @Default(<NotificationDto>[]) List<NotificationDto> notifications,
    @Default(0) int unreadCount,
    @Default(false) bool hasMore,
    String? nextCursor,
  }) = _NotificationsResponseDto;

  const NotificationsResponseDto._();

  factory NotificationsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseDtoFromJson(json);

  NotificationPage toEntity() => NotificationPage(
        notifications:
            notifications.map((n) => n.toEntity()).toList(growable: false),
        unreadCount: unreadCount,
        cursor: PageCursor(hasMore: hasMore, nextCursor: nextCursor),
      );
}

/// `HashtagFeedResponse`.
@freezed
abstract class HashtagFeedResponseDto with _$HashtagFeedResponseDto {
  const factory HashtagFeedResponseDto({
    @Default('') String hashtag,
    @Default(0) int postCount,
    @Default(<PostDto>[]) List<PostDto> posts,
    @Default(false) bool hasMore,
    String? nextCursor,
  }) = _HashtagFeedResponseDto;

  const HashtagFeedResponseDto._();

  factory HashtagFeedResponseDto.fromJson(Map<String, dynamic> json) =>
      _$HashtagFeedResponseDtoFromJson(json);

  HashtagFeed toEntity({Set<int> myPetIds = const {}}) => HashtagFeed(
        hashtag: hashtag,
        postCount: postCount,
        posts:
            posts.map((p) => p.toEntity(myPetIds: myPetIds)).toList(growable: false),
        cursor: PageCursor(hasMore: hasMore, nextCursor: nextCursor),
      );
}

/// `SearchResponse`.
@freezed
abstract class SearchResponseDto with _$SearchResponseDto {
  const factory SearchResponseDto({
    @Default(<SearchResultDto>[]) List<SearchResultDto> results,
    @Default(false) bool hasMore,
    String? nextCursor,
  }) = _SearchResponseDto;

  const SearchResponseDto._();

  factory SearchResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseDtoFromJson(json);

  SearchResultsPage toEntity({Set<int> myPetIds = const {}}) => SearchResultsPage(
        results: results
            .map((r) => r.toEntity(myPetIds: myPetIds))
            .toList(growable: false),
        cursor: PageCursor(hasMore: hasMore, nextCursor: nextCursor),
      );
}

/// `TrendingResponse`.
@freezed
abstract class TrendingResponseDto with _$TrendingResponseDto {
  const factory TrendingResponseDto({
    @Default(<TrendingHashtagDto>[]) List<TrendingHashtagDto> trendingHashtags,
    @Default(<PostDto>[]) List<PostDto> trendingPosts,
  }) = _TrendingResponseDto;

  const TrendingResponseDto._();

  factory TrendingResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TrendingResponseDtoFromJson(json);

  Trending toEntity({Set<int> myPetIds = const {}}) => Trending(
        hashtags:
            trendingHashtags.map((h) => h.toEntity()).toList(growable: false),
        posts: trendingPosts
            .map((p) => p.toEntity(myPetIds: myPetIds))
            .toList(growable: false),
      );
}

// ── Small action responses ─────────────────────────────────────────────────

/// `FollowResponse`.
@freezed
abstract class FollowResponseDto with _$FollowResponseDto {
  const factory FollowResponseDto({
    @Default(0) int petId,
    @Default(0) int followers,
    @Default(false) bool isFollowing,
  }) = _FollowResponseDto;

  const FollowResponseDto._();

  factory FollowResponseDto.fromJson(Map<String, dynamic> json) =>
      _$FollowResponseDtoFromJson(json);

  FollowResult toEntity() =>
      FollowResult(petId: petId, followers: followers, isFollowing: isFollowing);
}

/// `SaveResponse`.
@freezed
abstract class SaveResponseDto with _$SaveResponseDto {
  const factory SaveResponseDto({
    @Default(0) int postId,
    @Default(false) bool saved,
    @Default(0) int saveCount,
  }) = _SaveResponseDto;

  const SaveResponseDto._();

  factory SaveResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SaveResponseDtoFromJson(json);

  SaveResult toEntity() =>
      SaveResult(postId: postId, saved: saved, saveCount: saveCount);
}

/// `SharePostResponse`.
@freezed
abstract class ShareResponseDto with _$ShareResponseDto {
  const factory ShareResponseDto({
    @Default(0) int postId,
    @Default('') String shareUrl,
  }) = _ShareResponseDto;

  const ShareResponseDto._();

  factory ShareResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ShareResponseDtoFromJson(json);

  ShareResult toEntity() => ShareResult(postId: postId, shareUrl: shareUrl);
}

/// `LikeCountResponse`.
@freezed
abstract class LikeCountResponseDto with _$LikeCountResponseDto {
  const factory LikeCountResponseDto({@Default(0) int likes}) =
      _LikeCountResponseDto;

  const LikeCountResponseDto._();

  factory LikeCountResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LikeCountResponseDtoFromJson(json);
}

/// `PinCommentResponse`.
@freezed
abstract class PinResponseDto with _$PinResponseDto {
  const factory PinResponseDto({@Default(false) bool isPinned}) =
      _PinResponseDto;

  const PinResponseDto._();

  factory PinResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PinResponseDtoFromJson(json);
}

/// `BlockResponse`.
@freezed
abstract class BlockResponseDto with _$BlockResponseDto {
  const factory BlockResponseDto({
    @Default(0) int petId,
    @Default(false) bool blocked,
  }) = _BlockResponseDto;

  const BlockResponseDto._();

  factory BlockResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BlockResponseDtoFromJson(json);

  BlockResult toEntity() => BlockResult(petId: petId, blocked: blocked);
}

/// `ReportResponse` - `status` is a camelCase string.
@freezed
abstract class ReportResponseDto with _$ReportResponseDto {
  const factory ReportResponseDto({
    @Default(0) int reportId,
    @Default('open') String status,
  }) = _ReportResponseDto;

  const ReportResponseDto._();

  factory ReportResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ReportResponseDtoFromJson(json);

  ReportResult toEntity() =>
      ReportResult(reportId: reportId, status: reportStatusFromWire(status));
}

/// `MarkNotificationReadResponse`.
@freezed
abstract class MarkReadResponseDto with _$MarkReadResponseDto {
  const factory MarkReadResponseDto({
    @Default(false) bool isRead,
    @Default(0) int unreadCount,
  }) = _MarkReadResponseDto;

  const MarkReadResponseDto._();

  factory MarkReadResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MarkReadResponseDtoFromJson(json);

  MarkReadResult toEntity() => MarkReadResult(unreadCount: unreadCount);
}

/// `MarkAllReadResponse`.
@freezed
abstract class MarkAllReadResponseDto with _$MarkAllReadResponseDto {
  const factory MarkAllReadResponseDto({@Default(0) int marked}) =
      _MarkAllReadResponseDto;

  const MarkAllReadResponseDto._();

  factory MarkAllReadResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MarkAllReadResponseDtoFromJson(json);

  /// The mark-all response carries only `marked`; the caller refetches the
  /// badge, so unreadCount is reported as 0 here and overridden downstream.
  MarkReadResult toEntity() => MarkReadResult(marked: marked, unreadCount: 0);
}
