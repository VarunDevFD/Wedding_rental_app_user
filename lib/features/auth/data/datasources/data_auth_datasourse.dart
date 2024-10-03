import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  FirebaseDataSource({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  //------------------ SignIn -- Google ------------------------------------//
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        debugPrint('Google sign-in aborted by user.');
        return null; // User canceled the sign-in
      }
      
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with credential
      UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
      return userCredential.user; // Return the User object
    } catch (e) {
      debugPrint('Error during Google sign-in: $e');
      return null; // Handle errors gracefully
    }
  }

  //------------------ SignIn -- Email & Password ------------------------------------//
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user; // Return the User object
    } catch (e) {
      debugPrint('Error during email sign-in: $e');
      return null; // Handle errors gracefully
    }
  }

  //------------------ SignUp -- Email & Password ------------------------------------//
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user; // Return the User object
    } catch (e) {
      debugPrint('Error during sign-up: $e'); // Log error
      return null; // Handle errors gracefully
    }
  }

  //------------------ SignOut ------------------------------------//
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
      debugPrint('User signed out successfully.');
    } catch (e) {
      debugPrint('Error during sign-out: $e');
    }
  }

  //------------------ Get Current User ------------------------------------//
  User? getCurrentUser() {
    return firebaseAuth.currentUser; // Return current user or null
  }
}
