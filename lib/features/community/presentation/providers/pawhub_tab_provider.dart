import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A one-shot request to open a specific PawHub hub segment
/// (0 = Feed, 1 = Lost & Found, 2 = Adoption), set by an external entry point
/// such as Home's quick actions before switching to the community branch.
///
/// The hub reads it on build / listens for changes, animates to that tab, then
/// clears it via [PawHubRequestedTab.clear] so it doesn't re-fire next visit.
final pawHubRequestedTabProvider =
    NotifierProvider<PawHubRequestedTab, int?>(PawHubRequestedTab.new);

class PawHubRequestedTab extends Notifier<int?> {
  @override
  int? build() => null;

  /// Request the hub to open [tab] (0 Feed · 1 Lost & Found · 2 Adoption).
  void request(int tab) => state = tab;

  /// Clear the pending request once consumed.
  void clear() => state = null;
}
