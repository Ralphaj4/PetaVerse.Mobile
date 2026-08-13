import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../data/datasources/poll_event_remote_datasource.dart';
import '../../data/repositories/poll_event_repository_impl.dart';
import '../../domain/entities/community_entities.dart' show PageCursor;
import '../../domain/entities/poll_event_entities.dart';
import '../../domain/repositories/poll_event_repository.dart';
import 'community_providers.dart';

part 'poll_event_providers.g.dart';

/// The poll & event repository, wired to the shared [ApiClient].
///
/// `myPetIds` is a callback reading [PetsNotifier] so the `isMine` flag on
/// creator/attendee pets always reflects the current pet set — same pattern as
/// `communityGroupRepository`.
@Riverpod(keepAlive: true)
PollEventRepository pollEventRepository(Ref ref) {
  return PollEventRepositoryImpl(
    PollEventRemoteDataSource(ref.watch(apiClientProvider)),
    () => ref.read(petsProvider).refs.map((r) => r.id).toSet(),
  );
}

// ── Polls ────────────────────────────────────────────────────────────────────

/// Accumulated poll list for a community: polls loaded so far + paging cursor +
/// a footer "loading more" flag.
class PagedPolls {
  const PagedPolls({
    required this.polls,
    required this.cursor,
    this.loadingMore = false,
  });

  final List<Poll> polls;
  final PageCursor cursor;
  final bool loadingMore;

  bool get hasMore => cursor.hasMore;

  PagedPolls copyWith({
    List<Poll>? polls,
    PageCursor? cursor,
    bool? loadingMore,
  }) =>
      PagedPolls(
        polls: polls ?? this.polls,
        cursor: cursor ?? this.cursor,
        loadingMore: loadingMore ?? this.loadingMore,
      );
}

/// A community's polls. Loads page 0 on build, appends via [loadMore], and
/// exposes [replace] so a vote can update one card in place.
@riverpod
class CommunityPolls extends _$CommunityPolls {
  @override
  Future<PagedPolls> build(int communityId) async {
    final result = await ref.read(pollEventRepositoryProvider).getPolls(
          communityId: communityId,
          actingPetId: ref.watch(actingPetIdProvider),
        );
    final page = result.when(success: (p) => p, failure: (f) => throw f);
    return PagedPolls(polls: page.polls, cursor: page.cursor);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.loadingMore) return;
    state = AsyncData(current.copyWith(loadingMore: true));
    final result = await ref.read(pollEventRepositoryProvider).getPolls(
          communityId: communityId,
          actingPetId: ref.read(actingPetIdProvider),
          page: current.cursor.nextPage ?? 0,
        );
    result.when(
      success: (page) => state = AsyncData(
        current.copyWith(
          polls: [...current.polls, ...page.polls],
          cursor: page.cursor,
          loadingMore: false,
        ),
      ),
      failure: (_) => state = AsyncData(current.copyWith(loadingMore: false)),
    );
  }

  /// Replaces a poll in place after a vote / retract so the card reflects the
  /// fresh counts without a full refetch.
  void replace(Poll updated) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        polls: [
          for (final p in current.polls) p.id == updated.id ? updated : p,
        ],
      ),
    );
  }

  /// Removes a poll from the loaded list (after delete).
  void remove(int pollId) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        polls: current.polls.where((p) => p.id != pollId).toList(),
      ),
    );
  }

  /// Prepends a freshly-created poll.
  void prepend(Poll poll) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(polls: [poll, ...current.polls]));
  }
}

// ── Events ───────────────────────────────────────────────────────────────────

/// Accumulated event list for a community.
class PagedEvents {
  const PagedEvents({
    required this.events,
    required this.cursor,
    this.loadingMore = false,
  });

  final List<CommunityEvent> events;
  final PageCursor cursor;
  final bool loadingMore;

  bool get hasMore => cursor.hasMore;

  PagedEvents copyWith({
    List<CommunityEvent>? events,
    PageCursor? cursor,
    bool? loadingMore,
  }) =>
      PagedEvents(
        events: events ?? this.events,
        cursor: cursor ?? this.cursor,
        loadingMore: loadingMore ?? this.loadingMore,
      );
}

/// A community's events (ordered by startsAt ascending server-side).
@riverpod
class CommunityEvents extends _$CommunityEvents {
  @override
  Future<PagedEvents> build(int communityId) async {
    final result = await ref.read(pollEventRepositoryProvider).getEvents(
          communityId: communityId,
          actingPetId: ref.watch(actingPetIdProvider),
        );
    final page = result.when(success: (p) => p, failure: (f) => throw f);
    return PagedEvents(events: page.events, cursor: page.cursor);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.loadingMore) return;
    state = AsyncData(current.copyWith(loadingMore: true));
    final result = await ref.read(pollEventRepositoryProvider).getEvents(
          communityId: communityId,
          actingPetId: ref.read(actingPetIdProvider),
          page: current.cursor.nextPage ?? 0,
        );
    result.when(
      success: (page) => state = AsyncData(
        current.copyWith(
          events: [...current.events, ...page.events],
          cursor: page.cursor,
          loadingMore: false,
        ),
      ),
      failure: (_) => state = AsyncData(current.copyWith(loadingMore: false)),
    );
  }

  /// Replaces an event in place after an RSVP / edit.
  void replace(CommunityEvent updated) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        events: [
          for (final e in current.events) e.id == updated.id ? updated : e,
        ],
      ),
    );
  }

  void remove(int eventId) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        events: current.events.where((e) => e.id != eventId).toList(),
      ),
    );
  }

  void prepend(CommunityEvent event) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(events: [event, ...current.events]));
  }
}

/// A single event's detail (family-keyed by id) — used by the event detail
/// page and the attendees list.
@riverpod
class EventDetail extends _$EventDetail {
  @override
  Future<CommunityEvent> build(int eventId) async {
    final result = await ref.read(pollEventRepositoryProvider).getEvent(
          eventId: eventId,
          actingPetId: ref.watch(actingPetIdProvider),
        );
    return result.when(success: (e) => e, failure: (f) => throw f);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  void set(CommunityEvent event) => state = AsyncData(event);
}

/// An event's attendees (family-keyed by id). Throws on failure so the page can
/// show an error state with retry.
@riverpod
Future<EventAttendeePage> eventAttendees(Ref ref, int eventId) async {
  final result = await ref
      .read(pollEventRepositoryProvider)
      .getAttendees(eventId: eventId);
  return result.when(success: (p) => p, failure: (f) => throw f);
}
