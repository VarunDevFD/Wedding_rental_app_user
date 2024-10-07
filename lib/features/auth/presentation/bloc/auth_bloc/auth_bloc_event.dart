import 'package:vr_wedding_rental/features/auth/domain/entities/user_entity.dart';

abstract class AuthEvent {}

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
  final AuthUser? user;
  final bool isLoading;
  final String? errorMessage;

  AuthEventState({this.user, this.isLoading = false, this.errorMessage});
}
