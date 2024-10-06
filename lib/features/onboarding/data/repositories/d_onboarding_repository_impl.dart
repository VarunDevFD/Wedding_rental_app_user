import 'package:vr_wedding_rental/features/onboarding/domain/repositories/r_onboarding_repository.dart';

import '../../domain/entities/d_onboarding_page.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  @override
  Future<List<OnboardingPage>> getOnboardingPages() async {
    // Example data. Replace with actual data source.
    return [
      OnboardingPage(
        text: 'Welcome to the VR Wedding',
        subText:
            'Choose reserve and rent wedding items in a few simple steps Convenient delivery',
        imagePath: 'assets/images/onboarding_1.png',
      ),
      OnboardingPage(
        text: 'Organize your Rentals',
        subText: 'Manage wedding rentals easily.',
        imagePath: 'assets/images/onboarding_2.png',
      ),
      OnboardingPage(
        text: 'Easy Booking',
        subText: 'Book wedding services with a few clicks.',
        imagePath: 'assets/images/onboarding_3.png',
      ),
    ];
  }
}
