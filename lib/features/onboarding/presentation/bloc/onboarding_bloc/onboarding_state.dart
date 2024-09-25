// import 'package:equatable/equatable.dart';

// abstract class OnboardingState extends Equatable {
//   const OnboardingState();
// }

// class OnboardingInitial extends OnboardingState {
//   @override
//   List<Object> get props => [];
// }

// class OnboardingLoaded extends OnboardingState {
//   final List<String> pages;

//   const OnboardingLoaded({required this.pages});

//   @override
//   List<Object> get props => [pages];
// }


import 'package:equatable/equatable.dart';
import '../../../domain/entities/d_onboarding_page.dart';

// Defining the states
abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

// Initial state
class OnboardingInitial extends OnboardingState {}

// Loading state
class OnboardingLoading extends OnboardingState {}

// Loaded state with the onboarding pages
class OnboardingLoaded extends OnboardingState {
  final List<OnboardingPage> pages;

  const OnboardingLoaded(this.pages);

  @override
  List<Object?> get props => [pages];
}

// Error state
class OnboardingError extends OnboardingState {
  final String message;

  const OnboardingError(this.message);

  @override
  List<Object?> get props => [message];
}
