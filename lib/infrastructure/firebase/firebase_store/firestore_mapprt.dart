import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/core/errors/authfailure.dart';
import 'package:pet_care/core/errors/common_faillure.dart';
import 'package:pet_care/core/errors/firstore_faillure.dart';

ErrorFailure mapFirestoreExceptionToFailure(
  FirebaseException exception,
) {
  switch (exception.code) {
    case 'permission-denied':
      return const PermissionDeniedFailure();

    case 'unauthenticated':
      return const UnauthorizedFailure();

    case 'not-found':
      return const UserNotFoundFailure();

    case 'unavailable':
      return const NetworkFailure();

    case 'resource-exhausted':
      return const TooManyRequestsFailure();

    case 'internal':
    case 'aborted':
    case 'deadline-exceeded':
      return const ServerFailure();

    default:
      return const UnknownFailure();
  }
}