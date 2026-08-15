 
 sealed class ErrorFailure {
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

class ServerFailure extends ErrorFailure {
  const ServerFailure()
      : super('Something went wrong on the server.');
}


class UserNotFoundFailure extends ErrorFailure {
  const UserNotFoundFailure()
      : super('User Not Found.');
}
class InvalidCredentialsFailure extends ErrorFailure {
  const InvalidCredentialsFailure()
      : super('Invalid email or password.');
}

class EmailAlreadyInUseFailure extends ErrorFailure {
  const EmailAlreadyInUseFailure()
      : super('This email is already in use.');
}

class WeakPasswordFailure extends ErrorFailure {
  const WeakPasswordFailure()
      : super('The password is too weak.');
}


class UnknownAuthFailure extends ErrorFailure {
  const UnknownAuthFailure()
      : super('An unexpected authentication error occurred.');
}
