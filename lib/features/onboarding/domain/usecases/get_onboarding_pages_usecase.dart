import 'package:vr_wedding_rental/features/onboarding/domain/entities/d_onboarding_page.dart';
import 'package:vr_wedding_rental/features/onboarding/domain/repositories/r_onboarding_repository.dart';

class GetOnboardingPagesUseCase {
  final OnboardingRepository repository;

  GetOnboardingPagesUseCase(this.repository);

  Future<List<OnboardingPageEntity>> call() {
    return repository.getOnboardingPages();
  }
}
