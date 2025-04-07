import 'package:vr_wedding_rental/features/onboarding/domain/entities/d_onboarding_page.dart';
import 'package:vr_wedding_rental/features/onboarding/domain/repositories/r_onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  @override
  Future<List<OnboardingPageEntity>> getOnboardingPages() async {
    // Example data. Replace with actual data source.
    return [
      OnboardingPageEntity(
        text: 'Welcome to the VR Wedding',
        subText:
            'Choose reserve and rent wedding items in a few simple steps Convenient delivery',
        imagePath:
            'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/user/onboarding_1.png',
      ),
      OnboardingPageEntity(
        text: 'Organize your Rentals',
        subText: 'Manage wedding rentals easily.',
        imagePath:
            'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/user/onboarding_2.png',
      ),
      OnboardingPageEntity(
        text: 'Easy Booking',
        subText: 'Book wedding services with a few clicks.',
        imagePath:
            'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/user/onboarding_3.png',
      ),
    ];
  }

  @override
  Future<void> setOnboardingComplete() async {
    // Implement storage logic
  }
  @override
  Future<bool> isOnboardingComplete() async {
    // Implement check logic
    return false;
  }
}
