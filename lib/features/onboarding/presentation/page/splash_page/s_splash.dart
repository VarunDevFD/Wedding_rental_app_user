import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vr_wedding_rental/features/onboarding/presentation/bloc/splash_bloc/splash_bloc.dart';
import 'package:vr_wedding_rental/features/onboarding/presentation/bloc/splash_bloc/splash_event.dart';
import 'package:vr_wedding_rental/features/onboarding/presentation/bloc/splash_bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dispatch the event when the widget is built
    context.read<SplashBloc>().add(CheckOnboardingStatus());

    return Scaffold(
      backgroundColor: const Color(0xFFEAE4DD),
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is GoToHome) {
            context.go('/bottomNavBar');
          } else if (state is GoToCategory) {
            context.go('/selectCategory');
          } else if (state is GoToWelcome) {
            context.go('/welcome');
          } else if (state is GoToOnboarding) {
            context.go('/onboarding');
          }
        },
        child: Center(
          child: Image.asset(
            'assets/images/app_logo.png',
            width: 450,
            height: 400,
          ),
        ),
      ),
    );
  }
}
