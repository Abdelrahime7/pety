import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/notifications/domain/entities/notification.dart';
import 'package:pet_care/features/notifications/presentation/riverpod/notificaton_notifier.dart';



final notificationProvider =
    AsyncNotifierProvider<NotificationNotifier, List<Notification>>(
  NotificationNotifier.new,
);
