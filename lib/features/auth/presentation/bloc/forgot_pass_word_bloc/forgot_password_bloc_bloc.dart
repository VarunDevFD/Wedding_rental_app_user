import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vr_wedding_rental/core/error/failure.dart';
import 'package:vr_wedding_rental/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/forgot_pass_word_bloc/forgot_password_bloc_event.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/forgot_pass_word_bloc/forgot_password_bloc_state.dart';

/// Manages the forget password process and its states.
class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final FirebaseAuth _firebaseAuth;

  // Initialize FirebaseAuth in the constructor
  ForgetPasswordBloc()
      : _firebaseAuth = FirebaseAuth.instance,
        super(ForgetPasswordInitial()) {
    // Listen for events
    on<ForgetPasswordEvent>(_onForgetPassword);
  }

  /// Handles the ForgetPasswordEvent and emits states based on the result.
  void _onForgetPassword(
    ForgetPasswordEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    // Emit loading state when the process starts
    emit(ForgetPasswordLoadingState());

    try {
      // Send the password reset email using Firebase Auth
      await _firebaseAuth.sendPasswordResetEmail(email: event.email);

      // Emit success state when the password reset email is successfully sent
      emit(ForgetPasswordSuccessState());
    } on FirebaseAuthException catch (e) {
      // Convert FirebaseAuthException to Failure
      final failure =
          Failure(message: e.message ?? 'An unknown error occurred');

      // Emit failure state with the converted Failure object
      emit(ForgetPasswordFailState(error: failure));
    } catch (e) {
      // Handle any other unknown exceptions by converting them into a Failure
      const failure =
          Failure(message: 'An unknown error occurred. Please try again.');

      // Emit fail state for unknown errors
      emit(ForgetPasswordFailState(error: failure));
    }
  }

  /// Handles the forget password process.
  // void _onForgetPassword(
  //   ForgetPasswordEvent event,
  //   Emitter<ForgetPasswordState> emit,
  // ) async {
  //   emit(ForgetPasswordLoadingState());

  //   // Get the ForgetPasswordUseCase from the GetIt.instance
  //   ForgetPasswordUseCase forgetPasswordUseCase =
  //       GetIt.instance<ForgetPasswordUseCase>();
  //   final result =
  //       await forgetPasswordUseCase.resetPassword(email: event.email.trim());

  // result.fold(
  //   (failure) {
  //     // Handle failure case and emit the corresponding error message
  //     emit(ForgetPasswordFailState(error: failure));
  //   },
  //   (_) {
  //     // Handle success case
  //     emit(ForgetPasswordSuccessState());
  //   },
  // );
  // }
}
