import 'dart:ui';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Direct navigation logic instead of BLoC
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        context.go('/onboarding');
      });
    });

    return Scaffold(
      backgroundColor: const Color(0xFFEAE4DD),
      body: ColorfulSafeArea(
        color: const Color(0xFFEAE4DD),
        overflowRules: const OverflowRules.all(true),
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Center(
          child: Image.asset(
            'assets/images/app_logo.png',
            width: 200.w,
            height: 200.h,
          ),
        ),
      ),
    );
  }
}
