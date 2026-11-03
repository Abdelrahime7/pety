import 'package:flutter/widgets.dart';
import 'package:pet_care/core/constant/l10n/app_localizations.dart';

extension L10nX on BuildContext {
  /// Translations: `context.l10n.darkMode`
  AppLocalizations get l10n {
    return AppLocalizations.of(this)!;
  }

  /// True when the app is displayed right-to-left (Arabic).
  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  /// Letter spacing that is switched off in Arabic, because spacing
  /// breaks the joined Arabic letters.
  double tracking(double value) => isRtl ? 0 : value;
}