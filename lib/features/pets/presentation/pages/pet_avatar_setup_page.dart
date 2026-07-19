import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/network/dtos/media_dtos.dart';
import '../../../../core/network/providers/media_datasource_provider.dart';
import '../../../../core/services/media_upload_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/ambient_decorations.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../domain/entities/pet_ref.dart';
import '../providers/create_pet_provider.dart';

/// Post-creation step that lets the owner add a photo for the pet they just
/// created — the pet equivalent of [AvatarSetupPage].
///
/// Reached after create-pet (when the new pet has an id but isn't committed to
/// the routing gate yet). Whether the user uploads or skips, the page commits
/// the pet to the gate and lands on home. The router's pet-creation gate allows
/// this route so committing-then-navigating never races a redirect.
class PetAvatarSetupPage extends ConsumerStatefulWidget {
  const PetAvatarSetupPage({required this.petId, this.petRef, super.key});

  final int petId;

  /// The slim ref from the create response. Used to commit the pet to the gate
  /// once setup is done (with the uploaded photo, if any).
  final PetRef? petRef;

  @override
  ConsumerState<PetAvatarSetupPage> createState() => _PetAvatarSetupPageState();
}

class _PetAvatarSetupPageState extends ConsumerState<PetAvatarSetupPage> {
  File? _avatarFile;
  bool _isUploading = false;

  Future<void> _showAvatarPicker() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const _PhotoSourceSheet(),
    );
    if (source == null) return;
    await _pickFromSource(source);
  }

  Future<void> _pickFromSource(ImageSource source) async {
    final picked = await ImagePicker().pickImage(
      source: source,
      imageQuality: 90,
    );
    if (picked != null && mounted) {
      setState(() => _avatarFile = File(picked.path));
    }
  }

  /// Uploads the picked photo (if any), then commits the pet and goes home.
  /// On upload failure the user is told but still proceeds — a missing photo
  /// must not trap them on this screen.
  Future<void> _continue() async {
    String? uploadedUrl;

    if (_avatarFile != null) {
      setState(() => _isUploading = true);

      final uploadService =
          MediaUploadService(ref.read(mediaDatasourceProvider));
      final result = await uploadService.uploadFile(
        file: _avatarFile!,
        contentType: 'image/jpeg',
        category: MediaCategory.petAvatar,
        petId: widget.petId,
        fileName: 'pet_avatar.jpg',
      );

      if (!mounted) return;
      uploadedUrl = result.valueOrNull?.url;
      final failure = result.failureOrNull;
      if (failure != null) {
        // Prefer the API message; falls back to a generic localized string.
        context.showErrorSnackBar(failure.localizedMessage(context.l10n));
      }
      setState(() => _isUploading = false);
    }

    if (!mounted) return;
    _commitAndExit(uploadedUrl);
  }

  void _skip() => _commitAndExit(null);

  /// Commits the created pet to the routing gate (carrying the uploaded photo
  /// so it shows immediately), then lands on home for both entry points.
  ///
  /// A single declarative `go(home)` replaces the whole create-pet stack in one
  /// step. We avoid chained pops / raw Navigator here: mixing those with
  /// go_router desynced its page list and it restored the popped page, which
  /// reopened this screen on skip. Commit first so the gate already knows the
  /// pet before home renders (home selects/shows it immediately).
  void _commitAndExit(String? imageUrl) {
    final ref0 = widget.petRef;
    if (ref0 != null) {
      ref.read(createPetProvider.notifier).commitCreated(
            PetRef(id: ref0.id, name: ref0.name, imagePath: imageUrl),
          );
    }
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hasPhoto = _avatarFile != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const AmbientDecorations(),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                      vertical: AppSpacing.xl,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: AppSpacing.md),

                        // ── sparkle accent + headline ──────────────────────
                        const Icon(
                          FluentIcons.sparkle_20_filled,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          l10n.petAvatarSetupTitle,
                          style: AppTextStyles.displayLarge.copyWith(
                            fontSize: 28,
                            height: 1.15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          l10n.petAvatarSetupSubtitle,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.xxl),

                        // ── tappable photo target on a soft blob ───────────
                        _PhotoTarget(
                          file: _avatarFile,
                          uploadHint: l10n.petAvatarUploadHint,
                          changeHint: l10n.changePhoto,
                          onTap: _isUploading ? null : _showAvatarPicker,
                        ),
                        const SizedBox(height: AppSpacing.xxl),

                        // ── reassurance chip ───────────────────────────────
                        _InfoChip(label: l10n.petAvatarSetupOptional),
                      ],
                    ),
                  ),
                ),

                // ── footer actions ─────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.xl,
                    AppSpacing.sm,
                    AppSpacing.xl,
                    AppSpacing.lg,
                  ),
                  child: Column(
                    children: [
                      AppButton(
                        label: hasPhoto
                            ? l10n.continueLabel
                            : l10n.petAvatarUploadHint,
                        icon: hasPhoto
                            ? FluentIcons.checkmark_24_regular
                            : FluentIcons.camera_add_24_regular,
                        variant: AppButtonVariant.primary,
                        isLoading: _isUploading,
                        // No photo → the primary action is disabled; the user
                        // uploads via the photo target or leaves via "Skip".
                        onPressed: hasPhoto ? _continue : null,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      AppButton(
                        label: l10n.skipForNow,
                        variant: AppButtonVariant.text,
                        onPressed: _isUploading ? null : _skip,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The large circular photo target: an empty prompt or the picked photo, seated
/// on a soft organic blob so it echoes the pet-onboarding hero art.
class _PhotoTarget extends StatelessWidget {
  const _PhotoTarget({
    required this.file,
    required this.uploadHint,
    required this.changeHint,
    required this.onTap,
  });

  final File? file;
  final String uploadHint;
  final String changeHint;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final size = (MediaQuery.sizeOf(context).width * 0.6).clamp(200.0, 260.0);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Soft organic blob behind the target.
            Container(
              width: size * 0.98,
              height: size * 0.9,
              decoration: const BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(150),
                  topRight: Radius.circular(130),
                  bottomLeft: Radius.circular(120),
                  bottomRight: Radius.circular(160),
                ),
              ),
            ),

            // Circular photo / prompt.
            Container(
              width: size * 0.78,
              height: size * 0.78,
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.35),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: file == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            FluentIcons.camera_add_24_regular,
                            color: AppColors.primary,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          uploadHint,
                          style: AppTextStyles.titleSmall.copyWith(
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ],
                    )
                  : Image.file(file!, fit: BoxFit.cover),
            ),

            // "Change" affordance once a photo is picked.
            if (file != null)
              PositionedDirectional(
                bottom: size * 0.06,
                end: size * 0.06,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: AppRadius.smAll,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        FluentIcons.edit_16_regular,
                        color: AppColors.onPrimary,
                        size: 14,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        changeHint,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.onPrimary,
                        ),
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

/// Small soft chip reinforcing that the photo is optional / editable later.
class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
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
          const Icon(
            FluentIcons.info_16_regular,
            color: AppColors.secondaryDark,
            size: 16,
          ),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.secondaryDark,
              ),
            ),
          ),
        ],
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
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: AppSpacing.xs,
                bottom: AppSpacing.md,
              ),
              child: Text(l10n.changePhoto, style: AppTextStyles.titleSmall),
            ),
            Row(
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
              style: AppTextStyles.bodySmall
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
