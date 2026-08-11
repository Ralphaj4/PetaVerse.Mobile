import 'package:flutter_test/flutter_test.dart';
import 'package:petaverse_mobile/features/community/domain/entities/community_entities.dart';
import 'package:petaverse_mobile/features/community/domain/entities/community_enums.dart';
import 'package:petaverse_mobile/features/community/presentation/models/pawhub_models.dart' as models;

void main() {
  group('PostMedia.durationLabel', () {
    test('null when isVideo is false', () {
      const m = PostMedia(url: 'u', isVideo: false);
      expect(m.durationLabel, isNull);
    });

    test('null when durationSeconds is null even if isVideo', () {
      const m = PostMedia(url: 'u', isVideo: true);
      expect(m.durationLabel, isNull);
    });

    test('formats seconds < 60', () {
      const m = PostMedia(url: 'u', isVideo: true, durationSeconds: 45);
      expect(m.durationLabel, '0:45');
    });

    test('formats exactly 60 seconds', () {
      const m = PostMedia(url: 'u', isVideo: true, durationSeconds: 60);
      expect(m.durationLabel, '1:00');
    });

    test('pads single-digit seconds', () {
      const m = PostMedia(url: 'u', isVideo: true, durationSeconds: 125);
      expect(m.durationLabel, '2:05');
    });
  });

  group('Post.copyWith', () {
    final base = Post(
      id: 1,
      author: const CommunityPet(id: 1, name: 'Bella'),
      media: const [],
      hashtags: const ['dog'],
      taggedPetIds: const [],
      likes: 10,
      comments: 3,
      likedByMe: false,
      saved: false,
      isEdited: false,
      createdAt: DateTime(2025, 1, 1),
    );

    test('copyWith updates likes', () {
      final updated = base.copyWith(likes: 11, likedByMe: true);
      expect(updated.likes, 11);
      expect(updated.likedByMe, true);
      expect(updated.id, 1);
    });

    test('copyWith preserves unchanged fields', () {
      final updated = base.copyWith(saved: true);
      expect(updated.hashtags, ['dog']);
      expect(updated.comments, 3);
    });
  });

  group('CommunityPet.breedOrSpecies', () {
    test('returns breed when non-empty', () {
      const p = CommunityPet(id: 1, name: 'X', breed: 'Beagle', species: 'Dog');
      expect(p.breedOrSpecies, 'Beagle');
    });

    test('falls back to species when breed is null', () {
      const p = CommunityPet(id: 1, name: 'X', species: 'Cat');
      expect(p.breedOrSpecies, 'Cat');
    });

    test('falls back to species when breed is empty', () {
      const p = CommunityPet(id: 1, name: 'X', breed: '', species: 'Parrot');
      expect(p.breedOrSpecies, 'Parrot');
    });

    test('returns empty string when both null', () {
      const p = CommunityPet(id: 1, name: 'X');
      expect(p.breedOrSpecies, '');
    });
  });

  group('PageCursor', () {
    test('empty cursor has no more pages', () {
      expect(PageCursor.empty.hasMore, false);
      expect(PageCursor.empty.nextPage, isNull);
    });

    test('cursor with nextPage has more', () {
      const c = PageCursor(hasMore: true, nextPage: 1);
      expect(c.hasMore, true);
    });
  });

  group('models.PawPost.fromEntity', () {
    final entity = Post(
      id: 99,
      author: const CommunityPet(
        id: 5,
        name: 'Luna',
        breed: 'Siamese',
        species: 'Cat',
        avatarUrl: 'https://cat.jpg',
        ownerName: 'Me',
        isMine: true,
      ),
      media: const [
        PostMedia(url: 'https://img.jpg', isVideo: false),
        PostMedia(url: 'https://vid.mp4', isVideo: true, durationSeconds: 30),
      ],
      hashtags: const ['cat', 'cute'],
      taggedPetIds: const [],
      likes: 42,
      comments: 7,
      likedByMe: true,
      saved: true,
      isEdited: true,
      createdAt: DateTime(2025, 3, 15),
      caption: 'Hello cats',
      locationName: 'Beirut',
      visibility: PostVisibility.followers,
      timeAgo: '5h',
    );

    test('maps backendId', () {
      expect(models.PawPost.fromEntity(entity).backendId, 99);
    });

    test('maps author isMine flag', () {
      expect(models.PawPost.fromEntity(entity).author.isMine, true);
    });

    test('maps media correctly', () {
      final post = models.PawPost.fromEntity(entity);
      expect(post.media.length, 2);
      expect(post.media[1].isVideo, true);
      expect(post.media[1].durationLabel, '0:30');
    });

    test('maps visibility to model enum', () {
      expect(models.PawPost.fromEntity(entity).visibility, models.PostVisibility.followers);
    });

    test('maps likedByMe, saved, isEdited', () {
      final post = models.PawPost.fromEntity(entity);
      expect(post.likedByMe, true);
      expect(post.saved, true);
      expect(post.isEdited, true);
    });

    test('totalCommentCount comes from server count', () {
      expect(models.PawPost.fromEntity(entity).totalCommentCount, 7);
    });
  });

  group('models.PawPet.fromEntity', () {
    const pet = CommunityPet(
      id: 10,
      name: 'Max',
      breed: 'Corgi',
      species: 'Dog',
      avatarUrl: 'https://max.jpg',
      ownerName: 'Jad',
      isVerified: true,
      followers: 4000,
      isFollowing: true,
      isMine: false,
    );

    test('maps all fields', () {
      final p = models.PawPet.fromEntity(pet);
      expect(p.backendId, 10);
      expect(p.id, '10');
      expect(p.name, 'Max');
      expect(p.breed, 'Corgi');
      expect(p.isVerified, true);
      expect(p.followers, 4000);
      expect(p.isFollowing, true);
      expect(p.isMine, false);
    });
  });
}
