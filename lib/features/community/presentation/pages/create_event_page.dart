import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/location_field.dart';
import '../../domain/entities/poll_event_entities.dart';
import '../providers/community_providers.dart';
import '../providers/poll_event_actions_providers.dart';
import '../widgets/poll_event_form_widgets.dart';

/// Form to create (or edit) an event inside a community. When [existing] is
/// non-null the page is in edit mode (patch update). Returns the created/updated
/// [CommunityEvent] via Navigator.pop.
class CreateEventPage extends ConsumerStatefulWidget {
  const CreateEventPage({
    required this.communityId,
    required this.communityName,
    this.existing,
    super.key,
  });

  final int communityId;
  final String communityName;
  final CommunityEvent? existing;

  @override
  ConsumerState<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends ConsumerState<CreateEventPage> {
  late final TextEditingController _title;
  late final TextEditingController _description;
  // Location is a map-backed picker (same as the signup page): a mini
  // FormBuilder holds the address text field, and [_latLng] holds the pin.
  final _locationFormKey = GlobalKey<FormBuilderState>();
  static const _addressFieldName = 'eventLocation';
  LatLng? _latLng;
  DateTime? _startsAt;
  DateTime? _endsAt;
  bool _submitting = false;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _title = TextEditingController(text: e?.title ?? '')..addListener(_onChanged);
    _description = TextEditingController(text: e?.description ?? '');
    // Seed the pin from an existing event's coordinates (if any).
    final loc = e?.location;
    if (loc != null && loc.hasCoordinates) {
      _latLng = LatLng(loc.lat!, loc.lng!);
    }
    _startsAt = e?.startsAt.toLocal();
    _endsAt = e?.endsAt?.toLocal();
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  /// The current address text from the mini location form (may be empty).
  String get _addressText {
    final field = _locationFormKey.currentState?.fields[_addressFieldName];
    return (field?.value as String?)?.trim() ?? '';
  }

  bool get _canSubmit => _title.text.trim().isNotEmpty && _startsAt != null;

  Future<DateTime?> _pickDateTime(DateTime? initial) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      firstDate: now,
      lastDate: now.add(const Duration(days: 730)),
      initialDate: initial ?? now.add(const Duration(days: 1)),
    );
    if (date == null || !mounted) return null;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
          initial ?? now.add(const Duration(hours: 1))),
    );
    if (!mounted) return null;
    return DateTime(
      date.year,
      date.month,
      date.day,
      time?.hour ?? 12,
      time?.minute ?? 0,
    );
  }

  Future<void> _pickStart() async {
    final picked = await _pickDateTime(_startsAt);
    if (picked != null) setState(() => _startsAt = picked);
  }

  Future<void> _pickEnd() async {
    final picked = await _pickDateTime(_endsAt ?? _startsAt);
    if (picked != null) setState(() => _endsAt = picked);
  }

  String? _validate(String l10nStartFuture, String l10nEndAfter) {
    final start = _startsAt;
    if (start == null) return null;
    // Only enforce future-start on create (an existing event may already
    // have started; the backend allows editing other fields).
    if (!_isEdit && !start.isAfter(DateTime.now())) return l10nStartFuture;
    final end = _endsAt;
    if (end != null && !end.isAfter(start)) return l10nEndAfter;
    return null;
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    final petId = ref.read(actingPetIdProvider);
    if (petId == null || !_canSubmit || _submitting) return;

    final validationError =
        _validate(l10n.eventStartMustBeFuture, l10n.eventEndAfterStart);
    if (validationError != null) {
      _snack(validationError);
      return;
    }

    setState(() => _submitting = true);
    final repo = ref.read(pollEventActionsProvider);
    final title = _title.text.trim();
    final description =
        _description.text.trim().isEmpty ? null : _description.text.trim();
    final displayName = _addressText;
    final location = displayName.isEmpty
        ? null
        : EventLocation(
            displayName: displayName,
            lat: _latLng?.latitude,
            lng: _latLng?.longitude,
          );

    final result = _isEdit
        ? await repo.updateEvent(
            eventId: widget.existing!.id,
            actingPetId: petId,
            title: title,
            description: description,
            location: location,
            // Empty field on an event that had a location → clear it.
            clearLocation:
                location == null && widget.existing!.location != null,
            startsAt: _startsAt,
            endsAt: _endsAt,
          )
        : await repo.createEvent(
            communityId: widget.communityId,
            creatorPetId: petId,
            title: title,
            startsAt: _startsAt!,
            description: description,
            location: location,
            endsAt: _endsAt,
          );
    if (!mounted) return;
    setState(() => _submitting = false);

    result.when(
      success: (event) {
        unawaited(HapticFeedback.mediumImpact());
        Navigator.of(context).pop(event);
      },
      failure: (f) => _snack(f.localizedMessage(l10n)),
    );
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.backgroundWarm,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWarm,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          tooltip: l10n.close,
          icon: const Icon(FluentIcons.dismiss_24_regular),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(_isEdit ? l10n.eventEditTitle : l10n.eventNewTitle,
            style: AppTextStyles.titleLarge),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.lg),
            child: SubmitPillButton(
              label: _isEdit ? l10n.eventUpdateSubmit : l10n.eventCreateSubmit,
              enabled: _canSubmit && !_submitting,
              busy: _submitting,
              onPressed: _submit,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          if (!_isEdit) ...[
            PostingInBanner(name: widget.communityName),
            const SizedBox(height: AppSpacing.md),
          ],
          FormCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.eventTitleLabel, style: AppTextStyles.titleSmall),
                const SizedBox(height: AppSpacing.sm),
                FormField2(
                  controller: _title,
                  hint: l10n.eventTitleHint,
                  maxLength: 200,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(l10n.eventDescriptionLabel,
                    style: AppTextStyles.titleSmall),
                const SizedBox(height: AppSpacing.sm),
                FormField2(
                  controller: _description,
                  hint: l10n.eventDescriptionHint,
                  maxLines: 3,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(l10n.eventLocationLabel, style: AppTextStyles.titleSmall),
                const SizedBox(height: AppSpacing.sm),
                // Map-backed location picker (same widget as the signup page):
                // tap the map to drop a pin, reverse-geocoded into the address.
                // Location is optional here, so the field isn't a submit gate.
                FormBuilder(
                  key: _locationFormKey,
                  child: LocationField(
                    addressFieldName: _addressFieldName,
                    initialLocation: _latLng,
                    initialLocationName: widget.existing?.location?.displayName,
                    onLocationChanged: (p) => setState(() => _latLng = p),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          FormCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _DateRow(
                  icon: FluentIcons.calendar_ltr_24_regular,
                  label: l10n.eventStartsLabel,
                  value: _startsAt == null
                      ? null
                      : formatDateTimeLabel(context, _startsAt!),
                  onTap: _pickStart,
                ),
                const Divider(
                    height: 1, indent: AppSpacing.lg, endIndent: AppSpacing.lg),
                _DateRow(
                  icon: FluentIcons.calendar_arrow_right_24_regular,
                  label: l10n.eventEndsLabel,
                  value: _endsAt == null
                      ? null
                      : formatDateTimeLabel(context, _endsAt!),
                  onClear: _endsAt == null
                      ? null
                      : () => setState(() => _endsAt = null),
                  onTap: _pickEnd,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _DateRow extends StatelessWidget {
  const _DateRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    this.onClear,
  });

  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.secondary),
      title: Text(label, style: AppTextStyles.bodyMedium),
      subtitle: value == null
          ? null
          : Text(value!,
              style: AppTextStyles.labelMedium
                  .copyWith(color: AppColors.textSecondary)),
      trailing: onClear != null
          ? IconButton(
              tooltip: context.l10n.clear,
              icon: const Icon(FluentIcons.dismiss_24_regular, size: 18),
              onPressed: onClear,
            )
          : const Icon(FluentIcons.chevron_right_24_regular,
              size: 18, color: AppColors.textTertiary),
      onTap: onTap,
    );
  }
}
