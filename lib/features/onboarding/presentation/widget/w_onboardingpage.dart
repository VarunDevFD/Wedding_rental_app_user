import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_text_styles.dart';
import 'package:vr_wedding_rental/features/onboarding/domain/entities/d_onboarding_page.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingPageEntity pageData;

  const OnboardingPage({
    super.key,
    required this.pageData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 450.h,
          width: 380.w,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(pageData.imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
          SizedBox(height: 20.h),
        Center(
          child: Padding(
            padding:   EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  pageData.text,
                  style: AppTextStyles.titleStyle,
                  textAlign: TextAlign.center,
                ),
                  SizedBox(height: 10.h),
                Text(
                  pageData.subText,
                  style: AppTextStyles.subTitleStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}/*
class OnboardingPageWidget extends StatelessWidget {
  final String imagePath;
  final String text;
  final String subText;
  final VoidCallback onSkipPressed;
  final VoidCallback onContinuePressed;
  final bool isLastPage;

  const OnboardingPageWidget({
    super.key,
    required this.imagePath,
    required this.text,
    required this.subText,
    required this.onSkipPressed,
    required this.onContinuePressed,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Center(
                child: Image.asset(
                  imagePath,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      text,
                      style: AppTextStyles.titleStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      subText,
                      style: AppTextStyles.subTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomButton(
                  text: isLastPage ? 'Get Started' : 'Continue',
                  onPressed: onContinuePressed,
                ),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
        Positioned(
          top: 40,
          right: 20,
          child: isLastPage
              ? const SizedBox()
              : TextButton(
                  onPressed: onSkipPressed,
                  child: Text(
                    'Skip',
                    style: AppTextStyles.buttonTextStyle,
                  ),
                ),
        ),
      ],
    );
  }
}
*/

