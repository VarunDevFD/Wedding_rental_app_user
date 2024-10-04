import 'package:vr_wedding_rental/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<AuthUser?> signInWithEmailPassword(String email, String password);
  Future<AuthUser?> signUpWithEmailPassword(String email, String password);
  Future<AuthUser?> signInWithGoogle();
  Future<void> signOut();
}
