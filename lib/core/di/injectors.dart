import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vr_wedding_rental/core/firebase/firebase_options.dart';
import 'package:vr_wedding_rental/core/shr_pref/datasource/preference_data_source.dart';
import 'package:vr_wedding_rental/core/shr_pref/repository/preference_repository.dart';
import 'package:vr_wedding_rental/features/auth/data/datasources/data_auth_datasourse.dart';
import 'package:vr_wedding_rental/features/auth/data/repositories/data_auth_repo.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/auth_user.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_email_password.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_out.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_up_with_email_password.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:vr_wedding_rental/features/home/presentation/bloc/venues_bloc/venues_bloc.dart';
import 'package:vr_wedding_rental/features/onboarding/data/repositories/d_onboarding_repository_impl.dart';
import 'package:vr_wedding_rental/features/onboarding/domain/repositories/r_onboarding_repository.dart';
import 'package:vr_wedding_rental/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:vr_wedding_rental/features/onboarding/domain/usecases/get_onboarding_pages_usecase.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //---FireBase-Initializing----Ready before any async operation are executed---
  WidgetsFlutterBinding.ensureInitialized();

  //--------------------Connect-with-firebase_options.dart----------------------
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //--------------------Shared-Preference---------------------------------------
  serviceLocator.registerLazySingleton<PreferencesRepository>(
      () => PreferencesRepository());

  serviceLocator.registerLazySingleton<PreferencesDataSource>(
      () => PreferencesDataSource());

  //--------------------On-Boarding-Screen--------------------------------------

  // Repository
  serviceLocator.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(),
  );

  // Use cases
  serviceLocator.registerLazySingleton(
    () => GetOnboardingPagesUseCase(serviceLocator<OnboardingRepository>()),
  );

  serviceLocator.registerLazySingleton(
    () => CompleteOnboardingUseCase(serviceLocator<OnboardingRepository>()),
  );
  //--------------------Auth-Firebase-dependencies------------------------------
  serviceLocator
      .registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  //--------------------Auth Data Sources---------------------------------------
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(
      firebaseAuth: serviceLocator<FirebaseAuth>(),
      googleSignIn: serviceLocator<GoogleSignIn>(),
    ),
  );

  //--------------------Auth Repositories---------------------------------------
  serviceLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator<AuthRemoteDataSource>()));

  //--------------------Auth Use Cases------------------------------------------
  serviceLocator.registerLazySingleton<SignUpWithEmailPassword>(
      () => SignUpWithEmailPassword(serviceLocator<AuthRepository>()));
  serviceLocator.registerLazySingleton<SignInWithEmailPassword>(
      () => SignInWithEmailPassword(serviceLocator<AuthRepository>()));
  serviceLocator.registerLazySingleton<SignInWithGoogle>(
      () => SignInWithGoogle(serviceLocator<AuthRepository>()));
  serviceLocator.registerLazySingleton<GetCurrentUser>(
      () => GetCurrentUser(repository: serviceLocator<AuthRepository>()));

  //--------------------Auth Bloc-----------------------------------------------
  serviceLocator
      .registerLazySingleton(() => SignOut(serviceLocator<AuthRepository>()));

  serviceLocator.registerLazySingleton(() => AuthBloc(
      googleSignIn: serviceLocator<SignInWithGoogle>(),
      googleSignOut: serviceLocator<SignOut>()));

  serviceLocator.registerFactory(() => HomeBloc());
}
