import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRepository {
  //--------------------Sign-In-------------------------------------------------
  Future<void> signInWithEmailPassword(String email, String password);

  //--------------------Sign-Up-------------------------------------------------
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
