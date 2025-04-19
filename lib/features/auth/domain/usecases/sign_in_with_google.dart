import 'package:firebase_auth/firebase_auth.dart';
import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';

class SignInWithGoogle {
  final repository = serviceLocator<AuthRepository>(); // GetIt instance

  Future<User?> call() => repository.signInWithGoogle();
}
