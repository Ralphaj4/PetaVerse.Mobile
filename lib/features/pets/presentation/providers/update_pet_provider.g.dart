// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_pet_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UpdatePetNotifier)
final updatePetProvider = UpdatePetNotifierProvider._();

final class UpdatePetNotifierProvider
    extends $NotifierProvider<UpdatePetNotifier, AsyncValue<Pet?>> {
  UpdatePetNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updatePetProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updatePetNotifierHash();

  @$internal
  @override
  UpdatePetNotifier create() => UpdatePetNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<Pet?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<Pet?>>(value),
    );
  }
}

String _$updatePetNotifierHash() => r'6730c3deda34946015fc2ef5a105f1140707a81f';

abstract class _$UpdatePetNotifier extends $Notifier<AsyncValue<Pet?>> {
  AsyncValue<Pet?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Pet?>, AsyncValue<Pet?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Pet?>, AsyncValue<Pet?>>,
              AsyncValue<Pet?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
