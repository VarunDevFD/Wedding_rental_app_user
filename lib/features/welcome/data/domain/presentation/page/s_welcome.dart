import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_colors.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_text_styles.dart';
import 'package:vr_wedding_rental/core/utils/widgets/custom_button.dart';
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
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Center(
                      child: Image.asset(
                        'assets/images/app_logo.png',
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Welcome to VR Wedding Rental',
                    style: AppTextStyles.titleStyle.copyWith(
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'Sign In',
                            onPressed: () {
                              context.go('/sign-in');
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: CustomButton(
                            buttonColor: AppColors.backgroundColor,
                            text: 'Sign Up',
                            textStyle: AppTextStyles.buttonTextStyleWelcomeBn2,
                            onPressed: () {
                              context.go('/sign-up');
                            },
                          ),
                        ),
                      ],
                    ),
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
