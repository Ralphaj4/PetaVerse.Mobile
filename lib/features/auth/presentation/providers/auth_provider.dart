import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../../profile/data/providers/user_repository_provider.dart';
import '../../../profile/presentation/providers/user_usecases_provider.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/login_outcome.dart';
import 'auth_repository_provider.dart';
import 'session_provider.dart';

part 'auth_provider.g.dart';

/// Outcome the login page acts on: go home, route to OTP, or stay (error).
enum LoginResult { authenticated, needsVerification, failed }

/// Drives the auth submission state for the login / register / OTP flows.
///
/// Each action returns a [bool] (success) for the pages' navigation logic,
/// while the AsyncValue carries loading + the last [Failure] so the UI can
/// show a spinner and surface a localized error message.
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  FutureOr<void> build() {}

  /// The failure from the most recent action, or null if it succeeded.
  Failure? get lastFailure {
    final err = state.error;
    return err is Failure ? err : null;
  }

  /// Registers a user. Returns whether it succeeded and the dev OTP the
  /// Development backend echoes back (null in production / on failure).
  Future<({bool ok, String? devOtp})> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    required double latitude,
    required double longitude,
    required String locationName,
    String? email,
  }) =>
      _runOtp(
        () => ref.read(authRepositoryProvider).register(
              firstName: firstName,
              lastName: lastName,
              mobileNumber: phone,
              password: password,
              latitude: latitude,
              longitude: longitude,
              locationName: locationName,
              email: email,
            ),
      );

  /// Requests a fresh OTP. Returns success + the dev OTP (null in prod).
  Future<({bool ok, String? devOtp})> resendOtp({required String phone}) =>
      _runOtp(
        () => ref.read(authRepositoryProvider).resendOtp(mobileNumber: phone),
      );

  /// Starts a password reset (sends OTP). Returns success + dev OTP.
  Future<({bool ok, String? devOtp})> forgotPassword({
    required String phone,
  }) =>
      _runOtp(
        () => ref
            .read(authRepositoryProvider)
            .forgotPassword(mobileNumber: phone),
      );

  /// Completes a password reset with the OTP and a new password.
  Future<bool> resetPassword({
    required String phone,
    required String code,
    required String newPassword,
  }) =>
      _runVoid(
        () => ref.read(authRepositoryProvider).resetPassword(
              mobileNumber: phone,
              otp: code,
              newPassword: newPassword,
            ),
      );

  /// Changes the authenticated user's password (JWT, no OTP).
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) =>
      _runVoid(
        () => ref.read(authRepositoryProvider).changePassword(
              oldPassword: oldPassword,
              newPassword: newPassword,
            ),
      );

  Future<bool> verifyOtp({
    required String phone,
    required String code,
  }) =>
      _runSession(
        () => ref.read(authRepositoryProvider).verifyPhone(
              mobileNumber: phone,
              otp: code,
            ),
      );

  /// Logs in. On a verified account the session gate is flipped and
  /// [LoginResult.authenticated] is returned; on an unverified account
  /// the backend resent an OTP and [LoginResult.needsVerification] is
  /// returned so the page can route to OTP entry.
  Future<({LoginResult result, String? devOtp})> login({
    required String phone,
    required String password,
  }) async {
    state = const AsyncLoading();
    final result = await ref.read(authRepositoryProvider).login(
          mobileNumber: phone,
          password: password,
        );
    final outcome = result.valueOrNull;
    if (outcome == null) {
      state = AsyncError(result.failureOrNull!, StackTrace.current);
      return (result: LoginResult.failed, devOtp: null);
    }

    switch (outcome) {
      case LoginAuthenticated():
        // Warm the profile cache before completing — login blocks until /me
        // is fetched and cached, so the Personal Information page renders
        // instantly afterwards.
        final warmed = await _warmProfileCache();
        if (!warmed.ok) {
          state = AsyncError(warmed.failure!, StackTrace.current);
          return (result: LoginResult.failed, devOtp: null);
        }
        state = const AsyncData(null);
        ref.read(sessionProvider.notifier).setLoggedIn(true);
        return (result: LoginResult.authenticated, devOtp: null);
      case LoginNeedsVerification(:final devOtp):
        state = const AsyncData(null);
        return (result: LoginResult.needsVerification, devOtp: devOtp);
    }
  }

  // ── Helpers ──────────────────────────────────────────────────────────

  /// Runs an OTP-dispatch call (register / resend / forgot-password),
  /// reflecting the outcome in the AsyncValue and returning success + OTP.
  Future<({bool ok, String? devOtp})> _runOtp(
    Future<Result<String?>> Function() action,
  ) async {
    state = const AsyncLoading();
    final result = await action();
    return result.when(
      success: (devOtp) {
        state = const AsyncData(null);
        return (ok: true, devOtp: devOtp);
      },
      failure: (f) {
        state = AsyncError(f, StackTrace.current);
        return (ok: false, devOtp: null);
      },
    );
  }

  /// Runs a void call (reset / change password), returning success.
  Future<bool> _runVoid(Future<Result<void>> Function() action) async {
    state = const AsyncLoading();
    final result = await action();
    return result.when(
      success: (_) {
        state = const AsyncData(null);
        return true;
      },
      failure: (f) {
        state = AsyncError(f, StackTrace.current);
        return false;
      },
    );
  }

  /// Revokes + clears the stored session, and drops the cached profile so
  /// the next user never sees the previous one's data.
  ///
  /// Note: this notifier is auto-disposed, so it must NOT touch [ref]
  /// after the await (the ref may be gone). Both repositories are read up
  /// front. The session-gate flip and any navigation are the caller's
  /// responsibility, driven from a stable ref.
  Future<void> logout() async {
    final authRepository = ref.read(authRepositoryProvider);
    final userRepository = ref.read(userRepositoryProvider);
    // Await BOTH local clears so they're durably written before logout is
    // considered done — otherwise a user who kills the app immediately after
    // tapping "log out" can relaunch with tokens/cache still present (skipping
    // login and showing the previous user's data).
    await Future.wait([
      authRepository.logout(),
      userRepository.clearCache(),
    ]);
  }

  /// Runs a session-returning call; tokens are already persisted by the
  /// repository, so here we flip the session gate to logged-in and
  /// translate the result into state + bool.
  Future<bool> _runSession(
    Future<Result<AuthSession>> Function() action,
  ) async {
    state = const AsyncLoading();
    final result = await action();
    final session = result.valueOrNull;
    if (session == null) {
      state = AsyncError(result.failureOrNull!, StackTrace.current);
      return false;
    }
    // Tokens are persisted by the repository; warm the profile cache before
    // flipping the gate so navigation lands on a ready Personal Info page.
    final warmed = await _warmProfileCache();
    if (!warmed.ok) {
      state = AsyncError(warmed.failure!, StackTrace.current);
      return false;
    }
    ref.read(sessionProvider.notifier).setLoggedIn(true);
    state = const AsyncData(null);
    return true;
  }

  /// Fetches and caches the signed-in user's profile (`/me`). Login and OTP
  /// verification block on this so the Personal Information page is warm.
  Future<({bool ok, Failure? failure})> _warmProfileCache() async {
    // ignore: avoid_print
    print('[AUTH] _warmProfileCache: start');
    final result = await ref.read(fetchUserProfileUsecaseProvider)();
    // ignore: avoid_print
    print('[AUTH] _warmProfileCache: done ok=${result.isSuccess} '
        'failure=${result.failureOrNull}');
    return result.when(
      success: (_) => (ok: true, failure: null),
      failure: (f) => (ok: false, failure: f),
    );
  }
}
