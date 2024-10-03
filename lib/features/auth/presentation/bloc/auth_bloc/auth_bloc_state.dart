import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user; // or whatever type you're using for the user

  const Authenticated(this.user);
}

class AuthUnAuthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});
}
