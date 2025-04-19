import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';

class SignInWithEmailPassword {
  final repository = serviceLocator<AuthRepository>(); // GetIt instance

  Future<void> call(String email, String password) async =>
      await repository.signInWithEmailPassword(email, password);
}
