import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/onboarding_repository_impl.dart';
import '../../domain/usecases/check_onboarding_completed.dart';
import '../../domain/usecases/complete_onboarding.dart';

part 'onboarding_provider.g.dart';

@Riverpod(keepAlive: true)
Future<bool> onboardingCompleted(Ref ref) {
  final repo = ref.read(onboardingRepositoryProvider);
  return CheckOnboardingCompleted(repo).call();
}

@riverpod
class OnboardingNotifier extends _$OnboardingNotifier {
  @override
  int build() => 0;

  void next(int totalSlides) {
    if (state < totalSlides - 1) state++;
  }

  void goTo(int index) => state = index;

  Future<void> complete() async {
    final repo = ref.read(onboardingRepositoryProvider);
    await CompleteOnboarding(repo).call();
    ref.invalidate(onboardingCompletedProvider);
  }
}
