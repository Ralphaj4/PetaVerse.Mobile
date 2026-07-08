import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/date_time_extensions.dart';
import '../../../../core/network/dtos/media_dtos.dart';
import '../../../../core/network/providers/media_datasource_provider.dart';
import '../../../../core/services/media_upload_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/location_field.dart';
import '../../../../shared/widgets/shimmer.dart';
import '../../domain/entities/user.dart';
import '../providers/user_provider.dart';

/// Personal information — view and edit the signed-in user's profile.
///
/// Offline-first: data is read from [userProvider] (warmed at login), so the
/// page renders instantly. Editable fields live in themed section cards; the
/// mobile number and membership date are read-only.
class PersonalInformationPage extends ConsumerStatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  ConsumerState<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState
    extends ConsumerState<PersonalInformationPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  DateTime? _selectedDateOfBirth;
  LatLng? _location;
  String? _initialLocationName;
  bool _locationTouched = false;
  bool _isUpdating = false;
  bool _isUploadingAvatar = false;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  /// Seeds the controllers once from the first user emission. Background
  /// reconciles don't overwrite in-progress edits.
  void _initializeForm(User user) {
    if (_initialized) return;
    _initialized = true;
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _emailController.text = user.email ?? '';
    _selectedDateOfBirth = user.dateOfBirth;
    if (user.latitude != null && user.longitude != null) {
      _location = LatLng(user.latitude!, user.longitude!);
    }
    _initialLocationName = user.locationName;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateOfBirth ??
          DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDateOfBirth = picked);
    }
  }

  Future<void> _submitUpdate() async {
    setState(() => _locationTouched = true);
    final formOk = _formKey.currentState!.saveAndValidate();
    final location = _location;
    if (!formOk || location == null) return;

    setState(() => _isUpdating = true);

    final email = _emailController.text.trim();
    final locationName =
        (_formKey.currentState!.value['locationName'] as String?)?.trim();
    final failure = await ref.read(userProvider.notifier).updateProfile(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          email: email.isEmpty ? null : email,
          dateOfBirth: _selectedDateOfBirth,
          latitude: location.latitude,
          longitude: location.longitude,
          locationName: locationName,
        );

    if (!mounted) return;
    setState(() => _isUpdating = false);

    if (failure == null) {
      context.showSuccessSnackBar(context.l10n.profileUpdated);
    } else {
      context.showErrorSnackBar(failure.localizedMessage(context.l10n));
    }
  }

  /// Opens a Camera / Gallery sheet, then uploads the chosen image as the
  /// user's avatar and refreshes the profile so the new photo appears.
  Future<void> _editAvatar() async {
    if (_isUploadingAvatar) return;

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (ctx) => _PhotoSourceSheet(),
    );
    if (source == null) return;

    final picked = await ImagePicker().pickImage(
      source: source,
      imageQuality: 90,
    );
    if (picked == null || !mounted) return;

    setState(() => _isUploadingAvatar = true);

    final uploadService = MediaUploadService(ref.read(mediaDatasourceProvider));
    final result = await uploadService.uploadFile(
      file: File(picked.path),
      contentType: 'image/jpeg',
      category: MediaCategory.userAvatar,
      fileName: 'avatar.jpg',
    );

    // Re-fetch /me so the freshly uploaded avatar URL is reflected everywhere.
    final failure = result.failureOrNull;
    if (failure == null) {
      await ref.read(userProvider.notifier).refresh();
    }

    if (!mounted) return;
    setState(() => _isUploadingAvatar = false);

    if (failure == null) {
      context.showSuccessSnackBar(context.l10n.photoUpdated);
    } else {
      // Prefer the API message; falls back to a generic localized string.
      context.showErrorSnackBar(failure.localizedMessage(context.l10n));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final userAsync = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Text(l10n.personalInformation, style: AppTextStyles.titleLarge),
      ),
      body: userAsync.when(
        skipLoadingOnRefresh: true,
        loading: () => const _PersonalInfoSkeleton(),
        error: (error, _) => _ErrorView(
          message: (error is Failure ? error : const UnknownFailure())
              .localizedMessage(l10n),
          onRetry: () => ref.read(userProvider.notifier).refresh(),
        ),
        data: (user) {
          _initializeForm(user);
          return _Body(
            user: user,
            formKey: _formKey,
            firstNameController: _firstNameController,
            lastNameController: _lastNameController,
            emailController: _emailController,
            selectedDateOfBirth: _selectedDateOfBirth,
            initialLocation: _location,
            initialLocationName: _initialLocationName,
            locationTouched: _locationTouched,
            onLocationChanged: (p) => setState(() => _location = p),
            isUpdating: _isUpdating,
            isUploadingAvatar: _isUploadingAvatar,
            onPickDate: _pickDate,
            onEditAvatar: _editAvatar,
            onSubmit: _submitUpdate,
          );
        },
      ),
    );
  }
}

