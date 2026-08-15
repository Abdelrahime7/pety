
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_care/core/errors/failure.dart';

ErrorFailure mapFirebaseExceptionToFailure(FirebaseAuthException e) {
  switch (e.code) {
    case 'user-not-found':
      return const UserNotFoundFailure();

    case 'wrong-password':
      return const InvalidCredentialsFailure();

    case 'email-already-in-use':
      return const EmailAlreadyInUseFailure();

    case 'weak-password':
      return const WeakPasswordFailure();

    case 'network-request-failed':
      return const NetworkFailure();

    default:
      return const UnknownAuthFailure();
  }
}