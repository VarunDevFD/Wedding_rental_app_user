import 'package:dartz/dartz.dart';
import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/features/auth/domain/entities/user_entity.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';

class SignInWithEmailPassword {
  final repository = serviceLocator<AuthRepository>(); // GetIt instance

  Future<Either<String, AuthUser>> call(String email, String password) async {
    return await repository.signInWithEmailPassword(
      email: email,
      password: password,
    );
  }
}
