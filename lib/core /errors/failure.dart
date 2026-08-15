 
 sealed class Failure {
  final String message;

  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure()
      : super('Please check your internet connection.');
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure()
      : super('You are not authorized.');
}

class ServerFailure extends Failure {
  const ServerFailure()
      : super('Something went wrong on the server.');
}