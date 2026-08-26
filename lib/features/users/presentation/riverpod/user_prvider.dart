

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/users/domain/enitiy/user.dart';
import 'package:pet_care/features/users/presentation/riverpod/user_notifier.dart';

final userProvider = AsyncNotifierProvider<UserNotifier,User>(
  UserNotifier.new
);