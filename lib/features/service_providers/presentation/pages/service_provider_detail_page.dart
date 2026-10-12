import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/service_icons.dart';
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
import '../widgets/provider_actions.dart';
import '../widgets/provider_hours_list.dart';
import '../widgets/provider_meta_pills.dart';
import '../widgets/provider_rate_sheet.dart';

class ServiceProviderDetailPage extends ConsumerWidget {
  const ServiceProviderDetailPage({
    required this.providerId,
    this.branchId,
    super.key,
  });

  final int providerId;
  final int? branchId;

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
        data: (detail) {
          // Find the tapped branch (or fall back to the first one).
          final branch = branchId != null
              ? detail.branches.firstWhere(
                  (b) => b.id == branchId,
                  orElse: () => detail.branches.first,
                )
              : detail.branches.isNotEmpty
                  ? detail.branches.first
                  : null;
          return _DetailView(
            detail: detail,
            providerId: providerId,
            branchId: branchId,
            heroImageUrl: branch?.storefrontImageUrl,
          );
        },
      ),
    );
  }
}

class _DetailView extends ConsumerWidget {
  const _DetailView({
    required this.detail,
    required this.providerId,
    this.branchId,
    this.heroImageUrl,
  });

  final ServiceProviderDetail detail;
  final int providerId;
  final int? branchId;
  final String? heroImageUrl;

  Future<void> _rate(BuildContext context, WidgetRef ref) async {
    final stars = await ProviderRateSheet.show(context, current: detail.myStars);
    if (stars == null) return;
    try {
      await ref.read(providerRatingProvider.notifier).rate(providerId, stars);
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
    final topPadding = MediaQuery.paddingOf(context).top;
    const avatarRadius = _ProviderHeroHeader._avatarRadius;
    const avatarBorder = _ProviderHeroHeader._avatarBorder;
    const avatarDiameter = avatarRadius * 2;
    // Hero height must match _ProviderHeroHeader so the avatar top is exact.
    final heroHeight = 280.0 + topPadding;
    // Avatar top: hero bottom minus avatar radius, pulled up by the corner
    // radius so it sits centred on the hero/content seam.
    final avatarTop = heroHeight - avatarRadius - AppRadius.lg;

    return SingleChildScrollView(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Column carries the hero + content sheet - lays out height.
          Column(
            children: [
              _ProviderHeroHeader(
                detail: detail,
                heroImageUrl: heroImageUrl,
              ),
              Transform.translate(
                offset: const Offset(0, -AppRadius.lg),
                child: _ProviderContent(
                  detail: detail,
                  branchId: branchId,
                  onRate: () => _rate(context, ref),
                ),
              ),
            ],
          ),
          // Avatar painted last → always on top of the content sheet.
          PositionedDirectional(
            start: AppSpacing.xl,
            top: avatarTop,
            child: Container(
              width: avatarDiameter,
              height: avatarDiameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black26,
                  width: avatarBorder,
                ),
                color: AppColors.surface,
              ),
              child: ClipOval(
                child: AppCachedImage(
                  imageUrl: detail.photoUrl,
                  width: avatarDiameter,
                  height: avatarDiameter,
                  borderRadius: BorderRadius.zero,
                  semanticLabel: detail.name,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Full-width Hero Header ───────────────────────────────────────────────────

class _ProviderHeroHeader extends StatelessWidget {
  const _ProviderHeroHeader({
    required this.detail,
    required this.heroImageUrl,
  });

  final ServiceProviderDetail detail;
  final String? heroImageUrl;

  static const double _avatarRadius = 60;
  static const double _avatarBorder = 4;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return SizedBox(
      height: 280 + topPadding,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Full-width storefront image
          AppCachedImage(
            imageUrl: heroImageUrl,
            width: double.infinity,
            height: double.infinity,
            borderRadius: BorderRadius.zero,
            semanticLabel: detail.name,
            fit: BoxFit.cover,
          ),

          // Dark scrim
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.3),
                  ],
                ),
              ),
            ),
          ),

          // Back button
          PositionedDirectional(
            start: AppSpacing.lg,
            top: topPadding + AppSpacing.sm,
            child: _CircleButton(
              icon: FluentIcons.arrow_left_24_regular,
              onTap: () => context.pop(),
            ),
          ),
        ],
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

// ── Content Sheet ────────────────────────────────────────────────────────────

class _ProviderContent extends ConsumerWidget {
  const _ProviderContent({
    required this.detail,
    required this.onRate,
    this.branchId,
  });

