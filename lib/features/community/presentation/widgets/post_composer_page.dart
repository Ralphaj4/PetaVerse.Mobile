import 'dart:async';
import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../models/pawhub_models.dart';
import '../providers/create_post_provider.dart';
import '../providers/post_upload_queue.dart';
import '../providers/community_providers.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../pages/tag_pets_page.dart';
import 'pawhub_common.dart';

/// Full-screen post composer. Users can pick photos/videos from device gallery
/// or camera. Caption, hashtags, tagged pets, location, visibility,
/// and publish are all wired to the real [CreatePost] provider.
class PostComposerPage extends ConsumerStatefulWidget {
  const PostComposerPage({
    required this.myPets,
    required this.actingAs,
    required this.taggablePets,
    this.communityId,
    this.communityName,
    super.key,
  });

  final List<PawPet> myPets;
  final PawPet actingAs;
  final List<PawPet> taggablePets;

  /// When set, the post is created inside this community (its feed, not the
  /// personal one). [communityName] is shown as a "Posting in …" banner.
  final int? communityId;
  final String? communityName;

  @override
  ConsumerState<PostComposerPage> createState() => _PostComposerPageState();
}

class _PostComposerPageState extends ConsumerState<PostComposerPage> {
  late PawPet _actingAs = widget.actingAs;
  final _caption = TextEditingController();
  final _location = TextEditingController();
  final List<PawMedia> _media = [];
  final List<PawPet> _tagged = [];
  // Visibility is fixed to public for now (the picker row was removed); still
  // sent to the backend on publish.
  final PostVisibility _visibility = PostVisibility.public;
  final ImagePicker _picker = ImagePicker();
  bool _pickerActive = false;

  static const int _captionLimit = 500;

  @override
  void initState() {
    super.initState();
    // Drive the "n / 2,200" counter in the caption card.
    _caption.addListener(_onCaptionChanged);
  }

  void _onCaptionChanged() => setState(() {});

  @override
  void dispose() {
    _caption.removeListener(_onCaptionChanged);
    _caption.dispose();
    _location.dispose();
    super.dispose();
  }

  Future<void> _addMedia() async {
    if (_pickerActive) return;
    _pickerActive = true;
    try {
      unawaited(showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        backgroundColor: AppColors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
        ),
        builder: (sheetContext) => SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(context.l10n.pawhubComposerAddToPost,
                    style: AppTextStyles.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  context.l10n.pawhubComposerAddToPostSubtitle,
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: _MediaSourceCard(
                        icon: FluentIcons.camera_24_regular,
                        label: context.l10n.camera,
                        subtitle: context.l10n.pawhubComposerCameraSubtitle,
                        accent: AppColors.secondary,
                        accentSoft: AppColors.secondarySoft,
                        onTap: () {
                          Navigator.pop(sheetContext);
                          _pickImage(ImageSource.camera);
                        },
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _MediaSourceCard(
                        icon: FluentIcons.image_multiple_24_regular,
                        label: context.l10n.gallery,
                        subtitle: context.l10n.pawhubComposerGallerySubtitle,
                        accent: AppColors.primaryDark,
                        accentSoft: AppColors.primarySoft,
                        onTap: () {
                          Navigator.pop(sheetContext);
                          _pickMedia();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ),
      ));
    } finally {
      _pickerActive = false;
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final file = await _picker.pickImage(source: source);
      if (file != null && mounted) {
        setState(() {
          _media.add(PawMedia(
            url: file.path,
            altText: '',
          ));
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.pawhubErrorPickingImage)),
        );
      }
    }
  }

