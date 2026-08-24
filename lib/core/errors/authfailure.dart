import 'package:pet_care/core/errors/common_faillure.dart';

class InvalidEmailFailure extends ErrorFailure {
  const InvalidEmailFailure()
      : super('The email address is invalid');
}

class UserNotFoundFailure extends ErrorFailure {
  const UserNotFoundFailure(): super ('No account found with this email');
}

class UserDisabledFailure extends ErrorFailure {
  const UserDisabledFailure()
      : super('This account has been disabled');
}

class RequireLoginAgain extends ErrorFailure {
  const RequireLoginAgain()
      : super('Please log in again to continue');
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