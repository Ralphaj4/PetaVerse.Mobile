import '../../../../core/errors/result.dart';
import '../../../../shared/models/paginated_response.dart';
import '../entities/app_notification.dart';

abstract interface class NotificationRepository {
  Future<Result<PaginatedResponse<AppNotification>>> getNotifications({
    int page = 1,
    int pageSize = 20,
  });

  Future<Result<int>> getUnreadCount();

  Future<Result<void>> markRead(int id);

  Future<Result<void>> markAllRead();
}
