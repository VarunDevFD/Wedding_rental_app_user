import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_email_password.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_up_with_email_password.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_state.dart';

import 'auth_bloc_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
  final SignInWithEmailPassword signInWithEmailPassword;
  final SignUpWithEmailPassword signUpWithEmailPassword;
  final SignInWithGoogle googleSignIn;

  AuthBloc({
    required this.signInWithEmailPassword,
    required this.signUpWithEmailPassword,
    required this.googleSignIn,
  }) : super(AuthInitial()) {

    //------SignIn-email and password------

    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await signInWithEmailPassword(event.email, event.password);
        emit(Authenticated(user!)); // Emit Authenticated state
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state
      }
    });
    
    //------SignUP-email and password------

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await signUpWithEmailPassword(event.email, event.password);
        emit(Authenticated(user!)); // Emit Authenticated state
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state
      }
    });

    //------Google-SignIn-event------

    on<GoogleSignInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await googleSignIn(); // Call the sign-in method
        if (user != null) {
          emit(Authenticated(user)); // Emit Authenticated state
        } else {
          emit(AuthError('Google sign-in failed')); // Emit error state
        }
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state
      }
    });

    //------Sign-Out------

    // on<SignOutEvent>((event, emit) async {
    //   emit(AuthLoading());
    //   try {
    //     await googleSignIn.signOut(); // Call sign out method from use case
    //     emit(Unauthenticated()); // Emit Unauthenticated state
    //   } catch (e) {
    //     emit(AuthError(e.toString())); // Emit error state if sign-out fails
    //   }
    // });
  }
}
