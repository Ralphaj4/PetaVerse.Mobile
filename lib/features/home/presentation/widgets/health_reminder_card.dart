import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../../../pawcare/domain/entities/health_reminder.dart';
import '../../../pets/presentation/providers/pets_provider.dart';

/// "Upcoming" card for a health reminder - a medication dose, vaccination
/// booster, or appointment. Leads with the pet's photo (badged with a small
/// kind icon) and trails with the due date, so the row reads "which pet, what,
/// when" at a glance.
///
/// Tapping deep-links to the reminder's pet's list page for its kind
/// (medications / vaccinations / appointments), where the user can resolve it
/// (mark given / administered / done). Pass [onTap] to override.
class HealthReminderCard extends ConsumerWidget {
  const HealthReminderCard({
    required this.reminder,
    this.index = 0,
    this.onTap,
    super.key,
  });

  final HealthReminder reminder;
  final int index;

  /// Overrides the default deep-link navigation when non-null.
  final VoidCallback? onTap;

  /// Routes to the list page owning this reminder's kind, for its pet.
  void _openReminder(BuildContext context) {
    final path = switch (reminder.kind) {
      HealthReminderKind.medication =>
        AppRoutes.medicationsPath(reminder.petId),
      HealthReminderKind.vaccination =>
        AppRoutes.vaccinationsPath(reminder.petId),
      HealthReminderKind.appointment =>
        AppRoutes.appointmentsPath(reminder.petId),
    };
    context.push(path);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final due = reminder.dueDate;
    final isVaccine = reminder.kind == HealthReminderKind.vaccination;
    final isAppointment = reminder.kind == HealthReminderKind.appointment;
    // Alternate orange/blue by position so no two adjacent cards share a color.
    final accent = index.isEven ? AppColors.primary : AppColors.secondary;

    // Only disambiguate whose reminder it is when the user has 2+ pets - a
    // single-pet owner doesn't need a face on every row. `(count, image)` is
    // read together so the widget rebuilds if either changes.
    final (petCount, petImage) = ref.watch(
      petsProvider.select((s) {
        String? image;
        for (final r in s.refs) {
          if (r.id == reminder.petId) {
            image = r.imagePath;
            break;
          }
        }
        return (s.refs.length, image);
      }),
    );
    final showAvatar = petCount >= 2;

    // Syringe has no 16px variant; the 20px glyph renders identically at the
    // badge's size: 12, so use it rather than substituting a shield.
    final kindIcon = isVaccine
        ? FluentIcons.syringe_20_filled
        : isAppointment
            ? FluentIcons.calendar_ltr_16_filled
            : FluentIcons.pill_16_filled;

    final subtitle = isVaccine
        ? l10n.reminderVaccinationBooster(reminder.petName)
        : isAppointment
            ? l10n.reminderAppointment(reminder.petName)
            : l10n.reminderMedicationDose(reminder.petName);

    final String status;
    final Color statusColor;
    if (reminder.isOverdue) {
      status = l10n.reminderOverdue;
      statusColor = AppColors.error;
    } else if (reminder.daysUntilDue == 0) {
      status = l10n.reminderDueToday;
      statusColor = AppColors.warning;
    } else {
      status = l10n.reminderDueInDays(reminder.daysUntilDue);
      statusColor = AppColors.textSecondary;
    }

    return AppCard(
      onTap: onTap ?? () => _openReminder(context),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          if (showAvatar)
            _PetAvatar(
              imageUrl: petImage,
              petName: reminder.petName,
              kindIcon: kindIcon,
              accent: accent,
            )
          else
            _KindBadge(icon: kindIcon, accent: accent),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reminder.title,
                  style: AppTextStyles.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  status,
                  style: AppTextStyles.labelMedium.copyWith(color: statusColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          _DateBlock(
            monthLabel: DateFormat.MMM(locale).format(due).toUpperCase(),
            dayLabel: DateFormat.d(locale).format(due),
            accent: accent,
            overdue: reminder.isOverdue,
          ),
        ],
      ),
    );
  }
}

/// Leading marker for single-pet owners: a tinted square holding the kind
/// icon. Matches the avatar's 48px footprint so both layouts align.
class _KindBadge extends StatelessWidget {
  const _KindBadge({required this.icon, required this.accent});

  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: AppRadius.mdAll,
      ),
      child: Icon(icon, size: 22, color: accent),
    );
  }
}

/// Round pet photo with a small kind-icon badge pinned to the bottom-end,
/// so each card shows both whose reminder it is and what kind.
class _PetAvatar extends StatelessWidget {
  const _PetAvatar({
    required this.imageUrl,
    required this.petName,
    required this.kindIcon,
    required this.accent,
  });

  final String? imageUrl;
  final String petName;
  final IconData kindIcon;
  final Color accent;

  static const double _size = 48;
  static const double _badge = 22;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _size,
      height: _size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipOval(
            child: AppCachedImage(
              imageUrl: imageUrl,
              width: _size,
              height: _size,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.zero,
              semanticLabel: petName,
            ),
          ),
          PositionedDirectional(
            end: -2,
            bottom: -2,
            child: Container(
              width: _badge,
              height: _badge,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surface, width: 2),
              ),
              child: Icon(kindIcon, size: 12, color: AppColors.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateBlock extends StatelessWidget {
  const _DateBlock({
    required this.monthLabel,
    required this.dayLabel,
    required this.accent,
    required this.overdue,
  });

  final String monthLabel;
  final String dayLabel;
  final Color accent;
  final bool overdue;

  @override
  Widget build(BuildContext context) {
    final bg = overdue
        ? AppColors.error.withValues(alpha: 0.10)
        : accent.withValues(alpha: 0.10);
    final fg = overdue ? AppColors.error : accent;

    return Container(
      width: 56,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.smAll,
      ),
      child: Column(
        children: [
          Text(
            monthLabel,
            style: AppTextStyles.labelMedium.copyWith(color: fg),
          ),
          Text(
            dayLabel,
            style: AppTextStyles.headlineMedium.copyWith(color: fg),
          ),
        ],
      ),
    );
  }
}
