import 'dart:async';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../../../core/utils/jwt_utils.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/login_outcome.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../dtos/auth_tokens_dto.dart';
import '../dtos/otp_dispatch_dto.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required SecureStorageService secureStorage,
  })  : _remote = remote,
        _secureStorage = secureStorage;

  final AuthRemoteDataSource _remote;
  final SecureStorageService _secureStorage;

  @override
  Future<Result<String?>> register({
    required String firstName,
    required String lastName,
    required String mobileNumber,
    required String password,
    required double latitude,
    required double longitude,
    required String locationName,
    String? email,
  }) =>
      _guardOtp(() => _remote.register(
            firstName: firstName,
            lastName: lastName,
            mobileNumber: mobileNumber,
            password: password,
            latitude: latitude,
            longitude: longitude,
            locationName: locationName,
            email: email,
          ));

  @override
  Future<Result<String?>> resendOtp({required String mobileNumber}) =>
      _guardOtp(() => _remote.resendOtp(mobileNumber));

  @override
  Future<Result<AuthSession>> verifyPhone({
    required String mobileNumber,
    required String otp,
  }) =>
      _guardSession(
        () => _remote.verifyPhone(mobileNumber: mobileNumber, otp: otp),
      );

  @override
  Future<Result<LoginOutcome>> login({
    required String mobileNumber,
    required String password,
  }) async {
    try {
      final dto =
          await _remote.login(mobileNumber: mobileNumber, password: password);

      // Unverified account: backend resent an OTP and issued no tokens.
      if (dto.requiresVerification) {
        return Result.success(
          LoginNeedsVerification(
            mobileNumber: mobileNumber,
            devOtp: dto.devOtp,
          ),
        );
      }

      // Verified: persist the issued tokens and return the session.
      await _secureStorage.saveTokens(
        accessToken: dto.accessToken!,
        refreshToken: dto.refreshToken!,
      );
      return Result.success(
        LoginAuthenticated(
          AuthSession(
            accessToken: dto.accessToken!,
            refreshToken: dto.refreshToken!,
            userId: dto.userId ?? '',
            roles: dto.roles,
          ),
        ),
      );
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<String?>> forgotPassword({required String mobileNumber}) =>
      _guardOtp(() => _remote.forgotPassword(mobileNumber));

  @override
  Future<Result<void>> resetPassword({
    required String mobileNumber,
    required String otp,
    required String newPassword,
  }) =>
      _guardVoid(() => _remote.resetPassword(
            mobileNumber: mobileNumber,
            otp: otp,
            newPassword: newPassword,
          ));

  @override
  Future<Result<void>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) =>
      _guardVoid(() => _remote.changePassword(
            oldPassword: oldPassword,
            newPassword: newPassword,
          ));

  @override
  Future<Result<void>> logout() async {
    // Best-effort server revoke — fire-and-forget so a slow/failing network
    // call never delays (or blocks) the local token clear, which is what
    // actually logs the user out on-device.
    final refresh = await _secureStorage.readRefreshToken();
    if (refresh != null && refresh.isNotEmpty) {
      unawaited(_remote.revoke(refresh).catchError((_) {}));
    }
    // Local token clear is awaited and durable — this is the source of truth
    // for [hasSession] on the next launch.
    await _secureStorage.clearTokens();
    return const Result.success(null);
  }

  @override
  Future<bool> hasSession() async {
    final token = await _secureStorage.readAccessToken();
    if (token == null || token.isEmpty) return false;

    // A stored access token isn't proof of a live session: on a cold launch the
    // day after login it is typically expired. Returning true here would let
    // the app enter Home, then every startup request would 401 at once and race
    // the (rotating) refresh token — logging the user out. So when the access
    // token is expired, refresh it up front and let THAT decide the verdict.
    if (!JwtUtils.isExpired(token)) return true;

    final refresh = await _secureStorage.readRefreshToken();
    if (refresh == null || refresh.isEmpty) return false;

    try {
      final dto = await _remote.refreshSession(refresh);
      await _secureStorage.saveTokens(
        accessToken: dto.accessToken,
        refreshToken: dto.refreshToken,
      );
      return true;
    } on UnauthorizedException {
      // Backend positively rejected the refresh token (401): the session is
      // dead. Clear the stale pair so we don't retry a doomed refresh next
      // launch, and report no session so the router routes to login.
      await _secureStorage.clearTokens();
      return false;
    } on ValidationException {
      // 400 — malformed refresh token; same verdict as a 401.
      await _secureStorage.clearTokens();
      return false;
    } on AppException {
      // Any other failure (timeout, connection error, 5xx) is inconclusive: we
      // do NOT know the session is dead, so we KEEP the tokens and let the user
      // in optimistically. The first authenticated request will 401 and the
      // interceptor will refresh again once the server responds; if the token
      // really is dead, that path ends the session cleanly. Clearing here would
      // log a valid user out over a momentary blip (or a debugger breakpoint).
      return true;
    }
  }

  // ── Helpers ──────────────────────────────────────────────────────────

  /// Runs an OTP-dispatch action (register / resend / forgot-password),
  /// returning the dev OTP echoed by the Development backend (null in prod).
  Future<Result<String?>> _guardOtp(
    Future<OtpDispatchDto> Function() action,
  ) async {
    try {
      final dto = await action();
      return Result.success(dto.devOtp);
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  /// Runs a void action, mapping exceptions to failures.
  Future<Result<void>> _guardVoid(Future<void> Function() action) async {
    try {
      await action();
      return const Result.success(null);
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  /// Runs a token-returning action, persists the tokens on success, and
  /// returns the resulting [AuthSession].
  Future<Result<AuthSession>> _guardSession(
    Future<AuthTokensDto> Function() action,
  ) async {
    try {
      final dto = await action();
      await _secureStorage.saveTokens(
        accessToken: dto.accessToken,
        refreshToken: dto.refreshToken,
      );
      return Result.success(
        AuthSession(
          accessToken: dto.accessToken,
          refreshToken: dto.refreshToken,
          userId: dto.userId,
          roles: dto.roles,
        ),
      );
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  Failure _mapFailure(AppException e) => switch (e) {
        NetworkException() => NetworkFailure(message: e.message),
        UnauthorizedException() => UnauthorizedFailure(message: e.message),
        ForbiddenException() => ForbiddenFailure(message: e.message),
        NotFoundException() => NotFoundFailure(message: e.message),
        ValidationException() => ValidationFailure(
            message: e.message,
            fieldErrors: e.fieldErrors,
          ),
        RateLimitException() => RateLimitFailure(
            message: e.message,
            retryAfter: e.retryAfter,
          ),
        ServerException() => ServerFailure(message: e.message),
        CacheException() => CacheFailure(message: e.message),
      };
}
