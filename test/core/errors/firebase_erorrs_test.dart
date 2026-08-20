import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_care/infrastructure/firebase/auth/firebase_auth_mapper.dart';

void main() {
  group('mapFirebaseExceptionToFailure', () {
    test('maps invalid-credential', () {
      final exception = FirebaseAuthException(
        code: 'invalid-credential',
      );

      final result = mapFirebaseExceptionToFailure(exception);

      expect(result.message, 'Invalid email or password.');
    });

    test('maps wrong-password', () {
      final exception = FirebaseAuthException(
        code: 'wrong-password',
      );

      final result = mapFirebaseExceptionToFailure(exception);

      expect(result.message, 'Invalid email or password.');
    });

    test('maps invalid-email', () {
      final exception = FirebaseAuthException(
        code: 'invalid-email',
      );

      final result = mapFirebaseExceptionToFailure(exception);

      expect(result.message, 'Invalid email or password.');
    });

    test('maps user-disabled', () {
      final exception = FirebaseAuthException(
        code: 'user-disabled',
      );

      final result = mapFirebaseExceptionToFailure(exception);

      expect(result.message, 'This account has been disabled');
    });

    test('maps user-not-found', () {
      final exception = FirebaseAuthException(
        code: 'No account found with this email',
      );

      final result = mapFirebaseExceptionToFailure(exception);

      expect(result.message, 'No account found with this email');
    });

    test('maps too-many-requests', () {
      final exception = FirebaseAuthException(
        code: 'too-many-requests',
      );

      final result = mapFirebaseExceptionToFailure(exception);

      expect(
        result.message,
        'Too many attempts. Please try again later',
      );
    });

    test('maps network-request-failed', () {
      final exception = FirebaseAuthException(
        code: 'network-request-failed',
      );

      final result = mapFirebaseExceptionToFailure(exception);

      expect(
        result.message,
        'Please check your internet connection.',
      );
    });


    test('maps weak-password', () {
      final exception = FirebaseAuthException(
        code: 'weak-password',
      );

      final result = mapFirebaseExceptionToFailure(exception);

      expect(
        result.message,
        'The password is too weak.',
      );
    });

    test('maps email-already-in-use', () {
      final exception = FirebaseAuthException(
        code: 'email-already-in-use',
      );

      final result = mapFirebaseExceptionToFailure(exception);

      expect(
        result.message,
        'An account already exists with this email',
      );
    });

    test('maps requires-recent-login', () {
      final exception = FirebaseAuthException(
        code: 'requires-recent-login',
      );

      final result = mapFirebaseExceptionToFailure(exception);

      expect(
        result.message,
        'Please log in again to continue',
      );
    });

    test('returns generic message for unknown error', () {
      final exception = FirebaseAuthException(
        code: 'some-unknown-code',
      );

      final result = mapFirebaseExceptionToFailure(exception);

      expect(
        result.message,
        'An unexpected authentication error occurred.',
      );
    });
  });
}