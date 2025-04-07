import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vr_wedding_rental/core/shr_pref/repository/preference_repository.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_colors.dart';
import 'package:vr_wedding_rental/core/utils/widgets/custom_button.dart';
import 'package:vr_wedding_rental/core/utils/widgets/custom_text.dart';
import 'package:vr_wedding_rental/features/onboarding/presentation/bloc/onboarding_bloc/onboarding_bloc.dart';
import 'package:vr_wedding_rental/features/onboarding/presentation/bloc/onboarding_bloc/onboarding_state.dart';
import 'package:vr_wedding_rental/features/onboarding/presentation/widget/w_onboardingpage.dart';

class OnBoardingScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            if (state.isLoading) {
              const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(child: Text(state.error!));
            }
            return Stack(
              children: [
                PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    context.read<OnboardingCubit>().nextPage(index);
                  },
                  children: state.pages
                      .map((page) =>
                          Center(child: OnboardingPage(pageData: page)))
                      .toList(),
                ),
                if (state.currentPage < state.pages.length - 1)
                  Positioned(
                    top: 40.h,
                    right: 20.w,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.buttonTextColor,
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        context.read<OnboardingCubit>().skipToEnd();
                        _pageController.jumpToPage(state.pages.length - 1);
                      },
                      child: const CustomText(
                        text: 'Skip',
                        styleType: TextStyleType.body,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 30.h,
                  left: 20.w,
                  right: 20.w,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          state.pages.length,
                          (index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.0.w),
                            width: 8.0.w,
                            height: 8.0.h,
                            decoration: BoxDecoration(
                              color: state.currentPage == index
                                  ? AppColors.white
                                  : AppColors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      CustomButton(
                        onPressed: state.currentPage == state.pages.length - 1
                            ? () {
                                // Set shared preference and then navigate
                                PreferencesRepository()
                                    .setHasSeenOnboarding(true)
                                    .then((_) {
                                  // ignore: use_build_context_synchronously
                                  context.go(
                                      '/welcome'); // Use context after async call completes
                                });
                              }
                            : () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                        text: (state.currentPage == state.pages.length - 1
                            ? 'Get Started'
                            : 'Next'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
