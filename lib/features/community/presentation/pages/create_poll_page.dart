import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/poll_event_entities.dart';
import '../providers/community_providers.dart';
import '../providers/poll_event_actions_providers.dart';
import '../widgets/poll_event_form_widgets.dart';

/// Form to create a poll inside a community. Returns the created [Poll] via
/// Navigator.pop so the caller can prepend it to the feed.
class CreatePollPage extends ConsumerStatefulWidget {
  const CreatePollPage({
    required this.communityId,
    required this.communityName,
    super.key,
  });

  final int communityId;
  final String communityName;

  @override
  ConsumerState<CreatePollPage> createState() => _CreatePollPageState();
}

class _CreatePollPageState extends ConsumerState<CreatePollPage> {
  final _question = TextEditingController();
  final _description = TextEditingController();
  // Start with two option fields (the minimum).
  final List<TextEditingController> _options = [
    TextEditingController(),
    TextEditingController(),
  ];
  bool _allowMultiple = false;
  DateTime? _expiresAt;
  bool _submitting = false;

  static const int _maxOptions = 10;

  @override
  void initState() {
    super.initState();
    _question.addListener(_onChanged);
    for (final c in _options) {
      c.addListener(_onChanged);
    }
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    _question.dispose();
    _description.dispose();
    for (final c in _options) {
      c.dispose();
    }
    super.dispose();
  }

  List<String> get _cleanOptions =>
      _options.map((c) => c.text.trim()).where((t) => t.isNotEmpty).toList();

  bool get _canSubmit =>
      _question.text.trim().isNotEmpty && _cleanOptions.length >= 2;

  void _addOption() {
    if (_options.length >= _maxOptions) return;
    final c = TextEditingController()..addListener(_onChanged);
    setState(() => _options.add(c));
  }

  void _removeOption(int i) {
    if (_options.length <= 2) return;
    final c = _options.removeAt(i);
    c.dispose();
    setState(() {});
  }

  Future<void> _pickExpiry() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      firstDate: now.add(const Duration(hours: 1)),
      lastDate: now.add(const Duration(days: 365)),
      initialDate: _expiresAt ?? now.add(const Duration(days: 7)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
          _expiresAt ?? now.add(const Duration(days: 7))),
    );
    if (!mounted) return;
    setState(() {
      _expiresAt = DateTime(
        date.year,
        date.month,
        date.day,
        time?.hour ?? 23,
        time?.minute ?? 59,
      );
    });
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    final petId = ref.read(actingPetIdProvider);
    if (petId == null || !_canSubmit || _submitting) return;

    setState(() => _submitting = true);
    final result = await ref.read(pollEventActionsProvider).createPoll(
          communityId: widget.communityId,
          creatorPetId: petId,
          title: _question.text.trim(),
          description: _description.text.trim().isEmpty
              ? null
              : _description.text.trim(),
          options: _cleanOptions,
          allowMultipleVotes: _allowMultiple,
          expiresAt: _expiresAt,
        );
    if (!mounted) return;
    setState(() => _submitting = false);

    result.when(
      success: (poll) {
        unawaited(HapticFeedback.mediumImpact());
        Navigator.of(context).pop(poll);
      },
      failure: (f) => ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(f.localizedMessage(l10n)),
        )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.backgroundWarm,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWarm,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          tooltip: l10n.close,
          icon: const Icon(FluentIcons.dismiss_24_regular),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(l10n.pollNewTitle, style: AppTextStyles.titleLarge),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.lg),
            child: SubmitPillButton(
              label: l10n.pollCreateSubmit,
              enabled: _canSubmit && !_submitting,
              busy: _submitting,
              onPressed: _submit,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          PostingInBanner(name: widget.communityName),
          const SizedBox(height: AppSpacing.md),
          // Question.
          FormCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.pollQuestionLabel, style: AppTextStyles.titleSmall),
                const SizedBox(height: AppSpacing.sm),
                FormField2(
                  controller: _question,
                  hint: l10n.pollQuestionHint,
                  maxLength: 200,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(l10n.pollDescriptionLabel,
                    style: AppTextStyles.titleSmall),
                const SizedBox(height: AppSpacing.sm),
                FormField2(
                  controller: _description,
                  hint: l10n.pollDescriptionHint,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Options.
          FormCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.pollOptionsLabel, style: AppTextStyles.titleSmall),
                const SizedBox(height: AppSpacing.sm),
                for (var i = 0; i < _options.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: Row(
                      children: [
                        Expanded(
                          child: FormField2(
                            controller: _options[i],
                            hint: l10n.pollOptionHint(i + 1),
                            maxLength: 200,
                          ),
                        ),
                        if (_options.length > 2)
                          IconButton(
                            tooltip: l10n.pawhubRemoveOption,
                            icon: const Icon(
                                FluentIcons.subtract_circle_24_regular,
                                color: AppColors.textTertiary),
                            onPressed: () => _removeOption(i),
                          ),
                      ],
                    ),
                  ),
                if (_options.length < _maxOptions)
                  TextButton.icon(
                    onPressed: _addOption,
                    icon: const Icon(FluentIcons.add_24_regular, size: 18),
                    label: Text(l10n.pollAddOption),
                    style: TextButton.styleFrom(
                        foregroundColor: AppColors.secondary),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Settings.
          FormCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SwitchListTile.adaptive(
                  value: _allowMultiple,
                  onChanged: (v) => setState(() => _allowMultiple = v),
                  activeThumbColor: AppColors.secondary,
                  title: Text(l10n.pollAllowMultiple,
                      style: AppTextStyles.bodyMedium),
                  subtitle: Text(l10n.pollAllowMultipleSubtitle,
                      style: AppTextStyles.labelSmall
                          .copyWith(color: AppColors.textSecondary)),
                ),
                const Divider(height: 1, indent: AppSpacing.lg, endIndent: AppSpacing.lg),
                ListTile(
                  leading: const Icon(FluentIcons.calendar_clock_24_regular,
                      color: AppColors.secondary),
                  title: Text(l10n.pollSetExpiry,
                      style: AppTextStyles.bodyMedium),
                  subtitle: Text(
                    _expiresAt == null
                        ? l10n.pollNoExpiry
                        : formatDateTimeLabel(context, _expiresAt!),
                    style: AppTextStyles.labelSmall
                        .copyWith(color: AppColors.textSecondary),
                  ),
                  trailing: _expiresAt == null
                      ? const Icon(FluentIcons.chevron_right_24_regular,
                          size: 18, color: AppColors.textTertiary)
                      : IconButton(
                          tooltip: l10n.clear,
                          icon: const Icon(FluentIcons.dismiss_24_regular,
                              size: 18),
                          onPressed: () => setState(() => _expiresAt = null),
                        ),
                  onTap: _pickExpiry,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}
