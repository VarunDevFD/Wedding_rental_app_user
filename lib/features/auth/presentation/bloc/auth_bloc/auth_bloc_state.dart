import 'package:vr_wedding_rental/features/auth/domain/entities/user_entity.dart';

abstract class AuthBlocState {}

class AuthInitial extends AuthBlocState {}

class AuthLoading extends AuthBlocState {}

class Authenticated extends AuthBlocState {
  final AuthUser user;

  Authenticated(this.user);
}

class AuthError extends AuthBlocState {
  final String message;

  AuthError(this.message);
}

class Unauthenticated extends AuthBlocState {}
