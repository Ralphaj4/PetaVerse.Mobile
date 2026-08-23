import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../domain/entities/poll_event_entities.dart';
import '../providers/community_providers.dart';
import '../providers/poll_event_actions_providers.dart';
import '../providers/poll_event_providers.dart';

/// An inline community poll card. Members tap an option to vote; results (bars +
/// counts) are always visible. Non-members and expired polls are read-only with
/// a "Join to vote" hint. Creator/lead can delete via the overflow.
class PollCard extends ConsumerStatefulWidget {
  const PollCard({
    required this.poll,
    required this.communityId,
    required this.canManage,
    required this.isMember,
    this.onDelete,
    super.key,
  });

  final Poll poll;
  final int communityId;

  /// Whether the acting pet can delete (creator or community lead).
  final bool canManage;

  /// Whether the acting pet is a member (may vote). Non-members see results
  /// with a "Join to vote" hint.
  final bool isMember;
  final VoidCallback? onDelete;

  @override
  ConsumerState<PollCard> createState() => _PollCardState();
}

class _PollCardState extends ConsumerState<PollCard> {
  bool _busy = false;

  Poll get _poll => widget.poll;

  Future<void> _vote(PollOption option) async {
    final l10n = context.l10n;
    final petId = ref.read(actingPetIdProvider);
    if (petId == null || !widget.isMember || _poll.isExpired || _busy) return;

    // Toggle logic: multi-select flips this option; single-select replaces.
    final List<int> optionIds;
    if (_poll.allowMultipleVotes) {
      final selected = _poll.options
          .where((o) => o.votedByMe)
          .map((o) => o.id)
          .toSet();
      if (option.votedByMe) {
        selected.remove(option.id);
      } else {
        selected.add(option.id);
      }
      optionIds = selected.toList();
    } else {
      optionIds = [option.id];
    }

    setState(() => _busy = true);
    // If a single-select re-tap on the same option, retract instead.
    final isRetract = !_poll.allowMultipleVotes &&
        _poll.hasVoted &&
        option.votedByMe &&
        _poll.options.where((o) => o.votedByMe).length == 1;

    final actions = ref.read(pollEventActionsProvider);
    final result = isRetract || optionIds.isEmpty
        ? await actions.retractVote(pollId: _poll.id, petId: petId)
        : await actions.vote(
            pollId: _poll.id, petId: petId, optionIds: optionIds);
    if (!mounted) return;
    setState(() => _busy = false);

    result.when(
      success: (updated) => ref
          .read(communityPollsProvider(widget.communityId).notifier)
          .replace(updated),
      failure: (f) => _snack(f.localizedMessage(l10n)),
    );
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final showResults = _poll.hasVoted || _poll.isExpired || !widget.isMember;
    final canVote = widget.isMember && !_poll.isExpired && !_busy;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.divider),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: creator + poll badge + overflow.
          Row(
            children: [
              AppAvatar(
                name: _poll.creator.name,
                imageUrl: _poll.creator.avatarUrl,
                radius: 18,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_poll.creator.name,
                        style: AppTextStyles.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    _MetaLine(poll: _poll),
                  ],
                ),
              ),
              const _TypeBadge(
                icon: FluentIcons.poll_24_filled,
                color: AppColors.secondary,
              ),
              if (widget.canManage)
                IconButton(
                  visualDensity: VisualDensity.compact,
                  tooltip: context.l10n.pawhubMoreOptions,
                  icon: const Icon(FluentIcons.more_horizontal_24_regular,
                      size: 20, color: AppColors.textTertiary),
                  onPressed: widget.onDelete,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Question + optional description.
          Text(_poll.title, style: AppTextStyles.titleMedium),
          if ((_poll.description ?? '').isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(_poll.description!,
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary)),
          ],
          const SizedBox(height: AppSpacing.md),
          // Options.
          for (final option in _poll.options) ...[
            _PollOptionRow(
              option: option,
              share: _poll.share(option),
              showResults: showResults,
              enabled: canVote,
              onTap: () => _vote(option),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          const SizedBox(height: AppSpacing.xs),
          // Footer: total votes + hint.
          Row(
            children: [
              Text(
                l10n.pollTotalVotes(_poll.totalVotes),
                style: AppTextStyles.labelMedium
                    .copyWith(color: AppColors.textSecondary),
              ),
              const Spacer(),
              _FooterHint(poll: _poll, isMember: widget.isMember),
            ],
          ),
        ],
      ),
    );
  }
}

/// The "created · closes/closed" meta line under the creator name.
class _MetaLine extends StatelessWidget {
  const _MetaLine({required this.poll});

  final Poll poll;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final String text;
    if (poll.isExpired) {
      text = l10n.pollClosed;
    } else if (poll.expiresAt != null) {
      text = l10n.pollClosesIn(_relative(poll.expiresAt!));
    } else {
      text = l10n.pollBadge;
    }
    return Text(text,
        style: AppTextStyles.labelSmall
            .copyWith(color: AppColors.textTertiary));
  }

  /// A coarse "in 3d" / "in 5h" style label for the closing time.
  String _relative(DateTime when) {
    final diff = when.difference(DateTime.now());
    if (diff.isNegative) return 'soon';
    if (diff.inDays >= 1) return 'in ${diff.inDays}d';
    if (diff.inHours >= 1) return 'in ${diff.inHours}h';
    if (diff.inMinutes >= 1) return 'in ${diff.inMinutes}m';
    return 'soon';
  }
}

class _FooterHint extends StatelessWidget {
  const _FooterHint({required this.poll, required this.isMember});

  final Poll poll;
  final bool isMember;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final String label;
    if (poll.isExpired) {
      label = l10n.pollClosed;
    } else if (!isMember) {
      label = l10n.pollJoinToVote;
    } else if (poll.hasVoted) {
      label = l10n.pollChangeVote;
    } else {
      label = l10n.pollTapToVote;
    }
    return Text(label,
        style: AppTextStyles.labelSmall
            .copyWith(color: AppColors.textTertiary));
  }
}

/// A single option: a tappable pill that, when results are shown, fills a
/// proportional progress bar behind the label and shows the % + a check for the
/// acting pet's own vote.
class _PollOptionRow extends StatelessWidget {
  const _PollOptionRow({
    required this.option,
    required this.share,
    required this.showResults,
    required this.enabled,
    required this.onTap,
  });

  final PollOption option;
  final double share;
  final bool showResults;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final pct = (share * 100).round();
    final selected = option.votedByMe;
    final barColor = selected
        ? AppColors.secondary.withValues(alpha: 0.18)
        : AppColors.secondarySoft.withValues(alpha: 0.5);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: AppRadius.mdAll,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppRadius.mdAll,
            border: Border.all(
              color: selected ? AppColors.secondary : AppColors.divider,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Result bar fill.
              if (showResults)
                Positioned.fill(
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: share.clamp(0, 1),
                    child: ColoredBox(color: barColor),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md, vertical: AppSpacing.sm + 2),
                child: Row(
                  children: [
                    if (selected)
                      const Padding(
                        padding: EdgeInsets.only(right: AppSpacing.xs),
                        child: Icon(FluentIcons.checkmark_circle_24_filled,
                            size: 18, color: AppColors.secondary),
                      ),
                    Expanded(
                      child: Text(
                        option.text,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight:
                              selected ? FontWeight.w700 : FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (showResults) ...[
                      const SizedBox(width: AppSpacing.sm),
                      Text('$pct%',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w700,
                          )),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A small pill badge marking the card type (poll / event).
class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 16, color: color),
    );
  }
}
