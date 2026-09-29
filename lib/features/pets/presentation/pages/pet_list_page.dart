import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/pet_list_provider.dart';
import '../providers/pets_provider.dart';
import '../widgets/pet_card_grid.dart';

/// Full pet listing, pushed from the profile tab when the user has more than
/// 2 pets. Reads from [petListProvider] (already loaded) — no extra fetch.
class PetListPage extends ConsumerWidget {
  const PetListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final pets = ref.watch(petListProvider).value ?? const [];
    final currentPetId = ref.watch(petsProvider.select((s) => s.currentPetId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with back button.
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      context.isRtl
                          ? FluentIcons.chevron_right_24_regular
                          : FluentIcons.chevron_left_24_regular,
                      color: AppColors.textPrimary,
                    ),
                    onPressed: () => context.popOrHome(),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(l10n.petProfiles, style: AppTextStyles.headlineLarge),
                ],
              ),
            ),

            // Scrollable grid.
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.lg,
                  AppSpacing.xl,
                ),
                child: PetCardGrid(
                  pets: pets,
                  activePetId: currentPetId,
                  enableHero: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
