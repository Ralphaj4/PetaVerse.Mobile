import 'package:hive_flutter/hive_flutter.dart';

/// Tracks one-time "first open" flags for features that show a disclaimer
/// or onboarding popup on their first launch.
///
/// Keys are stored in the shared `app_prefs` Hive box so they survive
/// reinstalls (same as [OpenByDefaultService]).
abstract final class FirstOpenService {
  static const _box = 'app_prefs';
  static const _aiDisclaimerKey = 'ai_disclaimer_accepted';
  static const _petVisionDisclaimerKey = 'pet_vision_disclaimer_seen';

  // ── AI chatbot ────────────────────────────────────────────────────────────

  static Future<bool> hasAcceptedAiDisclaimer() async {
    final box = await Hive.openBox<String>(_box);
    return box.get(_aiDisclaimerKey) != null;
  }

  static Future<void> markAiDisclaimerAccepted() async {
    final box = await Hive.openBox<String>(_box);
    await box.put(_aiDisclaimerKey, '1');
  }

  // ── Pet Vision ────────────────────────────────────────────────────────────

  static Future<bool> hasSeenPetVisionDisclaimer() async {
    final box = await Hive.openBox<String>(_box);
    return box.get(_petVisionDisclaimerKey) != null;
  }

  static Future<void> markPetVisionDisclaimerSeen() async {
    final box = await Hive.openBox<String>(_box);
    await box.put(_petVisionDisclaimerKey, '1');
  }
}
