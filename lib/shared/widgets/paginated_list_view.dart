import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_spacing.dart';
import 'loading_state_widget.dart';

/// Infinite-scroll list. Requests the next page when the user nears the
/// end (20 items per page per engineering guidelines).
class PaginatedListView<T> extends StatefulWidget {
  const PaginatedListView({
    required this.items,
    required this.itemBuilder,
    required this.hasMore,
    required this.onLoadMore,
    this.isLoadingMore = false,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.separator,
    super.key,
  });

  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final bool hasMore;
  final VoidCallback onLoadMore;
  final bool isLoadingMore;
  final EdgeInsetsGeometry padding;
  final Widget? separator;

  @override
  State<PaginatedListView<T>> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  @override
  Widget build(BuildContext context) {
    final itemCount = widget.items.length + (widget.hasMore ? 1 : 0);
    return ListView.separated(
      padding: widget.padding,
      itemCount: itemCount,
      separatorBuilder: (_, _) =>
          widget.separator ?? const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        if (index >= widget.items.length) {
          if (!widget.isLoadingMore) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) widget.onLoadMore();
            });
          }
          return const Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: LoadingStateWidget(),
          );
        }
        // Prefetch shortly before the end is reached.
        if (widget.hasMore &&
            !widget.isLoadingMore &&
            index ==
                widget.items.length - AppConstants.paginationTriggerThreshold) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) widget.onLoadMore();
          });
        }
        return widget.itemBuilder(context, widget.items[index]);
      },
    );
  }
}
