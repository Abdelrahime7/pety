
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_care/core/constant/l10n/app_localizations_en.dart';
import 'package:pet_care/features/authentication/presentation/validators/password_validator.dart';

void main() {
    final l10n = AppLocalizationsEn();

  group('validatePassword', () {
    test('returns error when password is null', () {
      expect(
        validatePassword(l10n,null),
        'Password is required',
      );
    });

    test('returns error when password is empty', () {
      expect(
        validatePassword(l10n,''),
        'Password is required',
      );
    });

    test('returns error when password has less than 8 characters', () {
      expect(
        validatePassword(l10n,'1234567'),
        'Password must be at least 8 characters',
      );
    });

    test('returns null when password has exactly 8 characters', () {
      expect(
        validatePassword(l10n,'12345678'),
        isNull,
      );
    });

    test('returns null when password has more than 8 characters', () {
      expect(
        validatePassword(l10n,'123456789'),
        isNull,
      );
    });

    test('accepts spaces because your current validator allows them', () {
      expect(
        validatePassword(l10n,'        '),
        isNull,
      );
    });
  });
}