import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../models/pawhub_models.dart';
import 'pawhub_common.dart';
import 'pawhub_feed_widgets.dart';

/// A pet profile surfaced as a modal sheet from the feed. Shows the header
/// (avatar, name, breed, bio, owner attribution), a stats row, a follow/manage
/// action, and a posts grid. Demonstrates the account → pets relationship via
/// the "siblings" strip.
class PetProfileSheet extends StatefulWidget {
  const PetProfileSheet({
    required this.pet,
    required this.postThumbnails,
    this.siblings = const [],
    super.key,
  });

  final PawPet pet;
  final List<String> postThumbnails;
  final List<PawPet> siblings;

  @override
  State<PetProfileSheet> createState() => _PetProfileSheetState();
}

class _PetProfileSheetState extends State<PetProfileSheet> {
  late bool _following = widget.pet.isFollowing;

  void _toggleFollow() {
    setState(() {
      _following = !_following;
      widget.pet.isFollowing = _following;
      widget.pet.followers += _following ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pet = widget.pet;
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
        ),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(child: _handle()),
            SliverToBoxAdapter(child: _header(pet)),
            SliverToBoxAdapter(child: _stats(pet)),
            SliverToBoxAdapter(child: _action(pet)),
            if (widget.siblings.isNotEmpty)
              SliverToBoxAdapter(child: _siblings()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.sm),
                child: Row(
                  children: [
                    const Icon(FluentIcons.grid_24_regular,
                        size: 18, color: AppColors.textSecondary),
                    const SizedBox(width: AppSpacing.sm),
                    Text('Posts', style: AppTextStyles.titleSmall),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.xl),
              sliver: SliverGrid(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                ),
                delegate: SliverChildBuilderDelegate(
                  (_, i) => ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: AppCachedImage(
                      imageUrl: widget.postThumbnails[i],
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  childCount: widget.postThumbnails.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _handle() => Center(
        child: Container(
          width: 40,
          height: 4,
          margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.divider,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      );

  Widget _header(PawPet pet) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        children: [
          AppAvatar(name: pet.name, imageUrl: pet.avatarUrl, radius: 44),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(pet.name, style: AppTextStyles.headlineMedium),
              if (pet.isVerified) ...[
                const SizedBox(width: AppSpacing.xs),
                const VerifiedBadge(size: 18),
              ],
            ],
          ),
          Text(pet.breedOrSpecies,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary)),
          if (pet.bio.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(pet.bio,
                style: AppTextStyles.bodyMedium, textAlign: TextAlign.center),
          ],
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(FluentIcons.person_24_regular,
                  size: 14, color: AppColors.textTertiary),
              const SizedBox(width: 4),
              Text('cared for by ${pet.ownerName}',
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.textTertiary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stats(PawPet pet) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, vertical: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _stat('${widget.postThumbnails.length}', 'Posts'),
          _stat(_compact(pet.followers), 'Followers'),
          _stat(_compact((pet.followers * 0.4).round()), 'Following'),
        ],
      ),
    );
  }

  Widget _stat(String value, String label) => Column(
        children: [
          Text(value, style: AppTextStyles.titleMedium),
          Text(label,
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textSecondary)),
        ],
      );

  Widget _action(PawPet pet) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: pet.isMine
          ? SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(FluentIcons.settings_24_regular, size: 18),
                label: const Text('Manage pet'),
              ),
            )
          : FollowButton(
              following: _following,
              onTap: _toggleFollow,
              expanded: true,
            ),
    );
  }

  Widget _siblings() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${widget.pet.name}'s siblings",
              style: AppTextStyles.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 64,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.siblings.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
              itemBuilder: (_, i) => Column(
                children: [
                  AppAvatar(
                    name: widget.siblings[i].name,
                    imageUrl: widget.siblings[i].avatarUrl,
                    radius: 20,
                  ),
                  const SizedBox(height: 4),
                  Text(widget.siblings[i].name,
                      style: AppTextStyles.labelSmall),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _compact(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return '$n';
  }
}
