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

  static Map<String, bool> _fromJson(Map<String, dynamic> json) => {
        NotifPrefKeys.medication:
            (json['medication'] as bool?) ?? true,
        NotifPrefKeys.vaccination:
            (json['vaccination'] as bool?) ?? true,
        NotifPrefKeys.appointment:
            (json['appointment'] as bool?) ?? true,
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
