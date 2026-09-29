// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_pet_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Drives the create-pet submission state.
///
/// The AsyncValue carries loading + the last [Failure] (for a spinner and a
/// localized error), while [create] returns a bool for the page's navigation.

@ProviderFor(CreatePetNotifier)
final createPetProvider = CreatePetNotifierProvider._();

/// Drives the create-pet submission state.
///
/// The AsyncValue carries loading + the last [Failure] (for a spinner and a
/// localized error), while [create] returns a bool for the page's navigation.
final class CreatePetNotifierProvider
    extends $AsyncNotifierProvider<CreatePetNotifier, void> {
  /// Drives the create-pet submission state.
  ///
  /// The AsyncValue carries loading + the last [Failure] (for a spinner and a
  /// localized error), while [create] returns a bool for the page's navigation.
  CreatePetNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createPetProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createPetNotifierHash();

  @$internal
  @override
  CreatePetNotifier create() => CreatePetNotifier();
}

String _$createPetNotifierHash() => r'8c6fc22f6d432b757a1b0c738081c348a2ac51e9';

/// Drives the create-pet submission state.
///
/// The AsyncValue carries loading + the last [Failure] (for a spinner and a
/// localized error), while [create] returns a bool for the page's navigation.

abstract class _$CreatePetNotifier extends $AsyncNotifier<void> {
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
