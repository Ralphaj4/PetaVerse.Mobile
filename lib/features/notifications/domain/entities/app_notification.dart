/// A single in-app notification entry from the bell feed.
class AppNotification {
  const AppNotification({
    required this.id,
    required this.type,
    required this.category,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
    this.route,
    this.petId,
  });

  final int id;

  /// Server-defined event type, e.g. "like", "comment", "adoption_approved".
  final String type;

  /// Routing category: "social" | "medication" | "vaccination" |
  /// "appointment" | "emergency".
  final String category;

  final String title;
  final String body;
  final bool isRead;
  final DateTime createdAt;

  /// GoRouter deep-link path, e.g. "/community/posts/99". Null when not
  /// applicable (e.g. password-change alert).
  final String? route;

  /// Relevant pet id when present (health-category notifications).
  final int? petId;

  AppNotification copyWith({bool? isRead}) => AppNotification(
        id: id,
        type: type,
        category: category,
        title: title,
        body: body,
        isRead: isRead ?? this.isRead,
        createdAt: createdAt,
        route: route,
        petId: petId,
      );
}
