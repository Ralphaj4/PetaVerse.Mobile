import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_local_datasource.g.dart';

const _boxName = 'preferences';
const _onboardingDoneKey = 'onboarding_completed';

class OnboardingLocalDataSource {
  const OnboardingLocalDataSource();

  Future<bool> isCompleted() async {
    final box = await Hive.openBox<bool>(_boxName);
    return box.get(_onboardingDoneKey, defaultValue: false)!;
  }

  Future<void> markCompleted() async {
    final box = await Hive.openBox<bool>(_boxName);
    await box.put(_onboardingDoneKey, true);
  }
}

@Riverpod(keepAlive: true)
OnboardingLocalDataSource onboardingLocalDataSource(Ref ref) =>
    const OnboardingLocalDataSource();
