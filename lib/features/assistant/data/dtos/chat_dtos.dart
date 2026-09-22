import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/logger_service.dart';
import '../../domain/entities/chat_entities.dart';

// ── Icon / color resolution ──────────────────────────────────────────────────

/// Resolves a wire [iconName] string to a [FluentIcons] constant.
/// Falls back to info icon for unknown names and logs the unknown name.
IconData _resolveIcon(String? iconName) => switch (iconName) {
      'food' => FluentIcons.food_24_filled,
      'heart_pulse' => FluentIcons.heart_pulse_24_filled,
      'sparkle' => FluentIcons.sparkle_24_filled,
      'info' => FluentIcons.info_24_filled,
      'warning' => FluentIcons.warning_24_filled,
      'shield' => FluentIcons.shield_24_filled,
      _ => () {
          if (iconName != null) {
            const LoggerService()
                .warning('Unknown AI block iconName: $iconName');
          }
          return FluentIcons.info_24_filled;
        }(),
    };

/// Resolves a wire [color] string to an [AppColors] constant.
Color _resolveColor(String? color) => switch (color) {
      'primary' => AppColors.primary,
      'secondary' => AppColors.secondary,
      'primaryDark' => AppColors.primaryDark,
      'danger' => AppColors.error,
      _ => () {
          if (color != null) {
            const LoggerService().warning('Unknown AI block color: $color');
          }
          return AppColors.primary;
        }(),
    };

/// Normalizes text for duplicate-detection between a message's inline body and
/// its structured blocks: lowercases, strips markdown emphasis/heading markers
/// (`* _ # \``), and collapses all whitespace so line-wrap and heading markup
/// differences don't defeat a substring match.
String _normalizeForMatch(String s) => s
    .toLowerCase()
    .replaceAll(RegExp(r'[*_#`]'), '')
    .replaceAll(RegExp(r'\s+'), ' ')
    .trim();

/// Removes from [text] any paragraph that a structured [blocks] card already
/// covers, so a section isn't shown twice (once inline, once as a card). We
/// keep the cards and drop the inline copy. A paragraph is dropped when its
/// normalized content is contained in — or contains — a block's normalized
/// title+body. Paragraphs the blocks don't cover (e.g. the intro) are kept
/// verbatim, preserving their markdown.
String _stripBlocksFromText(String text, List<ChatBlock> blocks) {
  if (blocks.isEmpty) return text;

  final blockKeys = [
    for (final b in blocks)
      _normalizeForMatch('${b.title ?? ''} ${b.body}')
  ].where((k) => k.isNotEmpty).toList(growable: false);
  if (blockKeys.isEmpty) return text;

  // Split into paragraphs on blank lines so a heading+body section stays as one
  // unit (adjacent lines), while the intro paragraph is separate.
  final paragraphs = text.split(RegExp(r'\n\s*\n'));
  final kept = <String>[];
  for (final para in paragraphs) {
    final key = _normalizeForMatch(para);
    if (key.isEmpty) continue;
    final covered = blockKeys.any((bk) => bk.contains(key) || key.contains(bk));
    if (!covered) kept.add(para.trim());
  }
  return kept.join('\n\n').trim();
}

// ── Block DTO ────────────────────────────────────────────────────────────────

class ChatBlockDto {
  const ChatBlockDto({
    required this.kind,
    required this.body,
    required this.proTip,
    this.title,
    this.iconName,
    this.color,
  });

  factory ChatBlockDto.fromJson(Map<String, dynamic> json) => ChatBlockDto(
        kind: json['kind'] as String? ?? 'text',
        title: json['title'] as String?,
        body: json['body'] as String? ?? '',
        iconName: json['iconName'] as String?,
        color: json['color'] as String?,
        proTip: json['proTip'] as bool? ?? false,
      );

  final String kind;
  final String? title;
  final String body;
  final String? iconName;
  final String? color;
  final bool proTip;

  ChatBlock toEntity() => ChatBlock(
        kind: kind,
        title: title,
        body: body,
        resolved: kind == 'tip'
            ? ResolvedTipStyle(
                icon: _resolveIcon(iconName),
                iconColor: _resolveColor(color),
                isProTip: proTip,
              )
            : null,
      );
}

// ── Message DTO ──────────────────────────────────────────────────────────────

