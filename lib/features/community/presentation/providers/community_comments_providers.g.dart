// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_comments_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The comment thread for a post. Top-level comments carry their replies
/// inline. Supports paginated loading and optimistic add / like / pin.

@ProviderFor(PostComments)
final postCommentsProvider = PostCommentsFamily._();

/// The comment thread for a post. Top-level comments carry their replies
/// inline. Supports paginated loading and optimistic add / like / pin.
final class PostCommentsProvider
    extends $AsyncNotifierProvider<PostComments, CommentPage> {
  /// The comment thread for a post. Top-level comments carry their replies
  /// inline. Supports paginated loading and optimistic add / like / pin.
  PostCommentsProvider._({
    required PostCommentsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'postCommentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$postCommentsHash();

  @override
  String toString() {
    return r'postCommentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PostComments create() => PostComments();

  @override
  bool operator ==(Object other) {
    return other is PostCommentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$postCommentsHash() => r'a42b8ba861bcc06249b6d463aeadd4b54a08a94e';

/// The comment thread for a post. Top-level comments carry their replies
/// inline. Supports paginated loading and optimistic add / like / pin.

final class PostCommentsFamily extends $Family
    with
        $ClassFamilyOverride<
          PostComments,
          AsyncValue<CommentPage>,
          CommentPage,
          FutureOr<CommentPage>,
          int
        > {
  PostCommentsFamily._()
    : super(
        retry: null,
        name: r'postCommentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The comment thread for a post. Top-level comments carry their replies
  /// inline. Supports paginated loading and optimistic add / like / pin.

  PostCommentsProvider call(int postId) =>
      PostCommentsProvider._(argument: postId, from: this);

  @override
  String toString() => r'postCommentsProvider';
}

/// The comment thread for a post. Top-level comments carry their replies
/// inline. Supports paginated loading and optimistic add / like / pin.

abstract class _$PostComments extends $AsyncNotifier<CommentPage> {
  late final _$args = ref.$arg as int;
  int get postId => _$args;

  FutureOr<CommentPage> build(int postId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CommentPage>, CommentPage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CommentPage>, CommentPage>,
              AsyncValue<CommentPage>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
