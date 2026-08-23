 class ErrorFailure {
  final String message;

  const ErrorFailure(this.message);
}

class NetworkFailure extends ErrorFailure {
  const NetworkFailure()
      : super('Please check your internet connection.');
}

class UnauthorizedFailure extends ErrorFailure {
  const UnauthorizedFailure()
      : super('You are not authorized.');
}

class TooManyRequestsFailure extends ErrorFailure {
  const TooManyRequestsFailure()
      : super('Too many attempts. Please try again later.');
}

class ServerFailure extends ErrorFailure {
  const ServerFailure()
      : super('Something went wrong on the server.');
}

class UnknownFailure extends ErrorFailure {
  const UnknownFailure()
      : super('Something went wrong.');
}