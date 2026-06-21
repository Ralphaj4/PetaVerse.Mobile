import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasources/vision_profile_remote_datasource.dart';
import '../../data/repositories/vision_profile_repository.dart';

part 'vision_profile_repository_provider.g.dart';

@Riverpod(keepAlive: true)
VisionProfileRepository visionProfileRepository(Ref ref) => VisionProfileRepository(
      VisionProfileRemoteDatasource(ref.watch(apiClientProvider)),
    );
