import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/auth_user.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_email_password.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_up_with_email_password.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_state.dart';
import 'auth_bloc_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
  final SignInWithEmailPassword signInWithEmailPassword;
  final SignUpWithEmailPassword signUpWithEmailPassword;
  final SignInWithGoogle googleSignIn;
  final GetCurrentUser getCurrentUser;

  AuthBloc({
    required this.signInWithEmailPassword,
    required this.signUpWithEmailPassword,
    required this.googleSignIn,
    required this.getCurrentUser,
  }) : super(AuthInitial()) {
    // Handle SignInEvent
    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await signInWithEmailPassword(event.email, event.password);
        emit(Authenticated(User as User));
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state
      }
    });

    // Handle SignUpEvent
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        // Call the sign-up method
        await signUpWithEmailPassword(event.email, event.password);

        // Fetch the current authenticated user
        final user = getCurrentUser();

        if (user != null) {
          emit(Authenticated(user)); // Emit Authenticated state with User
        } else {
          emit(const AuthError('Sign up failed. Please try again.'));
        }
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state
      }
    });

    // Handle GoogleSignInEvent
    on<GoogleSignInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await googleSignIn(); // Call the sign-in method
        if (user != null) {
          emit(Authenticated(user)); // Emit Authenticated state
        } else {
          emit(const AuthError('Google sign-in failed')); // Emit error state
        }
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state
      }
    });

    // Handle SignOutEvent
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
