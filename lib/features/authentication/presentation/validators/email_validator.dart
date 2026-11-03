import 'package:pet_care/core/constant/l10n/app_localizations.dart';

final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

String? validateEmail(AppLocalizations l10n, String? value) {
  if (value == null || value.trim().isEmpty) {
    return l10n.emailRequired;
  }

  if (!emailRegex.hasMatch(value.trim())) {
    return l10n.emailInvalid;
  }

  return null;
}