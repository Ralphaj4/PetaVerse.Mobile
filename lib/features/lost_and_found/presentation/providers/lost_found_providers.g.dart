// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lost_found_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(lostFoundRepository)
final lostFoundRepositoryProvider = LostFoundRepositoryProvider._();

final class LostFoundRepositoryProvider
    extends
        $FunctionalProvider<
          LostFoundRepository,
          LostFoundRepository,
          LostFoundRepository
        >
    with $Provider<LostFoundRepository> {
  LostFoundRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lostFoundRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lostFoundRepositoryHash();

  @$internal
  @override
  $ProviderElement<LostFoundRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LostFoundRepository create(Ref ref) {
    return lostFoundRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LostFoundRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LostFoundRepository>(value),
    );
  }
}

String _$lostFoundRepositoryHash() =>
    r'1ca41df0ea6959502dc53e424d9c9c3470071992';

/// Loads a single report by id for the details screen. Auto-disposes so each
/// visit fetches fresh data; the details page seeds the UI from the tapped
/// alert while this resolves.

@ProviderFor(reportDetail)
final reportDetailProvider = ReportDetailFamily._();

/// Loads a single report by id for the details screen. Auto-disposes so each
/// visit fetches fresh data; the details page seeds the UI from the tapped
/// alert while this resolves.

