import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_colors.dart';

class SignUpNavigation extends StatelessWidget {
  const SignUpNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?'),
        GestureDetector(
          onTap: () => context.go('/sign-up'),
          child: const Text(
            ' Sign Up',
            style: TextStyle(color: AppColors.blue),
          ),
        ),
      ],
    );
  }
}
