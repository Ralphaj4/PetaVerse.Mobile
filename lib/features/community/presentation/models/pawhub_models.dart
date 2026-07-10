import 'package:flutter/foundation.dart';

/// Prototype-only models for the PawHub feed. These are deliberately mutable
/// and self-contained (no backend, no freezed) so the page can be fully
/// interactive with dummy data. When the real API lands, these get replaced
/// by DTOs/entities behind repositories — see docs/pawhub-design.md.

/// Post visibility. Public = everyone, followers = only followers, private =
/// only the owner's account.
enum PostVisibility { public, followers, private }

extension PostVisibilityX on PostVisibility {
  String get label => switch (this) {
        PostVisibility.public => 'Public',
        PostVisibility.followers => 'Followers',
        PostVisibility.private => 'Only me',
      };
}

/// A pet persona — the social identity that authors posts. In production this
/// maps onto the real `Pet` entity + follow state.
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
  });

  final String id;
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
/// (play glyph, duration badge) — playback itself is stubbed in the prototype.
class PawMedia {
  const PawMedia({
    required this.url,
    this.isVideo = false,
    this.durationLabel,
    this.altText = '',
  });

  final String url;
  final bool isVideo;
  final String? durationLabel;
  final String altText;
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
    List<PawComment>? replies,
  }) : replies = replies ?? [];

  final String id;
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
    List<PawComment>? comments,
  }) : comments = comments ?? [];

  final String id;
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

  int get commentCount =>
      comments.length + comments.fold(0, (n, c) => n + c.replies.length);
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
    required this.type,
    required this.actor,
    required this.text,
    required this.timeAgo,
    this.thumbnailUrl,
    this.isRead = false,
  });

  final PawNotifType type;
  final PawPet actor;
  final String text;
  final String timeAgo;
  final String? thumbnailUrl;
  bool isRead;
}

// ── Dummy data ────────────────────────────────────────────────────────────

/// Deterministic dummy dataset for the interactive prototype. Uses picsum.photos
/// seeded URLs so images are stable across rebuilds (and cache-friendly).
class PawHubDummy {
  PawHubDummy._();

  static String _img(String seed, {int w = 800, int h = 800}) =>
      'https://picsum.photos/seed/$seed/$w/$h';

  static String _avatar(String seed) =>
      'https://picsum.photos/seed/${seed}_av/200/200';

  // The signed-in account's pets (drive the Pet Switcher).
  static final myPets = <PawPet>[
    PawPet(
      id: 'me_milo',
      name: 'Milo',
      breed: 'Beagle',
      species: 'Dog',
      avatarUrl: _avatar('milo'),
      ownerName: 'You',
      bio: 'Professional treat inspector 🦴 · 3 y/o',
      isMine: true,
      isVerified: true,
      followers: 1284,
    ),
    PawPet(
      id: 'me_luna',
      name: 'Luna',
      breed: 'Siamese',
      species: 'Cat',
      avatarUrl: _avatar('luna'),
      ownerName: 'You',
      bio: 'Sunbeam connoisseur ☀️',
      isMine: true,
      followers: 642,
    ),
    PawPet(
      id: 'me_kiwi',
      name: 'Kiwi',
      breed: '',
      species: 'Parrot',
      avatarUrl: _avatar('kiwi'),
      ownerName: 'You',
      bio: 'Says hello. Repeatedly.',
      isMine: true,
      followers: 88,
    ),
  ];

  static final _bella = PawPet(
    id: 'bella',
    name: 'Bella',
    breed: 'Golden Retriever',
    species: 'Dog',
    avatarUrl: _avatar('bella'),
    ownerName: 'Sarah K.',
    isFollowing: true,
    isVerified: true,
    followers: 9820,
  );
  static final _max = PawPet(
    id: 'max',
    name: 'Max',
    breed: 'Corgi',
    species: 'Dog',
    avatarUrl: _avatar('max'),
    ownerName: 'Jad H.',
    isFollowing: true,
    followers: 4310,
  );
  static final _cocoa = PawPet(
    id: 'cocoa',
    name: 'Cocoa',
    breed: 'Persian',
    species: 'Cat',
    avatarUrl: _avatar('cocoa'),
    ownerName: 'Lea M.',
    followers: 2150,
  );
  static final _nugget = PawPet(
    id: 'nugget',
    name: 'Nugget',
    breed: 'Holland Lop',
    species: 'Rabbit',
    avatarUrl: _avatar('nugget'),
    ownerName: 'Omar T.',
    followers: 770,
  );

