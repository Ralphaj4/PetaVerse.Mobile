import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../core/extensions/context_extensions.dart';
import '../../core/location/geocoding_service.dart';
import '../../core/location/location_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/map/map_marker_data.dart';
import '../../core/widgets/map/map_view.dart';
import 'app_button.dart';

/// Opens a full-screen map picker and returns the chosen location's
/// human-readable address (reverse-geocoded), or null if the user backs out.
///
/// Tap the map to drop/move a pin; "use my location" centers on the device.
/// The confirmed pin is reverse-geocoded server-side into an address line via
/// [GeocodingService]. For flows that need coordinates too, use [LocationField]
/// instead — this returns only the display name (matching the post composer's
/// string `locationName` field).
Future<String?> pickLocationName(BuildContext context, {String? initial}) {
  return Navigator.of(context).push<String>(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => _LocationNamePicker(initialName: initial),
    ),
  );
}

class _LocationNamePicker extends ConsumerStatefulWidget {
  const _LocationNamePicker({this.initialName});

  final String? initialName;

  @override
  ConsumerState<_LocationNamePicker> createState() =>
      _LocationNamePickerState();
}

class _LocationNamePickerState extends ConsumerState<_LocationNamePicker> {
  LatLng? _picked;
  LatLng _center = kDefaultMapCenter;
  late final TextEditingController _address =
      TextEditingController(text: widget.initialName ?? '');
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    // Center the empty map on the device once permission resolves (no pin yet).
    WidgetsBinding.instance.addPostFrameCallback((_) => _centerOnDevice());
  }

  @override
  void dispose() {
    _address.dispose();
    super.dispose();
  }

  Future<void> _centerOnDevice() async {
    final here = await ref.read(locationServiceProvider).currentLatLng();
    if (!mounted || here == null || _picked != null) return;
    setState(() => _center = here);
  }

  Future<void> _useMyLocation() async {
    setState(() => _busy = true);
    final here = await ref.read(locationServiceProvider).currentLatLng();
    if (!mounted) return;
    if (here == null) {
      setState(() => _busy = false);
      context.showErrorSnackBar(context.l10n.errorUnknown);
      return;
    }
    await _apply(here);
  }

  /// Drops the pin and reverse-geocodes it into the address field (best-effort;
  /// a failed lookup just leaves the field for the user to type into).
  Future<void> _apply(LatLng point) async {
    setState(() {
      _picked = point;
      _center = point;
      _busy = true;
    });
    final result = await ref.read(geocodingServiceProvider).reverse(
          latitude: point.latitude,
          longitude: point.longitude,
        );
    final address = result.valueOrNull;
    if (address != null && mounted) _address.text = address;
    if (mounted) setState(() => _busy = false);
  }

  void _confirm() {
    final name = _address.text.trim();
    // Require either a resolved/typed address; the pin alone isn't enough since
    // the post stores a display name string.
    if (name.isEmpty) return;
    Navigator.of(context).pop(name);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: MapView(
              center: _picked ?? _center,
              zoom: 15,
              markers: _picked == null
                  ? const []
                  : [
                      MapMarkerData(
                        id: 'picked',
                        point: _picked!,
                        color: AppColors.primary,
                        icon: FluentIcons.location_24_filled,
                      ),
                    ],
              cluster: false,
              showRecenterButton: true,
              onTap: _apply,
            ),
          ),
          // Back button.
          PositionedDirectional(
            top: 0,
            start: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Material(
                  color: AppColors.surface,
                  shape: const CircleBorder(),
                  elevation: 2,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: l10n.close,
                    icon: Icon(
                      context.isRtl
                          ? FluentIcons.arrow_right_24_regular
                          : FluentIcons.arrow_left_24_regular,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Bottom card: hint + editable address + confirm.
          PositionedDirectional(
            start: AppSpacing.lg,
            end: AppSpacing.lg,
            bottom: AppSpacing.lg,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppRadius.lgAll,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textPrimary.withValues(alpha: 0.12),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _address,
                      textCapitalization: TextCapitalization.words,
                      style: AppTextStyles.bodyMedium,
                      decoration: InputDecoration(
                        hintText: _busy
                            ? l10n.locationResolving
                            : l10n.pawhubComposerLocationHint,
                        prefixIcon: _busy
                            ? const Padding(
                                padding: EdgeInsets.all(12),
                                child: SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2),
                                ),
                              )
                            : const Icon(FluentIcons.location_24_regular,
                                size: 20, color: AppColors.textSecondary),
                        isDense: true,
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Expanded(
                          child: _UseMyLocationButton(
                            label: l10n.locationUseMine,
                            busy: _busy,
                            onTap: _useMyLocation,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: AppButton(
                            label: l10n.confirm,
                            icon: FluentIcons.checkmark_24_regular,
                            variant: AppButtonVariant.primary,
                            onPressed:
                                _address.text.trim().isEmpty ? null : _confirm,
                          ),
                        ),
                      ],
                    ),
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

class _UseMyLocationButton extends StatelessWidget {
  const _UseMyLocationButton({
    required this.label,
    required this.busy,
    required this.onTap,
  });

  final String label;
  final bool busy;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.secondarySoft,
      borderRadius: AppRadius.mdAll,
      child: InkWell(
        onTap: busy ? null : onTap,
        borderRadius: AppRadius.mdAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(FluentIcons.my_location_24_filled,
                  size: 18, color: AppColors.secondaryDark),
              const SizedBox(width: AppSpacing.xs),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.secondaryDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
