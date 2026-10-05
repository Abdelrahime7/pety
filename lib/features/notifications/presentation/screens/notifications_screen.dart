import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/notifications/presentation/riverpod/notification_provider.dart';
import 'package:pet_care/features/notifications/presentation/widgets/notification_card.dart';
import 'package:pet_care/features/notifications/presentation/widgets/notification_empty_state.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          notificationsAsync.when(
            data: (notifications) {
              final hasUnread =
                  notifications.any((notification) => !notification.isRead);

              if (!hasUnread) {
                return const SizedBox.shrink();
              }

              return TextButton(
                onPressed: () async {
                  for (final notification in notifications) {
                    if (!notification.isRead &&
                        notification.id != null) {
                      await ref
                          .read(notificationProvider.notifier)
                          .markAsRead(notification.id!);
                    }
                  }
                },
                child: const Text('Mark all read'),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: () {
          return ref
              .read(notificationProvider.notifier)
              .refresh();
        },
        child: notificationsAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),

          error: (error, _) => Center(
            child: Padding(
              
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                   Text(
                      error.toString(),
                  ),
            
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      ref.invalidate(notificationProvider);
                    },
                    child: const Text('Try again'),
                  ),
                ],
              ),
            ),
          ),

          data: (notifications) {
            if (notifications.isEmpty) {
              return const NotificationEmptyState();
            }

            return ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final notification = notifications[index];

                return NotificationCard(
                  notification: notification,
                  onTap: () async {
                    if (!notification.isRead &&
                        notification.id != null) {
                      await ref
                          .read(notificationProvider.notifier)
                          .markAsRead(notification.id!);
                    }

                    // Later:
                    // Navigate based on notification.data
                    //
                    // appointmentId
                    // petId
                    // appointmentType
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}