  final ServiceProviderDetail detail;
  final VoidCallback onRate;
  final int? branchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Resolve the emergency number: prefer the selected branch, fall back to
    // the first branch that has one.
    final emergencyNumber = () {
      if (branchId != null) {
        final selected = detail.branches
            .where((b) => b.id == branchId)
            .firstOrNull;
        if (selected?.emergency?.isNotEmpty == true) return selected!.emergency!;
      }
      for (final b in detail.branches) {
        if (b.emergency?.isNotEmpty == true) return b.emergency!;
      }
      return null;
    }();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(AppRadius.lg),
          topEnd: Radius.circular(AppRadius.lg),
        ),
      ),
      child: Padding(
        // Top padding: corner radius overlap + avatar overhang (60px radius)
        // + gap so the name clears the avatar bottom edge.
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg)
            .copyWith(top: AppRadius.lg + 38 + AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name + verified tick
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    detail.name,
                    style: AppTextStyles.headlineLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (detail.isVerified) ...[
                  const SizedBox(width: AppSpacing.xs),
                  const Icon(
                    FluentIcons.checkmark_circle_24_filled,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ],
              ],
            ),

            const SizedBox(height: AppSpacing.md),

            // Rating + Status + Rate button
            Row(
              children: [
                RatingPill(
                  rating: detail.rating,
                  reviewCount: detail.reviewCount,
                ),
                const SizedBox(width: AppSpacing.sm),
                OpenStatusPill(
                  isOpen: detail.isOpen,
                  hoursLabel: detail.hoursLabel,
                ),
                const Spacer(),
                Material(
                  color: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.smAll,
                  ),
                  child: InkWell(
                    onTap: onRate,
                    borderRadius: AppRadius.smAll,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            detail.myStars != null && detail.myStars! > 0
                                ? FluentIcons.star_24_filled
                                : FluentIcons.star_24_regular,
                            color: AppColors.onPrimary,
                            size: 20,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            context.l10n.providerRate,
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
              ],
            ),

            // Emergency
            if (emergencyNumber != null) ...[
              const SizedBox(height: AppSpacing.xl),
              _EmergencyBanner(phoneNumber: emergencyNumber),
            ],

            // Description section
            if (detail.description != null &&
                detail.description!.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xl),
              _SectionHeader(
                icon: FluentIcons.info_24_regular,
                title: context.l10n.providerAbout,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                detail.description!,
                style: AppTextStyles.bodyMedium,
              ),
            ],

            // Services section
            if (detail.services.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xl),
              _ExpandableServiceList(
                icon: FluentIcons.checkmark_circle_24_regular,
                title: context.l10n.providerServices,
                items: detail.services
                    .map((s) => _ListItem(
                          icon: getServiceIcon(s.name),
                          label: s.name,
                          accent: AppColors.primary,
                          soft: AppColors.primarySoft,
                        ))
                    .toList(),
              ),
            ],

            // Supported species
            if (detail.supportedSpecies.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xl),
              _SectionHeader(
                icon: FluentIcons.animal_dog_24_regular,
                title: context.l10n.providerSupportedSpecies,
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final species in detail.supportedSpecies)
                    _SpeciesChip(species: species),
                ],
              ),
            ],

            // Locations & Contact
            if (detail.branches.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xl),
              _SectionHeader(
                icon: FluentIcons.location_24_regular,
                title: branchId == null && detail.branches.length > 1
                    ? context.l10n.providerLocationsContact(detail.branches.length)
                    : context.l10n.providerLocationContact,
              ),
              const SizedBox(height: AppSpacing.sm),
              Builder(builder: (context) {
                final branches = branchId == null
                    ? detail.branches
                    : detail.branches.where((b) => b.id == branchId).toList();
                return Column(
                  children: [
                    for (int i = 0; i < branches.length; i++) ...[
                      _LocationCard(
                        branch: branches[i],
                        providerName: detail.name,
                      ),
                      if (i < branches.length - 1)
                        const SizedBox(height: AppSpacing.sm),
                    ],
                  ],
                );
              }),
            ],

            // Hours (collapsible)
            if (detail.hours.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xl),
              _CollapsibleHours(hours: detail.hours),
            ],

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: AppSpacing.sm),
        Text(title, style: AppTextStyles.titleMedium),
      ],
    );
  }
}

