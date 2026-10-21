import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasources/community_remote_datasource.dart';
import '../../domain/entities/community_enums.dart';

part 'community_impressions_provider.g.dart';

/// Thin provider over the shared remote datasource, used by the impression
/// tracker so it doesn't have to reach through the repository (impressions are
/// fire-and-forget and don't use the Result/Failure pipeline).
@Riverpod(keepAlive: true)
CommunityRemoteDataSource communityRemoteDataSource(Ref ref) =>
    CommunityRemoteDataSource(ref.watch(apiClientProvider));

/// Debounced, de-duplicated post-impression reporter for the Discover feed.
///
/// Call [record] as a card becomes meaningfully visible. The tracker:
///   * de-dupes per session (a post is reported at most once per surface),
///   * buffers and flushes on a debounce ([_flushDelay]) or when the buffer
///     reaches [_batchThreshold],
///   * caps a batch at [_maxBatch] items (the server caps anyway),
///   * swallows every error - an impression failure must never surface.
///
/// keepAlive so the seen-set survives feed rebuilds (pull-to-refresh, pet
/// switch) within a session; a fresh app launch starts a clean session.
@Riverpod(keepAlive: true)
class ImpressionTracker extends _$ImpressionTracker {
  static const Duration _flushDelay = Duration(seconds: 2);
  static const int _batchThreshold = 20;
  static const int _maxBatch = 200;

  /// Keys already reported this session, so a card wobbling in and out of view
  /// is never re-reported. Key = "petId:surface:postId".
  final Set<String> _seen = {};

  /// Pending (not-yet-flushed) impressions, keyed the same way to collapse any
  /// duplicates that slip in before a flush.
  final Map<String, _PendingImpression> _pending = {};

  Timer? _debounce;

  @override
  void build() {
    // Flush whatever is buffered if this provider is ever disposed.
    ref.onDispose(() {
      _debounce?.cancel();
      unawaited(_flush());
    });
  }

  /// Records that [postId] was seen on [surface] by [petId] (null → server uses
  /// the caller's first pet). No-op if already seen this session.
  void record({
    required int postId,
    int? petId,
    ImpressionSurface surface = ImpressionSurface.discover,
  }) {
    final key = '${petId ?? 0}:${surface.wire}:$postId';
    if (_seen.contains(key)) return;
    _seen.add(key);
    _pending[key] = _PendingImpression(
      postId: postId,
      petId: petId,
      surface: surface.wire,
    );

    if (_pending.length >= _batchThreshold) {
      _debounce?.cancel();
      unawaited(_flush());
    } else {
      _debounce?.cancel();
      _debounce = Timer(_flushDelay, () => unawaited(_flush()));
    }
  }

  Future<void> _flush() async {
    if (_pending.isEmpty) return;
    final batch = _pending.values.take(_maxBatch).toList();
    // Only clear the slice we're sending; anything beyond _maxBatch stays queued
    // for the next flush.
    for (final imp in batch) {
      _pending.remove('${imp.petId ?? 0}:${imp.surface}:${imp.postId}');
    }

    // Group by petId so each call carries a single acting pet (the API takes one
    // petId per request). In practice the whole batch shares one pet.
    final byPet = <int?, List<_PendingImpression>>{};
    for (final imp in batch) {
      byPet.putIfAbsent(imp.petId, () => []).add(imp);
    }

    final ds = ref.read(communityRemoteDataSourceProvider);
    for (final entry in byPet.entries) {
      try {
        await ds.reportImpressions(
          petId: entry.key,
          items: [
            for (final imp in entry.value)
              {'postId': imp.postId, 'surface': imp.surface},
          ],
        );
      } catch (_) {
        // Best-effort: drop silently. Already removed from _pending above and
        // kept in _seen, so we don't retry (impressions are low-value, high-
        // volume - losing a few is fine).
      }
    }
  }
}

class _PendingImpression {
  const _PendingImpression({
    required this.postId,
    required this.petId,
    required this.surface,
  });

  final int postId;
  final int? petId;
  final int surface;
}
