import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_dropdown_field.dart';
import '../../domain/entities/health_lookup.dart';
import '../providers/pawcare_providers.dart';
import '../widgets/health_form_fields.dart';

/// Adds a vaccination record: pick a vaccine from the lookup (the API requires
/// a valid vaccineId), set the administered date, and optionally a booster
/// date, vet name, and note.
class AddVaccinationPage extends ConsumerStatefulWidget {
  const AddVaccinationPage({required this.petId, super.key});

  final int petId;

  @override
  ConsumerState<AddVaccinationPage> createState() =>
      _AddVaccinationPageState();
}

class _AddVaccinationPageState extends ConsumerState<AddVaccinationPage> {
  int? _vaccineId;
  final _vetController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime _administeredAt = DateTime.now();
  DateTime? _nextDue;
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _vetController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickAdministered() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _administeredAt,
      firstDate: DateTime(now.year - 30),
      lastDate: now,
    );
    if (picked != null) setState(() => _administeredAt = picked);
  }

  Future<void> _pickNextDue() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _nextDue ?? now.add(const Duration(days: 365)),
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 10),
    );
    if (picked != null) setState(() => _nextDue = picked);
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final vaccineId = _vaccineId;
    if (vaccineId == null) {
      setState(() => _error = l10n.healthVaccinationsNameRequired);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });

    final vet = _vetController.text.trim();
    final notes = _notesController.text.trim();
    final result = await ref.read(pawCareRepositoryProvider).addVaccination(
          widget.petId,
          vaccineId: vaccineId,
          dateAdministered: _administeredAt,
          nextDueDate: _nextDue,
          vetName: vet.isEmpty ? null : vet,
          notes: notes.isEmpty ? null : notes,
        );
    if (!mounted) return;
    setState(() => _saving = false);

    result.when(
      success: (_) {
        ref.invalidate(petHealthSnapshotProvider(widget.petId));
        ref.invalidate(petVaccinationsProvider(widget.petId));
        context.showSuccessSnackBar(l10n.healthVaccinationsAddedSuccess);
        context.pop();
      },
      failure: (f) => setState(() =>
          _error = f.message?.isNotEmpty == true ? f.message : l10n.errorUnknown),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final dateFmt = DateFormat.yMMMMd(locale);
    final lookupsAsync = ref.watch(vaccineLookupsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(l10n.healthVaccinationsAdd),
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
            // ── Vaccine (lookup dropdown) ──────────────────────────────────
            HealthCard(
              child: _VaccineDropdown(
                lookupsAsync: lookupsAsync,
                selectedId: _vaccineId,
                onChanged: (id) => setState(() {
                  _vaccineId = id;
                  _error = null;
                }),
                onRetry: () => ref.invalidate(vaccineLookupsProvider),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(_error!,
                  style:
                      AppTextStyles.bodySmall.copyWith(color: AppColors.error)),
            ],
            const SizedBox(height: AppSpacing.lg),

            // ── Administered date ──────────────────────────────────────────
            HealthFieldLabel(l10n.healthVaccinationsAdministeredLabel),
            const SizedBox(height: AppSpacing.sm),
            HealthDateField(
              label: dateFmt.format(_administeredAt),
              onTap: _pickAdministered,
            ),
            const SizedBox(height: AppSpacing.lg),

            // ── Next due (optional) ────────────────────────────────────────
            HealthFieldLabel(l10n.healthVaccinationsNextDueLabel),
            const SizedBox(height: AppSpacing.sm),
            HealthDateField(
              label: _nextDue == null
                  ? l10n.healthVaccinationsNoBooster
                  : dateFmt.format(_nextDue!),
              placeholder: _nextDue == null,
              onTap: _pickNextDue,
              onClear: _nextDue == null
                  ? null
                  : () => setState(() => _nextDue = null),
            ),
            const SizedBox(height: AppSpacing.lg),

            // ── Vet (optional) ─────────────────────────────────────────────
            HealthFieldLabel(l10n.healthVaccinationsVetLabel),
            const SizedBox(height: AppSpacing.sm),
            HealthTextField(
              controller: _vetController,
              hint: l10n.healthVaccinationsVetHint,
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

/// The vaccine lookup dropdown — the same [AppDropdownField] used for species /
/// breed / coat color, with loading / error fallbacks.
class _VaccineDropdown extends StatelessWidget {
  const _VaccineDropdown({
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
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
      error: (_, _) => Row(
        children: [
          Expanded(
            child: Text(
              l10n.errorUnknown,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
            ),
          ),
          TextButton(onPressed: onRetry, child: Text(l10n.retry)),
        ],
      ),
      data: (items) => AppDropdownField<int>(
        name: 'vaccineLookup',
        label: l10n.healthVaccinationsNameLabel,
        hint: l10n.healthVaccinationsPickHint,
        initialValue: selectedId,
        items: [
          for (final v in items)
            DropdownMenuItem(value: v.id, child: Text(v.name)),
        ],
        onChanged: onChanged,
      ),
    );
  }
}
