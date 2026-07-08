import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/network/dtos/media_dtos.dart';
import '../../../../core/network/providers/media_datasource_provider.dart';
import '../../../../core/services/media_upload_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_dropdown_field.dart';
import '../../../../shared/widgets/location_field.dart';
import '../../../pets/domain/entities/pet.dart';
import '../../../pets/presentation/providers/pet_list_provider.dart';
import '../../../pets/presentation/providers/species_provider.dart';
import '../../domain/entities/lost_found_report.dart';
import '../providers/lost_found_providers.dart';

/// Common report page: report one of your own pets as **lost**, or a pet you
/// found as **found**. A segmented toggle swaps between picking your pet (lost)
/// and entering the pet's species/breed manually (found). Shared fields:
/// description, last-seen address, and a map location.
class ReportLostPetPage extends ConsumerStatefulWidget {
  const ReportLostPetPage({super.key});

  @override
  ConsumerState<ReportLostPetPage> createState() => _ReportLostPetPageState();
}

class _ReportLostPetPageState extends ConsumerState<ReportLostPetPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  ReportType _type = ReportType.lost;

  // Lost: selected own-pet id (stable across list refreshes).
  int? _selectedPetId;

  // Found: species drives the breed dropdown.
  int? _foundSpeciesId;

  LatLng? _location;
  bool _locationTouched = false;

  // Found: an optional photo of the found pet. Uploaded on submit as a
  // PetReport MediaAsset, then linked via avatarMediaAssetId.
  File? _photo;
  bool _uploadingPhoto = false;

  // Set once submit is attempted, so the "photo required" error only shows
  // after the user tries to submit (like [_locationTouched]).
  bool _photoTouched = false;

  /// Switches report type and wipes everything type-specific so nothing leaks
  /// across the toggle. The Lost/Found layouts reuse form-field slots (e.g. the
  /// Lost-only reward text field sits where the address field was), so we must
  /// reset the FormBuilder state as well as our own fields.
  void _onTypeChanged(ReportType type) {
    if (type == _type) return;
    setState(() {
      _type = type;
      _selectedPetId = null;
      _foundSpeciesId = null;
      _photo = null;
      _photoTouched = false;
      _location = null;
      _locationTouched = false;
    });
    // Clear all form fields (description, address, reward, found name, etc.)
    // after the layout for the new type has been built.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _formKey.currentState?.reset();
    });
  }

  Future<void> _pickPhoto() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const _PhotoSourceSheet(),
    );
    if (source == null) return;
    final picked =
        await ImagePicker().pickImage(source: source, imageQuality: 90);
    if (picked != null && mounted) {
      setState(() => _photo = File(picked.path));
    }
  }

  Future<void> _submit(List<Pet> pets) async {
    setState(() {
      _locationTouched = true;
      _photoTouched = true;
    });
    final form = _formKey.currentState!;
    final formOk = form.saveAndValidate();
    final location = _location;
    // A photo is mandatory for Found reports (the only way the listing gets an
    // image, since the finder doesn't own the pet).
    final photoMissing = _type == ReportType.found && _photo == null;
    if (!formOk || location == null || photoMissing) return;

    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    final values = form.value;

    late final String petName;
    late final int speciesId;
    final int? breedId;
    // Lost reports link to the owned pet so the backend resolves its avatar.
    int? petId;

    if (_type == ReportType.lost) {
      final pet = pets.where((p) => p.id == _selectedPetId).firstOrNull;
      if (pet == null) return;
      final resolved = await _resolveSpeciesId(pet);
      if (!mounted) return;
      if (resolved == null) {
        context.showErrorSnackBar(l10n.reportSpeciesUnresolved);
        return;
      }
      petName = pet.name;
      speciesId = resolved;
      breedId = pet.breedId;
      petId = pet.id;
    } else {
      petName = (values['foundName'] as String).trim();
      speciesId = values['foundSpecies'] as int;
      breedId = values['foundBreed'] as int?;
    }

    // Reward is Lost-only; parse from the optional text field.
    int? reward;
    if (_type == ReportType.lost) {
      final raw = (values['reward'] as String?)?.trim();
      if (raw != null && raw.isNotEmpty) reward = int.tryParse(raw);
    }

    // Found: upload the (required) photo first so we can attach its confirmed
    // MediaAsset to the listing. A failed upload blocks submit rather than
    // silently dropping it.
    String? avatarMediaAssetId;
    if (_type == ReportType.found && _photo != null) {
      setState(() => _uploadingPhoto = true);
      final uploadService =
          MediaUploadService(ref.read(mediaDatasourceProvider));
      final upload = await uploadService.uploadFile(
        file: _photo!,
        contentType: 'image/jpeg',
        category: MediaCategory.petReport,
        fileName: 'pet_report.jpg',
      );
      if (!mounted) return;
      setState(() => _uploadingPhoto = false);
      final failure = upload.failureOrNull;
      if (failure != null) {
        context.showErrorSnackBar(failure.localizedMessage(l10n));
        return;
      }
      avatarMediaAssetId = upload.valueOrNull?.id;
    }

    final report = await ref.read(createReportProvider.notifier).create(
          type: _type,
          petName: petName,
          speciesId: speciesId,
          breedId: breedId,
          description: (values['description'] as String).trim(),
          lastSeenAddress: (values['address'] as String).trim(),
          latitude: location.latitude,
          longitude: location.longitude,
          petId: petId,
          reward: reward,
          avatarMediaAssetId: avatarMediaAssetId,
        );
    if (!mounted) return;

    if (report == null) {
      final failure = ref.read(createReportProvider.notifier).lastFailure;
      if (failure != null) {
        context.showErrorSnackBar(failure.localizedMessage(l10n));
      }
      return;
    }

    Navigator.of(context).pop();
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.reportCreatedSuccess)));
  }

  /// Resolves a lost pet's speciesId by matching its speciesName against the
  /// species list (trim + case-insensitive). Rethrows load failures.
  Future<int?> _resolveSpeciesId(Pet pet) async {
    final species = await ref.read(speciesListProvider.future);
    final target = pet.speciesName?.trim().toLowerCase();
    if (target == null || target.isEmpty) return null;
    for (final s in species) {
      if (s.name.trim().toLowerCase() == target) return s.id;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isSubmitting = ref.watch(createReportProvider).isLoading;
    final petsAsync = ref.watch(petListProvider);

    final accent = _type == ReportType.lost ? AppColors.error : AppColors.success;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.xl,
                  ),
                  children: [
                    // ── Header: back + centered title + subtitle ─────────
                    _Header(
                      title: l10n.reportTitle,
                      subtitle: l10n.reportHeaderSubtitle,
                      onBack: () => Navigator.of(context).maybePop(),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // ── Lost / Found toggle ──────────────────────────────
                    _TypeToggle(
                      type: _type,
                      lostLabel: l10n.reportTypeLost,
                      foundLabel: l10n.reportTypeFound,
                      onChanged: _onTypeChanged,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Center(
                      child: Text(
                        _type == ReportType.lost
                            ? l10n.reportLostSubtitle
                            : l10n.reportFoundSubtitle,
                        style: AppTextStyles.bodyMedium
                            .copyWith(color: AppColors.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // ── Pet identity: lost = own pet; found = manual ─────
                    if (_type == ReportType.lost)
                      _LostPetPicker(
                        petsAsync: petsAsync,
                        selectedPetId: _selectedPetId,
                        accent: accent,
                        onChanged: (id) =>
                            setState(() => _selectedPetId = id),
                      )
                    else ...[
                      _FoundPetFields(
                        speciesId: _foundSpeciesId,
                        accent: accent,
                        onSpeciesChanged: (id) =>
                            setState(() => _foundSpeciesId = id),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      _FieldLabel(
                        l10n.reportPhoto,
                        icon: FluentIcons.image_24_regular,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _PhotoPicker(
                        photo: _photo,
                        onPick: _pickPhoto,
                        onRemove: () => setState(() => _photo = null),
                      ),
                      if (_photoTouched && _photo == null) ...[
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          l10n.reportPhotoRequired,
                          style: AppTextStyles.bodySmall
                              .copyWith(color: AppColors.error),
                        ),
                      ],
                    ],
                    const SizedBox(height: AppSpacing.lg),

                    // ── Description ──────────────────────────────────────
                    _FieldLabel(
                      l10n.reportDescription,
                      icon: FluentIcons.note_24_regular,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _CardSurface(
                      child: FormBuilderTextField(
                        name: 'description',
                        maxLines: 3,
                        maxLength: 500,
                        textCapitalization: TextCapitalization.sentences,
                        // Keep the "n/500" counter visible for this field.
                        decoration: _borderless(l10n.reportDescriptionHint)
                            .copyWith(counterText: ''),
                        buildCounter: (
                          context, {
                          required currentLength,
                          required isFocused,
                          maxLength,
                        }) =>
                            Text(
                          '$currentLength/$maxLength',
                          style: AppTextStyles.bodySmall
                              .copyWith(color: AppColors.textTertiary),
                        ),
                        validator: FormBuilderValidators.required(
                          errorText: l10n.fieldRequired,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // ── Reward (Lost only) ───────────────────────────────
                    if (_type == ReportType.lost) ...[
                      _FieldLabel(
                        l10n.reportReward,
                        icon: FluentIcons.gift_24_regular,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _CardSurface(
                        child: FormBuilderTextField(
                          name: 'reward',
                          keyboardType: TextInputType.number,
                          decoration: _borderless(l10n.reportRewardHint)
                              .copyWith(
                            prefixIcon: const _RewardPrefix(),
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 0,
                              minHeight: 0,
                            ),
                          ),
                          // Optional; when present must parse to 0–999.
                          validator: (value) {
                            final v = value?.trim();
                            if (v == null || v.isEmpty) return null;
                            final n = int.tryParse(v);
                            if (n == null || n < 0 || n > 999) {
                              return l10n.reportRewardRange;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                        ),
                        child: Text(
                          l10n.reportRewardHelper,
                          style: AppTextStyles.bodySmall
                              .copyWith(color: AppColors.textSecondary),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],

                    // ── Location ─────────────────────────────────────────
                    _FieldLabel(
                      l10n.reportLocation,
                      icon: FluentIcons.location_24_regular,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    LocationField(
                      addressFieldName: 'address',
                      accent: accent,
                      showValidationError: _locationTouched,
                      onLocationChanged: (p) =>
                          setState(() => _location = p),
                    ),
                  ],
                ),
              ),

              // ── Sticky footer CTA ────────────────────────────────────────
              Container(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.lg,
                ),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textPrimary.withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: AppButton(
                    label: l10n.reportSubmit,
                    variant: AppButtonVariant.primary,
                    isLoading: isSubmitting || _uploadingPhoto,
                    onPressed: () => _submit(petsAsync.value ?? const []),
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

/// Borderless input decoration so fields sit flush inside a [_CardSurface].
InputDecoration _borderless(String hint) => InputDecoration(
      hintText: hint,
      // Strip the theme's outlined borders for every state — fields sit flush
      // inside a [_CardSurface], which supplies the surface + shadow.
      filled: false,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      isDense: true,
      // Slightly shorter fields than the default.
      contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      counterText: '',
    );

// ── Lost / Found segmented toggle ─────────────────────────────────────────────

class _TypeToggle extends StatelessWidget {
  const _TypeToggle({
    required this.type,
    required this.lostLabel,
    required this.foundLabel,
    required this.onChanged,
  });

  final ReportType type;
  final String lostLabel;
  final String foundLabel;
  final ValueChanged<ReportType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          _segment(
            lostLabel,
            FluentIcons.animal_paw_print_20_filled,
            ReportType.lost,
            AppColors.error,
          ),
          _segment(
            foundLabel,
            FluentIcons.search_20_regular,
            ReportType.found,
            AppColors.success,
          ),
        ],
      ),
    );
  }

  Widget _segment(String label, IconData icon, ReportType value, Color accent) {
    final selected = type == value;
    final fg = selected ? AppColors.onPrimary : AppColors.textSecondary;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(value),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          decoration: BoxDecoration(
            color: selected ? accent : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: fg),
              const SizedBox(width: AppSpacing.sm),
              Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(
                  color: fg,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Lost: own-pet picker ──────────────────────────────────────────────────────

class _LostPetPicker extends StatelessWidget {
  const _LostPetPicker({
    required this.petsAsync,
    required this.selectedPetId,
    required this.accent,
    required this.onChanged,
  });

  final AsyncValue<List<Pet>> petsAsync;
  final int? selectedPetId;
  final Color accent;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return petsAsync.when(
      loading: () => const _CardSurface(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.sm),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
      ),
      error: (_, _) => _CardSurface(
        child: Text(
          l10n.errorUnknown,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
        ),
      ),
      data: (pets) {
        if (pets.isEmpty) {
          return _CardSurface(
            child: Text(
              l10n.reportNoPets,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
          );
        }
        // Default to the first pet; reset if the selection left the list.
        final effectiveId =
            (selectedPetId != null && pets.any((p) => p.id == selectedPetId))
                ? selectedPetId
                : pets.first.id;
        if (effectiveId != selectedPetId) {
          WidgetsBinding.instance
              .addPostFrameCallback((_) => onChanged(effectiveId));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CardSurface(
              child: AppDropdownField<int>(
                name: 'lostPet',
                label: l10n.reportSelectPet,
                hint: l10n.reportSelectPetHint,
                initialValue: effectiveId,
                items: [
                  for (final p in pets)
                    DropdownMenuItem(
                      value: p.id,
                      child: Text('${p.name} · ${p.breedOrSpecies}'),
                    ),
                ],
                // Show each pet's avatar before its name (sheet + collapsed).
                leadingBuilder: (id) {
                  final pet = pets.where((p) => p.id == id).firstOrNull;
                  if (pet == null) return null;
                  return AppAvatar(
                    name: pet.name,
                    imageUrl: pet.avatarUrl,
                    radius: 16,
                  );
                },
                onChanged: onChanged,
              ),
            ),
          ],
        );
      },
    );
  }
}


// ── Found: manual species / name / breed ──────────────────────────────────────

class _FoundPetFields extends ConsumerWidget {
  const _FoundPetFields({
    required this.speciesId,
    required this.accent,
    required this.onSpeciesChanged,
  });

  final int? speciesId;
  final Color accent;
  final ValueChanged<int?> onSpeciesChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final speciesAsync = ref.watch(speciesListProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pet name.
        _FieldLabel(
          l10n.reportFoundName,
          icon: FluentIcons.animal_paw_print_24_regular,
        ),
        const SizedBox(height: AppSpacing.sm),
        _CardSurface(
          child: FormBuilderTextField(
            name: 'foundName',
            textCapitalization: TextCapitalization.words,
            decoration: _borderless(l10n.reportFoundNameHint),
            validator: FormBuilderValidators.required(
              errorText: l10n.fieldRequired,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Species.
        _CardSurface(
          child: speciesAsync.when(
            loading: () => _InlineLoading(label: l10n.reportFoundSpecies),
            error: (_, _) => _InlineError(
              label: l10n.reportFoundSpecies,
              error: l10n.errorUnknown,
            ),
            data: (species) => AppDropdownField<int>(
              name: 'foundSpecies',
              label: l10n.reportFoundSpecies,
              validator: FormBuilderValidators.required(
                errorText: l10n.fieldRequired,
              ),
              items: [
                for (final s in species)
                  DropdownMenuItem(value: s.id, child: Text(s.name)),
              ],
              onChanged: onSpeciesChanged,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Breed (cascades off species; optional).
        _FoundBreedField(speciesId: speciesId),
      ],
    );
  }
}

class _FoundBreedField extends ConsumerWidget {
  const _FoundBreedField({required this.speciesId});

  final int? speciesId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    if (speciesId == null) {
      return _CardSurface(
        child: AppDropdownField<int>(
          name: 'foundBreed',
          label: l10n.reportFoundBreed,
          hint: l10n.reportFoundSelectSpeciesFirst,
          enabled: false,
          items: const [],
        ),
      );
    }

    final breedsAsync = ref.watch(breedsListProvider(speciesId!));
    return breedsAsync.when(
      loading: () =>
          _CardSurface(child: _InlineLoading(label: l10n.reportFoundBreed)),
      error: (_, _) => _CardSurface(
        child: _InlineError(
          label: l10n.reportFoundBreed,
          error: l10n.errorUnknown,
        ),
      ),
      data: (breeds) {
        if (breeds.isEmpty) return const SizedBox.shrink();
        return _CardSurface(
          child: AppDropdownField<int>(
            name: 'foundBreed',
            label: l10n.reportFoundBreed,
            items: [
              for (final b in breeds)
                DropdownMenuItem(value: b.id, child: Text(b.name)),
            ],
          ),
        );
      },
    );
  }
}

class _InlineLoading extends StatelessWidget {
  const _InlineLoading({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.xs),
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ],
      );
}

class _InlineError extends StatelessWidget {
  const _InlineError({required this.label, required this.error});
  final String label;
  final String error;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.xs),
          Text(error,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.error)),
        ],
      );
}

// ── Header ────────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.subtitle,
    required this.onBack,
  });

  final String title;
  final String subtitle;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Centered title + subtitle.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.xs),
              Text(
                title,
                style: AppTextStyles.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle,
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        // Floating back button, pinned to the leading edge.
        PositionedDirectional(
          start: 0,
          top: 0,
          child: Material(
            color: AppColors.surface,
            borderRadius: AppRadius.smAll,
            elevation: 1,
            shadowColor: AppColors.textPrimary.withValues(alpha: 0.15),
            child: InkWell(
              onTap: onBack,
              borderRadius: AppRadius.smAll,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Icon(
                  context.isRtl
                      ? FluentIcons.chevron_right_24_regular
                      : FluentIcons.chevron_left_24_regular,
                  color: AppColors.textPrimary,
                  size: 22,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Shared bits ───────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label, {required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            // Icon chips are always the brand orange, regardless of report type.
            color: AppColors.primary.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary, size: 16),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(label, style: AppTextStyles.titleSmall),
      ],
    );
  }
}

/// The `$` prefix shown inside the reward field.
class _RewardPrefix extends StatelessWidget {
  const _RewardPrefix();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
        child: Text(
          r'$',
          style: AppTextStyles.titleMedium
              .copyWith(color: AppColors.textSecondary),
        ),
      );
}

// ── Found: photo picker ───────────────────────────────────────────────────────

class _PhotoPicker extends StatelessWidget {
  const _PhotoPicker({
    required this.photo,
    required this.onPick,
    required this.onRemove,
  });

  final File? photo;
  final VoidCallback onPick;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (photo != null) {
      return ClipRRect(
        borderRadius: AppRadius.lgAll,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.file(photo!, fit: BoxFit.cover),
            ),
            PositionedDirectional(
              top: AppSpacing.sm,
              end: AppSpacing.sm,
              child: Material(
                color: AppColors.surface,
                shape: const CircleBorder(),
                elevation: 2,
                child: IconButton(
                  onPressed: onRemove,
                  tooltip: l10n.reportPhotoRemove,
                  icon: const Icon(
                    FluentIcons.dismiss_24_regular,
                    size: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: onPick,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.lgAll,
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              FluentIcons.camera_add_24_regular,
              color: AppColors.primary,
              size: 32,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.reportPhotoHint,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

/// Camera / Gallery chooser, returning the picked [ImageSource].
class _PhotoSourceSheet extends StatelessWidget {
  const _PhotoSourceSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: _SourceButton(
                icon: FluentIcons.camera_24_regular,
                label: l10n.camera,
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: _SourceButton(
                icon: FluentIcons.image_24_regular,
                label: l10n.gallery,
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SourceButton extends StatelessWidget {
  const _SourceButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.mdAll,
          border: Border.all(color: AppColors.primary, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primary, size: 32),
            const SizedBox(height: AppSpacing.sm),
            Text(
              label,
              style:
                  AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardSurface extends StatelessWidget {
  const _CardSurface({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}
