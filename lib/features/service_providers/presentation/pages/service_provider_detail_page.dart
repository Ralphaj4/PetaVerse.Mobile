import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../../domain/entities/service_provider_detail.dart';
import '../providers/provider_detail_providers.dart';
import '../widgets/provider_badges.dart';
import '../widgets/provider_branch_card.dart';
import '../widgets/provider_hours_list.dart';
import '../widgets/provider_meta_pills.dart';
import '../widgets/provider_rate_sheet.dart';

/// Tap-a-pin provider detail: header, badges, description, all branches (with
/// per-branch contact actions), weekly hours, specializations, and a rate CTA.
class ServiceProviderDetailPage extends ConsumerWidget {
  const ServiceProviderDetailPage({required this.providerId, super.key});

  final int providerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(providerDetailProvider(providerId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorView(
          failure: error is Failure ? error : const UnknownFailure(),
          onRetry: () => ref.invalidate(providerDetailProvider(providerId)),
          onBack: () => context.pop(),
        ),
        data: (detail) => _DetailView(detail: detail),
      ),
    );
  }
}

class _DetailView extends ConsumerWidget {
  const _DetailView({required this.detail});

  final ServiceProviderDetail detail;

  Future<void> _rate(BuildContext context, WidgetRef ref) async {
    final stars = await ProviderRateSheet.show(context, current: detail.myStars);
    if (stars == null) return;
    try {
      await ref.read(providerRatingProvider.notifier).rate(detail.id, stars);
      if (context.mounted) {
        context.showSuccessSnackBar(context.l10n.providerRateThanks);
      }
    } on Failure catch (f) {
      if (context.mounted) {
        context.showErrorSnackBar(f.localizedMessage(context.l10n));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return CustomScrollView(
      slivers: [
        _Header(detail: detail),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(detail.name, style: AppTextStyles.headlineMedium),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    RatingPill(
                      rating: detail.rating,
                      reviewCount: detail.reviewCount,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    OpenStatusPill(
                      isOpen: detail.isOpen,
                      hoursLabel: detail.hoursLabel,
                    ),
                  ],
                ),
                if (detail.badges.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  ProviderBadges(badges: detail.badges),
                ],
                const SizedBox(height: AppSpacing.md),
                _RateButton(
                  myStars: detail.myStars,
                  onTap: () => _rate(context, ref),
                ),
                if (detail.description != null &&
                    detail.description!.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.lg),
                  Text(detail.description!, style: AppTextStyles.bodyMedium),
                ],
                if (detail.specializations.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.lg),
                  _Section(title: l10n.providerSpecializations),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final s in detail.specializations)
                        _Chip(label: s.label),
                    ],
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                _Section(
                  title: detail.branches.length > 1
                      ? l10n.providerBranchesCount(detail.branches.length)
                      : l10n.providerLocation,
                ),
                const SizedBox(height: AppSpacing.sm),
                for (final branch in detail.branches) ...[
                  ProviderBranchCard(
                    branch: branch,
                    providerName: detail.name,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
                if (detail.hours.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  _Section(title: l10n.providerHours),
                  const SizedBox(height: AppSpacing.sm),
                  ProviderHoursList(hours: detail.hours),
                ],
                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Photo header with a floating back button and category tint scrim.
class _Header extends StatelessWidget {
  const _Header({required this.detail});

  final ServiceProviderDetail detail;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: _CircleButton(
          icon: FluentIcons.arrow_left_24_regular,
          onTap: () => context.pop(),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: AppCachedImage(
          imageUrl: detail.photoUrl,
          width: double.infinity,
          height: 220,
          borderRadius: BorderRadius.zero,
          semanticLabel: detail.name,
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, size: 20, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) =>
      Text(title, style: AppTextStyles.titleMedium);
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondarySoft,
        borderRadius: AppRadius.smAll,
      ),
      child: Text(
        label,
        style: AppTextStyles.labelMedium.copyWith(
          color: AppColors.secondary,
          letterSpacing: 0,
        ),
      ),
    );
  }
}

class _RateButton extends StatelessWidget {
  const _RateButton({required this.myStars, required this.onTap});

  final int? myStars;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final rated = myStars != null && myStars! > 0;
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(
        rated ? FluentIcons.star_24_filled : FluentIcons.star_24_regular,
        size: 18,
        color: AppColors.primary,
      ),
      label: Text(rated ? l10n.providerUpdateRating : l10n.providerRate),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.divider),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.smAll),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.failure,
    required this.onRetry,
    required this.onBack,
  });

  final Failure failure;
  final VoidCallback onRetry;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final notFound = failure is NotFoundFailure;
    return SafeArea(
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: _CircleButton(
                icon: FluentIcons.arrow_left_24_regular,
                onTap: onBack,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      FluentIcons.error_circle_24_regular,
                      size: 44,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      notFound
                          ? l10n.providerNotFoundTitle
                          : l10n.providerErrorTitle,
                      style: AppTextStyles.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      failure.localizedMessage(l10n),
                      style: AppTextStyles.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    if (!notFound) ...[
                      const SizedBox(height: AppSpacing.lg),
                      FilledButton(
                        onPressed: onRetry,
                        child: Text(l10n.retry),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
