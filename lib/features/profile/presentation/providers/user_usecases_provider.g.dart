// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_usecases_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getCachedUserProfileUsecase)
final getCachedUserProfileUsecaseProvider =
    GetCachedUserProfileUsecaseProvider._();

final class GetCachedUserProfileUsecaseProvider
    extends
        $FunctionalProvider<
          GetCachedUserProfileUsecase,
          GetCachedUserProfileUsecase,
          GetCachedUserProfileUsecase
        >
    with $Provider<GetCachedUserProfileUsecase> {
  GetCachedUserProfileUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCachedUserProfileUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCachedUserProfileUsecaseHash();

  @$internal
  @override
  $ProviderElement<GetCachedUserProfileUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetCachedUserProfileUsecase create(Ref ref) {
    return getCachedUserProfileUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCachedUserProfileUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCachedUserProfileUsecase>(value),
    );
  }
}

String _$getCachedUserProfileUsecaseHash() =>
    r'322c59fbbb70f9e4981b89345ce2ef9ee9bb6e95';

@ProviderFor(fetchUserProfileUsecase)
final fetchUserProfileUsecaseProvider = FetchUserProfileUsecaseProvider._();

final class FetchUserProfileUsecaseProvider
    extends
        $FunctionalProvider<
          FetchUserProfileUsecase,
          FetchUserProfileUsecase,
          FetchUserProfileUsecase
        >
    with $Provider<FetchUserProfileUsecase> {
  FetchUserProfileUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchUserProfileUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchUserProfileUsecaseHash();

  @$internal
  @override
  $ProviderElement<FetchUserProfileUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FetchUserProfileUsecase create(Ref ref) {
    return fetchUserProfileUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FetchUserProfileUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FetchUserProfileUsecase>(value),
    );
  }
}

String _$fetchUserProfileUsecaseHash() =>
    r'6e3ee9191618e8cc492b5b746cc44db420872a81';

@ProviderFor(updateUserProfileUsecase)
final updateUserProfileUsecaseProvider = UpdateUserProfileUsecaseProvider._();

final class UpdateUserProfileUsecaseProvider
    extends
        $FunctionalProvider<
          UpdateUserProfileUsecase,
          UpdateUserProfileUsecase,
          UpdateUserProfileUsecase
        >
    with $Provider<UpdateUserProfileUsecase> {
  UpdateUserProfileUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateUserProfileUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateUserProfileUsecaseHash();

  @$internal
  @override
  $ProviderElement<UpdateUserProfileUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateUserProfileUsecase create(Ref ref) {
    return updateUserProfileUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateUserProfileUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateUserProfileUsecase>(value),
    );
  }
}

String _$updateUserProfileUsecaseHash() =>
    r'1f2dee705737097e45069d1d1db8926dd1bbab7d';
