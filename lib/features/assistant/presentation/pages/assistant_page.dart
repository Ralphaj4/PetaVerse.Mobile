import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../../../core/analytics/analytics_service.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/chat_entities.dart';
import '../providers/assistant_providers.dart';
import '../widgets/bot_bubble.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/quick_reply_chips.dart';
import '../widgets/typing_indicator.dart';
import '../widgets/user_bubble.dart';

/// The AI assistant chat screen.
///
/// Lifecycle:
///   1. Opens → creates a new chat session via [AssistantRepository].
///   2. User sends → [ChatSessionNotifier.send()] optimistically appends
///      messages and folds SSE stream events into state.
///   3. Widgets (BotBubble, TipSectionItem, QuickReplyChips) render unchanged
///      — the data layer resolved iconName/color to real Flutter constants.
class AssistantPage extends ConsumerStatefulWidget {
  const AssistantPage({this.petId, super.key});

  /// When launched from a pet's profile the context is scoped to that pet.
  final int? petId;

  @override
  ConsumerState<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends ConsumerState<AssistantPage> {
  final ScrollController _scrollController = ScrollController();

  /// The active session id — null while creating.
  int? _sessionId;
  String? _sessionError;

  @override
  void initState() {
    super.initState();
    _createSession();
    ref.read(analyticsServiceProvider).logEvent('ai_chat_started');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _createSession() async {
    final result = await ref
        .read(assistantRepositoryProvider)
        .createSession(petId: widget.petId);

    result.when(
      success: (session) {
        if (mounted) setState(() => _sessionId = session.id);
      },
      failure: (f) {
        if (mounted) {
          setState(() => _sessionError = context.l10n.errorServer);
        }
      },
    );
  }

  void _handleSend(String text) {
    if (_sessionId == null) return;
    ref.read(chatSessionProvider(_sessionId!).notifier).send(text);
    _scrollToBottom();
  }

  void _handleQuickReply(String label) => _handleSend(label);

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // If there's an active session, watch its messages.
    final sessionState = _sessionId != null
        ? ref.watch(chatSessionProvider(_sessionId!))
        : null;

    // Scroll to bottom whenever messages change.
    if (sessionState?.value != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(FluentIcons.dismiss_24_regular),
          tooltip: l10n.close,
          onPressed: () => context.popOrHome(),
        ),
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                FluentIcons.sparkle_24_filled,
                size: 16,
                color: AppColors.onPrimary,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(l10n.aiAssistantTitle, style: AppTextStyles.titleMedium),
          ],
        ),
      ),
      body: _buildBody(context, sessionState, l10n),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AsyncValue<List<ChatMessage>>? sessionState,
    dynamic l10n,
  ) {
    // Session creation failed.
    if (_sessionError != null) {
      return _ErrorView(
        message: _sessionError!,
        onRetry: () {
          setState(() => _sessionError = null);
          _createSession();
        },
      );
    }

    // Session not yet created — show spinner.
    if (_sessionId == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Session exists but messages are loading/errored.
    if (sessionState == null || sessionState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (sessionState.hasError) {
      return _ErrorView(
        message: l10n.errorServer as String,
        onRetry: () =>
            ref.invalidate(chatSessionProvider(_sessionId!)),
      );
    }

    final messages = sessionState.value ?? [];

    return Column(
      children: [
        Expanded(
          child: messages.isEmpty
              ? _SuggestedPrompts(onTap: _handleSend)
              : ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.lg,
                    AppSpacing.lg,
                    AppSpacing.md,
                  ),
                  itemCount: messages.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.lg),
                  itemBuilder: (context, i) {
                    final msg = messages[i];

                    if (msg.role == ChatMessageRole.user) {
                      return Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: UserBubble(
                          text: msg.text,
                          timeLabel: '',
                        ),
                      );
                    }

                    // Streaming placeholder — show typing indicator until text arrives.
                    if (msg.status == ChatMessageStatus.streaming &&
                        msg.text.isEmpty &&
                        msg.blocks.isEmpty) {
                      return TypingIndicator(
                          botLabel: l10n.aiAssistantTitle as String);
                    }

                    // Bot message (streaming with partial text, or done).
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _BotMessageView(
                            message: msg,
                            botLabel: l10n.aiAssistantTitle as String),
                        if (msg.quickReplies.isNotEmpty) ...[
                          const SizedBox(height: AppSpacing.md),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              start: AppSpacing.xxl + AppSpacing.xs,
                            ),
                            child: QuickReplyChips(
                              labels: msg.quickReplies,
                              onTap: _handleQuickReply,
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
        ),
        ChatInputBar(
          hint: l10n.aiAskHint as String,
          onSend: _handleSend,
        ),
      ],
    );
  }
}

/// Adapts a [ChatMessage] (domain entity) to the [BotBubble] widget which
/// still uses the presentation [chat_message.dart] model.
class _BotMessageView extends StatelessWidget {
  const _BotMessageView({
    required this.message,
    required this.botLabel,
  });

