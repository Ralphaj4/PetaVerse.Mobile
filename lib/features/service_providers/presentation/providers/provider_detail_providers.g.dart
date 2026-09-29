// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_detail_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Full detail for one provider, stamped with per-branch distance from the
/// user's current location when known.

@ProviderFor(providerDetail)
final providerDetailProvider = ProviderDetailFamily._();

/// Full detail for one provider, stamped with per-branch distance from the
/// user's current location when known.

final class ProviderDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<ServiceProviderDetail>,
          ServiceProviderDetail,
          FutureOr<ServiceProviderDetail>
        >
    with
        $FutureModifier<ServiceProviderDetail>,
        $FutureProvider<ServiceProviderDetail> {
  /// Full detail for one provider, stamped with per-branch distance from the
  /// user's current location when known.
  ProviderDetailProvider._({
    required ProviderDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'providerDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$providerDetailHash();

  @override
  String toString() {
    return r'providerDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ServiceProviderDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ServiceProviderDetail> create(Ref ref) {
    final argument = this.argument as int;
    return providerDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProviderDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$providerDetailHash() => r'a6025d36051e323d7e3f973bd8b0082ccad516d1';

/// Full detail for one provider, stamped with per-branch distance from the
/// user's current location when known.

final class ProviderDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ServiceProviderDetail>, int> {
  ProviderDetailFamily._()
    : super(
        retry: null,
        name: r'providerDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Full detail for one provider, stamped with per-branch distance from the
  /// user's current location when known.

  ProviderDetailProvider call(int id) =>
      ProviderDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'providerDetailProvider';
}

/// Submits the user's star rating for a provider and refreshes the detail on
/// success. Returns the updated aggregate for optimistic UI, or throws the
/// [Failure] for the caller to surface.

@ProviderFor(ProviderRating)
final providerRatingProvider = ProviderRatingProvider._();

/// Submits the user's star rating for a provider and refreshes the detail on
/// success. Returns the updated aggregate for optimistic UI, or throws the
/// [Failure] for the caller to surface.
final class ProviderRatingProvider
    extends $AsyncNotifierProvider<ProviderRating, void> {
  /// Submits the user's star rating for a provider and refreshes the detail on
  /// success. Returns the updated aggregate for optimistic UI, or throws the
  /// [Failure] for the caller to surface.
  ProviderRatingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'providerRatingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$providerRatingHash();

  @$internal
  @override
  ProviderRating create() => ProviderRating();
}

String _$providerRatingHash() => r'35c7616853da571506b8e0bffe12b34a4a150727';

/// Submits the user's star rating for a provider and refreshes the detail on
/// success. Returns the updated aggregate for optimistic UI, or throws the
/// [Failure] for the caller to surface.

abstract class _$ProviderRating extends $AsyncNotifier<void> {
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
