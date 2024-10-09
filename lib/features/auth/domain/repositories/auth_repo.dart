import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vr_wedding_rental/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  //------Sign-In------
  Future<AuthUser?> signInWithEmailPassword(
      String email, String password) async {
    // Firebase SignIn logic
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return null;
    // You may want to return a user object here
  }

  //------Sign-Up------
  Future<void> signUpWithEmailPassword(String email, String password);
  //--------------------Get-Current-User----------------------------------------
  User? getCurrentUser();

  Future<User?> signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }
}
