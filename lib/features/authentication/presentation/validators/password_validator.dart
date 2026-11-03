import 'package:pet_care/core/constant/l10n/app_localizations.dart';

String? validatePassword(AppLocalizations l10n, String? value) {
  if (value == null || value.isEmpty) {
    return l10n.passwordRequired;
  }

  if (value.length < 8) {
    return l10n.passwordTooShort;
  }

  return null;
}