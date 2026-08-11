// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Publishes a new post: uploads each media file through the presign/confirm
/// flow, then creates the post with the confirmed asset ids.
///
/// `keepAlive` so the notifier isn't disposed mid-publish (which would hang the
/// returned Future).

@ProviderFor(CreatePost)
final createPostProvider = CreatePostProvider._();

/// Publishes a new post: uploads each media file through the presign/confirm
/// flow, then creates the post with the confirmed asset ids.
///
/// `keepAlive` so the notifier isn't disposed mid-publish (which would hang the
/// returned Future).
final class CreatePostProvider
    extends $AsyncNotifierProvider<CreatePost, void> {
  /// Publishes a new post: uploads each media file through the presign/confirm
  /// flow, then creates the post with the confirmed asset ids.
  ///
  /// `keepAlive` so the notifier isn't disposed mid-publish (which would hang the
  /// returned Future).
  CreatePostProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createPostProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createPostHash();

  @$internal
  @override
  CreatePost create() => CreatePost();
}

String _$createPostHash() => r'4260ca62306c8be88cf835ec37ae180858017e13';

/// Publishes a new post: uploads each media file through the presign/confirm
/// flow, then creates the post with the confirmed asset ids.
///
/// `keepAlive` so the notifier isn't disposed mid-publish (which would hang the
/// returned Future).

abstract class _$CreatePost extends $AsyncNotifier<void> {
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
