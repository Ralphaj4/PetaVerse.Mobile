import '../../../../core/errors/result.dart';
import '../entities/auth_session.dart';
import '../entities/login_outcome.dart';

/// Contract for authentication against the PetsApp API.
///
/// All methods return [Result] — exceptions never cross this boundary.
abstract interface class AuthRepository {
  /// Registers a new user. The backend sends an OTP to the mobile number;
  /// no tokens are issued until the phone is verified. Returns the dev OTP
  /// echoed by the Development backend (null in production).
  Future<Result<String?>> register({
    required String firstName,
    required String lastName,
    required String mobileNumber,
    required String password,
    required double latitude,
    required double longitude,
    required String locationName,
    String? email,
  });

  /// Requests a fresh OTP for an existing, not-yet-verified account.
  /// Returns the dev OTP (null in production).
  Future<Result<String?>> resendOtp({required String mobileNumber});

  /// Confirms the registration OTP and returns an authenticated session.
  Future<Result<AuthSession>> verifyPhone({
    required String mobileNumber,
    required String otp,
  });

  /// Authenticates with mobile number + password.
  ///
  /// Returns a [LoginAuthenticated] (tokens issued) or, for an unverified
  /// account, a [LoginNeedsVerification] (the backend resent an OTP — the
  /// caller must route to OTP entry).
  Future<Result<LoginOutcome>> login({
    required String mobileNumber,
    required String password,
  });

  /// Starts a password reset — backend sends an OTP to the mobile number.
  /// Returns the dev OTP (null in production).
  Future<Result<String?>> forgotPassword({required String mobileNumber});

  /// Completes a password reset with the OTP and a new password.
  Future<Result<void>> resetPassword({
    required String mobileNumber,
    required String otp,
    required String newPassword,
  });

  /// Changes the authenticated user's password (JWT, no OTP).
  Future<Result<void>> changePassword({
    required String oldPassword,
    required String newPassword,
  });

  /// Revokes the stored refresh token and clears local credentials.
  Future<Result<void>> logout();

  /// Whether a session token is currently stored locally.
  Future<bool> hasSession();
}
