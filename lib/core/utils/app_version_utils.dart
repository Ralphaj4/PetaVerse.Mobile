/// Compares two semver strings (e.g. "1.2.3").
///
/// Returns negative if [a] < [b], zero if equal, positive if [a] > [b].
/// Ignores pre-release suffixes — only major.minor.patch matter.
abstract final class AppVersionUtils {
  static int compare(String a, String b) {
    final aParts = _parts(a);
    final bParts = _parts(b);
    for (var i = 0; i < 3; i++) {
      final diff = aParts[i] - bParts[i];
      if (diff != 0) return diff;
    }
    return 0;
  }

  /// True when [current] is older than [required] (force-update needed).
  static bool isOlderThan(String current, String required) =>
      compare(current, required) < 0;

  static List<int> _parts(String version) {
    final parts = version.split('.').map((s) {
      // Strip any suffix like "-beta" or "+1"
      final clean = RegExp(r'^\d+').stringMatch(s) ?? '0';
      return int.tryParse(clean) ?? 0;
    }).toList();
    while (parts.length < 3) { parts.add(0); }
    return parts;
  }
}
