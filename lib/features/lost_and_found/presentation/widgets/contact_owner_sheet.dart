import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// A modern bottom sheet that lets the finder reach a lost pet's owner either
/// by a phone call or a WhatsApp message.
///
/// Shown via [ContactOwnerSheet.show]. If [phone] is null/blank the caller
/// should surface [AppLocalizations.contactNoPhone] instead of opening this.
abstract final class ContactOwnerSheet {
  /// Opens the contact sheet for [petName]/[phone]. The `onLaunchError`
  /// callback fires when neither the dialer nor WhatsApp could be opened, so
  /// the page can show a localized snackbar (the sheet closes first).
  static Future<void> show(
    BuildContext context, {
    required String petName,
    required String phone,
    required VoidCallback onLaunchError,
  }) {
    return WoltModalSheet.show<void>(
      context: context,
      // A single bottom-sheet page; no top bar — the header is custom.
      pageListBuilder: (sheetContext) => [
        WoltModalSheetPage(
          hasTopBarLayer: false,
          backgroundColor: AppColors.surface,
          surfaceTintColor: AppColors.surface,
          child: _ContactSheetBody(
            petName: petName,
            phone: phone,
            onLaunchError: onLaunchError,
          ),
        ),
      ],
    );
  }
}

class _ContactSheetBody extends StatelessWidget {
  const _ContactSheetBody({
    required this.petName,
    required this.phone,
    required this.onLaunchError,
  });

  final String petName;
  final String phone;
  final VoidCallback onLaunchError;

  /// Digits-only form for the `wa.me` deep link (drops spaces, dashes, `+`).
  String get _whatsAppNumber => phone.replaceAll(RegExp(r'[^0-9]'), '');

  Future<void> _dial(BuildContext context) async {
    Navigator.of(context).pop();
    final ok = await launchUrl(Uri(scheme: 'tel', path: phone));
    if (!ok) onLaunchError();
  }

  Future<void> _whatsApp(BuildContext context) async {
    Navigator.of(context).pop();
    final ok = await launchUrl(
      Uri.parse('https://wa.me/$_whatsAppNumber'),
      mode: LaunchMode.externalApplication,
    );
    if (!ok) onLaunchError();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── header ──────────────────────────────────────────────────────
          Center(
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                FluentIcons.person_call_24_regular,
                color: AppColors.primary,
                size: 28,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.contactOwnerTitle,
            style: AppTextStyles.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.contactOwnerSubtitle(petName),
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          // The number itself, so the user knows who they're reaching.
          Center(
            child: Text(
              phone,
              style: AppTextStyles.titleSmall
                  .copyWith(color: AppColors.textPrimary),
              textDirection: TextDirection.ltr,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // ── options ─────────────────────────────────────────────────────
          _ContactOption(
            icon: FluentIcons.call_24_filled,
            iconColor: AppColors.onPrimary,
            iconBackground: AppColors.primary,
            title: l10n.contactCall,
            subtitle: l10n.contactCallSubtitle,
            onTap: () => _dial(context),
          ),
          const SizedBox(height: AppSpacing.md),
          _ContactOption(
            // The SVG already carries the green rounded background + glyph.
            leading: ClipRRect(
              borderRadius: AppRadius.mdAll,
              child: SvgPicture.asset(
                'assets/icons/whatsapp.svg',
                width: 48,
                height: 48,
              ),
            ),
            title: l10n.contactWhatsApp,
            subtitle: l10n.contactWhatsAppSubtitle,
            onTap: () => _whatsApp(context),
          ),
        ],
      ),
    );
  }
}

/// A large tappable row: a 48×48 leading visual + title/subtitle + chevron.
///
/// Provide either an [icon] (rendered on a colored [iconBackground] chip) or a
/// fully-formed [leading] widget (e.g. an SVG that supplies its own chip).
class _ContactOption extends StatelessWidget {
  const _ContactOption({
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.icon,
    this.iconColor,
    this.iconBackground,
    this.leading,
  }) : assert(icon != null || leading != null,
            'Provide either an icon or a leading widget');

  final IconData? icon;
  final Color? iconColor;
  final Color? iconBackground;

  /// A custom 48×48 leading widget; overrides [icon] when set.
  final Widget? leading;

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      borderRadius: AppRadius.lgAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.lgAll,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: leading ??
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: iconBackground,
                        borderRadius: AppRadius.mdAll,
                      ),
                      child: Icon(icon, color: iconColor, size: 24),
                    ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.titleSmall),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              Icon(
                context.isRtl
                    ? FluentIcons.chevron_left_20_regular
                    : FluentIcons.chevron_right_20_regular,
                color: AppColors.textTertiary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
