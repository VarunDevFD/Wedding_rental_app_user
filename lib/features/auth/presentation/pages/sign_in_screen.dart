// lib/features/auth/presentation/pages/sign_in_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_colors.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_text_styles.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In', style: AppTextStyles.titleStyle),
        backgroundColor: AppColors.buttonTextColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Please sign in to continue',
              style: AppTextStyles.subTitleStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.h),
            TextField(
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Navigate to Forgot Password Screen
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                // Add sign in logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonTextColor,
              ),
              child: Text('Sign In', style: AppTextStyles.buttonTextStyle),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                const Expanded(child: Divider(color: AppColors.black)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Text(
                    'OR',
                    style: AppTextStyles.subTitleStyle,
                  ),
                ),
                const Expanded(child: Divider(color: AppColors.black)),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: AppColors.black),
                  ),
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                      size: 24.sp,
                    ),
                    onPressed: () {
                      // Add Google Sign-In logic
                    },
                  ),
                ),
                SizedBox(width: 20.w),
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: AppColors.black),
                  ),
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.apple,
                      color: Colors.black,
                      size: 24.sp,
                    ),
                    onPressed: () {
                      // Add iOS Sign-In logic
                    },
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: AppTextStyles.subTitleStyle,
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to Sign Up Screen
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
