// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationRepository)
final notificationRepositoryProvider = NotificationRepositoryProvider._();

final class NotificationRepositoryProvider
    extends
        $FunctionalProvider<
          NotificationRepository,
          NotificationRepository,
          NotificationRepository
        >
    with $Provider<NotificationRepository> {
  NotificationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotificationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationRepository create(Ref ref) {
    return notificationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationRepository>(value),
    );
  }
}

String _$notificationRepositoryHash() =>
    r'2a2f1c31686b01ece0d8222b8ad2e58573a13d4f';

/// Badge count for the bell icon. Kept alive so it persists across tabs.
/// Invalidate after markRead / markAllRead.

@ProviderFor(notificationUnreadCount)
final notificationUnreadCountProvider = NotificationUnreadCountProvider._();

/// Badge count for the bell icon. Kept alive so it persists across tabs.
/// Invalidate after markRead / markAllRead.

final class NotificationUnreadCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Badge count for the bell icon. Kept alive so it persists across tabs.
  /// Invalidate after markRead / markAllRead.
  NotificationUnreadCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationUnreadCountProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationUnreadCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return notificationUnreadCount(ref);
  }
}

String _$notificationUnreadCountHash() =>
    r'c28f394a7eb7d4b9f2e6c3c4a1756e574e421a07';

/// Paginated notification list. Managed by [NotificationListNotifier] so
/// the page can append items and optimistically flip isRead flags.

@ProviderFor(NotificationList)
final notificationListProvider = NotificationListProvider._();

/// Paginated notification list. Managed by [NotificationListNotifier] so
/// the page can append items and optimistically flip isRead flags.
final class NotificationListProvider
    extends $AsyncNotifierProvider<NotificationList, List<AppNotification>> {
  /// Paginated notification list. Managed by [NotificationListNotifier] so
  /// the page can append items and optimistically flip isRead flags.
  NotificationListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationListHash();

  @$internal
  @override
  NotificationList create() => NotificationList();
}

String _$notificationListHash() => r'c01d5868c23565d6806effe0d80bd638a59977ce';

/// Paginated notification list. Managed by [NotificationListNotifier] so
/// the page can append items and optimistically flip isRead flags.

abstract class _$NotificationList
    extends $AsyncNotifier<List<AppNotification>> {
  FutureOr<List<AppNotification>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<AppNotification>>, List<AppNotification>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AppNotification>>,
                List<AppNotification>
              >,
              AsyncValue<List<AppNotification>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Convenience selector — true while more pages are available.

@ProviderFor(notificationHasMore)
final notificationHasMoreProvider = NotificationHasMoreProvider._();

/// Convenience selector — true while more pages are available.

final class NotificationHasMoreProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Convenience selector — true while more pages are available.
  NotificationHasMoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationHasMoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationHasMoreHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return notificationHasMore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$notificationHasMoreHash() =>
    r'6e4901ccb4e11089ac3fc6a2cdbf9aced3f2de31';

/// Convenience selector — true while a page is being fetched.

@ProviderFor(notificationIsLoadingMore)
final notificationIsLoadingMoreProvider = NotificationIsLoadingMoreProvider._();

/// Convenience selector — true while a page is being fetched.

final class NotificationIsLoadingMoreProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Convenience selector — true while a page is being fetched.
  NotificationIsLoadingMoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationIsLoadingMoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationIsLoadingMoreHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return notificationIsLoadingMore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$notificationIsLoadingMoreHash() =>
    r'de293757d14a30b8d825813b3b4977e6f8f0f744';
