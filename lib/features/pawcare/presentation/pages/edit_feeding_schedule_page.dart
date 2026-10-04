import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/notification_service.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../domain/entities/feeding_schedule.dart';
import '../../../home/presentation/providers/home_providers.dart';
import '../providers/pawcare_providers.dart';
import '../widgets/care_schedule_pickers.dart';
import '../widgets/feeding_grooming_l10n.dart';
import '../widgets/health_form_fields.dart';

/// Create / edit a pet's feeding schedule: which days it recurs on and the meals
/// (time + optional amount) within a day. Saving replaces the whole schedule and
/// re-arms device-local reminders; an existing schedule can be removed via the
/// delete action.
class EditFeedingSchedulePage extends ConsumerWidget {
  const EditFeedingSchedulePage({required this.petId, super.key});

  final int petId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final scheduleAsync = ref.watch(petFeedingScheduleProvider(petId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(l10n.feedingTitle),
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
          onRetry: () => ref.invalidate(petFeedingScheduleProvider(petId)),
        ),
        data: (schedule) => _FeedingForm(petId: petId, initial: schedule),
      ),
    );
  }
}

class _FeedingForm extends ConsumerStatefulWidget {
  const _FeedingForm({required this.petId, required this.initial});

  final int petId;
  final FeedingSchedule? initial;

  @override
  ConsumerState<_FeedingForm> createState() => _FeedingFormState();
}

/// A meal being edited - a mutable draft of a [FeedingTime].
class _MealDraft {
  _MealDraft({
    required this.hour,
    required this.minute,
    this.quantity,
    this.unit = FeedUnit.grams,
  });

  int hour;
  int minute;
  double? quantity;
  FeedUnit unit;
}

