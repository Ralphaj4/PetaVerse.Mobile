import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../pets/presentation/providers/pets_provider.dart';

/// Segmented "For [Pet] / All" pill that toggles species tailoring. Shown only
/// when the user has an active pet. When [tailoring] is on, the search filters
/// to providers that serve the active pet's species (plus species-agnostic
/// ones); "All" clears the species filter.
class ProviderPetToggle extends ConsumerWidget {
  const ProviderPetToggle({
    required this.tailoring,
    required this.onChanged,
    super.key,
  });

  final bool tailoring;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petName = ref.watch(petsProvider).currentPet?.name;
    final forLabel = petName == null
        ? context.l10n.providerForMyPet
        : context.l10n.providerForPet(petName);

    return Center(
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        elevation: 3,
        shadowColor: AppColors.textPrimary.withValues(alpha: 0.25),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Segment(
                icon: FluentIcons.animal_paw_print_24_filled,
                label: forLabel,
                selected: tailoring,
                onTap: tailoring ? null : onChanged,
              ),
              _Segment(
                label: context.l10n.providerForAll,
                selected: !tailoring,
                onTap: tailoring ? onChanged : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: selected ? AppColors.secondary : Colors.transparent,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 15,
                  color: selected ? AppColors.onSecondary : AppColors.secondary,
                ),
                const SizedBox(width: 5),
              ],
              Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(
                  color:
                      selected ? AppColors.onSecondary : AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
