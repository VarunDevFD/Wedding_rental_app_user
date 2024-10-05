import 'package:vr_wedding_rental/features/auth/domain/entities/user_entity.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';

class SignInWithGoogle {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  Future<AuthUser?> call() {
    return repository.signInWithGoogle(); // Call the sign-in method from the repository
  }
}
