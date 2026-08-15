

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/authentication/presentation/riverpod/auth_notifier.dart';
import 'package:pet_care/features/authentication/presentation/riverpod/auth_stat.dart';

final authProvider = NotifierProvider<AuthNotifier,AuthStat> (
AuthNotifier.new
);