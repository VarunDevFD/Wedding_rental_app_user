import 'package:firebase_auth/firebase_auth.dart';
import 'package:vr_wedding_rental/features/auth/data/datasources/data_auth_datasourse.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';

import '../../domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

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
  Future<void> signUpWithEmailPassword(String email, String password) {
    return remoteDataSource.signUpWithEmailPassword(email, password);
  }

  @override
  Future<User?> signInWithGoogle() async {
    final user = await remoteDataSource.signInWithGoogle();
    if (user != null) {}
    return null;
  }

  @override
  User? getCurrentUser() {
    return remoteDataSource.getCurrentUser();
  }

  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }
}
