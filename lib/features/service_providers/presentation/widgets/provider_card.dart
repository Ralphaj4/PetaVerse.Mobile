import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../../domain/entities/provider_category.dart';
import '../../domain/entities/service_provider.dart';
import 'provider_badges.dart';
import 'provider_format.dart';
import 'provider_meta_pills.dart';

/// Premium provider card used in the expanded list.
///
/// Layout: a square photo on the leading edge, then name + category, the
/// open/rating/distance meta line, badges, address, and a "View Details" button.
/// When [selected], it lifts with a brand-tinted border so the card tapped on
/// the map is visually linked to its highlighted pin.
class ProviderCard extends StatelessWidget {
  const ProviderCard({
    required this.provider,
    this.selected = false,
    this.onTap,
    this.onViewDetails,
    super.key,
  });

  final ServiceProvider provider;
  final bool selected;
  final VoidCallback? onTap;
  final VoidCallback? onViewDetails;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final accent = provider.primaryCategory.color;

    return Semantics(
      button: true,
      selected: selected,
      label: provider.name,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.lgAll,
          border: Border.all(
            color: selected ? accent : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: selected
                  ? accent.withValues(alpha: 0.20)
                  : AppColors.textPrimary.withValues(alpha: 0.06),
              blurRadius: selected ? 20 : 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: AppRadius.lgAll,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Photo(provider: provider, accent: accent),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(child: _Info(provider: provider, accent: accent)),
                    ],
                  ),
                  if (provider.badges.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.md),
                    ProviderBadges(badges: provider.badges),
                  ],
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    width: double.infinity,
                    child: Material(
                      color: AppColors.primary,
                      borderRadius: AppRadius.smAll,
                      child: InkWell(
                        onTap: onViewDetails,
                        borderRadius: AppRadius.smAll,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.sm,
                            horizontal: AppSpacing.md,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FluentIcons.open_24_regular,
                                color: AppColors.onPrimary,
                                size: 18,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                l10n.viewDetails,
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: AppColors.onPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({required this.provider, required this.accent});

  final ServiceProvider provider;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppCachedImage(
          imageUrl: provider.photoUrl,
          width: 84,
          height: 84,
          borderRadius: AppRadius.mdAll,
          semanticLabel: provider.name,
        ),
        // Category glyph chip, bottom-start, so the type reads at a glance.
        PositionedDirectional(
          bottom: 5,
          start: 5,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.surface, width: 1.5),
            ),
            child: Icon(
              provider.primaryCategory.filledIcon,
              size: 12,
              color: AppColors.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.provider, required this.accent});

  final ServiceProvider provider;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final distance = ProviderFormat.distance(l10n, provider.distanceKm);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          provider.name,
          style: AppTextStyles.titleSmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          ProviderFormat.category(l10n, provider.primaryCategory),
          style: AppTextStyles.labelMedium.copyWith(
            color: accent,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            RatingPill(rating: provider.rating, reviewCount: provider.reviewCount),
            if (distance.isNotEmpty) ...[
              _dot(),
              Flexible(
                child: Text(
                  distance,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 4),
        OpenStatusPill(isOpen: provider.isOpen, hoursLabel: provider.hoursLabel),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(
              FluentIcons.location_24_regular,
              size: 13,
              color: AppColors.textTertiary,
            ),
            const SizedBox(width: 3),
            Expanded(
              child: Text(
                provider.address,
                style: AppTextStyles.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _dot() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Container(
          width: 3,
          height: 3,
          decoration: const BoxDecoration(
            color: AppColors.textTertiary,
            shape: BoxShape.circle,
          ),
        ),
      );
}
