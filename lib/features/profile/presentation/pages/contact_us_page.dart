import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/network/app_config_datasource.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class ContactUsPage extends ConsumerWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final configAsync = ref.watch(appConfigProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(l10n.contactUs, style: AppTextStyles.titleMedium),
      ),
      body: configAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => _ErrorBody(onRetry: () => ref.invalidate(appConfigProvider)),
        data: (result) => result.when(
          success: (config) => _Body(
            supportEmail: config.supportEmail,
            supportPhone: config.supportPhone,
          ),
          failure: (_) => _ErrorBody(onRetry: () => ref.invalidate(appConfigProvider)),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.supportEmail, required this.supportPhone});

  final String supportEmail;
  final String supportPhone;

  Future<void> _openEmail(BuildContext context, String subject) async {
    final uri = Uri(
      scheme: 'mailto',
      path: supportEmail,
      queryParameters: {'subject': subject},
    );
    if (!await launchUrl(uri)) {
      if (context.mounted) {
        context.showErrorSnackBar(context.l10n.contactLaunchError);
      }
    }
  }

  Future<void> _openWhatsApp(BuildContext context) async {
    // WhatsApp expects the number as digits only (no '+', spaces or dashes).
    final digits = supportPhone.replaceAll(RegExp(r'[^0-9]'), '');
    final uri = Uri.parse('https://wa.me/$digits');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        context.showErrorSnackBar(context.l10n.contactLaunchError);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        const SizedBox(height: AppSpacing.md),
        // Header illustration / icon
        Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              color: AppColors.secondarySoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              FluentIcons.mail_24_filled,
              size: 36,
              color: AppColors.secondary,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          l10n.contactUsTitle,
          style: AppTextStyles.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.contactUsSubtitle,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xxl),

        // Contact Us card
        _EmailCard(
          icon: FluentIcons.chat_help_24_regular,
          iconColor: AppColors.secondary,
          title: l10n.contactUs,
          subtitle: l10n.contactUsEmailSubtitle,
          onTap: () => _openEmail(context, l10n.contactUsEmailSubject),
        ),
        const SizedBox(height: AppSpacing.md),

        // Report a Problem card
        _EmailCard(
          icon: FluentIcons.bug_24_regular,
          iconColor: AppColors.accentCoral,
          title: l10n.reportProblem,
          subtitle: l10n.reportProblemSubtitle,
          onTap: () => _openEmail(context, l10n.reportProblemEmailSubject),
        ),

        // Text Us (WhatsApp) card - only when a support phone is configured.
        if (supportPhone.trim().isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          _EmailCard(
            // The SVG already carries the green rounded background + glyph.
            leading: ClipRRect(
              borderRadius: AppRadius.mdAll,
              child: SvgPicture.asset(
                'assets/icons/whatsapp.svg',
                width: 48,
                height: 48,
              ),
            ),
            title: l10n.textUs,
            subtitle: l10n.textUsSubtitle,
            onTap: () => _openWhatsApp(context),
          ),
        ],

        const SizedBox(height: AppSpacing.xxl),
        Text(
          l10n.contactUsResponseTime,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _EmailCard extends StatelessWidget {
  const _EmailCard({
    this.icon,
    this.iconColor,
    this.leading,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : assert(leading != null || (icon != null && iconColor != null),
            'Provide either a leading widget or an icon + iconColor.');

  final IconData? icon;
  final Color? iconColor;

  /// A fully-formed 48×48 leading visual (e.g. an SVG that supplies its own
  /// chip). Takes precedence over [icon] when provided.
  final Widget? leading;

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: AppRadius.lgAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.lgAll,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              leading ??
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: iconColor!.withValues(alpha: 0.12),
                      borderRadius: AppRadius.mdAll,
                    ),
                    child: Icon(icon, size: 24, color: iconColor),
                  ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.titleSmall),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Icon(
                FluentIcons.arrow_up_right_24_regular,
                size: 18,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              FluentIcons.warning_24_regular,
              size: 48,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.errorServer,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(onPressed: onRetry, child: Text(l10n.retry)),
          ],
        ),
      ),
    );
  }
}
