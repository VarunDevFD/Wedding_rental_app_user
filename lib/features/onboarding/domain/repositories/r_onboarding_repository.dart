import 'package:vr_wedding_rental/features/onboarding/domain/entities/d_onboarding_page.dart';

abstract class OnboardingRepository {
  Future<List<OnboardingPage>> getOnboardingPages();
}
