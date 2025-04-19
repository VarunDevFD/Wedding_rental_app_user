import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';

class SignUpWithEmailPassword {
  final repository = serviceLocator<AuthRepository>(); 

  Future<void> call(String name,String email, String password) async {
    return await repository.signUpWithEmailPassword( name,email, password);
  }
}
