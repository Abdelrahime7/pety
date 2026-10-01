import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';

final unreadNotificationCountProvider =
    FutureProvider<int>((ref) async {
  final userId =
      ref.read(authenticationServiceProvider).getCurrentUser()?.uid;

  if (userId == null) {
    return 0;
  }

  final result = await ref
      .read(notificationServiceProvider)
      .getUnreadCount(userId);

  return switch (result) {
    Success(data: final count) => count,
    Failure() => 0,
    _ => 0,
  };
});