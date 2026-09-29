import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../models/pawhub_models.dart';
import '../providers/community_actions_providers.dart';
import '../providers/community_feed_providers.dart';
import '../widgets/pawhub_sheets.dart';
import '../widgets/pet_profile_sheet.dart';

/// Pushes the full-page profile for [pet]. Shared by every surface that shows
/// a tappable pet (post cards on the feed, hashtag, saved, trending, post
/// detail, my-posts…) so tapping a pet always opens its profile by id.
void openPawHubPetProfile(BuildContext context, PawPet pet) {
  if (pet.backendId <= 0) return;
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => PawHubPetProfilePage(pet: pet, siblings: const []),
    ),
  );
}

/// Full-page pet profile view. Uses the profile sheet content in a scrollable page.
class PawHubPetProfilePage extends ConsumerStatefulWidget {
  const PawHubPetProfilePage({
    required this.pet,
    required this.siblings,
    super.key,
  });

  final PawPet pet;
  final List<PawPet> siblings;

  @override
  ConsumerState<PawHubPetProfilePage> createState() => _PawHubPetProfilePageState();
}

class _PawHubPetProfilePageState extends ConsumerState<PawHubPetProfilePage> {
  @override
  void initState() {
    super.initState();
    // Force a fresh fetch of the pet's posts and profile (authoritative follow
    // state) on open, so it's correct regardless of the entry point.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(petPostsProvider(widget.pet.backendId));
      ref.invalidate(petProfileProvider(widget.pet.backendId));
    });
  }

  Future<void> _reportPet() async {
    final reason = await showReportSheet(context);
    if (reason != null && mounted) {
      await ref.read(communityActionsProvider).reportPet(widget.pet.backendId, reason);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.pawHubPostReported)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          if (!widget.pet.isMine)
            IconButton(
              onPressed: _reportPet,
              icon: const Icon(FluentIcons.flag_24_regular,
                  color: AppColors.error),
            ),
        ],
      ),
      body: PetProfileSheet(
        pet: widget.pet,
        siblings: widget.siblings,
      ),
    );
  }
}
