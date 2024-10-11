import 'auth_bloc_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/auth_user.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_in_with_email_password.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/sign_up_with_email_password.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
  final SignInWithGoogle googleSignIn;

  AuthBloc({required this.googleSignIn}) : super(AuthInitial()) {
    //------------------------------SignInEvent---------------------------------

    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      final signIn = serviceLocator<SignInWithEmailPassword>();
      final getCurrentUser = serviceLocator<GetCurrentUser>();
      try {
        await signIn(event.email, event.password);
        final user = getCurrentUser(); // Fetch the current authenticated user
        emit(Authenticated(user!));
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state
      }
    });

    //------------------------------SignUpEvent---------------------------------
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      final signUp = serviceLocator<SignUpWithEmailPassword>();
      final getCurrentUser = serviceLocator<GetCurrentUser>();
      try {
        // Call the sign-up method
        await signUp(event.email, event.password);

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

    //----------------------GoogleSignInEvent-----------------------------------
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
