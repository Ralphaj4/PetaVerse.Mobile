import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../domain/entities/grooming_schedule.dart';
import '../providers/pawcare_providers.dart';
import '../widgets/care_schedule_pickers.dart';
import '../widgets/health_form_fields.dart';

/// Create / edit a pet's grooming schedule: a recurrence interval in days and
/// the next-due date. Reminders are server-pushed (FCM); saving only stores the
/// schedule. A configured schedule also offers "mark groomed" (advances the due
/// date server-side) and delete.
class EditGroomingSchedulePage extends ConsumerWidget {
  const EditGroomingSchedulePage({required this.petId, super.key});

  final int petId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final scheduleAsync = ref.watch(petGroomingScheduleProvider(petId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(l10n.groomingTitle),
        leading: IconButton(
          icon: Icon(
            context.isRtl
                ? FluentIcons.arrow_right_24_regular
                : FluentIcons.arrow_left_24_regular,
          ),
          onPressed: () => context.popOrHome(),
        ),
      ),
      body: scheduleAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorStateWidget(
          failure: e is Failure ? e : null,
          onRetry: () => ref.invalidate(petGroomingScheduleProvider(petId)),
        ),
        data: (schedule) => _GroomingForm(petId: petId, initial: schedule),
      ),
    );
  }
}

class _GroomingForm extends ConsumerStatefulWidget {
  const _GroomingForm({required this.petId, required this.initial});

  final int petId;
  final GroomingSchedule? initial;

  @override
  ConsumerState<_GroomingForm> createState() => _GroomingFormState();
}

class _GroomingFormState extends ConsumerState<_GroomingForm> {
  late int _intervalDays;
  late DateTime _nextDueDate;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    _intervalDays = initial?.intervalDays ?? 21; // ~3 weeks is a common cadence
    _nextDueDate = initial?.nextDueDate ??
        DateTime.now().add(Duration(days: _intervalDays));
  }

  Future<void> _pickInterval() async {
    final picked = await showGroomingIntervalSheet(context, _intervalDays);
    if (picked != null) setState(() => _intervalDays = picked);
  }

  Future<void> _pickNextDue() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _nextDueDate.isBefore(now) ? now : _nextDueDate,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 10),
    );
    if (picked != null) setState(() => _nextDueDate = picked);
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    setState(() {
      _saving = true;
      _error = null;
    });

    final result =
        await ref.read(pawCareRepositoryProvider).saveGroomingSchedule(
              widget.petId,
              intervalDays: _intervalDays,
              nextDueDate: _nextDueDate,
              lastGroomedDate: widget.initial?.lastGroomedDate,
            );
    if (!mounted) return;
    setState(() => _saving = false);

    result.when(
      success: (_) {
        ref.invalidate(petGroomingScheduleProvider(widget.petId));
        context.showSuccessSnackBar(l10n.groomingSaved);
        context.pop();
      },
      failure: (f) => setState(() => _error = f.localizedMessage(l10n)),
    );
  }

  Future<void> _markGroomed() async {
    final l10n = context.l10n;
    setState(() => _saving = true);
    final result =
        await ref.read(pawCareRepositoryProvider).markGroomed(widget.petId);
    if (!mounted) return;
    setState(() => _saving = false);
    result.when(
      success: (updated) {
        ref.invalidate(petGroomingScheduleProvider(widget.petId));
        setState(() {
          _nextDueDate = updated.nextDueDate;
          _intervalDays = updated.intervalDays;
        });
        context.showSuccessSnackBar(l10n.groomingMarkedGroomed);
      },
      failure: (f) => context.showErrorSnackBar(f.localizedMessage(l10n)),
    );
  }

  Future<void> _delete() async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.groomingDeleteTitle),
        content: Text(l10n.groomingDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.delete,
                style: const TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() => _saving = true);
    final result = await ref
        .read(pawCareRepositoryProvider)
        .deleteGroomingSchedule(widget.petId);
    if (!mounted) return;
    setState(() => _saving = false);
    result.when(
      success: (_) {
        ref.invalidate(petGroomingScheduleProvider(widget.petId));
        context.showSuccessSnackBar(l10n.groomingDeleted);
        context.pop();
      },
      failure: (f) => context.showErrorSnackBar(f.localizedMessage(l10n)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final hasExisting = widget.initial != null;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // ── Interval ──────────────────────────────────────────────────────────
        HealthFieldLabel(l10n.groomingIntervalLabel),
        const SizedBox(height: AppSpacing.sm),
        HealthPickerField(
          icon: FluentIcons.arrow_repeat_all_24_regular,
          label: l10n.groomingEveryDays(_intervalDays),
          onTap: _pickInterval,
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Next due ──────────────────────────────────────────────────────────
        HealthFieldLabel(l10n.groomingNextDueLabel),
        const SizedBox(height: AppSpacing.sm),
        HealthDateField(
          label: DateFormat.yMMMMd(locale).format(_nextDueDate),
          onTap: _pickNextDue,
        ),

        if (hasExisting) ...[
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            label: l10n.groomingMarkGroomed,
            icon: FluentIcons.checkmark_circle_24_regular,
            variant: AppButtonVariant.outlined,
            onPressed: _saving ? null : _markGroomed,
          ),
        ],

        if (_error != null) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            _error!,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
          ),
        ],
        const SizedBox(height: AppSpacing.xl),

        AppButton(
          label: l10n.save,
          icon: FluentIcons.checkmark_24_regular,
          variant: AppButtonVariant.primary,
          isLoading: _saving,
          onPressed: _save,
        ),

        if (hasExisting) ...[
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: l10n.groomingDelete,
            icon: FluentIcons.delete_24_regular,
            variant: AppButtonVariant.text,
            onPressed: _saving ? null : _delete,
          ),
        ],
      ],
    );
  }
}
