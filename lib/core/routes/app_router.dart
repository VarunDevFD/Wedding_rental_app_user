import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:vr_wedding_rental/features/auth/presentation/pages/forgot_screen.dart';
import 'package:vr_wedding_rental/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:vr_wedding_rental/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:vr_wedding_rental/features/home/presentation/page/home_screen.dart';
import 'package:vr_wedding_rental/features/onboarding/presentation/page/onboarding/s_onboarding.dart';
import 'package:vr_wedding_rental/features/onboarding/presentation/page/splash_page/s_splash.dart';
import 'package:vr_wedding_rental/features/welcome/data/domain/presentation/page/s_welcome.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) {
          final authSignInBloc =
              context.read<AuthBloc>(); // Retrieve AuthBloc from context
          return SignInScreen(
              authBloc: authSignInBloc); // Pass the AuthBloc instance
        },
      ),
      GoRoute(
          path: '/sign-up',
          builder: (context, state) {
            final authSignUpBloc =
                context.read<AuthBloc>(); // Retrieve AuthBloc from context
            return SignUpScreen(authBloc: authSignUpBloc);
          }),
      GoRoute(
        path: '/home',
        builder: (context, state) =>  HomeScreen(),
      ),
      GoRoute(
        path: '/forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
}