class _LocationCard extends StatefulWidget {
  const _LocationCard({required this.branch, required this.providerName});

  final ProviderBranch branch;
  final String providerName;

  @override
  State<_LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<_LocationCard> {
  GoogleMapController? _mapController;

  Future<void> _launch(Uri uri, {LaunchMode mode = LaunchMode.platformDefault}) async {
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: mode);
  }

  Future<void> _call() async {
    final p = widget.branch.phone;
    if (p == null || p.isEmpty) return;
    await _launch(Uri(scheme: 'tel', path: p));
  }

  Future<void> _whatsApp() async {
    final w = widget.branch.whatsApp;
    if (w == null || w.isEmpty) return;
    await _launch(
      Uri(scheme: 'https', host: 'wa.me', path: '/$w', queryParameters: {'text': ''}),
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> _openWebsite() async {
    final raw = widget.branch.website;
    if (raw == null || raw.isEmpty) return;
    final uri = Uri.tryParse(raw.startsWith('http') ? raw : 'https://$raw');
    if (uri == null) return;
    await _launch(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _openInstagram() async {
    final ig = widget.branch.instagram;
    if (ig == null || ig.isEmpty) return;
    final handle = ig.replaceAll('@', '');
    final appUri = Uri.parse('instagram://user?username=$handle');
    final webUri = Uri.parse('https://instagram.com/$handle');
    if (await canLaunchUrl(appUri)) {
      await launchUrl(appUri);
    } else {
      await _launch(webUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final branch = widget.branch;
    final lat = branch.location.latitude;
    final lng = branch.location.longitude;
    final l10n = context.l10n;

    final hasPhone = branch.phone?.isNotEmpty == true;
    final hasWhatsApp = branch.whatsApp?.isNotEmpty == true;
    final hasWebsite = branch.website?.isNotEmpty == true;
    final hasInstagram = branch.instagram?.isNotEmpty == true;
    final hasOnlinePresence = hasWebsite || hasInstagram;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.smAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Map thumbnail ────────────────────────────────────────────────
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppRadius.sm),
            ),
            child: SizedBox(
              height: 140,
              child: GoogleMap(
                onMapCreated: (c) => _mapController = c,
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, lng),
                  zoom: 16,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('provider'),
                    position: LatLng(lat, lng),
                  ),
                },
                zoomControlsEnabled: false,
                scrollGesturesEnabled: false,
                zoomGesturesEnabled: false,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
                myLocationButtonEnabled: false,
                style: '''
[
  { "featureType": "poi", "elementType": "all", "stylers": [{ "visibility": "off" }] },
  { "featureType": "transit", "elementType": "all", "stylers": [{ "visibility": "off" }] }
]''',
              ),
            ),
          ),

          // ── Address + distance ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md, AppSpacing.md, AppSpacing.md, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      FluentIcons.location_24_regular,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        branch.address,
                        style: AppTextStyles.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (branch.distanceKm != null) ...[
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        l10n.providerKmAway(branch.distanceKm!.toStringAsFixed(1)),
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // ── Directions button ────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md, AppSpacing.sm, AppSpacing.md, 0),
            child: Material(
              color: AppColors.secondarySoft,
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.smAll,
                side: const BorderSide(color: AppColors.secondary),
              ),
              child: InkWell(
                onTap: () async {
                  final ok = await ProviderActions.navigateTo(
                    branch.location, widget.providerName);
                  if (!ok && context.mounted) {
                    context.showErrorSnackBar(l10n.providerDirectionsFailed);
                  }
                },
                borderRadius: AppRadius.smAll,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(FluentIcons.location_24_regular,
                          color: AppColors.secondary, size: 18),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        l10n.providerDirections,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Contact actions (Call / WhatsApp) ────────────────────────────
          if (hasPhone || hasWhatsApp) ...[
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              child: Divider(height: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Row(
                children: [
                  if (hasPhone)
                    Expanded(
                      child: _ContactButton(
                        icon: FluentIcons.call_24_regular,
                        label: l10n.providerCall,
                        color: AppColors.primary,
                        onTap: _call,
                      ),
                    ),
                  if (hasPhone && hasWhatsApp)
                    const SizedBox(width: AppSpacing.sm),
                  if (hasWhatsApp)
                    Expanded(
                      child: _WhatsAppButton(onTap: _whatsApp, label: l10n.providerWhatsApp),
                    ),
                ],
              ),
            ),
          ],

          // ── Online presence (Website / Instagram) ────────────────────────
          if (hasOnlinePresence) ...[
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              child: Divider(height: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Row(
                children: [
                  if (hasWebsite)
                    _OnlinePill(
                      icon: FluentIcons.globe_24_regular,
                      label: l10n.providerWebsite,
                      onTap: _openWebsite,
                    ),
                  if (hasWebsite && hasInstagram)
                    const SizedBox(width: AppSpacing.sm),
                  if (hasInstagram)
                    _OnlinePill.svg(
                      svgPath: 'assets/icons/instagram.svg',
                      label: l10n.providerInstagram,
                      onTap: _openInstagram,
                    ),
                ],
              ),
            ),
          ],

          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}

/// WhatsApp button: green background, white logo SVG rendered without any color
/// filter so the SVG's own white paths show cleanly on the green surface.
class _WhatsAppButton extends StatelessWidget {
  const _WhatsAppButton({required this.onTap, required this.label});

  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF25D366),
      borderRadius: AppRadius.smAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.smAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: SvgPicture.asset(
                  'assets/icons/whatsapp.svg',
                  width: 20,
                  height: 20,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Filled action button used in the contact row (Call / WhatsApp / Emergency).
class _ContactButton extends StatelessWidget {
  const _ContactButton({
    required this.label,
    required this.color,
    required this.onTap,
    required this.icon,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: AppRadius.smAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.smAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                Icon(icon, color: Colors.white, size: 20),
              const SizedBox(height: 2),
              Text(
                label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small outlined pill for online presence links (Website / Instagram).
class _OnlinePill extends StatelessWidget {
  const _OnlinePill({
    required this.label,
    required this.onTap,
    this.icon,
    this.svgPath,
  });

  factory _OnlinePill.svg({
    required String svgPath,
    required String label,
    required VoidCallback onTap,
  }) => _OnlinePill(label: label, onTap: onTap, svgPath: svgPath);

  final IconData? icon;
  final String? svgPath;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      borderRadius: AppRadius.smAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.smAll,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            borderRadius: AppRadius.smAll,
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (svgPath != null)
                SizedBox(
                  width: 16,
                  height: 16,
                  child: SvgPicture.asset(
                    svgPath!,
                    colorFilter: const ColorFilter.mode(
                        AppColors.textSecondary, BlendMode.srcIn),
                  ),
                )
              else
                Icon(icon, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: AppSpacing.xs),
              Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Emergency call card — styled as a section card consistent with the rest of
/// the detail page, with a red accent to signal urgency.
class _EmergencyBanner extends StatelessWidget {
  const _EmergencyBanner({required this.phoneNumber});

  final String phoneNumber;

  Future<void> _call() async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      borderRadius: AppRadius.smAll,
      child: InkWell(
        onTap: _call,
        borderRadius: AppRadius.smAll,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppRadius.smAll,
            border: Border.all(color: AppColors.error.withValues(alpha: 0.4)),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: AppRadius.smAll,
                ),
                child: const Icon(
                  FluentIcons.call_24_filled,
                  color: AppColors.error,
                  size: 22,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      phoneNumber,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      context.l10n.providerEmergencyBannerSubtitle,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                FluentIcons.arrow_forward_24_regular,
                color: AppColors.error,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CollapsibleHours extends StatefulWidget {
  const _CollapsibleHours({required this.hours});

  final List<ProviderHours> hours;

  @override
  State<_CollapsibleHours> createState() => _CollapsibleHoursState();
}

class _CollapsibleHoursState extends State<_CollapsibleHours>
    with SingleTickerProviderStateMixin {
  bool _showAll = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _showAll = !_showAll);
    if (_showAll) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  String _getDayName(BuildContext context, int weekday) {
    final l10n = context.l10n;
    return [
      l10n.providerDaySunday,
      l10n.providerDayMonday,
      l10n.providerDayTuesday,
      l10n.providerDayWednesday,
      l10n.providerDayThursday,
      l10n.providerDayFriday,
      l10n.providerDaySaturday,
    ][weekday];
  }

  String _getTodayHoursText(BuildContext context) {
    final now = DateTime.now();
    final todayOfWeek = (now.weekday % 7);

    final todayHours = widget.hours
        .where((h) => h.dayOfWeek == todayOfWeek)
        .toList();

    if (todayHours.isEmpty) {
      return context.l10n.providerClosedToday;
    }

    final hour = todayHours.first;
    return '${hour.startTime} - ${hour.endTime}';
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final todayOfWeek = (now.weekday % 7);
    final dayName = _getDayName(context, todayOfWeek);
    final hoursText = _getTodayHoursText(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Row(
                children: [
                  const Icon(
                    FluentIcons.clock_24_regular,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    context.l10n.providerHoursLabel,
                    style: AppTextStyles.titleMedium,
                  ),
                  const Spacer(),
                  RotationTransition(
                    turns: _animation,
                    child: const Icon(
                      FluentIcons.chevron_down_24_regular,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: _showAll
              ? ProviderHoursList(hours: widget.hours)
              : Padding(
                  padding: const EdgeInsets.only(left: AppSpacing.lg),
                  child: Text(
                    '$dayName      $hoursText',
                    style: AppTextStyles.bodyMedium,
                  ),
                ),
        ),
      ],
    );
  }
}

/// Data holder for a single row in [_ExpandableServiceList].
class _ListItem {
  const _ListItem({
    required this.icon,
    required this.label,
    required this.accent,
    required this.soft,
  });
  final IconData icon;
  final String label;
  final Color accent;
  final Color soft;
}

/// Shows a section header + a list of items, collapsing to [_kPreviewCount]
/// rows by default with an animated expand/collapse toggle.
class _ExpandableServiceList extends StatefulWidget {
  const _ExpandableServiceList({
    required this.icon,
    required this.title,
    required this.items,
  });

  final IconData icon;
  final String title;
  final List<_ListItem> items;

  @override
  State<_ExpandableServiceList> createState() => _ExpandableServiceListState();
}

class _ExpandableServiceListState extends State<_ExpandableServiceList> {
  static const int _kPreviewCount = 3;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final items = widget.items;
    final canExpand = items.length > _kPreviewCount;
    final visible = _expanded || !canExpand ? items : items.take(_kPreviewCount).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header row — title on left, toggle on right.
        Row(
          children: [
            Icon(widget.icon, size: 20, color: AppColors.primary),
            const SizedBox(width: AppSpacing.sm),
            Text(widget.title, style: AppTextStyles.titleMedium),
            const Spacer(),
            if (canExpand)
              GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Text(
                  _expanded
                      ? l10n.providerShowLess
                      : l10n.providerShowAll(items.length),
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        // Animated list container.
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.smAll,
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              children: [
                for (int i = 0; i < visible.length; i++) ...[
                  _ServiceRow(item: visible[i]),
                  if (i < visible.length - 1)
                    const Divider(height: 1, indent: 48),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ServiceRow extends StatelessWidget {
  const _ServiceRow({required this.item});

  final _ListItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 2,
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: item.soft,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(item.icon, size: 16, color: item.accent),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              item.label,
              style: AppTextStyles.bodyMedium,
            ),
          ),
          Icon(
            FluentIcons.checkmark_24_regular,
            size: 16,
            color: item.accent,
          ),
        ],
      ),
    );
  }
}

class _SpeciesChip extends StatelessWidget {
  const _SpeciesChip({required this.species});

  final ProviderSpecies species;

  @override
  Widget build(BuildContext context) {
    final icon = getSpeciesIcon(species.name);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondarySoft,
        borderRadius: AppRadius.smAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.secondary),
          const SizedBox(width: AppSpacing.xs),
          Text(
            species.name,
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.secondary,
              letterSpacing: 0,
            ),
          ),
        ],
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
