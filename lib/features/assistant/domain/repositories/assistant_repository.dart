import '../../../../core/errors/result.dart';
import '../entities/chat_entities.dart';

/// Sealed event emitted by the SSE message stream.
sealed class ChatStreamEvent {
  const ChatStreamEvent();
}

/// Incremental text token — append to the current bot message's intro text.
final class TokenEvent extends ChatStreamEvent {
  const TokenEvent(this.text);
  final String text;
}

/// A complete structured block (tip card or plain fallback).
final class BlockEvent extends ChatStreamEvent {
  const BlockEvent(this.block);
  final ChatBlock block;
}

/// Quick-replies + footer — arrives once, just before [DoneEvent].
final class MetaEvent extends ChatStreamEvent {
  const MetaEvent({
    required this.quickReplies,
    this.footerText,
    this.footerActionLabel,
  });
  final List<String> quickReplies;
  final String? footerText;
  final String? footerActionLabel;
}

/// Stream completed successfully. [messageId] is the persisted message id.
final class DoneEvent extends ChatStreamEvent {
  const DoneEvent(this.messageId);
  final int messageId;
}

/// Terminal error from the backend (e.g. content_filter, rate-limit).
final class ErrorEvent extends ChatStreamEvent {
  const ErrorEvent(this.code, this.message);
  final String code;
  final String message;
}

abstract interface class AssistantRepository {
  /// List all sessions (caller filters by isArchived if needed).
  Future<Result<List<ChatSessionSummary>>> getSessions();

  /// Full session with replayed message history.
  Future<Result<ChatSession>> getSession(int sessionId);

  /// Create a new chat session, optionally scoped to a pet.
  Future<Result<ChatSession>> createSession({int? petId, String? title});

  /// Archive (soft-delete) a session.
  Future<Result<void>> deleteSession(int sessionId);

  /// Send a message and receive the streamed reply.
  /// The stream always ends with either [DoneEvent] or [ErrorEvent].
  Stream<ChatStreamEvent> sendMessage(int sessionId, String text);
}
