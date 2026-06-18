/// Global application constants.
abstract final class AppConstants {
  /// Backend base URL. Overridable per environment via --dart-define.
  ///
  /// The PetsApp.Api listens on port 5075 under `/api`. The default below
  /// works for the Android emulator (10.0.2.2 maps to the host machine).
  /// Override per environment, e.g.:
  ///   • Android emulator: http://10.0.2.2:5075/api  (default)
  ///   • iOS simulator:    http://localhost:5075/api
  ///   • Physical device:  `http://<your-LAN-ip>:5075/api`
  /// Run with: flutter run --dart-define=API_BASE_URL=http://192.168.1.50:5075/api
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    // defaultValue: 'http://192.168.200.176:5075/api',
    defaultValue: 'http://petaverse.runasp.net/api',
    // defaultValue: 'http://10.0.2.2:5075/api',
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
