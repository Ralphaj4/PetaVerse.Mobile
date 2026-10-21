import '../network/api_client.dart';
import '../network/api_endpoints.dart';
import 'notification_prefs_store.dart';

class NotificationPrefsRemoteDataSource {
  const NotificationPrefsRemoteDataSource(this._client);

  final ApiClient _client;

  Future<Map<String, bool>> fetch() async {
    final json = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.notificationPreferences,
    );
    return _fromJson(json);
  }

  Future<Map<String, bool>> patch(Map<String, bool> changes) async {
    final json = await _client.put<Map<String, dynamic>>(
      ApiEndpoints.notificationPreferences,
      data: _toJson(changes),
    );
    return _fromJson(json);
  }

  /// Reads just the lost-pet alert radius (km) from the preferences payload.
  /// Returns null when the server omits it, so the caller can keep its default.
  Future<double?> fetchRadiusKm() async {
    final json = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.notificationPreferences,
    );
    return (json['lostPetAlertRadiusKm'] as num?)?.toDouble();
  }

  /// Partial-update of just the radius. The endpoint leaves omitted fields
  /// untouched, so this never disturbs the boolean toggles.
  Future<double?> patchRadiusKm(double km) async {
    final json = await _client.put<Map<String, dynamic>>(
      ApiEndpoints.notificationPreferences,
      data: {'lostPetAlertRadiusKm': km},
    );
    return (json['lostPetAlertRadiusKm'] as num?)?.toDouble();
  }

  static Map<String, bool> _fromJson(Map<String, dynamic> json) => {
        NotifPrefKeys.medication:
            (json['medication'] as bool?) ?? true,
        NotifPrefKeys.vaccination:
            (json['vaccination'] as bool?) ?? true,
        NotifPrefKeys.appointment:
            (json['appointment'] as bool?) ?? true,
        NotifPrefKeys.feeding:
            (json['feeding'] as bool?) ?? true,
        NotifPrefKeys.grooming:
            (json['grooming'] as bool?) ?? true,
        NotifPrefKeys.communityInteractions:
            (json['communityInteractions'] as bool?) ?? true,
        NotifPrefKeys.newFollower:
            (json['newFollower'] as bool?) ?? true,
        NotifPrefKeys.mentions:
            (json['mentions'] as bool?) ?? true,
        NotifPrefKeys.adoption:
            (json['adoption'] as bool?) ?? true,
        NotifPrefKeys.coOwnership:
            (json['coOwnership'] as bool?) ?? true,
        NotifPrefKeys.lostPetNearby:
            (json['lostPetNearby'] as bool?) ?? true,
      };

  static Map<String, dynamic> _toJson(Map<String, bool> prefs) => {
        if (prefs.containsKey(NotifPrefKeys.medication))
          'medication': prefs[NotifPrefKeys.medication],
        if (prefs.containsKey(NotifPrefKeys.vaccination))
          'vaccination': prefs[NotifPrefKeys.vaccination],
        if (prefs.containsKey(NotifPrefKeys.appointment))
          'appointment': prefs[NotifPrefKeys.appointment],
        if (prefs.containsKey(NotifPrefKeys.feeding))
          'feeding': prefs[NotifPrefKeys.feeding],
        if (prefs.containsKey(NotifPrefKeys.grooming))
          'grooming': prefs[NotifPrefKeys.grooming],
        if (prefs.containsKey(NotifPrefKeys.communityInteractions))
          'communityInteractions':
              prefs[NotifPrefKeys.communityInteractions],
        if (prefs.containsKey(NotifPrefKeys.newFollower))
          'newFollower': prefs[NotifPrefKeys.newFollower],
        if (prefs.containsKey(NotifPrefKeys.mentions))
          'mentions': prefs[NotifPrefKeys.mentions],
        if (prefs.containsKey(NotifPrefKeys.adoption))
          'adoption': prefs[NotifPrefKeys.adoption],
        if (prefs.containsKey(NotifPrefKeys.coOwnership))
          'coOwnership': prefs[NotifPrefKeys.coOwnership],
        if (prefs.containsKey(NotifPrefKeys.lostPetNearby))
          'lostPetNearby': prefs[NotifPrefKeys.lostPetNearby],
      };
}
