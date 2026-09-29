import 'dart:ui';

/// A supported app culture: the language sent to the backend via the
/// `X-Culture` header and used to drive the UI locale.
///
/// The [code] is the canonical value persisted in secure storage and sent
/// on every request. [flagAsset] is the SVG shown in the language picker.
enum AppCulture {
  english('en', 'assets/icons/flags/us.svg', 'English'),
  french('fr', 'assets/icons/flags/fr.svg', 'Français'),
  arabic('ar', 'assets/icons/flags/lb.svg', 'العربية');

  const AppCulture(this.code, this.flagAsset, this.nativeName);

  /// The culture code sent in the `X-Culture` header (e.g. "en").
  final String code;

  /// Asset path of the flag SVG shown in the picker.
  final String flagAsset;

  /// The language name in its own language, shown in the picker.
  final String nativeName;

  /// The [Locale] this culture maps to, for [MaterialApp.locale].
  Locale get locale => Locale(code);

  /// The default culture used until the user picks one.
  static const AppCulture fallback = AppCulture.english;

  /// Resolves a stored code back to a culture, falling back to [fallback]
  /// for unknown or null values.
  static AppCulture fromCode(String? code) {
    for (final culture in AppCulture.values) {
      if (culture.code == code) return culture;
    }
    return fallback;
  }
}
