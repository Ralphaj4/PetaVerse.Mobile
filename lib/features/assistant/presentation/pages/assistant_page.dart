import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/analytics/analytics_service.dart';
import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../community/presentation/models/pawhub_models.dart';
import '../../../community/presentation/widgets/pawhub_common.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../domain/entities/chat_entities.dart';
import '../providers/assistant_providers.dart';
import '../widgets/bot_bubble.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/markdown_text.dart';
import '../widgets/quick_reply_chips.dart';
import '../widgets/typing_indicator.dart';
import '../widgets/user_bubble.dart';

/// The AI assistant chat screen.
///
/// Lifecycle:
///   1. Opens → creates a chat session scoped to the active pet (its id is
///      always sent to `POST /sessions`).
///   2. User sends → [ChatSessionNotifier.send()] optimistically appends
///      messages and folds SSE stream events into state.
///   3. User can switch which pet the conversation is about via the app-bar
///      pet chip. Switching starts a fresh session for the newly-selected pet
///      (with a confirm dialog first if a conversation is already underway).
///   4. Widgets (BotBubble, TipSectionItem, QuickReplyChips) render unchanged
///      — the data layer resolved iconName/color to real Flutter constants.
class AssistantPage extends ConsumerStatefulWidget {
  const AssistantPage({this.petId, this.sessionId, super.key});

  /// When launched from a pet's profile a *new* chat is scoped to that pet.
  /// When null (e.g. opened from the tab bar) the current pet is used.
  final int? petId;

  /// When opening an existing conversation from the history page, its id.
  /// Takes precedence over [petId] — the chat's pet comes from the session.
  final int? sessionId;

