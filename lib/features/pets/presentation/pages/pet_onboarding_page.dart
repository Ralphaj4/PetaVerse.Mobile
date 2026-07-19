import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/providers/session_provider.dart';
import '../../../co_ownership/presentation/providers/co_ownership_providers.dart';
import '../../../profile/presentation/providers/user_provider.dart';
import '../providers/pets_provider.dart';

/// First-run pet setup: shown after auth when the user has no pet.
///
/// Besides the create-a-pet prompt, this is the pre-gate escape hatch for a
/// user who owns no pet but has been invited to co-own one: it surfaces their
/// shareable profile tag (so they can be invited) and, when they have pending
/// invitations, a shortcut into the invitations page. Logout is always
/// available so a user is never stranded here.
class PetOnboardingPage extends ConsumerWidget {
  const PetOnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pets = ref.watch(petsProvider);

    final Widget body;
    if (!pets.ready) {
      body = _Loading(message: context.l10n.petOnboardingLoading);
    } else if (pets.unresolvedEmpty) {
      // Offline + empty cache: we can't be sure the user has no pet, so we
      // offer a retry rather than letting them create a (possibly duplicate).
      body = ErrorStateWidget(
        failure: pets.failure,
        onRetry: () => ref.read(petsProvider.notifier).retry(),
      );
    } else {
      body = const _AddFirstPet();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: body),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: AppSpacing.lg),
          Text(
            message,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _AddFirstPet extends ConsumerStatefulWidget {
  const _AddFirstPet();

  @override
  ConsumerState<_AddFirstPet> createState() => _AddFirstPetState();
}

class _AddFirstPetState extends ConsumerState<_AddFirstPet> {
  @override
  void initState() {
    super.initState();
    // Refresh incoming invites when landing here so a request that arrived
    // after login shows up (the /me pending-count is warmed at login and can
    // be stale). incomingInvitesProvider is the authoritative source.
    Future.microtask(
      () => ref.invalidate(incomingInvitesProvider),
    );
  }

  Future<void> _logout() async {
    // Same sequence as the profile page: flip the session gate first (router
    // sends to /login synchronously), then await the durable local clears.
    final authNotifier = ref.read(authProvider.notifier);
    final sessionNotifier = ref.read(sessionProvider.notifier);
    sessionNotifier.setLoggedIn(false);
    await authNotifier.logout();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final width = MediaQuery.sizeOf(context).width;
    final artSize = width * 0.5;

    final tag = ref.watch(userProvider).value?.userCode;
    // Live count from the real endpoint (not the stale /me warm-up count).
    final pendingInvites =
        ref.watch(incomingInvitesProvider).value?.length ?? 0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Scrollable content fills the space above the pinned CTAs.
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: AppSpacing.lg),
                  // ── illustration on a soft organic blob ──────────────
                  SizedBox(
                    width: artSize,
                    height: artSize,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: artSize * 0.92,
                          height: artSize * 0.82,
                          decoration: const BoxDecoration(
                            color: AppColors.primarySoft,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(150),
                              topRight: Radius.circular(130),
                              bottomLeft: Radius.circular(120),
                              bottomRight: Radius.circular(160),
                            ),
                          ),
                        ),
                        Lottie.asset(
                          'assets/lotties/owner_dog.json',
                          width: artSize,
                          height: artSize,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // ── sparkle accent + two-tone headline ───────────────
                  const Icon(
                    FluentIcons.sparkle_20_filled,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${l10n.petOnboardingTitleTop}\n',
                          style: AppTextStyles.displayLarge.copyWith(
                            fontSize: 30,
                            height: 1.15,
                          ),
                        ),
                        TextSpan(
                          text: l10n.petOnboardingTitleAccent,
                          style: AppTextStyles.displayLarge.copyWith(
                            fontSize: 30,
                            height: 1.15,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    l10n.petOnboardingSubtitle,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // ── adopt escape hatch ───────────────────────────────
                  // A pet-less first-timer's most common intent: get a pet by
                  // adopting one — so it leads over the co-own section.
                  _AdoptPill(
                    onTap: () => context.push(AppRoutes.adoptionBoard),
                  ),

                  // ── animated co-own section ──────────────────────────
                  if (tag != null && tag.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.md),
                    _CoOwnSection(
                      tag: tag,
                      pendingInvites: pendingInvites,
                      onViewInvites: () =>
                          context.push(AppRoutes.coOwnerInvitations),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // ── primary CTA pinned at the bottom ─────────────────────────
          const SizedBox(height: AppSpacing.md),
          AppButton(
            label: l10n.petOnboardingAction,
            icon: FluentIcons.add_24_regular,
            variant: AppButtonVariant.primary,
            // Push (not go) so the create-pet form stacks over onboarding and
            // its back button returns here. On success the form advances to the
            // avatar-setup step, which commits the pet to the gate.
            onPressed: () => context.push(AppRoutes.createPet),
          ),
          const SizedBox(height: AppSpacing.sm),
          // ── logout under the primary CTA ─────────────────────────────
          TextButton.icon(
            onPressed: _logout,
            icon: const Icon(FluentIcons.sign_out_24_regular, size: 18),
            label: Text(l10n.logOut),
            style:
                TextButton.styleFrom(foregroundColor: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

/// Collapsible co-own section: a small tappable pill that animates open into
/// the full card (profile tag + copy, and a pending-invites shortcut). Auto-
/// expands when there are pending invitations so the user notices them.
class _CoOwnSection extends StatefulWidget {
  const _CoOwnSection({
    required this.tag,
    required this.pendingInvites,
    required this.onViewInvites,
  });

  final String tag;
  final int pendingInvites;
  final VoidCallback onViewInvites;

  @override
  State<_CoOwnSection> createState() => _CoOwnSectionState();
}

class _CoOwnSectionState extends State<_CoOwnSection> {
  bool _expanded = false;

  @override
  void didUpdateWidget(_CoOwnSection old) {
    super.didUpdateWidget(old);
    // If invitations arrive, open the section so the badge/action is visible.
    if (widget.pendingInvites > 0 && old.pendingInvites == 0 && !_expanded) {
      setState(() => _expanded = true);
    }
  }

  Future<void> _copyTag() async {
    await Clipboard.setData(ClipboardData(text: widget.tag));
    if (mounted) context.showSuccessSnackBar(context.l10n.profileTagCopied);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: _expanded
          ? _ExpandedCard(
              tag: widget.tag,
              pendingInvites: widget.pendingInvites,
              onCopy: _copyTag,
              onCollapse: () => setState(() => _expanded = false),
              onViewInvites: widget.onViewInvites,
            )
          : _CollapsedPill(
              pendingInvites: widget.pendingInvites,
              onTap: () => setState(() => _expanded = true),
            ),
    );
  }
}

/// The small collapsed state: a pill with a people icon, a prompt, an optional
/// count badge, and a chevron.
class _CollapsedPill extends StatelessWidget {
  const _CollapsedPill({required this.pendingInvites, required this.onTap});

  final int pendingInvites;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Material(
      color: AppColors.secondarySoft,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(FluentIcons.people_team_24_filled,
                  size: 18, color: AppColors.secondaryDark),
              const SizedBox(width: AppSpacing.sm),
              Text(
                l10n.onboardingCoOwnTitle,
                style: AppTextStyles.labelLarge
                    .copyWith(color: AppColors.secondaryDark),
              ),
              if (pendingInvites > 0) ...[
                const SizedBox(width: AppSpacing.sm),
                _CountBadge(count: pendingInvites),
              ],
              const SizedBox(width: AppSpacing.xs),
              const Icon(FluentIcons.chevron_down_24_regular,
                  size: 18, color: AppColors.secondaryDark),
            ],
          ),
        ),
      ),
    );
  }
}

/// The expanded card: title + close, body copy, copyable tag, and (when there
/// are pending invites) a "View invitations" action.
class _ExpandedCard extends StatelessWidget {
  const _ExpandedCard({
    required this.tag,
    required this.pendingInvites,
    required this.onCopy,
    required this.onCollapse,
    required this.onViewInvites,
  });

  final String tag;
  final int pendingInvites;
  final VoidCallback onCopy;
  final VoidCallback onCollapse;
  final VoidCallback onViewInvites;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.secondarySoft,
        borderRadius: AppRadius.lgAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(FluentIcons.people_team_24_filled,
                  size: 18, color: AppColors.secondaryDark),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  l10n.onboardingCoOwnTitle,
                  style: AppTextStyles.titleSmall
                      .copyWith(color: AppColors.secondaryDark),
                ),
              ),
              InkWell(
                onTap: onCollapse,
                customBorder: const CircleBorder(),
                child: const Padding(
                  padding: EdgeInsets.all(2),
                  child: Icon(FluentIcons.chevron_up_24_regular,
                      size: 18, color: AppColors.secondaryDark),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.onboardingCoOwnBody,
            style:
                AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.md),
          // Copyable tag pill.
          Material(
            color: AppColors.surface,
            borderRadius: AppRadius.mdAll,
            child: InkWell(
              onTap: onCopy,
              borderRadius: AppRadius.mdAll,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.md,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '#$tag',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const Icon(FluentIcons.copy_24_regular,
                        size: 18, color: AppColors.secondaryDark),
                  ],
                ),
              ),
            ),
          ),
          // Pending-invites shortcut, only when there are any.
          if (pendingInvites > 0) ...[
            const SizedBox(height: AppSpacing.md),
            _ViewInvitesButton(
              count: pendingInvites,
              onTap: onViewInvites,
            ),
          ],
        ],
      ),
    );
  }
}

