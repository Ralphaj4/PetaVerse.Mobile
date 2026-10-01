import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/app/notification_service.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/feeding_schedule.dart';
import 'feeding_grooming_l10n.dart';

// The bottom-sheet pickers behind the feeding / grooming edit forms. All share
// the app's sheet language: a rounded-top surface, a grab handle, a title, and
// tappable rows with a primary check on the active option — matching
// `showMedicationFrequencySheet` and `AppDropdownField`'s picker.

/// Rounded-top sheet frame with the standard grab handle and title.
Future<T?> _showCareSheet<T>(
  BuildContext context, {
  required String title,
  required Widget Function(BuildContext) body,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
    ),
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _SheetHandle(),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  0,
                  AppSpacing.lg,
                  AppSpacing.sm,
                ),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(title, style: AppTextStyles.titleMedium),
                ),
              ),
              body(ctx),
            ],
          ),
        ),
      ),
    ),
  );
}

class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          width: 36,
          height: 4,
          margin: const EdgeInsets.only(bottom: AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.divider,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      );
}

/// A selectable option row with a leading label and a trailing primary check.
class _OptionRow extends StatelessWidget {
  const _OptionRow({
    required this.label,
    required this.selected,
    required this.onTap,
    this.emphasized = false,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  /// Renders the label in the primary color (used for the quick-preset rows).
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: emphasized ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            if (selected)
              const Icon(FluentIcons.checkmark_24_filled,
                  size: 20, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}

// ── Feeding days (multi-select) ─────────────────────────────────────────────

const int _everyDayMask = 0x7F; // bits 0–6
const int _weekdaysMask = 0x3E; // Mon–Fri
const int _weekendsMask = 0x41; // Sun + Sat

/// Opens the feeding-days picker and resolves to the chosen bitmask, or null if
/// dismissed. Quick presets (every day / weekdays / weekends) sit above the
/// seven individual day toggles; a "Done" button confirms the multi-selection.
Future<int?> showFeedingDaysSheet(BuildContext context, int current) {
  return _showCareSheet<int>(
    context,
    title: context.l10n.feedingDaysLabel,
    body: (_) => _FeedingDaysBody(initial: current),
  );
}

class _FeedingDaysBody extends StatefulWidget {
  const _FeedingDaysBody({required this.initial});

  final int initial;

  @override
  State<_FeedingDaysBody> createState() => _FeedingDaysBodyState();
}

class _FeedingDaysBodyState extends State<_FeedingDaysBody> {
  late int _mask = widget.initial & _everyDayMask;

  void _setPreset(int mask) => setState(() => _mask = mask);
  void _toggle(Weekday day) => setState(() => _mask ^= 1 << day.bit);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _OptionRow(
          label: l10n.feedingEveryDay,
          selected: _mask == _everyDayMask,
          emphasized: true,
          onTap: () => _setPreset(_everyDayMask),
        ),
        _OptionRow(
          label: l10n.feedingWeekdays,
          selected: _mask == _weekdaysMask,
          emphasized: true,
          onTap: () => _setPreset(_weekdaysMask),
        ),
        _OptionRow(
          label: l10n.feedingWeekends,
          selected: _mask == _weekendsMask,
          emphasized: true,
          onTap: () => _setPreset(_weekendsMask),
        ),
        const Divider(
          height: 1,
          color: AppColors.divider,
          indent: AppSpacing.lg,
          endIndent: AppSpacing.lg,
        ),
        for (final day in Weekday.values)
          _OptionRow(
            label: fullWeekday(l10n, day),
            selected: _mask & (1 << day.bit) != 0,
            onTap: () => _toggle(day),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.sm,
          ),
          child: FilledButton(
            onPressed: () => Navigator.of(context).pop(_mask),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
            ),
            child: Text(l10n.done),
          ),
        ),
      ],
    );
  }
}

// ── Grooming interval (single-select + custom) ──────────────────────────────

const _intervalPresets = <int>[7, 14, 21, 30, 60, 90];

