// lib/core/di/injectors.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vr_wedding_rental/core/firebase/firebase_options.dart';
import 'package:vr_wedding_rental/features/auth/data/datasources/data_auth_datasourse.dart';
import 'package:vr_wedding_rental/features/auth/data/repositories/data_auth_repo.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_email_password.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_out.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_up_with_email_password.dart';
import 'package:vr_wedding_rental/features/home/data/datasources/venue_remote_data_source.dart';
import 'package:vr_wedding_rental/features/home/data/repository/venue_repository_impl.dart';
import 'package:vr_wedding_rental/features/home/domain/repository/venue_repo_domain.dart';
import 'package:vr_wedding_rental/features/home/domain/usecases/get_venues.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //---FireBase-Initializing----Ready before any async operation are executed---
  WidgetsFlutterBinding.ensureInitialized();

  //--------------------Connect-with-firebase_options.dart----------------------
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //--------------------External Dependencies-----------------------------------
  // Register FirebaseAuth
  serviceLocator
      .registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Register GoogleSignIn
  serviceLocator.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  // Register FirebaseFirestore
  serviceLocator.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  //--------------------Authentication------------------------------------------

  // Register DataSource
  serviceLocator.registerLazySingleton<AuthDataSource>(
    () => AuthRemoteDataSource(),
  );

  // Register Repository
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(),
  );

  // Register Use Cases
  serviceLocator.registerLazySingleton<SignInWithEmailPassword>(
    () => SignInWithEmailPassword(),
  );

  serviceLocator.registerLazySingleton<SignUpWithEmailPassword>(
    () => SignUpWithEmailPassword(),
  );

  serviceLocator.registerLazySingleton<SignInWithGoogle>(
    () => SignInWithGoogle(),
  );

  serviceLocator.registerLazySingleton<SignOut>(
    () => SignOut(),
  );

  //--------------------- Home -------------------------------------------------

  // Register Use Case
  serviceLocator.registerLazySingleton<GetVenues>(
    () => GetVenues(serviceLocator()),
  );

  // Register Repository
  serviceLocator.registerLazySingleton<VenueRepository>(
  () => VenueRepositoryImpl(
    remoteDataSource: serviceLocator<VenueRemoteDataSource>(),
  ),
);

  // Register Data Source
  serviceLocator.registerLazySingleton<VenueRemoteDataSource>(
    () =>
        VenueRemoteDataSourceImpl(), // Replace with your actual implementation
  );
}
