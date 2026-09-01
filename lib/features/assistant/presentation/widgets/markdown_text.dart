import 'package:flutter/material.dart';

/// Renders the lightweight inline markdown the AI assistant emits — **bold**
/// and *italic* (or _italic_) — as styled spans, so raw `**` never reaches the
/// user. Everything else (including `\n`) is passed through as plain text.
///
/// Deliberately tiny: the assistant only produces inline emphasis, so we avoid
/// pulling in a full markdown package. Unmatched/oddly-nested markers are
/// rendered literally rather than swallowed.
class MarkdownText extends StatelessWidget {
  const MarkdownText(
    this.data, {
    required this.style,
    this.textAlign,
    super.key,
  });

  final String data;
  final TextStyle style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: _parse(data, style)),
      style: style,
      textAlign: textAlign,
    );
  }

  /// Splits [text] into spans, toggling bold/italic on `**`/`__` and `*`/`_`.
  static List<TextSpan> _parse(String text, TextStyle base) {
    final spans = <TextSpan>[];
    final buffer = StringBuffer();
    var bold = false;
    var italic = false;

    void flush() {
      if (buffer.isEmpty) return;
      spans.add(TextSpan(
        text: buffer.toString(),
        style: base.copyWith(
          fontWeight: bold ? FontWeight.w700 : base.fontWeight,
          fontStyle: italic ? FontStyle.italic : base.fontStyle,
        ),
      ));
      buffer.clear();
    }

    var i = 0;
    while (i < text.length) {
      // Bold: ** or __ (only when there's a following char to emphasize).
      if (i + 1 < text.length &&
          (text.startsWith('**', i) || text.startsWith('__', i))) {
        flush();
        bold = !bold;
        i += 2;
        continue;
      }
      // Italic: single * or _ .
      final ch = text[i];
      if (ch == '*' || ch == '_') {
        flush();
        italic = !italic;
        i += 1;
        continue;
      }
      buffer.write(ch);
      i += 1;
    }
    flush();
    return spans;
  }
}
