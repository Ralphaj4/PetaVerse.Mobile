/// Global application constants.
abstract final class AppConstants {
  /// Backend base URL. Overridable per environment via --dart-define.
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.petaverse.app/v1',
  );

  /// Page size for all paginated lists (infinite scroll, 20 at a time).
  static const int pageSize = 20;

  /// Debounce duration for search inputs.
  static const Duration searchDebounce = Duration(milliseconds: 300);

  /// Network timeouts.
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 20);

  /// Distance from list end (in items) at which the next page is requested.
  static const int paginationTriggerThreshold = 3;

  /// When false (default until a backend exists) repositories operate
  /// purely offline-first from the Hive cache and skip remote sync.
  /// Enable with --dart-define=REMOTE_SYNC=true once the API is live.
  static const bool remoteSyncEnabled =
      bool.fromEnvironment('REMOTE_SYNC', defaultValue: false);
}
