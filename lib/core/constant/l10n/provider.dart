import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/theme/theme_prvider.dart';

/// Selected app language. `null` means "follow the phone's language".
final localeProvider =
    NotifierProvider<LocaleNotifier, Locale?>(LocaleNotifier.new);

class LocaleNotifier extends Notifier<Locale?> {
  static const _key = 'locale';

  @override
  Locale? build() {
    final code = ref.read(sharedPrefsProvider).getString(_key);
    return code == null ? null : Locale(code);
  }

  void setLocale(Locale? locale) {
    state = locale;
    final prefs = ref.read(sharedPrefsProvider);
    if (locale == null) {
      prefs.remove(_key);
    } else {
      prefs.setString(_key, locale.languageCode);
    }
  }
}