// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_event_actions_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Write actions for community polls & events (create poll, vote, create/update
/// event, RSVP). Thin wrapper over [PollEventRepository] that emits the
/// analytics event on success, so each event fires in exactly one place no
/// matter which screen triggers the action. Mirrors [CommunityGroupActions].
///
/// Read as a plain object (`ref.read(pollEventActionsProvider)`); holds no
/// state. Reads/mutations of the loaded lists still go through the list
/// notifiers at the call site — this only owns the repo call + analytics.

@ProviderFor(pollEventActions)
final pollEventActionsProvider = PollEventActionsProvider._();

/// Write actions for community polls & events (create poll, vote, create/update
/// event, RSVP). Thin wrapper over [PollEventRepository] that emits the
/// analytics event on success, so each event fires in exactly one place no
/// matter which screen triggers the action. Mirrors [CommunityGroupActions].
///
/// Read as a plain object (`ref.read(pollEventActionsProvider)`); holds no
/// state. Reads/mutations of the loaded lists still go through the list
/// notifiers at the call site — this only owns the repo call + analytics.

final class PollEventActionsProvider
    extends
        $FunctionalProvider<
          PollEventActions,
          PollEventActions,
          PollEventActions
        >
    with $Provider<PollEventActions> {
  /// Write actions for community polls & events (create poll, vote, create/update
  /// event, RSVP). Thin wrapper over [PollEventRepository] that emits the
  /// analytics event on success, so each event fires in exactly one place no
  /// matter which screen triggers the action. Mirrors [CommunityGroupActions].
  ///
  /// Read as a plain object (`ref.read(pollEventActionsProvider)`); holds no
  /// state. Reads/mutations of the loaded lists still go through the list
  /// notifiers at the call site — this only owns the repo call + analytics.
  PollEventActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pollEventActionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pollEventActionsHash();

  @$internal
  @override
  $ProviderElement<PollEventActions> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PollEventActions create(Ref ref) {
    return pollEventActions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PollEventActions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PollEventActions>(value),
    );
  }
}

String _$pollEventActionsHash() => r'248ad14f6473a5b06ad593f1fd231c5fdd84a70e';
