import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_dropdown_field.dart';
import '../../../pets/domain/entities/pet.dart';
import '../../../pets/presentation/providers/pet_list_provider.dart';
import '../providers/adoption_providers.dart';
import '../widgets/shelter_listing_form.dart';

/// Lister-side create flow: put one of your own pets up for adoption.
///
/// The pet supplies species/breed/avatar/DOB (rehome-only v1), so the form only
/// collects a description, a pickup location, and a few trait flags. On success
/// it pops and the board refreshes.
class ListPetForAdoptionPage extends ConsumerStatefulWidget {
  const ListPetForAdoptionPage({super.key});

  @override
  ConsumerState<ListPetForAdoptionPage> createState() =>
      _ListPetForAdoptionPageState();
}

class _ListPetForAdoptionPageState
    extends ConsumerState<ListPetForAdoptionPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _shelterFormKey = GlobalKey<FormBuilderState>();
  final _shelterFormStateKey = GlobalKey<ShelterListingFormState>();

  /// The active create mode. Rehome (own pet) vs. shelter/stray (no pet).
  bool _shelterMode = false;

  int? _selectedPetId;

  bool _vaccinated = false;
  bool _neutered = false;
  bool _goodWithKids = false;

  /// Shared success handling: pop and toast. [listing] null means the create
  /// failed — surface the notifier's failure instead.
  void _onCreateResult(Object? listing) {
    final l10n = context.l10n;
    if (listing == null) {
      final failure =
          ref.read(createAdoptionListingProvider.notifier).lastFailure;
      context.showErrorSnackBar(
        failure?.localizedMessage(l10n) ?? l10n.errorUnknown,
      );
      return;
    }
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.adoptionListingCreated)));
  }

  Future<void> _submitRehome(List<Pet> pets) async {
    final form = _formKey.currentState!;
    final formOk = form.saveAndValidate();
    final pet = pets.where((p) => p.id == _selectedPetId).firstOrNull;
    if (!formOk || pet == null) return;

    final description = (form.value['description'] as String?)?.trim();

    final listing =
        await ref.read(createAdoptionListingProvider.notifier).create(
              petId: pet.id,
              description:
                  description == null || description.isEmpty ? null : description,
              vaccinated: _vaccinated,
              neutered: _neutered,
              goodWithKids: _goodWithKids,
            );
    if (!mounted) return;
    _onCreateResult(listing);
  }

  Future<void> _submitShelter() async {
    final data = _shelterFormStateKey.currentState?.readData();
    // Null means required fields are missing or the photo is still uploading;
    // the form has already surfaced the validation errors.
    if (data == null) return;

    final description =
        (_shelterFormKey.currentState?.value['description'] as String?)?.trim();

    final listing =
        await ref.read(createAdoptionListingProvider.notifier).createShelter(
              petName: data.petName,
              speciesId: data.speciesId,
              gender: data.gender,
              breedId: data.breedId,
              dateOfBirth: data.dateOfBirth,
              sizeId: data.sizeId,
              coatColorId: data.coatColorId,
              photoAssetId: data.photoAssetId,
              description:
                  description == null || description.isEmpty ? null : description,
              vaccinated: _vaccinated,
              neutered: _neutered,
              goodWithKids: _goodWithKids,
            );
    if (!mounted) return;
    _onCreateResult(listing);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isSubmitting = ref.watch(createAdoptionListingProvider).isLoading;
    final petsAsync = ref.watch(petListProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
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
                  _Header(
                    title: l10n.adoptionListTitle,
                    subtitle: l10n.adoptionListSubtitle,
                    onBack: () => Navigator.of(context).maybePop(),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // ── Mode toggle ──────────────────────────────────────
                  _ModeToggle(
                    shelterMode: _shelterMode,
                    onChanged: (v) => setState(() => _shelterMode = v),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // ── Mode-specific fields (each in its own FormBuilder) ─
                  if (_shelterMode)
                    FormBuilder(
                      key: _shelterFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _FieldLabel(
                            l10n.adoptionShelterAnimalDetails,
                            icon: FluentIcons.animal_paw_print_24_regular,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          ShelterListingForm(
                            key: _shelterFormStateKey,
                            formKey: _shelterFormKey,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          _DescriptionField(l10n: l10n),
                        ],
                      ),
                    )
                  else
                    FormBuilder(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _FieldLabel(
                            l10n.adoptionListWhichPet,
                            icon: FluentIcons.animal_paw_print_24_regular,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          _PetPicker(
                            petsAsync: petsAsync,
                            selectedPetId: _selectedPetId,
                            onChanged: (id) =>
                                setState(() => _selectedPetId = id),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          _DescriptionField(l10n: l10n),
                        ],
                      ),
                    ),
                  const SizedBox(height: AppSpacing.lg),

                  // ── Traits ───────────────────────────────────────────
                  _FieldLabel(
                    l10n.adoptionListTraits,
                    icon: FluentIcons.checkmark_circle_24_regular,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _CardSurface(
                    child: Column(
                      children: [
                        _TraitSwitch(
                          label: l10n.adoptionTraitVaccinated,
                          value: _vaccinated,
                          onChanged: (v) => setState(() => _vaccinated = v),
                        ),
                        const Divider(height: 1, color: AppColors.divider),
                        _TraitSwitch(
                          label: l10n.adoptionTraitNeutered,
                          value: _neutered,
                          onChanged: (v) => setState(() => _neutered = v),
                        ),
                        const Divider(height: 1, color: AppColors.divider),
                        _TraitSwitch(
                          label: l10n.adoptionTraitGoodWithKids,
                          value: _goodWithKids,
                          onChanged: (v) => setState(() => _goodWithKids = v),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // ── Transfer expectation note ────────────────────────
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.secondarySoft,
                      borderRadius: AppRadius.mdAll,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(FluentIcons.info_24_regular,
                            size: 18, color: AppColors.secondaryDark),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            _shelterMode
                                ? l10n.adoptionShelterTransferNote
                                : l10n.adoptionListTransferNote,
                            style: AppTextStyles.bodySmall
                                .copyWith(color: AppColors.secondaryDark),
                          ),
                        ),
                      ],
                    ),
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
                  label: l10n.adoptionListSubmit,
                  variant: AppButtonVariant.primary,
                  isLoading: isSubmitting ||
                      (_shelterFormStateKey.currentState?.isUploadingPhoto ??
                          false),
                  onPressed: () => _shelterMode
                      ? _submitShelter()
                      : _submitRehome(petsAsync.value ?? const []),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Borderless input decoration so fields sit flush inside a [_CardSurface].
InputDecoration _borderless(String hint) => InputDecoration(
      hintText: hint,
      filled: false,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      counterText: '',
    );

// ── Mode toggle ─────────────────────────────────────────────────────────────

/// Segmented control choosing between rehoming an owned pet and listing a
/// shelter/stray animal (no pet record).
class _ModeToggle extends StatelessWidget {
  const _ModeToggle({required this.shelterMode, required this.onChanged});

  final bool shelterMode;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          _Segment(
            label: l10n.adoptionModeMyPet,
            selected: !shelterMode,
            onTap: () => onChanged(false),
          ),
          _Segment(
            label: l10n.adoptionModeShelter,
            selected: shelterMode,
            onTap: () => onChanged(true),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: selected ? AppColors.onPrimary : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Shared description field ──────────────────────────────────────────────────

/// The listing description field, identical in both modes. Lives inside the
/// mode's FormBuilder so its value is read from that form.
class _DescriptionField extends StatelessWidget {
  const _DescriptionField({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _FieldLabel(
          l10n.adoptionAboutTitle,
          icon: FluentIcons.note_24_regular,
        ),
        const SizedBox(height: AppSpacing.sm),
        _CardSurface(
          child: FormBuilderTextField(
            name: 'description',
            maxLines: 4,
            maxLength: 500,
            textCapitalization: TextCapitalization.sentences,
            decoration: _borderless(l10n.adoptionListDescriptionHint)
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
          ),
        ),
      ],
    );
  }
}

// ── Own-pet picker ────────────────────────────────────────────────────────────

class _PetPicker extends StatelessWidget {
  const _PetPicker({
    required this.petsAsync,
    required this.selectedPetId,
    required this.onChanged,
  });

  final AsyncValue<List<Pet>> petsAsync;
  final int? selectedPetId;
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
              l10n.adoptionListNoPets,
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

        return _CardSurface(
          child: AppDropdownField<int>(
            name: 'listPet',
            label: l10n.adoptionListSelectPet,
            hint: l10n.adoptionListSelectPetHint,
            initialValue: effectiveId,
            items: [
              for (final p in pets)
                DropdownMenuItem(
                  value: p.id,
                  child: Text('${p.name} · ${p.breedOrSpecies}'),
                ),
            ],
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
        );
      },
    );
  }
}

// ── Trait switch row ──────────────────────────────────────────────────────────

class _TraitSwitch extends StatelessWidget {
  const _TraitSwitch({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: AppTextStyles.bodyMedium)),
        Switch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: AppColors.primary,
        ),
      ],
    );
  }
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
