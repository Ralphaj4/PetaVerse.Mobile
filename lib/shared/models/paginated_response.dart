/// Generic page of results used by all paginated lists.
class PaginatedResponse<T> {
  const PaginatedResponse({
    required this.items,
    required this.page,
    required this.hasMore,
  });

  final List<T> items;
  final int page;
  final bool hasMore;

  PaginatedResponse<R> map<R>(R Function(T item) transform) =>
      PaginatedResponse(
        items: items.map(transform).toList(),
        page: page,
        hasMore: hasMore,
      );
}
