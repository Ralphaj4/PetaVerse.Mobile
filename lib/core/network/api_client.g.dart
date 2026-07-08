// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// App-wide auth event bus. The [ApiClient]'s interceptor emits on it when a
/// session dies; the session gate listens and redirects to login.

@ProviderFor(authEvents)
final authEventsProvider = AuthEventsProvider._();

/// App-wide auth event bus. The [ApiClient]'s interceptor emits on it when a
/// session dies; the session gate listens and redirects to login.

final class AuthEventsProvider
    extends $FunctionalProvider<AuthEvents, AuthEvents, AuthEvents>
    with $Provider<AuthEvents> {
  /// App-wide auth event bus. The [ApiClient]'s interceptor emits on it when a
  /// session dies; the session gate listens and redirects to login.
  AuthEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authEventsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authEventsHash();

  @$internal
  @override
  $ProviderElement<AuthEvents> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthEvents create(Ref ref) {
    return authEvents(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthEvents value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthEvents>(value),
    );
  }
}

String _$authEventsHash() => r'69826f28c010bef837672f24901439e4dc4eca9e';

@ProviderFor(apiClient)
final apiClientProvider = ApiClientProvider._();

final class ApiClientProvider
    extends $FunctionalProvider<ApiClient, ApiClient, ApiClient>
    with $Provider<ApiClient> {
  ApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiClientHash();

  @$internal
  @override
  $ProviderElement<ApiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiClient create(Ref ref) {
    return apiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiClient>(value),
    );
  }
}

String _$apiClientHash() => r'65ed8fbe35b9c2fc2874634df0131115238ce751';

@ProviderFor(loggerService)
final loggerServiceProvider = LoggerServiceProvider._();

final class LoggerServiceProvider
    extends $FunctionalProvider<LoggerService, LoggerService, LoggerService>
    with $Provider<LoggerService> {
  LoggerServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loggerServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loggerServiceHash();

  @$internal
  @override
  $ProviderElement<LoggerService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LoggerService create(Ref ref) {
    return loggerService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoggerService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoggerService>(value),
    );
  }
}

String _$loggerServiceHash() => r'9e87c3f31e269e3482ec6f9d230b53178d1f236a';