final class ReportDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<LostFoundReport>,
          LostFoundReport,
          FutureOr<LostFoundReport>
        >
    with $FutureModifier<LostFoundReport>, $FutureProvider<LostFoundReport> {
  /// Loads a single report by id for the details screen. Auto-disposes so each
  /// visit fetches fresh data; the details page seeds the UI from the tapped
  /// alert while this resolves.
  ReportDetailProvider._({
    required ReportDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'reportDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$reportDetailHash();

  @override
  String toString() {
    return r'reportDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<LostFoundReport> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LostFoundReport> create(Ref ref) {
    final argument = this.argument as int;
    return reportDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ReportDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$reportDetailHash() => r'aa5ce4707f751ae375502f0038a4a94b7b8fe833';

/// Loads a single report by id for the details screen. Auto-disposes so each
/// visit fetches fresh data; the details page seeds the UI from the tapped
/// alert while this resolves.

final class ReportDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<LostFoundReport>, int> {
  ReportDetailFamily._()
    : super(
        retry: null,
        name: r'reportDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Loads a single report by id for the details screen. Auto-disposes so each
  /// visit fetches fresh data; the details page seeds the UI from the tapped
  /// alert while this resolves.

  ReportDetailProvider call(int id) =>
      ReportDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'reportDetailProvider';
}

@ProviderFor(LostFoundFilterNotifier)
final lostFoundFilterProvider = LostFoundFilterNotifierProvider._();

final class LostFoundFilterNotifierProvider
    extends $NotifierProvider<LostFoundFilterNotifier, LostFoundFilter> {
  LostFoundFilterNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lostFoundFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lostFoundFilterNotifierHash();

  @$internal
  @override
  LostFoundFilterNotifier create() => LostFoundFilterNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LostFoundFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LostFoundFilter>(value),
    );
  }
}

String _$lostFoundFilterNotifierHash() =>
    r'4b080d8cd42260258cfc3ae07f479456a54ec830';

abstract class _$LostFoundFilterNotifier extends $Notifier<LostFoundFilter> {
  LostFoundFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LostFoundFilter, LostFoundFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LostFoundFilter, LostFoundFilter>,
              LostFoundFilter,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Loads the dashboard for the device location and current filter. Re-runs
/// when the filter changes. Falls back to [kLostFoundFallbackCenter] when the
/// device location is unavailable so the screen still renders.

@ProviderFor(LostFoundDashboardNotifier)
final lostFoundDashboardProvider = LostFoundDashboardNotifierProvider._();

/// Loads the dashboard for the device location and current filter. Re-runs
/// when the filter changes. Falls back to [kLostFoundFallbackCenter] when the
/// device location is unavailable so the screen still renders.
final class LostFoundDashboardNotifierProvider
    extends
        $AsyncNotifierProvider<LostFoundDashboardNotifier, LostFoundDashboard> {
  /// Loads the dashboard for the device location and current filter. Re-runs
  /// when the filter changes. Falls back to [kLostFoundFallbackCenter] when the
  /// device location is unavailable so the screen still renders.
  LostFoundDashboardNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lostFoundDashboardProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lostFoundDashboardNotifierHash();

  @$internal
  @override
  LostFoundDashboardNotifier create() => LostFoundDashboardNotifier();
}

String _$lostFoundDashboardNotifierHash() =>
    r'71d6cd39e7522457c4db2f8f29e112c8c04d7bc4';

/// Loads the dashboard for the device location and current filter. Re-runs
/// when the filter changes. Falls back to [kLostFoundFallbackCenter] when the
/// device location is unavailable so the screen still renders.

abstract class _$LostFoundDashboardNotifier
    extends $AsyncNotifier<LostFoundDashboard> {
  FutureOr<LostFoundDashboard> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<LostFoundDashboard>, LostFoundDashboard>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LostFoundDashboard>, LostFoundDashboard>,
              AsyncValue<LostFoundDashboard>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Volunteer join/leave actions. The AsyncValue carries the in-flight state.
///
/// `keepAlive` is REQUIRED: these methods set `state = AsyncLoading()` then
/// await the network. As an auto-dispose notifier with no listeners (the page
/// only `ref.read`s it), it would be disposed mid-await and the returned Future
/// would never complete — hanging the caller. Keeping it alive avoids that.

@ProviderFor(VolunteerActions)
final volunteerActionsProvider = VolunteerActionsProvider._();

/// Volunteer join/leave actions. The AsyncValue carries the in-flight state.
///
/// `keepAlive` is REQUIRED: these methods set `state = AsyncLoading()` then
/// await the network. As an auto-dispose notifier with no listeners (the page
/// only `ref.read`s it), it would be disposed mid-await and the returned Future
/// would never complete — hanging the caller. Keeping it alive avoids that.
final class VolunteerActionsProvider
    extends $AsyncNotifierProvider<VolunteerActions, void> {
  /// Volunteer join/leave actions. The AsyncValue carries the in-flight state.
  ///
  /// `keepAlive` is REQUIRED: these methods set `state = AsyncLoading()` then
  /// await the network. As an auto-dispose notifier with no listeners (the page
  /// only `ref.read`s it), it would be disposed mid-await and the returned Future
  /// would never complete — hanging the caller. Keeping it alive avoids that.
  VolunteerActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'volunteerActionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$volunteerActionsHash();

  @$internal
  @override
  VolunteerActions create() => VolunteerActions();
}

String _$volunteerActionsHash() => r'055350333fbd02981e756d4678d16c2c56816ddb';

/// Volunteer join/leave actions. The AsyncValue carries the in-flight state.
///
/// `keepAlive` is REQUIRED: these methods set `state = AsyncLoading()` then
/// await the network. As an auto-dispose notifier with no listeners (the page
/// only `ref.read`s it), it would be disposed mid-await and the returned Future
/// would never complete — hanging the caller. Keeping it alive avoids that.

abstract class _$VolunteerActions extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Creates a lost report. The AsyncValue carries loading + the last [Failure]
/// (for a spinner and a localized error); [create] returns the new report on
/// success (null on failure). On success the dashboard is invalidated so the
/// new alert appears.
///
/// `keepAlive` so the notifier isn't auto-disposed mid-await (which would hang
/// the returned Future) — see [VolunteerActions].

@ProviderFor(CreateReport)
final createReportProvider = CreateReportProvider._();

/// Creates a lost report. The AsyncValue carries loading + the last [Failure]
/// (for a spinner and a localized error); [create] returns the new report on
/// success (null on failure). On success the dashboard is invalidated so the
/// new alert appears.
///
/// `keepAlive` so the notifier isn't auto-disposed mid-await (which would hang
/// the returned Future) — see [VolunteerActions].
final class CreateReportProvider
    extends $AsyncNotifierProvider<CreateReport, void> {
  /// Creates a lost report. The AsyncValue carries loading + the last [Failure]
  /// (for a spinner and a localized error); [create] returns the new report on
  /// success (null on failure). On success the dashboard is invalidated so the
  /// new alert appears.
  ///
  /// `keepAlive` so the notifier isn't auto-disposed mid-await (which would hang
  /// the returned Future) — see [VolunteerActions].
  CreateReportProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createReportProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createReportHash();

  @$internal
  @override
  CreateReport create() => CreateReport();
}

String _$createReportHash() => r'384acd5615893d6fbffb4bb2e34a9bfac204d945';

/// Creates a lost report. The AsyncValue carries loading + the last [Failure]
/// (for a spinner and a localized error); [create] returns the new report on
/// success (null on failure). On success the dashboard is invalidated so the
/// new alert appears.
///
/// `keepAlive` so the notifier isn't auto-disposed mid-await (which would hang
/// the returned Future) — see [VolunteerActions].

abstract class _$CreateReport extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Deletes the user's own report. Returns true on success; on success the
/// dashboard is invalidated so the deleted alert disappears.
///
/// `keepAlive` so the notifier isn't auto-disposed mid-await — see
/// [VolunteerActions].

@ProviderFor(DeleteReport)
final deleteReportProvider = DeleteReportProvider._();

/// Deletes the user's own report. Returns true on success; on success the
/// dashboard is invalidated so the deleted alert disappears.
///
/// `keepAlive` so the notifier isn't auto-disposed mid-await — see
/// [VolunteerActions].
final class DeleteReportProvider
    extends $AsyncNotifierProvider<DeleteReport, void> {
  /// Deletes the user's own report. Returns true on success; on success the
  /// dashboard is invalidated so the deleted alert disappears.
  ///
  /// `keepAlive` so the notifier isn't auto-disposed mid-await — see
  /// [VolunteerActions].
  DeleteReportProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteReportProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteReportHash();

  @$internal
  @override
  DeleteReport create() => DeleteReport();
}

String _$deleteReportHash() => r'52586fa054f28144cc10d0b2fabf4bdcb6747ef0';

/// Deletes the user's own report. Returns true on success; on success the
/// dashboard is invalidated so the deleted alert disappears.
///
/// `keepAlive` so the notifier isn't auto-disposed mid-await — see
/// [VolunteerActions].

abstract class _$DeleteReport extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
