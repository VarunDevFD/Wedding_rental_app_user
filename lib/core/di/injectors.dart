import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vr_wedding_rental/core/firebase/firebase_options.dart';
import 'package:vr_wedding_rental/features/auth/data/datasources/data_auth_datasourse.dart';
import 'package:vr_wedding_rental/features/auth/data/repositories/data_auth_repo.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart'; 
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_email_password.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_out.dart'; 
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_up_with_email_password.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //---FireBase-Initializing----Ready before any async operation are executed---
  WidgetsFlutterBinding.ensureInitialized();

  //--------------------Connect-with-firebase_options.dart----------------------
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //--------------------FirebaseFirestore--------------------------------------
  serviceLocator.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  //--------------------Authentication------------------------------------------
  serviceLocator
      .registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  serviceLocator.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(),
  );

  serviceLocator
      .registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  serviceLocator.registerLazySingleton<SignUpWithEmailPassword>(
      () => SignUpWithEmailPassword());
  serviceLocator.registerLazySingleton(() => SignInWithEmailPassword());
  serviceLocator.registerLazySingleton(() => SignInWithGoogle());
  serviceLocator.registerLazySingleton(() => SignOut());
}
