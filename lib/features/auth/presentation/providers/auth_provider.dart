import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
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
    String? email,
  }) =>
      _runOtp(
        () => ref.read(authRepositoryProvider).register(
              firstName: firstName,
              lastName: lastName,
              mobileNumber: phone,
              password: password,
              email: email,
            ),
      );

  /// Requests a fresh OTP. Returns success + the dev OTP (null in prod).
  Future<({bool ok, String? devOtp})> resendOtp({required String phone}) =>
      _runOtp(
        () => ref.read(authRepositoryProvider).resendOtp(mobileNumber: phone),
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
    return result.when(
      success: (outcome) {
        state = const AsyncData(null);
        switch (outcome) {
          case LoginAuthenticated():
            ref.read(sessionProvider.notifier).setLoggedIn(true);
            return (result: LoginResult.authenticated, devOtp: null);
          case LoginNeedsVerification(:final devOtp):
            return (result: LoginResult.needsVerification, devOtp: devOtp);
        }
      },
      failure: (f) {
        state = AsyncError(f, StackTrace.current);
        return (result: LoginResult.failed, devOtp: null);
      },
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────

  /// Runs an OTP-dispatch call (register / resend), reflecting the outcome
  /// in the AsyncValue and returning success + the dev OTP.
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

  /// Revokes + clears the stored session.
  ///
  /// Note: this notifier is auto-disposed, so it must NOT touch [ref]
  /// after the await (the ref may be gone). The session-gate flip and any
  /// navigation are the caller's responsibility, driven from a stable ref.
  Future<void> logout() => ref.read(authRepositoryProvider).logout();

  /// Runs a session-returning call; tokens are already persisted by the
  /// repository, so here we flip the session gate to logged-in and
  /// translate the result into state + bool.
  Future<bool> _runSession(
    Future<Result<AuthSession>> Function() action,
  ) async {
    state = const AsyncLoading();
    final result = await action();
    return result.when(
      success: (_) {
        ref.read(sessionProvider.notifier).setLoggedIn(true);
        state = const AsyncData(null);
        return true;
      },
      failure: (f) {
        state = AsyncError(f, StackTrace.current);
        return false;
      },
    );
  }
}
