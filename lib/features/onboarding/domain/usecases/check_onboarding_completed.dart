import '../repositories/onboarding_repository.dart';

class CheckOnboardingCompleted {
  const CheckOnboardingCompleted(this._repository);

  final OnboardingRepository _repository;

  Future<bool> call() => _repository.isCompleted();
}
