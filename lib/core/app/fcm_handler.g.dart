// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fcmHandler)
final fcmHandlerProvider = FcmHandlerProvider._();

final class FcmHandlerProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  FcmHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fcmHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fcmHandlerHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return fcmHandler(ref);
  }
}

String _$fcmHandlerHash() => r'2fd4edc0837d595396d7ac0edea4c65aada0fe0c';
