import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/user.dart';
import 'user_usecases_provider.dart';

part 'user_provider.g.dart';

/// Offline-first profile state.
///
/// The cache is warmed at login/verify time, so [build] returns the cached
/// user instantly (no spinner) and reconciles with the server in the
/// background. Only a cold cache (no login-time warm) falls back to a
/// blocking network fetch.
@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  Future<User> build() async {
    final cached = await ref.read(getCachedUserProfileUsecaseProvider)();
    final cachedUser = cached.valueOrNull;

    if (cachedUser != null) {
      // Show cache instantly; reconcile with the server in the background
      // without blocking this build (so the UI gets the cached user right
      // away rather than waiting on the network).
      unawaited(_reconcile());
      return cachedUser;
    }

    // Cold cache: block on the network fetch.
    final result = await ref.read(fetchUserProfileUsecaseProvider)();
    return result.when(
      success: (user) => user,
      failure: (failure) => throw failure,
    );
  }

  /// Background sync — refreshes from the server without flipping the UI
  /// back to a loading state. Silently keeps a stale-but-usable cache on
  /// failure (the user still sees their cached profile).
  Future<void> _reconcile() async {
    final result = await ref.read(fetchUserProfileUsecaseProvider)();
    final user = result.valueOrNull;
    // The notifier may have been disposed while the network call was in
    // flight (e.g. the user left the screen) — don't touch state if so.
    if (user != null && ref.mounted) {
      state = AsyncValue.data(user);
    }
  }

  /// Updates the profile. On success the state is refreshed with the new
  /// user and null is returned; on failure the existing (data) state is kept
  /// intact — so the form isn't wiped — and the [Failure] is returned for the
  /// page to surface (e.g. a snackbar).
  Future<Failure?> updateProfile({
    required String firstName,
    required String lastName,
    String? email,
    DateTime? dateOfBirth,
    double? latitude,
    double? longitude,
    String? locationName,
  }) async {
    final usecase = ref.read(updateUserProfileUsecaseProvider);
    final result = await usecase(
      firstName: firstName,
      lastName: lastName,
      email: email,
      dateOfBirth: dateOfBirth,
      latitude: latitude,
      longitude: longitude,
      locationName: locationName,
    );

    return result.when(
      success: (user) {
        state = AsyncValue.data(user);
        return null;
      },
      failure: (failure) => failure,
    );
  }

  /// Manual refresh (e.g. the error-state Retry button). Shows a spinner
  /// while the authoritative fetch runs.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final result = await ref.read(fetchUserProfileUsecaseProvider)();
    result.when(
      success: (user) {
        state = AsyncValue.data(user);
      },
      failure: (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
    );
  }
}
