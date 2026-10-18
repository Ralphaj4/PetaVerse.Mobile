// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PageDto _$PageDtoFromJson(Map<String, dynamic> json) => _PageDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  handle: json['handle'] as String? ?? '',
  bio: json['bio'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  bannerUrl: json['bannerUrl'] as String?,
  website: json['website'] as String?,
  phone: json['phone'] as String?,
  address: json['address'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  category: json['category'] as String?,
  ownerUserId: json['ownerUserId'] as String?,
  isVerified: json['isVerified'] as bool? ?? false,
  followerCount: (json['followerCount'] as num?)?.toInt() ?? 0,
  postCount: (json['postCount'] as num?)?.toInt() ?? 0,
  isFollowing: json['isFollowing'] as bool?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$PageDtoToJson(_PageDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'handle': instance.handle,
  'bio': instance.bio,
  'avatarUrl': instance.avatarUrl,
  'bannerUrl': instance.bannerUrl,
  'website': instance.website,
  'phone': instance.phone,
  'address': instance.address,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'category': instance.category,
  'ownerUserId': instance.ownerUserId,
  'isVerified': instance.isVerified,
  'followerCount': instance.followerCount,
  'postCount': instance.postCount,
  'isFollowing': instance.isFollowing,
  'createdAt': instance.createdAt?.toIso8601String(),
};
