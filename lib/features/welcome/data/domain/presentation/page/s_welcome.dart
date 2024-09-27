import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import screenutil package
import 'package:go_router/go_router.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_colors.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_text_styles.dart';
import 'package:vr_wedding_rental/features/welcome/data/domain/presentation/bloc/welcome_bloc.dart';
import 'package:vr_wedding_rental/features/welcome/data/domain/presentation/bloc/welcome_satate.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeBloc(),
      child: Scaffold(
        body: BlocBuilder<WelcomeBloc, WelcomeState>(
          builder: (context, state) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome Screen',
                    style: AppTextStyles.titleStyle.copyWith(
                      fontSize: 24.sp,
                    ),
                  ),
                  SizedBox(height: 20.h), 
                  Container(
                    width: 200.w, 
                    height: 200.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.buttonTextColor,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/app_logo.png',
                        width: 150.w, 
                        height: 150.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h), 
                  Text(
                    'Welcome to VR Wedding Rental',
                    style: AppTextStyles.subTitleStyle.copyWith(
                      fontSize: 18.sp, 
                    ),
                  ),
                  SizedBox(height: 40.h), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.go('/sign-in');
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.black,
                          backgroundColor: AppColors.buttonTextColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w, // Responsive horizontal padding
                            vertical: 12.h, // Responsive vertical padding
                          ),
                        ),
                        child: Text(
                          'Sign In',
                          style: TextStyle(fontSize: 16.sp), // Responsive font
                        ),
                      ),
                      SizedBox(width: 20.w), // Responsive spacing
                      ElevatedButton(
                        onPressed: () {
                          context.go('/sign-up');
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.white,
                          backgroundColor: AppColors.backgroundColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w, // Responsive horizontal padding
                            vertical: 12.h, // Responsive vertical padding
                          ),
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 16.sp), // Responsive font
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
