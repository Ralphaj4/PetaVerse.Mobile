import 'package:flutter/widgets.dart';

/// Border radius design tokens.
abstract final class AppRadius {
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;

  static final BorderRadius smAll = BorderRadius.circular(sm);
  static final BorderRadius mdAll = BorderRadius.circular(md);
  static final BorderRadius lgAll = BorderRadius.circular(lg);
}
