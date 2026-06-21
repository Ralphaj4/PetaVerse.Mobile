// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_usecases_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getUserProfileUsecase)
final getUserProfileUsecaseProvider = GetUserProfileUsecaseProvider._();

final class GetUserProfileUsecaseProvider
    extends
        $FunctionalProvider<
          GetUserProfileUsecase,
          GetUserProfileUsecase,
          GetUserProfileUsecase
        >
    with $Provider<GetUserProfileUsecase> {
  GetUserProfileUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getUserProfileUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getUserProfileUsecaseHash();

  @$internal
  @override
  $ProviderElement<GetUserProfileUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetUserProfileUsecase create(Ref ref) {
    return getUserProfileUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetUserProfileUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetUserProfileUsecase>(value),
    );
  }
}

String _$getUserProfileUsecaseHash() =>
    r'387d207925ee7b440190a5a198ccd32050de4289';

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
