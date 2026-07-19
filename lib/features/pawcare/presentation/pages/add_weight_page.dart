import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../domain/entities/weight_record.dart';
import '../providers/pawcare_providers.dart';
import '../widgets/health_form_fields.dart';

/// Records a new weight measurement for a pet: a value, a unit toggle (kg / lb),
/// and the date it was taken. On success it invalidates the health providers so
/// the dashboard + history reflect the new reading, then pops.
class AddWeightPage extends ConsumerStatefulWidget {
  const AddWeightPage({required this.petId, super.key});

  final int petId;

  @override
  ConsumerState<AddWeightPage> createState() => _AddWeightPageState();
}

class _AddWeightPageState extends ConsumerState<AddWeightPage> {
  final _controller = TextEditingController();
  WeightUnit _unit = WeightUnit.kg;
  DateTime _recordedAt = DateTime.now();
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double? get _value => double.tryParse(_controller.text.trim().replaceAll(',', '.'));

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _recordedAt,
      firstDate: DateTime(now.year - 30),
      lastDate: now,
    );
    if (picked != null) setState(() => _recordedAt = picked);
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final value = _value;
    if (value == null || value <= 0) {
      setState(() => _error = l10n.healthWeightInvalid);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });

    final result = await ref.read(pawCareRepositoryProvider).addWeight(
          widget.petId,
          weight: value,
          unit: _unit,
          recordedDate: _recordedAt,
        );
    if (!mounted) return;
    setState(() => _saving = false);

    result.when(
      success: (_) {
        ref.invalidate(petHealthSnapshotProvider(widget.petId));
        ref.invalidate(weightHistoryProvider(widget.petId));
        context.showSuccessSnackBar(l10n.healthWeightAddedSuccess);
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

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(l10n.healthWeightAdd),
        leading: IconButton(
          icon: Icon(
            context.isRtl
                ? FluentIcons.arrow_right_24_regular
                : FluentIcons.arrow_left_24_regular,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // ── Value + unit ──────────────────────────────────────────────────
          HealthFieldLabel(l10n.healthWeightValueLabel),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                  ],
                  style: AppTextStyles.titleMedium,
                  decoration: InputDecoration(
                    hintText: l10n.healthWeightValueHint,
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: AppRadius.mdAll,
                      borderSide: const BorderSide(color: AppColors.divider),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: AppRadius.mdAll,
                      borderSide: const BorderSide(color: AppColors.divider),
                    ),
                  ),
                  onChanged: (_) {
                    if (_error != null) setState(() => _error = null);
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              _UnitToggle(
                unit: _unit,
                onChanged: (u) => setState(() => _unit = u),
              ),
            ],
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              _error!,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),

          // ── Date ──────────────────────────────────────────────────────────
          HealthFieldLabel(l10n.healthWeightDateLabel),
          const SizedBox(height: AppSpacing.sm),
          HealthDateField(
            label: DateFormat.yMMMMd(locale).format(_recordedAt),
            onTap: _pickDate,
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
    );
  }
}

/// kg / lb segmented toggle.
class _UnitToggle extends StatelessWidget {
  const _UnitToggle({required this.unit, required this.onChanged});

  final WeightUnit unit;
  final ValueChanged<WeightUnit> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          for (final u in WeightUnit.values)
            GestureDetector(
              onTap: () => onChanged(u),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: u == unit ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  u.suffix,
                  style: AppTextStyles.labelMedium.copyWith(
                    color:
                        u == unit ? AppColors.onPrimary : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

