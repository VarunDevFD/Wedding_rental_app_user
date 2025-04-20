import 'package:dartz/dartz.dart';
import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/core/error/failure.dart';
import 'package:vr_wedding_rental/core/utils/app_exception.dart';
import 'package:vr_wedding_rental/features/auth/data/datasources/data_auth_datasourse.dart';
import 'package:vr_wedding_rental/features/auth/data/models/user_model.dart';
import 'package:vr_wedding_rental/features/auth/domain/entities/user_entity.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final remoteDataSource = serviceLocator<AuthDataSource>();
  @override
  Future<Either<String, AuthUser>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final authUserModel =
          await remoteDataSource.signInWithEmailPassword(email, password);

      // Convert result (AuthUser) back to entity (no conversion needed since data source returns AuthUser)
      return Right(authUserModel.toEntity());
    } on AppException catch (e) {
      return Left(e.alert);
    } catch (e) {
      return Left('Sign-in error: $e');
    }
  }

  @override
  Future<Either<String, AuthUser>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final authUserModel = await remoteDataSource.signUpWithEmailPassword(
        AuthUserModel(
          id: '', // ID set by Firebase
          email: email,
          name: name,
          password: password,
        ),
      );
      return Right(authUserModel!.toEntity());
    } on AppException catch (e) {
      return Left(e.alert);
    } catch (e) {
      return Left('Sign-up error: $e');
    }
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
  Future<Either<String, AuthUser>> signInWithGoogle() async {
    try {
      final authUserModel = await remoteDataSource.signInWithGoogle();
      return Right(authUserModel.toEntity());
    } on AppException catch (e) {
      return Left(e.alert);
    } catch (e) {
      return Left('Sign-in error: $e');
    }
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
