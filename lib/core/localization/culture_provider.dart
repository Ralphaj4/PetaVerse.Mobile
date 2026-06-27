import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../storage/secure_storage_service.dart';
import 'app_culture.dart';

part 'culture_provider.g.dart';

/// The app-wide current culture.
///
/// Backed by [SecureStorageService] (saved like the access token) and loaded
/// eagerly at startup via [load] so the value is available synchronously for
/// request headers ([AppCulture.code] → `X-Culture`) and the UI locale.
/// Defaults to [AppCulture.fallback] (`en`) until the user picks one.
@Riverpod(keepAlive: true)
class Culture extends _$Culture {
  @override
  AppCulture build() => AppCulture.fallback;

  /// Hydrates the current culture from secure storage. Call once during
  /// startup, before the first frame, so the locale doesn't flicker.
  Future<void> load() async {
    final stored = await ref.read(secureStorageServiceProvider).readCulture();
    state = AppCulture.fromCode(stored);
  }

  /// Switches the culture and persists it. Updates the UI locale and the
  /// `X-Culture` header sent on subsequent requests.
  Future<void> setCulture(AppCulture culture) async {
    if (culture == state) return;
    await ref.read(secureStorageServiceProvider).saveCulture(culture.code);
    state = culture;
  }
}
