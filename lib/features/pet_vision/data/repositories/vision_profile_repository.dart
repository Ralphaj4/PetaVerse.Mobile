import '../../../../core/errors/result.dart';
import '../datasources/vision_profile_remote_datasource.dart';
import '../../domain/entities/vision_profile.dart';

abstract class IVisionProfileRepository {
  Future<Result<VisionProfile?>> getBySpeciesId(int speciesId);
  Future<Result<VisionProfile?>> getBySpeciesName(String speciesName);
  Future<Result<List<VisionProfile>>> getAll();
}

class VisionProfileRepository implements IVisionProfileRepository {
  final VisionProfileRemoteDatasource _remoteDatasource;

  VisionProfileRepository(this._remoteDatasource);

  @override
  Future<Result<VisionProfile?>> getBySpeciesId(int speciesId) =>
      _remoteDatasource.getBySpeciesId(speciesId);

  @override
  Future<Result<VisionProfile?>> getBySpeciesName(String speciesName) =>
      _remoteDatasource.getBySpeciesName(speciesName);

  @override
  Future<Result<List<VisionProfile>>> getAll() =>
      _remoteDatasource.getAll();
}
