
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/core/services/notification/notification_service.dart';
import 'package:pet_care/features/notifications/domain/entities/notification.dart';

class NotificationNotifier
    extends AsyncNotifier<List<Notification>> {
  NotificationService get _service =>
      ref.read(notificationServiceProvider);

  String? get _userId =>
      ref.read(authenticationServiceProvider).getCurrentUser()?.uid;

  @override
  Future<List<Notification>> build() async {
    final userId = _userId;

    if (userId == null) {
      return [];
    }

    final result = await _service.getNotifications(userId);

    return switch (result) {
      Success(data: final notifications) => notifications,
      Failure(message: final message) => throw Exception(message),
      _ => [],
    };
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final userId = _userId;

      if (userId == null) {
        return [];
      }

      final result = await _service.getNotifications(userId);

      return switch (result) {
        Success(data: final notifications) => notifications,
        Failure(message: final message) => throw Exception(message),
        _ => [],
      };
    });
  }

  Future<void> markAsRead(String notificationId) async {
    final result = await _service.markAsRead(notificationId);

    if (result is Failure) {
      return;
    }

    final currentNotifications = state.valueOrNull;

    if (currentNotifications == null) {
      return;
    }

    state = AsyncData(
      currentNotifications.map((notification) {
        if (notification.id == notificationId) {
          return Notification(
            id: notification.id,
            userId: notification.userId,
            title: notification.title,
            body: notification.body,
            type: notification.type,
            isRead: true,
            createdAt: notification.createdAt,
            data: notification.data,
          );
        }

        return notification;
      }).toList(),
    );
  }
}