import 'dart:developer';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_colors.dart';
import 'package:vr_wedding_rental/features/onboarding/presentation/widget/w_onboardingpage.dart';

import '../../../data/repositories/d_onboarding_repository_impl.dart';
import '../../../domain/usecases/get_onboarding_pages_usecase.dart';
import '../../bloc/onboarding_bloc/onboarding_bloc.dart';
import '../../bloc/onboarding_bloc/onboarding_event.dart';
import '../../bloc/onboarding_bloc/onboarding_state.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return BlocProvider(
      create: (_) =>
          OnboardingBloc(GetOnboardingPagesUseCase(OnboardingRepositoryImpl()))
            ..add(LoadOnboarding()),
      child: Scaffold(
        body: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            if (state is OnboardingLoaded) {
              return ColorfulSafeArea(
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: state.pages.length,
                        itemBuilder: (context, index) {
                          final page = state.pages[index];

                          // Define isLastPage inside itemBuilder
                          final bool isLastPage =
                              index == state.pages.length - 1;

                          return OnboardingPageWidget(
                            imagePath: page.imagePath,
                            text: page.text,
                            subText: page.subText,
                            onSkipPressed: () {
                              pageController.jumpToPage(state.pages.length - 1);
                            },
                            onContinuePressed: () {
                              if (isLastPage) {
                                log("Keri");
                                context.go('/welcome');
                              } else {
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 96),
                                  curve: Curves.easeIn,
                                );
                              }
                            },
                            isLastPage: isLastPage,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: state.pages.length,
                        effect: JumpingDotEffect(
                          dotWidth: 8.w,
                          dotHeight: 8.h,
                          spacing: 16.w,
                          activeDotColor: AppColors.buttonTextColor,
                          dotColor: AppColors.backgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
