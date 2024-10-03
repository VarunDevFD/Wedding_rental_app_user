import 'package:firebase_auth/firebase_auth.dart';
import 'package:vr_wedding_rental/features/auth/data/datasources/data_auth_datasourse.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseDataSource firebaseDataSource;

  AuthRepositoryImpl({required this.firebaseDataSource});

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    return await firebaseDataSource.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<User?> signInWithGoogle() async {
    return await firebaseDataSource.signInWithGoogle();
  }

  @override
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    return await firebaseDataSource.signUpWithEmailAndPassword(email, password);
  }

  @override
  Future<void> signOut() async {
    await firebaseDataSource.signOut();
  }

  
  User? getCurrentUser() {
    return firebaseDataSource.getCurrentUser();
  }
}
