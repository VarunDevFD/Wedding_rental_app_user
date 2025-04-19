import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/core/error/failure.dart';
import 'package:vr_wedding_rental/features/auth/data/datasources/data_auth_datasourse.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';

import '../../domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final remoteDataSource = serviceLocator<AuthRemoteDataSource>();


  @override
  Future<AuthUser?> signInWithEmailPassword(
      String email, String password) async {
    final user =
        await remoteDataSource.signInWithEmailPassword(email, password);
    if (user != null) {
      return AuthUser(id: user.id, email: user.email);
    }
    return null;
  }

  @override
  Future<void> signUpWithEmailPassword(String name,String email, String password) {
    return remoteDataSource.signUpWithEmailPassword( name,email, password);
  }

  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      await remoteDataSource.resetPassword(email);
      // Return Right to indicate success after sending the email
      return const Right(null); // Return Right with a null value for success
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to send password reset email'),
      );
    }
  }

  @override
  Future<User?> signInWithGoogle() async {
    final user = await remoteDataSource.signInWithGoogle();
    if (user != null) {}
    return user;
  }

   

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure()); // Replace with your custom failure
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    throw UnimplementedError();
  }

  @override
  Future<void> clearAuthUser() {
    throw UnimplementedError();
  }
}
