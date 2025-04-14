import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/core/navigation/bloc/navigation_bloc.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/forgot_pass_word_bloc/forgot_password_bloc_bloc.dart';
import 'package:vr_wedding_rental/features/home/presentation/bloc/venues_bloc/venues_bloc.dart';
import 'package:vr_wedding_rental/features/home/presentation/bloc/venues_bloc/venues_event.dart';
import 'package:vr_wedding_rental/features/onboarding/presentation/bloc/onboarding_bloc/onboarding_bloc.dart';
import 'package:vr_wedding_rental/features/onboarding/presentation/bloc/splash_bloc/splash_bloc.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;
  const AppBlocProvider({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashBloc()),
        BlocProvider(
          create: (context) => AuthBloc(
            googleSignIn: GetIt.I(),
            googleSignOut: GetIt.I(),
          ),
        ),
        BlocProvider(create: (_) => ForgetPasswordBloc()),
        BlocProvider(create: (_) => OnboardingCubit()),
        BlocProvider(create: (_) => NavigationBloc()),
        BlocProvider(create: (_) => HomeBloc()..add(FetchVenues())),
      ],
      child: child,
    );
  }
}
