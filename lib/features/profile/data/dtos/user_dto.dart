import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required String firstName,
    required String lastName,
    String? email,
    String? pendingEmail,
    required String mobileNumber,
    required bool mobileVerified,
    DateTime? dateOfBirth,
    String? avatarUrl,
    required List<String> roles,
    required DateTime createdAt,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  const UserDto._();

  User toEntity() => User(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        pendingEmail: pendingEmail,
        mobileNumber: mobileNumber,
        mobileVerified: mobileVerified,
        dateOfBirth: dateOfBirth,
        avatarUrl: avatarUrl,
        roles: roles,
        createdAt: createdAt,
      );
}
