import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/core/utils/app_exception.dart';
import 'package:vr_wedding_rental/core/utils/helper/helper_auth_funtion.dart';
import 'package:vr_wedding_rental/features/auth/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<AuthUserModel> signInWithGoogle();
  Future<AuthUserModel> signInWithEmailPassword(String email, String password);
  Future<AuthUserModel?> signUpWithEmailPassword(AuthUserModel user);
  Future<void> resetPassword(String email);
  Future<void> signOut();
  User? getCurrentUser();
}

class AuthRemoteDataSource implements AuthDataSource {
  final firebaseAuth = serviceLocator<FirebaseAuth>();
  final googleSignIn = serviceLocator<GoogleSignIn>();
  final fireStore = serviceLocator<FirebaseFirestore>();

  // --------------------------Add User to fireBaseCollection-------------------

  Future<void> _addUserToFirestore(
    AuthUserModel authUser,
  ) async {
    final userId = authUser.id;

    // Add a new Firestore document with a unique ID for each role
    await fireStore
        .collection('users')
        .doc('User')
        .collection('User')
        .doc(userId)
        .set({
      'uid': userId,
      'photoUrl': authUser.photoUrl,
      'name': authUser.name,
      'email': authUser.email,
      'password': authUser.password,
      'time': FieldValue.serverTimestamp(),
      'googleSignIn': authUser.googleSignIn,
    });

    // await pref.setHasSeenCategory(true);
    _setUserId(userId!);
    // Home Screen after authentication
    _setHasSeenHome(value: true);

    log("User added to Firestore: ${authUser.email}");
  }

  //--------------------------Sin-Up-Email-&-Password---------------------------

  @override
  Future<AuthUserModel?> signUpWithEmailPassword(
    AuthUserModel user,
  ) async {
    const String role = "User";

    try {
      // Check User exists in Firestore
      final userData = await fireStore
          .collection('users')
          .doc(role)
          .collection(role)
          .where('email', isEqualTo: user.email)
          .where('googleSignIn', isEqualTo: false)
          .get();

      if (userData.docs.isNotEmpty) {
        throw const AppException(
          details: 'Email already in use',
          alert: 'Email already in use. Please use another email.',
        );
      }

      if (user.password == null || user.password!.isEmpty) {
        throw const AppException(
          details: 'Password is missing',
          alert: 'Please provide a password.',
        );
      }

      final modEmail = Helpers.concatenateWithNewEmail(user.email);
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: modEmail,
        password: user.password!,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw const AppException(
          details: 'User creation failed',
          alert: 'Failed to create user account.',
        );
      }

      final authUserModel = AuthUserModel(
        id: firebaseUser.uid,
        email: user.email,
        name: user.name,
        photoUrl: user.photoUrl,
        role: user.role ?? 'User',
        createdAt: DateTime.now(),
        password: null, // Clear password after sign-up
      );

      // _setUserId(firebaseUser.uid);
      log("User ID: ${firebaseUser.uid}");
      await _addUserToFirestore(authUserModel);
      return authUserModel;
    } on FirebaseAuthException catch (e) {
      throw AppException(
        details: e.toString(),
        alert: 'Sign-up failed: ${e.message}',
      );
    } catch (e) {
      throw AppException(
        details: e.toString(),
        alert: 'An error occurred during sign-up.',
      );
    }
  }

  //--------------------------Sin-In-Email-&-Password---------------------------

  @override
  Future<AuthUserModel> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final modEmail = Helpers.concatenateWithNewEmail(email);
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: modEmail,
        password: password,
      );
      // Saveed current user ID
      _setUserId(userCredential.user!.uid);
      _setHasSeenHome(value: true);
      log("User ID: ${userCredential.user!.uid}");
      final user = userCredential.user;

      if (user == null) {
        throw const AppException(
          details: 'Sign-in failed',
          alert: 'No user found for the provided credentials.',
        );
      }

      // Fetch user data from Firestore
      const role = 'User';
      final doc = await fireStore
          .collection('users')
          .doc(role)
          .collection(role)
          .doc(user.uid)
          .get();

      if (!doc.exists) {
        throw const AppException(
          details: 'User data not found',
          alert: 'User data not found in Firestore. Please sign up first.',
        );
      }

      final authUserModel = AuthUserModel.fromFirestore(doc.data()!, user.uid);

      log('Email Sign-In successful: ${authUserModel.email}');
      return authUserModel;
    } on FirebaseAuthException catch (e) {
      throw AppException(
        details: e.toString(),
        alert: 'Sign-in failed: ${e.message}',
      );
    } catch (e) {
      throw AppException(
        details: e.toString(),
        alert: 'An error occurred during sign-in.',
      );
    }
  }

  //---------------------------Sign-In-Google-----------------------------------

  @override
  Future<AuthUserModel> signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw const AppException(
          details: 'Google sign-in aborted',
          alert: 'Google sign-in was cancelled.',
        );
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential =
          await firebaseAuth.signInWithCredential(credential);

      final user = userCredential.user;

      if (user != null) {
        // Extract email and other user data
        final AuthUserModel authUser = AuthUserModel(
          id: user.uid,
          email: user.email ?? googleUser.email,
          name: user.displayName ?? googleUser.displayName ?? 'Anonymous',
          photoUrl: user.photoURL ?? googleUser.photoUrl,
          googleSignIn: true,
          createdAt: DateTime.now(),
          role: 'User',
        );

        // Store user data in Firestore
        await _addUserToFirestore(authUser);
        return authUser;
      } else {
        throw const AppException(
          details: 'Google sign-in failed',
          alert: 'Failed to authenticate with Google.',
        );
      }
    } on FirebaseAuthException catch (e) {
      throw AppException(
        details: e.toString(),
        alert: 'Google sign-in failed: ${e.message}',
      );
    } catch (e) {
      throw AppException(
        details: e.toString(),
        alert: 'An error occurred during Google sign-in.',
      );
    }
  }

  //-------------------------Forgot-Password-------------------------------------------

  @override
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

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut(); // Sign out from Firebase
      await googleSignIn.signOut(); // Sign out from Google
      _removeAllPrefs();

    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  //--------------------------SignUp --Get the User ----------------------------

  @override
  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  //--------------------------Set-SharedPreferences----------------------------
  Future<void> _setUserId(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("uid", value); // Save the flag
  }

  Future<void> _setHasSeenHome({bool value = false}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenHome', value); // Save the flag
  }

  Future<void> _removeAllPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('hasSeenHome');
    await prefs.remove('uid'); // Remove the uid key
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('photoUrl');
    await prefs.remove('googleSignIn');
  }
}
