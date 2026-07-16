import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/network/dtos/media_dtos.dart';
import '../../../../core/network/providers/media_datasource_provider.dart';
import '../../../../core/services/media_upload_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_dropdown_field.dart';
import '../../../pets/presentation/providers/species_provider.dart';

/// The details a shelter/stray listing collects for the animal, plus the
/// confirmed photo asset id (null when the lister skipped the photo).
class ShelterFormData {
  const ShelterFormData({
    required this.petName,
    required this.speciesId,
    required this.gender,
    this.breedId,
    this.dateOfBirth,
    this.sizeId,
    this.coatColorId,
    this.photoAssetId,
  });

  final String petName;
  final int speciesId;
  final String gender;
  final int? breedId;
  final DateTime? dateOfBirth;
  final int? sizeId;
  final int? coatColorId;
  final String? photoAssetId;
}

/// The animal-details form for a shelter/stray adoption listing. Unlike the
/// rehome path (which derives everything from an owned pet), this collects the
/// pet's identity inline: photo, name, species → breed, gender, DOB, size,
/// coat color. Reuses the shared /species and /pet-attributes lookups.
///
/// Owns the photo upload: the picked image is uploaded to the
/// AdoptionListingPhoto media bucket up front, and the confirmed assetId is
/// handed back through [ShelterFormData] on submit.
class ShelterListingForm extends ConsumerStatefulWidget {
  const ShelterListingForm({required this.formKey, super.key});

  /// The parent form key, so the host page can trigger validation on submit.
  final GlobalKey<FormBuilderState> formKey;

  @override
  ConsumerState<ShelterListingForm> createState() => ShelterListingFormState();
}

class ShelterListingFormState extends ConsumerState<ShelterListingForm> {
  int? _speciesId;

  File? _photoFile;
  String? _photoAssetId;
  bool _uploadingPhoto = false;

  /// Whether a photo upload is currently in flight (host disables submit).
  bool get isUploadingPhoto => _uploadingPhoto;

  /// Reads the validated form into a [ShelterFormData], or null when required
  /// fields are missing / a photo was picked but hasn't finished uploading.
  ShelterFormData? readData() {
    final form = widget.formKey.currentState!;
    if (!form.saveAndValidate()) return null;
    // A picked-but-unconfirmed photo means the upload failed or is pending —
    // don't submit a listing that silently drops the photo.
    if (_photoFile != null && _photoAssetId == null) return null;

    final values = form.value;
    final name = (values['petName'] as String).trim();
    return ShelterFormData(
      petName: name,
      speciesId: values['speciesId'] as int,
      gender: values['gender'] as String,
      breedId: values['breedId'] as int?,
      dateOfBirth: values['dateOfBirth'] as DateTime?,
      sizeId: _nullIfZero(values['sizeId'] as int?),
      coatColorId: _nullIfZero(values['coatColorId'] as int?),
      photoAssetId: _photoAssetId,
    );
  }

  int? _nullIfZero(int? v) => (v == null || v == 0) ? null : v;

