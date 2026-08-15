import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core%20/constant/routers/app_routers.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:pet_care/core%20/constant/theme/app_theme.dart';
import 'package:pet_care/infrastructure/firebase/cloud_messaging/message_notification.dart';
import 'infrastructure/firebase/configue/firebase_options.dart';




void main()async {

   
   WidgetsFlutterBinding.ensureInitialized();

 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupNotifications();
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(

          title: 'PetCare+',
          routerConfig: appRouter,
          theme: AppTheme.light,
        );
      },
      
    ),
  );
}
