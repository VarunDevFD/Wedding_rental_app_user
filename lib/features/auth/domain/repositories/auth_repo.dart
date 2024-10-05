import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vr_wedding_rental/features/auth/domain/entities/user_entity.dart';

class AuthRepository {
  
  Future<AuthUser?> signInWithEmailPassword(
      String email, String password) async {
    // Firebase SignIn logic
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return null;
    // You may want to return a user object here
  }

  Future<AuthUser?> signUpWithEmailPassword(
      String email, String password) async {
    // Firebase SignUp logic
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return null;
    // You may want to return a user object here
  }

  Future<AuthUser?> signInWithGoogle() async {
    // Firebase Google SignIn logic
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
