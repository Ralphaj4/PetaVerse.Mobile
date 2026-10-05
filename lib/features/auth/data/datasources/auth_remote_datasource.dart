import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dtos/auth_tokens_dto.dart';
import '../dtos/login_response_dto.dart';
import '../dtos/otp_dispatch_dto.dart';

/// Remote auth data source. Talks to the API exclusively through
/// [ApiClient]; never touches Dio directly. Throws AppExceptions
/// (mapped by ApiClient) - the repository turns those into Failures.
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
    String? deviceId,
    bool captchaAcknowledged = false,
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
        'deviceId': deviceId,
        'captchaAcknowledged': captchaAcknowledged,
      },
    );
    return OtpDispatchDto.fromJson(json);
  }

  Future<OtpDispatchDto> resendOtp(
    String mobileNumber, {
    String? deviceId,
    bool captchaAcknowledged = false,
  }) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.resendOtp,
      data: {
        'mobileNumber': mobileNumber,
        'deviceId': deviceId,
        'captchaAcknowledged': captchaAcknowledged,
      },
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

  Future<void> revoke({
    required String refreshToken,
    required String deviceId,
  }) async {
    await _client.post<Map<String, dynamic>>(
      ApiEndpoints.revokeToken,
      data: {'refreshToken': refreshToken, 'deviceId': deviceId},
    );
  }

  /// Exchanges a refresh token for a fresh token pair. Used by the proactive
  /// startup refresh (an expired access token on cold launch) - the reactive
  /// 401 path in [AuthInterceptor] refreshes on its own and does not use this.
  Future<AuthTokensDto> refreshSession(String refreshToken) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.refreshToken,
      data: {'refreshToken': refreshToken},
    );
    return AuthTokensDto.fromJson(json);
  }

  /// Starts a password reset. When [requestOtp] is true the backend forces
  /// SMS OTP delivery; otherwise it chooses email link vs. SMS automatically.
  Future<OtpDispatchDto> forgotPassword(
    String mobileNumber, {
    bool requestOtp = false,
    String? deviceId,
    bool captchaAcknowledged = false,
  }) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.forgotPassword,
      data: {
        'mobileNumber': mobileNumber,
        if (requestOtp) 'requestOtp': true,
        'deviceId': deviceId,
        'captchaAcknowledged': captchaAcknowledged,
      },
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

  /// Sends a 6-digit email verification code to the current user's email.
  Future<void> sendEmailVerification() async {
    await _client.post<void>(ApiEndpoints.emailVerifySend);
  }

  /// Confirms the email verification code entered by the user.
  Future<void> confirmEmailVerification(String code) async {
    await _client.post<void>(
      ApiEndpoints.emailVerifyConfirm,
      data: {'code': code},
    );
  }

  /// Registers (or refreshes) a device FCM token so the backend can send
  /// targeted push notifications to this device.
  Future<void> registerFcmToken({
    required String token,
    required String deviceId,
    required String platform,
    required String timeZone,
  }) async {
    await _client.post<void>(
      ApiEndpoints.fcmToken,
      data: {
        'token': token,
        'deviceId': deviceId,
        'platform': platform,
        'timeZone': timeZone,
      },
    );
  }

  /// Removes a device FCM token - call on logout so the backend stops
  /// sending pushes to this device.
  Future<void> unregisterFcmToken({required String deviceId}) async {
    await _client.deleteWithBody<void>(
      ApiEndpoints.fcmToken,
      data: {'deviceId': deviceId},
    );
  }

  /// Permanently deletes the authenticated user's account (204 No Content).
  Future<void> deleteAccount() async {
    await _client.delete<void>(ApiEndpoints.deleteAccount);
  }
}
