import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/user_repository.dart';
import 'user_datasource_provider.dart';

part 'user_repository_provider.g.dart';

@riverpod
UserRepository userRepository(Ref ref) {
  final datasource = ref.watch(userDatasourceProvider);
  return UserRepository(datasource);
}