  static List<PawPost> feed() => [
        PawPost(
          id: 'p1',
          author: _bella,
          media: [
            const PawMedia(
              url: 'https://picsum.photos/seed/beach1/900/1100',
              altText: 'A golden retriever running on a sunny beach',
            ),
            const PawMedia(
              url: 'https://picsum.photos/seed/beach2/900/1100',
              altText: 'The same dog shaking off water',
            ),
            const PawMedia(
              url: 'https://picsum.photos/seed/beach3/900/1100',
              isVideo: true,
              durationLabel: '0:12',
              altText: 'Slow-motion zoomies clip',
            ),
          ],
          caption:
              'Beach day was a WHOLE vibe 🌊🐾 someone please tell Bella the ocean is not a chew toy',
          timeAgo: '2h',
          hashtags: const ['beachdog', 'goldenretriever', 'zoomies'],
          taggedPets: [_max],
          locationName: 'Ramlet al-Baida, Beirut',
          likes: 342,
          likedByMe: true,
          comments: [
            PawComment(
              id: 'c1',
              author: _max,
              body: 'the third one 😭 I was RIGHT there why didn\'t you wait',
              timeAgo: '1h',
              likes: 18,
              isPinned: true,
              replies: [
                PawComment(
                  id: 'c1r1',
                  author: _bella,
                  body: 'next time bring your floaties 🦺',
                  timeAgo: '58m',
                  likes: 6,
                ),
              ],
            ),
            PawComment(
              id: 'c2',
              author: _cocoa,
              body: 'cats would NEVER but ok live your truth 💅',
              timeAgo: '44m',
              likes: 31,
            ),
          ],
        ),
        PawPost(
          id: 'p2',
          author: _max,
          media: [
            const PawMedia(
              url: 'https://picsum.photos/seed/corgi_loaf/900/900',
              altText: 'A corgi sitting like a loaf of bread',
            ),
          ],
          caption: 'achieved perfect loaf. no notes.',
          timeAgo: '5h',
          hashtags: const ['corgi', 'loaf', 'shorKing'],
          taggedPets: const [],
          locationName: 'Achrafieh',
          likes: 1205,
          comments: [
            PawComment(
              id: 'c3',
              author: _bella,
              body: 'structural integrity: immaculate',
              timeAgo: '3h',
              likes: 40,
            ),
          ],
        ),
        PawPost(
          id: 'p3',
          author: _cocoa,
          media: [
            const PawMedia(
              url: 'https://picsum.photos/seed/cat_sun/900/1000',
              altText: 'A persian cat napping in a sunbeam',
            ),
            const PawMedia(
              url: 'https://picsum.photos/seed/cat_sun2/900/1000',
              altText: 'Close-up of the cat yawning',
            ),
          ],
          caption: 'do not perceive me before noon ☀️😾',
          timeAgo: '8h',
          hashtags: const ['catsofpawhub', 'persian', 'moodforever'],
          taggedPets: const [],
          visibility: PostVisibility.followers,
          likes: 88,
          saved: true,
          isEdited: true,
          comments: const [],
        ),
        PawPost(
          id: 'p4',
          author: _nugget,
          media: [
            const PawMedia(
              url: 'https://picsum.photos/seed/bun1/900/900',
              altText: 'A holland lop rabbit mid-binky',
            ),
          ],
          caption: 'BINKY ACHIEVED 🐰✨ level up',
          timeAgo: '11h',
          hashtags: const ['rabbitsofpawhub', 'binky'],
          taggedPets: const [],
          likes: 219,
          comments: [
            PawComment(
              id: 'c4',
              author: _max,
              body: 'teach me your ways smol one',
              timeAgo: '9h',
              likes: 12,
            ),
          ],
        ),
      ];

  static const alert = PawAlert(
    petName: 'Rocky',
    breed: 'Tabby cat',
    distanceLabel: '1.2 km away',
    timeAgo: '35m',
    imageUrl: 'https://picsum.photos/seed/rocky_lost/400/400',
    reward: 100,
  );

  static List<PawPet> suggestedPets() => [_cocoa, _nugget, _bella, _max];

  static List<PawNotif> notifications() => [
        PawNotif(
          type: PawNotifType.alert,
          actor: _nugget,
          text: 'Lost cat reported 1.2 km away — Rocky, a tabby',
          timeAgo: '35m',
          thumbnailUrl: alert.imageUrl,
        ),
        PawNotif(
          type: PawNotifType.like,
          actor: _bella,
          text: 'Bella, Max & 12 others liked Milo\'s photo',
          timeAgo: '1h',
          thumbnailUrl: _img('beach1', w: 120, h: 120),
        ),
        PawNotif(
          type: PawNotifType.comment,
          actor: _max,
          text: 'Max commented: "structural integrity: immaculate"',
          timeAgo: '3h',
          thumbnailUrl: _img('corgi_loaf', w: 120, h: 120),
          isRead: true,
        ),
        PawNotif(
          type: PawNotifType.follow,
          actor: _cocoa,
          text: 'Cocoa started following Luna',
          timeAgo: '6h',
          isRead: true,
        ),
        PawNotif(
          type: PawNotifType.mention,
          actor: _bella,
          text: 'Bella mentioned Milo in a comment',
          timeAgo: '1d',
          isRead: true,
        ),
      ];

  /// A second page of posts for the infinite-scroll demo (reshuffled clones).
  static List<PawPost> morePage(int page) {
    final base = feed();
    return [
      for (var i = 0; i < base.length; i++)
        PawPost(
          id: 'p${page}_$i',
          author: base[i].author,
          media: base[i].media,
          caption: base[i].caption,
          timeAgo: '${page + 1}d',
          hashtags: base[i].hashtags,
          taggedPets: base[i].taggedPets,
          locationName: base[i].locationName,
          visibility: base[i].visibility,
          likes: base[i].likes ~/ (page + 1),
          comments: base[i].comments,
        ),
    ];
  }
}

/// Debug guard so the prototype dataset never ships silently in a real build
/// without being noticed.
@visibleForTesting
const bool kPawHubIsPrototype = true;
