class User {
  final String id;

  /// Short, public, shareable account identifier (e.g. "a1b2c3d4"), issued by
  /// the backend. Distinct from [id] — safe to show to the user and share.
  final String userCode;
  final String firstName;
  final String lastName;
  final String? email;
  final String? pendingEmail;
  final String mobileNumber;
  final bool mobileVerified;
  final DateTime? dateOfBirth;
  final String? avatarUrl;
  final double? latitude;
  final double? longitude;
  final String? locationName;
  final List<String> roles;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.userCode,
    required this.firstName,
    required this.lastName,
    this.email,
    this.pendingEmail,
    required this.mobileNumber,
    required this.mobileVerified,
    this.dateOfBirth,
    this.avatarUrl,
    this.latitude,
    this.longitude,
    this.locationName,
    required this.roles,
    required this.createdAt,
  });
}
