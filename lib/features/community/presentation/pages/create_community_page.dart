import 'dart:async';
import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/network/dtos/media_dtos.dart';
import '../../../../core/network/providers/media_datasource_provider.dart';
import '../../../../core/services/media_upload_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_dropdown_field.dart';
import '../../domain/entities/community_group_enums.dart';
import '../providers/community_group_actions_providers.dart';
import '../providers/community_group_providers.dart';
import '../providers/community_providers.dart';
import '../widgets/community_common.dart';

/// Live availability state of the handle field.
enum _HandleStatus { idle, checking, available, taken, invalid }

/// Form to create a new community, led by the acting pet. Reached via
/// `/community/communities/create`.
class CreateCommunityPage extends ConsumerStatefulWidget {
  const CreateCommunityPage({super.key});

  @override
  ConsumerState<CreateCommunityPage> createState() =>
      _CreateCommunityPageState();
}

class _CreateCommunityPageState extends ConsumerState<CreateCommunityPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _picker = ImagePicker();
  bool _submitting = false;

  File? _avatarFile;
  File? _bannerFile;

  // ── Handle availability ─────────────────────────────────────────────────────
  final _handleController = TextEditingController();
  Timer? _handleDebounce;
  _HandleStatus _handleStatus = _HandleStatus.idle;
  // Guards against a stale in-flight check overwriting a newer one.
  int _handleCheckSeq = 0;

  static final _handleFormat = RegExp(r'^[a-z0-9-]+$');

  @override
  void dispose() {
    _handleDebounce?.cancel();
    _handleController.dispose();
    super.dispose();
  }

  void _onHandleChanged(String raw) {
    _handleDebounce?.cancel();
    final handle = raw.trim().toLowerCase();

    if (handle.isEmpty) {
      setState(() => _handleStatus = _HandleStatus.idle);
      return;
    }
    if (!_handleFormat.hasMatch(handle)) {
      setState(() => _handleStatus = _HandleStatus.invalid);
      return;
    }
    setState(() => _handleStatus = _HandleStatus.checking);
    final seq = ++_handleCheckSeq;
    _handleDebounce = Timer(const Duration(milliseconds: 300), () async {
      final result = await ref
          .read(communityGroupRepositoryProvider)
          .checkHandleAvailable(handle);
      if (!mounted || seq != _handleCheckSeq) return; // superseded
      result.when(
        success: (available) => setState(() => _handleStatus =
            available ? _HandleStatus.available : _HandleStatus.taken),
        // On a network error, don't block the user — server still validates.
        failure: (_) => setState(() => _handleStatus = _HandleStatus.idle),
      );
    });
  }

  /// The trailing status glyph for the handle field.
  Widget? _handleSuffix() => switch (_handleStatus) {
        _HandleStatus.checking => const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        _HandleStatus.available => const Icon(
            FluentIcons.checkmark_circle_24_filled,
            color: AppColors.success),
        _HandleStatus.taken || _HandleStatus.invalid => const Icon(
            FluentIcons.error_circle_24_filled,
            color: AppColors.error),
        _HandleStatus.idle => null,
      };

  /// The helper line under the handle field.
  String? _handleHelper(AppLocalizations l10n) => switch (_handleStatus) {
        _HandleStatus.checking => l10n.communityHandleChecking,
        _HandleStatus.available => l10n.communityHandleAvailable,
        _HandleStatus.taken => l10n.communityHandleTaken,
        _HandleStatus.invalid => l10n.communityHandleInvalid,
        _HandleStatus.idle => null,
      };

  Future<void> _pickImage({required bool isBanner}) async {
    try {
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked == null || !mounted) return;
      setState(() {
        if (isBanner) {
          _bannerFile = File(picked.path);
        } else {
          _avatarFile = File(picked.path);
        }
      });
    } catch (_) {
      if (mounted) _snack(context.l10n.communityCreateFailed);
    }
  }

  /// Uploads [file] via the presign/confirm flow, returning the confirmed asset
  /// id, or null (with a snackbar) on failure.
  Future<String?> _uploadImage(File file, MediaCategory category) async {
    final uploader = MediaUploadService(ref.read(mediaDatasourceProvider));
    final result = await uploader.uploadFile(
      file: file,
      contentType: 'image/jpeg',
      category: category,
    );
    return result.when(success: (asset) => asset.id, failure: (_) => null);
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    final actingPetId = ref.read(actingPetIdProvider);
    if (actingPetId == null) {
      _snack(l10n.communityCreateAddPetFirst);
      return;
    }
    final form = _formKey.currentState!;
    if (!form.saveAndValidate()) return;
    // Block submit while the handle is taken, invalid, or still checking.
    if (_handleStatus == _HandleStatus.taken ||
        _handleStatus == _HandleStatus.invalid ||
        _handleStatus == _HandleStatus.checking) {
      _snack(_handleStatus == _HandleStatus.checking
          ? l10n.communityHandleChecking
          : l10n.communityHandleTaken);
      return;
    }
    final values = form.value;

    setState(() => _submitting = true);

    // Upload images first (if any). A failed upload aborts creation.
    String? avatarAssetId;
    String? bannerAssetId;
    if (_avatarFile != null) {
      avatarAssetId =
          await _uploadImage(_avatarFile!, MediaCategory.communityAvatar);
      if (avatarAssetId == null) return _fail(l10n);
    }
    if (_bannerFile != null) {
      bannerAssetId =
          await _uploadImage(_bannerFile!, MediaCategory.communityBanner);
      if (bannerAssetId == null) return _fail(l10n);
    }

    final handle = (values['handle'] as String?)?.trim();
    final description = (values['description'] as String?)?.trim();

    final community = await ref.read(communityGroupActionsProvider).create(
          name: (values['name'] as String).trim(),
          category: values['category'] as CommunityCategory,
          handle: (handle?.isNotEmpty ?? false) ? handle : null,
          description: (description?.isNotEmpty ?? false) ? description : null,
          avatarAssetId: avatarAssetId,
          bannerAssetId: bannerAssetId,
        );

    if (!mounted) return;
    setState(() => _submitting = false);

    if (community == null) {
      _snack(l10n.communityCreateFailed);
      return;
    }
    _snack(l10n.communityCreatedToast);
    context.pushReplacement('/community/communities/${community.id}');
  }

  void _fail(AppLocalizations l10n) {
    if (!mounted) return;
    setState(() => _submitting = false);
    _snack(l10n.communityCreateFailed);
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(l10n.communityCreateTitle),
      ),
      body: SafeArea(
        child: FormBuilder(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              _imagePickers(l10n),
              const SizedBox(height: AppSpacing.xl),
              FormBuilderTextField(
                name: 'name',
                textInputAction: TextInputAction.next,
                maxLength: 60,
                decoration: InputDecoration(
                  labelText: l10n.communityCreateNameLabel,
                  hintText: l10n.communityCreateNameHint,
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(borderRadius: AppRadius.mdAll),
                ),
                validator: FormBuilderValidators.required(
                  errorText: l10n.communityCreateNameRequired,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              // Category uses the app-wide bottom-sheet picker (like species /
              // vaccination), boxed to match the surrounding text fields.
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md, vertical: AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppRadius.mdAll,
                  border: Border.all(color: AppColors.divider),
                ),
                child: AppDropdownField<CommunityCategory>(
                  name: 'category',
                  label: l10n.communityCreateCategoryLabel,
                  hint: l10n.communityCreateCategoryLabel,
                  searchable: false,
                  items: [
                    for (final c in CommunityCategory.values)
                      DropdownMenuItem(value: c, child: Text(c.label(l10n))),
                  ],
                  validator: FormBuilderValidators.required(
                    errorText: l10n.communityCreateCategoryRequired,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              FormBuilderTextField(
                name: 'handle',
                controller: _handleController,
                textInputAction: TextInputAction.next,
                maxLength: 30,
                onChanged: (v) => _onHandleChanged(v ?? ''),
                inputFormatters: [
                  // Lowercase + slug chars only, as the user types.
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9-]')),
                  TextInputFormatter.withFunction(
                    (_, n) => n.copyWith(text: n.text.toLowerCase()),
                  ),
                ],
                decoration: InputDecoration(
                  labelText: l10n.communityCreateHandleLabel,
                  hintText: l10n.communityCreateHandleHint,
                  prefixText: '@',
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(borderRadius: AppRadius.mdAll),
                  suffixIcon: _handleSuffix(),
                  helperText: _handleHelper(l10n),
                  helperStyle: AppTextStyles.bodySmall.copyWith(
                    color: _handleStatus == _HandleStatus.available
                        ? AppColors.success
                        : (_handleStatus == _HandleStatus.taken ||
                                _handleStatus == _HandleStatus.invalid)
                            ? AppColors.error
                            : AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              FormBuilderTextField(
                name: 'description',
                maxLines: 4,
                maxLength: 300,
                decoration: InputDecoration(
                  labelText: l10n.communityCreateDescriptionLabel,
                  hintText: l10n.communityCreateDescriptionHint,
                  alignLabelWithHint: true,
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(borderRadius: AppRadius.mdAll),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              FilledButton(
                onPressed: (_submitting ||
                        _handleStatus == _HandleStatus.taken ||
                        _handleStatus == _HandleStatus.invalid ||
                        _handleStatus == _HandleStatus.checking)
                    ? null
                    : _submit,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
                ),
                child: _submitting
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: AppColors.onPrimary),
                      )
                    : Text(l10n.communityCreateSubmit),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Banner (wide, tappable) with the avatar picker overlapping its lower-left.
  Widget _imagePickers(AppLocalizations l10n) {
    return SizedBox(
      height: 150,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Banner
          GestureDetector(
            onTap: _submitting ? null : () => _pickImage(isBanner: true),
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: AppRadius.lgAll,
                border: Border.all(color: AppColors.divider),
              ),
              clipBehavior: Clip.antiAlias,
              child: _bannerFile != null
                  ? Image.file(_bannerFile!, fit: BoxFit.cover)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(FluentIcons.image_add_24_regular,
                            color: AppColors.textTertiary),
                        const SizedBox(height: AppSpacing.xs),
                        Text(l10n.communityCreateBannerLabel,
                            style: AppTextStyles.labelMedium
                                .copyWith(color: AppColors.textTertiary)),
                      ],
                    ),
            ),
          ),
          // Avatar
          Positioned(
            bottom: 0,
            left: AppSpacing.lg,
            child: GestureDetector(
              onTap: _submitting ? null : () => _pickImage(isBanner: false),
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.background, width: 3),
                ),
                clipBehavior: Clip.antiAlias,
                child: _avatarFile != null
                    ? Image.file(_avatarFile!, fit: BoxFit.cover)
                    : const Icon(FluentIcons.camera_add_24_regular,
                        color: AppColors.textTertiary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
