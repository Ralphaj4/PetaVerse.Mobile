import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_tokens_dto.freezed.dart';
part 'auth_tokens_dto.g.dart';

/// Response from `verify-phone` and `login`: the full token pair plus
/// the authenticated user's id and roles.
@freezed
abstract class AuthTokensDto with _$AuthTokensDto {
  const factory AuthTokensDto({
    required String accessToken,
    required String refreshToken,
    @Default('') String userId,
    @Default(<String>[]) List<String> roles,
  }) = _AuthTokensDto;

  factory AuthTokensDto.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensDtoFromJson(json);
}
