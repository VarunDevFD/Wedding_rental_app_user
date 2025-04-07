
import 'package:vr_wedding_rental/features/onboarding/domain/repositories/r_onboarding_repository.dart';

class CompleteOnboardingUseCase {
  final OnboardingRepository repository;

  CompleteOnboardingUseCase(this.repository);

  Future<void> execute() {
    return repository.setOnboardingComplete();
  }
}