class _FeedingFormState extends ConsumerState<_FeedingForm> {
  /// Selected days as a bitmask (bit0 = Sun … bit6 = Sat).
  late int _daysOfWeek;
  late List<_MealDraft> _meals;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    _daysOfWeek = initial?.daysOfWeek ?? 0x7F; // default every day
    _meals = [
      for (final t in initial?.times ?? const <FeedingTime>[])
        _MealDraft(
          hour: t.hour,
          minute: t.minute,
          quantity: t.quantity,
          unit: t.unit,
        ),
    ];
    if (_meals.isEmpty) {
      _meals.add(_MealDraft(hour: 8, minute: 0)); // one sensible default meal
    }
  }

  Future<void> _pickDays() async {
    final picked = await showFeedingDaysSheet(context, _daysOfWeek);
    if (picked != null) setState(() => _daysOfWeek = picked);
  }

  Future<void> _pickTime(_MealDraft meal) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: meal.hour, minute: meal.minute),
    );
    if (picked != null) {
      setState(() {
        meal.hour = picked.hour;
        meal.minute = picked.minute;
      });
    }
  }

  void _addMeal() {
    setState(() => _meals.add(_MealDraft(hour: 18, minute: 0)));
  }

  void _removeMeal(int index) {
    setState(() => _meals.removeAt(index));
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    if (_daysOfWeek == 0) {
      setState(() => _error = l10n.feedingNoDaysError);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });

    final times = [
      for (final m in _meals)
        FeedingTime(
          hour: m.hour,
          minute: m.minute,
          quantity: m.quantity,
          unit: m.unit,
        ),
    ];

    final result =
        await ref.read(pawCareRepositoryProvider).saveFeedingSchedule(
              widget.petId,
              daysOfWeek: _daysOfWeek,
              times: times,
            );
    if (!mounted) return;
    setState(() => _saving = false);

    result.when(
      success: (_) async {
        ref.invalidate(petFeedingScheduleProvider(widget.petId));
        ref.invalidate(petHealthSnapshotProvider(widget.petId));
        ref.invalidate(homeSummaryProvider);
        if (!mounted) return;
        await showBatteryOptimizationSheetIfNeeded(
          context,
          ref.read(notificationServiceProvider),
        );
        if (!mounted) return;
        context.showSuccessSnackBar(l10n.feedingSaved);
        context.pop();
      },
      failure: (f) => setState(() => _error = f.localizedMessage(l10n)),
    );
  }

  Future<void> _delete() async {
    final l10n = context.l10n;
    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.delete_24_regular,
      title: l10n.feedingDeleteTitle,
      message: l10n.feedingDeleteMessage,
      confirmLabel: l10n.delete,
      cancelLabel: l10n.cancel,
      isDestructive: true,
    );
    if (confirmed != true || !mounted) return;

    setState(() => _saving = true);
    final result = await ref
        .read(pawCareRepositoryProvider)
        .deleteFeedingSchedule(widget.petId);
    if (!mounted) return;
    setState(() => _saving = false);
    result.when(
      success: (_) {
        ref.invalidate(petFeedingScheduleProvider(widget.petId));
        ref.invalidate(petHealthSnapshotProvider(widget.petId));
        ref.invalidate(homeSummaryProvider);
        context.showSuccessSnackBar(l10n.feedingDeleted);
        context.pop();
      },
      failure: (f) => context.showErrorSnackBar(f.localizedMessage(l10n)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hasExisting = widget.initial != null;

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              // ── Days ──────────────────────────────────────────────────────
              HealthFieldLabel(l10n.feedingDaysLabel),
              const SizedBox(height: AppSpacing.sm),
              HealthPickerField(
                icon: FluentIcons.calendar_week_start_24_regular,
                label: feedingDaysLabel(l10n, _daysOfWeek),
                onTap: _pickDays,
              ),
              const SizedBox(height: AppSpacing.lg),

              // ── Meals ─────────────────────────────────────────────────────
              Row(
                children: [
                  Expanded(child: HealthFieldLabel(l10n.feedingMealsLabel)),
                  TextButton.icon(
                    onPressed: _addMeal,
                    icon: const Icon(FluentIcons.add_24_regular, size: 18),
                    label: Text(l10n.feedingAddMeal),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              for (var i = 0; i < _meals.length; i++) ...[
                _MealEditor(
                  key: ObjectKey(_meals[i]),
                  meal: _meals[i],
                  index: i,
                  onPickTime: () => _pickTime(_meals[i]),
                  onQuantityChanged: (q) => _meals[i].quantity = q,
                  onUnitChanged: (u) => setState(() => _meals[i].unit = u),
                  onRemove: _meals.length > 1 ? () => _removeMeal(i) : null,
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ],
          ),
        ),

        // ── Pinned bottom actions ────────────────────────────────────────────
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_error != null) ...[
                  Text(
                    _error!,
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
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
                    label: l10n.feedingDelete,
                    icon: FluentIcons.delete_24_regular,
                    variant: AppButtonVariant.text,
                    onPressed: _saving ? null : _delete,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// A single meal editor card: a time picker field, an optional amount field, and
/// a unit picker - all in the app's field language (no raw dropdowns).
class _MealEditor extends StatefulWidget {
  const _MealEditor({
    required this.meal,
    required this.index,
    required this.onPickTime,
    required this.onQuantityChanged,
    required this.onUnitChanged,
    required this.onRemove,
    super.key,
  });

  final _MealDraft meal;
  final int index;
  final VoidCallback onPickTime;
  final ValueChanged<double?> onQuantityChanged;
  final ValueChanged<FeedUnit> onUnitChanged;
  final VoidCallback? onRemove;

  @override
  State<_MealEditor> createState() => _MealEditorState();
}

class _MealEditorState extends State<_MealEditor> {
  late final TextEditingController _qtyController;

  @override
  void initState() {
    super.initState();
    final q = widget.meal.quantity;
    _qtyController = TextEditingController(
      text: q == null
          ? ''
          : (q == q.roundToDouble() ? q.toInt().toString() : q.toString()),
    );
  }

  @override
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

  Future<void> _pickUnit() async {
    final picked = await showFeedUnitSheet(context, widget.meal.unit);
    if (picked != null) widget.onUnitChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tod = TimeOfDay(hour: widget.meal.hour, minute: widget.meal.minute);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Meal header: index + remove.
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.feedingMealNumber(widget.index + 1),
                  style: AppTextStyles.labelLarge
                      .copyWith(color: AppColors.textSecondary),
                ),
              ),
              if (widget.onRemove != null)
                InkWell(
                  onTap: widget.onRemove,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  child: const Padding(
                    padding: EdgeInsets.all(AppSpacing.xs),
                    child: Icon(FluentIcons.delete_24_regular,
                        size: 18, color: AppColors.error),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Time.
          HealthPickerField(
            icon: FluentIcons.clock_24_regular,
            label: tod.format(context),
            onTap: widget.onPickTime,
          ),
          const SizedBox(height: AppSpacing.sm),

          // Amount + unit. IntrinsicHeight lets the unit picker match the
          // amount field's height without forcing an unbounded stretch (a bare
          // CrossAxisAlignment.stretch inside a scrolling column is infinite).
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              Expanded(
                flex: 3,
                child: _AmountField(
                  controller: _qtyController,
                  hint: l10n.feedingAmountHint,
                  onChanged: (v) =>
                      widget.onQuantityChanged(double.tryParse(v.trim())),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                flex: 2,
                child: HealthPickerField(
                  icon: FluentIcons.scales_24_regular,
                  label: feedUnitName(l10n, widget.meal.unit),
                  onTap: _pickUnit,
                ),
              ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The amount text input, styled to match [HealthPickerField]'s bordered frame
/// so it lines up with the unit picker beside it.
class _AmountField extends StatelessWidget {
  const _AmountField({
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: AppTextStyles.titleSmall,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            AppTextStyles.bodyMedium.copyWith(color: AppColors.textTertiary),
        prefixIcon: const Icon(FluentIcons.food_24_regular,
            size: 20, color: AppColors.primary),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
