

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/authentication/data%20/user_data.dart';
import 'package:pet_care/features/authentication/presentation/riverpod/auth_notifier.dart';

final authProvider = AsyncNotifierProvider<AuthNotifier,UserResponse?> (
AuthNotifier.new
);