import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Broadcasts "scroll to top" requests for the bottom-nav tabs.
///
/// The shell bumps a per-branch counter when the user re-taps the already-
/// selected tab while its branch navigator is at its root (no page pushed on
/// top). Each tab's root page listens for its own branch index and animates
/// its primary scroll view back to the top.
///
/// A monotonically increasing counter (rather than a bool/void) is used so
/// every tap is a distinct value that Riverpod's `listen` fires on — even two
/// taps in a row.
final tabScrollToTopProvider =
    NotifierProvider<TabScrollToTopNotifier, Map<int, int>>(
  TabScrollToTopNotifier.new,
);

class TabScrollToTopNotifier extends Notifier<Map<int, int>> {
  @override
  Map<int, int> build() => const {};

  /// Request the tab at [branchIndex] to scroll to the top.
  void request(int branchIndex) {
    state = {
      ...state,
      branchIndex: (state[branchIndex] ?? 0) + 1,
    };
  }
}
