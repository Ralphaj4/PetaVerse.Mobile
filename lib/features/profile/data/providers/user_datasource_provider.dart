import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../datasources/user_datasource.dart';

part 'user_datasource_provider.g.dart';

@riverpod
IUserDatasource userDatasource(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return UserDatasource(apiClient);
}
