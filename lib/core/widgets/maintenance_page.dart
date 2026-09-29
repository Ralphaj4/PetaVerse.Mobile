import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../extensions/context_extensions.dart';
import '../network/app_config_datasource.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// Fullscreen blocking screen shown when [AppConfigMaintenance.active] is true.
/// The user cannot navigate elsewhere — they must wait for maintenance to end
/// and relaunch the app (or the admin disables maintenance and the cache TTL
/// expires on the next cold launch).
class MaintenancePage extends StatelessWidget {
  const MaintenancePage({required this.maintenance, super.key});

  final AppConfigMaintenance maintenance;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    FluentIcons.wrench_24_regular,
                    size: 44,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  l10n.maintenanceTitle,
                  style: AppTextStyles.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  maintenance.message.isNotEmpty
                      ? maintenance.message
                      : l10n.maintenanceDefaultMessage,
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
                if (maintenance.endsAt != null) ...[
                  const SizedBox(height: AppSpacing.lg),
                  _CountdownLabel(endsAt: maintenance.endsAt!),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CountdownLabel extends StatelessWidget {
  const _CountdownLabel({required this.endsAt});

  final DateTime endsAt;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().toUtc();
    final end = endsAt.toUtc();
    if (end.isBefore(now)) return const SizedBox.shrink();

    final diff = end.difference(now);
    final hours = diff.inHours;
    final minutes = diff.inMinutes.remainder(60);

    final label = hours > 0
        ? context.l10n.maintenanceEndsInHoursMinutes(hours, minutes)
        : context.l10n.maintenanceEndsInMinutes(minutes);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary),
      ),
    );
  }
}
