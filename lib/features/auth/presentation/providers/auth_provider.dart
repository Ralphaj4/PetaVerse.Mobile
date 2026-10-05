import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/app/notification_service.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../../home/presentation/providers/home_providers.dart';
import '../../../pawcare/presentation/providers/pawcare_providers.dart';
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

  /// Registers a user. Returns success, whether CAPTCHA is required, and the
  /// dev OTP echoed by the Development backend (null in production / on failure).
  Future<({bool ok, bool captchaRequired, String? devOtp})> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    required double latitude,
    required double longitude,
    required String locationName,
    String? email,
    bool captchaAcknowledged = false,
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
              captchaAcknowledged: captchaAcknowledged,
            ),
      );

  /// Requests a fresh OTP. Returns success, whether CAPTCHA is required,
  /// and the dev OTP (null in prod).
  Future<({bool ok, bool captchaRequired, String? devOtp})> resendOtp({
    required String phone,
    bool captchaAcknowledged = false,
  }) =>
      _runOtp(
        () => ref.read(authRepositoryProvider).resendOtp(
              mobileNumber: phone,
              captchaAcknowledged: captchaAcknowledged,
            ),
      );

  /// Starts a password reset. Returns success, whether CAPTCHA is required,
  /// whether an SMS OTP was sent (vs. an email link), and the dev OTP.
  Future<({bool ok, bool captchaRequired, bool isOtp, String? devOtp})>
      forgotPassword({
    required String phone,
    bool requestOtp = false,
    bool captchaAcknowledged = false,
  }) async {
    state = const AsyncLoading();
    final result = await ref.read(authRepositoryProvider).forgotPassword(
          mobileNumber: phone,
          requestOtp: requestOtp,
          captchaAcknowledged: captchaAcknowledged,
        );
    return result.when(
      success: (data) {
        state = const AsyncData(null);
        return (
          ok: !data.captchaRequired,
          captchaRequired: data.captchaRequired,
          isOtp: data.isOtp,
          devOtp: data.devOtp,
        );
      },
      failure: (f) {
        state = AsyncError(f, StackTrace.current);
        return (ok: false, captchaRequired: false, isOtp: false, devOtp: null);
      },
    );
  }

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
        // Warm the profile cache before completing - login blocks until /me
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

  /// Runs an OTP-dispatch call (register / resend), reflecting the outcome in
  /// the AsyncValue and returning success, captchaRequired, and the dev OTP.
  Future<({bool ok, bool captchaRequired, String? devOtp})> _runOtp(
    Future<Result<({bool captchaRequired, String? devOtp})>> Function() action,
  ) async {
    state = const AsyncLoading();
    final result = await action();
    return result.when(
      success: (data) {
        state = const AsyncData(null);
        return (
          ok: !data.captchaRequired,
          captchaRequired: data.captchaRequired,
          devOtp: data.devOtp,
        );
      },
      failure: (f) {
        state = AsyncError(f, StackTrace.current);
        return (ok: false, captchaRequired: false, devOtp: null);
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

  /// Sends a 6-digit verification code to the user's email address.
  Future<bool> sendEmailVerification() =>
      _runVoid(() => ref.read(authRepositoryProvider).sendEmailVerification());

  /// Confirms the 6-digit email verification code entered by the user.
  Future<bool> confirmEmailVerification(String code) =>
      _runVoid(
          () => ref.read(authRepositoryProvider).confirmEmailVerification(code));

  /// Permanently deletes the account via DELETE /api/users/me, then clears all
  /// local credentials and cached data.
  ///
  /// Mirrors [logout]: all providers are read up front, no [state] writes
  /// happen after the awaits - the notifier is auto-disposed and its ref
  /// becomes invalid as soon as the session gate is flipped by the caller.
  /// Returns the [Result] directly so the caller can handle errors and drive
  /// the gate flip from a stable ref.
  Future<Result<void>> deleteAccount() async {
    final authRepository = ref.read(authRepositoryProvider);
    final userRepository = ref.read(userRepositoryProvider);
    final reminderCache = ref.read(healthReminderCacheProvider);
    final homeCache = ref.read(homeSummaryCacheProvider);
    final notifications = ref.read(notificationServiceProvider);
    final result = await authRepository.deleteAccount();
    if (result.isFailure) return result;
    await Future.wait([
      userRepository.clearCache(),
      reminderCache.clear(),
      homeCache.clear(),
      notifications.cancelAll(),
    ]);
    return result;
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
    final reminderCache = ref.read(healthReminderCacheProvider);
    final homeCache = ref.read(homeSummaryCacheProvider);
    final notifications = ref.read(notificationServiceProvider);
    // Await the local clears so they're durably written before logout is
    // considered done - otherwise a user who kills the app immediately after
    // tapping "log out" can relaunch with tokens/cache still present (skipping
    // login and showing the previous user's data).
    await Future.wait([
      authRepository.logout(),
      userRepository.clearCache(),
      reminderCache.clear(),
      homeCache.clear(),
      notifications.cancelAll(),
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