class ChatMessageDto {
  const ChatMessageDto({
    required this.id,
    required this.role,
    required this.textContent,
    required this.createdAt,
    this.blocks,
    this.quickReplies,
    this.footer,
  });

  factory ChatMessageDto.fromJson(Map<String, dynamic> json) {
    final blocksRaw = json['blocks'] as List<dynamic>?;
    final repliesRaw = json['quickReplies'] as List<dynamic>?;
    final footerRaw = json['footer'] as Map<String, dynamic>?;

    return ChatMessageDto(
      id: json['id'] as int,
      // role: 0 = user, 1 = assistant (int from backend)
      role: (json['role'] as int?) == 1
          ? ChatMessageRole.assistant
          : ChatMessageRole.user,
      textContent: json['textContent'] as String? ?? '',
      blocks: blocksRaw
          ?.map((e) => ChatBlockDto.fromJson(e as Map<String, dynamic>))
          .toList(growable: false),
      quickReplies: repliesRaw?.cast<String>(),
      footer: footerRaw,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  final int id;
  final ChatMessageRole role;
  final String textContent;
  final List<ChatBlockDto>? blocks;
  final List<String>? quickReplies;
  final Map<String, dynamic>? footer;
  final DateTime createdAt;

  ChatMessage toEntity() {
    // The footer is a short call-to-action line, not a copy of the answer.
    // History payloads sometimes echo the whole reply into `footer.text`,
    // which would render the message twice — drop it when it just duplicates
    // the body.
    final footerText = footer?['text'] as String?;
    final dedupedFooter =
        (footerText != null && footerText.trim() == textContent.trim())
            ? null
            : footerText;

    // On history reload the backend flattens the whole reply into
    // `textContent` (intro + every structured section inline, with markdown
    // headings) AND *also* returns those sections as separate blocks. Rendered
    // together each section shows up twice — once inline in the body text, once
    // as a styled card. We keep the styled cards (they carry the design) and
    // strip the sections they cover out of the inline text, leaving only the
    // intro paragraph in the body.
    final mappedBlocks =
        blocks?.map((b) => b.toEntity()).toList(growable: false) ?? const [];
    final dedupedText =
        stripChatMetaLines(_stripBlocksFromText(textContent, mappedBlocks));

    return ChatMessage(
      id: id,
      role: role,
      text: dedupedText,
      blocks: mappedBlocks,
      quickReplies: quickReplies ?? [],
      footerText: dedupedFooter,
      footerActionLabel: footer?['actionLabel'] as String?,
      status: ChatMessageStatus.done,
    );
  }
}

// ── Session DTOs ─────────────────────────────────────────────────────────────

class ChatSessionSummaryDto {
  const ChatSessionSummaryDto({
    required this.id,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
    this.petId,
    this.petName,
    this.title,
  });

  factory ChatSessionSummaryDto.fromJson(Map<String, dynamic> json) =>
      ChatSessionSummaryDto(
        id: json['id'] as int,
        petId: json['petId'] as int?,
        petName: json['petName'] as String?,
        title: json['title'] as String?,
        isArchived: json['isArchived'] as bool? ?? false,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );

  final int id;
  final int? petId;
  final String? petName;
  final String? title;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatSessionSummary toEntity() => ChatSessionSummary(
        id: id,
        petId: petId,
        petName: petName,
        title: title,
        isArchived: isArchived,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

class ChatSessionDto {
  const ChatSessionDto({
    required this.id,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
    required this.messages,
    this.petId,
    this.title,
  });

  factory ChatSessionDto.fromJson(Map<String, dynamic> json) {
    final msgsRaw = json['messages'] as List<dynamic>? ?? [];
    return ChatSessionDto(
      id: json['id'] as int,
      petId: json['petId'] as int?,
      title: json['title'] as String?,
      isArchived: json['isArchived'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      messages: msgsRaw
          .map((e) => ChatMessageDto.fromJson(e as Map<String, dynamic>))
          .toList(growable: false),
    );
  }

  final int id;
  final int? petId;
  final String? title;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ChatMessageDto> messages;

  ChatSession toEntity() => ChatSession(
        id: id,
        petId: petId,
        title: title,
        isArchived: isArchived,
        createdAt: createdAt,
        updatedAt: updatedAt,
        messages: messages.map((m) => m.toEntity()).toList(growable: false),
      );
}
