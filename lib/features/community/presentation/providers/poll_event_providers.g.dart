// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_event_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The poll & event repository, wired to the shared [ApiClient].
///
/// `myPetIds` is a callback reading [PetsNotifier] so the `isMine` flag on
/// creator/attendee pets always reflects the current pet set — same pattern as
/// `communityGroupRepository`.

@ProviderFor(pollEventRepository)
final pollEventRepositoryProvider = PollEventRepositoryProvider._();

/// The poll & event repository, wired to the shared [ApiClient].
///
/// `myPetIds` is a callback reading [PetsNotifier] so the `isMine` flag on
/// creator/attendee pets always reflects the current pet set — same pattern as
/// `communityGroupRepository`.

final class PollEventRepositoryProvider
    extends
        $FunctionalProvider<
          PollEventRepository,
          PollEventRepository,
          PollEventRepository
        >
    with $Provider<PollEventRepository> {
  /// The poll & event repository, wired to the shared [ApiClient].
  ///
  /// `myPetIds` is a callback reading [PetsNotifier] so the `isMine` flag on
  /// creator/attendee pets always reflects the current pet set — same pattern as
  /// `communityGroupRepository`.
  PollEventRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pollEventRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pollEventRepositoryHash();

  @$internal
  @override
  $ProviderElement<PollEventRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PollEventRepository create(Ref ref) {
    return pollEventRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PollEventRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PollEventRepository>(value),
    );
  }
}

String _$pollEventRepositoryHash() =>
    r'bea4e6ab6f13f9d1f13de2eb29bf8f32ea67e051';

/// A community's polls. Loads page 0 on build, appends via [loadMore], and
/// exposes [replace] so a vote can update one card in place.

@ProviderFor(CommunityPolls)
final communityPollsProvider = CommunityPollsFamily._();

