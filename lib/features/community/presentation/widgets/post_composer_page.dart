import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../models/pawhub_models.dart';
import 'pawhub_common.dart';
import 'pawhub_sheets.dart';

/// Full-screen post composer. Prototype: the "media picker" adds stock images
/// (no real gallery), but everything else — pet switcher, caption, hashtags,
/// tagged pets, location, visibility, alt text, publish — is interactive and
/// returns a fully-formed [PawPost] to the feed.
class PostComposerPage extends StatefulWidget {
  const PostComposerPage({
    required this.myPets,
    required this.actingAs,
    required this.taggablePets,
    super.key,
  });

  final List<PawPet> myPets;
  final PawPet actingAs;
  final List<PawPet> taggablePets;

  @override
  State<PostComposerPage> createState() => _PostComposerPageState();
}

class _PostComposerPageState extends State<PostComposerPage> {
  late PawPet _actingAs = widget.actingAs;
  final _caption = TextEditingController();
  final List<PawMedia> _media = [];
  final List<PawPet> _tagged = [];
  PostVisibility _visibility = PostVisibility.public;
  String? _location;
  bool _publishing = false;

  int _stockSeed = 0;

  @override
  void dispose() {
    _caption.dispose();
    super.dispose();
  }

  // Prototype media picker: appends a stable stock image.
  void _addMedia() {
    setState(() {
      _stockSeed++;
      _media.add(PawMedia(
        url: 'https://picsum.photos/seed/compose_${_stockSeed}_'
            '${DateTime.now().second}/900/1100',
        altText: '',
      ));
    });
  }

  Future<void> _switchPet() async {
    final chosen = await showPetSwitcherSheet(
      context,
      pets: widget.myPets,
      current: _actingAs,
      title: 'Posting as',
    );
    if (chosen != null) setState(() => _actingAs = chosen);
  }

  Future<void> _pickVisibility() async {
    final v = await showVisibilitySheet(context, current: _visibility);
    if (v != null) setState(() => _visibility = v);
  }

  Future<void> _pickTags() async {
    final result = await showModalBottomSheet<List<PawPet>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (_) => _TagPetsSheet(
        candidates: widget.taggablePets,
        selected: _tagged,
      ),
    );
    if (result != null) {
      setState(() => _tagged
        ..clear()
        ..addAll(result));
    }
  }

  void _editLocation() async {
    // Prototype: cycle a couple of sample locations rather than open the map.
    const samples = [
      'Beirut, Lebanon',
      'Achrafieh',
      'Ramlet al-Baida',
      null,
    ];
    final next =
        samples[(samples.indexOf(_location) + 1) % samples.length];
    setState(() => _location = next);
  }

  Future<void> _publish() async {
    if (_media.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Add at least one photo')));
      return;
    }
    setState(() => _publishing = true);
    // Simulate the upload pipeline.
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;

    final caption = _caption.text.trim();
    final hashtags = RegExp(r'#(\w+)')
        .allMatches(caption)
        .map((m) => m.group(1)!)
        .toList();
    final post = PawPost(
      id: 'composed_${DateTime.now().microsecondsSinceEpoch}',
      author: _actingAs,
      media: _media,
      caption: caption.replaceAll(RegExp(r'#\w+'), '').trim(),
      timeAgo: 'now',
      hashtags: hashtags,
      taggedPets: _tagged,
      locationName: _location,
      visibility: _visibility,
    );
    unawaited(HapticFeedback.mediumImpact());
    Navigator.of(context).pop(post);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(FluentIcons.dismiss_24_regular,
              color: AppColors.textPrimary),
        ),
        title: Text('New post', style: AppTextStyles.titleLarge),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: FilledButton(
              onPressed: _publishing ? null : _publish,
              child: _publishing
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('Share'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Posting-as pill.
          Row(
            children: [
              PetSwitcherPill(
                pet: _actingAs,
                prefix: 'Posting as',
                onTap: _switchPet,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Media strip.
          _mediaStrip(),
          const SizedBox(height: AppSpacing.lg),

          // Caption.
          TextField(
            controller: _caption,
            minLines: 3,
            maxLines: 8,
            maxLength: 2200,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              hintText: 'Write a caption… add #hashtags and @mentions',
              border: InputBorder.none,
              counterText: '',
            ),
          ),
          const Divider(color: AppColors.divider),

          _optionRow(
            icon: FluentIcons.tag_24_regular,
            label: 'Tag pets',
            value: _tagged.isEmpty
                ? null
                : _tagged.map((p) => p.name).join(', '),
            onTap: _pickTags,
          ),
          _optionRow(
            icon: FluentIcons.location_24_regular,
            label: 'Add location',
            value: _location,
            onTap: _editLocation,
          ),
          _optionRow(
            icon: FluentIcons.eye_24_regular,
            label: 'Visibility',
            value: _visibility.label,
            onTap: _pickVisibility,
          ),
        ],
      ),
    );
  }

  Widget _mediaStrip() {
    return SizedBox(
      height: 104,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _media.length + 1,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (_, i) {
          if (i == _media.length) {
            return _AddMediaTile(onTap: _addMedia);
          }
          return _MediaThumb(
            media: _media[i],
            isCover: i == 0,
            onRemove: () => setState(() => _media.removeAt(i)),
          );
        },
      ),
    );
  }

  Widget _optionRow({
    required IconData icon,
    required String label,
    required String? value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.textSecondary),
            const SizedBox(width: AppSpacing.md),
            Text(label, style: AppTextStyles.bodyMedium),
            const Spacer(),
            if (value != null)
              Flexible(
                child: Text(
                  value,
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textSecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
}

class _AddMediaTile extends StatelessWidget {
  const _AddMediaTile({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 104,
        height: 104,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.mdAll,
          border: Border.all(color: AppColors.divider),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(FluentIcons.image_add_24_regular,
                color: AppColors.primary, size: 26),
            SizedBox(height: 4),
            Text('Add', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ],
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
  });

  final PawMedia media;
  final bool isCover;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: AppRadius.mdAll,
          child: AppCachedImage(
            imageUrl: media.url,
            width: 104,
            height: 104,
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
              child: const Text('Cover',
                  style: TextStyle(color: Colors.white, fontSize: 10)),
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
      ],
    );
  }
}

class _TagPetsSheet extends StatefulWidget {
  const _TagPetsSheet({required this.candidates, required this.selected});

  final List<PawPet> candidates;
  final List<PawPet> selected;

  @override
  State<_TagPetsSheet> createState() => _TagPetsSheetState();
}

class _TagPetsSheetState extends State<_TagPetsSheet> {
  late final Set<String> _sel = widget.selected.map((p) => p.id).toSet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Tag pets', style: AppTextStyles.titleMedium),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.pop(
                    context,
                    widget.candidates
                        .where((p) => _sel.contains(p.id))
                        .toList(),
                  ),
                  child: const Text('Done'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ...widget.candidates.map((p) {
              final on = _sel.contains(p.id);
              return CheckboxListTile(
                value: on,
                onChanged: (_) => setState(() =>
                    on ? _sel.remove(p.id) : _sel.add(p.id)),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.trailing,
                title: Row(
                  children: [
                    AppAvatar(name: p.name, imageUrl: p.avatarUrl, radius: 18),
                    const SizedBox(width: AppSpacing.md),
                    Text(p.name, style: AppTextStyles.bodyMedium),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
