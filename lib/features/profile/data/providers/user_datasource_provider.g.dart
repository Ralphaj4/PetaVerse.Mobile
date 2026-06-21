// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_datasource_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userDatasource)
final userDatasourceProvider = UserDatasourceProvider._();

final class UserDatasourceProvider
    extends
        $FunctionalProvider<IUserDatasource, IUserDatasource, IUserDatasource>
    with $Provider<IUserDatasource> {
  UserDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userDatasourceHash();

  @$internal
  @override
  $ProviderElement<IUserDatasource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IUserDatasource create(Ref ref) {
    return userDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IUserDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IUserDatasource>(value),
    );
  }
}

String _$userDatasourceHash() => r'd44c7efcc2d01f515f9e6069ed9d7422e07b3055';
