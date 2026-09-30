import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/features/notifications/domain/entities/notification.dart';
import 'package:pet_care/features/notifications/domain/enums/notification_type.dart';
import 'package:pet_care/infrastructure/firebase/data_source/notification/firebase_notification_data_source.dart';

class NotificationService {
  final NotificationDataSource _dataSource;
  final FlutterLocalNotificationsPlugin _localNotifications =
    FlutterLocalNotificationsPlugin();

  NotificationService(this._dataSource);

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
Future<Result<void>> setupNotifications(String userId) async {
  try {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint(
      'Notification permission: ${settings.authorizationStatus}',
    );

    // FCM registration
    final token = await messaging.getToken();

    debugPrint('🔥 FCM TOKEN: $token');

    if (token != null) {
      await saveFcmToken(userId, token);
    }

    // Only configure notification display if permission is granted
    if (settings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      await _initializeLocalNotifications();
      await _setupForegroundNotifications();
    }

    messaging.onTokenRefresh.listen((token) async {
      debugPrint('🔥 FCM TOKEN REFRESHED: $token');
      await saveFcmToken(userId, token);
    });

    return const Success(null);
  } catch (e) {
    debugPrint('Notification setup error: $e');
    return Failure(e.toString());
  }
}

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



Future<void> _setupForegroundNotifications() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    final notification = message.notification;

    if (notification == null) return;

    print('Foreground notification: ${notification.title}');
    print('Body: ${notification.body}');

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
  });
}

Future<void> _initializeLocalNotifications() async {
  const androidSettings = AndroidInitializationSettings(
    '@mipmap/ic_launcher',
  );

  const settings = InitializationSettings(
    android: androidSettings,
  );

  await _localNotifications.initialize(settings: settings);
}
}