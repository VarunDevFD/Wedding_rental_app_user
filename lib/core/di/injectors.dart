import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vr_wedding_rental/features/auth/data/datasources/data_auth_datasourse.dart';
import 'package:vr_wedding_rental/features/auth/data/repositories/data_auth_repo.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/auth_user.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_email_password.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_up_with_email_password.dart'; // Import this

final getIt = GetIt.instance;

Future<void> init() async {
  // Register Firebase dependencies
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  // Register Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(
      firebaseAuth: getIt<FirebaseAuth>(),
      googleSignIn: getIt<GoogleSignIn>(),
    ),
  );

  // SignUp Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt()),
  );

  // SignUp Use Cases
  getIt.registerLazySingleton(() => SignUpWithEmailPassword(getIt()));
  getIt.registerLazySingleton(() => SignInWithEmailPassword(getIt()));
  getIt.registerLazySingleton(() => SignInWithGoogle(getIt()));
  getIt.registerLazySingleton(() => GetCurrentUser(repository: getIt()));
}
