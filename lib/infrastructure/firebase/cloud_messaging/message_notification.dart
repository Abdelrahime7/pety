import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> setupNotifications() async {
  final messaging = FirebaseMessaging.instance;

   await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

}
