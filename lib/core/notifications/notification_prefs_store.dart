import 'package:hive_flutter/hive_flutter.dart';

/// Keys for each toggleable notification preference, stored as booleans in
/// a dedicated Hive box. All default to `true` (enabled) when not set.
abstract final class NotifPrefKeys {
  // Health reminders
  static const String medication = 'pref_medication';
  static const String vaccination = 'pref_vaccination';
  static const String appointment = 'pref_appointment';

  // Community / PawHub interactions
  static const String communityInteractions = 'pref_community_interactions';
  static const String newFollower = 'pref_new_follower';
  static const String mentions = 'pref_mentions';

  // Adoption events
  static const String adoption = 'pref_adoption';

  // Co-ownership events
  static const String coOwnership = 'pref_co_ownership';

  // Nearby lost pet geo-push
  static const String lostPetNearby = 'pref_lost_pet_nearby';

  // Security alerts are intentionally omitted — they are always enabled.

  static const List<String> all = [
    medication,
    vaccination,
    appointment,
    communityInteractions,
    newFollower,
    mentions,
    adoption,
    coOwnership,
    lostPetNearby,
  ];
}

const _boxName = 'notification_prefs';

/// Thin synchronous Hive wrapper for notification preference booleans.
/// All reads default to `true` when no value has been saved.
class NotificationPrefsStore {
  const NotificationPrefsStore();

  Future<Box<bool>> _box() => Hive.openBox<bool>(_boxName);

  Future<bool> get(String key) async {
    final box = await _box();
    return box.get(key, defaultValue: true) ?? true;
  }

  Future<void> set(String key, {required bool enabled}) async {
    final box = await _box();
    await box.put(key, enabled);
  }

  /// Returns all prefs as a map. Keys absent in Hive default to `true`.
  Future<Map<String, bool>> getAll() async {
    final box = await _box();
    return {
      for (final key in NotifPrefKeys.all)
        key: box.get(key, defaultValue: true) ?? true,
    };
  }

  /// Writes a full map of prefs to Hive in one batch.
  Future<void> setAll(Map<String, bool> prefs) async {
    final box = await _box();
    await box.putAll(prefs);
  }
}
