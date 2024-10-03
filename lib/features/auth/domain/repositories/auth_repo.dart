import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    return null;
  
    // Your Google Sign-In logic (ensure to return a User object)
  }

  // Sign in with Email and Password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user; // Return the User object
    } catch (e) {
      rethrow; // Handle errors as necessary
    }
  }

  // Sign up with Email and Password
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user; // Return the User object
    } catch (e) {
      rethrow; // Handle errors as necessary
    }
  }

  // Sign out method
  Future<void> signOut() async {
    await _firebaseAuth.signOut(); // This should be void
  }
}
