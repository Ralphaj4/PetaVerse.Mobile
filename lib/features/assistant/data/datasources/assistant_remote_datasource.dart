import 'dart:convert';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/repositories/assistant_repository.dart';
import '../dtos/chat_dtos.dart';

/// Remote data source for the AI assistant feature.
/// Talks exclusively through [ApiClient] — never touches Dio directly.
/// Throws AppExceptions (mapped by ApiClient); the repository turns them
/// into Failures.
class AssistantRemoteDataSource {
  const AssistantRemoteDataSource(this._client);

  final ApiClient _client;

  Future<List<ChatSessionSummaryDto>> getSessions() async {
    final data =
        await _client.get<List<dynamic>>(ApiEndpoints.aiChatSessions);
    return data
        .map((e) =>
            ChatSessionSummaryDto.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  Future<ChatSessionDto> getSession(int sessionId) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.aiChatSession(sessionId),
    );
    return ChatSessionDto.fromJson(data);
  }

  Future<ChatSessionDto> createSession({int? petId, String? title}) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.aiChatSessions,
      data: {
        'petId': ?petId,
        'title': ?title,
      },
    );
    return ChatSessionDto.fromJson(data);
  }

  Future<void> deleteSession(int sessionId) async {
    await _client.delete<void>(ApiEndpoints.aiChatSession(sessionId));
  }

  /// Streams typed ChatStreamEvents from the SSE endpoint.
  /// Parses each frame's event + data pair into the sealed event hierarchy.
  Stream<ChatStreamEvent> sendMessage(int sessionId, String text) async* {
    final rawStream = _client.postSse(
      ApiEndpoints.aiChatMessages(sessionId),
      data: {'text': text},
    );

    await for (final frame in rawStream) {
      final event = _parseFrame(frame);
      if (event != null) {
        yield event;
        // Stop consuming after terminal events.
        if (event is DoneEvent || event is ErrorEvent) break;
      }
    }
  }

  /// Parses a single SSE frame string into a ChatStreamEvent.
  ChatStreamEvent? _parseFrame(String frame) {
    String? eventType;
    String? dataLine;

    for (final line in frame.split('\n')) {
      if (line.startsWith('event:')) {
        eventType = line.substring(6).trim();
      } else if (line.startsWith('data:')) {
        dataLine = line.substring(5).trim();
      }
    }

    if (eventType == null || dataLine == null) return null;

    try {
      final json = jsonDecode(dataLine) as Map<String, dynamic>;
      return switch (eventType) {
        'token' => TokenEvent(json['text'] as String? ?? ''),
        'block' => BlockEvent(ChatBlockDto.fromJson(json).toEntity()),
        'meta' => MetaEvent(
            quickReplies: (json['quickReplies'] as List<dynamic>?)
                    ?.cast<String>() ??
                [],
            footerText: json['footerText'] as String?,
            footerActionLabel: json['footerActionLabel'] as String?,
          ),
        'done' => DoneEvent(json['messageId'] as int? ?? 0),
        'error' => ErrorEvent(
            json['code'] as String? ?? 'unknown',
            json['message'] as String? ?? '',
          ),
        _ => null,
      };
    } catch (_) {
      return null;
    }
  }
}
