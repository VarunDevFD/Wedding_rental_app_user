import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vr_wedding_rental/features/auth/presentation/pages/forgot_screen.dart';
import 'package:vr_wedding_rental/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:vr_wedding_rental/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:vr_wedding_rental/features/home/presentation/page/bottom_navigation_Bar_Items_screen.dart';
import 'package:vr_wedding_rental/features/home/presentation/page/popular_items_screen.dart';
import 'package:vr_wedding_rental/features/onboarding/presentation/page/onboarding/s_onboarding.dart';
import 'package:vr_wedding_rental/features/onboarding/presentation/page/splash_page/s_splash.dart';
import 'package:vr_wedding_rental/features/welcome/data/domain/presentation/page/s_welcome.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
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
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/forgotPassword',
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/popularScreen',
        builder: (context, state) => const PopularItemsScreen(),
      ),
    ],
  );
}
