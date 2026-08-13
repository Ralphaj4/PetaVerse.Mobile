// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PetSummaryDto _$PetSummaryDtoFromJson(Map<String, dynamic> json) =>
    _PetSummaryDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      breed: json['breed'] as String?,
      species: json['species'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      bio: json['bio'] as String?,
      ownerName: json['ownerName'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
      followers: (json['followers'] as num?)?.toInt() ?? 0,
      isFollowing: json['isFollowing'] as bool? ?? false,
    );

Map<String, dynamic> _$PetSummaryDtoToJson(_PetSummaryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'breed': instance.breed,
      'species': instance.species,
      'avatarUrl': instance.avatarUrl,
      'bio': instance.bio,
      'ownerName': instance.ownerName,
      'isVerified': instance.isVerified,
      'followers': instance.followers,
      'isFollowing': instance.isFollowing,
    };

_PostMediaDto _$PostMediaDtoFromJson(Map<String, dynamic> json) =>
    _PostMediaDto(
      url: json['url'] as String? ?? '',
      isVideo: json['isVideo'] as bool? ?? false,
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
      altText: json['altText'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
    );

Map<String, dynamic> _$PostMediaDtoToJson(_PostMediaDto instance) =>
    <String, dynamic>{
      'url': instance.url,
      'isVideo': instance.isVideo,
      'durationSeconds': instance.durationSeconds,
      'altText': instance.altText,
      'thumbnailUrl': instance.thumbnailUrl,
    };

_PostDto _$PostDtoFromJson(Map<String, dynamic> json) => _PostDto(
  id: (json['id'] as num).toInt(),
  author: PetSummaryDto.fromJson(json['author'] as Map<String, dynamic>),
  media:
      (json['media'] as List<dynamic>?)
          ?.map((e) => PostMediaDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PostMediaDto>[],
  caption: json['caption'] as String?,
  locationName: json['locationName'] as String?,
  visibility: (json['visibility'] as num?)?.toInt() ?? 0,
  hashtags:
      (json['hashtags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  taggedPets:
      (json['taggedPets'] as List<dynamic>?)
          ?.map((e) => PetSummaryDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PetSummaryDto>[],
  likes: (json['likes'] as num?)?.toInt() ?? 0,
  comments: (json['comments'] as num?)?.toInt() ?? 0,
  likedByMe: json['likedByMe'] as bool? ?? false,
  saved: json['saved'] as bool? ?? false,
  isEdited: json['isEdited'] as bool? ?? false,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  timeAgo: json['timeAgo'] as String?,
  communityId: (json['communityId'] as num?)?.toInt(),
  communityName: json['communityName'] as String?,
);

Map<String, dynamic> _$PostDtoToJson(_PostDto instance) => <String, dynamic>{
  'id': instance.id,
  'author': instance.author,
  'media': instance.media,
  'caption': instance.caption,
  'locationName': instance.locationName,
  'visibility': instance.visibility,
  'hashtags': instance.hashtags,
  'taggedPets': instance.taggedPets,
  'likes': instance.likes,
  'comments': instance.comments,
  'likedByMe': instance.likedByMe,
  'saved': instance.saved,
  'isEdited': instance.isEdited,
  'createdAt': instance.createdAt?.toIso8601String(),
  'timeAgo': instance.timeAgo,
  'communityId': instance.communityId,
  'communityName': instance.communityName,
};

_CommentDto _$CommentDtoFromJson(Map<String, dynamic> json) => _CommentDto(
  id: (json['id'] as num).toInt(),
  postId: (json['postId'] as num?)?.toInt() ?? 0,
  author: PetSummaryDto.fromJson(json['author'] as Map<String, dynamic>),
  parentCommentId: (json['parentCommentId'] as num?)?.toInt(),
  body: json['body'] as String? ?? '',
  likes: (json['likes'] as num?)?.toInt() ?? 0,
  likedByMe: json['likedByMe'] as bool? ?? false,
  isPinned: json['isPinned'] as bool? ?? false,
  replies:
      (json['replies'] as List<dynamic>?)
          ?.map((e) => CommentDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <CommentDto>[],
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  timeAgo: json['timeAgo'] as String?,
);

Map<String, dynamic> _$CommentDtoToJson(_CommentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'author': instance.author,
      'parentCommentId': instance.parentCommentId,
      'body': instance.body,
      'likes': instance.likes,
      'likedByMe': instance.likedByMe,
      'isPinned': instance.isPinned,
      'replies': instance.replies,
      'createdAt': instance.createdAt?.toIso8601String(),
      'timeAgo': instance.timeAgo,
    };

_PostDetailDto _$PostDetailDtoFromJson(Map<String, dynamic> json) =>
    _PostDetailDto(
      post: PostDto.fromJson(json['post'] as Map<String, dynamic>),
      comments:
          (json['comments'] as List<dynamic>?)
              ?.map((e) => CommentDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CommentDto>[],
    );

Map<String, dynamic> _$PostDetailDtoToJson(_PostDetailDto instance) =>
    <String, dynamic>{'post': instance.post, 'comments': instance.comments};

_LostFoundAlertDto _$LostFoundAlertDtoFromJson(Map<String, dynamic> json) =>
    _LostFoundAlertDto(
      id: (json['id'] as num).toInt(),
      petName: json['petName'] as String? ?? '',
      breed: json['breed'] as String? ?? '',
      distanceLabel: json['distanceLabel'] as String?,
      imageUrl: json['imageUrl'] as String? ?? '',
      reward: (json['reward'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      timeAgo: json['timeAgo'] as String?,
    );

Map<String, dynamic> _$LostFoundAlertDtoToJson(_LostFoundAlertDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'petName': instance.petName,
      'breed': instance.breed,
      'distanceLabel': instance.distanceLabel,
      'imageUrl': instance.imageUrl,
      'reward': instance.reward,
      'createdAt': instance.createdAt?.toIso8601String(),
      'timeAgo': instance.timeAgo,
    };

_NotificationDto _$NotificationDtoFromJson(Map<String, dynamic> json) =>
    _NotificationDto(
      id: (json['id'] as num).toInt(),
      type: (json['type'] as num?)?.toInt() ?? 0,
      actor: json['actor'] == null
          ? null
          : PetSummaryDto.fromJson(json['actor'] as Map<String, dynamic>),
      text: json['text'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String?,
      actionUrl: json['actionUrl'] as String?,
      isRead: json['isRead'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      timeAgo: json['timeAgo'] as String?,
    );

Map<String, dynamic> _$NotificationDtoToJson(_NotificationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'actor': instance.actor,
      'text': instance.text,
      'thumbnailUrl': instance.thumbnailUrl,
      'actionUrl': instance.actionUrl,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt?.toIso8601String(),
      'timeAgo': instance.timeAgo,
    };

_SearchResultDto _$SearchResultDtoFromJson(Map<String, dynamic> json) =>
    _SearchResultDto(
      type: json['type'] as String? ?? 'post',
      post: json['post'] == null
          ? null
          : PostDto.fromJson(json['post'] as Map<String, dynamic>),
      hashtag: json['hashtag'] as String?,
      postCount: (json['postCount'] as num?)?.toInt(),
      pet: json['pet'] == null
          ? null
          : PetSummaryDto.fromJson(json['pet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchResultDtoToJson(_SearchResultDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'post': instance.post,
      'hashtag': instance.hashtag,
      'postCount': instance.postCount,
      'pet': instance.pet,
    };

_TrendingHashtagDto _$TrendingHashtagDtoFromJson(Map<String, dynamic> json) =>
    _TrendingHashtagDto(
      tag: json['tag'] as String? ?? '',
      postCount: (json['postCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TrendingHashtagDtoToJson(_TrendingHashtagDto instance) =>
    <String, dynamic>{'tag': instance.tag, 'postCount': instance.postCount};

_FeedResponseDto _$FeedResponseDtoFromJson(Map<String, dynamic> json) =>
    _FeedResponseDto(
      posts:
          (json['posts'] as List<dynamic>?)
              ?.map((e) => PostDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PostDto>[],
      hasMore: json['hasMore'] as bool? ?? false,
      nextPage: (json['nextPage'] as num?)?.toInt(),
      postCount: (json['postCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FeedResponseDtoToJson(_FeedResponseDto instance) =>
    <String, dynamic>{
      'posts': instance.posts,
      'hasMore': instance.hasMore,
      'nextPage': instance.nextPage,
      'postCount': instance.postCount,
    };

_DiscoverResponseDto _$DiscoverResponseDtoFromJson(Map<String, dynamic> json) =>
    _DiscoverResponseDto(
      posts:
          (json['posts'] as List<dynamic>?)
              ?.map((e) => PostDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PostDto>[],
      suggestedPets:
          (json['suggestedPets'] as List<dynamic>?)
              ?.map((e) => PetSummaryDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PetSummaryDto>[],
      suggestedCommunities:
          (json['suggestedCommunities'] as List<dynamic>?)
              ?.map((e) => CommunityDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CommunityDto>[],
      alerts:
          (json['alerts'] as List<dynamic>?)
              ?.map(
                (e) => LostFoundAlertDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <LostFoundAlertDto>[],
      hasMore: json['hasMore'] as bool? ?? false,
      nextPage: (json['nextPage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DiscoverResponseDtoToJson(
  _DiscoverResponseDto instance,
) => <String, dynamic>{
  'posts': instance.posts,
  'suggestedPets': instance.suggestedPets,
  'suggestedCommunities': instance.suggestedCommunities,
  'alerts': instance.alerts,
  'hasMore': instance.hasMore,
  'nextPage': instance.nextPage,
};

_CommentsResponseDto _$CommentsResponseDtoFromJson(Map<String, dynamic> json) =>
    _CommentsResponseDto(
      comments:
          (json['comments'] as List<dynamic>?)
              ?.map((e) => CommentDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CommentDto>[],
      hasMore: json['hasMore'] as bool? ?? false,
      nextPage: (json['nextPage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CommentsResponseDtoToJson(
  _CommentsResponseDto instance,
) => <String, dynamic>{
  'comments': instance.comments,
  'hasMore': instance.hasMore,
  'nextPage': instance.nextPage,
};

_PetPageDto _$PetPageDtoFromJson(Map<String, dynamic> json) => _PetPageDto(
  followers:
      (json['followers'] as List<dynamic>?)
          ?.map((e) => PetSummaryDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PetSummaryDto>[],
  following:
      (json['following'] as List<dynamic>?)
          ?.map((e) => PetSummaryDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PetSummaryDto>[],
  blockedPets:
      (json['blockedPets'] as List<dynamic>?)
          ?.map((e) => PetSummaryDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PetSummaryDto>[],
  count: (json['count'] as num?)?.toInt() ?? 0,
  hasMore: json['hasMore'] as bool? ?? false,
  nextPage: (json['nextPage'] as num?)?.toInt(),
);

Map<String, dynamic> _$PetPageDtoToJson(_PetPageDto instance) =>
    <String, dynamic>{
      'followers': instance.followers,
      'following': instance.following,
      'blockedPets': instance.blockedPets,
      'count': instance.count,
      'hasMore': instance.hasMore,
      'nextPage': instance.nextPage,
    };

_SuggestedPetsResponseDto _$SuggestedPetsResponseDtoFromJson(
  Map<String, dynamic> json,
) => _SuggestedPetsResponseDto(
  suggestedPets:
      (json['suggestedPets'] as List<dynamic>?)
          ?.map((e) => PetSummaryDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PetSummaryDto>[],
);

Map<String, dynamic> _$SuggestedPetsResponseDtoToJson(
  _SuggestedPetsResponseDto instance,
) => <String, dynamic>{'suggestedPets': instance.suggestedPets};

_NotificationsResponseDto _$NotificationsResponseDtoFromJson(
  Map<String, dynamic> json,
) => _NotificationsResponseDto(
  notifications:
      (json['notifications'] as List<dynamic>?)
          ?.map((e) => NotificationDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <NotificationDto>[],
  unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
  hasMore: json['hasMore'] as bool? ?? false,
  nextPage: (json['nextPage'] as num?)?.toInt(),
);

Map<String, dynamic> _$NotificationsResponseDtoToJson(
  _NotificationsResponseDto instance,
) => <String, dynamic>{
  'notifications': instance.notifications,
  'unreadCount': instance.unreadCount,
  'hasMore': instance.hasMore,
  'nextPage': instance.nextPage,
};

_HashtagFeedResponseDto _$HashtagFeedResponseDtoFromJson(
  Map<String, dynamic> json,
) => _HashtagFeedResponseDto(
  hashtag: json['hashtag'] as String? ?? '',
  postCount: (json['postCount'] as num?)?.toInt() ?? 0,
  posts:
      (json['posts'] as List<dynamic>?)
          ?.map((e) => PostDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PostDto>[],
  hasMore: json['hasMore'] as bool? ?? false,
  nextPage: (json['nextPage'] as num?)?.toInt(),
);

Map<String, dynamic> _$HashtagFeedResponseDtoToJson(
  _HashtagFeedResponseDto instance,
) => <String, dynamic>{
  'hashtag': instance.hashtag,
  'postCount': instance.postCount,
  'posts': instance.posts,
  'hasMore': instance.hasMore,
  'nextPage': instance.nextPage,
};

_SearchResponseDto _$SearchResponseDtoFromJson(Map<String, dynamic> json) =>
    _SearchResponseDto(
      results:
          (json['results'] as List<dynamic>?)
              ?.map((e) => SearchResultDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SearchResultDto>[],
      hasMore: json['hasMore'] as bool? ?? false,
      nextPage: (json['nextPage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SearchResponseDtoToJson(_SearchResponseDto instance) =>
    <String, dynamic>{
      'results': instance.results,
      'hasMore': instance.hasMore,
      'nextPage': instance.nextPage,
    };

_TrendingResponseDto _$TrendingResponseDtoFromJson(Map<String, dynamic> json) =>
    _TrendingResponseDto(
      trendingHashtags:
          (json['trendingHashtags'] as List<dynamic>?)
              ?.map(
                (e) => TrendingHashtagDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <TrendingHashtagDto>[],
      trendingPosts:
          (json['trendingPosts'] as List<dynamic>?)
              ?.map((e) => PostDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PostDto>[],
    );

Map<String, dynamic> _$TrendingResponseDtoToJson(
  _TrendingResponseDto instance,
) => <String, dynamic>{
  'trendingHashtags': instance.trendingHashtags,
  'trendingPosts': instance.trendingPosts,
};

_FollowResponseDto _$FollowResponseDtoFromJson(Map<String, dynamic> json) =>
    _FollowResponseDto(
      petId: (json['petId'] as num?)?.toInt() ?? 0,
      followers: (json['followers'] as num?)?.toInt() ?? 0,
      isFollowing: json['isFollowing'] as bool? ?? false,
    );

Map<String, dynamic> _$FollowResponseDtoToJson(_FollowResponseDto instance) =>
    <String, dynamic>{
      'petId': instance.petId,
      'followers': instance.followers,
      'isFollowing': instance.isFollowing,
    };

_SaveResponseDto _$SaveResponseDtoFromJson(Map<String, dynamic> json) =>
    _SaveResponseDto(
      postId: (json['postId'] as num?)?.toInt() ?? 0,
      saved: json['saved'] as bool? ?? false,
      saveCount: (json['saveCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SaveResponseDtoToJson(_SaveResponseDto instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'saved': instance.saved,
      'saveCount': instance.saveCount,
    };

_ShareResponseDto _$ShareResponseDtoFromJson(Map<String, dynamic> json) =>
    _ShareResponseDto(
      postId: (json['postId'] as num?)?.toInt() ?? 0,
      shareUrl: json['shareUrl'] as String? ?? '',
    );

Map<String, dynamic> _$ShareResponseDtoToJson(_ShareResponseDto instance) =>
    <String, dynamic>{'postId': instance.postId, 'shareUrl': instance.shareUrl};

_LikeCountResponseDto _$LikeCountResponseDtoFromJson(
  Map<String, dynamic> json,
) => _LikeCountResponseDto(likes: (json['likes'] as num?)?.toInt() ?? 0);

Map<String, dynamic> _$LikeCountResponseDtoToJson(
  _LikeCountResponseDto instance,
) => <String, dynamic>{'likes': instance.likes};

_PinResponseDto _$PinResponseDtoFromJson(Map<String, dynamic> json) =>
    _PinResponseDto(isPinned: json['isPinned'] as bool? ?? false);

Map<String, dynamic> _$PinResponseDtoToJson(_PinResponseDto instance) =>
    <String, dynamic>{'isPinned': instance.isPinned};

_BlockResponseDto _$BlockResponseDtoFromJson(Map<String, dynamic> json) =>
    _BlockResponseDto(
      petId: (json['petId'] as num?)?.toInt() ?? 0,
      blocked: json['blocked'] as bool? ?? false,
    );

Map<String, dynamic> _$BlockResponseDtoToJson(_BlockResponseDto instance) =>
    <String, dynamic>{'petId': instance.petId, 'blocked': instance.blocked};

_ReportResponseDto _$ReportResponseDtoFromJson(Map<String, dynamic> json) =>
    _ReportResponseDto(
      reportId: (json['reportId'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'open',
    );

Map<String, dynamic> _$ReportResponseDtoToJson(_ReportResponseDto instance) =>
    <String, dynamic>{'reportId': instance.reportId, 'status': instance.status};

_MarkReadResponseDto _$MarkReadResponseDtoFromJson(Map<String, dynamic> json) =>
    _MarkReadResponseDto(
      isRead: json['isRead'] as bool? ?? false,
      unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MarkReadResponseDtoToJson(
  _MarkReadResponseDto instance,
) => <String, dynamic>{
  'isRead': instance.isRead,
  'unreadCount': instance.unreadCount,
};

_MarkAllReadResponseDto _$MarkAllReadResponseDtoFromJson(
  Map<String, dynamic> json,
) => _MarkAllReadResponseDto(marked: (json['marked'] as num?)?.toInt() ?? 0);

Map<String, dynamic> _$MarkAllReadResponseDtoToJson(
  _MarkAllReadResponseDto instance,
) => <String, dynamic>{'marked': instance.marked};
