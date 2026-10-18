import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../community/domain/entities/community_enums.dart';
import '../../domain/entities/page_entities.dart';

part 'page_dtos.freezed.dart';
part 'page_dtos.g.dart';

/// `PageResponse` — a full page profile.
@freezed
abstract class PageDto with _$PageDto {
  const factory PageDto({
    required int id,
    @Default('') String name,
    @Default('') String handle,
    String? bio,
    String? avatarUrl,
    String? bannerUrl,
    String? website,
    String? phone,
    String? address,
    double? latitude,
    double? longitude,
    String? category,
    String? ownerUserId,
    @Default(false) bool isVerified,
    @Default(0) int followerCount,
    @Default(0) int postCount,
    // null when anonymous viewer
    bool? isFollowing,
    DateTime? createdAt,
  }) = _PageDto;

  const PageDto._();

  factory PageDto.fromJson(Map<String, dynamic> json) =>
      _$PageDtoFromJson(json);

  PageProfile toEntity() => PageProfile(
        id: id,
        name: name,
        handle: handle,
        bio: bio,
        avatarUrl: avatarUrl,
        bannerUrl: bannerUrl,
        website: website,
        phone: phone,
        address: address,
        latitude: latitude,
        longitude: longitude,
        category: pageCategoryFromWire(category),
        ownerUserId: ownerUserId,
        isVerified: isVerified,
        followerCount: followerCount,
        postCount: postCount,
        isFollowing: isFollowing,
        createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      );
}

/// Result of follow / unfollow — the server echoes back the updated profile.
typedef PageFollowResponseDto = PageDto;
