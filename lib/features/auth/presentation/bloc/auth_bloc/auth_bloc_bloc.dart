import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';

import 'auth_bloc_event.dart';
import 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc({required this.repository}) : super(AuthInitial()) {
    // Google Sign In
    on<SignInGoogleEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await repository.signInWithGoogle();
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(AuthUnAuthenticated());
        }
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    // Email/Password Sign In
    on<SignInEmailPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await repository.signInWithEmailAndPassword(
            event.email, event.password);
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(AuthUnAuthenticated());
        }
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    // Email/Password Sign Up
    on<SignUpEmailPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await repository.signUpWithEmailAndPassword(
            event.email, event.password);
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(AuthUnAuthenticated());
        }
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    // // Sign Out
    // on<SignOutEvent>((event, emit) async {
    //   emit(AuthLoading());
    //   try {
    //     await repository.signOut();
    //     emit(AuthUnAuthenticated());
    //   } catch (e) {
    //     emit(AuthError(message: e.toString()));
    //   }
    // });
  }
}


