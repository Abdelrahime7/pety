import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/notifications/presentation/riverpod/notification_provider.dart';
import 'package:pet_care/features/notifications/presentation/widgets/notification_setting_tile.dart';
import 'package:pet_care/features/users/domain/entity/user.dart';

class NotificationSettingsScreen extends ConsumerWidget {
  final User user;

  const NotificationSettingsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(notificationSettingsProvider);

    ref.listen<AsyncValue<bool>>(notificationSettingsProvider, (
      previous,
      next,
    ) {
      next.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });

    final isEnabled = settingsState.value ?? false;
    final isLoading = settingsState.isLoading;

    return Scaffold(
      backgroundColor: context.colors.surface,
      appBar: AppBar(
        backgroundColor: context.colors.surface,
        elevation: 0,
        title: Text('Notification Settings', style: context.style.headerName),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Notifications',
            style: context.style.subtitle.copyWith(
              color: context.colors.onSurface,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Choose which notifications you want to receive '
            'about your pets.',
            style: context.style.regular14.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 24),

          NotificationSettingTile(
            icon: Icons.calendar_month_outlined,
            title: 'Appointment reminders',
            subtitle: 'Get notified about your pet\'s upcoming appointments.',
            value: isEnabled,
            onChanged: isLoading
                ? null
                : (value) async {
                    await ref
                        .read(notificationSettingsProvider.notifier)
                        .setAppointmentNotifications(
                          userId: user.userId,
                          enabled: value,
                        );
                  },
          ),
        ],
      ),
    );
  }
}
