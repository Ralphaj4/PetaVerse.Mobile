import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/chat_message.dart';
import '../widgets/bot_bubble.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/health_vault_card.dart';
import '../widgets/quick_reply_chips.dart';
import '../widgets/user_bubble.dart';

// ── Mock initial conversation ────────────────────────────────────────
List<ChatMessage> _initialMessages() => [
      const ChatMessage(
        id: 'u1',
        sender: MessageSender.user,
        text:
            'Hi PawBot! I just adopted a Golden Retriever. Can you give me some advice on Golden Retriever nutrition? What should be looking for in their food?',
      ),
      const ChatMessage(
        id: 'b1',
        sender: MessageSender.bot,
        text:
            'Congratulations on your new companion! Golden Retrievers are prone to joint issues and weight gain, so their diet requires careful management.',
        tips: [
          TipSection(
            icon: FluentIcons.food_24_filled,
            iconColor: AppColors.primary,
            title: 'Weight Management',
            body:
                'Look for high-quality protein (chicken/lamb) and moderate fat. Avoid "filler" carbs like corn to prevent obesity.',
          ),
          TipSection(
            icon: FluentIcons.heart_pulse_24_filled,
            iconColor: AppColors.secondary,
            title: 'Joint Health',
            body:
                'Essential nutrients like Glucosamine and Chondroitin help support their prone-to-dysplasia joints.',
          ),
          TipSection(
            icon: FluentIcons.sparkle_24_filled,
            iconColor: AppColors.primaryDark,
            title: 'Omega Fatty Acids',
            body:
                'To maintain that signature golden coat, ensure the food has Omega-3 and Omega-6 fatty acids (Fish oil is excellent!).',
            style: TipStyle.proTip,
          ),
        ],
        footerText: 'Would you like me to recommend specific brands for Goldens?',
        footerActionLabel: 'View Feeding Chart',
        quickReplies: ['FAQs', 'BreedInfo', 'Symptom Checker'],
      ),
    ];

class AssistantPage extends StatefulWidget {
  const AssistantPage({super.key});

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  final ScrollController _scrollController = ScrollController();
  late final List<ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    _messages = _initialMessages();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSend(String text) {
    setState(() {
      _messages.add(ChatMessage(
        id: 'u${_messages.length}',
        sender: MessageSender.user,
        text: text,
      ));
    });
    _scrollToBottom();
    // Stub bot response — replace with real API call via provider.
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      setState(() {
        _messages.add(ChatMessage(
          id: 'b${_messages.length}',
          sender: MessageSender.bot,
          text: "Great question! I'm looking that up for you right now…",
        ));
      });
      _scrollToBottom();
    });
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
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              itemCount: _messages.length + 1, // +1 for vault card
              separatorBuilder: (context, i) =>
                  const SizedBox(height: AppSpacing.lg),
              itemBuilder: (context, i) {
                // Health Vault card rendered after the last message.
                if (i == _messages.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.md),
                    child: HealthVaultCard(
                      title: l10n.aiHealthVaultTitle,
                      subtitle: l10n.aiHealthVaultSubtitle('your Golden Retriever'),
                      onTap: () {},
                    ),
                  );
                }

                final msg = _messages[i];
                if (msg.sender == MessageSender.user) {
                  return Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: UserBubble(
                      text: msg.text,
                      timeLabel: 'Sarah • 10:21 AM',
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BotBubble(
                      message: msg,
                      botLabel: l10n.aiAssistantTitle,
                    ),
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
            hint: l10n.aiAskHint,
            onSend: _handleSend,
          ),
        ],
      ),
    );
  }
}