  Future<void> _pickMedia() async {
    try {
      // pickMultipleMedia returns a mix of images and videos from the library.
      final files = await _picker.pickMultipleMedia();
      if (files.isEmpty) return;
      final picked = <PawMedia>[];
      for (final file in files) {
        final isVideo = _isVideoFile(file);
        // Videos need a duration (the backend requires it); read it from the
        // file before we queue the item.
        final duration = isVideo ? await _readVideoSeconds(file.path) : null;
        picked.add(PawMedia(
          url: file.path,
          isVideo: isVideo,
          durationSeconds: duration,
          altText: '',
        ));
      }
      if (mounted) setState(() => _media.addAll(picked));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.pawhubErrorPickingMedia)),
        );
      }
    }
  }

  /// Lets the user pick a cover image (poster) for the video at [index] from
  /// the gallery. Stored locally on the item and uploaded as the thumbnail
  /// asset on publish. Reuses the picker-active guard so it can't overlap
  /// another picker session.
  Future<void> _pickCover(int index) async {
    if (_pickerActive) return;
    _pickerActive = true;
    try {
      final file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null && mounted) {
        setState(() {
          _media[index] = _media[index].copyWith(localCoverPath: file.path);
        });
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.pawhubErrorPickingImage)),
        );
      }
    } finally {
      _pickerActive = false;
    }
  }

  /// Detects a video by MIME type when available, falling back to the file
  /// extension (covers the common gallery-picked formats).
  bool _isVideoFile(XFile file) {
    final mime = file.mimeType?.toLowerCase();
    if (mime != null) return mime.startsWith('video/');
    const videoExt = {
      '.mp4', '.mov', '.m4v', '.3gp', '.avi', '.mkv', '.webm',
    };
    final path = file.path.toLowerCase();
    return videoExt.any(path.endsWith);
  }

  /// Reads a video's duration (rounded up to whole seconds) via a throwaway
  /// [VideoPlayerController]. Returns null if it can't be determined.
  Future<int?> _readVideoSeconds(String path) async {
    final controller = VideoPlayerController.file(File(path));
    try {
      await controller.initialize();
      final d = controller.value.duration;
      if (d == Duration.zero) return null;
      return d.inMilliseconds <= 0 ? null : (d.inMilliseconds / 1000).ceil();
    } catch (_) {
      return null;
    } finally {
      await controller.dispose();
    }
  }


  Future<void> _switchPet() async {
    final chosen = await showPetSwitcherSheet(
      context,
      pets: widget.myPets,
      current: _actingAs,
      title: context.l10n.pawHubPostingAs,
    );
    if (chosen != null) {
      setState(() => _actingAs = chosen);
      ref.read(petsProvider.notifier).selectPet(chosen.backendId);
    }
  }

  Future<void> _pickTags() async {
    final result = await context.push<List<PawPet>>(
      AppRoutes.tagPets,
      extra: TagPetsArgs(
        candidates: widget.taggablePets,
        selected: List<PawPet>.from(_tagged),
        // Can't tag the author pet in its own post.
        excludePetId: _actingAs.backendId,
      ),
    );
    if (result != null && mounted) {
      setState(() => _tagged
        ..clear()
        ..addAll(result));
    }
  }

  /// The tag-pets row value: null when none, the single name when one, or
  /// "First & N more" when several (avoids truncating a comma-joined list).
  String? _taggedSummary() {
    if (_tagged.isEmpty) return null;
    if (_tagged.length == 1) return _tagged.first.name;
    return context.l10n.pawhubComposerTaggedSummary(
      _tagged.first.name,
      _tagged.length - 1,
    );
  }

  Future<void> _publish() async {
    if (_media.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text(context.l10n.pawHubAddPhotoRequired)));
      return;
    }

    // Every video must carry a duration or the backend rejects the post.
    final videoMissingDuration = _media.any(
      (m) => m.isVideo && (m.durationSeconds == null || m.durationSeconds! <= 0),
    );
    if (videoMissingDuration) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(context.l10n.pawhubComposerVideoLengthError),
        ));
      return;
    }

    final resolvedPetId = _actingAs.backendId > 0
        ? _actingAs.backendId
        : (ref.read(actingPetIdProvider) ?? 0);
    if (resolvedPetId == 0) return;

    final captionText = _caption.text.trim();
    final hashtags = RegExp(r'#(\w+)')
        .allMatches(captionText)
        .map((m) => m.group(1)!)
        .toList();
    final cleanCaption = captionText.replaceAll(RegExp(r'#\w+'), '').trim();

    final draftMedia = _media.map((m) {
      final isVideo = m.isVideo;
      return DraftMedia(
        file: File(m.url),
        contentType: isVideo ? 'video/mp4' : 'image/jpeg',
        altText: m.altText,
        durationSeconds: isVideo ? m.durationSeconds : null,
        // Only videos carry a cover; ignore any stray path on an image.
        thumbnailFile: isVideo && m.localCoverPath != null
            ? File(m.localCoverPath!)
            : null,
      );
    }).toList();

    // Hand the post off to the background upload queue and leave immediately —
    // uploading (which can be slow for videos) continues via the global
    // progress banner while the user keeps browsing.
    ref.read(postUploadQueueProvider.notifier).enqueue(
          PostDraft(
            authorPetId: resolvedPetId,
            caption: cleanCaption.isNotEmpty ? cleanCaption : null,
            locationName:
                _location.text.trim().isEmpty ? null : _location.text.trim(),
            visibility: _visibility.toDomain,
            media: draftMedia,
            hashtags: hashtags,
            taggedPetIds: _tagged
                .where((p) => p.backendId > 0)
                .map((p) => p.backendId)
                .toList(),
            communityId: widget.communityId,
          ),
        );

    unawaited(HapticFeedback.mediumImpact());
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // Publishing now happens in the background queue after we pop, so the
    // share button never shows a busy state here.
    const publishing = false;
    return Scaffold(
      backgroundColor: AppColors.backgroundWarm,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWarm,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(FluentIcons.dismiss_24_regular,
              color: AppColors.textPrimary),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.l10n.pawHubNewPostTitle,
                style: AppTextStyles.titleLarge),
            const SizedBox(width: AppSpacing.sm),
            const Icon(FluentIcons.animal_paw_print_24_filled,
                size: 20, color: AppColors.primary),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.lg),
            child: _ShareButton(
              publishing: publishing,
              onPressed: _publish,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Posting-as card.
          _CompositionCard(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: _postingAsRow(),
          ),
          const SizedBox(height: AppSpacing.md),

          // Posting-in banner (community posts only).
          if (widget.communityName != null) ...[
            _postingInCard(),
            const SizedBox(height: AppSpacing.md),
          ],

          // Media card.
          _CompositionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.l10n.pawhubComposerAddPhotosOrVideos,
                    style: AppTextStyles.titleSmall),
                const SizedBox(height: AppSpacing.md),
                _mediaStrip(),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Caption card.
          _captionCard(),
          const SizedBox(height: AppSpacing.md),

          // Options card.
          _CompositionCard(
            padding: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: AppRadius.mdAll,
              child: Column(
                children: [
                  _optionRow(
                    icon: FluentIcons.tag_24_regular,
                    label: context.l10n.pawHubTagPets,
                    subtitle: context.l10n.pawhubComposerTagPetsSubtitle,
                    value: _taggedSummary(),
                    onTap: _pickTags,
                  ),
                  const _RowDivider(),
                  _locationRow(),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  /// Avatar + "Posting as" / bold pet name + dropdown chevron.
  Widget _postingAsRow() {
    return InkWell(
      onTap: _switchPet,
      borderRadius: AppRadius.mdAll,
      child: Row(
        children: [
          AppAvatar(
            name: _actingAs.name,
            imageUrl: _actingAs.avatarUrl,
            radius: 26,
          ),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.pawHubPostingAs,
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.textSecondary),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_actingAs.name, style: AppTextStyles.titleMedium),
                  const SizedBox(width: 2),
                  const Icon(FluentIcons.chevron_down_16_filled,
                      size: 16, color: AppColors.textPrimary),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Teal "Posting in `<community>`" banner card.
  Widget _postingInCard() {
    return _CompositionCard(
      color: AppColors.secondarySoft,
      border: false,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.md),
      child: Row(
        children: [
          const Icon(FluentIcons.people_community_24_filled,
              size: 22, color: AppColors.secondaryDark),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.l10n.pawhubComposerPostingIn,
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.secondaryDark)),
                Text(
                  widget.communityName!,
                  style: AppTextStyles.titleSmall
                      .copyWith(color: AppColors.secondaryDark),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(FluentIcons.chevron_right_24_regular,
              size: 20, color: AppColors.secondaryDark),
        ],
      ),
    );
  }

  /// Caption field card with the live character counter.
  Widget _captionCard() {
    return _CompositionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _caption,
            minLines: 3,
            maxLines: 8,
            maxLength: _captionLimit,
            textCapitalization: TextCapitalization.sentences,
            style: AppTextStyles.bodyMedium,
            decoration: InputDecoration(
              hintText: context.l10n.pawHubCaptionHint,
              hintStyle: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textTertiary),
              isDense: true,
              contentPadding: EdgeInsets.zero,
              filled: false,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              counterText: '',
            ),
          ),
          Text(
            '${_caption.text.characters.length} / '
            '${_formatThousands(_captionLimit)}',
            style: AppTextStyles.labelSmall
                .copyWith(color: AppColors.textTertiary),
          ),
        ],
      ),
    );
  }

  /// "2200" → "2,200" for the counter, matching the mockup.
  static String _formatThousands(int value) {
    final digits = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  Widget _mediaStrip() {
    return SizedBox(
      height: 132,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _media.length + 1,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
        itemBuilder: (_, i) {
          if (i == _media.length) {
            return _AddMediaTile(
              onTap: _pickerActive ? null : _addMedia,
              disabled: _pickerActive,
            );
          }
          return _MediaThumb(
            media: _media[i],
            isCover: i == 0,
            onRemove: () => setState(() => _media.removeAt(i)),
            onPickCover:
                _media[i].isVideo ? () => _pickCover(i) : null,
          );
        },
      ),
    );
  }

  Widget _optionRow({
    required IconData icon,
    required String label,
    required String subtitle,
    required String? value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.md),
        child: Row(
          children: [
            Icon(icon, size: 24, color: AppColors.secondary),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTextStyles.bodyMedium),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            if (value != null)
              // Its own Expanded so the value's box stretches toward the
              // chevron; TextAlign.end then pins the text hard against the
              // right edge rather than letting it hug the label column mid-row.
              Expanded(
                flex: 2,
                child: Text(
                  value,
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.secondaryDark),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                ),
              ),
            const SizedBox(width: AppSpacing.xs),
            const Icon(FluentIcons.chevron_right_24_regular,
                size: 18, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }

  /// The location input: an inline text field the user types a place name into
  /// (no map picker). Mirrors the option-row's icon + labels on the left.
  Widget _locationRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
      child: Row(
        children: [
          const Icon(FluentIcons.location_24_regular,
              size: 24, color: AppColors.secondary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: TextField(
              controller: _location,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              style: AppTextStyles.bodyMedium,
              decoration: InputDecoration(
                labelText: context.l10n.pawHubAddLocation,
                hintText: context.l10n.pawhubComposerLocationFieldHint,
                hintStyle: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textTertiary),
                isDense: true,
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// White rounded section card used to group the composer's blocks, matching
/// the mockup's card-per-section layout on a warm background.
class _CompositionCard extends StatelessWidget {
  const _CompositionCard({
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.color = AppColors.surface,
    this.border = true,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final bool border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppRadius.mdAll,
        border:
            border ? Border.all(color: AppColors.divider) : null,
      ),
      child: child,
    );
  }
}

/// Inset divider between rows inside the options card.
class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) => const Divider(
        height: 1,
        thickness: 1,
        indent: AppSpacing.lg,
        endIndent: AppSpacing.lg,
        color: AppColors.divider,
      );
}

/// The solid-orange pill "Share" action in the app bar.
class _ShareButton extends StatelessWidget {
  const _ShareButton({required this.publishing, required this.onPressed});

  final bool publishing;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl, vertical: AppSpacing.sm),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      onPressed: onPressed,
      child: publishing
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: Colors.white),
            )
          : Text(context.l10n.pawHubShare,
              style: AppTextStyles.titleSmall
                  .copyWith(color: AppColors.onPrimary)),
    );
  }
}

