import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_dropdown_field.dart';
import '../../../../shared/widgets/app_snack_bar.dart';
import '../../domain/entities/new_pet.dart';
import '../../domain/entities/pet.dart';
import '../../domain/entities/species.dart';
import '../providers/pet_detail_provider.dart';
import '../providers/pet_list_provider.dart';
import '../providers/species_provider.dart';
import '../providers/update_pet_provider.dart';

class EditPetPage extends ConsumerStatefulWidget {
  const EditPetPage({required this.petId, super.key});

  final int petId;

  @override
  ConsumerState<EditPetPage> createState() => _EditPetPageState();
}

class _EditPetPageState extends ConsumerState<EditPetPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  int? _speciesId;

  Future<void> _submit(Pet pet) async {
    final form = _formKey.currentState!;
    if (!form.saveAndValidate()) return;
    final values = form.value;

    String? trimOrNull(String key) {
      final v = (values[key] as String?)?.trim();
      return (v != null && v.isNotEmpty) ? v : null;
    }

    final sterilizationStatus = values['sterilizationStatus'] as String?;

    final updated = NewPet(
      name: (values['name'] as String).trim(),
      breedId: values['breedId'] as int,
      dateOfBirth: values['dateOfBirth'] as DateTime,
      gender: values['gender'] as String,
      pelage: trimOrNull('pelage'),
      microchipNumber: trimOrNull('microchipNumber'),
      microchipLocation: trimOrNull('microchipLocation'),
      sterilizationStatus: sterilizationStatus,
      sterilizationDate:
          sterilizationStatus == 'Intact' || sterilizationStatus == null
              ? null
              : values['sterilizationDate'] as DateTime?,
    );

    final notifier = ref.read(updatePetProvider.notifier);
    final result = await notifier.update(widget.petId, updated);
    if (!mounted) return;

    if (result != null) {
      ref.invalidate(petDetailProvider(widget.petId));
      ref.invalidate(petListProvider);

      final messenger = ScaffoldMessenger.of(context);
      final message = context.l10n.petUpdatedSuccess;
      context.pop();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.buildSuccess(message));
    } else {
      final failure = notifier.lastFailure;
      if (failure != null) {
        context.showErrorSnackBar(failure.localizedMessage(context.l10n));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final speciesAsync = ref.watch(speciesListProvider);
    final isSubmitting = ref.watch(updatePetProvider).isLoading;

    final pet = ref.watch(petDetailProvider(widget.petId)).value ??
        ref
            .watch(petListProvider)
            .value
            ?.where((p) => p.id == widget.petId)
            .firstOrNull;

    if (pet == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Seed speciesId by matching pet's speciesName against the loaded list.
    if (_speciesId == null && speciesAsync.value != null) {
      final match =
          speciesAsync.value!.where((s) => s.name == pet.speciesName).firstOrNull;
      if (match != null) _speciesId = match.id;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(title: l10n.editPetTitle),
            Expanded(
              child: speciesAsync.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => _SpeciesError(
                  message: asFailure(e).localizedMessage(l10n),
                  onRetry: () => ref.invalidate(speciesListProvider),
                ),
                data: (species) => _Form(
                  formKey: _formKey,
                  pet: pet,
                  species: species,
                  speciesId: _speciesId,
                  isSubmitting: isSubmitting,
                  onSpeciesChanged: (value) {
                    setState(() => _speciesId = value);
                    _formKey.currentState?.fields['breedId']?.didChange(null);
                  },
                  onSubmit: () => _submit(pet),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  const _Header({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final isRtl = context.isRtl;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 52),
            child: Text(title, style: AppTextStyles.headlineLarge),
          ),
          PositionedDirectional(
            start: 0,
            top: 0,
            bottom: 0,
            child: Center(child: _FloatingBackButton(isRtl: isRtl)),
          ),
        ],
      ),
    );
  }
}

class _FloatingBackButton extends StatelessWidget {
  const _FloatingBackButton({required this.isRtl});

  final bool isRtl;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: AppRadius.mdAll,
      elevation: 0,
      child: InkWell(
        borderRadius: AppRadius.mdAll,
        onTap: () => context.canPop() ? context.pop() : null,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: AppRadius.mdAll,
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            isRtl
                ? FluentIcons.chevron_right_24_regular
                : FluentIcons.chevron_left_24_regular,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

// ── Form ──────────────────────────────────────────────────────────────────────

class _Form extends StatefulWidget {
  const _Form({
    required this.formKey,
    required this.pet,
    required this.species,
    required this.speciesId,
    required this.isSubmitting,
    required this.onSpeciesChanged,
    required this.onSubmit,
  });

  final GlobalKey<FormBuilderState> formKey;
  final Pet pet;
  final List<Species> species;
  final int? speciesId;
  final bool isSubmitting;
  final ValueChanged<int?> onSpeciesChanged;
  final VoidCallback onSubmit;

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  late String? _sterilizationStatus = widget.pet.sterilizationStatus;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final showSterilizationDate =
        _sterilizationStatus != null && _sterilizationStatus != 'Intact';

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      child: FormBuilder(
        key: widget.formKey,
        initialValue: {
          'name': widget.pet.name,
          'speciesId': widget.speciesId,
          'breedId': widget.pet.breedId,
          'dateOfBirth': widget.pet.dateOfBirth,
          'gender': widget.pet.gender,
          'pelage': widget.pet.pelage,
          'microchipNumber': widget.pet.microchipNumber,
          'microchipLocation': widget.pet.microchipLocation,
          'sterilizationStatus': widget.pet.sterilizationStatus,
          'sterilizationDate': widget.pet.sterilizationDate,
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _HeroAvatar(),
            const SizedBox(height: AppSpacing.md),

            // Pet name.
            _FieldCard(
              icon: FluentIcons.animal_dog_24_regular,
              child: FormBuilderTextField(
                name: 'name',
                textCapitalization: TextCapitalization.words,
                style: AppTextStyles.titleMedium,
                decoration: _cardInput(label: l10n.createPetName),
                validator: FormBuilderValidators.required(
                    errorText: l10n.fieldRequired),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Animal type (species).
            _FieldCard(
              icon: FluentIcons.animal_paw_print_24_regular,
              child: AppDropdownField<int>(
                name: 'speciesId',
                label: l10n.createPetSpecies,
                validator: FormBuilderValidators.required(
                    errorText: l10n.fieldRequired),
                items: [
                  for (final s in widget.species)
                    DropdownMenuItem(value: s.id, child: Text(s.name)),
                ],
                onChanged: widget.onSpeciesChanged,
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Breed.
            _BreedCard(speciesId: widget.speciesId),
            const SizedBox(height: AppSpacing.md),

            // Date of birth.
            _FieldCard(
              icon: FluentIcons.calendar_24_regular,
              child: FormBuilderDateTimePicker(
                name: 'dateOfBirth',
                inputType: InputType.date,
                lastDate: DateTime.now(),
                format: DateFormat.yMMMMd(locale),
                style: AppTextStyles.titleMedium,
                decoration: _cardInput(
                  label: l10n.createPetDateOfBirth,
                  suffixIcon: const Icon(FluentIcons.calendar_24_regular,
                      color: AppColors.textSecondary),
                ),
                validator: FormBuilderValidators.required(
                    errorText: l10n.fieldRequired),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Gender.
            const _GenderCard(),
            const SizedBox(height: AppSpacing.xl),

            // ── Optional section ─────────────────────────────────────────
            _SectionDivider(label: l10n.createPetAdditionalInfo),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.createPetAdditionalInfoSubtitle,
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textTertiary),
            ),
            const SizedBox(height: AppSpacing.md),

            // Pelage.
            _FieldCard(
              icon: FluentIcons.color_24_regular,
              child: FormBuilderTextField(
                name: 'pelage',
                textCapitalization: TextCapitalization.sentences,
                style: AppTextStyles.titleMedium,
                decoration: _cardInput(label: l10n.createPetPelage),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Microchip number.
            _FieldCard(
              icon: FluentIcons.communication_24_regular,
              child: FormBuilderTextField(
                name: 'microchipNumber',
                keyboardType: TextInputType.number,
                style: AppTextStyles.titleMedium,
                decoration:
                    _cardInput(label: l10n.createPetMicrochipNumber),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Microchip location.
            _FieldCard(
              icon: FluentIcons.location_24_regular,
              child: FormBuilderTextField(
                name: 'microchipLocation',
                textCapitalization: TextCapitalization.sentences,
                style: AppTextStyles.titleMedium,
                decoration:
                    _cardInput(label: l10n.createPetMicrochipLocation),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Sterilization status.
            _FieldCard(
              icon: FluentIcons.heart_pulse_24_regular,
              child: AppDropdownField<String>(
                name: 'sterilizationStatus',
                label: l10n.createPetSterilizationStatus,
                items: [
                  DropdownMenuItem(
                      value: 'Intact',
                      child: Text(l10n.sterilizationStatusIntact)),
                  DropdownMenuItem(
                      value: 'Neutered',
                      child: Text(l10n.sterilizationStatusNeutered)),
                  DropdownMenuItem(
                      value: 'Spayed',
                      child: Text(l10n.sterilizationStatusSpayed)),
                  DropdownMenuItem(
                      value: 'Unknown',
                      child: Text(l10n.sterilizationStatusUnknown)),
                ],
                onChanged: (v) => setState(() => _sterilizationStatus = v),
              ),
            ),

            if (showSterilizationDate) ...[
              const SizedBox(height: AppSpacing.md),
              _FieldCard(
                icon: FluentIcons.calendar_checkmark_24_regular,
                child: FormBuilderDateTimePicker(
                  name: 'sterilizationDate',
                  inputType: InputType.date,
                  lastDate: DateTime.now(),
                  format: DateFormat.yMMMMd(locale),
                  style: AppTextStyles.titleMedium,
                  decoration: _cardInput(
                    label: l10n.createPetSterilizationDate,
                    suffixIcon: const Icon(FluentIcons.calendar_24_regular,
                        color: AppColors.textSecondary),
                  ),
                ),
              ),
            ],

            const SizedBox(height: AppSpacing.xl),

            AppButton(
              label: l10n.editPetSave,
              icon: FluentIcons.checkmark_24_regular,
              variant: AppButtonVariant.primary,
              isLoading: widget.isSubmitting,
              onPressed: widget.onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Shared input decoration ───────────────────────────────────────────────────

InputDecoration _cardInput({required String label, Widget? suffixIcon}) =>
    InputDecoration(
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
      suffixIcon: suffixIcon,
      suffixIconConstraints: const BoxConstraints(minWidth: 24, minHeight: 24),
    );

// ── Section divider ───────────────────────────────────────────────────────────

class _SectionDivider extends StatelessWidget {
  const _SectionDivider({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
            child: Divider(color: AppColors.divider, thickness: 1)),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text(
            label,
            style: AppTextStyles.labelMedium
                .copyWith(color: AppColors.textSecondary),
          ),
        ),
        const Expanded(
            child: Divider(color: AppColors.divider, thickness: 1)),
      ],
    );
  }
}

// ── Hero avatar ───────────────────────────────────────────────────────────────

class _HeroAvatar extends StatelessWidget {
  const _HeroAvatar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: const BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              FluentIcons.animal_paw_print_24_filled,
              size: 40,
              color: AppColors.primary,
            ),
          ),
          const PositionedDirectional(
            start: 100,
            top: 16,
            child: Icon(
              FluentIcons.heart_20_filled,
              size: 14,
              color: AppColors.accentCoral,
            ),
          ),
          const PositionedDirectional(
            end: 100,
            top: 36,
            child: Icon(
              FluentIcons.sparkle_20_filled,
              size: 14,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Field card ────────────────────────────────────────────────────────────────

class _FieldCard extends StatelessWidget {
  const _FieldCard({required this.icon, required this.child});

  final IconData icon;
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: AppRadius.mdAll,
            ),
            child: Icon(icon, size: 20, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// ── Breed card ────────────────────────────────────────────────────────────────

class _BreedCard extends ConsumerWidget {
  const _BreedCard({required this.speciesId});

  final int? speciesId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    if (speciesId == null) {
      return _FieldCard(
        icon: FluentIcons.ribbon_24_regular,
        child: AppDropdownField<int>(
          name: 'breedId',
          label: l10n.createPetBreed,
          hint: l10n.createPetSelectSpeciesFirst,
          enabled: false,
          items: const [],
        ),
      );
    }

    final breedsAsync = ref.watch(breedsListProvider(speciesId!));
    return breedsAsync.when(
      loading: () => _FieldCard(
        icon: FluentIcons.ribbon_24_regular,
        child: _BreedLoadingField(label: l10n.createPetBreed),
      ),
      error: (e, _) => _FieldCard(
        icon: FluentIcons.ribbon_24_regular,
        child: _BreedErrorField(
          label: l10n.createPetBreed,
          error: asFailure(e).localizedMessage(l10n),
        ),
      ),
      data: (breeds) => _FieldCard(
        icon: FluentIcons.ribbon_24_regular,
        child: AppDropdownField<int>(
          name: 'breedId',
          label: l10n.createPetBreed,
          validator: FormBuilderValidators.required(
              errorText: l10n.fieldRequired),
          items: [
            for (final b in breeds)
              DropdownMenuItem(value: b.id, child: Text(b.name)),
          ],
        ),
      ),
    );
  }
}

// ── Breed loading / error stubs ───────────────────────────────────────────────

class _BreedLoadingField extends StatelessWidget {
  const _BreedLoadingField({required this.label});
  final String label;

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
        const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ],
    );
  }
}

class _BreedErrorField extends StatelessWidget {
  const _BreedErrorField({required this.label, required this.error});
  final String label;
  final String error;

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
        Text(error,
            style:
                AppTextStyles.bodySmall.copyWith(color: AppColors.error)),
      ],
    );
  }
}

// ── Gender card ───────────────────────────────────────────────────────────────

class _GenderCard extends StatelessWidget {
  const _GenderCard();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return _FieldCard(
      icon: FluentIcons.person_24_regular,
      child: FormBuilderField<String>(
        name: 'gender',
        validator: FormBuilderValidators.required(
            errorText: l10n.fieldRequired),
        builder: (field) {
          final options = <({String value, String label, String? asset})>[
            (
              value: 'Male',
              label: l10n.genderMale,
              asset: 'assets/icons/gender_male.svg'
            ),
            (
              value: 'Female',
              label: l10n.genderFemale,
              asset: 'assets/icons/gender_female.svg'
            ),
            (value: 'Unknown', label: l10n.genderUnknown, asset: null),
          ];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.createPetGender,
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  for (int i = 0; i < options.length; i++) ...[
                    if (i > 0) const SizedBox(width: AppSpacing.xs),
                    _GenderChip(
                      label: options[i].label,
                      asset: options[i].asset,
                      selected: field.value == options[i].value,
                      onTap: () => field.didChange(options[i].value),
                    ),
                  ],
                ],
              ),
              if (field.hasError) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  field.errorText ?? '',
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.error),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _GenderChip extends StatelessWidget {
  const _GenderChip({
    required this.label,
    required this.asset,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String? asset;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = selected ? AppColors.onPrimary : AppColors.textSecondary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(
            vertical: 9, horizontal: AppSpacing.md),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.circular(50),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (asset != null)
              SvgPicture.asset(
                asset!,
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(fg, BlendMode.srcIn),
              )
            else
              Icon(FluentIcons.question_circle_24_regular,
                  size: 16, color: fg),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.labelMedium.copyWith(color: fg),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Species error ─────────────────────────────────────────────────────────────

class _SpeciesError extends StatelessWidget {
  const _SpeciesError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(FluentIcons.error_circle_24_regular,
                size: 48, color: AppColors.error),
            const SizedBox(height: AppSpacing.lg),
            Text(
              message,
              style: context.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            OutlinedButton(
              onPressed: onRetry,
              child: Text(context.l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}
