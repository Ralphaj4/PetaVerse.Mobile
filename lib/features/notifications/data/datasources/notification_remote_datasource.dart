import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dtos/notification_dtos.dart';

class NotificationRemoteDataSource {
  const NotificationRemoteDataSource(this._client);

  final ApiClient _client;

  Future<NotificationPageDto> getNotifications({
    required int page,
    required int pageSize,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.notifications,
      queryParameters: {'page': page, 'pageSize': pageSize},
    );
    return NotificationPageDto.fromJson(data);
  }

  Future<int> getUnreadCount() async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.notificationsUnreadCount,
    );
    return UnreadCountDto.fromJson(data).count;
  }

  Future<void> markRead(int id) async {
    await _client.post<void>(ApiEndpoints.notificationRead(id));
  }

  Future<void> markAllRead() async {
    await _client.post<void>(ApiEndpoints.notificationsReadAll);
  }
}
