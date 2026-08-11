import 'package:flutter_test/flutter_test.dart';
import 'package:petaverse_mobile/features/community/data/dtos/community_dtos.dart';
import 'package:petaverse_mobile/features/community/domain/entities/community_enums.dart';

void main() {
  group('PetSummaryDto.toEntity', () {
    const dto = PetSummaryDto(
      id: 42,
      name: 'Milo',
      breed: 'Beagle',
      species: 'Dog',
      avatarUrl: 'https://example.com/milo.jpg',
      ownerName: 'Ralph',
      isVerified: true,
      followers: 500,
      isFollowing: true,
    );

    test('maps all fields', () {
      final e = dto.toEntity();
      expect(e.id, 42);
      expect(e.name, 'Milo');
      expect(e.breed, 'Beagle');
      expect(e.species, 'Dog');
      expect(e.avatarUrl, 'https://example.com/milo.jpg');
      expect(e.ownerName, 'Ralph');
      expect(e.isVerified, true);
      expect(e.followers, 500);
      expect(e.isFollowing, true);
      expect(e.isMine, false);
    });

    test('sets isMine when id in myPetIds', () {
      final e = dto.toEntity(mine: true);
      expect(e.isMine, true);
    });

    test('breedOrSpecies returns breed when present', () {
      final e = dto.toEntity();
      expect(e.breedOrSpecies, 'Beagle');
    });

    test('breedOrSpecies falls back to species', () {
      const noBreed = PetSummaryDto(id: 1, name: 'X', breed: '', species: 'Cat');
      final e = noBreed.toEntity();
      expect(e.breedOrSpecies, 'Cat');
    });
  });

  group('PostMediaDto.toEntity', () {
    test('maps image media', () {
      const dto = PostMediaDto(url: 'https://img.jpg', isVideo: false);
      final e = dto.toEntity();
      expect(e.url, 'https://img.jpg');
      expect(e.isVideo, false);
      expect(e.durationLabel, isNull);
    });

    test('maps video media and produces durationLabel', () {
      const dto =
          PostMediaDto(url: 'https://vid.mp4', isVideo: true, durationSeconds: 90);
      final e = dto.toEntity();
      expect(e.isVideo, true);
      expect(e.durationLabel, '1:30');
    });

    test('durationLabel pads seconds < 10', () {
      const dto = PostMediaDto(url: 'u', isVideo: true, durationSeconds: 65);
      expect(dto.toEntity().durationLabel, '1:05');
    });
  });

  group('PostDto.toEntity', () {
    const petDto = PetSummaryDto(id: 7, name: 'Bella');
    final dto = PostDto(
      id: 100,
      author: petDto,
      caption: 'Hello world',
      hashtags: ['dog', 'cute'],
      likes: 20,
      comments: 5,
      likedByMe: true,
      saved: false,
      isEdited: false,
      visibility: 0,
      createdAt: DateTime(2025, 6, 1),
      timeAgo: '2h',
    );

    test('maps core post fields', () {
      final e = dto.toEntity();
      expect(e.id, 100);
      expect(e.caption, 'Hello world');
      expect(e.hashtags, ['dog', 'cute']);
      expect(e.likes, 20);
      expect(e.comments, 5);
      expect(e.likedByMe, true);
      expect(e.timeAgo, '2h');
      expect(e.visibility, PostVisibility.public);
    });

    test('visibility wire 1 → followers', () {
      final e = dto.copyWith(visibility: 1).toEntity();
      expect(e.visibility, PostVisibility.followers);
    });

    test('visibility wire 2 → private', () {
      final e = dto.copyWith(visibility: 2).toEntity();
      expect(e.visibility, PostVisibility.private);
    });

    test('isMine set via myPetIds callback', () {
      final e = dto.toEntity(myPetIds: {7});
      expect(e.author.isMine, true);
    });

    test('isMine false when not in myPetIds', () {
      final e = dto.toEntity(myPetIds: {99});
      expect(e.author.isMine, false);
    });
  });

  group('CommentDto.toEntity', () {
    const author = PetSummaryDto(id: 3, name: 'Max');
    const reply = CommentDto(
      id: 22,
      postId: 1,
      author: PetSummaryDto(id: 4, name: 'Cocoa'),
      body: 'Nice!',
      likes: 2,
      createdAt: null,
    );
    const dto = CommentDto(
      id: 10,
      postId: 1,
      author: author,
      body: 'Great post',
      likes: 5,
      likedByMe: true,
      isPinned: true,
      replies: [reply],
      createdAt: null,
    );

    test('maps top-level comment fields', () {
      final e = dto.toEntity();
      expect(e.id, 10);
      expect(e.body, 'Great post');
      expect(e.likes, 5);
      expect(e.likedByMe, true);
      expect(e.isPinned, true);
    });

    test('maps nested replies', () {
      final e = dto.toEntity();
      expect(e.replies.length, 1);
      expect(e.replies.first.id, 22);
      expect(e.replies.first.body, 'Nice!');
    });

    test('isReply false for top-level', () {
      expect(dto.toEntity().isReply, false);
    });

    test('isReply true when parentCommentId set', () {
      final child = dto.copyWith(parentCommentId: 10);
      expect(child.toEntity().isReply, true);
    });
  });

  group('ReportReasonX.wire', () {
    test('each enum produces expected camelCase string', () {
      expect(ReportReason.inappropriate.wire, 'inappropriate');
      expect(ReportReason.spam.wire, 'spam');
      expect(ReportReason.harassment.wire, 'harassment');
      expect(ReportReason.misinformation.wire, 'misinformation');
      expect(ReportReason.violence.wire, 'violence');
      expect(ReportReason.other.wire, 'other');
    });
  });

  group('postVisibilityFromWire', () {
    test('0 → public', () => expect(postVisibilityFromWire(0), PostVisibility.public));
    test('1 → followers', () => expect(postVisibilityFromWire(1), PostVisibility.followers));
    test('2 → private', () => expect(postVisibilityFromWire(2), PostVisibility.private));
    test('unknown → public', () => expect(postVisibilityFromWire(99), PostVisibility.public));
  });

  group('notificationTypeFromWire', () {
    test('0 → like', () => expect(notificationTypeFromWire(0), NotificationType.like));
    test('6 → alert', () => expect(notificationTypeFromWire(6), NotificationType.alert));
    test('null → alert (fallback)', () => expect(notificationTypeFromWire(null), NotificationType.alert));
    test('unknown → alert (fallback)', () => expect(notificationTypeFromWire(999), NotificationType.alert));
  });
}
