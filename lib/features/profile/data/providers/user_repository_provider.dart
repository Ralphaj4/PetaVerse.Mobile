import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/storage/hive_service.dart';
import '../datasources/user_datasource.dart';
import '../datasources/user_local_datasource.dart';
import '../repositories/user_repository.dart';

part 'user_repository_provider.g.dart';

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) => UserRepository(
      UserDatasource(ref.watch(apiClientProvider)),
      UserLocalDataSource(ref.watch(hiveServiceProvider)),
    );
