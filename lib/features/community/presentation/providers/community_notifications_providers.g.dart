// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_notifications_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The community notifications list ("the bell"). [NotificationPage.unreadCount]
/// is the badge total. Offline-first: page 0 falls back to the Hive cache.

@ProviderFor(CommunityNotifications)
final communityNotificationsProvider = CommunityNotificationsProvider._();

/// The community notifications list ("the bell"). [NotificationPage.unreadCount]
/// is the badge total. Offline-first: page 0 falls back to the Hive cache.
final class CommunityNotificationsProvider
    extends $AsyncNotifierProvider<CommunityNotifications, NotificationPage> {
  /// The community notifications list ("the bell"). [NotificationPage.unreadCount]
  /// is the badge total. Offline-first: page 0 falls back to the Hive cache.
  CommunityNotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communityNotificationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communityNotificationsHash();

  @$internal
  @override
  CommunityNotifications create() => CommunityNotifications();
}

String _$communityNotificationsHash() =>
    r'c5045fb430ef2012e23aa419cb6c4d2fa4dc2b4d';

/// The community notifications list ("the bell"). [NotificationPage.unreadCount]
/// is the badge total. Offline-first: page 0 falls back to the Hive cache.

abstract class _$CommunityNotifications
    extends $AsyncNotifier<NotificationPage> {
  FutureOr<NotificationPage> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<NotificationPage>, NotificationPage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NotificationPage>, NotificationPage>,
              AsyncValue<NotificationPage>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The bell badge count on its own — the number of unread notifications for the
/// acting pet. Reads through the notifications page so it stays live.

@ProviderFor(communityUnreadCount)
final communityUnreadCountProvider = CommunityUnreadCountProvider._();

/// The bell badge count on its own — the number of unread notifications for the
/// acting pet. Reads through the notifications page so it stays live.

final class CommunityUnreadCountProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// The bell badge count on its own — the number of unread notifications for the
  /// acting pet. Reads through the notifications page so it stays live.
  CommunityUnreadCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communityUnreadCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communityUnreadCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return communityUnreadCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$communityUnreadCountHash() =>
    r'1c9566fb5a341527c1ee8677d79c1b495bbf001f';
