import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pet_care/core/constant/theme/app_theme.dart';
import 'package:pet_care/infrastructure/firebase/cloud_messaging/message_notification.dart';
import 'infrastructure/firebase/configue/firebase_options.dart';




void main()
async {
   WidgetsFlutterBinding.ensureInitialized();

 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  

  await GoogleSignIn.instance.initialize(
    serverClientId:
        '721972208500-qgkmhmklka2k2ul6rdg38i8ru4cuqpit.apps.googleusercontent.com',
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupNotifications();
  runApp(
    ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return ProviderScope(
          child: MaterialApp.router(
          
            title: 'PetCare',
            routerConfig: appRouter,
            theme: AppTheme.light,
  
        )
        );
      },
    ),
  );
}