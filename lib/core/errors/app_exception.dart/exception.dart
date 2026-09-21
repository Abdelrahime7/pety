
class AppException implements Exception {
  final String message;

  const AppException(this.message);
}

class NetworkException extends AppException {
  const NetworkException()
      : super('Network error occurred');
}

class UnauthorizedException extends AppException {
  const UnauthorizedException()
      : super('Unauthorized');
}

class ServerException extends AppException {
  const ServerException()
      : super('Server error occurred');
}

