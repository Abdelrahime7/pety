import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pet_care/core/constant/l10n/app_localizations.dart';
import 'package:pet_care/core/constant/l10n/provider.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';
import 'package:pet_care/core/constant/theme/app_theme.dart';
import 'package:pet_care/core/constant/theme/theme_prvider.dart';
import 'package:pet_care/infrastructure/firebase/cloud_messaging/message_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'infrastructure/firebase/configue/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await GoogleSignIn.instance.initialize(
    serverClientId:
        '721972208500-qgkmhmklka2k2ul6rdg38i8ru4cuqpit.apps.googleusercontent.com',
  );

  await setupNotifications();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider); // null = follow the phone

    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
          routerConfig: appRouter,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeMode,
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}