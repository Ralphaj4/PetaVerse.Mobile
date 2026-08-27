import 'package:flutter/material.dart';

/// Resolved icon+color pair after mapping from wire enum names.
/// The data layer resolves iconName/color strings here so raw strings
/// never reach the presentation layer.
class ResolvedTipStyle {
  const ResolvedTipStyle({
    required this.icon,
    required this.iconColor,
    required this.isProTip,
  });

  final IconData icon;
  final Color iconColor;
  final bool isProTip;
}

/// A structured block inside a bot message (tip card or plain text block).
class ChatBlock {
  const ChatBlock({
    required this.kind,
    required this.body,
    this.title,
    this.resolved,
  });

  /// "tip" or "text" (never-drop fallback from backend parser).
  final String kind;
  final String body;
  final String? title;

  /// Null for kind=="text" blocks (no icon/color).
  final ResolvedTipStyle? resolved;
}

/// A single message in the chat — user or assistant.
class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.role,
    required this.text,
    this.blocks = const [],
    this.quickReplies = const [],
    this.footerText,
    this.footerActionLabel,
    this.status = ChatMessageStatus.done,
  });

  final int id;
  final ChatMessageRole role;

  /// Streamed text content (for assistant: the intro prose; grows token-by-token).
  final String text;
  final List<ChatBlock> blocks;
  final List<String> quickReplies;
  final String? footerText;
  final String? footerActionLabel;
  final ChatMessageStatus status;

  ChatMessage copyWith({
    String? text,
    List<ChatBlock>? blocks,
    List<String>? quickReplies,
    String? footerText,
    String? footerActionLabel,
    ChatMessageStatus? status,
  }) =>
      ChatMessage(
        id: id,
        role: role,
        text: text ?? this.text,
        blocks: blocks ?? this.blocks,
        quickReplies: quickReplies ?? this.quickReplies,
        footerText: footerText ?? this.footerText,
        footerActionLabel: footerActionLabel ?? this.footerActionLabel,
        status: status ?? this.status,
      );
}

enum ChatMessageRole { user, assistant }

enum ChatMessageStatus {
  /// Message was sent and a response is being received (streaming).
  streaming,

  /// Fully received / completed.
  done,

  /// Stream ended with an error.
  error,
}

/// Summary card for the session list screen.
class ChatSessionSummary {
  const ChatSessionSummary({
    required this.id,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
    this.petId,
    this.petName,
    this.title,
  });

  final int id;
  final int? petId;
  final String? petName;
  final String? title;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
}

/// Full session with message history (from GET /sessions/{id}).
class ChatSession {
  const ChatSession({
    required this.id,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
    required this.messages,
    this.petId,
    this.title,
  });

  final int id;
  final int? petId;
  final String? title;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ChatMessage> messages;
}
