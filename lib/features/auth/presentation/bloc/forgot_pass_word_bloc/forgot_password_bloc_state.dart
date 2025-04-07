import 'package:vr_wedding_rental/core/error/failure.dart';

sealed class ForgetPasswordState {
  const ForgetPasswordState();
}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoadingState extends ForgetPasswordState {}

final class ForgetPasswordSuccessState extends ForgetPasswordState {}

final class ForgetPasswordFailState extends ForgetPasswordState {
  final Failure error;
  ForgetPasswordFailState({
    required this.error,
  });
}