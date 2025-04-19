import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/core/utils/app_exception.dart';
import 'package:vr_wedding_rental/core/utils/helper/helper_auth_funtion.dart';
import 'package:vr_wedding_rental/features/auth/domain/entities/user_entity.dart';

class AuthRemoteDataSource {
  final firebaseAuth = serviceLocator<FirebaseAuth>();
  final googleSignIn = serviceLocator<GoogleSignIn>();
  final fireStore = serviceLocator<FirebaseFirestore>();

  // --------------------------Add User to fireBaseCollection-------------------
  Future<void> _addUserToFirestore(
    String name,
    String email,
    String? password,
    String? uid,
    String? photoUrl,
    bool value,
  ) async {
    final userId = uid ?? getCurrentUser()?.uid;

    if (userId == null) {
      throw Exception(
          'User ID is null. Unable to store user details in Firestore.');
    }

    // Add a new Firestore document with a unique ID for each role
    await fireStore
        .collection('users')
        .doc('User')
        .collection('User')
        .doc(userId)
        .set({
      'uid': userId,
      'photoUrl': photoUrl,
      'name': name,
      'email': email,
      'password': password,
      'time': FieldValue.serverTimestamp(),
      'googleSignIn': value,
    });

    // await pref.setHasSeenCategory(true);
    // await pref.setHasSeenUserId([userId]);

    log("User added to Firestore: $email");
  }

  //--------------------------Sin-Up-Email-&-Password---------------------------

  Future<void> signUpWithEmailPassword(
    String name,
    String email,
    String password,
  ) async {
    const String role = "User";

    try {
      // Check if the user already exists in Firestore
      final userData = await fireStore
          .collection('users')
          .doc(role)
          .collection(role)
          .where('email', isEqualTo: email)
          .where('googleSignIn', isEqualTo: false)
          .get();

      if (userData.docs.isNotEmpty) {
        // Email already exists in the subcollection
        throw Exception("Email already in use. Please use another email.");
      }

      final modEmail = Helpers.concatenateWithNewEmail(email);
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: modEmail,
        password: password,
      );
      _setUserId(userCredential.user!.uid);
      log("User ID: ${userCredential.user!.uid}");
      await _addUserToFirestore(
          name, email, password, userCredential.user?.uid, null, false);
    } catch (e) {
      // Handle any exceptions and rethrow for UI handling
      throw Exception(e.toString());
    }
  }

  //--------------------------Sin-In-Email-&-Password---------------------------

  Future<AuthUser?> signInWithEmailPassword(
      String email, String password) async {
    try {
      final modEmail = Helpers.concatenateWithNewEmail(email);
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: modEmail,
        password: password,
      );
      // User Uid saved Shared preference
      _setUserId(userCredential.user!.uid);

      return userCredential.user != null
          ? AuthUser(
              id: userCredential.user!.uid, email: userCredential.user!.email!)
          : null;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase specific exceptions
      throw Exception('Sign in failed: ${e.message}');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  //---------------------------Sign-In-Google-----------------------------------

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign in aborted');
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        // Extract email and other user data
        final String? email = user.email;
        final String? displayName = user.displayName;
        final String uid = user.uid;
        final String? photoUrl = user.photoURL;

        if (email != null) {
          // Store user data in Firestore
          await _addUserToFirestore(
            displayName ?? 'Anonymous',
            email,
            null,
            uid,
            photoUrl,
            true,
          );
          // Saved the UserId on here
          _setUserId(uid);
        } else {
          log('No email found for user');
        }
      }
      return user;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase exceptions
      throw Exception('Google sign in failed: ${e.message}');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  //-------------------------Forgot-Password-------------------------------------------

  Future<void> resetPassword(String email) async {
    try {
      // Send the password reset email
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      // Throw an AppException with the error details and an alert message
      throw AppException(details: e.toString(), alert: e.toString());
    }
  }

  //-------------------------Sign-Out-------------------------------------------

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut(); // Sign out from Firebase
      await googleSignIn.signOut(); // Sign out from Google
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  //--------------------------SignUp --Get the User ----------------------------

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  //--------------------------Set-SharedPreferences----------------------------
  Future<void> _setUserId(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("uid", value); // Save the flag
  }
}
