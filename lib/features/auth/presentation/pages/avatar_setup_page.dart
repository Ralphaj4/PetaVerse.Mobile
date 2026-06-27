import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/network/dtos/media_dtos.dart';
import '../../../../core/network/providers/media_datasource_provider.dart';
import '../../../../core/services/media_upload_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class AvatarSetupPage extends ConsumerStatefulWidget {
  const AvatarSetupPage({super.key});

  @override
  ConsumerState<AvatarSetupPage> createState() => _AvatarSetupPageState();
}

class _AvatarSetupPageState extends ConsumerState<AvatarSetupPage> {
  File? _avatarFile;
  bool _isUploading = false;

  Future<void> _showAvatarPicker() async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.lg),
        ),
      ),
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.lg),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: AppSpacing.lg,
                right: AppSpacing.lg,
                top: AppSpacing.lg,
                bottom: AppSpacing.md,
              ),
              child: Text(
                'Choose Photo Source',
                style: AppTextStyles.titleSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                      child: _AvatarSourceButton(
                        icon: FluentIcons.camera_24_regular,
                        label: 'Camera',
                        onTap: () async {
                          Navigator.pop(ctx);
                          await _pickFromSource(ImageSource.camera);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                      child: _AvatarSourceButton(
                        icon: FluentIcons.image_24_regular,
                        label: 'Gallery',
                        onTap: () async {
                          Navigator.pop(ctx);
                          await _pickFromSource(ImageSource.gallery);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFromSource(ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: source,
      imageQuality: 90,
    );
    if (image != null && mounted) {
      setState(() => _avatarFile = File(image.path));
    }
  }

  Future<void> _uploadAndContinue() async {
    if (_avatarFile != null) {
      setState(() => _isUploading = true);

      final uploadService = MediaUploadService(
        ref.read(mediaDatasourceProvider),
      );
      await uploadService.uploadFile(
        file: _avatarFile!,
        contentType: 'image/jpeg',
        category: MediaCategory.userAvatar,
        fileName: 'avatar.jpg',
      );

      if (!mounted) return;
      setState(() => _isUploading = false);
    }

    if (!mounted) return;
    context.go(AppRoutes.petOnboarding);
  }

  @override
  Widget build(BuildContext context) {
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
                // Top decorative icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    FluentIcons.person_add_24_regular,
                    color: AppColors.primary,
                    size: 48,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // Title
                Text(
                  'Add Your Photo',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.md),

                // Subtitle
                Text(
                  'Help others get to know you better.\nThis is optional and you can change it anytime.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Upload box
                GestureDetector(
                  onTap: _showAvatarPicker,
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.xxl,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                    child: _avatarFile == null
                        ? Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  FluentIcons.camera_add_24_regular,
                                  color: AppColors.primary,
                                  size: 40,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.lg),
                              Text(
                                'Upload a photo',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                'JPEG, JPG or PNG. Max 5MB.',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(AppRadius.lg),
                            child: Image.file(
                              _avatarFile!,
                              fit: BoxFit.cover,
                              height: 250,
                              width: double.infinity,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Benefits row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const _BenefitItem(
                      icon: FluentIcons.heart_24_regular,
                      label: 'Build trust',
                    ),
                    Container(
                      width: 1,
                      height: 60,
                      color: Colors.grey[300],
                    ),
                    const _BenefitItem(
                      icon: FluentIcons.star_24_regular,
                      label: 'Stand out',
                    ),
                  ],
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
                  onPressed: _isUploading ? null : _uploadAndContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: Colors.grey[300],
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
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
                          _avatarFile == null ? 'Skip for now' : 'Continue',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
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

class _AvatarSourceButton extends StatelessWidget {
  const _AvatarSourceButton({
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
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.primary, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 32,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BenefitItem extends StatelessWidget {
  const _BenefitItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 32,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