  @override
  ConsumerState<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends ConsumerState<AssistantPage> {
  final ScrollController _scrollController = ScrollController();

  /// The pet a *new* chat is scoped to. Sent to `POST /sessions` when the
  /// session is created lazily on the first message.
  int? _petId;

  /// The active session id, or null when no session exists yet. A session is
  /// created lazily — see [_handleSend]. It's non-null immediately only when
  /// opening an existing conversation from history.
  int? _sessionId;

  /// True while the lazy `POST /sessions` is in flight (first send).
  bool _creatingSession = false;

  /// Set if the lazy session creation failed, so the send can be retried.
  String? _sessionError;

  @override
  void initState() {
    super.initState();
    if (widget.sessionId != null) {
      // Opening an existing conversation — the session already exists.
      _sessionId = widget.sessionId;
      _isOpenedSession = true;
    } else {
      // New chat: scope to the launch pet, else the app-wide current pet. The
      // routing gate guarantees the user always has at least one pet. No
      // session is created until the first message is sent.
      _petId = widget.petId ?? ref.read(petsProvider).currentPetId;
    }
    ref.read(analyticsServiceProvider).logEvent('ai_chat_started');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Ensures a session exists, creating one lazily for [_petId] if needed.
  /// Returns the session id, or null if creation failed.
  Future<int?> _ensureSession() async {
    if (_sessionId != null) return _sessionId;

    setState(() {
      _creatingSession = true;
      _sessionError = null;
    });

    final result = await ref
        .read(assistantRepositoryProvider)
        .createSession(petId: _petId);

    if (!mounted) return null;

    return result.when(
      success: (session) {
        setState(() {
          _sessionId = session.id;
          _creatingSession = false;
        });
        // The history list now has a new entry.
        ref.invalidate(chatHistoryProvider);
        return session.id;
      },
      failure: (f) {
        setState(() {
          _creatingSession = false;
          _sessionError = context.l10n.errorServer;
        });
        return null;
      },
    );
  }

  void _openHistory() {
    // The history page pushes its own assistant instance for the chosen
    // conversation, so the opened chat gets a back button to this list rather
    // than replacing the view here.
    context.push(AppRoutes.assistantHistory);
  }

  /// The user's pets as [PawPet]s, reusing PawHub's switcher model so the AI
  /// page shows the exact same pet-picker widget as the community feed.
  List<PawPet> _pawPets() => ref
      .read(petsProvider)
      .refs
      .map((r) => PawPet(
            id: r.id.toString(),
            backendId: r.id,
            name: r.name,
            breed: '',
            species: '',
            avatarUrl: r.imagePath,
            ownerName: '',
            isMine: true,
          ))
      .toList();

  /// True when the on-screen session was opened from history rather than being
  /// a new chat composed here, so its pet is fixed and the switcher is hidden.
  bool _isOpenedSession = false;

  /// The [PawPet] the conversation is currently about (for the app-bar pill).
  PawPet? _currentPawPet() {
    for (final p in _pawPets()) {
      if (p.backendId == _petId) return p;
    }
    return null;
  }

  /// True once the current session has at least one exchanged message — used
  /// to decide whether switching pets needs a confirm.
  bool get _conversationStarted {
    if (_sessionId == null) return false;
    final msgs = ref.read(chatSessionProvider(_sessionId!)).value ?? const [];
    return msgs.isNotEmpty;
  }

  /// Opens the shared PawHub pet-switcher sheet; on choosing a *different* pet,
  /// re-scopes the chat to it. Switching does NOT create a session — that
  /// happens lazily on the first message (see [_handleSend]).
  Future<void> _openPetSwitcher() async {
    final pets = _pawPets();
    final current = _currentPawPet();
    if (pets.length < 2 || current == null || _isOpenedSession) return;

    final chosen = await showPetSwitcherSheet(
      context,
      pets: pets,
      current: current,
      title: context.l10n.aiSwitchPetTitle,
      showMyPostsLink: false,
    );

    if (chosen == null || chosen.backendId == _petId || !mounted) return;
    await _switchToPet(chosen);
  }

  Future<void> _switchToPet(PawPet pet) async {
    // If the current chat already has messages, its session is saved in
    // history; confirm before replacing the view with a fresh empty chat.
    if (_conversationStarted) {
      final confirmed = await _confirmSwitch(pet.name);
      if (confirmed != true || !mounted) return;
    }

    // Point the app-wide selection at the chosen pet and reset to a fresh
    // empty chat scoped to it. No session is created yet.
    ref.read(petsProvider.notifier).selectPet(pet.backendId);
    setState(() {
      _petId = pet.backendId;
      _sessionId = null;
      _sessionError = null;
      _creatingSession = false;
    });
  }

  Future<bool?> _confirmSwitch(String petName) {
    final l10n = context.l10n;
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(l10n.aiSwitchConfirmTitle, style: AppTextStyles.titleMedium),
        content: Text(
          l10n.aiSwitchConfirmBody(petName),
          style: AppTextStyles.bodyMedium
              .copyWith(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.aiSwitchConfirmAction),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSend(String text) async {
    if (_creatingSession) return;

    // Lazy: create the session for this pet on the first message, then send.
    final sessionId = await _ensureSession();
    if (sessionId == null || !mounted) return; // creation failed

    // Let the session provider finish its initial load before sending, so the
    // provider's build() doesn't resolve *after* send() and clobber the
    // optimistic messages. For a just-created session this returns [] fast.
    try {
      await ref.read(chatSessionProvider(sessionId).future);
    } catch (_) {
      // A load error surfaces via the watched AsyncValue in build(); the
      // error view offers a retry. Don't send onto an errored session.
      return;
    }
    if (!mounted) return;

    unawaited(ref.read(chatSessionProvider(sessionId).notifier).send(text));
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

    // The pet shown in the app-bar switcher pill (null hides it).
    final pillPet = _currentPawPet();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        leading: IconButton(
          // Opened from history: a back arrow returning to the list. A fresh
          // chat: a dismiss "X" that closes the assistant.
          icon: Icon(
            _isOpenedSession
                ? FluentIcons.arrow_left_24_regular
                : FluentIcons.dismiss_24_regular,
          ),
          tooltip: _isOpenedSession ? l10n.back : l10n.close,
          onPressed: () => context.popOrHome(),
        ),
        titleSpacing: 0,
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
            Flexible(
              child: Text(
                l10n.aiAssistantTitle,
                style: AppTextStyles.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(FluentIcons.history_24_regular),
            tooltip: l10n.aiHistoryTooltip,
            onPressed: _openHistory,
          ),
          // Pet-switcher pill at the far right (for a new chat). Hidden while
          // viewing an existing conversation opened from history.
          if (!_isOpenedSession && pillPet != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: AppSpacing.md),
              child: Center(
                child: PetSwitcherPill(pet: pillPet, onTap: _openPetSwitcher),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildBody(context, sessionState, l10n)),
          ChatInputBar(
            hint: l10n.aiAskHint,
            onSend: _handleSend,
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AsyncValue<List<ChatMessage>>? sessionState,
    dynamic l10n,
  ) {
    // Lazy session creation failed on send — let the user retry.
    if (_sessionError != null) {
      return _ErrorView(
        message: _sessionError!,
        onRetry: () => setState(() => _sessionError = null),
      );
    }

    // No session yet (new/empty chat) — show the suggested prompts. Typing in
    // the input bar (or tapping a prompt) creates the session lazily.
    if (_sessionId == null) {
      if (_creatingSession) {
        return const Center(child: CircularProgressIndicator());
      }
      return _SuggestedPrompts(onTap: _handleSend);
    }

    // Session exists but its history is still loading (opened from history).
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

    return messages.isEmpty
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
                      MarkdownText(message.text,
                          style: AppTextStyles.bodyMedium),

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
      return MarkdownText(block.body, style: AppTextStyles.bodySmall);
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
                MarkdownText(block.body, style: AppTextStyles.bodySmall),
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
    required this.category,
    required this.question,
  });

  final IconData icon;
  final Color iconColor;

  /// Short category chip label, resolved from l10n at build time.
  final String Function(dynamic l10n) category;

  /// The actual question shown on the tile *and* sent when tapped, so the
  /// user always sees exactly what they're asking.
  final String Function(dynamic l10n) question;
}

final _kPrompts = <_Prompt>[
  _Prompt(
    icon: FluentIcons.food_24_filled,
    iconColor: AppColors.primary,
    category: (l10n) => l10n.aiCatNutrition as String,
    question: (l10n) => l10n.aiPromptNutrition as String,
  ),
  _Prompt(
    icon: FluentIcons.heart_pulse_24_filled,
    iconColor: AppColors.accentCoral,
    category: (l10n) => l10n.aiCatSymptoms as String,
    question: (l10n) => l10n.aiPromptSymptoms as String,
  ),
  _Prompt(
    icon: FluentIcons.syringe_24_filled,
    iconColor: AppColors.secondary,
    category: (l10n) => l10n.aiCatVaccinations as String,
    question: (l10n) => l10n.aiPromptVaccinations as String,
  ),
  _Prompt(
    icon: FluentIcons.animal_cat_24_filled,
    iconColor: AppColors.accentPurple,
    category: (l10n) => l10n.aiCatBreed as String,
    question: (l10n) => l10n.aiPromptBreed as String,
  ),
];

class _SuggestedPrompts extends StatelessWidget {
  const _SuggestedPrompts({required this.onTap});

  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
          Text(l10n.aiGreeting, style: AppTextStyles.titleLarge),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.aiIntro,
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            l10n.aiSuggestedLabel.toUpperCase(),
            style: AppTextStyles.labelSmall,
          ),
          const SizedBox(height: AppSpacing.md),
          // Full-width rows: each shows the real question, so it's always
          // clear what tapping will ask. (Replaces the old 2×2 grid of
          // ambiguous one-word tiles.)
          for (var i = 0; i < _kPrompts.length; i++) ...[
            _PromptCard(prompt: _kPrompts[i], onTap: onTap),
            if (i != _kPrompts.length - 1)
              const SizedBox(height: AppSpacing.md),
          ],
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
    final l10n = context.l10n;
    final question = prompt.question(l10n);

    return Semantics(
      button: true,
      label: question,
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        child: InkWell(
          onTap: () => onTap(question),
          borderRadius: BorderRadius.circular(AppSpacing.lg),
          child: Ink(
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
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: prompt.iconColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppSpacing.md),
                  ),
                  child: Icon(prompt.icon, size: 20, color: prompt.iconColor),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prompt.category(l10n).toUpperCase(),
                        style: AppTextStyles.labelSmall
                            .copyWith(color: prompt.iconColor),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        question,
                        style: AppTextStyles.titleSmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const Icon(
                  FluentIcons.arrow_up_right_24_regular,
                  size: 16,
                  color: AppColors.textTertiary,
                ),
              ],
            ),
          ),
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
