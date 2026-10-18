import '../../../community/domain/entities/community_enums.dart';

/// A full page profile (`PageResponse`). Used on the page detail screen.
class PageProfile {
  const PageProfile({
    required this.id,
    required this.name,
    required this.handle,
    required this.category,
    required this.isVerified,
    required this.followerCount,
    required this.postCount,
    required this.createdAt,
    this.bio,
    this.avatarUrl,
    this.bannerUrl,
    this.website,
    this.phone,
    this.address,
    this.latitude,
    this.longitude,
    this.ownerUserId,
    this.isFollowing,
  });

  final int id;
  final String name;
  final String handle;
  final String? bio;
  final String? avatarUrl;
  final String? bannerUrl;
  final String? website;
  final String? phone;
  final String? address;
  final double? latitude;
  final double? longitude;
  final PageCategory category;
  final String? ownerUserId;
  final bool isVerified;
  final int followerCount;
  final int postCount;

  /// Null when the viewer is not authenticated.
  final bool? isFollowing;

  final DateTime createdAt;

  bool get hasCoordinates => latitude != null && longitude != null;

  PageProfile copyWith({bool? isFollowing, int? followerCount}) => PageProfile(
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
        category: category,
        ownerUserId: ownerUserId,
        isVerified: isVerified,
        followerCount: followerCount ?? this.followerCount,
        postCount: postCount,
        isFollowing: isFollowing ?? this.isFollowing,
        createdAt: createdAt,
      );
}
