import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../domain/entities/community_enums.dart';
import '../models/pawhub_models.dart';
import '../providers/community_providers.dart';

/// Arguments for [TagPetsPage], passed via GoRouter `extra`.
class TagPetsArgs {
  const TagPetsArgs({
    required this.candidates,
    required this.selected,
    this.excludePetId,
  });

  /// The user's own pets, shown as the default list before searching.
  final List<PawPet> candidates;

  /// Pets already tagged (pre-checked on entry).
  final List<PawPet> selected;

  /// A pet id to exclude from results (the post's author — you can't tag the
  /// pet that's creating the post). Null when there's nothing to exclude.
  final int? excludePetId;
}

/// Full-screen "Tag pets" picker.
///
/// Empty query → shows the user's own pets. Typing searches ALL pets via the
/// community pet-search endpoint (debounced), so any pet can be tagged. Tap a
/// row to toggle; selected pets appear as removable chips above the list.
///
/// Returns the selected `List<PawPet>` via [context.pop]; returns null if the
/// user backs out without confirming.
class TagPetsPage extends ConsumerStatefulWidget {
  const TagPetsPage({required this.args, super.key});

  final TagPetsArgs args;

  @override
  ConsumerState<TagPetsPage> createState() => _TagPetsPageState();
}

class _TagPetsPageState extends ConsumerState<TagPetsPage> {
  final _searchController = TextEditingController();
  Timer? _debounce;

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

  /// The active (debounced) search query.
  String _query = '';

  /// Remote pet-search state for the current [_query].
  bool _searching = false;
  List<PawPet> _results = const [];
  // Guards against a stale in-flight search overwriting a newer one.
  int _searchSeq = 0;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onQueryChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.removeListener(_onQueryChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onQueryChanged() {
    final q = _searchController.text.trim();
    _debounce?.cancel();
    if (q == _query) return;
    setState(() => _query = q);
    if (q.isEmpty) {
      setState(() {
        _searching = false;
        _results = const [];
      });
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 300), () => _search(q));
  }

  Future<void> _search(String query) async {
    final seq = ++_searchSeq;
    setState(() => _searching = true);
    final result = await ref.read(communityRepositoryProvider).search(
          query: query,
          type: SearchType.pets,
          actingPetId: ref.read(actingPetIdProvider),
        );
    if (!mounted || seq != _searchSeq) return; // superseded
    result.when(
      success: (page) => setState(() {
        _searching = false;
        _results = page.results
            .where((r) => r.pet != null)
            .map((r) => PawPet.fromEntity(r.pet!))
            .where((p) => p.backendId != widget.args.excludePetId)
            .toList();
      }),
      failure: (_) => setState(() {
        _searching = false;
        _results = const [];
      }),
    );
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
    // Empty query → own pets; otherwise the remote search results.
    // Empty query → own pets; otherwise the (already-filtered) search results.
    // Either way, never offer the author pet (can't tag itself).
    final candidates = _query.isEmpty
        ? widget.args.candidates
            .where((p) => p.backendId != widget.args.excludePetId)
            .toList()
        : _results;
    final selected = _selectedById.values.toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundWarm,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWarm,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.popOrHome(),
          tooltip: context.l10n.pawhubBack,
          icon: const Icon(FluentIcons.arrow_left_24_regular,
              color: AppColors.textPrimary),
        ),
        title: Text(context.l10n.pawhubTagPetsTitle,
            style: AppTextStyles.titleLarge),
        actions: [
          TextButton(
            onPressed: _done,
            child: Text(
              context.l10n.pawHubDone,
              style: AppTextStyles.titleSmall
                  .copyWith(color: AppColors.primaryDark),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Name search field.
          _searchField(),
          const SizedBox(height: AppSpacing.md),

          // Currently-tagged chips.
          if (selected.isNotEmpty) ...[
            Text(context.l10n.pawhubTagPetsTaggedCount(selected.length),
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

          // Section header: "My pets" by default, "Results" while searching.
          Text(
            _query.isEmpty
                ? context.l10n.pawhubTagPetsMyPets
                : context.l10n.pawhubTagPetsResults,
            style: AppTextStyles.titleSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          if (_searching)
            const Padding(
              padding: EdgeInsets.all(AppSpacing.xl),
              child: Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else if (candidates.isEmpty)
            _emptyMyPets(noMatch: _query.isNotEmpty)
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
                hintText: context.l10n.pawhubTagPetsSearchHint,
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
              tooltip: context.l10n.clear,
              icon: const Icon(FluentIcons.dismiss_circle_24_filled,
                  size: 20, color: AppColors.textTertiary),
              splashRadius: 18,
            ),
        ],
      ),
    );
  }

  /// Empty state: either "no pets at all" or "no pets match your search".
  Widget _emptyMyPets({required bool noMatch}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(
        noMatch
            ? context.l10n.pawhubTagPetsNoMatch
            : context.l10n.pawhubTagPetsEmpty,
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
            Semantics(
              button: true,
              label: context.l10n.pawhubRemoveTag,
              child: InkWell(
                onTap: onRemove,
                customBorder: const CircleBorder(),
                child: const Padding(
                  padding: EdgeInsets.all(2),
                  child: Icon(FluentIcons.dismiss_16_filled,
                      size: 14, color: AppColors.secondaryDark),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
