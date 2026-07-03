import 'dart:async';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/storage/secure_storage_service.dart';
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
    String? email,
  }) =>
      _guardOtp(() => _remote.register(
            firstName: firstName,
            lastName: lastName,
            mobileNumber: mobileNumber,
            password: password,
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
    return token != null && token.isNotEmpty;
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
        ServerException() => ServerFailure(message: e.message),
        CacheException() => CacheFailure(message: e.message),
      };
}
