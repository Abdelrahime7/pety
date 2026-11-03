import 'package:flutter_test/flutter_test.dart';
import 'package:pet_care/core/constant/l10n/app_localizations_ar.dart';
import 'package:pet_care/core/constant/l10n/app_localizations_en.dart';
import 'package:pet_care/features/authentication/presentation/validators/email_validator.dart';

void main() {
  final l10n = AppLocalizationsEn();

  group('validateEmail', () {
    test('returns error when email is null', () {
      expect(validateEmail(l10n, null), 'Email is required');
    });

    test('returns error when email is empty', () {
      expect(validateEmail(l10n, ''), 'Email is required');
    });

    test('returns error when email contains only spaces', () {
      expect(validateEmail(l10n, '   '), 'Email is required');
    });

    test('returns error for invalid email', () {
      expect(validateEmail(l10n, 'abc'), 'Enter a valid email address');
    });

    test('returns error when @ is missing', () {
      expect(validateEmail(l10n, 'testgmail.com'), 'Enter a valid email address');
    });

    test('returns error when domain is missing', () {
      expect(validateEmail(l10n, 'test@'), 'Enter a valid email address');
    });

    test('returns null for valid email', () {
      expect(validateEmail(l10n, 'test@gmail.com'), isNull);
    });

    test('returns null for valid email with dot', () {
      expect(validateEmail(l10n, 'john.doe@gmail.com'), isNull);
    });

    test('trims whitespace before validation', () {
      expect(validateEmail(l10n, '  test@gmail.com  '), isNull);
    });

    test('returns the Arabic message for the Arabic locale', () {
      expect(validateEmail(AppLocalizationsAr(), ''), 'البريد الإلكتروني مطلوب');
    });
  });
}