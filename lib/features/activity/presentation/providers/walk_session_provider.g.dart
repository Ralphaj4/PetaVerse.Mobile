// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walk_session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(activityRepository)
final activityRepositoryProvider = ActivityRepositoryProvider._();

final class ActivityRepositoryProvider
    extends
        $FunctionalProvider<
          ActivityRepository,
          ActivityRepository,
          ActivityRepository
        >
    with $Provider<ActivityRepository> {
  ActivityRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activityRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activityRepositoryHash();

  @$internal
  @override
  $ProviderElement<ActivityRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ActivityRepository create(Ref ref) {
    return activityRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActivityRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActivityRepository>(value),
    );
  }
}

String _$activityRepositoryHash() =>
    r'9834562d9c32a0055e11200394ee196efefbe6ba';

/// null = no active walk.
///
/// GPS walks are tracked by the foreground service's own isolate (see
/// `_WalkTaskHandler`) so they survive the app being swiped away; this
/// notifier just mirrors its per-second ticks into UI state. Timer-only
/// walks (location denied → no service allowed) tick locally instead.

@ProviderFor(WalkSessionNotifier)
final walkSessionProvider = WalkSessionNotifierProvider._();

/// null = no active walk.
///
/// GPS walks are tracked by the foreground service's own isolate (see
/// `_WalkTaskHandler`) so they survive the app being swiped away; this
/// notifier just mirrors its per-second ticks into UI state. Timer-only
/// walks (location denied → no service allowed) tick locally instead.
final class WalkSessionNotifierProvider
    extends $NotifierProvider<WalkSessionNotifier, WalkSession?> {
  /// null = no active walk.
  ///
  /// GPS walks are tracked by the foreground service's own isolate (see
  /// `_WalkTaskHandler`) so they survive the app being swiped away; this
  /// notifier just mirrors its per-second ticks into UI state. Timer-only
  /// walks (location denied → no service allowed) tick locally instead.
  WalkSessionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'walkSessionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$walkSessionNotifierHash();

  @$internal
  @override
  WalkSessionNotifier create() => WalkSessionNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WalkSession? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WalkSession?>(value),
    );
  }
}

String _$walkSessionNotifierHash() =>
    r'aebc57fed554861eea44a35f9ebfdc4408cde5a4';

/// null = no active walk.
///
/// GPS walks are tracked by the foreground service's own isolate (see
/// `_WalkTaskHandler`) so they survive the app being swiped away; this
/// notifier just mirrors its per-second ticks into UI state. Timer-only
/// walks (location denied → no service allowed) tick locally instead.

abstract class _$WalkSessionNotifier extends $Notifier<WalkSession?> {
  WalkSession? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<WalkSession?, WalkSession?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WalkSession?, WalkSession?>,
              WalkSession?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(walkHistory)
final walkHistoryProvider = WalkHistoryFamily._();

final class WalkHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WalkActivity>>,
          List<WalkActivity>,
          FutureOr<List<WalkActivity>>
        >
    with
        $FutureModifier<List<WalkActivity>>,
        $FutureProvider<List<WalkActivity>> {
  WalkHistoryProvider._({
    required WalkHistoryFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'walkHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$walkHistoryHash();

  @override
  String toString() {
    return r'walkHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<WalkActivity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<WalkActivity>> create(Ref ref) {
    final argument = this.argument as int;
    return walkHistory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WalkHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$walkHistoryHash() => r'cf4244f2a51e1e556708e35d9be4df73167b468e';

final class WalkHistoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<WalkActivity>>, int> {
  WalkHistoryFamily._()
    : super(
        retry: null,
        name: r'walkHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  WalkHistoryProvider call(int petId) =>
      WalkHistoryProvider._(argument: petId, from: this);

  @override
  String toString() => r'walkHistoryProvider';
}
