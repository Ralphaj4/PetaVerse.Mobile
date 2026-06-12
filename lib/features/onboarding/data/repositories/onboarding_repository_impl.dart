import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_datasource.dart';

part 'onboarding_repository_impl.g.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._dataSource);

  final OnboardingLocalDataSource _dataSource;

  @override
  Future<bool> isCompleted() => _dataSource.isCompleted();

  @override
  Future<void> markCompleted() => _dataSource.markCompleted();
}

@Riverpod(keepAlive: true)
OnboardingRepository onboardingRepository(Ref ref) => OnboardingRepositoryImpl(
      ref.read(onboardingLocalDataSourceProvider),
    );
