import 'dart:async';

import 'package:flutter/foundation.dart';

/// Debounces rapid calls — used by search fields so the API is not hit on
/// every keystroke (300ms per engineering guidelines).
class Debouncer {
  Debouncer({this.delay = const Duration(milliseconds: 300)});

  final Duration delay;
  Timer? _timer;

  void call(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
