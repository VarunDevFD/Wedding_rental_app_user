import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/features/auth/data/models/user_model.dart';
import 'package:vr_wedding_rental/features/auth/domain/entities/user_entity.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_out.dart';
import 'auth_bloc_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_email_password.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_up_with_email_password.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
  AuthBloc() : super(AuthInitial()) {
    on<CheckAuthStatusEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final firebaseAuth = serviceLocator<FirebaseAuth>();
        final user = firebaseAuth.currentUser;

        if (user != null) {
          // Check SharedPreferences first
          final prefs = await SharedPreferences.getInstance();
          final uid = prefs.getString('uid');
          final name = prefs.getString('name');
          final email = prefs.getString('email');
          final photoUrl = prefs.getString('photoUrl');
          final googleSignIn = prefs.getBool('googleSignIn');

          if (uid != null && name != null && email != null) {
            // Use data from SharedPreferences
            final authUserModel = AuthUserModel(
              id: uid,
              name: name,
              email: email,
              photoUrl: photoUrl,
              googleSignIn: googleSignIn,
              createdAt: DateTime.now(),
              role: 'User',
            );
            emit(Authenticated(authUserModel.toEntity()));
          } else {
            // Fallback to Firestore
            final fireStore = serviceLocator<FirebaseFirestore>();
            const role = 'User';
            final doc = await fireStore
                .collection('users')
                .doc(role)
                .collection(role)
                .doc(user.uid)
                .get();

            if (doc.exists) {
              final authUserModel =
                  AuthUserModel.fromFirestore(doc.data()!, user.uid);
              // Save to SharedPreferences for future use
              await prefs.setString('uid', authUserModel.id!);
              await prefs.setString('name', authUserModel.name ?? '');
              await prefs.setString('email', authUserModel.email);
              await prefs.setString('photoUrl', authUserModel.photoUrl ?? '');
              await prefs.setBool(
                  'googleSignIn', authUserModel.googleSignIn ?? false);

              emit(Authenticated(authUserModel.toEntity()));
            } else {
              emit(const AuthError(
                  'User data not found. Please sign in again.'));
            }
          }
        } else {
          emit(AuthInitial());
        }
      } catch (e) {
        emit(AuthError('Error checking auth status: $e'));
      }
    });

    //------------------------------SignInEvent---------------------------------

    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      final signIn = serviceLocator<SignInWithEmailPassword>();
      try {
        final result = await signIn(event.email, event.password);
        await result.fold(
          (error) => throw Exception(error),
          (authUser) async {
            emit(Authenticated(authUser));
          },
        );
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state
      }
    });

    //------------------------------SignUpEvent---------------------------------
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      final signUp = serviceLocator<SignUpWithEmailPassword>();
      try {
        final userData = AuthUser(
            email: event.email, name: event.name, password: event.password);
        // Call the sign-up method
        await signUp.call(
          name: event.name,
          email: event.email,
          password: event.password,
        );
        emit(Authenticated(userData)); // Emit Authenticated state with User
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state
      }
    });

    //----------------------Sign-In-Google-Event--------------------------------
    on<GoogleSignInEvent>((event, emit) async {
      emit(AuthLoading());
      final googleSignIn = serviceLocator<SignInWithGoogle>();
      try {
        final result = await googleSignIn.call(); // Call the sign-in method

        await result.fold(
          (error) => throw Exception(error),
          (authUser) async {
            emit(Authenticated(authUser)); // Emit Authenticated state with User
          },
        );
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state
      }
    });

    //----------------------Sign-Out--------------------------------------------
    on<SignOutEvent>((event, emit) async {
      final signOut = serviceLocator<SignOut>();
      emit(AuthLoading());
      try {
        await signOut.call(); // Call the sign-out method
        emit(SignOutSuccessState());

        // Clear all SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('hasSeenHome');
        await prefs.remove('uid');
        await prefs.remove('name');
        await prefs.remove('email');
        await prefs.remove('photoUrl');
        await prefs.remove('googleSignIn');
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state if sign-out fails
      }
    });

    add(CheckAuthStatusEvent());
  }
}
