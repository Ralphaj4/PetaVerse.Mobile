import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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

/// Max length of the free-text location name, matching the API contract.
const int kLocationNameMaxLength = 200;

/// Reusable location picker: an interactive map to drop/drag a pin (capturing
/// latitude/longitude) plus a free-text address field for a human-readable
/// [locationName]. Both are **required**.
///
/// Wire it into an ancestor [FormBuilder]: the address is registered as a
/// [FormBuilderTextField] under [addressFieldName], so its value and
/// validation flow through the parent form. The coordinate is surfaced via
/// [onLocationChanged] (the parent owns it, since it isn't a form field).
///
/// Behaviour mirrors the Lost & Found report flow:
/// * The map defaults to the device's current position (with permission),
///   falling back to [kDefaultMapCenter] when denied/unavailable.
/// * Dropping/dragging the pin (or "use my location") reverse-geocodes the
///   coordinate into the address field — but only when the field is empty or
///   still holds a value we auto-filled. Text the user typed is never
///   overwritten.
class LocationField extends ConsumerStatefulWidget {
  const LocationField({
    required this.addressFieldName,
    required this.onLocationChanged,
    this.initialLocation,
    this.initialLocationName,
    this.accent = AppColors.primary,
    this.showValidationError = false,
    super.key,
  });

  /// FormBuilder field name the address text field registers under.
  final String addressFieldName;

  /// Called whenever the pin moves (or is first set). Never called with null.
  final ValueChanged<LatLng> onLocationChanged;

  /// Pre-fills the pin (e.g. editing an existing profile).
  final LatLng? initialLocation;

  /// Pre-fills the address text field (e.g. editing an existing profile).
  final String? initialLocationName;

  /// Tint for the pin and "use my location" button.
  final Color accent;

  /// When true, shows the "pick a location" error under the map (used by the
  /// parent form on a submit attempt with no pin, since the coordinate lives
  /// outside the FormBuilder and can't validate itself).
  final bool showValidationError;

  @override
  ConsumerState<LocationField> createState() => _LocationFieldState();
}

class _LocationFieldState extends ConsumerState<LocationField> {
  LatLng? _location;

  /// True while fetching the device location / reverse-geocoding.
  bool _locating = false;

  /// The address value we last reverse-geocoded into the field, or null if the
  /// user has since edited (or we never auto-filled). A new pin may overwrite
  /// an auto-filled value, but never one the user typed.
  String? _autoFilledAddress;

  @override
  void initState() {
    super.initState();
    _location = widget.initialLocation;
    // When editing, the pre-filled address counts as "auto-filled" so a later
    // pin move can refresh it — but a user edit still takes precedence.
    _autoFilledAddress = widget.initialLocationName;
    if (_location == null) {
      // No initial pin — center on the device once permission resolves.
      WidgetsBinding.instance.addPostFrameCallback((_) => _centerOnDevice());
    }
  }

  /// One-shot device-location read used purely to *center* the empty map; it
  /// does not drop a pin (the user must still choose their location).
  Future<void> _centerOnDevice() async {
    final here = await ref.read(locationServiceProvider).currentLatLng();
    if (!mounted || here == null || _location != null) return;
    setState(() => _mapCenter = here);
  }

  /// The empty-state map center: device location if we have it, else the
  /// app-wide default. Once a pin exists, [MapView] follows [_location].
  LatLng _mapCenter = kDefaultMapCenter;

  /// Fetches the device's current position and applies it as the pin+address.
  Future<void> _useMyLocation() async {
    setState(() => _locating = true);
    final here = await ref.read(locationServiceProvider).currentLatLng();
    if (!mounted) return;
    if (here == null) {
      setState(() => _locating = false);
      context.showErrorSnackBar(context.l10n.errorUnknown);
      return;
    }
    await _applyLocation(here);
  }

  /// Sets the pin to [point] and, when allowed, fills the address field by
  /// reverse-geocoding it. The pin is set regardless; the address is a
  /// best-effort convenience — geocoding failures are silent.
  Future<void> _applyLocation(LatLng point) async {
    setState(() {
      _location = point;
      _locating = true;
    });
    widget.onLocationChanged(point);

    final field = _formField;
    final existing = (field?.value as String?)?.trim();
    // Fill when empty, or when the current value is one we auto-filled (the
    // user hasn't taken over the field). Never clobber user-typed text.
    final mayFill = existing == null ||
        existing.isEmpty ||
        (_autoFilledAddress != null && existing == _autoFilledAddress);

    if (mayFill) {
      final result = await ref.read(geocodingServiceProvider).reverse(
            latitude: point.latitude,
            longitude: point.longitude,
          );
      final address = result.valueOrNull;
      if (address != null && mounted) {
        _autoFilledAddress = address;
        _formField?.didChange(address);
      }
    }

    if (mounted) setState(() => _locating = false);
  }

  FormFieldState<dynamic>? get _formField =>
      FormBuilder.of(context)?.fields[widget.addressFieldName];