// ── Body ──────────────────────────────────────────────────────────────────

class _Body extends StatelessWidget {
  const _Body({
    required this.user,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.selectedDateOfBirth,
    required this.initialLocation,
    required this.initialLocationName,
    required this.locationTouched,
    required this.onLocationChanged,
    required this.isUpdating,
    required this.isUploadingAvatar,
    required this.onPickDate,
    required this.onEditAvatar,
    required this.onSubmit,
  });

  final User user;
  final GlobalKey<FormBuilderState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final DateTime? selectedDateOfBirth;
  final LatLng? initialLocation;
  final String? initialLocationName;
  final bool locationTouched;
  final ValueChanged<LatLng> onLocationChanged;
  final bool isUpdating;
  final bool isUploadingAvatar;
  final VoidCallback onPickDate;
  final VoidCallback onEditAvatar;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;
    final dobLabel = selectedDateOfBirth != null
        ? selectedDateOfBirth!.toMediumDate(locale)
        : l10n.selectDate;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.xxl,
      ),
      child: FormBuilder(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProfileHeaderCard(
              user: user,
              isUploadingAvatar: isUploadingAvatar,
              onEditAvatar: onEditAvatar,
            ),
            const SizedBox(height: AppSpacing.xl),

            // ── Basic Information ──────────────────────────────────────
            _SectionCard(
              icon: FluentIcons.person_24_regular,
              title: l10n.basicInformation,
              children: [
                FormBuilderTextField(
                  name: 'firstName',
                  controller: firstNameController,
                  decoration: InputDecoration(labelText: l10n.firstName),
                  validator: FormBuilderValidators.required(
                    errorText: l10n.fieldRequired,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                FormBuilderTextField(
                  name: 'lastName',
                  controller: lastNameController,
                  decoration: InputDecoration(labelText: l10n.lastName),
                  validator: FormBuilderValidators.required(
                    errorText: l10n.fieldRequired,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                _ReadOnlyTapField(
                  label: l10n.dateOfBirth,
                  value: dobLabel,
                  placeholder: selectedDateOfBirth == null,
                  onTap: onPickDate,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // ── Contact Details ────────────────────────────────────────
            _SectionCard(
              icon: FluentIcons.mail_24_regular,
              title: l10n.contactDetails,
              children: [
                FormBuilderTextField(
                  name: 'email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: l10n.emailOptional,
                    helperText: user.pendingEmail != null
                        ? l10n.emailPendingVerification(user.pendingEmail!)
                        : null,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return null;
                    return FormBuilderValidators.email(
                      errorText: l10n.invalidEmail,
                    )(value);
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                _MobileNumberField(
                  number: user.mobileNumber,
                  verified: user.mobileVerified,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // ── Location ───────────────────────────────────────────────
            _SectionCard(
              icon: FluentIcons.location_24_regular,
              title: l10n.locationName,
              children: [
                LocationField(
                  addressFieldName: 'locationName',
                  initialLocation: initialLocation,
                  initialLocationName: initialLocationName,
                  showValidationError: locationTouched,
                  onLocationChanged: onLocationChanged,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // ── Account Details ────────────────────────────────────────
            _SectionCard(
              icon: FluentIcons.info_24_regular,
              title: l10n.accountDetails,
              children: [
                _InfoRow(
                  icon: FluentIcons.calendar_clock_24_regular,
                  label: l10n.memberSince(user.createdAt.toMediumDate(locale)),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),

            AppButton(
              label: l10n.save,
              variant: AppButtonVariant.primary,
              icon: FluentIcons.checkmark_24_regular,
              onPressed: isUpdating ? null : onSubmit,
              isLoading: isUpdating,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Header card ─────────────────────────────────────────────────────────

class _ProfileHeaderCard extends StatelessWidget {
  const _ProfileHeaderCard({
    required this.user,
    required this.isUploadingAvatar,
    required this.onEditAvatar,
  });

  final User user;
  final bool isUploadingAvatar;
  final VoidCallback onEditAvatar;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final fullName = '${user.firstName} ${user.lastName}'.trim();
    final role = user.roles.isNotEmpty ? user.roles.first : null;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppRadius.lgAll,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: AppRadius.lgAll,
        child: Stack(
          children: [
            // Gradient base.
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primaryLight, AppColors.primary],
                  ),
                ),
              ),
            ),
            // Decorative translucent blobs.
            const Positioned(
              top: -50,
              right: -40,
              child: _Blob(size: 150, opacity: 0.18),
            ),
            const Positioned(
              top: 30,
              right: 40,
              child: _Blob(size: 60, opacity: 0.12),
            ),
            const Positioned(
              bottom: -30,
              left: -20,
              child: _Blob(size: 90, opacity: 0.12),
            ),
            const PositionedDirectional(
              bottom: AppSpacing.lg,
              start: AppSpacing.lg,
              child: _DotsGrid(),
            ),
            // Content. The infinite-width SizedBox forces the Stack (sized by
            // its non-positioned child) to span the full parent width.
            SizedBox(
              width: double.infinity,
              child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.xxl,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _EditableAvatar(
                    name: fullName,
                    imageUrl: user.avatarUrl,
                    isUploading: isUploadingAvatar,
                    onEdit: onEditAvatar,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          fullName,
                          style: AppTextStyles.headlineMedium.copyWith(
                            color: AppColors.onPrimary,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (user.mobileVerified) ...[
                        const SizedBox(width: AppSpacing.sm),
                        const _VerifiedBadge(),
                      ],
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.xs,
                    children: [
                      if (role != null)
                        _HeaderChip(
                          label: role,
                          icon: FluentIcons.person_24_regular,
                        ),
                      if (user.userCode.isNotEmpty)
                        _UserCodeChip(code: user.userCode),
                    ],
                  ),
                ],
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Avatar with a white ring and a pencil edit badge (with a busy spinner
/// while a new photo uploads).
class _EditableAvatar extends StatelessWidget {
  const _EditableAvatar({
    required this.name,
    required this.imageUrl,
    required this.isUploading,
    required this.onEdit,
  });

  final String name;
  final String? imageUrl;
  final bool isUploading;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      height: 96,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.onPrimary, width: 3),
            ),
            child: AppAvatar(name: name, imageUrl: imageUrl, radius: 42),
          ),
          if (isUploading)
            Positioned.fill(
              child: Container(
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColors.textPrimary.withValues(alpha: 0.45),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColors.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          // Edit pencil badge.
          PositionedDirectional(
            bottom: 0,
            end: 0,
            child: GestureDetector(
              onTap: isUploading ? null : onEdit,
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.onPrimary, width: 2.5),
                ),
                child: const Icon(
                  FluentIcons.edit_16_filled,
                  size: 14,
                  color: AppColors.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A small circular "verified" badge shown trailing the user's name — a green
/// disc with a white check, ringed in white so it reads on the gradient header.
class _VerifiedBadge extends StatelessWidget {
  const _VerifiedBadge();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.l10n.verified,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: AppColors.success,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.onPrimary, width: 1.5),
        ),
        alignment: Alignment.center,
        child: const Icon(
          FluentIcons.checkmark_16_filled,
          size: 12,
          color: AppColors.onPrimary,
        ),
      ),
    );
  }
}

/// A pill chip on a white surface — neutral by default, tinted by [accent]
/// (e.g. green for "Verified").
class _HeaderChip extends StatelessWidget {
  const _HeaderChip({required this.label, this.icon, this.accent});

  final String label;
  final IconData? icon;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final fg = accent ?? AppColors.textPrimary;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.onPrimary,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: fg),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: fg,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// A tappable pill showing the user's public [code] (e.g. "#a1b2c3d4").
/// Tapping copies it to the clipboard and confirms with a snackbar — handy
/// for sharing an account reference with support or other users.
class _UserCodeChip extends StatelessWidget {
  const _UserCodeChip({required this.code});

  final String code;

  Future<void> _copy(BuildContext context) async {
    final l10n = context.l10n;
    await Clipboard.setData(ClipboardData(text: code));
    if (context.mounted) context.showSuccessSnackBar(l10n.userIdCopied);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Semantics(
      button: true,
      label: '${l10n.userId}: $code',
      child: Material(
        color: AppColors.onPrimary,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: InkWell(
          onTap: () => _copy(context),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  FluentIcons.copy_24_regular,
                  size: 16,
                  color: AppColors.textPrimary,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '#$code',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A soft white circle used as a background decoration in the header.
class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.onPrimary.withValues(alpha: opacity),
        shape: BoxShape.circle,
      ),
    );
  }
}

/// A small 4×4 grid of faint dots, echoing the reference header.
class _DotsGrid extends StatelessWidget {
  const _DotsGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        4,
        (_) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              4,
              (_) => Container(
                width: 4,
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: AppColors.onPrimary.withValues(alpha: 0.25),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Photo source sheet ──────────────────────────────────────────────────

/// Bottom sheet that lets the user pick a photo source, returning the
/// chosen [ImageSource] (or null if dismissed).
class _PhotoSourceSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
              ),
            ),
            Text(l10n.changePhoto, style: AppTextStyles.titleMedium),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: _SourceButton(
                    icon: FluentIcons.camera_24_regular,
                    label: l10n.camera,
                    onTap: () => Navigator.pop(context, ImageSource.camera),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _SourceButton(
                    icon: FluentIcons.image_24_regular,
                    label: l10n.gallery,
                    onTap: () => Navigator.pop(context, ImageSource.gallery),
                  ),
                ),
              ],
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
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.mdAll,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: AppRadius.mdAll,
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: const BoxDecoration(
                color: AppColors.primarySoft,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primaryDark, size: 24),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              label,
              style: AppTextStyles.bodyMedium
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Section card ────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.children,
  });

  final IconData icon;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: AppRadius.smAll,
                ),
                child: Icon(icon, size: 18, color: AppColors.primaryDark),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(title, style: AppTextStyles.titleMedium),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          ...children,
        ],
      ),
    );
  }
}

// ── Read-only fields ──────────────────────────────────────────────────────

/// A field that looks like the form inputs but opens a picker on tap
/// (used for the date of birth).
class _ReadOnlyTapField extends StatelessWidget {
  const _ReadOnlyTapField({
    required this.label,
    required this.value,
    required this.placeholder,
    required this.onTap,
  });

  final String label;
  final String value;
  final bool placeholder;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.mdAll,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(
            FluentIcons.calendar_24_regular,
            size: 20,
            color: AppColors.textSecondary,
          ),
        ),
        child: Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            color: placeholder ? AppColors.textTertiary : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

/// Read-only mobile number row with a verified/unverified badge.
class _MobileNumberField extends StatelessWidget {
  const _MobileNumberField({required this.number, required this.verified});

  final String number;
  final bool verified;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = verified ? AppColors.success : AppColors.warning;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          const Icon(
            FluentIcons.phone_24_regular,
            size: 20,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.mobileNumber, style: AppTextStyles.labelSmall),
                const SizedBox(height: 2),
                Text(
                  number,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  verified
                      ? FluentIcons.checkmark_circle_16_filled
                      : FluentIcons.warning_16_filled,
                  size: 13,
                  color: color,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  verified ? l10n.verified : l10n.unverified,
                  style: AppTextStyles.labelMedium.copyWith(color: color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A simple icon + label info row (used in Account Details).
class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textTertiary),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Error view ──────────────────────────────────────────────────────────

/// First-load skeleton: the gradient header (avatar + name lines) and a couple
/// of section cards with field rows.
class _PersonalInfoSkeleton extends StatelessWidget {
  const _PersonalInfoSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Header card.
          const SkeletonCard(
            padding: EdgeInsets.all(AppSpacing.xl),
            child: Column(
              children: [
                SkeletonBox(width: 96, height: 96, shape: BoxShape.circle),
                SizedBox(height: AppSpacing.md),
                SkeletonLine(width: 160, height: 18),
                SizedBox(height: AppSpacing.sm),
                SkeletonLine(width: 100, height: 12),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Two section cards, each with a title + a few field rows.
          for (var s = 0; s < 2; s++) ...[
            SkeletonCard(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SkeletonLine(width: 120, height: 14),
                  const SizedBox(height: AppSpacing.lg),
                  for (var f = 0; f < 3; f++) ...[
                    const SkeletonLine(width: 70, height: 11),
                    const SizedBox(height: AppSpacing.sm),
                    SkeletonBox(height: 44, borderRadius: AppRadius.smAll),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              FluentIcons.error_circle_24_regular,
              size: 48,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              message,
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: context.l10n.retry,
              variant: AppButtonVariant.primary,
              expanded: false,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
