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

  // Users
  static const String usersMe = '/users/me';
  static const String usersProfile = '/users/profile';

  // Pets
  static const String pets = '/pets';
  static String pet(String id) => '/pets/$id';

  // Species / breeds (lookup data for the create-pet form)
  static const String species = '/species';
  static String speciesBreeds(int speciesId) => '/species/$speciesId/breeds';
  static String speciesVision(int speciesId) => '/species/$speciesId/vision';
  static String speciesVisionByName(String speciesName) =>
      '/species/vision/$speciesName';
  static const String speciesVisionAll = '/species/vision';
  static String petMedicalRecords(String petId) =>
      '/pets/$petId/medical-records';
  static String petVaccinations(String petId) => '/pets/$petId/vaccinations';

  // Health
  static const String reminders = '/reminders';
  static String reminder(String id) => '/reminders/$id';
  static const String healthLogs = '/health-logs';

  // Lost & Found
  static const String lostFoundDashboard = '/lost-found/dashboard';
  static const String lostFoundListings = '/lost-found/listings';
  static String lostFoundListing(int id) => '/lost-found/listings/$id';
  static String lostFoundListingResolve(int id) =>
      '/lost-found/listings/$id/resolve';
  static const String lostFoundVolunteer = '/lost-found/volunteer';

  // AI Assistant
  static const String aiChat = '/ai/chat';

  // Services directory
  static const String services = '/services';

  // Community
  static const String posts = '/community/posts';
  static String post(String id) => '/community/posts/$id';
  static String postLike(String id) => '/community/posts/$id/like';
  static String postComments(String id) => '/community/posts/$id/comments';

  // Media (avatars, pet documents, etc.)
  static const String mediaUploadUrl = '/media/upload-url';
  static String mediaConfirm(String assetId) => '/media/$assetId/confirm';
  static String media(String assetId) => '/media/$assetId';

  // Geocoding (reverse: coordinates → street address)
  static const String geocodeReverse = '/geocode/reverse';
}
