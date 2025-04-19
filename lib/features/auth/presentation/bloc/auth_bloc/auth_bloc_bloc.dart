import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_out.dart';
import 'auth_bloc_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_email_password.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_up_with_email_password.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
  AuthBloc() : super(AuthInitial()) {
    //------------------------------SignInEvent---------------------------------

    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      final signIn = serviceLocator<SignInWithEmailPassword>();
      // final getCurrentUser = serviceLocator<GetCurrentUser>();
      try {
        await signIn(event.email, event.password);
        // final user = getCurrentUser(); // Fetch the current authenticated user
        await _setHasSeenHome(); // Call to save flag in SharedPreferences
        emit(const Authenticated(true));
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state
      }
    });

    //------------------------------SignUpEvent---------------------------------
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      final signUp = serviceLocator<SignUpWithEmailPassword>();
      try {
        // Call the sign-up method
        await signUp.call(event.name, event.email, event.password);
        await _setHasSeenHome(); // Call to save flag in SharedPreferences
        emit(const Authenticated(true)); // Emit Authenticated state with User

      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state
      }
    });

    //----------------------Sign-In-Google-Event--------------------------------
    on<GoogleSignInEvent>((event, emit) async {
      final googleSignIn = serviceLocator<SignInWithGoogle>();
      emit(AuthLoading());
      try {
        final user = await googleSignIn.call(); // Call the sign-in method
        log(user.toString());
        if (user != null) {
          emit(const Authenticated(true)); // Emit Authenticated state
          await _setHasSeenHome(); // Call to save flag in SharedPreferences
        } else {
          emit(const AuthError('Google sign-in failed')); // Emit error state
        }
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

        // Clear the user's session from SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('hasSeenHome'); // Optionally, remove the home flag
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state if sign-out fails
      }
    });
  }

  // Helper function to set hasSeenHome flag in SharedPreferences
  Future<void> _setHasSeenHome() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenHome', true); // Save the flag
  }
}
