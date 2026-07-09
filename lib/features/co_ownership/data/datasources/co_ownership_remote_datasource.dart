import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../pets/data/dtos/pet_dto.dart';
import '../dtos/co_ownership_dtos.dart';

/// Remote co-ownership data source. Talks to the API exclusively through
/// [ApiClient]; never touches Dio directly. Throws AppExceptions (mapped by
/// ApiClient) — the repository turns those into Failures.
class CoOwnershipRemoteDataSource {
  const CoOwnershipRemoteDataSource(this._client);

  final ApiClient _client;

  /// GET /users/lookup?code={code}&petId={petId} → PublicUserCard (404 when no
  /// match). [petId] scopes the `hasBeenInvited` flag to that pet.
  Future<PublicUserCardDto> lookupByCode(String code, {int? petId}) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.userLookup,
      queryParameters: {
        'code': code,
        'petId': ?petId,
      },
    );
    return PublicUserCardDto.fromJson(data);
  }

  /// POST /pets/{petId}/co-owner-invites → 201 CoOwnerInvite. The extra
  /// `petId` field in the body is ignored when parsing as a sent invite.
  Future<SentCoOwnerInviteDto> sendInvite({
    required int petId,
    required String userCode,
  }) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.petCoOwnerInvites(petId),
      data: {'userCode': userCode},
    );
    return SentCoOwnerInviteDto.fromJson(data);
  }

  /// GET /users/me/co-owner-invites → array of IncomingCoOwnerInvite.
  Future<List<IncomingCoOwnerInviteDto>> getIncoming() async {
    final data = await _client.get<List<dynamic>>(ApiEndpoints.myCoOwnerInvites);
    return data
        .map((e) => IncomingCoOwnerInviteDto.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  /// POST /users/me/co-owner-invites/{id}/accept → 200 full PetResponse.
  Future<PetDto> acceptInvite(int id) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.acceptCoOwnerInvite(id),
    );
    return PetDto.fromJson(data);
  }

  /// POST /users/me/co-owner-invites/{id}/decline → 204 No Content.
  Future<void> declineInvite(int id) async {
    await _client.post<void>(ApiEndpoints.declineCoOwnerInvite(id));
  }

  /// GET /pets/{petId}/co-owner-invites → array of SentCoOwnerInvite.
  Future<List<SentCoOwnerInviteDto>> getSent(int petId) async {
    final data = await _client.get<List<dynamic>>(
      ApiEndpoints.petCoOwnerInvites(petId),
    );
    return data
        .map((e) => SentCoOwnerInviteDto.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  /// POST /pets/{petId}/co-owner-invites/{id}/cancel → 204 No Content.
  Future<void> cancelInvite({required int petId, required int id}) async {
    await _client.post<void>(ApiEndpoints.cancelCoOwnerInvite(petId, id));
  }

  /// GET /pets/{petId}/owners → array of PetOwner (primary owner + co-owners).
  Future<List<PetOwnerDto>> getOwners(int petId) async {
    final data = await _client.get<List<dynamic>>(
      ApiEndpoints.petOwners(petId),
    );
    return data
        .map((e) => PetOwnerDto.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  /// DELETE /pets/{petId}/owners/{userId} → 204. Primary owner removes a
  /// co-owner, or a co-owner removes themselves (leave).
  Future<void> removeOwner({required int petId, required String userId}) async {
    await _client.delete<void>(ApiEndpoints.petOwner(petId, userId));
  }
}
