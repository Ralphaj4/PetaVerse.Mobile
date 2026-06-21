class User {
  final String id;
  final String firstName;
  final String lastName;
  final String? email;
  final String? pendingEmail;
  final String mobileNumber;
  final bool mobileVerified;
  final DateTime? dateOfBirth;
  final String? avatarUrl;
  final List<String> roles;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.pendingEmail,
    required this.mobileNumber,
    required this.mobileVerified,
    this.dateOfBirth,
    this.avatarUrl,
    required this.roles,
    required this.createdAt,
  });
}
