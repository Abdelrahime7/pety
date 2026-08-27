import 'package:dio/dio.dart';
import 'package:pet_care/core/errors/authfailure.dart';
import 'package:pet_care/core/errors/common_faillure.dart';

ErrorFailure mapDioExceptionToFailure(
  DioException exception,
) {
  final statusCode = exception.response?.statusCode;

  switch (statusCode) {
    case 400:
      return const UnknownFailure();

    case 401:
    case 403:
      return const UnauthorizedFailure();

    case 404:
      return const UserNotFoundFailure();

    case 429:
      return const TooManyRequestsFailure();

    case 500:
    case 502:
    case 503:
    case 504:
      return const ServerFailure();

    default:
      switch (exception.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionError:
          return const NetworkFailure();

        default:
          return const UnknownFailure();
      }
  }
}