/// Full-width "View invitations (N)" action shown inside the expanded card.
class _ViewInvitesButton extends StatelessWidget {
  const _ViewInvitesButton({required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.secondary,
      borderRadius: AppRadius.mdAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.mdAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(FluentIcons.mail_24_filled,
                  size: 18, color: AppColors.onSecondary),
              const SizedBox(width: AppSpacing.sm),
              Text(
                context.l10n.onboardingViewInvitesCount(count),
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.onSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Quiet pill inviting a pet-less user to browse the adoption board. Styled in
/// the soft brand-orange to sit as a peer of the (teal) co-own section without
/// competing with the primary "Add my pet" CTA.
class _AdoptPill extends StatelessWidget {
  const _AdoptPill({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Material(
      color: AppColors.primarySoft,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(FluentIcons.heart_24_filled,
                  size: 18, color: AppColors.primaryDark),
              const SizedBox(width: AppSpacing.sm),
              Text(
                l10n.onboardingAdoptPrompt,
                style: AppTextStyles.labelLarge
                    .copyWith(color: AppColors.primaryDark),
              ),
              const SizedBox(width: AppSpacing.xs),
              const Icon(FluentIcons.chevron_right_24_regular,
                  size: 18, color: AppColors.primaryDark),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small circular count badge.
class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 20),
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        '$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
