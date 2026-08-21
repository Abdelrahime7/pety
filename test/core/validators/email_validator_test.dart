import 'package:flutter_test/flutter_test.dart';
import 'package:pet_care/features/authentication/presentation/validators/email_validator.dart';

void main() {
  group('validateEmail', () {
    test('returns error when email is null', () {
      expect(
        validateEmail(null),
        'Email is required',
      );
    });

    test('returns error when email is empty', () {
      expect(
        validateEmail(''),
        'Email is required',
      );
    });

    test('returns error when email contains only spaces', () {
      expect(
        validateEmail('   '),
        'Email is required',
      );
    });

    test('returns error for invalid email', () {
      expect(
        validateEmail('abc'),
        'Enter a valid email address',
      );
    });

    test('returns error when @ is missing', () {
      expect(
        validateEmail('testgmail.com'),
        'Enter a valid email address',
      );
    });

    test('returns error when domain is missing', () {
      expect(
        validateEmail('test@'),
        'Enter a valid email address',
      );
    });

    test('returns null for valid email', () {
      expect(
        validateEmail('test@gmail.com'),
        isNull,
      );
    });

    test('returns null for valid email with dot', () {
      expect(
        validateEmail('john.doe@gmail.com'),
        isNull,
      );
    });


    test('trims whitespace before validation', () {
      expect(
        validateEmail('  test@gmail.com  '),
        isNull,
      );
    });
  });
}