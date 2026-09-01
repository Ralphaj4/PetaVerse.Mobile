// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(assistantRepository)
final assistantRepositoryProvider = AssistantRepositoryProvider._();

final class AssistantRepositoryProvider
    extends
        $FunctionalProvider<
          AssistantRepository,
          AssistantRepository,
          AssistantRepository
        >
    with $Provider<AssistantRepository> {
  AssistantRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assistantRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assistantRepositoryHash();

  @$internal
  @override
  $ProviderElement<AssistantRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AssistantRepository create(Ref ref) {
    return assistantRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssistantRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssistantRepository>(value),
    );
  }
}

String _$assistantRepositoryHash() =>
    r'8d481ac906b9c9b7f967a1917b5e531c6502ce87';

/// Manages the full message list for a single chat session.
///
/// Lifecycle:
///   build()  → loads history from the backend
///   send()   → optimistically appends user + streaming placeholder,
///              then folds SSE events into message state

@ProviderFor(ChatSession)
final chatSessionProvider = ChatSessionFamily._();

/// Manages the full message list for a single chat session.
///
/// Lifecycle:
///   build()  → loads history from the backend
///   send()   → optimistically appends user + streaming placeholder,
///              then folds SSE events into message state
final class ChatSessionProvider
    extends $AsyncNotifierProvider<ChatSession, List<ChatMessage>> {
  /// Manages the full message list for a single chat session.
  ///
  /// Lifecycle:
  ///   build()  → loads history from the backend
  ///   send()   → optimistically appends user + streaming placeholder,
  ///              then folds SSE events into message state
  ChatSessionProvider._({
    required ChatSessionFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'chatSessionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$chatSessionHash();

  @override
  String toString() {
    return r'chatSessionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChatSession create() => ChatSession();

  @override
  bool operator ==(Object other) {
    return other is ChatSessionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatSessionHash() => r'c701dc00a88ebfb974ad446147d325822fe23366';

/// Manages the full message list for a single chat session.
///
/// Lifecycle:
///   build()  → loads history from the backend
///   send()   → optimistically appends user + streaming placeholder,
///              then folds SSE events into message state

final class ChatSessionFamily extends $Family
    with
        $ClassFamilyOverride<
          ChatSession,
          AsyncValue<List<ChatMessage>>,
          List<ChatMessage>,
          FutureOr<List<ChatMessage>>,
          int
        > {
  ChatSessionFamily._()
    : super(
        retry: null,
        name: r'chatSessionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Manages the full message list for a single chat session.
  ///
  /// Lifecycle:
  ///   build()  → loads history from the backend
  ///   send()   → optimistically appends user + streaming placeholder,
  ///              then folds SSE events into message state

  ChatSessionProvider call(int sessionId) =>
      ChatSessionProvider._(argument: sessionId, from: this);

  @override
  String toString() => r'chatSessionProvider';
}

/// Manages the full message list for a single chat session.
///
/// Lifecycle:
///   build()  → loads history from the backend
///   send()   → optimistically appends user + streaming placeholder,
///              then folds SSE events into message state

abstract class _$ChatSession extends $AsyncNotifier<List<ChatMessage>> {
  late final _$args = ref.$arg as int;
  int get sessionId => _$args;

  FutureOr<List<ChatMessage>> build(int sessionId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ChatMessage>>, List<ChatMessage>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ChatMessage>>, List<ChatMessage>>,
              AsyncValue<List<ChatMessage>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// Provides the active session id for the current assistant screen.
/// The page pushes its session id here before it's read by [chatSessionProvider].

@ProviderFor(ActiveChatSessionId)
final activeChatSessionIdProvider = ActiveChatSessionIdProvider._();

/// Provides the active session id for the current assistant screen.
/// The page pushes its session id here before it's read by [chatSessionProvider].
final class ActiveChatSessionIdProvider
    extends $NotifierProvider<ActiveChatSessionId, int?> {
  /// Provides the active session id for the current assistant screen.
  /// The page pushes its session id here before it's read by [chatSessionProvider].
  ActiveChatSessionIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeChatSessionIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeChatSessionIdHash();

  @$internal
  @override
  ActiveChatSessionId create() => ActiveChatSessionId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$activeChatSessionIdHash() =>
    r'b6c158e9ec4887fe77b00509978127db68f1c3de';

/// Provides the active session id for the current assistant screen.
/// The page pushes its session id here before it's read by [chatSessionProvider].

abstract class _$ActiveChatSessionId extends $Notifier<int?> {
  int? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int?, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int?, int?>,
              int?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The user's chat sessions for the history screen — newest-updated first,
/// archived sessions filtered out (the backend soft-deletes, we hide them).
///
/// Backed by `GET /ai/chat/sessions` (endpoint 2). [archive] calls
/// `DELETE /ai/chat/sessions/{id}` (endpoint 5) and optimistically removes the
/// row so the list updates instantly.

@ProviderFor(ChatHistory)
final chatHistoryProvider = ChatHistoryProvider._();

/// The user's chat sessions for the history screen — newest-updated first,
/// archived sessions filtered out (the backend soft-deletes, we hide them).
///
/// Backed by `GET /ai/chat/sessions` (endpoint 2). [archive] calls
/// `DELETE /ai/chat/sessions/{id}` (endpoint 5) and optimistically removes the
/// row so the list updates instantly.
final class ChatHistoryProvider
    extends $AsyncNotifierProvider<ChatHistory, List<ChatSessionSummary>> {
  /// The user's chat sessions for the history screen — newest-updated first,
  /// archived sessions filtered out (the backend soft-deletes, we hide them).
  ///
  /// Backed by `GET /ai/chat/sessions` (endpoint 2). [archive] calls
  /// `DELETE /ai/chat/sessions/{id}` (endpoint 5) and optimistically removes the
  /// row so the list updates instantly.
  ChatHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatHistoryHash();

  @$internal
  @override
  ChatHistory create() => ChatHistory();
}

String _$chatHistoryHash() => r'aa2c2f0c2cc1c5659effcbf255c645485dd451c2';

/// The user's chat sessions for the history screen — newest-updated first,
/// archived sessions filtered out (the backend soft-deletes, we hide them).
///
/// Backed by `GET /ai/chat/sessions` (endpoint 2). [archive] calls
/// `DELETE /ai/chat/sessions/{id}` (endpoint 5) and optimistically removes the
/// row so the list updates instantly.

abstract class _$ChatHistory extends $AsyncNotifier<List<ChatSessionSummary>> {
  FutureOr<List<ChatSessionSummary>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<ChatSessionSummary>>,
              List<ChatSessionSummary>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ChatSessionSummary>>,
                List<ChatSessionSummary>
              >,
              AsyncValue<List<ChatSessionSummary>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
