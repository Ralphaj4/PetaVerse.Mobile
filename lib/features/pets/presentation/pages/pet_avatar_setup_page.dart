import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/network/dtos/media_dtos.dart';
import '../../../../core/network/providers/media_datasource_provider.dart';
import '../../../../core/services/media_upload_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
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
      uploadedUrl = result.when(success: (asset) => asset.url, failure: (_) => null);
      if (uploadedUrl == null) {
        context.showErrorSnackBar(context.l10n.photoUploadFailed);
      }
      setState(() => _isUploading = false);
    }

    if (!mounted) return;
    _commitAndGoHome(uploadedUrl);
  }

  void _skip() => _commitAndGoHome(null);

  /// Commits the created pet to the routing gate (carrying the uploaded photo
  /// so it shows immediately), then navigates home. Navigation happens before
  /// commit so the gate's redirect can't race the pending nav.
  void _commitAndGoHome(String? imageUrl) {
    final ref0 = widget.petRef;
    context.go(AppRoutes.home);
    if (ref0 != null) {
      ref.read(createPetProvider.notifier).commitCreated(
            PetRef(id: ref0.id, name: ref0.name, imagePath: imageUrl),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.xl,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          FluentIcons.animal_paw_print_24_filled,
                          color: AppColors.primary,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Text(
                        l10n.petAvatarSetupTitle,
                        style: AppTextStyles.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        l10n.petAvatarSetupSubtitle,
                        style: AppTextStyles.bodyMedium
                            .copyWith(color: AppColors.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      GestureDetector(
                        onTap: _showAvatarPicker,
                        child: Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.05),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              width: 2,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: _avatarFile == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      FluentIcons.camera_add_24_regular,
                                      color: AppColors.primary,
                                      size: 44,
                                    ),
                                    const SizedBox(height: AppSpacing.md),
                                    Text(
                                      l10n.petAvatarUploadHint,
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              : Image.file(_avatarFile!, fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.xl,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isUploading ? null : _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.divider,
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSpacing.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.lgAll,
                    ),
                  ),
                  child: _isUploading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          _avatarFile == null
                              ? l10n.skipForNow
                              : l10n.continueLabel,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
            if (!_isUploading)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: TextButton(
                  onPressed: _avatarFile == null ? null : _skip,
                  child: Text(
                    l10n.skipForNow,
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textSecondary),
                  ),
                ),
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
        color: Colors.white,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          color: Colors.white,
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
