import 'package:dartz/dartz.dart';
import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/core/error/failure.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';

class SignOut {
  final repository = serviceLocator<AuthRepository>(); // GetIt instance

  Future<Either<Failure, void>> call() async =>
      await repository.signOut(); // Sign-out method from the repository
}
