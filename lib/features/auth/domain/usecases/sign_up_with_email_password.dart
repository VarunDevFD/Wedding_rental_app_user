import 'package:dartz/dartz.dart';
import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/features/auth/domain/entities/user_entity.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';

class SignUpWithEmailPassword {
  final repository = serviceLocator<AuthRepository>();

  Future<Either<String, AuthUser>> call({
    required String name,
    required String email,
    required String password, 
  }) async {
    return await repository.signUpWithEmailPassword(
      name: name,
      email: email,
      password: password, 
    );
  }
}
