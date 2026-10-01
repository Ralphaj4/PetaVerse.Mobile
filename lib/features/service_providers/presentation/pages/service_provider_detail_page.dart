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
    // Hero height matches _ProviderHeroHeader (without the old avatar overhang).
    final heroHeight = 280.0 + topPadding;
    // Avatar center sits exactly on the hero/content boundary.
    final avatarTop = heroHeight - _ProviderHeroHeader._avatarRadius - AppRadius.lg;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Scrollable content behind the avatar
        SingleChildScrollView(
          child: Column(
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
        ),

        // Avatar floats above everything — highest z-order in the Stack.
        PositionedDirectional(
          start: AppSpacing.xl,
          top: avatarTop,
          child: Container(
            width: _ProviderHeroHeader._avatarRadius * 2,
            height: _ProviderHeroHeader._avatarRadius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black26,
                width: _ProviderHeroHeader._avatarBorder,
              ),
              color: AppColors.surface,
            ),
            child: ClipOval(
              child: AppCachedImage(
                imageUrl: detail.photoUrl,
                width: _ProviderHeroHeader._avatarRadius * 2,
                height: _ProviderHeroHeader._avatarRadius * 2,
                borderRadius: BorderRadius.zero,
                semanticLabel: detail.name,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
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
            .copyWith(top: AppRadius.lg + 60 + AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Verified badge
            if (detail.isVerified) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      FluentIcons.checkmark_circle_24_filled,
                      color: AppColors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      context.l10n.badgeVerified,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primary,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],

            // Name
            Text(
              detail.name,
              style: AppTextStyles.headlineLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
              _SectionHeader(
                icon: FluentIcons.checkmark_circle_24_regular,
                title: context.l10n.providerServices,
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final service in detail.services)
                    _ServiceChip(service: service),
                ],
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

  Future<void> _call() async {
    final phone = widget.branch.phone;
    if (phone == null || phone.isEmpty) return;
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lat = widget.branch.location.latitude;
    final lng = widget.branch.location.longitude;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.smAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Address + distance + Buttons (stacked)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.branch.address,
                    style: AppTextStyles.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (widget.branch.distanceKm != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      context.l10n.providerKmAway(widget.branch.distanceKm!.toStringAsFixed(1)),
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                  const SizedBox(height: AppSpacing.lg),
                  // Stacked buttons
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (widget.branch.phone != null &&
                          widget.branch.phone!.isNotEmpty) ...[
                        Material(
                          color: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppRadius.smAll,
                          ),
                          child: InkWell(
                            onTap: _call,
                            borderRadius: AppRadius.smAll,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSpacing.sm,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    FluentIcons.call_24_regular,
                                    color: AppColors.onPrimary,
                                    size: 18,
                                  ),
                                  const SizedBox(width: AppSpacing.xs),
                                  Text(
                                    context.l10n.providerCall,
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
                        const SizedBox(height: AppSpacing.sm),
                      ],
                      Material(
                        color: AppColors.secondarySoft,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.smAll,
                          side: const BorderSide(color: AppColors.secondary),
                        ),
                        child: InkWell(
                          onTap: () async {
                            final ok = await ProviderActions.navigateTo(
                              widget.branch.location,
                              widget.providerName,
                            );
                            if (!ok && context.mounted) {
                              context.showErrorSnackBar(
                                context.l10n.providerDirectionsFailed,
                              );
                            }
                          },
                          borderRadius: AppRadius.smAll,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.sm,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  FluentIcons.location_24_regular,
                                  color: AppColors.secondary,
                                  size: 18,
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Text(
                                  context.l10n.providerDirections,
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
                      if (widget.branch.whatsApp != null &&
                          widget.branch.whatsApp!.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.sm),
                        Material(
                          color: const Color(0xFF25D366),
                          shape: RoundedRectangleBorder(
                            borderRadius: AppRadius.smAll,
                          ),
                          child: InkWell(
                            onTap: () async {
                              final whatsapp = widget.branch.whatsApp;
                              if (whatsapp == null || whatsapp.isEmpty) return;
                              final uri = Uri(
                                scheme: 'https',
                                host: 'wa.me',
                                path: '/$whatsapp',
                                queryParameters: {'text': ''},
                              );
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri,
                                    mode: LaunchMode.externalApplication);
                              }
                            },
                            borderRadius: AppRadius.smAll,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSpacing.sm,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: SvgPicture.asset(
                                      'assets/icons/whatsapp.svg',
                                      semanticsLabel: context.l10n.providerWhatsApp,
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.xs),
                                  Text(
                                    context.l10n.providerWhatsApp,
                                    style: AppTextStyles.labelMedium.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Right: Google Map
            Container(
              width: 150,
              height: widget.branch.whatsApp != null &&
                      widget.branch.whatsApp!.isNotEmpty
                  ? 175
                  : 135,
              decoration: BoxDecoration(
                borderRadius: AppRadius.smAll,
                border: Border.all(color: AppColors.divider),
                color: AppColors.surface,
              ),
              child: ClipRRect(
                borderRadius: AppRadius.smAll,
                child: GoogleMap(
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
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

class _ServiceChip extends StatelessWidget {
  const _ServiceChip({required this.service});

  final ProviderService service;

  @override
  Widget build(BuildContext context) {
    final icon = getServiceIcon(service.name);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: AppRadius.smAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: AppSpacing.xs),
          Text(
            service.name,
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.primary,
              letterSpacing: 0,
            ),
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
