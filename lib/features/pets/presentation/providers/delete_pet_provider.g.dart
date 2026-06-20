// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_pet_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DeletePetNotifier)
final deletePetProvider = DeletePetNotifierProvider._();

final class DeletePetNotifierProvider
    extends $NotifierProvider<DeletePetNotifier, AsyncValue<void>> {
  DeletePetNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deletePetProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deletePetNotifierHash();

  @$internal
  @override
  DeletePetNotifier create() => DeletePetNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$deletePetNotifierHash() => r'51482f3329d02a49d4ec6403af2f7f4d78d6e6d2';

abstract class _$DeletePetNotifier extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
