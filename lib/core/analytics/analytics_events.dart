/// Canonical analytics event names.
///
/// Sensitive medical information must never be attached as parameters.
abstract final class AnalyticsEvents {
  static const String petCreated = 'PetCreated';
  static const String appointmentBooked = 'AppointmentBooked';
  static const String medicationCompleted = 'MedicationCompleted';
  static const String vaccinationAdded = 'VaccinationAdded';
  static const String aiChatStarted = 'AIChatStarted';
  static const String purchaseCompleted = 'PurchaseCompleted';
  static const String sosActivated = 'SOSActivated';
  static const String lostPetReported = 'LostPetReported';
  static const String foundPetReported = 'FoundPetReported';
  static const String postCreated = 'PostCreated';
  static const String reminderCreated = 'ReminderCreated';
  static const String communityCreated = 'CommunityCreated';
  static const String communityJoined = 'CommunityJoined';
}
