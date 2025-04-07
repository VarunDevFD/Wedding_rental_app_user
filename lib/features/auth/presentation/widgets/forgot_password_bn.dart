import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_text_styles.dart';

class ForgotPasswordBn extends StatelessWidget {
  const ForgotPasswordBn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          width: 10,
          height: 25,
        ),
        TextButton(
          onPressed: () {
            context.go('/forgotPassword');
          },
          child: Text('Forgot Password?',
              style: AppTextStyles.buttonTextStyleForgotBn),
        ),
      ],
    );
  }
}
