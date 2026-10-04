import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// Manages the one-time "Open links by default" prompt on Android.
///
/// Android 12+ sets the per-user link-handling selection to Disabled even when
/// the domain is verified. Users must opt-in via Settings → Apps → Open by
/// default. This service tracks whether we have already shown the prompt (so it
/// fires at most once per install) and provides the helper to open the system
/// settings screen directly.
abstract final class OpenByDefaultService {
  static const _box = 'app_prefs';
  static const _key = 'open_by_default_prompted';

  /// Returns true if we should show the sheet (Android only, not yet prompted).
  static Future<bool> shouldPrompt() async {
    if (!Platform.isAndroid) return false;
    final box = await Hive.openBox<String>(_box);
    return box.get(_key) == null;
  }

  /// Mark as prompted so the sheet never shows again.
  static Future<void> markPrompted() async {
    final box = await Hive.openBox<String>(_box);
    await box.put(_key, '1');
  }

  /// Opens the system "Open by default" settings screen for this app so the
  /// user can enable petaverseapp.com link handling with two taps.
  static Future<void> openSettings() async {
    // intent: URI that fires ACTION_APP_OPEN_BY_DEFAULT_SETTINGS (Android 12+).
    // url_launcher passes this to the OS which resolves it via the Intent system.
    final intentUri = Uri.parse(
      'intent:#Intent;action=android.settings.APP_OPEN_BY_DEFAULT_SETTINGS;'
      'data=package%3Acom.petaverse.app;end',
    );
    if (!await launchUrl(intentUri, mode: LaunchMode.externalApplication)) {
      // Fallback for older Android: open the generic app-info screen.
      // Settings → Apps → PetaVerse → the user can find "Open by default" there.
      final appInfoUri = Uri.parse(
        'intent:#Intent;action=android.settings.APPLICATION_DETAILS_SETTINGS;'
        'data=package%3Acom.petaverse.app;end',
      );
      await launchUrl(appInfoUri, mode: LaunchMode.externalApplication);
    }
  }
}
