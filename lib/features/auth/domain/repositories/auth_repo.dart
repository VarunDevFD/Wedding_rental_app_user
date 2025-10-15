import 'package:dartz/dartz.dart';
import 'package:vr_wedding_rental/core/error/failure.dart';
import 'package:vr_wedding_rental/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  //--------------------Sign-In-------------------------------------------------
  Future<Either<String, AuthUser>> signInWithEmailPassword({
    required String email,
    required String password,
  });

  //--------------------Sign-Up-------------------------------------------------
  Future<Either<String, AuthUser>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }); // AuthUserModel

  //--------------------Forget-Password-----------------------------------------
  Future<void> sendPasswordResetEmail(String email);

  //--------------------Sign-In-Google------------------------------------------

  Future<Either<String, AuthUser>> signInWithGoogle();

  //--------------------Sign-Out------------------------------------------------
  Future<Either<Failure, void>> signOut();

  //--------------------Clear-SharedPreferences---------------------------------
  Future<void> clearAuthUser();
}
