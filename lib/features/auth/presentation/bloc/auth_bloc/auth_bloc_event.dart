import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';


// Base class for all auth events, extending Equatable
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent({required this.email, required this.password});
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;

  SignUpEvent({required this.email, required this.password});
}

class GoogleSignInEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}

class AuthEventState {
  final User? user;
  final bool isLoading;
  final String? errorMessage;

  AuthEventState({this.user, this.isLoading = false, this.errorMessage});
}
