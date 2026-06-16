import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Fixed bottom input bar: attachment "+" button, text field, orange send FAB.
class ChatInputBar extends StatefulWidget {
  const ChatInputBar({
    required this.hint,
    required this.onSend,
    this.onAttach,
    super.key,
  });

  final String hint;
  final ValueChanged<String> onSend;
  final VoidCallback? onAttach;

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(
      () => setState(() => _hasText = _controller.text.trim().isNotEmpty),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    widget.onSend(text);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.sm + bottom,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: widget.onAttach,
            icon: const Icon(
              FluentIcons.add_24_regular,
              color: AppColors.textSecondary,
            ),
            tooltip: 'Attach',
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppSpacing.xl),
              ),
              child: TextField(
                controller: _controller,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _send(),
                decoration: InputDecoration.collapsed(
                  hintText: widget.hint,
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                style: AppTextStyles.bodyMedium,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          AnimatedScale(
            scale: _hasText ? 1.0 : 0.85,
            duration: const Duration(milliseconds: 200),
            child: FloatingActionButton.small(
              onPressed: _send,
              backgroundColor:
                  _hasText ? AppColors.primary : AppColors.textTertiary,
              elevation: 0,
              child: const Icon(
                FluentIcons.send_24_filled,
                color: AppColors.onPrimary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
