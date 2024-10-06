import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vr_wedding_rental/features/auth/data/datasources/data_auth_datasourse.dart';
import 'package:vr_wedding_rental/features/auth/data/repositories/data_auth_repo.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_email_password.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_up_with_email_password.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:vr_wedding_rental/core/routes/app_router.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the GoogleSignIn instance
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // Initialize the AuthRemoteDataSource
    final AuthRemoteDataSource remoteDataSource = AuthRemoteDataSource(
      firebaseAuth: FirebaseAuth.instance,
      googleSignIn: googleSignIn,
    );

    // Initialize the AuthRepository
    final AuthRepository authRepository = AuthRepositoryImpl(
      remoteDataSource: remoteDataSource, // Pass remoteDataSource here
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            signInWithEmailPassword: SignInWithEmailPassword(authRepository),
            signUpWithEmailPassword: SignUpWithEmailPassword(authRepository),
            googleSignIn: SignInWithGoogle(authRepository),
          ),
        ),
        // Add other BlocProviders here if needed
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        title: 'Flutter Wedding Rental Application',
      ),
    );
  }
}
