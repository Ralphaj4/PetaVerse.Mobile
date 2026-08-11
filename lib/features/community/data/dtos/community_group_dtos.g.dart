// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_group_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommunityDto _$CommunityDtoFromJson(Map<String, dynamic> json) =>
    _CommunityDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      handle: json['handle'] as String?,
      description: json['description'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
      category: (json['category'] as num?)?.toInt() ?? 0,
      lead: PetSummaryDto.fromJson(json['lead'] as Map<String, dynamic>),
      memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
      postCount: (json['postCount'] as num?)?.toInt() ?? 0,
      isMember: json['isMember'] as bool?,
      isLead: json['isLead'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CommunityDtoToJson(_CommunityDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'handle': instance.handle,
      'description': instance.description,
      'avatarUrl': instance.avatarUrl,
      'bannerUrl': instance.bannerUrl,
      'category': instance.category,
      'lead': instance.lead,
      'memberCount': instance.memberCount,
      'postCount': instance.postCount,
      'isMember': instance.isMember,
      'isLead': instance.isLead,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_CommunityMemberDto _$CommunityMemberDtoFromJson(Map<String, dynamic> json) =>
    _CommunityMemberDto(
      pet: PetSummaryDto.fromJson(json['pet'] as Map<String, dynamic>),
      role: (json['role'] as num?)?.toInt() ?? 1,
      joinedAt: json['joinedAt'] == null
          ? null
          : DateTime.parse(json['joinedAt'] as String),
    );

Map<String, dynamic> _$CommunityMemberDtoToJson(_CommunityMemberDto instance) =>
    <String, dynamic>{
      'pet': instance.pet,
      'role': instance.role,
      'joinedAt': instance.joinedAt?.toIso8601String(),
    };

_CommunityDirectoryResponseDto _$CommunityDirectoryResponseDtoFromJson(
  Map<String, dynamic> json,
) => _CommunityDirectoryResponseDto(
  communities:
      (json['communities'] as List<dynamic>?)
          ?.map((e) => CommunityDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <CommunityDto>[],
  total: (json['total'] as num?)?.toInt(),
  hasMore: json['hasMore'] as bool? ?? false,
  nextPage: (json['nextPage'] as num?)?.toInt(),
);

Map<String, dynamic> _$CommunityDirectoryResponseDtoToJson(
  _CommunityDirectoryResponseDto instance,
) => <String, dynamic>{
  'communities': instance.communities,
  'total': instance.total,
  'hasMore': instance.hasMore,
  'nextPage': instance.nextPage,
};

_CommunityMembersResponseDto _$CommunityMembersResponseDtoFromJson(
  Map<String, dynamic> json,
) => _CommunityMembersResponseDto(
  members:
      (json['members'] as List<dynamic>?)
          ?.map((e) => CommunityMemberDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <CommunityMemberDto>[],
  count: (json['count'] as num?)?.toInt() ?? 0,
  hasMore: json['hasMore'] as bool? ?? false,
  nextPage: (json['nextPage'] as num?)?.toInt(),
);

Map<String, dynamic> _$CommunityMembersResponseDtoToJson(
  _CommunityMembersResponseDto instance,
) => <String, dynamic>{
  'members': instance.members,
  'count': instance.count,
  'hasMore': instance.hasMore,
  'nextPage': instance.nextPage,
};

_CommunityListResponseDto _$CommunityListResponseDtoFromJson(
  Map<String, dynamic> json,
) => _CommunityListResponseDto(
  communities:
      (json['communities'] as List<dynamic>?)
          ?.map((e) => CommunityDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <CommunityDto>[],
);

Map<String, dynamic> _$CommunityListResponseDtoToJson(
  _CommunityListResponseDto instance,
) => <String, dynamic>{'communities': instance.communities};

_CommunityJoinResponseDto _$CommunityJoinResponseDtoFromJson(
  Map<String, dynamic> json,
) => _CommunityJoinResponseDto(
  communityId: (json['communityId'] as num).toInt(),
  isMember: json['isMember'] as bool? ?? false,
  memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$CommunityJoinResponseDtoToJson(
  _CommunityJoinResponseDto instance,
) => <String, dynamic>{
  'communityId': instance.communityId,
  'isMember': instance.isMember,
  'memberCount': instance.memberCount,
};