/// A community's polls. Loads page 0 on build, appends via [loadMore], and
/// exposes [replace] so a vote can update one card in place.
final class CommunityPollsProvider
    extends $AsyncNotifierProvider<CommunityPolls, PagedPolls> {
  /// A community's polls. Loads page 0 on build, appends via [loadMore], and
  /// exposes [replace] so a vote can update one card in place.
  CommunityPollsProvider._({
    required CommunityPollsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'communityPollsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communityPollsHash();

  @override
  String toString() {
    return r'communityPollsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CommunityPolls create() => CommunityPolls();

  @override
  bool operator ==(Object other) {
    return other is CommunityPollsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communityPollsHash() => r'38b843b52f8115849352ce8000fd3f779c247e70';

/// A community's polls. Loads page 0 on build, appends via [loadMore], and
/// exposes [replace] so a vote can update one card in place.

final class CommunityPollsFamily extends $Family
    with
        $ClassFamilyOverride<
          CommunityPolls,
          AsyncValue<PagedPolls>,
          PagedPolls,
          FutureOr<PagedPolls>,
          int
        > {
  CommunityPollsFamily._()
    : super(
        retry: null,
        name: r'communityPollsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A community's polls. Loads page 0 on build, appends via [loadMore], and
  /// exposes [replace] so a vote can update one card in place.

  CommunityPollsProvider call(int communityId) =>
      CommunityPollsProvider._(argument: communityId, from: this);

  @override
  String toString() => r'communityPollsProvider';
}

/// A community's polls. Loads page 0 on build, appends via [loadMore], and
/// exposes [replace] so a vote can update one card in place.

abstract class _$CommunityPolls extends $AsyncNotifier<PagedPolls> {
  late final _$args = ref.$arg as int;
  int get communityId => _$args;

  FutureOr<PagedPolls> build(int communityId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PagedPolls>, PagedPolls>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PagedPolls>, PagedPolls>,
              AsyncValue<PagedPolls>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// A community's events (ordered by startsAt ascending server-side).

@ProviderFor(CommunityEvents)
final communityEventsProvider = CommunityEventsFamily._();

/// A community's events (ordered by startsAt ascending server-side).
final class CommunityEventsProvider
    extends $AsyncNotifierProvider<CommunityEvents, PagedEvents> {
  /// A community's events (ordered by startsAt ascending server-side).
  CommunityEventsProvider._({
    required CommunityEventsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'communityEventsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communityEventsHash();

  @override
  String toString() {
    return r'communityEventsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CommunityEvents create() => CommunityEvents();

  @override
  bool operator ==(Object other) {
    return other is CommunityEventsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communityEventsHash() => r'c320c3b885d7efcd3a0c282712a9105d983c6f0d';

/// A community's events (ordered by startsAt ascending server-side).

final class CommunityEventsFamily extends $Family
    with
        $ClassFamilyOverride<
          CommunityEvents,
          AsyncValue<PagedEvents>,
          PagedEvents,
          FutureOr<PagedEvents>,
          int
        > {
  CommunityEventsFamily._()
    : super(
        retry: null,
        name: r'communityEventsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A community's events (ordered by startsAt ascending server-side).

  CommunityEventsProvider call(int communityId) =>
      CommunityEventsProvider._(argument: communityId, from: this);

  @override
  String toString() => r'communityEventsProvider';
}

/// A community's events (ordered by startsAt ascending server-side).

abstract class _$CommunityEvents extends $AsyncNotifier<PagedEvents> {
  late final _$args = ref.$arg as int;
  int get communityId => _$args;

  FutureOr<PagedEvents> build(int communityId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PagedEvents>, PagedEvents>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PagedEvents>, PagedEvents>,
              AsyncValue<PagedEvents>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// A single event's detail (family-keyed by id) — used by the event detail
/// page and the attendees list.

@ProviderFor(EventDetail)
final eventDetailProvider = EventDetailFamily._();

/// A single event's detail (family-keyed by id) — used by the event detail
/// page and the attendees list.
final class EventDetailProvider
    extends $AsyncNotifierProvider<EventDetail, CommunityEvent> {
  /// A single event's detail (family-keyed by id) — used by the event detail
  /// page and the attendees list.
  EventDetailProvider._({
    required EventDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'eventDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventDetailHash();

  @override
  String toString() {
    return r'eventDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EventDetail create() => EventDetail();

  @override
  bool operator ==(Object other) {
    return other is EventDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventDetailHash() => r'a3b4960f53f2ed096baf751e08712210ed47abac';

/// A single event's detail (family-keyed by id) — used by the event detail
/// page and the attendees list.

final class EventDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          EventDetail,
          AsyncValue<CommunityEvent>,
          CommunityEvent,
          FutureOr<CommunityEvent>,
          int
        > {
  EventDetailFamily._()
    : super(
        retry: null,
        name: r'eventDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A single event's detail (family-keyed by id) — used by the event detail
  /// page and the attendees list.

  EventDetailProvider call(int eventId) =>
      EventDetailProvider._(argument: eventId, from: this);

  @override
  String toString() => r'eventDetailProvider';
}

/// A single event's detail (family-keyed by id) — used by the event detail
/// page and the attendees list.

abstract class _$EventDetail extends $AsyncNotifier<CommunityEvent> {
  late final _$args = ref.$arg as int;
  int get eventId => _$args;

  FutureOr<CommunityEvent> build(int eventId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CommunityEvent>, CommunityEvent>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CommunityEvent>, CommunityEvent>,
              AsyncValue<CommunityEvent>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// An event's attendees (family-keyed by id). Throws on failure so the page can
/// show an error state with retry.

@ProviderFor(eventAttendees)
final eventAttendeesProvider = EventAttendeesFamily._();

/// An event's attendees (family-keyed by id). Throws on failure so the page can
/// show an error state with retry.

final class EventAttendeesProvider
    extends
        $FunctionalProvider<
          AsyncValue<EventAttendeePage>,
          EventAttendeePage,
          FutureOr<EventAttendeePage>
        >
    with
        $FutureModifier<EventAttendeePage>,
        $FutureProvider<EventAttendeePage> {
  /// An event's attendees (family-keyed by id). Throws on failure so the page can
  /// show an error state with retry.
  EventAttendeesProvider._({
    required EventAttendeesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'eventAttendeesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventAttendeesHash();

  @override
  String toString() {
    return r'eventAttendeesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EventAttendeePage> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EventAttendeePage> create(Ref ref) {
    final argument = this.argument as int;
    return eventAttendees(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EventAttendeesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventAttendeesHash() => r'a806f9be717ef1793e150c8f67886ac6eb4477b1';

/// An event's attendees (family-keyed by id). Throws on failure so the page can
/// show an error state with retry.

final class EventAttendeesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<EventAttendeePage>, int> {
  EventAttendeesFamily._()
    : super(
        retry: null,
        name: r'eventAttendeesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// An event's attendees (family-keyed by id). Throws on failure so the page can
  /// show an error state with retry.

  EventAttendeesProvider call(int eventId) =>
      EventAttendeesProvider._(argument: eventId, from: this);

  @override
  String toString() => r'eventAttendeesProvider';
}
