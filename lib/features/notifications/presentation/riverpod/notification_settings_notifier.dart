import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';


class NotificationSettingsNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    return false;
  }

  Future<void> setAppointmentNotifications({
    required String userId,
    required bool enabled,
  }) async {
    state = const AsyncLoading();

    final service = ref.read(notificationServiceProvider);

    final Result<void> result;

    if (enabled) {
      result = await service.enableNotifications(userId);
    } else {
      result = await service.disableNotifications(userId);
    }

    if (result is Success<void>) {
      state = AsyncData(enabled);
    } else if (result is Failure<void>) {
      state = AsyncError(
        result.message,
        StackTrace.current,
      );
    } else if (result is Cancelled<void>) {
      state = AsyncData(state.value ?? false);
    }
  }
}