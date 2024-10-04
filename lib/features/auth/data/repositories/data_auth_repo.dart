import 'package:vr_wedding_rental/features/auth/data/datasources/data_auth_datasourse.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';

import '../../domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AuthUser?> signInWithEmailPassword(
      String email, String password) async {
    final user =
        await remoteDataSource.signInWithEmailPassword(email, password);
    if (user != null) {
      return AuthUser(id: user.uid, email: user.email!);
    }
    return null;
  }

  @override
  Future<AuthUser?> signUpWithEmailPassword(
      String email, String password) async {
    final user =
        await remoteDataSource.signUpWithEmailPassword(email, password);
    if (user != null) {
      return AuthUser(id: user.uid, email: user.email!);
    }
    return null;
  }

  @override
  Future<AuthUser?> signInWithGoogle() async {
    final user = await remoteDataSource.signInWithGoogle();
    if (user != null) {
      return AuthUser(
          id: user.uid, email: user.email!, displayName: user.displayName);
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }
}
