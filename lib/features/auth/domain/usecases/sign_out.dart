import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';

class SignOut {
  final AuthRepository repository;

  SignOut(this.repository);

  Future<void> call() async {
    await repository.signOut(); // Call the sign-out method from the repository
  }
}
