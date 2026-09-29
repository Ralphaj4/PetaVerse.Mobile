import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/service_provider_detail.dart';
import 'provider_actions.dart';
import 'provider_format.dart';

/// A single branch on the detail page: address + distance and a row of contact
/// actions (directions, call, WhatsApp, website) for whichever channels exist.
class ProviderBranchCard extends StatelessWidget {
  const ProviderBranchCard({
    required this.branch,
    required this.providerName,
    super.key,
  });

  final ProviderBranch branch;
  final String providerName;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final distance = ProviderFormat.distance(l10n, branch.distanceKm);

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                FluentIcons.location_24_regular,
                size: 16,
                color: AppColors.secondary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(branch.address, style: AppTextStyles.bodyMedium),
              ),
              if (distance.isNotEmpty)
                Text(
                  distance,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 0,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _Action(
                icon: FluentIcons.location_arrow_24_regular,
                label: l10n.providerDirections,
                onTap: () =>
                    ProviderActions.navigateTo(branch.location, providerName),
              ),
              if (_has(branch.phone))
                _Action(
                  icon: FluentIcons.call_24_regular,
                  label: l10n.providerCall,
                  onTap: () => ProviderActions.dial(branch.phone),
                ),
              if (_has(branch.whatsApp))
                _Action(
                  icon: FluentIcons.chat_24_regular,
                  label: l10n.providerWhatsApp,
                  onTap: () => ProviderActions.whatsApp(branch.whatsApp),
                ),
              if (_has(branch.emergency))
                _Action(
                  icon: FluentIcons.alert_urgent_24_regular,
                  label: l10n.providerEmergencyCall,
                  tint: AppColors.error,
                  onTap: () => ProviderActions.dial(branch.emergency),
                ),
              if (_has(branch.website))
                _Action(
                  icon: FluentIcons.globe_24_regular,
                  label: l10n.providerWebsite,
                  onTap: () => ProviderActions.openUrl(branch.website),
                ),
              if (_has(branch.instagram))
                _Action(
                  icon: FluentIcons.camera_24_regular,
                  label: l10n.providerInstagram,
                  onTap: () => ProviderActions.openUrl(
                    _instagramUrl(branch.instagram!),
                  ),
                ),
              if (_has(branch.email))
                _Action(
                  icon: FluentIcons.mail_24_regular,
                  label: l10n.providerEmail,
                  onTap: () => ProviderActions.email(branch.email),
                ),
            ],
          ),
        ],
      ),
    );
  }

  static bool _has(String? v) => v != null && v.isNotEmpty;

  /// Turns an `@handle` (or bare handle) into an instagram.com URL.
  static String _instagramUrl(String handle) {
    final h = handle.startsWith('@') ? handle.substring(1) : handle;
    return 'https://instagram.com/$h';
  }
}

class _Action extends StatelessWidget {
  const _Action({
    required this.icon,
    required this.label,
    required this.onTap,
    this.tint = AppColors.secondary,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: tint.withValues(alpha: 0.10),
        borderRadius: AppRadius.smAll,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.smAll,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 16, color: tint),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: tint,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
