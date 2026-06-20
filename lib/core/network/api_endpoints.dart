/// All backend endpoint paths, centralized.
abstract final class ApiEndpoints {
  // Auth
  static const String register = '/auth/register';
  static const String resendOtp = '/auth/resend-otp';
  static const String verifyPhone = '/auth/verify-phone';
  static const String login = '/auth/login';
  static const String refreshToken = '/auth/refresh';
  static const String revokeToken = '/auth/revoke';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String changePassword = '/auth/change-password';

  // Pets
  static const String pets = '/pets';
  static String pet(String id) => '/pets/$id';

  // Species / breeds (lookup data for the create-pet form)
  static const String species = '/species';
  static String speciesBreeds(int speciesId) => '/species/$speciesId/breeds';
  static String petMedicalRecords(String petId) =>
      '/pets/$petId/medical-records';
  static String petVaccinations(String petId) => '/pets/$petId/vaccinations';

  // Health
  static const String reminders = '/reminders';
  static String reminder(String id) => '/reminders/$id';
  static const String healthLogs = '/health-logs';

  // Lost & Found
  static const String lostFoundReports = '/lost-found/reports';
  static String lostFoundReport(String id) => '/lost-found/reports/$id';

  // AI Assistant
  static const String aiChat = '/ai/chat';

  // Services directory
  static const String services = '/services';

  // Community
  static const String posts = '/community/posts';
  static String post(String id) => '/community/posts/$id';
  static String postLike(String id) => '/community/posts/$id/like';
  static String postComments(String id) => '/community/posts/$id/comments';
}
