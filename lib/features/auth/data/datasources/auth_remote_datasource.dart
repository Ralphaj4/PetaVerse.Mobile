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
    String? email,
  }) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.register,
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'mobileNumber': mobileNumber,
        'password': password,
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
}
