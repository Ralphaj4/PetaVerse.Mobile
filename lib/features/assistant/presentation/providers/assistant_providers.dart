import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/result.dart';
import '../../../../core/network/api_client.dart';
import '../../data/datasources/assistant_remote_datasource.dart';
import '../../data/repositories/assistant_repository_impl.dart';
import '../../domain/entities/chat_entities.dart';
import '../../domain/repositories/assistant_repository.dart';

part 'assistant_providers.g.dart';

@riverpod
AssistantRepository assistantRepository(Ref ref) => AssistantRepositoryImpl(
      remote: AssistantRemoteDataSource(ref.watch(apiClientProvider)),
    );

/// Manages the full message list for a single chat session.
///
/// Lifecycle:
///   build()  → loads history from the backend
///   send()   → optimistically appends user + streaming placeholder,
///              then folds SSE events into message state
@riverpod
class ChatSession extends _$ChatSession {
  @override
  Future<List<ChatMessage>> build(int sessionId) async {
    final result = await ref
        .watch(assistantRepositoryProvider)
        .getSession(sessionId);
    return result.when(
      success: (session) => session.messages,
      failure: (f) => throw f,
    );
  }

  /// Sends [text] and streams the reply back into state.
  Future<void> send(String text) async {
    // Don't allow concurrent sends.
    if (_isSending) return;
    _isSending = true;

    final current = state.value ?? [];

    // Optimistic: append the user message with a temporary id.
    final userMsg = ChatMessage(
      id: -(current.length + 1),
      role: ChatMessageRole.user,
      text: text,
      status: ChatMessageStatus.done,
    );

    // Placeholder for the streaming bot response.
    final botPlaceholder = ChatMessage(
      id: -(current.length + 2),
      role: ChatMessageRole.assistant,
      text: '',
      status: ChatMessageStatus.streaming,
    );

    state = AsyncData([...current, userMsg, botPlaceholder]);

    // Track the mutable bot message as we receive events.
    var botMsg = botPlaceholder;

    void updateBot(ChatMessage updated) {
      final msgs = state.value ?? [];
      state = AsyncData([
        for (final m in msgs)
          if (m.id == botMsg.id) updated else m,
      ]);
      botMsg = updated;
    }

    final stream = ref
        .read(assistantRepositoryProvider)
        .sendMessage(sessionId, text);

    await for (final event in stream) {
      switch (event) {
        case TokenEvent(:final text):
          updateBot(botMsg.copyWith(text: botMsg.text + text));

        case BlockEvent(:final block):
          updateBot(botMsg.copyWith(blocks: [...botMsg.blocks, block]));

        case MetaEvent(
            :final quickReplies,
            :final footerText,
            :final footerActionLabel,
          ):
          updateBot(botMsg.copyWith(
            quickReplies: quickReplies,
            footerText: footerText,
            footerActionLabel: footerActionLabel,
          ));

        case DoneEvent(:final messageId):
          // Replace temp id with the real persisted one.
          final msgs = state.value ?? [];
          state = AsyncData([
            for (final m in msgs)
              if (m.id == botMsg.id)
                botMsg.copyWith(status: ChatMessageStatus.done)
                    // Real id — reconstruct since copyWith doesn't cover id.
                    ._withId(messageId)
              else
                m,
          ]);

        case ErrorEvent():
          updateBot(botMsg.copyWith(status: ChatMessageStatus.error));
      }
    }

    _isSending = false;
  }

  bool _isSending = false;
}

extension on ChatMessage {
  ChatMessage _withId(int newId) => ChatMessage(
        id: newId,
        role: role,
        text: text,
        blocks: blocks,
        quickReplies: quickReplies,
        footerText: footerText,
        footerActionLabel: footerActionLabel,
        status: status,
      );
}

/// Provides the active session id for the current assistant screen.
/// The page pushes its session id here before it's read by [chatSessionProvider].
@riverpod
class ActiveChatSessionId extends _$ActiveChatSessionId {
  @override
  int? build() => null;

  void set(int id) => state = id;
}

/// The user's chat sessions for the history screen — newest-updated first,
/// archived sessions filtered out (the backend soft-deletes, we hide them).
///
/// Backed by `GET /ai/chat/sessions` (endpoint 2). [archive] calls
/// `DELETE /ai/chat/sessions/{id}` (endpoint 5) and optimistically removes the
/// row so the list updates instantly.
@riverpod
class ChatHistory extends _$ChatHistory {
  @override
  Future<List<ChatSessionSummary>> build() async {
    final result = await ref.watch(assistantRepositoryProvider).getSessions();
    return result.when(
      success: (sessions) => [
        for (final s in sessions)
          if (!s.isArchived) s,
      ]..sort((a, b) => b.updatedAt.compareTo(a.updatedAt)),
      failure: (f) => throw f,
    );
  }

  /// Archives (soft-deletes) a session and drops it from the list. On failure
  /// the list is reloaded so the row reappears.
  Future<Result<void>> archive(int sessionId) async {
    final previous = state.value ?? const [];
    // Optimistic: remove immediately.
    state = AsyncData([
      for (final s in previous)
        if (s.id != sessionId) s,
    ]);

    final result = await ref.read(assistantRepositoryProvider).deleteSession(sessionId);
    result.when(
      success: (_) {},
      failure: (_) => state = AsyncData(previous), // roll back
    );
    return result;
  }
}
