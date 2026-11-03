import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';

extension ThemeX on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
  AppStyle get style => AppStyle(
        Theme.of(this).colorScheme,
        arabic: Localizations.localeOf(this).languageCode == 'ar',
      );
}