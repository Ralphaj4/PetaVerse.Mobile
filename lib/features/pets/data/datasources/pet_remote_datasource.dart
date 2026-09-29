import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/entities/new_pet.dart';
import '../dtos/breed_dto.dart';
import '../dtos/coat_color_dto.dart';
import '../dtos/create_pet_response_dto.dart';
import '../dtos/pet_dto.dart';
import '../dtos/pet_size_dto.dart';
import '../dtos/species_dto.dart';

/// Remote pet data source. Talks to the API exclusively through
/// [ApiClient]; never touches Dio directly. Throws AppExceptions
/// (mapped by ApiClient) — the repository turns those into Failures.
class PetRemoteDataSource {
  const PetRemoteDataSource(this._client);

  final ApiClient _client;

  /// GET /api/pets → array of PetResponse (empty array when none).
  Future<List<PetDto>> getMyPets() async {
    final data = await _client.get<List<dynamic>>(ApiEndpoints.pets);
    return data
        .map((e) => PetDto.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  /// POST /api/pets → the slim CreatePetResponse (`{id, name, imagePath}`).
  /// Only the required fields are sent; the backend trims the name and
  /// validates that the breed exists.
  Future<CreatePetResponseDto> createPet(NewPet pet) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.pets,
      data: {
        'name': pet.name,
        'speciesId': pet.speciesId,
        'breedId': pet.breedId,
        'dateOfBirth': pet.dateOfBirth.toUtc().toIso8601String(),
        'gender': pet.gender,
        if (pet.sizeId != null) 'sizeId': pet.sizeId,
        if (pet.coatColorId != null) 'coatColorId': pet.coatColorId,
        if (pet.microchipNumber != null) 'microchipNumber': pet.microchipNumber,
        if (pet.microchipLocation != null) 'microchipLocation': pet.microchipLocation,
        if (pet.sterilizationStatus != null) 'sterilizationStatus': pet.sterilizationStatus,
        if (pet.sterilizationDate != null)
          'sterilizationDate': pet.sterilizationDate!.toUtc().toIso8601String(),
      },
    );
    return CreatePetResponseDto.fromJson(json);
  }

  /// GET /api/pets/{id} → full PetResponse.
  Future<PetDto> getPetById(int id) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.pet(id.toString()),
    );
    return PetDto.fromJson(data);
  }

  /// PUT /api/pets/{id} → updated PetResponse.
  Future<PetDto> updatePet(int id, NewPet pet) async {
    final data = await _client.put<Map<String, dynamic>>(
      ApiEndpoints.pet(id.toString()),
      data: {
        'name': pet.name,
        'speciesId': pet.speciesId,
        'breedId': pet.breedId,
        'dateOfBirth': pet.dateOfBirth.toUtc().toIso8601String(),
        'gender': pet.gender,
        // Always sent (even as null) so the user can clear a previously-set
        // size / coat color back to "not specified" on a PUT.
        'sizeId': pet.sizeId,
        'coatColorId': pet.coatColorId,
        if (pet.microchipNumber != null) 'microchipNumber': pet.microchipNumber,
        if (pet.microchipLocation != null)
          'microchipLocation': pet.microchipLocation,
        if (pet.sterilizationStatus != null)
          'sterilizationStatus': pet.sterilizationStatus,
        if (pet.sterilizationDate != null)
          'sterilizationDate':
              pet.sterilizationDate!.toUtc().toIso8601String(),
      },
    );
    return PetDto.fromJson(data);
  }

  /// DELETE /api/pets/{id} → 204 No Content.
  Future<void> deletePet(int id) async {
    await _client.delete<void>(ApiEndpoints.pet(id.toString()));
  }

  /// GET /api/species → array of SpeciesResponse.
  Future<List<SpeciesDto>> getSpecies() async {
    final data = await _client.get<List<dynamic>>(ApiEndpoints.species);
    return data
        .map((e) => SpeciesDto.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  /// GET /api/species/{id}/breeds → array of BreedResponse.
  Future<List<BreedDto>> getBreeds(int speciesId) async {
    final data = await _client.get<List<dynamic>>(
      ApiEndpoints.speciesBreeds(speciesId),
    );
    return data
        .map((e) => BreedDto.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  /// GET /api/pet-attributes/sizes → array of `{id, name}`.
  Future<List<PetSizeDto>> getPetSizes() async {
    final data = await _client.get<List<dynamic>>(ApiEndpoints.petSizes);
    return data
        .map((e) => PetSizeDto.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  /// GET /api/pet-attributes/coat-colors → array of `{id, name}`.
  Future<List<CoatColorDto>> getCoatColors() async {
    final data = await _client.get<List<dynamic>>(ApiEndpoints.coatColors);
    return data
        .map((e) => CoatColorDto.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }
}
