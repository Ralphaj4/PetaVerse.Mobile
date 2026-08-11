import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../models/pawhub_models.dart';

/// Arguments for [TagPetsPage], passed via GoRouter `extra`.
class TagPetsArgs {
  const TagPetsArgs({required this.candidates, required this.selected});

  /// The pets the user can tag from their own account.
  final List<PawPet> candidates;

  /// Pets already tagged (pre-checked on entry).
  final List<PawPet> selected;
}

/// Full-screen "Tag pets" picker.
///
/// Two ways to tag a pet:
///  1. Search by a pet's unique identifier (backend endpoint not implemented
///     yet — the field is wired to a stubbed lookup that returns nothing and
///     shows a "coming soon" state).
///  2. Pick from your own pets in the list below.
///
/// Returns the selected `List<PawPet>` via [context.pop]; returns null if the
/// user backs out without confirming.
class TagPetsPage extends StatefulWidget {
  const TagPetsPage({required this.args, super.key});

  final TagPetsArgs args;

  @override
  State<TagPetsPage> createState() => _TagPetsPageState();
}

class _TagPetsPageState extends State<TagPetsPage> {
  final _searchController = TextEditingController();

  /// Backend-id set of the currently-selected pets. Using [PawPet.id] (stable
  /// string id) keeps parity with how the composer tracked selection.
  late final Set<String> _selectedIds =
      widget.args.selected.map((p) => p.id).toSet();

  /// Selected pets keyed by id, so a pet tagged via search (not in [candidates])
  /// can still be rendered as a chip and returned. Seeded with the pre-selected
  /// pets and any candidates the user picks.
  late final Map<String, PawPet> _selectedById = {
    for (final p in widget.args.selected) p.id: p,
  };

  /// The live identifier query. Drives the (currently stubbed) search results.
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(
      () => setState(() => _query = _searchController.text.trim()),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggle(PawPet pet) {
    setState(() {
      if (_selectedIds.remove(pet.id)) {
        _selectedById.remove(pet.id);
      } else {
        _selectedIds.add(pet.id);
        _selectedById[pet.id] = pet;
      }
    });
  }

  void _remove(String id) {
    setState(() {
      _selectedIds.remove(id);
      _selectedById.remove(id);
    });
  }

  void _done() {
    context.pop<List<PawPet>>(_selectedById.values.toList());
  }

  @override
  Widget build(BuildContext context) {
    final candidates = widget.args.candidates;
    final selected = _selectedById.values.toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundWarm,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWarm,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(FluentIcons.arrow_left_24_regular,
              color: AppColors.textPrimary),
        ),
        title: Text('Tag pets', style: AppTextStyles.titleLarge),
        actions: [
          TextButton(
            onPressed: _done,
            child: Text(
              'Done',
              style: AppTextStyles.titleSmall
                  .copyWith(color: AppColors.primaryDark),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Identifier search field.
          _searchField(),
          const SizedBox(height: AppSpacing.md),

          // Search results (stubbed until the lookup endpoint exists).
          if (_query.isNotEmpty) ...[
            _searchResultsPlaceholder(),
            const SizedBox(height: AppSpacing.md),
          ],

          // Currently-tagged chips.
          if (selected.isNotEmpty) ...[
            Text('Tagged (${selected.length})',
                style: AppTextStyles.labelMedium
                    .copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final pet in selected)
                  _SelectedChip(pet: pet, onRemove: () => _remove(pet.id)),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
          ],

          // My pets list.
          Text('My pets', style: AppTextStyles.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          if (candidates.isEmpty)
            _emptyMyPets()
          else
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: AppRadius.mdAll,
                border: Border.all(color: AppColors.divider),
              ),
              child: ClipRRect(
                borderRadius: AppRadius.mdAll,
                child: Column(
                  children: [
                    for (var i = 0; i < candidates.length; i++) ...[
                      if (i > 0)
                        const Divider(
                          height: 1,
                          thickness: 1,
                          indent: AppSpacing.lg,
                          endIndent: AppSpacing.lg,
                          color: AppColors.divider,
                        ),
                      _PetRow(
                        pet: candidates[i],
                        selected: _selectedIds.contains(candidates[i].id),
                        onTap: () => _toggle(candidates[i]),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _searchField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.divider),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          const Icon(FluentIcons.search_24_regular,
              size: 22, color: AppColors.textSecondary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              style: AppTextStyles.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Search by pet ID…',
                hintStyle: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textTertiary),
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: AppSpacing.md),
              ),
            ),
          ),
          if (_query.isNotEmpty)
            IconButton(
              onPressed: _searchController.clear,
              icon: const Icon(FluentIcons.dismiss_circle_24_filled,
                  size: 20, color: AppColors.textTertiary),
              splashRadius: 18,
            ),
        ],
      ),
    );
  }

  /// Placeholder for the not-yet-built identifier lookup. Keeps the flow
  /// discoverable so it's obvious where results will land once the backend
  /// endpoint exists.
  Widget _searchResultsPlaceholder() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          const Icon(FluentIcons.search_info_24_regular,
              size: 28, color: AppColors.textTertiary),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Search by pet ID is coming soon',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            'You\'ll be able to find any pet by its unique identifier here.',
            style: AppTextStyles.bodySmall
                .copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _emptyMyPets() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(
        'You have no pets to tag yet.',
        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// A single selectable pet row (avatar + name/breed + check).
class _PetRow extends StatelessWidget {
  const _PetRow({
    required this.pet,
    required this.selected,
    required this.onTap,
  });

  final PawPet pet;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.md),
        child: Row(
          children: [
            AppAvatar(name: pet.name, imageUrl: pet.avatarUrl, radius: 22),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pet.name, style: AppTextStyles.bodyMedium),
                  if (pet.breedOrSpecies.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      pet.breedOrSpecies,
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            _CheckDot(selected: selected),
          ],
        ),
      ),
    );
  }
}

/// A circular check indicator — filled teal when selected, hollow otherwise.
class _CheckDot extends StatelessWidget {
  const _CheckDot({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: selected ? AppColors.secondary : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? AppColors.secondary : AppColors.divider,
          width: 1.5,
        ),
      ),
      child: selected
          ? const Icon(FluentIcons.checkmark_16_filled,
              size: 15, color: AppColors.onSecondary)
          : null,
    );
  }
}

/// A removable chip for a tagged pet, shown above the list.
class _SelectedChip extends StatelessWidget {
  const _SelectedChip({required this.pet, required this.onRemove});

  final PawPet pet;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.secondarySoft,
      borderRadius: BorderRadius.circular(50),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 4, AppSpacing.xs, 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppAvatar(name: pet.name, imageUrl: pet.avatarUrl, radius: 12),
            const SizedBox(width: AppSpacing.xs),
            Text(
              pet.name,
              style: AppTextStyles.labelMedium
                  .copyWith(color: AppColors.secondaryDark),
            ),
            const SizedBox(width: 2),
            InkWell(
              onTap: onRemove,
              customBorder: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(2),
                child: Icon(FluentIcons.dismiss_16_filled,
                    size: 14, color: AppColors.secondaryDark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
