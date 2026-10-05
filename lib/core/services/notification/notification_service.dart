import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/features/notifications/domain/entities/notification.dart';
import 'package:pet_care/features/notifications/domain/enums/notification_type.dart';
import 'package:pet_care/infrastructure/firebase/data_source/notification/firebase_notification_data_source.dart';
import 'package:device_info_plus/device_info_plus.dart';

class NotificationService {
  final NotificationDataSource _dataSource;

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();


      StreamSubscription<RemoteMessage>? _onMessageSubscription;

  NotificationService(this._dataSource);

  // --------------------------------------------------
  // Firestore notifications
  // --------------------------------------------------

  Future<Result<List<Notification>>> getNotifications(
    String userId,
  ) async {
    try {
      final data = await _dataSource.getNotifications(userId);

      final notifications = data.map(_fromMap).toList();

      return Success(notifications);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<Result<int>> getUnreadCount(String userId) async {
    try {
      final count = await _dataSource.getUnreadCount(userId);

      return Success(count);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<Result<void>> markAsRead(String notificationId) async {
    try {
      await _dataSource.markAsRead(notificationId);

      return const Success(null);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  // --------------------------------------------------
  // FCM token
  // --------------------------------------------------

  Future<Result<void>> saveFcmToken(
    String userId,
    String token,
  ) async {
    try {
      await _dataSource.saveFcmToken(userId, token);

      return const Success(null);
    } catch (e) {
      return Failure(e.toString());
    }
  }

 Future<Result<void>> deleteFcmToken (
    String userId,
    String token,
  ) async {
    try {
      await _dataSource.deleteFcmToken(userId, token);

      return const Success(null);
    } catch (e) {
      return Failure(e.toString());
    }
  }




  // --------------------------------------------------
  // enable Notificatio
  // --------------------------------------------------

Future<Result<void>> enableNotifications(String userId) async {
  try {
    final messaging = FirebaseMessaging.instance;

    // Android 13+ requires runtime notification permission.
    final androidInfo = await DeviceInfoPlugin().androidInfo;

    if (androidInfo.version.sdkInt >= 33) {
      final settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus !=
          AuthorizationStatus.authorized) {
        return Failure(
          'Notification permission was not granted.',
        );
      }
    }

    // Android 12 and below don't need runtime
    // notification permission.
    final token = await messaging.getToken();

    if (token == null) {
      return Failure('Could not get FCM token.');
    }

    await saveFcmToken(userId, token);

    await _initializeLocalNotifications();
    await _setupForegroundNotifications();

    return const Success(null);
  } catch (e) {
    return Failure(e.toString());
  }
}


  // --------------------------------------------------
  // Mapping
  // --------------------------------------------------

  Notification _fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map['id'] as String?,
      userId: map['userId'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
      type: NotificationType.values.firstWhere(
        (type) => type.name == map['type'],
        orElse: () => NotificationType.system,
      ),
      isRead: map['isRead'] as bool? ?? false,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      data: map['data'] != null
          ? Map<String, dynamic>.from(map['data'])
          : null,
    );
  }

   // --------------------------------------------------
  // disable Notificatio
  // --------------------------------------------------

Future<Result<void>> disableNotifications(String userId) async {
  try {
    final messaging = FirebaseMessaging.instance;

    final token = await messaging.getToken();

    if (token != null) {
      await deleteFcmToken(userId, token);
    }

    return const Success(null);
  } catch (e) {
    return Failure(e.toString());
  }
}

  // --------------------------------------------------
  // Foreground notifications
  // --------------------------------------------------

 Future<void> _setupForegroundNotifications() async {
  await _onMessageSubscription?.cancel();

  _onMessageSubscription = FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) async {
      final notification = message.notification;

      if (notification == null) {
        return;
      }

      await _localNotifications.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'pety_notifications',
            'Pety Notifications',
            channelDescription: 'Notifications from Pety',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
      );
    },
  );
}

  // --------------------------------------------------
  // Local notification initialization
  // --------------------------------------------------

  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings = InitializationSettings(
      android: androidSettings,
    );

    await _localNotifications.initialize(
      settings: settings,
    );

    const channel = AndroidNotificationChannel(
      'pety_notifications',
      'Pety Notifications',
      description: 'Notifications from Pety',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
}