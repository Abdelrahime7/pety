import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/notifications/presentation/riverpod/notification_provider.dart';
import 'package:pet_care/features/notifications/presentation/widgets/notification_setting_tile.dart';
import 'package:pet_care/features/users/domain/entity/user.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
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
        title: Text(context.l10n.notificationSettings, style: context.style.headerName),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            context.l10n.notifications,
            style: context.style.subtitle.copyWith(
              color: context.colors.onSurface,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            context.l10n.chooseNotifications,
            style: context.style.regular14.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 24),

          NotificationSettingTile(
            icon: Icons.calendar_month_outlined,
            title: context.l10n.appointmentReminders,
            subtitle: context.l10n.appointmentRemindersDesc,
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