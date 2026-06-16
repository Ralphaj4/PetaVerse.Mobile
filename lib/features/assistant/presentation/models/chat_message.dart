import 'package:flutter/material.dart';

enum MessageSender { user, bot }

enum TipStyle { normal, proTip }

class TipSection {
  const TipSection({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.body,
    this.style = TipStyle.normal,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String body;
  final TipStyle style;
}

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.sender,
    required this.text,
    this.tips = const [],
    this.footerText,
    this.footerActionLabel,
    this.quickReplies = const [],
  });

  final String id;
  final MessageSender sender;
  final String text;
  final List<TipSection> tips;
  final String? footerText;
  final String? footerActionLabel;
  final List<String> quickReplies;
}