  Future<void> _pickPhoto() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const _PhotoSourceSheet(),
    );
    if (source == null) return;

    final picked =
        await ImagePicker().pickImage(source: source, imageQuality: 90);
    if (picked == null || !mounted) return;

    setState(() {
      _photoFile = File(picked.path);
      _photoAssetId = null;
      _uploadingPhoto = true;
    });

    final service = MediaUploadService(ref.read(mediaDatasourceProvider));
    final result = await service.uploadFile(
      file: File(picked.path),
      contentType: 'image/jpeg',
      category: MediaCategory.adoptionListingPhoto,
      fileName: 'adoption_listing.jpg',
    );
    if (!mounted) return;

    result.when(
      success: (asset) => setState(() {
        _photoAssetId = asset.id;
        _uploadingPhoto = false;
      }),
      failure: (f) {
        setState(() {
          _photoFile = null;
          _uploadingPhoto = false;
        });
        context.showErrorSnackBar(f.localizedMessage(context.l10n));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final speciesAsync = ref.watch(speciesListProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Photo ────────────────────────────────────────────────────────
        Center(
          child: _PhotoPicker(
            file: _photoFile,
            uploading: _uploadingPhoto,
            onTap: _uploadingPhoto ? null : _pickPhoto,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Name ─────────────────────────────────────────────────────────
        _Card(
          child: FormBuilderTextField(
            name: 'petName',
            textCapitalization: TextCapitalization.words,
            decoration: _input(l10n.adoptionShelterName),
            validator: FormBuilderValidators.required(
              errorText: l10n.fieldRequired,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // ── Species ──────────────────────────────────────────────────────
        speciesAsync.when(
          loading: () => const _Card(
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
          error: (e, _) => _Card(
            child: Text(
              asFailure(e).localizedMessage(l10n),
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
            ),
          ),
          data: (species) => _Card(
            child: AppDropdownField<int>(
              name: 'speciesId',
              label: l10n.createPetSpecies,
              validator: FormBuilderValidators.required(
                errorText: l10n.fieldRequired,
              ),
              items: [
                for (final s in species)
                  DropdownMenuItem(value: s.id, child: Text(s.name)),
              ],
              onChanged: (v) => setState(() => _speciesId = v),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // ── Breed (cascades off species) ─────────────────────────────────
        _BreedCard(speciesId: _speciesId),
        const SizedBox(height: AppSpacing.md),

        // ── Gender ───────────────────────────────────────────────────────
        _Card(
          child: AppDropdownField<String>(
            name: 'gender',
            label: l10n.createPetGender,
            searchable: false,
            validator: FormBuilderValidators.required(
              errorText: l10n.fieldRequired,
            ),
            items: [
              DropdownMenuItem(value: 'Male', child: Text(l10n.genderMale)),
              DropdownMenuItem(value: 'Female', child: Text(l10n.genderFemale)),
              DropdownMenuItem(
                  value: 'Unknown', child: Text(l10n.genderUnknown)),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // ── Date of birth (optional) ─────────────────────────────────────
        _Card(
          child: FormBuilderDateTimePicker(
            name: 'dateOfBirth',
            inputType: InputType.date,
            lastDate: DateTime.now(),
            format: DateFormat.yMMMMd(locale),
            decoration: _input(l10n.createPetDateOfBirth).copyWith(
              suffixIcon: const Icon(
                FluentIcons.calendar_24_regular,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // ── Size (optional) ──────────────────────────────────────────────
        _SizeCard(),
        const SizedBox(height: AppSpacing.md),

        // ── Coat color (optional) ────────────────────────────────────────
        _CoatColorCard(),
      ],
    );
  }
}

InputDecoration _input(String label) => InputDecoration(
      labelText: label,
      labelStyle:
          AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      isDense: true,
      contentPadding: EdgeInsets.zero,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
    );

// ── Breed / size / coat cascading cards ─────────────────────────────────────

class _BreedCard extends ConsumerStatefulWidget {
  const _BreedCard({required this.speciesId});

  final int? speciesId;

  @override
  ConsumerState<_BreedCard> createState() => _BreedCardState();
}

class _BreedCardState extends ConsumerState<_BreedCard> {
  int? _lastSpeciesId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (widget.speciesId == null) {
      _lastSpeciesId = null;
      return _Card(
        child: AppDropdownField<int>(
          name: 'breedId',
          label: l10n.createPetBreed,
          hint: l10n.createPetSelectSpeciesFirst,
          enabled: false,
          items: const [],
        ),
      );
    }

    final breedsAsync = ref.watch(breedsListProvider(widget.speciesId!));
    return breedsAsync.when(
      loading: () => _Card(
        child: _MiniLabel(label: l10n.createPetBreed, loading: true),
      ),
      error: (e, _) => _Card(
        child: _MiniLabel(
          label: l10n.createPetBreed,
          error: asFailure(e).localizedMessage(l10n),
        ),
      ),
      data: (breeds) {
        if (breeds.isEmpty) {
          _lastSpeciesId = widget.speciesId;
          return const SizedBox.shrink();
        }
        if (widget.speciesId != _lastSpeciesId) {
          _lastSpeciesId = widget.speciesId;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            FormBuilder.of(context)?.fields['breedId']?.didChange(null);
          });
        }
        return _Card(
          child: AppDropdownField<int>(
            name: 'breedId',
            label: l10n.createPetBreed,
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

class _SizeCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final sizesAsync = ref.watch(petSizesListProvider);
    return sizesAsync.when(
      loading: () => _Card(
        child: _MiniLabel(label: l10n.createPetSize, loading: true),
      ),
      error: (e, _) => _Card(
        child: _MiniLabel(
          label: l10n.createPetSize,
          error: asFailure(e).localizedMessage(l10n),
        ),
      ),
      data: (sizes) => _Card(
        child: AppDropdownField<int>(
          name: 'sizeId',
          label: l10n.createPetSize,
          searchable: false,
          items: [
            DropdownMenuItem(value: 0, child: Text(l10n.createPetNotSpecified)),
            for (final s in sizes)
              DropdownMenuItem(value: s.id, child: Text(s.displayName)),
          ],
        ),
      ),
    );
  }
}

class _CoatColorCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final colorsAsync = ref.watch(coatColorsListProvider);
    return colorsAsync.when(
      loading: () => _Card(
        child: _MiniLabel(label: l10n.createPetCoatColor, loading: true),
      ),
      error: (e, _) => _Card(
        child: _MiniLabel(
          label: l10n.createPetCoatColor,
          error: asFailure(e).localizedMessage(l10n),
        ),
      ),
      data: (colors) => _Card(
        child: AppDropdownField<int>(
          name: 'coatColorId',
          label: l10n.createPetCoatColor,
          items: [
            DropdownMenuItem(value: 0, child: Text(l10n.createPetNotSpecified)),
            for (final c in colors)
              DropdownMenuItem(value: c.id, child: Text(c.displayName)),
          ],
        ),
      ),
    );
  }
}

// ── Photo picker ────────────────────────────────────────────────────────────

class _PhotoPicker extends StatelessWidget {
  const _PhotoPicker({
    required this.file,
    required this.uploading,
    required this.onTap,
  });

  final File? file;
  final bool uploading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: AppColors.primarySoft,
          shape: BoxShape.circle,
          image: file != null
              ? DecorationImage(image: FileImage(file!), fit: BoxFit.cover)
              : null,
        ),
        alignment: Alignment.center,
        child: uploading
            ? const SizedBox(
                width: 26,
                height: 26,
                child: CircularProgressIndicator(strokeWidth: 2.5),
              )
            : file == null
                ? const Icon(
                    FluentIcons.camera_add_24_regular,
                    size: 36,
                    color: AppColors.primary,
                  )
                : const Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: AppColors.primary,
                        child: Icon(FluentIcons.camera_24_filled,
                            size: 14, color: AppColors.onPrimary),
                      ),
                    ),
                  ),
      ),
    );
  }
}

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

// ── Shared bits ─────────────────────────────────────────────────────────────

class _Card extends StatelessWidget {
  const _Card({required this.child});

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

/// A small labelled placeholder for a picker that's still loading or errored.
class _MiniLabel extends StatelessWidget {
  const _MiniLabel({required this.label, this.loading = false, this.error});

  final String label;
  final bool loading;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label,
            style: AppTextStyles.bodySmall
                .copyWith(color: AppColors.textSecondary)),
        const SizedBox(height: AppSpacing.xs),
        if (loading)
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        else if (error != null)
          Text(error!,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.error)),
      ],
    );
  }
}
