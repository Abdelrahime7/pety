 
 sealed class ErrorFailure {
  final String message;

  const ErrorFailure(this.message);
}



class TooManyRequestsFailure extends ErrorFailure {
  const TooManyRequestsFailure()
      : super('Too many attempts. Please try again later');
}

class InvalidEmailFailure extends ErrorFailure {
  const InvalidEmailFailure()
      : super('The email address is invalid');
}

class UserDisabledFailure extends ErrorFailure {
  const UserDisabledFailure()
      : super('This account has been disabled');
}

 class RequireLoginAgain extends ErrorFailure
 {
  const RequireLoginAgain():super('Please log in again to continue');
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
      : super('No account found with this email');
}
class InvalidCredentialsFailure extends ErrorFailure {
  const InvalidCredentialsFailure()
      : super('Invalid email or password.');
}

class EmailAlreadyInUseFailure extends ErrorFailure {
  const EmailAlreadyInUseFailure()
      : super('An account already exists with this email');
}

class WeakPasswordFailure extends ErrorFailure {
  const WeakPasswordFailure()
      : super('The password is too weak.');
}


class UnknownAuthFailure extends ErrorFailure {
  const UnknownAuthFailure()
      : super('An unexpected authentication error occurred.');
}

