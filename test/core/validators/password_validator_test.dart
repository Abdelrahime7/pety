
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_care/features/authentication/presentation/validators/password_validator.dart';

void main() {
  group('validatePassword', () {
    test('returns error when password is null', () {
      expect(
        validatePassword(null),
        'Password is required',
      );
    });

    test('returns error when password is empty', () {
      expect(
        validatePassword(''),
        'Password is required',
      );
    });

    test('returns error when password has less than 8 characters', () {
      expect(
        validatePassword('1234567'),
        'Password must be at least 8 characters',
      );
    });

    test('returns null when password has exactly 8 characters', () {
      expect(
        validatePassword('12345678'),
        isNull,
      );
    });

    test('returns null when password has more than 8 characters', () {
      expect(
        validatePassword('123456789'),
        isNull,
      );
    });

    test('accepts spaces because your current validator allows them', () {
      expect(
        validatePassword('        '),
        isNull,
      );
    });
  });
}