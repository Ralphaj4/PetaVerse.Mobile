// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_prefs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationPrefsStore)
final notificationPrefsStoreProvider = NotificationPrefsStoreProvider._();

final class NotificationPrefsStoreProvider
    extends
        $FunctionalProvider<
          NotificationPrefsStore,
          NotificationPrefsStore,
          NotificationPrefsStore
        >
    with $Provider<NotificationPrefsStore> {
  NotificationPrefsStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPrefsStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationPrefsStoreHash();

  @$internal
  @override
  $ProviderElement<NotificationPrefsStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationPrefsStore create(Ref ref) {
    return notificationPrefsStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationPrefsStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationPrefsStore>(value),
    );
  }
}

String _$notificationPrefsStoreHash() =>
    r'11063957a26e2bcb643f2284a412fa550daec88d';

@ProviderFor(notificationPrefsRemoteDataSource)
final notificationPrefsRemoteDataSourceProvider =
    NotificationPrefsRemoteDataSourceProvider._();

final class NotificationPrefsRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          NotificationPrefsRemoteDataSource,
          NotificationPrefsRemoteDataSource,
          NotificationPrefsRemoteDataSource
        >
    with $Provider<NotificationPrefsRemoteDataSource> {
  NotificationPrefsRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPrefsRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$notificationPrefsRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<NotificationPrefsRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationPrefsRemoteDataSource create(Ref ref) {
    return notificationPrefsRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationPrefsRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationPrefsRemoteDataSource>(
        value,
      ),
    );
  }
}

String _$notificationPrefsRemoteDataSourceHash() =>
    r'12685577a3adf3cc7118d28418303093b8132bf3';

/// Live map of all notification preferences. keepAlive so every consumer
/// (FCM handler, notification service, settings page) shares one instance.
///
/// Build order:
///   1. Read Hive immediately → UI shows instantly with cached values.
///   2. Fetch from API in the background → overwrite Hive + state.

@ProviderFor(NotificationPrefsNotifier)
final notificationPrefsProvider = NotificationPrefsNotifierProvider._();

/// Live map of all notification preferences. keepAlive so every consumer
/// (FCM handler, notification service, settings page) shares one instance.
///
/// Build order:
///   1. Read Hive immediately → UI shows instantly with cached values.
///   2. Fetch from API in the background → overwrite Hive + state.
final class NotificationPrefsNotifierProvider
    extends
        $AsyncNotifierProvider<NotificationPrefsNotifier, Map<String, bool>> {
  /// Live map of all notification preferences. keepAlive so every consumer
  /// (FCM handler, notification service, settings page) shares one instance.
  ///
  /// Build order:
  ///   1. Read Hive immediately → UI shows instantly with cached values.
  ///   2. Fetch from API in the background → overwrite Hive + state.
  NotificationPrefsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPrefsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationPrefsNotifierHash();

  @$internal
  @override
  NotificationPrefsNotifier create() => NotificationPrefsNotifier();
}

String _$notificationPrefsNotifierHash() =>
    r'd4f0c642874db958980b3a7095b18a81a9665b17';

/// Live map of all notification preferences. keepAlive so every consumer
/// (FCM handler, notification service, settings page) shares one instance.
///
/// Build order:
///   1. Read Hive immediately → UI shows instantly with cached values.
///   2. Fetch from API in the background → overwrite Hive + state.

abstract class _$NotificationPrefsNotifier
    extends $AsyncNotifier<Map<String, bool>> {
  FutureOr<Map<String, bool>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<Map<String, bool>>, Map<String, bool>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Map<String, bool>>, Map<String, bool>>,
              AsyncValue<Map<String, bool>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
