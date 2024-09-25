import 'package:equatable/equatable.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object> get props => [];
}

class NavigateToSignIn extends WelcomeEvent {}

class NavigateToSignUp extends WelcomeEvent {}