  final ChatMessage message;
  final String botLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BotAvatar(),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                botLabel,
                style: AppTextStyles.labelSmall
                    .copyWith(color: AppColors.textTertiary),
              ),
              const SizedBox(height: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppSpacing.xs),
                    topRight: Radius.circular(AppSpacing.xl),
                    bottomLeft: Radius.circular(AppSpacing.xl),
                    bottomRight: Radius.circular(AppSpacing.xl),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textPrimary.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (message.text.isNotEmpty)
                      Text(message.text, style: AppTextStyles.bodyMedium),

                    if (message.blocks.isNotEmpty) ...[
                      if (message.text.isNotEmpty)
                        const SizedBox(height: AppSpacing.md),
                      ...message.blocks.map(
                        (block) => Padding(
                          padding:
                              const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: _BlockView(block: block),
                        ),
                      ),
                    ],

                    if (message.footerText != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              message.footerText!,
                              style: AppTextStyles.bodySmall,
                            ),
                          ),
                          if (message.footerActionLabel != null) ...[
                            const SizedBox(width: AppSpacing.sm),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                message.footerActionLabel!,
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: AppColors.secondary,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],

                    if (message.status == ChatMessageStatus.error)
                      Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.sm),
                        child: Text(
                          '⚠ Response failed. Please try again.',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Renders a single [ChatBlock] — tip card or plain-text fallback.
class _BlockView extends StatelessWidget {
  const _BlockView({required this.block});

  final ChatBlock block;

  @override
  Widget build(BuildContext context) {
    final resolved = block.resolved;

    // Plain-text fallback block (kind == "text" or no resolved style).
    if (resolved == null) {
      return Text(block.body, style: AppTextStyles.bodySmall);
    }

    final isProTip = resolved.isProTip;
    final bg = isProTip ? AppColors.primarySoft : AppColors.background;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        border: isProTip
            ? Border.all(color: AppColors.primary.withValues(alpha: 0.25))
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: resolved.iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppSpacing.sm),
            ),
            child: Icon(resolved.icon, size: 17, color: resolved.iconColor),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (block.title != null)
                  RichText(
                    text: TextSpan(
                      children: [
                        if (isProTip)
                          TextSpan(
                            text: 'Pro-Tip: ',
                            style: AppTextStyles.labelMedium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        TextSpan(
                          text: block.title,
                          style: AppTextStyles.titleSmall,
                        ),
                      ],
                    ),
                  ),
                if (block.title != null) const SizedBox(height: AppSpacing.xs),
                Text(block.body, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BotAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        FluentIcons.sparkle_24_filled,
        size: 18,
        color: AppColors.onPrimary,
      ),
    );
  }
}

// ── Suggested prompts ────────────────────────────────────────────────────────

class _Prompt {
  const _Prompt({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.message,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String message;
}

const _kPrompts = [
  _Prompt(
    icon: FluentIcons.food_24_filled,
    iconColor: AppColors.primary,
    label: 'Nutrition',
    message: 'What should I feed my pet for a healthy diet?',
  ),
  _Prompt(
    icon: FluentIcons.heart_pulse_24_filled,
    iconColor: AppColors.secondary,
    label: 'Symptoms',
    message: 'My pet seems unwell — what symptoms should I watch for?',
  ),
  _Prompt(
    icon: FluentIcons.syringe_24_filled,
    iconColor: AppColors.primaryDark,
    label: 'Vaccinations',
    message: 'What vaccinations does my pet need and when?',
  ),
  _Prompt(
    icon: FluentIcons.animal_cat_24_filled,
    iconColor: AppColors.secondary,
    label: 'Breed Info',
    message: 'Tell me about my pet\'s breed characteristics and care needs.',
  ),
];

class _SuggestedPrompts extends StatelessWidget {
  const _SuggestedPrompts({required this.onTap});

  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              FluentIcons.sparkle_24_filled,
              size: 24,
              color: AppColors.onPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Hi! I\'m PawBot 👋',
            style: AppTextStyles.titleLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Ask me anything about your pet\'s health, nutrition, or care. Here are some topics to get you started:',
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.xl),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.5,
            children: _kPrompts
                .map((p) => _PromptCard(prompt: p, onTap: onTap))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _PromptCard extends StatelessWidget {
  const _PromptCard({required this.prompt, required this.onTap});

  final _Prompt prompt;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(prompt.message),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.lg),
          border: Border.all(color: AppColors.divider),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: prompt.iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
              child: Icon(prompt.icon, size: 17, color: prompt.iconColor),
            ),
            const Spacer(),
            Text(
              prompt.label,
              style: AppTextStyles.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Error view ────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              FluentIcons.warning_24_regular,
              size: 48,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(
              onPressed: onRetry,
              child: Text(context.l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}
