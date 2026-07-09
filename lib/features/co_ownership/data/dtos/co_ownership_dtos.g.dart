// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'co_ownership_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PublicUserCardDto _$PublicUserCardDtoFromJson(Map<String, dynamic> json) =>
    _PublicUserCardDto(
      id: json['id'] as String,
      userCode: json['userCode'] as String,
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String?,
      hasBeenInvited: json['hasBeenInvited'] as bool? ?? false,
    );

Map<String, dynamic> _$PublicUserCardDtoToJson(_PublicUserCardDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userCode': instance.userCode,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatarUrl': instance.avatarUrl,
      'hasBeenInvited': instance.hasBeenInvited,
    };

_PetOwnerDto _$PetOwnerDtoFromJson(Map<String, dynamic> json) => _PetOwnerDto(
  id: json['id'] as String,
  userCode: json['userCode'] as String,
  firstName: json['firstName'] as String? ?? '',
  lastName: json['lastName'] as String? ?? '',
  avatarUrl: json['avatarUrl'] as String?,
  isPrimaryOwner: json['isPrimary'] as bool? ?? false,
);

Map<String, dynamic> _$PetOwnerDtoToJson(_PetOwnerDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userCode': instance.userCode,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatarUrl': instance.avatarUrl,
      'isPrimary': instance.isPrimaryOwner,
    };

_SentCoOwnerInviteDto _$SentCoOwnerInviteDtoFromJson(
  Map<String, dynamic> json,
) => _SentCoOwnerInviteDto(
  id: (json['id'] as num).toInt(),
  status:
      $enumDecodeNullable(_$CoOwnershipStatusJsonEnumMap, json['status']) ??
      CoOwnershipStatusJson.pending,
  invitee: PublicUserCardDto.fromJson(json['invitee'] as Map<String, dynamic>),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$SentCoOwnerInviteDtoToJson(
  _SentCoOwnerInviteDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'status': _$CoOwnershipStatusJsonEnumMap[instance.status]!,
  'invitee': instance.invitee,
  'createdAt': instance.createdAt?.toIso8601String(),
};

const _$CoOwnershipStatusJsonEnumMap = {
  CoOwnershipStatusJson.pending: 1,
  CoOwnershipStatusJson.accepted: 2,
  CoOwnershipStatusJson.declined: 3,
  CoOwnershipStatusJson.cancelled: 4,
};

_IncomingCoOwnerInviteDto _$IncomingCoOwnerInviteDtoFromJson(
  Map<String, dynamic> json,
) => _IncomingCoOwnerInviteDto(
  id: (json['id'] as num).toInt(),
  status:
      $enumDecodeNullable(_$CoOwnershipStatusJsonEnumMap, json['status']) ??
      CoOwnershipStatusJson.pending,
  pet: InvitePetDto.fromJson(json['pet'] as Map<String, dynamic>),
  inviter: InviteInviterDto.fromJson(json['inviter'] as Map<String, dynamic>),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$IncomingCoOwnerInviteDtoToJson(
  _IncomingCoOwnerInviteDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'status': _$CoOwnershipStatusJsonEnumMap[instance.status]!,
  'pet': instance.pet,
  'inviter': instance.inviter,
  'createdAt': instance.createdAt?.toIso8601String(),
};

_InvitePetDto _$InvitePetDtoFromJson(Map<String, dynamic> json) =>
    _InvitePetDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      speciesName: json['speciesName'] as String? ?? '',
      breedName: json['breedName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$InvitePetDtoToJson(_InvitePetDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'speciesName': instance.speciesName,
      'breedName': instance.breedName,
      'avatarUrl': instance.avatarUrl,
    };

_InviteInviterDto _$InviteInviterDtoFromJson(Map<String, dynamic> json) =>
    _InviteInviterDto(
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$InviteInviterDtoToJson(_InviteInviterDto instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatarUrl': instance.avatarUrl,
    };
