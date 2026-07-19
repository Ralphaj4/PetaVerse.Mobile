import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Named frequency presets that map to a day count. "Custom" lets the user type
/// any interval, matching the API's free-form `frequencyDays`.
const _presets = <(int, String Function(AppLocalizations))>[
  (1, _daily),
  (7, _weekly),
  (14, _biweekly),
  (30, _monthly),
  (90, _quarterly),
];

String _daily(AppLocalizations l) => l.healthFrequencyDaily;
String _weekly(AppLocalizations l) => l.healthFrequencyWeekly;
String _biweekly(AppLocalizations l) => l.healthFrequencyBiweekly;
String _monthly(AppLocalizations l) => l.healthFrequencyMonthly;
String _quarterly(AppLocalizations l) => l.healthFrequencyQuarterly;

/// A human label for a [frequencyDays] value: a named preset when it matches
/// one exactly, otherwise "Every N days".
String frequencyDaysLabel(AppLocalizations l10n, int frequencyDays) {
  for (final (days, label) in _presets) {
    if (days == frequencyDays) return label(l10n);
  }
  return l10n.healthFrequencyEveryNDays(frequencyDays);
}

/// Shows the frequency picker sheet and resolves to the chosen day count, or
/// null if dismissed. [current] preselects the matching preset.
Future<int?> showMedicationFrequencySheet(
  BuildContext context,
  int current,
) {
  return showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
    ),
    builder: (_) => _FrequencySheet(current: current),
  );
}

class _FrequencySheet extends StatefulWidget {
  const _FrequencySheet({required this.current});

  final int current;

  @override
  State<_FrequencySheet> createState() => _FrequencySheetState();
}

class _FrequencySheetState extends State<_FrequencySheet> {
  late final TextEditingController _customController;
  late bool _custom;

  @override
  void initState() {
    super.initState();
    _custom = !_presets.any((p) => p.$1 == widget.current);
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
    if (days != null && days >= 1 && days <= 36500) {
      Navigator.of(context).pop(days);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(l10n.healthMedicationsFrequencyLabel,
                      style: AppTextStyles.titleMedium),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              for (final (days, label) in _presets)
                ListTile(
                  title: Text(label(l10n), style: AppTextStyles.bodyMedium),
                  trailing: (!_custom && days == widget.current)
                      ? const Icon(FluentIcons.checkmark_24_filled,
                          color: AppColors.primary, size: 20)
                      : null,
                  onTap: () => Navigator.of(context).pop(days),
                ),
              // Custom days row.
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onTap: () => setState(() => _custom = true),
                        onSubmitted: (_) => _confirmCustom(),
                        decoration: InputDecoration(
                          hintText: '30',
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
          ),
        ),
      ),
    );
  }
}
