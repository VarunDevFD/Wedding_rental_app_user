import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:vr_wedding_rental/core/utils/theme/app_text_styles.dart';
import 'package:vr_wedding_rental/core/utils/widgets/custom_buttom.dart';

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
                  width: 250.w,
                  height: 250.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Text(
                      text,
                      style: AppTextStyles.titleStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      subText,
                      style: AppTextStyles.subTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomButton(
                  text: isLastPage ? 'Get Started' : 'Continue',
                  onPressed: onContinuePressed,
                ),
              ],
            ),
            SizedBox(height: 50.h),
          ],
        ),
        Positioned(
          top: 40.h,
          right: 20.w,
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