/// Opens the grooming-interval picker and resolves to the chosen day count, or
/// null if dismissed. Mirrors the medication frequency sheet: named presets plus
/// a custom "N days" row.
Future<int?> showGroomingIntervalSheet(BuildContext context, int current) {
  return _showCareSheet<int>(
    context,
    title: context.l10n.groomingIntervalLabel,
    body: (_) => _GroomingIntervalBody(current: current),
  );
}

class _GroomingIntervalBody extends StatefulWidget {
  const _GroomingIntervalBody({required this.current});

  final int current;

  @override
  State<_GroomingIntervalBody> createState() => _GroomingIntervalBodyState();
}

class _GroomingIntervalBodyState extends State<_GroomingIntervalBody> {
  late final TextEditingController _customController;
  late bool _custom;

  @override
  void initState() {
    super.initState();
    _custom = !_intervalPresets.contains(widget.current);
    _customController =
        TextEditingController(text: _custom ? '${widget.current}' : '');
  }

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  void _confirmCustom() {
    final days = int.tryParse(_customController.text.trim());
    if (days != null && days >= 1 && days <= 3650) {
      Navigator.of(context).pop(days);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final days in _intervalPresets)
          _OptionRow(
            label: l10n.groomingEveryDays(days),
            selected: !_custom && days == widget.current,
            onTap: () => Navigator.of(context).pop(days),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.sm,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(l10n.healthFrequencyCustomLabel,
                    style: AppTextStyles.bodyMedium),
              ),
              SizedBox(
                width: 80,
                child: TextField(
                  controller: _customController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onTap: () => setState(() => _custom = true),
                  onSubmitted: (_) => _confirmCustom(),
                  decoration: InputDecoration(
                    hintText: '21',
                    isDense: true,
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: AppRadius.smAll,
                      borderSide: const BorderSide(color: AppColors.divider),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: AppRadius.smAll,
                      borderSide: const BorderSide(color: AppColors.divider),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(l10n.healthFrequencyDaysSuffix,
                  style: AppTextStyles.bodySmall),
              const SizedBox(width: AppSpacing.sm),
              IconButton(
                onPressed: _confirmCustom,
                icon: const Icon(FluentIcons.checkmark_circle_24_filled,
                    color: AppColors.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Feeding unit (single-select) ────────────────────────────────────────────

/// Opens the feeding-amount unit picker and resolves to the chosen unit, or null
/// if dismissed.
Future<FeedUnit?> showFeedUnitSheet(BuildContext context, FeedUnit current) {
  return _showCareSheet<FeedUnit>(
    context,
    title: context.l10n.feedingUnitLabel,
    body: (ctx) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final unit in FeedUnit.values)
          _OptionRow(
            label: feedUnitName(context.l10n, unit),
            selected: unit == current,
            onTap: () => Navigator.of(ctx).pop(unit),
          ),
      ],
    ),
  );
}

/// Shows the battery-optimization exemption sheet after every feeding schedule
/// save, as long as the app is not yet exempted. Once the user grants it the
/// OS state flips and this becomes a no-op on all future saves — no separate
/// "asked" flag needed. If they deny, they'll see it again next save, giving
/// them a natural retry path without any extra nagging logic.
Future<void> showBatteryOptimizationSheetIfNeeded(
  BuildContext context,
  NotificationService notifications,
) async {
  if (await notifications.hasBatteryOptimizationExemption()) return;

  if (!context.mounted) return;
  final l10n = context.l10n;

  final allow = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
    ),
    builder: (ctx) => SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  FluentIcons.alert_24_filled,
                  size: 28,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.batteryOptSheetTitle,
              style: AppTextStyles.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.batteryOptSheetBody,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
              ),
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(l10n.batteryOptSheetAllow),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(44),
              ),
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(
                l10n.batteryOptSheetNotNow,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  if (allow == true && context.mounted) {
    await notifications.requestBatteryOptimizationExemption();
  }
}
