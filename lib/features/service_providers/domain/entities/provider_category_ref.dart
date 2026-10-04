import 'provider_category.dart';

/// A row from `GET /service-providers/categories` - the admin-configurable
/// category table that maps a numeric [id] (used in search items' `categoryIds`
/// / `primaryCategoryId`) to a [slug] the client owns icons/colors for.
///
/// [name] is the server's display name; the client prefers its own localized
/// label (via [ProviderCategory]) and uses [name] only as a fallback for an
/// unknown slug.
class ProviderCategoryRef {
  const ProviderCategoryRef({
    required this.id,
    required this.slug,
    required this.name,
    required this.sortOrder,
  });

  final int id;
  final String slug;
  final String name;
  final int sortOrder;

  /// The client enum this row maps to, or null when the slug is unknown
  /// (forward-compatible: a new server category renders in a safe "other"
  /// bucket rather than crashing).
  ProviderCategory? get category => ProviderCategoryX.fromSlug(slug);
}
