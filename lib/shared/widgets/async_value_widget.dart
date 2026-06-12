import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/errors/failure.dart';
import 'error_state_widget.dart';
import 'loading_state_widget.dart';

/// Renders an [AsyncValue] with the mandatory loading/error/data states.
///
/// Errors thrown by providers are expected to be [Failure]s (repositories
/// return Result, providers unwrap to throw the Failure into AsyncValue).
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    required this.value,
    required this.data,
    this.onRetry,
    super.key,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => const LoadingStateWidget(),
      error: (error, _) => ErrorStateWidget(
        failure: error is Failure ? error : null,
        onRetry: onRetry,
      ),
    );
  }
}
