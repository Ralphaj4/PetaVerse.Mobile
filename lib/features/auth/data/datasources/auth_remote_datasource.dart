import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dtos/auth_tokens_dto.dart';
import '../dtos/login_response_dto.dart';
import '../dtos/otp_dispatch_dto.dart';

/// Remote auth data source. Talks to the API exclusively through
/// [ApiClient]; never touches Dio directly. Throws AppExceptions
/// (mapped by ApiClient) — the repository turns those into Failures.
class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._client);

  final ApiClient _client;

  Future<OtpDispatchDto> register({
    required String firstName,
    required String lastName,
    required String mobileNumber,
    required String password,
    required double latitude,
    required double longitude,
    required String locationName,
    String? email,
  }) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.register,
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'mobileNumber': mobileNumber,
        'password': password,
        'latitude': latitude,
        'longitude': longitude,
        'locationName': locationName,
        if (email != null && email.isNotEmpty) 'email': email,
      },
    );
    return OtpDispatchDto.fromJson(json);
  }

  Future<OtpDispatchDto> resendOtp(String mobileNumber) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.resendOtp,
      data: {'mobileNumber': mobileNumber},
    );
    return OtpDispatchDto.fromJson(json);
  }

  Future<AuthTokensDto> verifyPhone({
    required String mobileNumber,
    required String otp,
  }) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.verifyPhone,
      data: {'mobileNumber': mobileNumber, 'otp': otp},
    );
    return AuthTokensDto.fromJson(json);
  }

  Future<LoginResponseDto> login({
    required String mobileNumber,
    required String password,
  }) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.login,
      data: {'mobileNumber': mobileNumber, 'password': password},
    );
    return LoginResponseDto.fromJson(json);
  }

  Future<void> revoke(String refreshToken) async {
    await _client.post<Map<String, dynamic>>(
      ApiEndpoints.revokeToken,
      data: {'refreshToken': refreshToken},
    );
  }

  /// Exchanges a refresh token for a fresh token pair. Used by the proactive
  /// startup refresh (an expired access token on cold launch) — the reactive
  /// 401 path in [AuthInterceptor] refreshes on its own and does not use this.
  Future<AuthTokensDto> refreshSession(String refreshToken) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.refreshToken,
      data: {'refreshToken': refreshToken},
    );
    return AuthTokensDto.fromJson(json);
  }

  /// Starts a password reset: backend sends an OTP to the mobile number.
  Future<OtpDispatchDto> forgotPassword(String mobileNumber) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.forgotPassword,
      data: {'mobileNumber': mobileNumber},
    );
    return OtpDispatchDto.fromJson(json);
  }

  /// Completes a password reset with the OTP and a new password.
  Future<void> resetPassword({
    required String mobileNumber,
    required String otp,
    required String newPassword,
  }) async {
    await _client.post<Map<String, dynamic>>(
      ApiEndpoints.resetPassword,
      data: {
        'mobileNumber': mobileNumber,
        'otp': otp,
        'newPassword': newPassword,
      },
    );
  }

  /// Changes the password of the authenticated user (JWT, no OTP).
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    await _client.post<Map<String, dynamic>>(
      ApiEndpoints.changePassword,
      data: {'oldPassword': oldPassword, 'newPassword': newPassword},
    );
  }
}
