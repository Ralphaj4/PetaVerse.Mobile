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
import '../../../../shared/widgets/app_dropdown_field.dart';
import '../../domain/entities/health_lookup.dart';
import '../providers/pawcare_providers.dart';
import '../widgets/health_form_fields.dart';
import '../widgets/medication_frequency.dart';

/// Adds a medication schedule: pick a medication from the lookup (or enter a
/// custom name), choose a frequency (preset or custom days), and set the start
/// date. On success it invalidates the health providers and pops.
class AddMedicationPage extends ConsumerStatefulWidget {
  const AddMedicationPage({required this.petId, super.key});

  final int petId;

  @override
  ConsumerState<AddMedicationPage> createState() => _AddMedicationPageState();
}

class _AddMedicationPageState extends ConsumerState<AddMedicationPage> {
  /// Chosen lookup medication id, or null when using a custom name.
  int? _medicationId;
  final _customController = TextEditingController();
  bool _useCustom = false;

  int _frequencyDays = 30;
  DateTime _startDate = DateTime.now();
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  Future<void> _pickFrequency() async {
    final picked = await showMedicationFrequencySheet(context, _frequencyDays);
    if (picked != null) setState(() => _frequencyDays = picked);
  }

  Future<void> _pickStartDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
    );
    if (picked != null) setState(() => _startDate = picked);
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final customName = _customController.text.trim();
    final hasSelection = _medicationId != null && !_useCustom;
    final hasCustom = _useCustom && customName.isNotEmpty;
    if (!hasSelection && !hasCustom) {
      setState(() => _error = l10n.healthMedicationsNameRequired);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });

    final result = await ref.read(pawCareRepositoryProvider).addMedication(
          widget.petId,
          medicationId: hasSelection ? _medicationId : null,
          customMedicationName: hasCustom ? customName : null,
          frequencyDays: _frequencyDays,
          startDate: _startDate,
        );
    if (!mounted) return;
    setState(() => _saving = false);

    result.when(
      success: (_) {
        ref.invalidate(petHealthSnapshotProvider(widget.petId));
        ref.invalidate(petHealthScoreProvider(widget.petId));
        ref.invalidate(petMedicationsProvider(widget.petId));
        context.showSuccessSnackBar(l10n.healthMedicationsAddedSuccess);
        context.pop();
      },
      failure: (f) => setState(() => _error = f.localizedMessage(l10n)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final lookupsAsync = ref.watch(medicationLookupsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(l10n.healthMedicationsAdd),
        leading: IconButton(
          icon: Icon(
            context.isRtl
                ? FluentIcons.arrow_right_24_regular
                : FluentIcons.arrow_left_24_regular,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: FormBuilder(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            // ── Medication (lookup dropdown OR custom) ─────────────────────
            if (!_useCustom)
              HealthCard(
                child: _MedicationDropdown(
                  lookupsAsync: lookupsAsync,
                  selectedId: _medicationId,
                  onChanged: (id) => setState(() {
                    _medicationId = id;
                    _error = null;
                  }),
                  onRetry: () =>
                      ref.invalidate(medicationLookupsProvider),
                ),
              )
            else ...[
              HealthFieldLabel(l10n.healthMedicationsNameLabel),
              const SizedBox(height: AppSpacing.sm),
              HealthTextField(
                controller: _customController,
                autofocus: true,
                hint: l10n.healthMedicationsNameHint,
                textCapitalization: TextCapitalization.words,
                onChanged: (_) {
                  if (_error != null) setState(() => _error = null);
                },
              ),
            ],
            const SizedBox(height: AppSpacing.sm),
            // Toggle between the lookup picker and a free-text custom name.
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton.icon(
                onPressed: () => setState(() {
                  _useCustom = !_useCustom;
                  _error = null;
                }),
                icon: Icon(
                  _useCustom
                      ? FluentIcons.list_24_regular
                      : FluentIcons.edit_24_regular,
                  size: 18,
                ),
                label: Text(
                  _useCustom
                      ? l10n.healthMedicationsUseList
                      : l10n.healthMedicationsUseCustom,
                ),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(_error!,
                  style:
                      AppTextStyles.bodySmall.copyWith(color: AppColors.error)),
            ],
            const SizedBox(height: AppSpacing.lg),

            // ── Frequency ──────────────────────────────────────────────────
            HealthFieldLabel(l10n.healthMedicationsFrequencyLabel),
            const SizedBox(height: AppSpacing.sm),
            HealthPickerField(
              icon: FluentIcons.arrow_repeat_all_24_regular,
              label: frequencyDaysLabel(l10n, _frequencyDays),
              onTap: _pickFrequency,
            ),
            const SizedBox(height: AppSpacing.lg),

            // ── Start date ─────────────────────────────────────────────────
            HealthFieldLabel(l10n.healthMedicationsStartDateLabel),
            const SizedBox(height: AppSpacing.sm),
            HealthDateField(
              label: DateFormat.yMMMMd(locale).format(_startDate),
              onTap: _pickStartDate,
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

/// The medication lookup dropdown — the same [AppDropdownField] used for
/// species / breed / coat color, with loading / error fallbacks.
class _MedicationDropdown extends StatelessWidget {
  const _MedicationDropdown({
    required this.lookupsAsync,
    required this.selectedId,
    required this.onChanged,
    required this.onRetry,
  });

  final AsyncValue<List<HealthLookup>> lookupsAsync;
  final int? selectedId;
  final ValueChanged<int?> onChanged;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return lookupsAsync.when(
      loading: () => const _DropdownLoading(),
      error: (_, _) => _DropdownError(onRetry: onRetry),
      data: (items) => AppDropdownField<int>(
        name: 'medicationLookup',
        label: l10n.healthMedicationsNameLabel,
        hint: l10n.healthMedicationsPickHint,
        initialValue: selectedId,
        items: [
          for (final m in items)
            DropdownMenuItem(value: m.id, child: Text(m.name)),
        ],
        onChanged: onChanged,
      ),
    );
  }
}

class _DropdownLoading extends StatelessWidget {
  const _DropdownLoading();

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
}

class _DropdownError extends StatelessWidget {
  const _DropdownError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        Expanded(
          child: Text(
            l10n.errorUnknown,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
          ),
        ),
        TextButton(onPressed: onRetry, child: Text(l10n.retry)),
      ],
    );
  }
}
