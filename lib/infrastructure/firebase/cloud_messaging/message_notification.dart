import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> setupNotifications() async {
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  print('Notification permission: ${settings.authorizationStatus}');
}