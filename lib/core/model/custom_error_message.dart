// Define Failure class and specific types of failures

class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

class InvalidCredentialsFailure extends Failure {
  InvalidCredentialsFailure(super.message);
}

class UnknownFailure extends Failure {
  UnknownFailure(super.message);
}
