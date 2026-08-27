import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../providers/pawcare_providers.dart';
import '../widgets/health_form_fields.dart';

/// Adds a pet appointment: title, date + time, optional location and notes.
/// On success it invalidates [petAppointmentsProvider] and pops.
class AddAppointmentPage extends ConsumerStatefulWidget {
  const AddAppointmentPage({required this.petId, super.key});

  final int petId;

  @override
  ConsumerState<AddAppointmentPage> createState() =>
      _AddAppointmentPageState();
}

class _AddAppointmentPageState extends ConsumerState<AddAppointmentPage> {
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime _scheduledAt = DateTime.now().add(const Duration(days: 1));
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _scheduledAt,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (pickedDate == null || !mounted) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_scheduledAt),
    );
    if (!mounted) return;
    setState(() {
      _scheduledAt = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime?.hour ?? _scheduledAt.hour,
        pickedTime?.minute ?? _scheduledAt.minute,
      );
    });
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      setState(() => _error = l10n.appointmentsTitleRequired);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });

    final result = await ref.read(pawCareRepositoryProvider).addAppointment(
          widget.petId,
          title: title,
          scheduledAt: _scheduledAt,
          location: _locationController.text.trim().isEmpty
              ? null
              : _locationController.text.trim(),
          notes: _notesController.text.trim().isEmpty
              ? null
              : _notesController.text.trim(),
        );
    if (!mounted) return;
    setState(() => _saving = false);

    result.when(
      success: (_) {
        ref.invalidate(petAppointmentsProvider(widget.petId));
        context.showSuccessSnackBar(l10n.appointmentsAddedSuccess);
        context.pop();
      },
      failure: (f) => setState(() => _error = f.localizedMessage(l10n)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(l10n.appointmentsAdd),
        leading: IconButton(
          icon: Icon(
            context.isRtl
                ? FluentIcons.arrow_right_24_regular
                : FluentIcons.arrow_left_24_regular,
          ),
          onPressed: () => context.popOrHome(),
        ),
      ),
      body: FormBuilder(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            // ── Title ──────────────────────────────────────────────────────
            HealthFieldLabel(l10n.appointmentsTitleLabel),
            const SizedBox(height: AppSpacing.sm),
            HealthTextField(
              controller: _titleController,
              autofocus: true,
              hint: l10n.appointmentsTitleHint,
              textCapitalization: TextCapitalization.words,
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
            ),
            if (_error != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                _error!,
                style:
                    AppTextStyles.bodySmall.copyWith(color: AppColors.error),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),

            // ── Date & time ────────────────────────────────────────────────
            HealthFieldLabel(l10n.appointmentsDateLabel),
            const SizedBox(height: AppSpacing.sm),
            HealthDateField(
              label: DateFormat.yMMMMd(locale).add_jm().format(_scheduledAt),
              onTap: _pickDateTime,
            ),
            const SizedBox(height: AppSpacing.lg),

            // ── Location (optional) ────────────────────────────────────────
            HealthFieldLabel(l10n.appointmentsLocationLabel),
            const SizedBox(height: AppSpacing.sm),
            HealthTextField(
              controller: _locationController,
              hint: l10n.appointmentsLocationHint,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: AppSpacing.lg),

            // ── Notes (optional) ───────────────────────────────────────────
            HealthFieldLabel(l10n.healthNotesLabel),
            const SizedBox(height: AppSpacing.sm),
            HealthTextField(
              controller: _notesController,
              hint: l10n.healthNotesHint,
            ),
            const SizedBox(height: AppSpacing.xxl),

            AppButton(
              label: l10n.save,
              icon: FluentIcons.checkmark_24_regular,
              variant: AppButtonVariant.primary,
              isLoading: _saving,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