class _AddMediaTile extends StatelessWidget {
  const _AddMediaTile({required this.onTap, this.disabled = false});
  final VoidCallback? onTap;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: Material(
        color: AppColors.primarySoft,
        borderRadius: AppRadius.mdAll,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.mdAll,
          child: CustomPaint(
            painter: _DashedBorderPainter(
              color: AppColors.primary.withValues(alpha: 0.55),
              radius: AppRadius.md,
            ),
            child: SizedBox(
              width: 120,
              height: 132,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(FluentIcons.add_24_filled,
                        color: AppColors.onPrimary, size: 24),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(context.l10n.pawhubComposerAddMedia,
                      style: AppTextStyles.labelMedium
                          .copyWith(color: AppColors.primaryDark)),
                  const SizedBox(height: 2),
                  Text(context.l10n.pawhubComposerMediaLimit,
                      style: AppTextStyles.labelSmall
                          .copyWith(color: AppColors.textSecondary)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Paints a rounded-rectangle dashed border (Flutter has no built-in one),
/// used by the "Add media" tile to match the mockup.
class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);

    const dashWidth = 6.0;
    const dashGap = 4.0;
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) =>
      old.color != color || old.radius != radius;
}

/// A large, tappable source option (Camera / Gallery) for the add-media sheet.
class _MediaSourceCard extends StatelessWidget {
  const _MediaSourceCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.accent,
    required this.accentSoft,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final Color accent;
  final Color accentSoft;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      borderRadius: AppRadius.lgAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.lgAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.lg, horizontal: AppSpacing.md),
          child: Column(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: accentSoft,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: accent, size: 26),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(label, style: AppTextStyles.titleSmall),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTextStyles.labelSmall
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MediaThumb extends StatelessWidget {
  const _MediaThumb({
    required this.media,
    required this.isCover,
    required this.onRemove,
    this.onPickCover,
  });

  final PawMedia media;
  final bool isCover;
  final VoidCallback onRemove;

  /// Videos only: opens the cover-image picker. Null for images.
  final VoidCallback? onPickCover;

  @override
  Widget build(BuildContext context) {
    final isLocalFile = media.url.startsWith('/');
    return Stack(
      children: [
        ClipRRect(
          borderRadius: AppRadius.mdAll,
          child: media.isVideo
              ? _videoThumb(isLocalFile)
              : isLocalFile
                  ? Image.file(
                      File(media.url),
                      width: 120,
                      height: 132,
                      fit: BoxFit.cover,
                    )
                  : AppCachedImage(
                      imageUrl: media.url,
                      width: 120,
                      height: 132,
                    ),
        ),
        if (isCover)
          PositionedDirectional(
            bottom: 4,
            start: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(context.l10n.pawhubComposerCoverBadge,
                  style: const TextStyle(color: Colors.white, fontSize: 10)),
            ),
          ),
        PositionedDirectional(
          top: 2,
          end: 2,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(3),
              child: const Icon(FluentIcons.dismiss_16_filled,
                  size: 14, color: Colors.white),
            ),
          ),
        ),
        // Videos: a "set/change cover" pill along the bottom.
        if (onPickCover != null)
          PositionedDirectional(
            bottom: 4,
            start: 4,
            end: 4,
            child: Semantics(
              button: true,
              label: context.l10n.pawhubComposerSetCover,
              child: GestureDetector(
                onTap: onPickCover,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        media.localCoverPath == null
                            ? FluentIcons.image_add_24_regular
                            : FluentIcons.image_edit_24_regular,
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        media.localCoverPath == null
                            ? context.l10n.pawhubComposerSetCover
                            : context.l10n.pawhubComposerChangeCover,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Placeholder tile for a picked video — dark background with play badge
  /// overlay. Prefers the user-chosen cover image; otherwise falls back to the
  /// raw video file's first frame (best-effort).
  Widget _videoThumb(bool isLocalFile) {
    final cover = media.localCoverPath;
    return Container(
      width: 120,
      height: 132,
      color: AppColors.textPrimary,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (cover != null)
            Positioned.fill(
              child: Image.file(
                File(cover),
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const SizedBox.shrink(),
              ),
            )
          else if (isLocalFile)
            Positioned.fill(
              child: Image.file(
                File(media.url),
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const SizedBox.shrink(),
              ),
            ),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.55),
              shape: BoxShape.circle,
            ),
            child: const Icon(FluentIcons.play_24_filled,
                color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }
}

