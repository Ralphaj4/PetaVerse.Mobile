import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/storage/hive_service.dart';
import '../../data/datasources/pet_local_datasource.dart';
import '../../data/datasources/pet_remote_datasource.dart';
import '../../data/repositories/pet_repository_impl.dart';
import '../../domain/repositories/pet_repository.dart';

part 'pet_repository_provider.g.dart';

@Riverpod(keepAlive: true)
PetRepository petRepository(Ref ref) => PetRepositoryImpl(
      remote: PetRemoteDataSource(ref.watch(apiClientProvider)),
      local: PetLocalDataSource(ref.watch(hiveServiceProvider)),
    );
