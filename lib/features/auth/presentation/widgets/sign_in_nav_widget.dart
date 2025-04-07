import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_colors.dart';

class SignInNavigation extends StatelessWidget {
  const SignInNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?'),
        GestureDetector(
          onTap: () => context.go('/sign-in'),
          child: const Text(
            ' Sign In',
            style: TextStyle(color: AppColors.blue),
          ),
        ),
      ],
    );
  }
}
