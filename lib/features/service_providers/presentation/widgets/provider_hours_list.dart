import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/service_provider_detail.dart';

/// Weekly opening-hours table. [ProviderHours.dayOfWeek] uses 0 = Sunday. Days
/// are listed Sunday→Saturday; a day with multiple rows shows them comma-joined;
/// a day with none shows "Closed". Today's row is emphasized.
class ProviderHoursList extends StatelessWidget {
  const ProviderHoursList({required this.hours, super.key});

  final List<ProviderHours> hours;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    // DateTime.weekday: Mon=1..Sun=7 → our scheme Sun=0..Sat=6.
    final todayIdx = DateTime.now().weekday % 7;

    final byDay = <int, List<ProviderHours>>{};
    for (final h in hours) {
      byDay.putIfAbsent(h.dayOfWeek, () => []).add(h);
    }

    return Column(
      children: [
        for (var day = 0; day < 7; day++)
          _Row(
            day: _weekdayName(locale, day),
            value: _valueFor(byDay[day]),
            isToday: day == todayIdx,
          ),
      ],
    );
  }

  String _valueFor(List<ProviderHours>? rows) {
    if (rows == null || rows.isEmpty) return 'Closed';
    return rows.map((r) => '${r.startTime} – ${r.endTime}').join(', ');
  }

  /// Localized full weekday name for our 0=Sunday index. Anchors on a known
  /// Sunday (2024-01-07) and adds [day] days so DateFormat gives the right name.
  String _weekdayName(String locale, int day) {
    final date = DateTime(2024, 1, 7).add(Duration(days: day));
    return DateFormat.EEEE(locale).format(date);
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.day,
    required this.value,
    required this.isToday,
  });

  final String day;
  final String value;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    final weight = isToday ? FontWeight.w700 : FontWeight.w500;
    final color = isToday ? AppColors.textPrimary : AppColors.textSecondary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              day,
              style: AppTextStyles.bodyMedium
                  .copyWith(fontWeight: weight, color: color),
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodyMedium
                .copyWith(fontWeight: weight, color: color),
          ),
        ],
      ),
    );
  }
}
