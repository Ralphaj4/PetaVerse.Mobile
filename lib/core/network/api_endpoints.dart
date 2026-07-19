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
  static const String userLookup = '/users/lookup';

  // Co-ownership invitations (invitee side, under /users/me)
  static const String myCoOwnerInvites = '/users/me/co-owner-invites';
  static String acceptCoOwnerInvite(int id) =>
      '/users/me/co-owner-invites/$id/accept';
  static String declineCoOwnerInvite(int id) =>
      '/users/me/co-owner-invites/$id/decline';

  // Pets
  static const String pets = '/pets';
  static String pet(String id) => '/pets/$id';

  // Co-ownership invitations (owner side, under a pet)
  static String petCoOwnerInvites(int petId) => '/pets/$petId/co-owner-invites';
  static String cancelCoOwnerInvite(int petId, int id) =>
      '/pets/$petId/co-owner-invites/$id/cancel';

  // Pet owners (primary owner + accepted co-owners)
  static String petOwners(int petId) => '/pets/$petId/owners';
  static String petOwner(int petId, String userId) =>
      '/pets/$petId/owners/$userId';

  // Species / breeds (lookup data for the create-pet form)
  static const String species = '/species';
  static String speciesBreeds(int speciesId) => '/species/$speciesId/breeds';
  static String speciesVision(int speciesId) => '/species/$speciesId/vision';
  static String speciesVisionByName(String speciesName) =>
      '/species/vision/$speciesName';
  static const String speciesVisionAll = '/species/vision';

  // Pet attribute lookups (size / coat color for the create-pet form)
  static const String petSizes = '/pet-attributes/sizes';
  static const String coatColors = '/pet-attributes/coat-colors';
  static String petMedicalRecords(String petId) =>
      '/pets/$petId/medical-records';
  static String petVaccinations(String petId) => '/pets/$petId/vaccinations';
  static String petVaccination(int petId, int vaccinationId) =>
      '/pets/$petId/vaccinations/$vaccinationId';

  // Health
  static const String reminders = '/reminders';
  static String reminder(String id) => '/reminders/$id';
  static const String healthLogs = '/health-logs';

  // PawCare — weight (under a pet)
  static String petWeight(int petId) => '/pets/$petId/weight';
  static String petWeightLatest(int petId) => '/pets/$petId/weight/latest';
  static String petWeightRecord(int petId, int weightId) =>
      '/pets/$petId/weight/$weightId';

  // PawCare — medications (under a pet)
  static String petMedications(int petId) => '/pets/$petId/medications';
  static String markMedicationGiven(int petId, int medId) =>
      '/pets/$petId/medications/$medId/mark-given';
  static String petMedication(int petId, int medId) =>
      '/pets/$petId/medications/$medId';
  static const String upcomingMedications = '/medications/upcoming';

  // PawCare — lookups
  static const String medicationLookups = '/lookups/medications';
  static const String vaccineLookups = '/lookups/vaccines';

  // Lost & Found
  static const String lostFoundDashboard = '/lost-found/dashboard';
  static const String lostFoundListings = '/lost-found/listings';
  static String lostFoundListing(int id) => '/lost-found/listings/$id';
  static String lostFoundListingResolve(int id) =>
      '/lost-found/listings/$id/resolve';
  static const String lostFoundVolunteer = '/lost-found/volunteer';

  // Adoption — board / discovery
  static const String adoptionListings = '/adoption/listings';
  static String adoptionListing(int id) => '/adoption/listings/$id';

  // Adoption — lister side (under a listing)
  static String adoptionListingRequests(int listingId) =>
      '/adoption/listings/$listingId/requests';
  static String approveAdoptionRequest(int listingId, int reqId) =>
      '/adoption/listings/$listingId/requests/$reqId/approve';
  static String rejectAdoptionRequest(int listingId, int reqId) =>
      '/adoption/listings/$listingId/requests/$reqId/reject';
  // Owner triggers the irreversible transfer (enabled only once the adopter has
  // accepted) → 200 PetResponse.
  static String completeAdoptionRequest(int listingId, int reqId) =>
      '/adoption/listings/$listingId/requests/$reqId/complete';
  static String withdrawAdoptionListing(int id) =>
      '/adoption/listings/$id/withdraw';

  // Adoption — "my stuff" under /users/me
  static const String myAdoptionListings = '/users/me/adoption-listings';
  static const String myAdoptionRequests = '/users/me/adoption-requests';
  static String cancelMyAdoptionRequest(int reqId) =>
      '/users/me/adoption-requests/$reqId/cancel';
  // Adopter opts in to an approved request ("I'll take it") — records consent,
  // does NOT transfer → 200 updated MyAdoptionRequest.
  static String acceptMyAdoptionRequest(int reqId) =>
      '/users/me/adoption-requests/$reqId/accept';

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

  // Walk activities (under a pet)
  static String petActivities(int petId) => '/pets/$petId/activities';
  static String petActivity(int petId, int activityId) =>
      '/pets/$petId/activities/$activityId';

  // Geocoding (reverse: coordinates → street address)
  static const String geocodeReverse = '/geocode/reverse';
}
