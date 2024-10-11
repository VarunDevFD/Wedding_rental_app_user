import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';

class SignInWithEmailPassword {
  final AuthRepository repository;

  SignInWithEmailPassword(this.repository);

  Future<void> call(String email, String password) async {
    return await repository.signInWithEmailPassword(email, password);
  }
}
