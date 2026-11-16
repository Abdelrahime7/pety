import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies_injection/di.dart';

class NotificationSettingsNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final authUser = ref.read(authenticationServiceProvider).getCurrentUser();

    if (authUser == null) {
      throw StateError('User not authenticated');
    }

    final result = await ref.read(userServiceProvider).getUser(authUser.uid);

    switch (result) {
      case Success(:final data):
        return data.appointmentNotificationsEnabled;

      case Failure(:final message):
        throw StateError(message);

      case Cancelled():
        throw StateError('Loading notification settings cancelled');
    }
  }

  Future<void> setAppointmentNotifications({
    required String userId,
    required bool enabled,
  }) async {
    final previousValue = state.value ?? false;
    state = const AsyncLoading();

    final userService = ref.read(userServiceProvider);
    final notificationService = ref.read(notificationServiceProvider);

    if (enabled) {
      // 1. Register the FCM token.
      final notificationResult = await notificationService.enableNotifications(
        userId,
      );

      if (notificationResult is! Success<void>) {
        state = AsyncData(previousValue);
        if (notificationResult is Failure<void>) {
          state = AsyncError(notificationResult.message, StackTrace.current);
        }
        return;
      }

      // 2. Save the preference only after enabling succeeds.
      final preferenceResult = await userService.updateAppointmentNotifications(
        userId: userId,
        enabled: true,
      );

     if (preferenceResult is Success<void>) {
  state = const AsyncData(true);
  return;
}

// Preference update failed: clean up the registered FCM token.
final cleanupResult = await notificationService.disableNotifications(
  userId,
);

if (preferenceResult is Failure<void>) {
  var message = preferenceResult.message;

  if (cleanupResult is Failure<void>) {
    message = '$message. Token cleanup also failed: ${cleanupResult.message}';
  }

  state = AsyncError(message, StackTrace.current);
} else {
  state = AsyncData(previousValue);
}
    } else {
      // 1. Disable the preference first, preventing scheduled pushes.
      final preferenceResult = await userService.updateAppointmentNotifications(
        userId: userId,
        enabled: false,
      );

      if (preferenceResult is! Success<void>) {
        if (preferenceResult is Failure<void>) {
          state = AsyncError(preferenceResult.message, StackTrace.current);
        } else {
          state = AsyncData(previousValue);
        }
        return;
      }

      // 2. Remove the FCM token.
      final notificationResult = await notificationService.disableNotifications(
        userId,
      );

      if (notificationResult is Success<void>) {
        state = const AsyncData(false);
      } else if (notificationResult is Failure<void>) {
        state = AsyncError(notificationResult.message, StackTrace.current);
      } else {
        state = const AsyncData(false);
      }
    }
  }
}