  Future<void> _openFullScreen() async {
    final picked = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (_) => _FullScreenLocationPicker(
          initial: _location,
          center: _location ?? _mapCenter,
          accent: widget.accent,
        ),
      ),
    );
    if (picked != null) await _applyLocation(picked);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Address (locationName) ───────────────────────────────────────
        FormBuilderTextField(
          name: widget.addressFieldName,
          initialValue: widget.initialLocationName,
          maxLength: kLocationNameMaxLength,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: l10n.locationName,
            hintText: l10n.locationNameHint,
            prefixIcon: const Icon(
              FluentIcons.location_24_regular,
              size: 20,
              color: AppColors.textSecondary,
            ),
            counterText: '',
          ),
          // Typing takes over the field — drop our auto-fill claim so a later
          // pin move won't overwrite the user's text.
          onChanged: (value) {
            if (value != _autoFilledAddress) _autoFilledAddress = null;
          },
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: l10n.fieldRequired),
            FormBuilderValidators.maxLength(
              kLocationNameMaxLength,
              errorText: l10n.locationNameTooLong,
            ),
          ]),
        ),
        const SizedBox(height: AppSpacing.sm),

        // ── Map ──────────────────────────────────────────────────────────
        _MapCard(
          location: _location,
          center: _location ?? _mapCenter,
          accent: widget.accent,
          hint: l10n.locationPickHint,
          onPicked: _applyLocation,
          onExpand: _openFullScreen,
        ),
        if (widget.showValidationError && _location == null) ...[
          const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: AppSpacing.md),
            child: Text(
              l10n.locationRequired,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        _UseMyLocationButton(
          label: l10n.locationUseMine,
          accent: widget.accent,
          busy: _locating,
          onTap: _useMyLocation,
        ),
      ],
    );
  }
}

/// The 220px inline map card: tap to drop a pin, with a full-screen expand
/// button and a "tap to drop a pin" hint until a location is chosen.
class _MapCard extends StatelessWidget {
  const _MapCard({
    required this.location,
    required this.center,
    required this.accent,
    required this.hint,
    required this.onPicked,
    required this.onExpand,
  });

  final LatLng? location;
  final LatLng center;
  final Color accent;
  final String hint;
  final ValueChanged<LatLng> onPicked;
  final VoidCallback onExpand;

  List<MapMarkerData> _markers() => location == null
      ? const []
      : [
          MapMarkerData(
            id: 'picked',
            point: location!,
            color: accent,
            icon: FluentIcons.location_24_filled,
          ),
        ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.lgAll,
      child: SizedBox(
        height: 220,
        child: Stack(
          children: [
            Positioned.fill(
              child: MapView(
                center: center,
                markers: _markers(),
                cluster: false,
                showRecenterButton: true,
                onTap: onPicked,
              ),
            ),
            PositionedDirectional(
              top: AppSpacing.sm,
              end: AppSpacing.sm,
              child: Material(
                color: AppColors.surface,
                shape: const CircleBorder(),
                elevation: 2,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onExpand,
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      FluentIcons.full_screen_maximize_24_regular,
                      size: 18,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
            if (location == null)
              Center(
                child: IgnorePointer(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.textPrimary.withValues(alpha: 0.12),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FluentIcons.location_24_filled,
                            size: 18, color: accent),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          hint,
                          style: AppTextStyles.labelMedium.copyWith(
                            color: accent,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Full-screen map picker: tap to drop the pin, confirm to return it.
class _FullScreenLocationPicker extends StatefulWidget {
  const _FullScreenLocationPicker({
    required this.center,
    required this.accent,
    this.initial,
  });

  final LatLng? initial;
  final LatLng center;
  final Color accent;

  @override
  State<_FullScreenLocationPicker> createState() =>
      _FullScreenLocationPickerState();
}

class _FullScreenLocationPickerState extends State<_FullScreenLocationPicker> {
  late LatLng? _picked = widget.initial;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: MapView(
              center: _picked ?? widget.center,
              zoom: 15,
              markers: _picked == null
                  ? const []
                  : [
                      MapMarkerData(
                        id: 'picked',
                        point: _picked!,
                        color: widget.accent,
                        icon: FluentIcons.location_24_filled,
                      ),
                    ],
              cluster: false,
              showRecenterButton: true,
              onTap: (p) => setState(() => _picked = p),
            ),
          ),
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
          PositionedDirectional(
            start: AppSpacing.lg,
            end: AppSpacing.lg,
            bottom: AppSpacing.lg,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppRadius.smAll,
                    ),
                    child: Text(
                      l10n.locationPickHint,
                      style: AppTextStyles.bodySmall,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AppButton(
                    label: l10n.confirm,
                    icon: FluentIcons.checkmark_24_regular,
                    variant: AppButtonVariant.primary,
                    onPressed: _picked == null
                        ? null
                        : () => Navigator.of(context).pop(_picked),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The "use my location" button below the map — fills the pin+address from
/// the device's current location.
class _UseMyLocationButton extends StatelessWidget {
  const _UseMyLocationButton({
    required this.label,
    required this.accent,
    required this.busy,
    required this.onTap,
  });

  final String label;
  final Color accent;
  final bool busy;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: accent.withValues(alpha: 0.1),
      borderRadius: AppRadius.mdAll,
      child: InkWell(
        onTap: busy ? null : onTap,
        borderRadius: AppRadius.mdAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (busy)
                SizedBox(
                  width: 18,
                  height: 18,
                  child:
                      CircularProgressIndicator(strokeWidth: 2, color: accent),
                )
              else
                Icon(FluentIcons.my_location_24_filled,
                    color: accent, size: 18),
              const SizedBox(width: AppSpacing.sm),
              Text(
                label,
                style: AppTextStyles.labelLarge.copyWith(
                  color: accent,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
